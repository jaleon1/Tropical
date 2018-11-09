<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes    
    require_once("Conexion.php");
    require_once("Usuario.php");
    require_once("ClienteFE.php");
    require_once("facturacionElectronica.php");
    require_once("Factura.php");
    require_once("Receptor.php");
    require_once("encdes.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $mensaje= new mensajeReceptor();
    switch($opt){
        case "ReadAllbyRange":
            echo json_encode($mensaje->ReadAllbyRange());
            break;
        case "ReadAllById":
            echo json_encode($mensaje->ReadAllById());
            break;
        case "Read":
            echo json_encode($mensaje->Read());
            break;
        case "Create":
            //echo json_encode($mensaje->Create());
            break;
        case "uploadxml":
            require_once("UUID.php");
            $mensaje->id= $obj["id"] ?? UUID::v4();
            $mensaje->mensaje = $_POST['mensaje'];
            $mensaje->detalle = $_POST['detalle'];
            $mensaje->uploadxml();
            break;
    }    
}

class mensajeReceptor{
    public $id=null;
    public $idEmisor=null;
    public $idReceptor=null;
    public $fechaCreacion;
    public $clave;
    public $consecutivoFE;
    public $fechaEmision;
    public $idDocumento;
    public $mensaje;
    public $detalle;
    public $totalImpuesto;
    public $totalComprobante;
    public $identificacionEmisor;
    public $identificacionReceptor;
    public $xml;

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            unset($_POST["obj"]);
            //Necesarias para la factura (Segun M Hacienda)
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->idReceptor= $_SESSION["userSession"]->idBodega;
            $this->mensaje= $obj["mensaje"];
            $this->detalle= $obj["detalle"] ?? null;
        }
    }

    function uploadxml(){
        try {
            // sube xml
            $uploaddir= '../../xmlmr/';
            if (!file_exists($uploaddir)) 
                mkdir($uploaddir, 0755, true);
            if (!empty($_FILES)) {
                foreach( $_FILES['file']['name'] as $key => $value){
                    $uploadfile = $uploaddir . $value;
                    if (move_uploaded_file($_FILES['file']['tmp_name'][$key], $uploadfile)) {
                        // lectura del xml.
                        $this->xml=simplexml_load_file($uploadfile)or die(json_encode(array(
                            'code' => '645' ,
                            'msg' => 'Error al leer archivo xml.'))
                        );
                        // guarda datos en bd. y envía MR.
                        $this->clave = (string)$this->xml->Clave;
                        $this->mensaje = $this->mensaje;
                        $this->detalle = $this->detalle ?? null;
                        $this->totalImpuesto = (string)$this->xml->MontoTotalImpuesto ?? null;
                        $this->totalComprobante = (string)$this->xml->TotalFactura;
                        // emisor del comprobante = proveedor
                        $this->idEmisor = $this->idEmisor ?? null;
                        $this->identificacionEmisor = (string)$this->xml->NumeroCedulaEmisor;
                        $this->idTipoIdentificacionEmisor = (string)$this->xml->TipoIdentificacionEmisor;
                        // receptor del comprobante = entidad registrada en el sistema.
                        $this->idReceptor = $_SESSION['userSession']->idBodega;
                        $this->identificacionReceptor = (string)$this->xml->NumeroCedulaReceptor;
                        $this->idTipoIdentificacionReceptor = (string)$this->xml->TipoIdentificacionReceptor;
                        $this->Create();
                    }
                }
            }

        }
        catch(Exception $e) {
            error_log("[ERROR]: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Read(){
        try {
            $sql='SELECT id, idDocumento, fechaCreacion, fechaEmision, consecutivo, clave, consecutivoFE, mensaje, detalle, totalImpuesto, totalComprobante, idEmisor, idTipoIdentificacionEmisor, identificacionEmisor, idReceptor, idTipoIdentificacionReceptor, identificacionReceptor, idEstadoComprobante, idSituacionComprobante
                FROM mensajeReceptor
                WHERE id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);     
            foreach ($data as $key => $value){
                $this->idDocumento = $value['idDocumento'];
                $this->fechaCreacion = $value['fechaCreacion'];
                $this->fechaEmision = $value['fechaEmision'];
                $this->consecutivo = $value['consecutivo'];
                $this->clave = $value['clave'] ?? null;
                $this->consecutivoFE = $value['consecutivoFE'] ?? null;
                $this->mensaje = $value['mensaje'];
                $this->detalle = $value['detalle'];
                $this->totalImpuesto = $value['totalImpuesto'];
                $this->totalComprobante = $value['totalComprobante'];
                $this->idEstadoComprobante = $value['idEstadoComprobante'];
                $this->idSituacionComprobante = $value['idSituacionComprobante'];
                $this->idEmisor = $value['idEmisor'];
                $this->idTipoIdentificacionEmisor = $value['idTipoIdentificacionEmisor'];
                $this->identificacionEmisor = $value['identificacionEmisor'];
                $this->idReceptor = $value['idReceptor'];
                $this->idTipoIdentificacionReceptor = $value['idTipoIdentificacionReceptor'];
                $this->identificacionReceptor = $value['identificacionReceptor'];
            }
            return $this;
        }     
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el mensaje receptor'))
            );
        }
    }

    function Create(){
        try {
            // id Documento.
            switch($this->mensaje){
                case 1:
                    $this->idDocumento = 5; // CCE.
                    break;
                case 2:
                    $this->idDocumento = 6; // CPCE.
                    break;
                case 3:
                    $this->idDocumento = 7; // RCE.
                    break;
            }
            $sql="INSERT INTO mensajeReceptor   (id, idDocumento, clave, consecutivoFE, mensaje, detalle, totalImpuesto, totalComprobante, idEmisor, idTipoIdentificacionEmisor, identificacionEmisor, idReceptor, idTipoIdentificacionReceptor, identificacionReceptor, xml)
                VALUES  (:id, :idDocumento, :clave, :consecutivoFE, :mensaje, :detalle, :totalImpuesto, :totalComprobante, :idEmisor, :idTipoIdentificacionEmisor,:identificacionEmisor, :idReceptor, :idTipoIdentificacionReceptor, :identificacionReceptor, :xml)";
            $param= array(':id'=>$this->id,
                ':idDocumento'=>$this->idDocumento,
                ':clave'=>$this->clave,
                ':consecutivoFE'=>$this->consecutivoFE,
                ':mensaje'=>$this->mensaje,
                ':detalle'=>$this->detalle,
                ':totalImpuesto'=>$this->totalImpuesto,
                ':totalComprobante'=>$this->totalComprobante,
                ':idEmisor'=>$this->idEmisor,
                ':idTipoIdentificacionEmisor'=>$this->idTipoIdentificacionEmisor,
                ':identificacionEmisor'=>$this->identificacionEmisor,
                ':idReceptor'=>$this->idReceptor,
                ':idTipoIdentificacionReceptor'=>$this->idTipoIdentificacionReceptor,
                ':identificacionReceptor'=>$this->identificacionReceptor,
                ':xml'=>$this->xml->asXML()
            );
            $data = DATA::Ejecutar($sql,$param, false);
            if($data){
                $this->enviar();
                error_log("[INFO] Certificado OK");
                echo "UPLOADED";
                return true;
            }
            else throw new Exception('No es posible guardar el mensaje receptor.', 98);            
        }     
        catch(Exception $e) {
            error_log("[ERROR]: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function enviar(){
        try{
            $this->Read();
            $this->idSituacionComprobante = 1; // normal.
            $this->terminal = '00001'; // normal.
            $this->local = '001'; // normal.            
            $entidad = new ClienteFE();
            $entidad->idBodega = $this->idReceptor;
            $this->datosReceptor = $entidad->read(); // receptor es la entidad que compra.
            $this->datosEntidad =   new ClienteFE();         // vendedor
            $this->datosEntidad->idTipoIdentificacion = $this->idTipoIdentificacionEmisor;
            $this->datosEntidad->identificacion = $this->identificacionEmisor;
            $this->datosEntidad->codigoSeguridad = $this->datosReceptor->codigoSeguridad;
            FacturacionElectronica::iniciar($this);
        }
        catch(Exception $e) {
            error_log("[ERROR]: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }
}

?>
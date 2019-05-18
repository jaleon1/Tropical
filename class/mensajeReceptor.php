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
        case "ReadAllbyRangeExterna":
            echo json_encode($mensaje->ReadAllbyRangeExterna());
            break;
        case "ReadAllById":
            echo json_encode($mensaje->ReadAllById());
            break;
        case "Read":
            echo json_encode($mensaje->Read());
            break;
        case "ReadAll":
            echo json_encode($mensaje->ReadAll());
            break;
        case "Create":
            //echo json_encode($mensaje->Create());
            break;
        case "uploadxml":
            require_once("UUID.php");
            // $mensaje->id= $obj["id"] ?? UUID::v4();
            $mensaje->mensaje = $_POST['mensaje'];
            $mensaje->detalle = $_POST['detalle'];
            echo json_encode($mensaje->uploadxml());
            break;
    }    
}

class respuesta{
    public $clave;
    public $estado;
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
    public $respuesta = array();
    public $entidad = null;

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
            $this->consecutivo= $obj["consecutivo"] ?? null;
            $this->fechaCreacion= $obj["fechaCreacion"] ?? null;
            $this->detalle= $obj["detalle"] ?? null;
            $this->mensaje= $obj["mensaje"] ?? null;
            $this->totalComprobante= $obj["totalComprobante"] ?? null;
            $this->idEstadoComprobante= $obj["idEstadoComprobante"] ?? null;
            $this->fechaInicial= $obj["fechaInicial"] ?? null;
            $this->fechaFinal= $obj["fechaFinal"] ?? null;
        }
    }

    function uploadxml(){
        try {
            // sube xml
            $uploaddir= '../../xmlmr/'. $_SESSION['userSession']->idBodega . "/";
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
                        // captura info del archivo.
                        $this->detalleMensaje = (string)$this->xml->DetalleMensaje ?? null;
                        if($this->detalleMensaje == "" || $this->detalleMensaje == null){
                            // es un xml de envio.
                            $this->totalImpuesto = (string)$this->xml->ResumenFactura->TotalImpuesto ?? null;
                            $this->totalComprobante = (string)$this->xml->ResumenFactura->TotalComprobante ?? null;
                            // emisor del comprobante = proveedor
                            $this->idEmisor = $this->idEmisor ?? null; // el id del proveedor aun no se maneja en bd.
                            $this->identificacionEmisor = (string)$this->xml->Emisor->Identificacion->Numero ?? null;
                            $this->idTipoIdentificacionEmisor = (string)$this->xml->Emisor->Identificacion->Tipo;
                            // receptor del comprobante = entidad registrada en el sistema.                            
                            $this->identificacionReceptor = (string)$this->xml->Receptor->Identificacion->Numero ?? null;
                            $this->idTipoIdentificacionReceptor = (string)$this->xml->Receptor->Identificacion->Tipo;
                            
                        } else{
                            // es un xml de acuse.
                            $this->totalImpuesto = (string)$this->xml->MontoTotalImpuesto ?? null;
                            $this->totalComprobante = (string)$this->xml->TotalFactura ?? null;
                            // emisor del comprobante = proveedor
                            $this->idEmisor = $this->idEmisor ?? null; // el id del proveedor aun no se maneja en bd.
                            $this->identificacionEmisor = (string)$this->xml->NumeroCedulaEmisor ?? null;
                            $this->idTipoIdentificacionEmisor = (string)$this->xml->TipoIdentificacionEmisor;
                            // receptor del comprobante = entidad registrada en el sistema.
                            $this->identificacionReceptor = (string)$this->xml->NumeroCedulaReceptor ?? null;
                            $this->idTipoIdentificacionReceptor = (string)$this->xml->TipoIdentificacionReceptor;
                        }
                        // guarda datos en bd. y envía MR.
                        $this->id= UUID::v4();
                        $this->idReceptor = $_SESSION['userSession']->idBodega;
                        $this->clave = (string)$this->xml->Clave ?? null;
                        $this->mensaje = $this->mensaje;
                        $this->detalle = $this->detalle ?? null;
                        // valida cedula.
                        $this->entidad = new ClienteFE();
                        $this->entidad->idBodega = $this->idReceptor;
                        $this->datosReceptor = $this->entidad->read(); // receptor es la entidad que compra.
                        if($this->identificacionReceptor != $this->entidad->identificacion){
                            $r = new Respuesta();
                            $r->clave = $this->clave;
                            $r->estado = 'La Cédula recibida no pertenece a su cuenta';
                            array_push($this->respuesta, $r);
                            continue;
                        }
                        // valida que el archivo tenga el formato correcto.
                        if($this->clave==null || $this->totalImpuesto==null || $this->totalComprobante==null || $this->identificacionEmisor==null || $this->identificacionReceptor==null){
                            $r = new Respuesta();
                            $r->clave = $this->clave;
                            $r->estado = 'Archivo Invalido';
                            array_push($this->respuesta, $r);
                            continue;
                        }
                        // valida que el archivo no esté en bd.
                        $sql="SELECT id 
                            FROM mensajeReceptor 
                            WHERE clave =:clave and idEstadoComprobante<=4";
                        $param= array(':clave'=>$this->clave);
                        $data = DATA::Ejecutar($sql,$param);
                        if(!count($data)){
                            // la clave no está repetida o no ha sido aceptada.
                            $r = new Respuesta();
                            $r->clave = $this->clave;
                            $r->estado = $this->Create();
                            array_push($this->respuesta, $r);
                        }
                        else {
                            // la clave ya fue subida.
                            $r = new Respuesta();
                            $r->clave = $this->clave;
                            $r->estado = 'Repetida';
                            array_push($this->respuesta, $r);
                        }
                    }
                }
            }
            return $this->respuesta;
        }
        catch(Exception $e) {
            error_log("[ERROR]: ". $e->getMessage());
            if (!headers_sent()) {
                    header('HTTP/1.0 400 Error al generar al enviar el email');
                }
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function aceptar(){
        try {                   
            // guarda datos en bd. y envía MR.
            $this->id= UUID::v4();
                       
            // if($this->identificacionReceptor != $this->entidad->identificacion){
            //     $r = new Respuesta();
            //     $r->clave = $this->clave;
            //     $r->estado = 'La Cédula recibida no pertenece a su cuenta';
            //     array_push($this->respuesta, $r);
            //     continue;
            // }
            //$this->idTipoIdentificacionReceptor = (string)$this->xml->TipoIdentificacionReceptor;
            
            // valida que el archivo tenga el formato correcto. NO DEBERIA DE SUCEDER...
            if($this->clave==null || $this->totalImpuesto==null || $this->totalComprobante==null || $this->identificacionEmisor==null || $this->identificacionReceptor==null){
                error_log("[ERROR]: error de datos de MR");
                exit;
            }
            
            // valida que el archivo no esté en bd.
            $sql="SELECT id 
                FROM mensajeReceptor 
                WHERE clave =:clave and idEstadoComprobante<=4";
            $param= array(':clave'=>$this->clave);
            $data = DATA::Ejecutar($sql,$param);
            if(!count($data)){
                // la clave no está repetida o no ha sido aceptada.
                $this->Create();
                error_log("[INFO]: XML ok");
                return true;
            }
            else {
                error_log("[ERROR]: XML REPETIDO EN BD");
            }
        }
        catch(Exception $e) {
            error_log("[ERROR]: ". $e->getMessage());
            if (!headers_sent()) {
                    header('HTTP/1.0 400 Error al generar al enviar el email');
                }
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
            if (!headers_sent()) {
                header('HTTP/1.0 400 Error al generar al enviar el email');
            }
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el mensaje receptor'))
            );
        }
    }

    function ReadAllbyRange(){
        try {
            $sql='SELECT id, consecutivoFe, fechaCreacion, detalle, mensaje, totalComprobante, idEmisor, 
            idEstadoComprobante FROM tropical.mensajeReceptor 
            WHERE idReceptor = :idReceptor 
            and fechaCreacion Between :fechaInicial and :fechaFinal
            ORDER BY consecutivoFe DESC;';
            $param= array(':fechaInicial'=>$this->fechaInicial, ':fechaFinal'=>$this->fechaFinal, ':idReceptor'=>$this->idReceptor);            
            $data= DATA::Ejecutar($sql, $param);   
            return $data;
        }     
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            if (!headers_sent()) {
                    header('HTTP/1.0 400 Error al generar al enviar el email');
                }
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el mensaje receptor'))
            );
        }
    }

    function ReadAllbyRangeExterna(){
        try {
            $sql='SELECT mr.id, mr.consecutivo, mr.fechaCreacion, mr.detalle, mr.mensaje, mr.totalComprobante, mr.idEmisor, 
            idEstadoComprobante 
            FROM tropical.mensajeReceptor mr 
            INNER JOIN tropical.bodega b on b.idTipoBodega = :idTipoBodega 
            WHERE idReceptor = :idReceptor and fechaCreacion Between :fechaInicial and :fechaFinal
            ORDER BY consecutivo DESC;';
            $param= array(':fechaInicial'=>$this->fechaInicial, ':fechaFinal'=>$this->fechaFinal, 
            ':idTipoBodega'=>'22a80c9e-5639-11e8-8242-54ee75873a12', ':idReceptor'=>$this->idReceptor);            
            $data= DATA::Ejecutar($sql, $param);   
            return $data;
        }     
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            if (!headers_sent()) {
                    header('HTTP/1.0 400 Error al generar al enviar el email');
                }
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el mensaje receptor'))
            );
        }
    }

    function ReadAll(){
        try {
            $sql='select id, consecutivo, fechaCreacion, detalle, mensaje, totalComprobante, idEmisor, 
            idEstadoComprobante from mensajeReceptor;';
            $data= DATA::Ejecutar($sql);     
            foreach ($data as $key => $value){
                $this->id = $value['idDocumento'];
                $this->consecutivo = $value['consecutivo'];
                $this->fechaCreacion = $value['fechaCreacion'];
                $this->mensaje = $value['mensaje'];
                $this->detalle = $value['detalle'];
                $this->totalComprobante = $value['totalComprobante'];
                $this->idEstadoComprobante = $value['idEstadoComprobante'];
                $this->idEmisor = $value['idEmisor'];
            }
            return $this;
        }     
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            if (!headers_sent()) {
                    header('HTTP/1.0 400 Error al generar al enviar el email');
                }
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el mensaje receptor'))
            );
        }
    }

    function Create(){
        try {
            if(gettype($this->xml)=="string")
                $this->xml = new SimpleXMLElement($this->xml);
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
            $sql="INSERT INTO mensajeReceptor  (id, idDocumento, clave, consecutivoFE, mensaje, detalle, totalImpuesto, totalComprobante, idEmisor, idTipoIdentificacionEmisor, identificacionEmisor, idReceptor, idTipoIdentificacionReceptor, identificacionReceptor, xml)
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
                return $this->enviar();
            }
            else return 'Error (1015) al crear en base de datos.';         
        }     
        catch(Exception $e) {
            return 'Error (1016) al crear en base de datos.';
        }
    }

    function enviar(){
        try{
            $this->Read();
            $this->idSituacionComprobante = 1; // normal.
            $this->terminal = '00001'; // normal.
            $this->local = '001'; // normal.            
            //
            $this->datosEntidad =   new ClienteFE();         // vendedor
            $this->datosEntidad->idTipoIdentificacion = $this->idTipoIdentificacionEmisor;
            $this->datosEntidad->identificacion = $this->identificacionEmisor;
            $this->datosEntidad->codigoSeguridad = $this->datosReceptor->codigoSeguridad;
            //
            $this->idBodega = $this->entidad->id;
            return FacturacionElectronica::iniciar($this);
        }
        catch(Exception $e) {
            return 'Error (1017) al leer el xml.';
        }
    }
}

?>
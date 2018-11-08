<?php
//date_default_timezone_set('America/Costa_Rica');
error_reporting(0);
if(isset($_GET["action"])){
    $opt= $_GET["action"];
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $mensaje= new mensajeReceptor();
    $mensaje->uploadxml();
}
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes    
    require_once("Conexion.php");
    require_once("Usuario.php");
    require_once("ClienteFE.php");    
    // require_once("facturacionElectronica.php");
    // require_once("encdes.php");    
    // require_once("consumible.php");
    // require_once("InventarioInsumoXBodega.php");
    // require_once("OrdenXFactura.php");    
    // require_once("Receptor.php");
    // require_once("Bodega.php");
    // require_once("productoXFactura.php");    
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
            echo json_encode($mensaje->Create());
            break;
        case "uploadxml":
            echo json_encode($mensaje->uploadxml());
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
    public $mensaje;
    public $detalle;
    public $totalImpuesto;
    public $totalComprobante;
    public $identificacionEmisor;
    public $identificacionReceptor;

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
                        // guarda datos en bd.
                        // envia MR.
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

    function Create(){
        try {
            $sql="INSERT INTO mensajeReceptor   (id, mensaje, detalle, idReceptor)
                VALUES  (:id, :mensaje, :detalle, :idReceptor)";
            $param= array(':id'=>$this->id,
                ':mensaje'=>$this->mensaje,
                ':detalle'=>$this->detalle,
                ':idReceptor'=>$this->idReceptor
            );
            $data = DATA::Ejecutar($sql,$param, false);
            if($data){        
                return $this;
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
}

?>
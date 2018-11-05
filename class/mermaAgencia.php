<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Insumo.php");
    require_once("Producto.php");
    require_once("Usuario.php");
    require_once("Evento.php");
    require_once("Rol.php");
    require_once("InventarioInsumoXBodega.php");
    //require_once("InventarioProducto.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $merma= new MermaAgencia();
    switch($opt){
        case "ReadAll":
            echo json_encode($merma->ReadAll());
            break;
        case "Create":
            echo json_encode($merma->Create());
            break;
    }
}

class MermaAgencia{
    public $id=null;
    public $idBodega= null;
    public $idProducto= null;
    public $idInsumo= null;
    public $descripcion='';
    public $cantidad=0;
    public $fecha;
    public $listaProducto= [];

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->idBodega= $_SESSION['userSession']->idBodega;
            // merma
            if(isset($obj["listaProducto"])){
                $this->listaProducto= [];
                foreach ($obj["listaProducto"] as $itemlist) {
                    $item= new Insumo();
                    $item->id = $itemlist['idProducto'];
                    $item->cantidad = $itemlist['cantidad'];
                    $item->descripcion= $itemlist['descripcion'];
                    array_push ($this->listaProducto, $item);
                }
            }
        }
    }

    // metodos.

    function ReadAll(){
        try {
            $sql='SELECT m.id, p.codigo, m.consecutivo, p.nombre, p.descripcion, m.cantidad, m.descripcion, m.fecha
                FROM mermaAgencia m inner join producto p on p.id = m.idInsumo
                WHERE idBodega =:idBodega';
            $param= array(':idBodega'=> $_SESSION['userSession']->idBodega);
            $data = DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function Create(){
        try {
            $created=true;
            // insumos
            foreach ($this->listaProducto as $item) {
                require_once("UUID.php");
                $id= UUID::v4();
                // historico merma
                $sql="INSERT INTO mermaAgencia (id, idInsumo, cantidad, descripcion, idBodega)
                    VALUES (:id, :idInsumo, :cantidad, :descripcion, :idBodega)";
                $param= array(':id'=> $id,':idInsumo'=> $item->id, ':cantidad'=> $item->cantidad, ':descripcion'=> $item->descripcion, ':idBodega'=> $this->idBodega);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
                // actualiza item.
                InventarioInsumoXBodega::mermaAgenciaSalida( $item->id, 'OrdenXX', $item->cantidad);
                // ***************** imprimir. ***************************
                // ***************** imprimir. ***************************
                // ***************** imprimir. ***************************
            }
            //
            if($created)
                return true;
            else throw new Exception('Error al restar MERMA, debe realizar el procedimiento manualmente.', 666);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }
}

?>
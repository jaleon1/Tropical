<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Insumo.php");
    require_once("Producto.php");
    require_once("InventarioInsumo.php");
    require_once("InventarioProducto.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $merma= new Merma();
    switch($opt){
        case "ReadAll":
            echo json_encode($merma->ReadAll());
            break;
        case "Create":
            echo json_encode($merma->Create());
            break;
    }
}

class Merma{
    public $id=null;
    public $idProducto='';
    public $idInsumo='';
    public $descripcion='';
    public $cantidad=0;
    public $fecha;

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            // merma
            if(isset($obj["listaInsumo"] )){
                $this->listaInsumo= [];
                foreach ($obj["listaInsumo"] as $itemlist) {
                    $item= new Insumo();
                    $item->id = $itemlist['idInsumo'];
                    $item->cantidad = $itemlist['cantidad'];
                    $item->descripcion= $itemlist['descripcion'];
                    array_push ($this->listaInsumo, $item);
                }
            }
            if(isset($obj["listaProducto"] )){
                $this->listaProducto= [];
                foreach ($obj["listaProducto"] as $itemlist) {
                    $item= new Producto();
                    $item->id = $itemlist['idProducto'];
                    $item->cantidad = $itemlist['cantidad'];
                    $item->descripcion= $itemlist['descripcion'];
                    array_push ($this->listaProducto, $item);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT m.id, i.codigo, i.nombre, i.descripcion, m.cantidad, m.descripcion, m.fecha
                FROM mermaInsumo m inner join insumo i on i.id = m.idInsumo
                UNION
                SELECT m.id, p.codigo, p.nombre, p.descripcion, m.cantidad, m.descripcion, m.fecha
                FROM mermaProducto m inner join producto p on p.id = m.idProducto';
            $data= DATA::Ejecutar($sql);
            return $data;
        }     
        catch(Exception $e) {
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
            foreach ($this->listaInsumo as $item) {
                // historico merma
                $sql="INSERT INTO mermaInsumo (id, idInsumo, cantidad, descripcion)
                    VALUES (uuid(), :idInsumo, :cantidad, :descripcion)";
                $param= array(':idInsumo'=> $item->id, ':cantidad'=> $item->cantidad, ':descripcion'=> $item->descripcion);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
                // actualiza item
                InventarioInsumo::salida( $item->id, 'merma', $item->cantidad);
            }
            // productos
            foreach ($this->listaProducto as $item) {
                // historico merma
                $sql="INSERT INTO mermaProducto (id, idProducto, cantidad, descripcion)
                    VALUES (uuid(), :idProducto, :cantidad, :descripcion)";
                $param= array(':idProducto'=> $item->id, ':cantidad'=> $item->cantidad, ':descripcion'=> $item->descripcion);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
                // actualiza item
                InventarioProducto::salida($item->id, 'merma', $item->cantidad);
            }
            //
            if($created)
                return true;
            else throw new Exception('Error al restar MERMA, debe realizar el procedimiento manualmente.', 666);
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }
}


?>
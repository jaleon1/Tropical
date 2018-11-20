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
        case "rollback":
            $merma->rollback();
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
                FROM mermaAgencia m 
                inner join insumosXBodega x on x.id = m.idInsumo
                inner join producto p on p.id = x.idProducto
                WHERE m.idBodega =:idBodega';
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
                // porcion
                // $sql="SELECT esVenta 
                //     FROM tropical.insumosXBodega x inner join producto p on p.id = x.idProducto
                //     where x.id = :id;";
                // $param= array(':id'=> $item->id);
                // $data = DATA::Ejecutar($sql,$param);
                // $porcion = 1;
                // if($data[0]['esVenta']=='0')
                //     $porcion = 1;
                // else if($data[0]['esVenta']=='1')
                //     $porcion = 20;
                // else if($data[0]['esVenta']=='2')
                //     $porcion = 40;
                //$item->cantidad = $item->cantidad * $porcion;
                // historico merma
                $sql="INSERT INTO mermaAgencia (id, idInsumo, cantidad, descripcion, idBodega)
                    VALUES (:id, :idInsumo, :cantidad, :descripcion, :idBodega)";
                $param= array(':id'=> $id,':idInsumo'=> $item->id, ':cantidad'=> $item->cantidad, ':descripcion'=> $item->descripcion, ':idBodega'=> $this->idBodega);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
                // consecutivo.
                // $sql="SELECT consecutivo 
                //     FROM tropical.mermaAgencia
                //     order by consecutivo desc limit 1";
                // //$param= array(':id'=> $item->id);
                // $data = DATA::Ejecutar($sql);
                // actualiza item.
                InventarioInsumoXBodega::mermaAgenciaSalida( $item->id, 'porcionXX', $item->cantidad);
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

    function Rollback(){
        try {
            // Entrada a inventario agencia.
            // delete from mermaAgencia.
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
<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Producto.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $consumible= new Consumible();
    switch($opt){
        case "ReadAll":
            echo json_encode($consumible->ReadAll());
            break;
        case "Create":
            echo json_encode($consumible->Create());
            break;
        case "Delete":
            echo json_encode($consumible->Delete($consumible->id));
            break;  
        case "ReadByCode":
            echo json_encode($consumible->ReadByCode());
            break;
    }
}

class Consumible{
    public $id=null;
    public $idProducto=null;
    public $cantidad=0;
    public $codigo=0;

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->codigo= $obj["codigo"] ?? '';
            // consumible
            if(isset($obj["lista"] )){
                $this->lista= [];
                foreach ($obj["lista"] as $itemlist) {
                    $item= new Producto();
                    $item->id = $itemlist['id'];
                    $item->idProducto = $itemlist['idProducto'];
                    $item->cantidad = $itemlist['cantidad'];
                    array_push ($this->lista, $item);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT c.id, c.idProducto, p.codigo, p.nombre, c.cantidad
                FROM consumible c inner join producto p on p.id = c.idProducto';
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

    // busca los productos y les asigna un uuid nuevo para agregarlo como consumible
    function ReadByCode(){
        try{
            $sql="SELECT uuid() as id, id as idProducto, nombre, codigo
                FROM producto 
                WHERE codigo like :codigo";
            $param= array(':codigo'=>'%'.$this->codigo.'%');

            $data= DATA::Ejecutar($sql,$param);
            
            if(count($data))
                return $data;
            else return false;
        }
        catch(Exception $e){
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Create(){
        try {
            $created=true;
            //borra los consumibles
            $this->Delete();
            // productos
            foreach ($this->lista as $item) {                
                // historico consumible
                $sql="INSERT INTO consumible (id, idProducto, cantidad)
                    VALUES (:id, :idProducto, :cantidad)";
                $param= array(':id'=> $item->id, ':idProducto'=> $item->idProducto, ':cantidad'=> $item->cantidad);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
            }
            if($created)
                return true;
            else throw new Exception('Error al crear el consumible.', 66923);
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Delete(){
        try {                  
            $sql='DELETE  FROM consumible';
                // WHERE id=:id';
            //$param= array(':id'=> $id);
            $data= DATA::Ejecutar($sql,null,false);
            if($data)
                return $sessiondata['status']=0;
            else throw new Exception('Error al eliminar.', 54649);
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
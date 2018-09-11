<?php
require_once("Conexion.php");
require_once("productosXBodega.php");
//
if (!isset($_SESSION))
    session_start();

if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    //
    $bodega= new Bodega();
    switch($opt){
        case "ReadAll":
            echo json_encode($bodega->ReadAll());
            break;
        case "Read":
            echo json_encode($bodega->Read());
            break;
        case "ListTipos":
            echo json_encode($bodega->ListTipos());
            break;
        case "List":
            echo json_encode($bodega->List());
            break;
        case "readByUser":
            echo json_encode($bodega->readByUser());
            break;
        case "Create":
            $bodega->Create();
            break;
        case "Update":
            $bodega->Update();
            break;
        case "Delete":
            $bodega->Delete();
            break;   
    }    
}

class Bodega{
    public $id=null;
    public $nombre='';
    public $descripcion='';    
    public $ubicacion='';
    public $contacto='';
    public $telefono='';
    public $tipo= null;    

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->nombre= $obj["nombre"] ?? '';
            $this->ubicacion= $obj["ubicacion"] ?? '';
            $this->descripcion= $obj["descripcion"] ?? '';
            $this->contacto= $obj["contacto"] ?? '';            
            $this->telefono= $obj["telefono"] ?? '';            
            $this->tipo= $obj["tipo"] ?? null;
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT b.id, b.nombre, b.descripcion , t.nombre as tipo
                FROM     bodega  b INNER JOIN tipoBodega t on t.id = b.idTipoBodega
                ORDER BY b.nombre asc';
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

    function Read(){
        try {
            $sql='SELECT b.id, b.nombre, b.descripcion, b.ubicacion, b.contacto, b.telefono, b.idTipoBodega as tipo
                FROM bodega  b
                where b.id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);     
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la bodega'))
            );
        }
    }

    function readByUser(){
        try {                                    
            require_once('Usuario.php');
            session_reset();
            $sql='SELECT b.id, b.nombre, b.descripcion , t.nombre as tipo
                    FROM tropical.bodega b 
                        INNER JOIN usuariosXBodega u on u.idbodega = b.id
                        INNER JOIN tipoBodega t on t.id = b.idTipoBodega
                    WHERE  u.idUsuario = :userId
                ORDER BY b.nombre asc';
            
            $param= array(':userId'=>$_SESSION['userSession']->id);
            $data= DATA::Ejecutar($sql,$param);    
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

    function ListTipos(){
        try {
            $sql='SELECT id, nombre
                FROM     tipoBodega       
                WHERE   nombre!="Primaria"
                ORDER BY nombre asc';
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

    function List(){
        try {
            $sql='SELECT id, nombre
                FROM     bodega
                ORDER BY nombre asc';
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
            $sql="INSERT INTO bodega   (id, nombre, ubicacion, descripcion, contacto, telefono, idTipoBodega)
                VALUES (:id, :nombre, :ubicacion, :descripcion, :contacto, :telefono, :tipo);";
            //
            $param= array(':id'=>$this->id, ':nombre'=>$this->nombre, ':ubicacion'=>$this->ubicacion, ':descripcion'=>$this->descripcion, 
                ':contacto'=>$this->contacto, ':telefono'=>$this->telefono, ':tipo'=>$this->tipo);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
            {
                $pb = new ProductosXBodega();
                $pb->idBodega= $this->id;
                $pb->create();
                return true;            
            }
            else throw new Exception('Error al guardar.', 02);
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Update(){
        try {
            $sql="UPDATE bodega 
                SET nombre=:nombre, ubicacion=:ubicacion, descripcion= :descripcion, contacto=:contacto, telefono=:telefono, idTipoBodega=:tipo
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':nombre'=>$this->nombre, ':ubicacion'=>$this->ubicacion, ':descripcion'=>$this->descripcion, 
                ':contacto'=>$this->contacto, ':telefono'=>$this->telefono, ':tipo'=>$this->tipo);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                return true;
            }
            else throw new Exception('Error al guardar.', 123);
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    private function CheckRelatedItems(){
        try{
            $sql="SELECT xx 
                FROM  xx R
                WHERE R.xx= :id";
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param);
            if(count($data))
                return true;
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

    function Delete(){
        try {
            // if($this->CheckRelatedItems()){
            //     //$sessiondata array que devuelve si hay relaciones del objeto con otras tablas.
            //     $sessiondata['status']=1; 
            //     $sessiondata['msg']='Registro en uso'; 
            //     return $sessiondata;           
            // }            
            $sql='DELETE FROM bodega  
                WHERE id= :id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data)
                return $sessiondata['status']=0; 
            else throw new Exception('Error al eliminar.', 978);
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
<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $ipautorizada= new ipAutorizada();
    switch($opt){
        case "ReadAll":
            echo json_encode($ipautorizada->ReadAll());
            break;
        case "Read":
            echo json_encode($ipautorizada->Read());
            break;
        case "Create":
            $ipautorizada->Create();
            break;
        case "Update":
            $ipautorizada->Update();
            break;
        case "Delete":
            $ipautorizada->Delete();
            break; 
    }
}

class ipAutorizada{
    public $ip= null;
    public $created= null;

    function __construct(){
        // identificador único
        if(isset($_POST["ip"])){
            $this->ip= $_POST["ip"];
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT ip, created
                FROM     ipAutorizada';
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
            $sql='SELECT ip, created
                FROM ipAutorizada
                where ip=:ip';
            $param= array(':ip'=>$this->ip);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el ipautorizada'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO ipAutorizada (ip) VALUES (:ip);";
            //
            $param= array(':ip'=>$this->ip );
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
            {
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
            $sql="UPDATE ipAutorizada 
                SET  ip=:ip
                WHERE ip=:ip";
            $param= array(':ip'=>$this->ip);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
                return true;
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

    function Delete(){
        try {
            // if($this->CheckRelatedItems()){
            //     //$sessiondata array que devuelve si hay relaciones del objeto con otras tablas.
            //     $sessiondata['status']=1; 
            //     $sessiondata['msg']='Registro en uso'; 
            //     return $sessiondata;           
            // }                    
            $sql='DELETE FROM ipAutorizada  
            WHERE ip= :ip';
            $param= array(':ip'=>$this->ip);
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
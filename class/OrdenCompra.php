<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Usuario.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $ordencompra= new OrdenCompra();
    switch($opt){
        case "ReadAll":
            echo json_encode($ordencompra->ReadAll());
            break;
        case "Read":
            echo json_encode($ordencompra->Read());
            break;
        case "Create":
            $ordencompra->Create();
            break;
        case "Update":
            $ordencompra->Update();
            break;
        case "Delete":
            $ordencompra->Delete();
            break;   
    }
}

class OrdenCompra{
    public $id=null;
    public $fecha='';
    public $idproveedor=null;
    public $orden='';
    public $idusuario=null;
    public $lista= [];

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            //$this->fecha= $obj["fecha"] ?? '';
            $this->idproveedor= $obj["idproveedor"] ?? null;
            $this->orden= $obj["orden"] ?? '';            
            //$this->idusuario= $obj["idusuario"] ?? null;
            // lista.
            if(isset($obj["lista"] )){
                require_once("InsumosXOrdenCompra.php");
                //
                foreach ($obj["lista"] as $itemlist) {
                    $item= new InsumosXOrdenCompra();
                    $item->idordencompra= $this->id;
                    $item->idinsumo= $itemlist['idinsumo'];
                    $item->costounitario= $itemlist['costounitario'];
                    $item->cantidadbueno= $itemlist['cantidadbueno'];
                    $item->cantidadmalo= $itemlist['cantidadmalo'];
                    $item->valorbueno= $itemlist['valorbueno'];
                    $item->valormalo= $itemlist['valormalo'];
                    array_push ($this->lista, $item);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, fecha, idproveedor, orden, idusuario
                FROM     ordencompra       
                ORDER BY fecha asc';
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
            $sql='SELECT id, fecha, idproveedor, orden, idusuario
                FROM ordencompra  
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el ordencompra'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO ordencompra   (id, idproveedor, orden, idusuario) VALUES (:id, :idproveedor, :orden, :idusuario);";
            //
            //require_once('Evento.php');
            
            $param= array(':id'=>$this->id ,':idproveedor'=>$this->idproveedor, ':orden'=>$this->orden, ':idusuario'=>$_SESSION['usersession']->id);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
            {
                //save array obj
                if(InsumosXOrdenCompra::Create($this->lista))
                    return true;
                else throw new Exception('Error al guardar los roles.', 03);
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
            $sql="UPDATE ordencompra 
                SET fecha=:fecha, idproveedor=:idproveedor, orden=:orden, idusuario=:idusuario
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':fecha'=>$this->fecha, ':idproveedor'=>$this->idproveedor, ':orden'=>$this->orden, ':idusuario'=>$this->idusuario);
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

    private function CheckRelatedItems(){
        try{
            $sql="SELECT id
                FROM /*  definir relacion */ R
                WHERE R./*definir campo relacion*/= :id";                
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
            $sql='DELETE FROM ordencompra  
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

    function ReadByCode(){
        try{     
            $sql="SELECT id, fecha, idproveedor, descripcion
                FROM ordencompra
                WHERE idproveedor= :idproveedor";
            $param= array(':idproveedor'=>$this->idproveedor);
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

}



?>
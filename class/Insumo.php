<?php
require_once("Conexion.php");
//require_once("Log.php");
//require_once('Globals.php');
//
if (!isset($_SESSION))
    session_start();

if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    $insumo= new Insumo();
    switch($opt){
        case "ReadAll":
            echo json_encode($insumo->ReadAll());
            break;
        case "Read":
            echo json_encode($insumo->Read());
            break;
        case "Create":
            $insumo->Create();
            break;
        case "Update":
            $insumo->Update();
            break;
        case "Delete":
            $insumo->Delete();
            break;   
    }
}

class Insumo{
    public $id=null;
    public $codigo='';
    public $nombre='';
    public $descripcion='';
    public $saldocantidad=0;
    public $saldocosto=0;
    public $costopromedio=0;

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->id= $obj["id"] ?? null;
            $this->codigo= $obj["codigo"] ?? '';
            $this->nombre= $obj["nombre"] ?? '';
            $this->descripcion= $obj["descripcion"] ?? '';
            $this->saldocantidad= $obj["saldocantidad"] ?? 0;            
            $this->saldocosto= $obj["saldocosto"] ?? 0;
            $this->costopromedio= $obj["costopromedio"] ?? 0;
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, codigo, nombre, descripcion, saldocantidad, saldocosto, costopromedio
                FROM     insumo       
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

    function Read(){
        try {
            $sql='SELECT id, codigo, nombre, descripcion, saldocantidad, saldocosto, costopromedio
                FROM insumo  
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el insumo'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO insumo (id, codigo, nombre, descripcion, saldocantidad, saldocosto, costopromedio) VALUES (uuid(), :codigo, :nombre, :descripcion, :saldocantidad, :saldocosto, :costopromedio);";
            //
            $param= array(':codigo'=>$this->codigo,':nombre'=>$this->nombre, ':descripcion'=>$this->descripcion, ':saldocantidad'=>$this->saldocantidad, ':saldocosto'=>$this->saldocosto, ':costopromedio'=>$this->costopromedio);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
            {
                //get id.
                //save array obj
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
            $sql="UPDATE insumo 
                SET  codigo=:codigo, nombre=:nombre, descripcion=:descripcion, saldocantidad=:saldocantidad, saldocosto=:saldocosto, costopromedio=:costopromedio
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':codigo'=>$this->codigo,':nombre'=>$this->nombre, ':descripcion'=>$this->descripcion, ':saldocantidad'=>$this->saldocantidad, ':saldocosto'=>$this->saldocosto, ':costopromedio'=>$this->costopromedio);
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
            $sql='DELETE FROM insumo  
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
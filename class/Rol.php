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
    $rol= new Rol();
    switch($opt){
        case "ReadAll":
            echo json_encode($rol->ReadAll());
            break;
        case "Read":
            echo json_encode($rol->Read());
            break;
        case "Create":
            $rol->Create();
            break;
        case "Update":
            $rol->Update();
            break;
        case "Delete":
            echo json_encode($rol->Delete());
            break;   
    }    
}

class Rol{
    public $id=null;
    public $nombre='';
    public $descripcion='';
    public $listaEvento= array();
    

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
            $this->descripcion= $obj["descripcion"] ?? '';
            //Categorias del rol.
            if(isset($obj["listaEvento"] )){
                require_once("EventosXRol.php");
                //
                foreach ($obj["listaEvento"] as $ideven) {
                    $evenrol= new EventosXRol();
                    $evenrol->idEvento= $ideven;
                    $evenrol->idRol= $this->id;
                    array_push ($this->listaEvento, $evenrol);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, nombre, descripcion
                FROM     rol       
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
            $sql='SELECT r.id, r.nombre, r.descripcion,  e.id as idEvento , e.nombre as nombreEvento
                FROM rol  r LEFT JOIN eventosXRol er on er.idRol = r.id
                    LEFT join evento e on e.id = er.idEvento
                where r.id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);     
            foreach ($data as $key => $value){
                require_once("Evento.php");
                $evento= new Evento(); // categorias del rol
                if($key==0){
                    $this->id = $value['id'];
                    $this->nombre = $value['nombre'];
                    $this->descripcion = $value['descripcion'];
                    // Evento
                    if($value['idEvento']!=null){
                        $evento->id = $value['idEvento'];
                        $evento->nombre = $value['nombreEvento'];
                        array_push ($this->listaEvento, $evento);
                    }
                }
                else {
                    $evento->id = $value['idEvento'];
                    $evento->nombre = $value['nombreEvento'];
                    array_push ($this->listaEvento, $evento);
                }
            }
            return $this;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el rol'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO rol   (id, nombre, descripcion)
                VALUES (:uuid, :nombre, :descripcion)";
            //
            $param= array(':uuid'=>$this->id, ':nombre'=>$this->nombre, ':descripcion'=>$this->descripcion );
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
            {
                //save array obj
                if(EventosXRol::Create($this->listaEvento))
                    return true;
                else throw new Exception('Error al guardar los eventos.', 03);
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
            $sql="UPDATE rol 
                SET nombre=:nombre, descripcion= :descripcion 
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':nombre'=>$this->nombre, ':descripcion'=>$this->descripcion);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                //update array obj
                if($this->listaEvento!=null)
                    if(EventosXRol::Update($this->listaEvento))
                        return true;            
                    else throw new Exception('Error al guardar los eventos.', 03);
                else {
                    // no tiene categorieventos
                    if(EventosXRol::Delete($this->id))
                        return true;
                    else throw new Exception('Error al guardar los eventos.', 04);
                }
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
            $sql="SELECT idRol
                FROM eventosXRol x
                WHERE x.idRol= :id";
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
            if($this->CheckRelatedItems()){
                //$sessiondata array que devuelve si hay relaciones del objeto con otras tablas.
                $sessiondata['status']=1; 
                $sessiondata['msg']='Registro en uso'; 
                return $sessiondata;           
            }                    
            $sql='DELETE FROM rol  
                WHERE id= :id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data){
                $sessiondata['status']=0; 
                return $sessiondata;
            }                
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
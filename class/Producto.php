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
    $producto= new Producto();
    switch($opt){
        case "ReadAll":
            echo json_encode($producto->ReadAll());
            break;
        case "Read":
            echo json_encode($producto->Read());
            break;
        case "ReadAllArticulo":
            echo json_encode($producto->ReadAllArticulo());
            break;
        case "ReadArticulo":
            echo json_encode($producto->ReadArticulo());
            break;
        case "Create":
            $producto->Create();
            break;
        case "Update":
            $producto->Update();
            break;
        case "UpdateCantidad":
            $producto->UpdateCantidad();
            break;
        case "Delete":
            echo json_encode($producto->Delete());
            break;   
        case "ReadByCode":  
            echo json_encode($producto->ReadByCode());
            break;
    }
}

class Producto{
    public $id=null;
    public $nombre='';
    public $codigo='';
    public $articulo=0;

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->id= $obj["id"] ?? null;
            $this->nombre= $obj["nombre"] ?? '';
            $this->codigo= $obj["codigo"] ?? '';
            $this->articulo= $obj["articulo"] ?? 0;
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, nombre, codigo, descripcion, saldocosto, costopromedio, precioventa, esventa
                FROM     producto       
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
  
    function ReadAllArticulo(){
        try {
            $sql='SELECT id, nombre, codigo, descripcion, saldocosto, costopromedio, precioventa, esventa
                FROM     producto       
                WHERE articulo=1
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
            $sql='SELECT id, nombre, codigo, descripcion, saldocosto, costopromedio, precioventa, esventa
                FROM producto  
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el producto'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO producto   (id, nombre, codigo, articulo ) VALUES (uuid(),:nombre, :codigo, :articulo );";
            //
            $param= array(':nombre'=>$this->nombre, ':codigo'=>$this->codigo, ':articulo'=>$this->articulo);
            $data = DATA::Ejecutar($sql,$param, false);
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
            $sql="UPDATE producto 
                SET nombre=:nombre, codigo=:codigo
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':nombre'=>$this->nombre, ':codigo'=>$this->codigo);
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
    
    // function UpdateCantidad(){
    //     try {
    //         /*

    //         INSERTAR CANTIDAD PRODUCTO BODEGA PRINCIPAL

    //         $param= array(':id'=>$_POST["idproducto"]);
    //         $sql="SELECT cantidad FROM productosxbodega WHERE idproducto=:id";
    //         $data=DATA::Ejecutar($sql,$param);
    //         $cantidad = $data[0][0] + $_POST["cantidad"];
            
    //         $sql="UPDATE producto SET cantidad=:cantidad WHERE id=:id";
    //         $param= array(':id'=>$_POST["idproducto"], ':cantidad'=>$cantidad);
    //         $data = DATA::Ejecutar($sql,$param,false);
    //         */
            
    //         $sql="UPDATE productotemporal SET estado=1 WHERE id=:id";
    //         $param= array(':id'=>$_POST["id"]);
    //         $data = DATA::Ejecutar($sql,$param,false);

    //         if($data)
    //             return true;
    //         else throw new Exception('Error al guardar.', 123);
    //     }     
    //     catch(Exception $e) {
    //         header('HTTP/1.0 400 Bad error');
    //         die(json_encode(array(
    //             'code' => $e->getCode() ,
    //             'msg' => $e->getMessage()))
    //         );
    //     }
    // }

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
            $sql='DELETE FROM producto  
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
            $sql="SELECT id, nombre, codigo, descripcion, saldocosto, costopromedio, precioventa, esventa
                FROM producto 
                WHERE codigo= :codigo";
            $param= array(':codigo'=>$this->codigo);
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
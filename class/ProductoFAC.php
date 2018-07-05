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
        case "Create":
            $producto->Create();
            break;
        case "Update":
            $producto->Update();
            break;
        case "Delete":
            $producto->Delete();
            break;   
        case "CheckRelatedItems":  
            echo json_encode($producto->CheckRelatedItems());
            break;  
        case "ReadByCode":  
            echo json_encode($producto->ReadByCode());
            break;
    }
}
class Producto{
    public $id=null;
    public $nombre='';
    public $cantidad=0;
    public $scancode='';
    public $precio=0;
    public $codigoRapido='';
    public $idcategoria='';
    public $fechaExpiracion=null;
    public $descripcion='';
    public $codigo='';
    public $articulo=0;
    function __construct(){
        require_once("Conexion.php");
        //require_once("Log.php");
        //require_once('Globals.php');
        //
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->id= $obj["id"] ?? null;
            $this->nombre= $obj["nombre"] ?? '';
            $this->descripcion= $obj["descripcion"] ?? '';
            $this->cantidad= $obj["cantidad"] ?? 0;            
            $this->scancode= $obj["scancode"] ?? '';
            $this->precio= $obj["precio"] ?? 0;
            $this->codigoRapido= $obj["codigoRapido"] ?? 0;
            $this->idcategoria= $obj["idcategoria"] ?? null;
            $this->fechaExpiracion= $obj["fechaExpiracion"] ?? null;
            //Categorias del producto.
            if(isset($obj["listaCategoria"] )){
                require_once("CategoriasXProducto.php");
                //
                foreach ($obj["listaCategoria"] as $idcat) {
                    $catprod= new CategoriasXProducto();
                    $catprod->idcategoria= $idcat;
                    $catprod->idProducto= $this->id;
                    array_push ($this->listaCategoria, $catprod);
                }
            }
        }
    }
    function ReadAll(){
        try {
            $sql='SELECT id, nombre, cantidad, scancode, cantidad, precio , codigoRapido
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
    function Read(){
        try {
            $sql='SELECT id, nombre, cantidad, scancode, precio , codigoRapido, idcategoria, fechaExpiracion, descripcion
                FROM producto  
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);     
            foreach ($data as $key => $value){
                require_once("Categoria.php");
                $cat= new Categoria(); // categorias del producto
                if($key==0){
                    $this->id = $value['id'];
                    $this->nombre = $value['nombre'];
                    $this->nombreAbreviado = $value['nombreAbreviado'];
                    $this->descripcion = $value['descripcion'];
                    $this->cantidad = $value['cantidad'];
                    $this->precio = $value['precio'];
                    $this->scancode = $value['scancode'];
                    $this->codigoRapido = $value['codigoRapido'];
                    $this->fechaExpiracion = $value['fechaExpiracion'];
                    //categoria
                    if($value['idcategoria']!=null){
                        $cat->id = $value['idcategoria'];
                        $cat->nombre = $value['nombrecategoria'];
                        array_push ($this->listaCategoria, $cat);
                    }
                }
                else {
                    $cat->id = $value['idcategoria'];
                    $cat->nombre = $value['nombrecategoria'];
                    array_push ($this->listaCategoria, $cat);
                }
            }
            return $this;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el producto'))
            );
        }
    }
    function ReadByCode(){
        try{     
            $sql="SELECT id, codigoRapido, descripcion, precio, cantidad, id FROM producto WHERE codigoRapido =:codigoRapido OR scancode =:scancode";
            $param= array(':codigoRapido'=>$this->codigoRapido,':scancode'=>$this->scancode);
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
            $sql="INSERT INTO producto   (id,nombre, cantidad, scancode, precio ,codigoRapido, idcategoria, fechaExpiracion, descripcion)
                VALUES (uuid(),:nombre, :cantidad, :scancode, :precio ,:codigoRapido, :idcategoria, :fechaExpiracion, :descripcion)";              
            //
            $param= array(':nombre'=>$this->nombre,':cantidad'=>$this->cantidad,':scancode'=>$this->scancode, ':precio'=>$this->precio, ':codigoRapido'=>$this->codigoRapido, ':idcategoria'=>$this->idcategoria, ':fechaExpiracion'=>$this->fechaExpiracion, ':descripcion'=>$this->descripcion );
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
            {
                //save array obj
                //if(CategoriasXProducto::Create($this->listaCategoria))
                    return true;
                //else throw new Exception('Error al guardar las categorias.', 03);
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
                SET nombre=:nombre, cantidad=:cantidad, scancode=:scancode, precio=:precio, codigoRapido=:codigoRapido, idcategoria=:idcategoria, fechaExpiracion=:fechaExpiracion, descripcion= :descripcion
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':nombre'=>$this->nombre,':cantidad'=>$this->cantidad,':scancode'=>$this->scancode, ':precio'=>$this->precio , ':codigoRapido'=>$this->codigoRapido, ':idcategoria'=>$this->idcategoria, ':fechaExpiracion'=>$this->fechaExpiracion, ':descripcion'=>$this->descripcion );
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                //update array obj
                if($this->listaCategoria!=null)
                    if(CategoriasXProducto::Update($this->listaCategoria))
                        return true;            
                    else throw new Exception('Error al guardar las categorias.', 03);
                else {
                    // no tiene categorias
                    if(CategoriasXProducto::Delete($this->id))
                        return true;
                    else throw new Exception('Error al guardar las categorias.', 04);
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
    function CheckRelatedItems(){
        try{
            $sql="SELECT idProducto
                FROM categoriasXProducto x
                WHERE x.idProducto= :id";
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param);
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
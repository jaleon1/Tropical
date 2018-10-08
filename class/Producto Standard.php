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
            echo json_encode($producto->Delete());
            break;   
    }    
}

class Producto{
    public $id=null;
    public $nombre='';
    public $nombreAbreviado='';
    public $descripcion='';    
    public $cantidad=0;
    public $precio=0;
    public $scancode='';
    public $codigoRapido='';
    public $fechaExpiracion=null;
    public $listaCategoria= array();
    

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
            $this->nombreAbreviado= $obj["nombreAbreviado"] ?? '';
            $this->descripcion= $obj["descripcion"] ?? '';
            $this->cantidad= $obj["cantidad"] ?? 0;            
            $this->precio= $obj["precio"] ?? 0;
            $this->scancode= $obj["scancode"] ?? '';            
            $this->codigoRapido= $obj["codigoRapido"] ?? 0;            
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
            $sql='SELECT id, nombre, nombreAbreviado, scancode, cantidad, precio , codigoRapido
                FROM     producto       
                ORDER BY nombre asc';
            $data= DATA::Ejecutar($sql);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function Read(){
        try {
            $sql='SELECT p.id, p.nombre, p.nombreAbreviado, p.descripcion, cantidad, precio, scancode, codigoRapido, fechaExpiracion, c.id as idcategoria,c.nombre as nombrecategoria
                FROM producto  p LEFT JOIN categoriasXProducto cp on cp.idProducto = p.id
                    LEFT join categoria c on c.id = cp.idcategoria
                where p.id=:id';
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
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el producto'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO producto   (id, nombre, nombreAbreviado, descripcion, cantidad, precio, scancode, codigoRapido, fechaExpiracion)
                VALUES (:uuid, :nombre, :nombreAbreviado, :descripcion, :cantidad, :precio, :scancode, :codigoRapido, :fechaExpiracion)";
            //
            $param= array(':uuid'=>$this->id, ':nombre'=>$this->nombre, ':nombreAbreviado'=>$this->nombreAbreviado, ':descripcion'=>$this->descripcion, ':cantidad'=>$this->cantidad, ':precio'=>$this->precio,
                ':scancode'=>$this->scancode, ':codigoRapido'=>$this->codigoRapido, ':fechaExpiracion'=>$this->fechaExpiracion);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
            {
                //save array obj
                if(CategoriasXProducto::Create($this->listaCategoria))
                    return true;
                else throw new Exception('Error al guardar las categorias.', 03);
            }
            else throw new Exception('Error al guardar.', 02);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
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
                SET nombre=:nombre, nombreAbreviado=:nombreAbreviado, descripcion= :descripcion, cantidad=:cantidad, precio=:precio, scancode=:scancode, codigoRapido=:codigoRapido, fechaExpiracion=:fechaExpiracion
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':nombre'=>$this->nombre, ':nombreAbreviado'=>$this->nombreAbreviado, ':descripcion'=>$this->descripcion, ':cantidad'=>$this->cantidad, ':precio'=>$this->precio , 
                ':scancode'=>$this->scancode, ':codigoRapido'=>$this->codigoRapido, ':fechaExpiracion'=>$this->fechaExpiracion);
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
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }   

    private function CheckRelatedItems(){
        try{
            $sql="SELECT idProducto
                FROM categoriasXProducto x
                WHERE x.idProducto= :id";
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
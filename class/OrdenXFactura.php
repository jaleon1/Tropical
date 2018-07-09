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
    // id, idFactura, idPrecio, numeroLinea, cantidad, idUnidadMedida, 
        // detalle, precioUnitario, montoTotal, montoDescuento, naturalezaDescuento,         
//         subTotal, codigoImpuesto, tarifaImpuesto, montoImpuesto, montoTotalLinea

// VALUES (uuid(), uuid(), uuid(), 5, 1.000, 33, 
// "COPOS", 1800.00, 1800.00, 0.00, "nada", 
// 1800.00, "1", 13.00, 130.00, 1930);

    public $idTamano=null;
    public $idSabor1=null;
    public $idSabor2=null;
    public $idTopping=null;
    public $estado='0';

    public $id=null;
    public $idFactura=null;
    public $idPrecio=null;
    public $numeroLinea=0;
    public $cantidad=0.000;
    public $idUnidadMedida=33; //codigo "33" para unidades

    public $detalle='';
    public $precioUnitario=0.00;
    public $montoTotal=0.00;
    public $montoDescuento=0.00;
    public $naturalezaDescuento='';

    public $subTotal=0.00;
    public $codigoImpuesto='';
    public $tarifaImpuesto=13.00;
    public $montoImpuesto=0.00;
    public $montoTotalLinea=0.00;

    function __construct(){
        require_once("Conexion.php");

        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            // INSERT INTO detalleOrden (id, tamano, idFactura, idSabor1, idSabor2, idTopping, estado)
            // VALUES (uuid(), 1, uuid(), uuid(), uuid(), uuid(), 1);

            $obj= json_decode($_POST["obj"],true);
            $this->idFactura= $obj["idFactura"] ?? null;
            $this->idTamano= $obj["idTamano"] ?? null;
            $this->idSabor1= $obj["idSabor1"] ?? null;
            $this->idSabor2= $obj["idSabor2"] ?? null;
            $this->idTopping= $obj["idTopping"] ?? null;            
            $this->numLinea= $obj["numLinea"] ?? '';
            $this->cant= $obj["cant"] ?? 0;
            $this->detalle= $obj["detalle"] ?? '';

            // //Categorias del producto.
            // if(isset($obj["listaCategoria"] )){
            //     require_once("CategoriasXProducto.php");
            //     //
            //     foreach ($obj["listaCategoria"] as $idcat) {
            //         $catprod= new CategoriasXProducto();
            //         $catprod->idcategoria= $idcat;
            //         $catprod->idProducto= $this->id;
            //         array_push ($this->listaCategoria, $catprod);
            //     }
            // }
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
        
        // INSERT INTO detalleOrden (id, tamano, idFactura, idSabor1, idSabor2, idTopping, estado)
        // VALUES (uuid(), 1, uuid(), uuid(), uuid(), uuid(), 1);

        try {
            $sql="INSERT INTO detalleOrden (id, tamano, idFactura, idSabor1, idSabor2, idTopping, estado)
                VALUES (uuid(), :tamano, :idFactura, :idSabor1, :idSabor2, :idTopping, :estado)";              
            //
            $param= array(':tamano'=>$this->idTamano,':idFactura'=>$this->idFactura,':idSabor1'=>$this->idSabor1, ':idSabor2'=>$this->idSabor2, ':idTopping'=>$this->idTopping, ':estado'=>$this->estado);
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
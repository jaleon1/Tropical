<?php
date_default_timezone_set('America/Costa_Rica');


if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    // Session
    if (!isset($_SESSION))
        session_start();
        
    require_once("OrdenXFactura.php");
    require_once("ProductoXFactura.php");
    // Instance
    $factura= new Factura();
    switch($opt){
        case "ReadAll":
            echo json_encode($factura->ReadAll());
            break;
        case "Read":
            echo json_encode($factura->Read());
            break;
        case "Create":
            $factura->Create();
            break;
        case "Update":
            $factura->Update();
            break;
        case "Delete":
            echo json_encode($factura->Delete());
            break;   
        case "LoadPreciosTamanos":
            echo json_encode($factura->LoadPreciosTamanos());
            break; 
    }
    
}

class Factura{
    ////////////////////////////////////   
    /////Factura
    public $local="";
    public $terminal="";
    public $idCondicionVenta=null;
    public $idSituacionComprobante=null;
    public $idEstadoComprobante="";
    public $idMedioPago=null;
    public $fechaEmision="";
    public $totalVenta=null; //Precio del producto
    public $totalDescuentos=null;
    public $totalVentaneta=null;
    public $totalImpuestos=null;
    public $totalComprobante=null;
    public $idEmisor=null;
    public $detalleFactura = [];
    public $detalleOrden = [];
    ///////////////////////////////////
    
    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }

        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            //Necesarias para la factura (Segun M Hacienda)
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->totalVenta= $obj["totalVenta"] ?? 0;

            $this->fechaCreacion= $obj["fechaCreacion"] ?? '';
            $this->local= $obj["local"] ?? '001';
            $this->terminal= $obj["terminal"] ?? '00001';
            $this->idCondicionVenta= $obj["idCondicionVenta"] ?? 1;          
            $this->idSituacionComprobante= $obj["idSituacionComprobante"] ?? 1;
            $this->idEstadoComprobante= $obj["idEstadoComprobante"] ?? '1';
            $this->idMedioPago= $obj["idMedioPago"] ?? '1';
            $this->fechaEmision= $obj["fechaEmision"] ?? '';
            $this->totalDescuentos= $obj["totalDescuentos"] ?? 0;
            $this->totalVentaneta= $obj["totalVentaneta"] ?? 0;
            $this->totalImpuesto= $obj["totalImpuesto"] ?? 0;
            $this->totalComprobante= $obj["totalComprobante"] ?? 0;
            $this->idEmisor= "1f85f425-1c4b-4212-9d97-72e413cffb3c";

            if(isset($obj["detalleFactura"] )){

                foreach ($obj["detalleFactura"] as $itemDetalle) {
                    $item= new ProductoXFactura();
                    $item->precioUnitario= $itemDetalle['precioUnitario'];
                    $item->detalle= $itemDetalle['detalle'];
                    $item->numeroLinea= $itemDetalle['numeroLinea'];
                    $item->idPrecio= $itemDetalle['idPrecio'];
                    array_push ($this->detalleFactura, $item);
                }
            }


            if(isset($obj["detalleOrden"] )){

                foreach ($obj["detalleOrden"] as $itemOrden) {
                    $item= new OrdenXFactura();
                    $item->idTamano= $itemOrden['idTamano'];
                    $item->idSabor1= $itemOrden['idSabor1'];
                    $item->idSabor2= $itemOrden['idSabor2'];
                    $item->idTopping= $itemOrden['idTopping'];
                    array_push ($this->detalleOrden, $item);
                }
            }
            

            // $this->subTotal= $obj["subTotal"] ?? ''; 
            // $this->iva= $obj["iva"] ?? 0;            
            // $this->porcentajeIva= $obj["porcentajeIva"] ?? 0;
            // $this->porcentajeDescuento= $obj["porcentajeDescuento"] ?? 0;            
            // $this->total= $obj["total"] ?? null;
            // Categorias del factura.
            // if(isset($obj["listaProducto"] )){
            //     require_once("ProductosXFactura.php");
            //     //
            //     foreach ($obj["listaProducto"] as $idprod) {
            //         $prodfact= new ProductosXFactura();
            //         $prodfact->idcategoria= $idprod;
            //         $prodfact->idproducto= $this->id;
            //         array_push ($this->listaProducto, $prodfact);
            //     }
            // }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, idUsuario, fecha, descuento, iva, porcentajeIva , porcentajeDescuento
                FROM     factura       
                ORDER BY idUsuario asc';
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
            $sql='SELECT p.id, p.idUsuario, p.fecha, p.subTotal, iva, porcentajeIva, descuento, porcentajeDescuento, total, c.id as idcategoria,c.idUsuario as nombrecategoria
                FROM factura  p LEFT JOIN categoriasXProducto cp on cp.idProducto = p.id
                    LEFT join categoria c on c.id = cp.idcategoria
                where p.id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);     
            foreach ($data as $key => $value){
                require_once("Categoria.php");
                $cat= new Categoria(); // categorias del factura
                if($key==0){
                    $this->id = $value['id'];
                    $this->idUsuario = $value['idUsuario'];
                    $this->fecha = $value['fecha'];
                    $this->subTotal = $value['subTotal'];
                    $this->iva = $value['iva'];
                    $this->porcentajeIva = $value['porcentajeIva'];
                    $this->descuento = $value['descuento'];
                    $this->porcentajeDescuento = $value['porcentajeDescuento'];
                    $this->total = $value['total'];
                    //categoria
                    if($value['idcategoria']!=null){
                        $cat->id = $value['idcategoria'];
                        $cat->idusuario = $value['nombrecategoria'];
                        array_push ($this->listaProducto, $cat);
                    }
                }
                else {
                    $cat->id = $value['idcategoria'];
                    $cat->idusuario = $value['nombrecategoria'];
                    array_push ($this->listaProducto, $cat);
                }
            }
            return $this;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el factura'))
            );
        }
    }
    function Create(){
        try {   

            $this->fechaCreacion = date("Y-m-d H:i:s");
            $this->fechaEmision = date("D \d\\e F Y");

            $sql="INSERT INTO factura   (id, fechaCreacion, local, terminal, idCondicionVenta,idSituacionComprobante,idEstadoComprobante, idMedioPago,fechaEmision, totalVenta, totalDescuentos, totalVentaneta, totalImpuesto, totalComprobante, idEmisor)
                                       
            VALUES  (:uuid, :fechaCreacion, :local, :terminal, :idCondicionVenta, :idSituacionComprobante, :idEstadoComprobante, :idMedioPago, :fechaEmision, :totalVenta, :totalDescuentos, :totalVentaneta, :totalImpuesto, :totalComprobante, :idEmisor)"; 
       
            $param= array(':uuid'=>$this->id, ':fechaCreacion'=>$this->fechaCreacion, ':local'=>$this->local, ':terminal'=>$this->terminal, 
                    ':idCondicionVenta'=>$this->idCondicionVenta, ':idSituacionComprobante'=>$this->idSituacionComprobante, ':idEstadoComprobante'=>$this->idEstadoComprobante, 
                    ':idMedioPago'=>$this->idMedioPago, ':fechaEmision'=>$this->fechaEmision, ':totalVenta'=>$this->totalVenta, ':totalDescuentos'=>$this->totalDescuentos, 
                    ':totalVentaneta'=>$this->totalVentaneta, ':totalImpuesto'=>$this->totalImpuesto, ':totalComprobante'=>$this->totalComprobante, ':idEmisor'=>$this->idEmisor);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
            {
                ProductoXFactura::$id=$this->id;
                 //save array obj
                 if(ProductoXFactura::Create($this->detalleFactura)){
                    // retorna orden autogenerada.
                    OrdenXFactura::$id=$this->id;
                    OrdenXFactura::Create($this->detalleOrden);
                    return true;
                }
                else throw new Exception('Error al guardar los productos.', 03);
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
            $sql="UPDATE factura 
                SET idUsuario=:idUsuario, fecha=:fecha, subTotal= :subTotal, iva=:iva, porcentajeIva=:porcentajeIva, descuento=:descuento, porcentajeDescuento=:porcentajeDescuento, total=:total
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':idUsuario'=>$this->idUsuario, ':fecha'=>$this->fecha, ':subTotal'=>$this->subTotal, ':iva'=>$this->iva, ':porcentajeIva'=>$this->porcentajeIva , 
                ':descuento'=>$this->descuento, ':porcentajeDescuento'=>$this->porcentajeDescuento, ':total'=>$this->total);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                //update array obj
                if($this->listaProducto!=null)
                    if(ProductosXFactura::Update($this->listaProducto))
                        return true;            
                    else throw new Exception('Error al guardar las categorias.', 03);
                else {
                    // no tiene categorias
                    if(ProductosXFactura::Delete($this->id))
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
            $sql='DELETE FROM factura  
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

    function LoadPreciosTamanos(){
        try{     
            $b = $_SESSION['idBodega'];
            $sql="SELECT id, tamano, precioVenta FROM preciosXBodega where idBodega = :idBodega;";
            $param= array(':idBodega'=>$b);
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
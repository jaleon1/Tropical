<?php
date_default_timezone_set('America/Costa_Rica');
error_reporting(0);
// require '../ticket/autoload.php';
// use Mike42\Escpos\Printer;
// use Mike42\Escpos\PrintConnectors\WindowsPrintConnector;
// use Mike42\Escpos\PrintConnectors\FilePrintConnector;


if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Usuario.php");
    require_once("ClienteFE.php");
    require_once("Receptor.php");
    require_once("FacturaElectronica.php");
    require_once("encdes.php");
    require_once("InventarioInsumoXBodega.php");
    require_once("consumible.php");
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
        case "ReadAllById":
            echo json_encode($factura->ReadAllById());
            break;
        case "Read":
            echo json_encode($factura->Read());
            break;
        case "ReadVentas":
            echo json_encode($factura->ReadVentas());
            break;
        case "Create":
            echo json_encode($factura->Create());
            break;
        case "EnviarFE":
            $factura->EnviarFE();
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
    //Factura
    public $local="";
    public $terminal="";
    public $idCondicionVenta=null;
    public $clave=null;
    public $consecutivoFE=null;
    public $idSituacionComprobante=null;
    public $idEstadoComprobante= null;
    public $idMedioPago=null;
    public $codigoReferencia = null; // FE - TE - ND - NC ...  documento para envio MH    
    public $fechaEmision="";
    public $totalVenta=null; //Precio del producto
    public $totalDescuentos=null;
    public $totalVentaneta=null;
    public $totalImpuesto=null;
    public $totalComprobante=null;
    public $idEmisor=null;
    public $detalleFactura = [];
    public $detalleOrden = [];
    public $datosReceptor = [];
    public $datosEntidad = [];
    public $lista= [];// Se usa para retornar los detalles de una factura
    public $consecutivo= [];
    public $usuario="";
    public $bodega="";
    public $plazoCredito= null;
    public $idCodigoMoneda= null;
    public $tipoCambio= null;
    public $montoEfectivo= null;
    public $montoTarjeta= null;
    //
    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            //Necesarias para la factura (Segun M Hacienda)
            require_once("UUID.php");
            // a. Datos de encabezado
            $this->id= $obj["id"] ?? UUID::v4();     
            $this->fechaCreacion= $obj["fechaCreacion"] ?? null;  //  fecha de creacion en base de datos 
            $this->idBodega= $obj["idBodega"] ?? $_SESSION["userSession"]->idBodega;
            $this->consecutivo= $obj["consecutivo"] ?? null;
            $this->local= $obj["local"] ?? $_SESSION["userSession"]->local;
            $this->terminal= $obj["terminal"] ?? '00001';
            $this->idCondicionVenta= $obj["idCondicionVenta"] ?? 1;
            $this->idSituacionComprobante= $obj["idSituacionComprobante"] ?? 1;
            $this->idEstadoComprobante= $obj["idEstadoComprobante"] ?? 1;
            $this->plazoCredito= $obj["plazoCredito"] ?? 0;
            $this->idMedioPago= $obj["idMedioPago"] ?? 1;
            // c. Resumen de la factura/Total de la Factura 
            // definir si es servicio o mercancia (producto). En caso Tropical, siempre es mercancia
            $this->idCodigoMoneda= $obj["idCodigoMoneda"] ?? 55; // CRC
            $this->tipoCambio= $obj['tipoCambio'] ?? 582.83; // tipo de cambio dinamico con BCCR
            $this->totalServGravados= $obj['totalServGravados'];
            $this->totalServExentos= $obj['totalServExentos'];
            $this->totalMercanciasGravadas= $obj['totalMercanciasGravadas'];
            $this->totalMercanciasExentas= $obj['totalMercanciasExentas'];
            $this->totalGravado= $obj['totalGravado'];
            $this->totalExento= $obj['totalExento'];
            $this->totalVenta= $obj["totalVenta"];
            $this->totalDescuentos= $obj["totalDescuentos"];
            $this->totalVentaneta= $obj["totalVentaneta"];
            $this->totalImpuesto= $obj["totalImpuesto"];
            $this->totalComprobante= $obj["totalComprobante"];
            $this->montoEfectivo= $obj["montoEfectivo"];
            $this->montoTarjeta= $obj["montoTarjeta"];
            // d. Informacion de referencia
            $this->codigoReferencia = $obj["codigoReferencia"] ?? 1; //codigo de documento de Referencia. Tropical tiene el documento por defecto 1
            $this->fechaEmision= $obj["fechaEmision"] ?? null; // emision del comprobante electronico.
            //
            $this->idReceptor = $obj['idReceptor'] ?? Receptor::default()->id; // si es null, utiliza el Receptor por defecto.
            $this->idEmisor =  $_SESSION["userSession"]->idEntidad;  //idEmisor no es necesario, es igual al idEntidad.
            $this->idUsuario=  $_SESSION["userSession"]->id;   
            //
            if(isset($obj["detalleFactura"] )){
                foreach ($obj["detalleFactura"] as $itemDetalle) {
                    // b. Detalle de la mercancía o servicio prestado
                    $item= new ProductoXFactura();
                    $item->idFactura = $this->id;
                    $item->idPrecio= $itemDetalle['idPrecio'];
                    $item->numeroLinea= $itemDetalle['numeroLinea'];
                    $item->idTipoCodigo= $itemDetalle['idTipoCodigo']?? 1;
                    $item->codigo= $itemDetalle['codigo'] ?? 999;
                    $item->cantidad= $itemDetalle['cantidad'] ?? 1;
                    $item->idUnidadMedida= $itemDetalle['idUnidadMedida'] ?? 78;
                    $item->detalle= $itemDetalle['detalle'];
                    $item->precioUnitario= $itemDetalle['precioUnitario'];                    
                    $item->montoTotal= $itemDetalle['montoTotal'];
                    $item->montoDescuento= $itemDetalle['montoDescuento'];
                    $item->naturalezaDescuento= $itemDetalle['naturalezaDescuento']??'No aplican descuentos'; // en Tropical no se manejan descuentos
                    $item->subTotal= $itemDetalle['subTotal'];
                    $item->idExoneracionImpuesto= $itemDetalle['idExoneracionImpuesto'] ?? null;
                    $item->codigoImpuesto= $itemDetalle['codigoImpuesto'] ?? 1; // impuesto ventas = 1
                    $item->tarifaImpuesto= $itemDetalle['tarifaImpuesto'];
                    $item->montoImpuesto= $itemDetalle['montoImpuesto'];                    
                    $item->montoTotalLinea= $itemDetalle['montoTotalLinea']; // subtotal + impuesto.
                    array_push ($this->detalleFactura, $item);
                }
            }
            // detalle de orden para presentar en pantalla de 
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

            if(isset($_POST["dataReceptor"] )){
                $this->datosReceptor = new Receptor();
                $this->datosReceptor = json_decode($_POST["dataReceptor"],true);
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT f.id, f.consecutivo, f.fechaCreacion, f.totalComprobante, f.montoEfectivo, f.montoTarjeta, b.nombre, u.userName, idEstadoComprobante
                FROM factura f
                INNER JOIN bodega b on f.idBodega = b.id
                INNER JOIN usuario u on u.id = f.idusuario   
                ORDER BY f.consecutivo asc';
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

    function ReadAllById(){
        try {
            $sql='SELECT f.id, f.consecutivo, f.fechaCreacion, f.totalComprobante, f.montoEfectivo, f.montoTarjeta, b.nombre, u.userName
                FROM factura f
                INNER JOIN bodega b on f.idBodega = b.id
                INNER JOIN usuario u on u.id = f.idusuario
                WHERE f.idUsuario =:idUsuario
                ORDER BY f.consecutivo asc';
            $param= array(':idUsuario'=>$_SESSION["userSession"]->id);
            $data = DATA::Ejecutar($sql,$param);
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
            $sql='SELECT idBodega, fechaCreacion, consecutivo, clave, consecutivoFE, local, terminal, idCondicionVenta, idSituacionComprobante, idEstadoComprobante, plazoCredito, 
                idMedioPago, idCodigoMoneda, tipoCambio, totalServGravados, totalServExentos, totalMercanciasGravadas, totalMercanciasExentas, totalGravado, totalExento, fechaEmision, codigoReferencia, 
                totalVenta, totalDescuentos, totalVentaneta, totalImpuesto, totalComprobante, idReceptor, idEmisor, idUsuario
                from factura
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);     
            foreach ($data as $key => $value){
                $this->idBodega = $value['idBodega'];
                $this->bodega = $_SESSION["userSession"]->bodega; // nombre de la bodega.
                $this->fechaCreacion = $value['fechaCreacion'];
                $this->consecutivo = $value['consecutivo'];
                $this->clave = $value['clave'] ?? null;
                $this->consecutivoFE = $value['consecutivoFE'] ?? null;
                $this->local = $value['local'];
                $this->terminal = $value['terminal'];
                $this->idCondicionVenta = $value['idCondicionVenta'];
                $this->idSituacionComprobante = $value['idSituacionComprobante'];
                $this->idEstadoComprobante = $value['idEstadoComprobante'];
                $this->plazoCredito = $value['plazoCredito'];
                $this->idMedioPago = $value['idMedioPago'];
                $this->idCodigoMoneda = $value['idCodigoMoneda'];
                $this->tipoCambio = $value['tipoCambio'];
                $this->totalServGravados = $value['totalServGravados'];
                $this->totalServExentos = $value['totalServExentos'];
                $this->totalMercanciasGravadas = $value['totalMercanciasGravadas'];
                $this->totalMercanciasExentas = $value['totalMercanciasExentas'];
                $this->totalGravado = $value['totalGravado'];
                $this->totalExento = $value['totalExento'];
                $this->fechaEmision = $value['fechaEmision'];
                $this->codigoReferencia = $value['codigoReferencia'];
                $this->totalVenta = $value['totalVenta'];
                $this->totalDescuentos = $value['totalDescuentos'];
                $this->totalVentaneta = $value['totalVentaneta'];
                $this->totalImpuesto = $value['totalImpuesto'];
                $this->totalComprobante = $value['totalComprobante'];
                $this->idReceptor = $value['idReceptor'];
                $this->idEmisor = $value['idEmisor'];
                $this->idUsuario = $value['idUsuario'];
                // $this->usuario =  nombre de la persona que hizo la transaccion
                $this->detalleFactura= ProductoXFactura::ReadByIdFactura($this->id);
                $receptor = new Receptor();
                $receptor->id = $this->idReceptor;
                $this->datosReceptor = $receptor->read();
                $entidad = new Entidad();
                $entidad->id = $this->idEntidad;
                $this->datosEntidad = $entidad->read();
            }
            return $this;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el factura'))
            );
        }
    }

    function ReadVentas(){
        try {
            $sql='SELECT f.id, f.fechaCreacion, f.consecutivo, f.totalComprobante,
            (SELECT count(pxf.codigo) FROM tropical.productosXFactura pxf WHERE pxf.codigo="12oz" AND pxf.idFactura=f.id) AS _12oz, 
            (SELECT count(pxf.codigo) FROM tropical.productosXFactura pxf WHERE pxf.codigo="08oz" AND pxf.idFactura=f.id) AS _08oz 
            FROM tropical.factura f ORDER BY f.fechaCreacion DESC;';
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

    private function perfildeContribuyente($apiloging=true){
        // Inicia sesión de API.
        $cliente= new ClienteFE();
        if($cliente->Check())
            $cliente->ReadProfile($apiloging);
        else {
            // retorna warning de facturacion sin contribuyente.
            echo json_encode(array(
                'code' => 000 ,
                'msg' => 'NOCONTRIB')
            );
            exit;
        }
    }

    function EnviarFE(){
        try {
            // consulta datos de factura en bd.
            $this->Read();
            $this->perfildeContribuyente();
            // envía la factura
            FacturaElectronica::Iniciar($this);
        }
        catch(Exception $e){}
    }

    function Create(){
        try {
            $sql="INSERT INTO factura   (id, idBodega, local, terminal, idCondicionVenta, idSituacionComprobante, idEstadoComprobante, plazoCredito, 
                idMedioPago, idCodigoMoneda, tipoCambio, totalServGravados, totalServExentos, totalMercanciasGravadas, totalMercanciasExentas, totalGravado, totalExento, codigoReferencia, 
                totalVenta, totalDescuentos, totalVentaneta, totalImpuesto, totalComprobante, idReceptor, idEmisor, idUsuario, montoEfectivo)
            VALUES  (:uuid, :idBodega, :local, :terminal, :idCondicionVenta, :idSituacionComprobante, :idEstadoComprobante, :plazoCredito,
                :idMedioPago, :idCodigoMoneda, :tipoCambio, :totalServGravados, :totalServExentos, :totalMercanciasGravadas, :totalMercanciasExentas, :totalGravado, :totalExento, :codigoReferencia, 
                :totalVenta, :totalDescuentos, :totalVentaneta, :totalImpuesto, :totalComprobante, :idReceptor, :idEmisor, :idUsuario, :montoEfectivo)";
            $param= array(':uuid'=>$this->id,
                ':idBodega'=>$this->idBodega,
                ':local'=>$this->local,
                ':terminal'=>$this->terminal,
                ':idCondicionVenta'=>$this->idCondicionVenta,
                ':idSituacionComprobante'=>$this->idSituacionComprobante,
                ':idEstadoComprobante'=>$this->idEstadoComprobante,
                ':plazoCredito'=> $this->plazoCredito,                    
                ':idMedioPago'=>$this->idMedioPago,
                ':idCodigoMoneda'=>$this->idCodigoMoneda,
                ':tipoCambio'=>$this->tipoCambio,
                ':totalServGravados'=> $this->totalServGravados,
                ':totalServExentos'=> $this->totalServExentos,
                ':totalMercanciasGravadas'=> $this->totalMercanciasGravadas,
                ':totalMercanciasExentas'=> $this->totalMercanciasExentas,
                ':totalGravado'=> $this->totalGravado,
                ':totalExento'=> $this->totalExento,
                ':codigoReferencia'=> $this->codigoReferencia,
                ':totalVenta'=>$this->totalVenta,
                ':totalDescuentos'=>$this->totalDescuentos,
                ':totalVentaneta'=>$this->totalVentaneta,
                ':totalImpuesto'=>$this->totalImpuesto,
                ':totalComprobante'=>$this->totalComprobante,
                ':idReceptor'=>$this->idReceptor,
                ':idEmisor'=>$this->idEmisor,
                ':idUsuario'=>$this->idUsuario,
                ':montoEfectivo'=>$this->montoEfectivo);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
            {
                 //save array obj
                 if(ProductoXFactura::Create($this->detalleFactura)){
                    $this->actualizaInventario($this->detalleOrden);
                    // orden de factura para mostrar en despacho.
                    OrdenXFactura::$id=$this->id;
                    OrdenXFactura::Create($this->detalleOrden);
                    // envio de comprobantes en tiempo real.
                    $this->EnviarFE();         
                    return $this;
                }
                else throw new Exception('Error al guardar los productos.', 03);
            }
            else throw new Exception('Error al guardar.', 02);
        }     
        catch(Exception $e) {
            error_log("error: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public static function updateEstado($idFactura, $idEstadoComprobante, $fechaEmision){
        try {
            $sql="UPDATE factura
                SET idEstadoComprobante=:idEstadoComprobante, fechaEmision=:fechaEmision
                WHERE id=:idFactura";
            $param= array(':idFactura'=>$idFactura, ':idEstadoComprobante'=>$idEstadoComprobante, ':fechaEmision'=>$fechaEmision);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
                return true;
            else throw new Exception('Error al guardar el histórico.', 03);            
        }     
        catch(Exception $e) {
            error_log("error: ". $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    function actualizaInventario($insumos){
        foreach ($insumos as $key => $value){
            // resta inventario sabor y topping.             
            if($value->idTamano==0)
                $porcion= 1;
            else $porcion= 1.4285714;
            InventarioInsumoXBodega::salida($value->idSabor1, 'ordenXX', $porcion);
            InventarioInsumoXBodega::salida($value->idSabor2, 'ordenXX', $porcion);
            InventarioInsumoXBodega::salida($value->idTopping, 'ordenXX', 1);
            // resta inventario consumibles.
            consumible::salida($value->idTamano);
        };
    }

    function TicketPrint($data){
        try {
            
            // $connector = new WindowsPrintConnector('/dev/usb/lp0');
            $connector = new FilePrintConnector("/dev/usb/lp0");
            $printer = new Printer($connector);
            $total=0;
            $printer->setJustification(Printer::JUSTIFY_CENTER);
            $printer->text("\n------------------------------------------------");
            $printer->text("\n"."TROPICAL SNO".$data->bodega);
            $printer->text("\n------------------------------------------------");
            $printer->text("\n"."3-102-655700,  S.R.L.");
            $printer->text("\n"."Tel.2245-0515, Fax: 2297-0998");
            $printer->text("\n"."Factura #:". $data->consecutivo);
            $printer->text("\n"."Fecha :". $data->fechaCreacion);
            $printer->text("\n"."Usuario :". $data->usuario."\n");
            $printer->text("\n------------------------------------------------");
            $printer->text("\n"."CN    "."DETALLE                "."PRECIO    "."TOTAL     ");
            $printer->text("\n------------------------------------------------");
            for ($i=0; $i < count($data->detalleFactura); $i++) { 
                $printer->text("\n"."1         ".$data->detalleFactura[$i]->detalle."  ".$data->detalleFactura[$i]->precioUnitario);
                $total = $total +  $data->detalleFactura[$i]->precioUnitario;
            }
            $printer->text("\n------------------------------------------------");
            $printer->text("\n"."Total I.V.I                            ". $total.".00"); 
            $printer->text("\n"."Tipo de Pago:------------------------------------");
            $printer->text("\n"."      Efectivo:                        ". $total.".00");
            $printer->text("\n"."      Vuelto:                          ". $total.".00");
            $printer->text("\n"."      Dif:                             ". $total.".00");
            $printer->text("\n"."Tarjeta de Credito:                    ". $total.".00\n");
            $printer->text("\n------------------------------------------------");
            $printer->text("\n"."Gracias por su Compra                        ");
            $printer->text("\n"."Una vez facturado no se aceptan cambios o    ");
            $printer->text("\n"."devoluciones.                                \n");
            $printer->text("\n"."Autorizado para impresión mediante           ");
            $printer->text("\n"."Resolución 48-2016 de DGTD                   \n");
            $printer->text("\n"."Autorizado para impresión mediante           ");
            $printer->text("\n"."Resolución 48-2016 de DGTD                   ");
            $printer->text("\n"."Visitenos en Facebook:  TSCR y déjenos sus   ");
            $printer->text("\n"."comentarios.                                 ");
            $printer->feed(3);
            $printer->cut();            
            $printer->pulse();
            $printer->close();

            return true;
            }     
            catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
                header('HTTP/1.0 777 Bad error');
                die(json_encode(array(
                    'code' => $e->getCode() ,
                    'msg' => 'Error al imprimir factura'))
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
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function LoadPreciosTamanos(){
        try{     
            // require_once("Rol.php");
            // require_once("Bodega.php");

            $sql="SELECT id, tamano, precioVenta FROM preciosXBodega where idBodega = :idBodega;";
            $param= array(':idBodega'=>$_SESSION["userSession"]->idBodega);
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
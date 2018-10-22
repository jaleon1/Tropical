<?php
date_default_timezone_set('America/Costa_Rica');
error_reporting(1);

if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Usuario.php");
    require_once("ClienteFE.php");
    require_once("Receptor.php");
    require_once("facturacionElectronica.php");
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
        case "Update":
            $factura->Update();
            break;
        case "Delete":
            echo json_encode($factura->Delete());
            break;   
        case "LoadPreciosTamanos":
            echo json_encode($factura->LoadPreciosTamanos());
            break;
        case "sendContingencia":
            // $factura->sendContingencia();
            break;
        case "sendNotaCredito":
            // Nota de Credito.
            $factura->idDocumentoNC= $_POST["idDocumentoNC"] ?? 3; // documento tipo 3: NC
            $factura->idReferencia= $_POST["idReferencia"] ?? 1; // código de referencia: 1 : Referencia a otro documento.
            $factura->razon= $_POST["razon"]; // Referencia a otro documento.
            $factura->notaCredito();
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
    public $idDocumento = null; // FE - TE - ND - NC ...  documento para envio MH
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
    // Referencia
    public $idDocumentoReferencia = null; // utilizado en COMPROBANTE EMITIDO DESPUES DE UNA NC.
    public $claveReferencia = null;
    public $fechaEmisionReferencia = null;
    // NC
    public $idDocumentoNC = null;
    public $claveNC = null;
    public $idReferencia = null;
    public $fechaEmisionNC = null;
    public $razon=null;
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
            $this->montoEfectivo= $obj["montoEfectivo"] ?? null;
            $this->montoTarjeta= $obj["montoTarjeta"] ?? null;
            // d. Informacion de referencia
            $this->idDocumento = $obj["idDocumento"] ?? 1;//$_SESSION["userSession"]->idDocumento; // Documento de Referencia.
            $this->fechaEmision= $obj["fechaEmision"] ?? null; // emision del comprobante electronico.
            //
            $this->idReceptor = $obj['idReceptor'] ?? Receptor::default()->id; // si es null, utiliza el Receptor por defecto.
            $this->idEmisor =  $_SESSION["userSession"]->idBodega;  //idEmisor no es necesario, es igual al idBodega.
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
            //
            if(isset($_POST["dataReceptor"] )){
                $this->datosReceptor = new Receptor();
                $this->datosReceptor = json_decode($_POST["dataReceptor"],true);
            }
            // Referencias.
            if(isset($obj["ref"] )){
                foreach ($obj["ref"] as $ref) {
                    $factura->idDocumentoNC= $ref["idDocumentoNC"]; // documento al que se hace referencia.
                    $factura->idReferencia= $ref["idReferencia"]; // código de referencia: 4 : Referencia a otro documento.
                    $factura->razon= $ref["razon"]; // Referencia a otro documento.
                }                
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT f.id, f.consecutivo, f.fechaCreacion, f.totalComprobante, f.montoEfectivo, f.montoTarjeta, b.nombre, u.userName, f.idEstadoComprobante
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
            $sql='SELECT f.id, f.consecutivo, f.fechaCreacion, f.totalComprobante, f.montoEfectivo, f.montoTarjeta, b.nombre, u.userName, f.idEstadoComprobante
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
                idMedioPago, idCodigoMoneda, tipoCambio, totalServGravados, totalServExentos, totalMercanciasGravadas, totalMercanciasExentas, totalGravado, totalExento, fechaEmision, idDocumento, 
                totalVenta, totalDescuentos, totalVentaneta, totalImpuesto, totalComprobante, idReceptor, idEmisor, idUsuario, idDocumentoNC, claveNC, fechaEmisionNC,
                    idReferencia, razon, idEstadoNC
                from factura
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);     
            foreach ($data as $key => $value){
                $this->idBodega = $value['idBodega'];
                //$this->bodega =  // nombre de la bodega.
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
                $this->idDocumento = $value['idDocumento'];                
                $this->totalVenta = $value['totalVenta'];
                $this->totalDescuentos = $value['totalDescuentos'];
                $this->totalVentaneta = $value['totalVentaneta'];
                $this->totalImpuesto = $value['totalImpuesto'];
                $this->totalComprobante = $value['totalComprobante'];
                $this->idReceptor = $value['idReceptor'];
                $this->idEmisor = $value['idEmisor'];
                $this->idUsuario = $value['idUsuario'];
                $this->idDocumentoNC = $value['idDocumentoNC'];
                $this->claveNC = $value['claveNC'];
                $this->fechaEmisionNC = $value['fechaEmisionNC'];
                $this->idReferencia = $value['idReferencia'];
                $this->razon = $value['razon'];
                $this->idEstadoNC = $value['idEstadoNC'];
                // $this->usuario =  nombre de la persona que hizo la transaccion
                $this->detalleFactura= ProductoXFactura::ReadByIdFactura($this->id);
                $receptor = new Receptor();
                $receptor->id = $this->idReceptor;
                $this->datosReceptor = $receptor->read();
                $entidad = new ClienteFE();
                $entidad->idBodega = $this->idBodega;
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

    function enviarDocumentoElectronico(){
        try {
            // consulta datos de factura en bd.
            $this->Read();
            // envía la factura
            FacturacionElectronica::Iniciar($this);
        }
        catch(Exception $e){}
    }

    function Create(){
        try {
            $sql="INSERT INTO factura   (id, idBodega, local, terminal, idCondicionVenta, idSituacionComprobante, idEstadoComprobante, plazoCredito, 
                idMedioPago, idCodigoMoneda, tipoCambio, totalServGravados, totalServExentos, totalMercanciasGravadas, totalMercanciasExentas, totalGravado, totalExento, idDocumento, 
                totalVenta, totalDescuentos, totalVentaneta, totalImpuesto, totalComprobante, idReceptor, idEmisor, idUsuario, montoEfectivo)
            VALUES  (:uuid, :idBodega, :local, :terminal, :idCondicionVenta, :idSituacionComprobante, :idEstadoComprobante, :plazoCredito,
                :idMedioPago, :idCodigoMoneda, :tipoCambio, :totalServGravados, :totalServExentos, :totalMercanciasGravadas, :totalMercanciasExentas, :totalGravado, :totalExento, :idDocumento, 
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
                ':idDocumento'=> $this->idDocumento,
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
                    $this->enviarDocumentoElectronico();         
                    return $this;
                }
                else throw new Exception('[ERROR] al guardar los productos.', 03);
            }
            else throw new Exception('[ERROR] al guardar.', 02);
        }     
        catch(Exception $e) {
            error_log("[ERROR]: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public static function setClave($documento, $idFactura, $clave, $consecutivoFE=null){
        try {
            $sql='';
            $param= [];
            switch($documento){
                case 1: //fe
                case 4: //te
                case 8: //contingencia
                    $sql="UPDATE factura
                        SET clave=:clave, consecutivoFE=:consecutivoFE
                        WHERE id=:idFactura";
                    $param= array(':idFactura'=>$idFactura, ':clave'=>$clave, ':consecutivoFE'=>$consecutivoFE);
                break;
                case 3: // NC
                    $sql="UPDATE factura
                        SET claveNC=:claveNC
                        WHERE id=:idFactura";
                    $param= array(':idFactura'=>$idFactura, ':claveNC'=>$clave);
                break;
            }
            //
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
                return true;
            else throw new Exception('Error al guardar el histórico.', 03);            
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    public static function updateEstado($documento, $idFactura, $idEstadoComprobante, $fechaEmision){
        try {
            $sql='';
            $param= [];
            switch($documento){
                case 1: //fe
                case 4: //te
                case 8: //contingencia                
                    $sql="UPDATE factura
                        SET idEstadoComprobante=:idEstadoComprobante, fechaEmision=:fechaEmision
                        WHERE id=:idFactura";
                    $param= array(':idFactura'=>$idFactura, ':idEstadoComprobante'=>$idEstadoComprobante, ':fechaEmision'=>$fechaEmision);
                break;
                case 3: // NC
                    $sql="UPDATE factura
                        SET idEstadoNC=:idEstadoNC, fechaEmisionNC=:fechaEmisionNC
                        WHERE id=:idFactura";
                    $param= array(':idFactura'=>$idFactura, ':idEstadoNC'=>$idEstadoComprobante, ':fechaEmisionNC'=>$fechaEmision);
                break;
            }
            //
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
                return true;
            else throw new Exception('Error al guardar el histórico.', 03);            
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    public static function updateIdEstadoComprobante($idFactura, $documento, $idEstadoComprobante){
        try {
            $sql='';
            $param= [];
            switch($documento){
                case 1: //fe
                case 4: //te
                case 8: //contingencia                
                    $sql="UPDATE factura
                        SET idEstadoComprobante=:idEstadoComprobante
                        WHERE id=:idFactura";
                    $param= array(':idFactura'=>$idFactura, ':idEstadoComprobante'=>$idEstadoComprobante);
                break;
                case 3: // NC
                    $sql="UPDATE factura
                        SET idEstadoNC=:idEstadoNC
                        WHERE id=:idFactura";
                    $param= array(':idFactura'=>$idFactura, ':idEstadoNC'=>$idEstadoComprobante);
                break;
            }
            //
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
                return true;
            else throw new Exception('Error al actualizar el estado del comprobante.', 0456);            
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
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
            Consumible::salida($value->idTamano);
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

    public function sendContingencia(){
        // busca facturas con error (5) y las reenvia con contingencia, para los documentos 1 - 4  (FE - TE)
        error_log("************************************************************");
        error_log("************************************************************");
        error_log("     [INFO] Iniciando Ejecucíon masiva de contingencia      ");
        error_log("************************************************************");
        error_log("************************************************************");
        $sql="SELECT f.id, b.nombre as entidad, consecutivo
            from factura f inner join bodega b on b.id = f.idBodega
            WHERE  f.idEstadoComprobante = 5 and (f.idDocumento = 1 or  f.idDocumento = 4 or  f.idDocumento = 8) 
            ORDER BY consecutivo asc";
            //idBodega=:idBodega and
        // $param= array(':idBodega'=>'0cf4f234-9479-4dcb-a8c0-faa4efe82db0');
        // $param= array(':idBodega'=>'f787b579-8306-4d68-a7ba-9ae328975270'); // carlos.echc11.
        $data = DATA::Ejecutar($sql);
        error_log("[INFO] Total de transacciones en Contingencia: ". count($data));
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Contingencia Entidad (". $transaccion['entidad'] .") Transaccion (".$transaccion['consecutivo'].")");
            $this->id = $transaccion['id'];
            $this->contingencia();                
        }
        error_log("[INFO] Finaliza Contingencia Masiva de Comprobantes");
    }

    public function contingencia(){
        try {
            // idDocumento 08 = Comprobante emitido en contingencia.
            // SituacionComprobante 02 = Contingencia
            // Estado de Comprobante 01 = Sin enviar.
            $sql="UPDATE factura
                SET idSituacionComprobante=:idSituacionComprobante , idDocumento=:idDocumento, idEstadoComprobante=:idEstadoComprobante
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':idSituacionComprobante'=>2 , ':idDocumento'=>8, ':idEstadoComprobante'=>1);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data){
                // lee la transaccion completa y re envia
                $this->enviarDocumentoElectronico();                
                return true;
            }
            else throw new Exception('Error al actualizar la situación del comprobante en Contingencia.', 45656);            
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public function notaCredito(){
        try {
            // check si ya existe la NC.
            $sql="SELECT id
                FROM factura
                WHERE id=:id and (idEstadoNC IS NULL OR idEstadoNC = 5 OR idEstadoNC = 1)";
            $param= array(':id'=>$this->id);
            $data = DATA::Ejecutar($sql,$param);
            // si hay comprobante sin NC, continua:
            if($data){
                // actualiza estado de comprobante con NC.
                $sql="UPDATE factura
                    SET idDocumentoNC=:idDocumentoNC, idReferencia=:idReferencia, razon=:razon, idEstadoNC=:idEstadoNC
                    WHERE id=:id";
                $param= array(
                    ':id'=>$this->id,
                    ':idDocumentoNC'=>$this->idDocumentoNC,
                    ':idReferencia'=>$this->idReferencia,
                    ':razon'=>$this->razon,
                    ':idEstadoNC'=>1);
                $data = DATA::Ejecutar($sql,$param, false);
                if($data)
                {
                    $this->read();
                    // envía la factura
                    FacturacionElectronica::iniciarNC($this);
                    return true;
                }
                else throw new Exception('Error al guardar.', 02);
            } else throw new Exception('Warning, el comprobante ('. $this->id .') ya tiene una Nota de Crédito asignada.', 0763);
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
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
            // ANTES DE CARGAR PRECIOS, VALIDA EL PERFIL DEL CONTRIBUYENTE
            $clientefe = new CLienteFE();
            if ($clientefe->checkProfile()){
                //
                $sql="SELECT id, tamano, precioVenta FROM preciosXBodega where idBodega = :idBodega;";
                $param= array(':idBodega'=>$_SESSION["userSession"]->idBodega);
                $data= DATA::Ejecutar($sql,$param);            
                if(count($data))
                    return $data;
                else return false;
            }
            return "NOCONTRIB";
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
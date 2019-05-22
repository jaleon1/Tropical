<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);

if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Usuario.php");
    require_once("ProductosXDistribucion.php");
    require_once('Factura.php');
    require_once('Receptor.php');
    require_once('facturacionElectronica.php');
    require_once('InventarioInsumoXBodega.php');
    require_once("Bodega.php");
    require_once("ClienteFE.php");
    require_once("encdes.php");
    require_once("InventarioProducto.php");
    require_once("mensajeReceptor.php");
    require_once("Bodega.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $distribucion= new Distribucion();
    switch($opt){
        case "ReadAll":
            echo json_encode($distribucion->ReadAll());
            break;
        case "Read":
            echo json_encode($distribucion->Read());
            break;
        case "ReadbyOrden":
            $distribucion->idBodega= $_SESSION["userSession"]->idBodega;
            $distribucion->orden= $_POST["orden"];
            echo json_encode($distribucion->ReadbyOrden());
            break;
        case "Create":
            if(!$distribucion->esInterna){
                if($distribucion->datosReceptor == null){
                    echo json_encode("NORECEPTOR");
                    return false;
                }
                if($distribucion->datosEntidad == null){
                    echo json_encode("NOCONTRIB");
                    return false;
                }
            }
            echo json_encode($distribucion->Create());
            break;
        case "Update":
            $distribucion->Update();
            break;
        case "Delete":
            $distribucion->orden= $_POST["orden"];
            $distribucion->Delete();
            break;  
        case "Aceptar":
            $distribucion->Aceptar(true);
            break;   
        case "ReadAllbyRange":
            echo json_encode($distribucion->ReadAllbyRange());
            break;
        case "ReadCancelada":
            echo json_encode($distribucion->ReadCancelada());
            break;
        case "cancelaDistribucion":
            $distribucion->cancelaDistribucion($_POST['id'], $_POST['razon']);
            break;
        case "sendContingenciaMasiva":
            $distribucion->sendContingenciaMasiva();
            break;
        case "sendContingencia":
            $distribucion->sendContingencia();
        break;
    }
}

class Distribucion{
    public $id=null;
    public $fecha='';
    public $idBodega=null;
    public $bodega=null;
    public $orden='';
    public $idUsuario=null;
    public $porcentajeDescuento=0;
    public $porcentajeIva=null;
    public $esInterna=true;
    public $lista= [];
    // para comprobante externo.
    public $detalleFactura= []; 
    public $datosReceptor = [];
    public $datosEntidad = [];
    public $fechaInicial='';
    public $fechaFinal='';
    public $totalServGravados = null;
    public $razon = null;
    public $consecutivo = null;
    public $clave='';

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            unset($_POST['obj']);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->idBodega= $obj["idBodega"];
            $this->orden= $obj["orden"] ?? '';
            // $this->porcentajeDescuento= $obj["porcentajeDescuento"] ?? 0;
            $this->porcentajeIva= $obj["porcentajeIva"] ?? '13';
            //$this->idUsuario= $obj["idUsuario"] ?? null;
            // comprobante electronico para bodega externa.
            $this->fechaCreacion= $obj["fechaCreacion"] ?? null;  //  fecha de creacion en base de datos.
            //$this->idEntidad= $obj["idEntidad"] ?? $_SESSION["userSession"]->idEntidad;            
            $this->consecutivo= $this->orden;
            $this->local= '001';//$obj["local"] ?? $_SESSION["userSession"]->local;
            $this->terminal= '00001'; //$obj["terminal"] ?? $_SESSION["userSession"]->terminal;
            $this->idCondicionVenta= 1;
            $this->idSituacionComprobante= 1;
            $this->idEstadoComprobante= 1;
            $this->plazoCredito= 0;
            $this->idMedioPago= 1;
            // c. Resumen de la factura/Total de la Factura 
            // definir si es servicio o mercancia (producto).
            $this->idCodigoMoneda= 55; // CRC
            $this->tipoCambio= 595.00; // tipo de cambio dinamico con BCCR
            $this->totalServGravados= number_format((float)$obj['totalServGravados'],5,'.','' ) ?? null;
            $this->totalServExentos= number_format((float)$obj['totalServExentos'],5,'.','' )  ?? null;
            $this->totalMercanciasGravadas= number_format((float)$obj['totalMercanciasGravadas'],5,'.','' )  ?? null;
            $this->totalMercanciasExentas= number_format((float)$obj['totalMercanciasExentas'],5,'.','' )  ?? null;
            $this->totalGravado= number_format((float)$obj['totalGravado'],5,'.','' )  ?? null;
            $this->totalExento= number_format((float)$obj['totalExento'],5,'.','' )  ?? null;
            $this->totalVenta= number_format((float)$obj['totalVenta'],5,'.','' )  ?? null;
            $this->totalDescuentos= number_format((float)$obj['totalDescuentos'],5,'.','' )   ?? null;;
            $this->totalVentaneta= number_format((float)$obj['totalVentaneta'],5,'.','' )   ?? null;
            $this->totalImpuesto= number_format((float)$obj['totalImpuesto'],5,'.','' )   ?? null;
            $this->totalComprobante= number_format((float)$obj['totalComprobante'],5,'.','' )   ?? null;
            // $this->montoEfectivo= $obj["montoEfectivo"]; //Jason: Lo comente temporalmente
            // $this->montoTarjeta= $obj["montoTarjeta"];   //Jason: Lo comente temporalmente
            // d. Informacion de referencia
            $this->idDocumento = 1; // Documento de Referencia.            
            $this->fechaEmision= $obj["fechaEmision"] ?? null; // emision del comprobante electronico.
            //
            $this->idReceptor = $obj['idReceptor'] ?? Receptor::default()->id; // si es null, utiliza el Receptor por defecto.
            $this->idUsuario=  $_SESSION["userSession"]->id;
            $this->fechaInicial= $obj["fechaInicial"] ?? null;
            $this->fechaFinal= $obj["fechaFinal"] ?? null;
            // si la bodega es externa, tiene que estar el ClienteFE (receptor) registrado.
            $central = new Bodega();
            $central->readCentral();
            $this->idEmisor =  $central->id;
            $externa = new Bodega();
            $externa->ReadbyId($obj["idBodega"]); // bodega receptor.
            if($externa->tipo != $central->tipo){
                $this->esInterna= false;
                // receptor
                $receptor = new ClienteFE();
                $receptor->idBodega = $this->idReceptor;
                $this->datosReceptor = $receptor->read();
                // emisor - Central.
                $entidad = new ClienteFE();
                $entidad->idBodega = $central->id;
                $this->datosEntidad = $entidad->read();
            }
            //
            // lista.
            if(isset($obj["detalleFactura"] )){
                require_once("ProductosXDistribucion.php");
                require_once("productoXFactura.php");
                //
                foreach ($obj["detalleFactura"] as $itemlist) {
                    // b. Detalle de la mercancía o servicio prestado
                    $item= new ProductosXDistribucion();
                    $item->idDistribucion= $this->id;
                    $item->idProducto= $itemlist['idProducto'];                    
                    $item->cantidad= $itemlist['cantidad'];
                    $item->valor= $itemlist['valor'];
                    //array_push ($this->lista, $item);
                    //$item= new ProductoXFactura();
                    $item->numeroLinea= $itemlist['numeroLinea'];
                    $item->idTipoCodigo= $itemlist['idTipoCodigo']?? 1;
                    $item->codigo= $itemlist['codigo'] ?? 999;
                    $item->cantidad= $itemlist['cantidad'] ?? 1;
                    $item->idUnidadMedida= $itemlist['idUnidadMedida'] ?? 78;
                    $item->detalle= $itemlist['detalle'];
                    $item->precioUnitario= $itemlist['precioUnitario'];
                    $item->montoTotal= $itemlist['montoTotal'];
                    $item->montoDescuento= $itemlist['montoDescuento'];
                    $item->naturalezaDescuento= $itemlist['naturalezaDescuento']??'No aplican descuentos'; // en Tropical no se manejan descuentos
                    $item->subTotal= $itemlist['subTotal'];
                    $item->idExoneracionImpuesto= $itemlist['idExoneracionImpuesto'] ?? null;
                    $item->codigoImpuesto= $itemlist['codigoImpuesto'] ?? 1; // impuesto ventas = 1
                    $item->tarifaImpuesto= $itemlist['tarifaImpuesto'];
                    $item->montoImpuesto= $itemlist['montoImpuesto'];                    
                    $item->montoTotalLinea= $itemlist['montoTotalLinea']; // subtotal + impuesto.
                    array_push ($this->detalleFactura, $item);
                }
            }
        }
    }

    function reGenerarFactura(){
        try {
            $nueva_factura = $this->Read();
            // referencia a la fatura cancelada.
            $item = new Referencia();
            $item->tipodoc= '01';  // factura electronica.
            $item->numero= $this->clave;
            $item->razon= 'Sustituye comprobante rechazado.'; 
            $item->fechaEmision= $this->fechaEmision ?? date_create(); 
            $item->codigo= '04';  // Referencia a otro documento. Al documento que se rechazó.
            array_push ($this->informacionReferencia, $item);
            //
            $sql="SELECT claveNC
                FROM distribucion
                WHERE id=:id";
            $param= array(':id'=>$this->id);
            $idNC = DATA::Ejecutar($sql,$param);

            $this->id = UUID::v4();
            $this->idDocumentoNC = NULL;

            foreach ($this->detalleFactura as $key=>$item) {
                $this->detalleFactura[$key]->idFactura = $this->id;
            }

            // $this->idDocumentoNC= $idNC[0]["claveNC"]; //Falta jalar este dato// documento al que se hace referencia.
            // $this->idReferencia= 4; // código de referencia: 4 : Referencia a otro documento.
            // $this->razon= "Cancelacion documento electronico"; // Referencia a otro documento.
            $this->reenvio = true;
            $this->Create();
        }     
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    public function notaCredito(){
        try {
            // check si ya existe la NC.
            $sql="SELECT id, orden
                FROM distribucion
                WHERE id=:id and (idEstadoNC IS NULL OR idEstadoNC = 5 OR idEstadoNC = 1)";
            $param= array(':id'=>$this->id);
            $data = DATA::Ejecutar($sql,$param);
            // si hay comprobante sin NC, continua:
            if($data){
                // actualiza estado de comprobante con NC.
                $sql="UPDATE distribucion
                    SET idDocumentoNC=:idDocumentoNC, idReferencia=:idReferencia, razon=:razon, idEstadoNC=:idEstadoNC
                    WHERE id=:id";
                $param= array(
                    ':id'=>$this->id,
                    ':idDocumentoNC'=>$this->idDocumentoNC ?? 3,
                    ':idReferencia'=>$this->idReferencia ?? $data[0]["orden"],
                    ':razon'=>$this->razon,
                    ':idEstadoNC'=>1);
                $data = DATA::Ejecutar($sql,$param, false);
                $this->informacionReferencia = [];
                if($data){
                    $this->Read();
                    // referencia a la fatura cancelada.
                    require_once("referencia.php");
                    $item = new Referencia();
                    $item->tipodoc= '01'; // factura electronica
                    $item->numero= $this->clave;  // clave del documento en referencia.
                    $item->razon=  $this->razon ?? 'Aplica Nota de credito';  // nc por rechazo? | cual es la razon de hacer la referencia.
                    $item->fechaEmision= $this->fechaEmision ?? date_create()->format('c'); // fecha de la emisión del documento al que hace referencia.
                    $item->codigo= '01';  // Anula Documento de Referencia. ;
                    array_push ($this->informacionReferencia, $item);
                    // datos entidad bodega central.
                    $central = new Bodega();
                    $central->readCentral();
                    // $this->idEmisor =  $this->id; //Jason: Esta poniendo el id de la distribucion en el id del Emisor
                    $entidad = new ClienteFE();
                    $entidad->idBodega = $central->id;
                    $this->datosEntidad = $entidad->read();
                    // datos receptor bodega externa.
                    $externa = new ClienteFE();
                    $externa->idBodega = $this->idBodega; // bodega receptor.
                    $this->datosReceptor = $externa->read();                    
                    //
                    $this->terminal = '00001';
                    $this->local = '001';
                    $this->consecutivo = $this->orden;
                    $this->idCondicionVenta= 1;
                    $this->idSituacionComprobante= 2;                
                    $this->plazoCredito= 0;
                    $this->idMedioPago= 1;
                    $this->idCodigoMoneda = 55; // CRC
                    $this->tipoCambio= 1.00; // tipo de cambio dinamico con BCCR  
                    // envía la factura
                    FacturacionElectronica::$distr = true;
                    FacturacionElectronica::iniciarNC($this);

                    if ($this->facturaRelacionada == true){
                        $this->reGenerarFactura();
                    }
                    return true;
                }
                else throw new Exception('Error al guardar.', 02);
            } else throw new Exception('Warning, el comprobante ('. $this->id .') ya tiene una Nota de Credito asignada.', 0763);
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

    function rollbackDistribucion(){
        $sql="SELECT pd.idProducto, pd.cantidad, p.costoPromedio, i.id as idInsumo
            FROM productosXDistribucion pd 
                inner join insumosXBodega i on pd.idProducto = i.idProducto
                inner join producto p on p.id = pd.idProducto
            WHERE idDistribucion =:idDistribucion and i.idBodega =:idBodega;";
            $param= array(':idDistribucion'=>$this->id, ':idBodega'=>$this->idBodega);
            $productosXDistribucion = DATA::Ejecutar($sql,$param);  

            if($productosXDistribucion){
                foreach ($productosXDistribucion as $key => $value){
                    // porcion del insumo de la agencia.
                    // busca si es artículo o producto (TOPPING - SABOR).
                    $sql='SELECT esVenta
                        FROM insumosXBodega x INNER JOIN producto p 
                        WHERE p.id= :idProducto';
                    $param= array(':idProducto'=>$value['idProducto']);
                    $porcion= DATA::Ejecutar($sql, $param);
                    //
                    if ($porcion[0]['esVenta']==0){        // artículo.
                        $porcion= 1;
                    }
                    else if ($porcion[0]['esVenta']==1){   // botella de sabor.
                        $porcion= 20;
                    }
                    else if ($porcion[0]['esVenta']==2){   // topping.
                        $porcion= 40;
                    }
                    InventarioInsumoXBodega::salida($value['idInsumo'], $this->idBodega, 'Cancela Distribucion#'.$this->orden, $value['cantidad']*$porcion);
                    InventarioProducto::entrada( $value['idProducto'],  'Cancela Distribucion#'.$this->orden, $value['cantidad'], $value['costoPromedio']);
                }
            }
    }
    
    public function cancelaDistribucion($idDistribucion, $razon){
        try {  
            //Master
            $sql="SELECT orden, idEstado, idBodega
                FROM distribucion
                WHERE id =:id;";
            $param= array(':id'=>$idDistribucion);
            $data = DATA::Ejecutar($sql,$param);  
            
            $this->razon = $razon;
            $this->id = $idDistribucion; 
            $this->orden = $data[0]["orden"];
            $this->idBodega = $data[0]["idBodega"];

            if($data[0]["idEstado"] == 1){
                $this->rollbackDistribucion();
            }
            
            // $objDistribucion = new Factura();
            // $objDistribucion->id = $idDistribucion;
            // $objDistribucion->idDocumentoNC = 3;
            // $objDistribucion->idReferencia = 1;
            // $objDistribucion->razon = $razon;
            $this->notaCredito();
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function ReadAll(){
        try {
            // $sql='SELECT id, fecha, idBodega, orden, idUsuario
            //     FROM     distribucion       
            //     ORDER BY fecha asc';
            $sql= 'SELECT d.id, fecha, orden, u.userName, b.nombre as bodega, e.nombre as estado, 
                    totalImpuesto, TotalComprobante, idEstadoComprobante
                FROM tropical.distribucion d
                    INNER JOIN usuario u on u.id=d.idUsuario
                    INNER JOIN bodega b on b.id=d.idBodega
                    INNER JOIN estado e on e.id=d.idEstado
                    
                GROUP BY orden
                ORDER BY fecha desc';
            $data= DATA::Ejecutar($sql);
            return $data;
        }     
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function ReadAllbyRange(){
        try {
            // $sql='SELECT id, fecha, idBodega, orden, idUsuario
            //     FROM     distribucion       
            //     ORDER BY fecha asc';
            $sql= 'SELECT d.id, fecha, orden, u.userName, b.nombre as bodega, e.nombre as estado, d.idEstadocomprobante, d.claveNC,
                    totalImpuesto, totalComprobante, idEstadoComprobante, t.nombre as tipoBodega
                FROM tropical.distribucion d
                    INNER JOIN usuario u on u.id=d.idUsuario
                    INNER JOIN bodega b on b.id=d.idBodega
                    INNER JOIN tipoBodega t on t.id=b.idTipoBodega 
                    INNER JOIN estado e on e.id=d.idEstado
                    
                WHERE fecha Between :fechaInicial and :fechaFinal
                GROUP BY orden
                ORDER BY fecha desc';
            $param= array(':fechaInicial'=>$this->fechaInicial, ':fechaFinal'=>$this->fechaFinal);            
            $data= DATA::Ejecutar($sql, $param);
            return $data;
        }     
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function ReadbyOrden(){
        try {
            $sql='SELECT id, fecha, orden, idUsuario, idBodega, porcentajeDescuento, porcentajeIva, totalImpuesto, totalComprobante
                FROM distribucion
                WHERE orden=:orden AND idBodega=:idBodega AND idEstado=0 AND idEstadoComprobante = 3';
            $param= array(':orden'=>$this->orden, ':idBodega'=>$this->idBodega);
            $data= DATA::Ejecutar($sql,$param);     
            if(count($data)){
                $this->id = $data[0]['id'];
                $this->fecha = $data[0]['fecha'];
                $this->idUsuario = $data[0]['idUsuario'];
                $this->idBodega = $data[0]['idBodega'];
                $this->porcentajeDescuento = $data[0]['porcentajeDescuento'];
                $this->porcentajeIva = $data[0]['porcentajeIva'];
                $this->totalImpuesto = $data[0]['totalImpuesto'];
                $this->totalComprobante = $data[0]['totalComprobante'];
                // productos x distribucion.
                $this->detalleFactura= ProductosXDistribucion::Read($this->id);
                //
                return $this;
            }
            else return null;
        }     
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el distribucion'))
            );
        }
    }

    function Read(){
        try {
            $sql='SELECT d.id, d.fecha, d.idEmisor, d.idReceptor, d.orden, clave, d.consecutivoFE, d.fechaEmision, d.idUsuario, d.idBodega, b.nombre as bodega, 
                d.porcentajeDescuento, d.porcentajeIva,  d.totalImpuesto, d.totalComprobante, d.idSituacionComprobante, d.idDocumento, d.idEstadoComprobante,
                totalServGravados, totalServExentos, totalMercanciasGravadas, totalMercanciasExentas, totalGravado, totalExento,
                totalVenta, totalDescuentos, totalVentaneta, d.clave
                FROM distribucion d
                INNER JOIN bodega b on b.id=d.idBodega
                where d.id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);     
            if(count($data)){
                $this->id = $data[0]['id'];
                $this->fecha = $data[0]['fecha'];
                $this->orden = $data[0]['orden'];
                $this->clave = $data[0]['clave'];
                $this->consecutivoFE = $data[0]['consecutivoFE'] ?? null;
                $this->fechaEmision = $data[0]['fechaEmision'] ?? null;
                $this->idUsuario = $data[0]['idUsuario'];
                $this->idBodega = $data[0]['idBodega'];
                $this->bodega = $data[0]['bodega'];
                $this->idReceptor = $data[0]['idReceptor'] ?? null;
                $this->idEmisor = $data[0]['idEmisor'] ?? null;
                $this->porcentajeDescuento = $data[0]['porcentajeDescuento'];
                $this->porcentajeIva = $data[0]['porcentajeIva'];
                $this->totalComprobante = $data[0]['totalComprobante'];
                $this->totalImpuesto = $data[0]['totalImpuesto'];
                $this->idSituacionComprobante = $data[0]['idSituacionComprobante'];
                $this->idDocumento = $data[0]['idDocumento'];
                $this->idEstadoComprobante = $data[0]['idEstadoComprobante'];
                $this->totalServGravados = $data[0]['totalServGravados'];
                $this->totalServExentos = $data[0]['totalServExentos'];
                $this->totalMercanciasGravadas = $data[0]['totalMercanciasGravadas'];
                $this->totalMercanciasExentas = $data[0]['totalMercanciasExentas'];
                $this->totalGravado = $data[0]['totalGravado'];
                $this->totalExento = $data[0]['totalExento'];
                $this->totalVenta = $data[0]['totalVenta'];
                $this->totalDescuentos = $data[0]['totalDescuentos'];
                $this->totalVentaneta = $data[0]['totalVentaneta'];
                $this->clave = $data[0]['clave'];
                // productos x distribucion.
                $this->detalleFactura= ProductosXDistribucion::Read($this->id);
                //
                return $this;
            }
            else return null;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el distribucion'))
            );
        }
    }

    function ReadCancelada(){
        try {
            $sql='SELECT d.id, fecha, orden, u.userName, b.nombre as bodega, e.nombre as estado, d.idEstadocomprobante, d.claveNC,
                totalImpuesto, totalComprobante, idEstadoComprobante, t.nombre as tipoBodega
            FROM tropical.distribucion d
                INNER JOIN usuario u on u.id=d.idUsuario
                INNER JOIN bodega b on b.id=d.idBodega
                INNER JOIN tipoBodega t on t.id=b.idTipoBodega 
                INNER JOIN estado e on e.id=d.idEstado                
            WHERE fecha Between :fechaInicial 
            AND :fechaFinal
            AND d.claveNC IS NULL
            AND t.nombre="Externa"
            GROUP BY orden
            ORDER BY fecha desc';

            $param= array(':fechaInicial'=>$this->fechaInicial, ':fechaFinal'=>$this->fechaFinal);
            $data = DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO distribucion  (id, idBodega, idUsuario, idReceptor, idEmisor, porcentajeDescuento, porcentajeIva, totalImpuesto, totalComprobante, idDocumento, idSituacionComprobante, idEstadoComprobante,
                    totalServGravados, totalServExentos, totalMercanciasGravadas, totalMercanciasExentas, totalGravado, totalExento, totalVenta, totalDescuentos, totalVentaneta) 
                VALUES (:id, :idBodega, :idUsuario, :idReceptor, :idEmisor, :porcentajeDescuento, :porcentajeIva, :totalImpuesto, :totalComprobante , :idDocumento, :idSituacionComprobante, :idEstadoComprobante,
                    :totalServGravados, :totalServExentos, :totalMercanciasGravadas, :totalMercanciasExentas, :totalGravado, :totalExento, :totalVenta, :totalDescuentos, :totalVentaneta);";
            $param= array(':id'=>$this->id ,
                ':idBodega'=>$this->idBodega,
                ':idUsuario'=>$_SESSION['userSession']->id,
                ':idReceptor'=>$this->idBodega,
                ':idEmisor'=>$this->datosEntidad->idBodega,     
                ':porcentajeDescuento'=>$this->porcentajeDescuento,
                ':porcentajeIva'=>$this->porcentajeIva,
                ':totalImpuesto'=>$this->totalImpuesto,
                ':totalComprobante'=>$this->totalComprobante,
                ':idDocumento'=>$this->idDocumento,
                ':idSituacionComprobante'=>$this->idSituacionComprobante,
                ':idEstadoComprobante'=>$this->idEstadoComprobante,
                ':totalServGravados'=> $this->totalServGravados,
                ':totalServExentos'=> $this->totalServExentos,
                ':totalMercanciasGravadas'=> $this->totalMercanciasGravadas,
                ':totalMercanciasExentas'=> $this->totalMercanciasExentas,
                ':totalGravado'=> $this->totalGravado,
                ':totalExento'=> $this->totalExento,
                ':totalVenta'=>$this->totalVenta,
                ':totalDescuentos'=>$this->totalDescuentos,
                ':totalVentaneta'=>$this->totalVentaneta
            );
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
            {
                //save array obj
                if(ProductosXDistribucion::Create($this->detalleFactura)){
                    // si es una bodega interna, acepta la distribución. Si es externa, crea el comprobante electrónico.
                    $sql="SELECT t.nombre
                        FROM tropical.bodega b
                        INNER JOIN tipoBodega t on t.id = b.idTipoBodega
                        WHERE b.id=:idBodega and t.nombre= 'Interna' ";
                    $param= array(':idBodega'=>$this->idBodega);
                    $data = DATA::Ejecutar($sql,$param);
                    if(count($data)){
                        $this->Read();
                        $this->Aceptar();
                        // retorna orden autogenerada.
                        return $this;
                    }
                    else{ // es externa. Crea comprobante.
                        
                        $objFactura = $this->Read();
                        $objFactura->consecutivo= $this->orden;
                        FacturacionElectronica::$distr= true;
                        FacturacionElectronica::iniciar($objFactura);
                        $this->getClave();
                        // retorna orden autogenerada.
                        return $this;
                    }
                }
                else throw new Exception('Error al guardar los productos.', 03);
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

    public function getClave(){
        try {
            $sql="SELECT clave
                from distribucion
                WHERE id=:id";
            $param= array(':id'=>$this->id);
            //
            $data = DATA::Ejecutar($sql,$param, true);
            if($data)
                $this->clave = $data[0]['clave'];
            else $this->clave = null;
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    function Aceptar($comprobante= false){
        try {
            $created=true;
            //if(!isset($this->orden))
            $this->Read();
            foreach ($this->detalleFactura as $item) {
                if(InventarioInsumoXBodega::entrada($item->idProducto, $this->idBodega, 'Distribución#'.$this->orden, $item->cantidad, $item->precioUnitario)){
                     // set idEstado = true.
                     $sql="UPDATE distribucion
                     SET idEstado=1, fechaAceptacion= NOW()
                     WHERE id=:id";
                    $param= array(':id'=> $this->id);
                    $data = DATA::Ejecutar($sql,$param,false);
                    if(!$data){
                        $created= false;
                    }
                    else {
                        $created= true;
                        // acepta MR.
                        if($comprobante){
                            //$this->Read();
                            $mr = new MensajeReceptor();                    
                            $mr->mensaje = 1;
                            $mr->detalle = 'Aceptacion por traslado';
                            $mr->clave = $this->clave;          
                            $mr->consecutivoFE =    $this->consecutivoFE;
                            $mr->fechaEmision =     $this->fechaEmision;
                            $mr->totalComprobante = $this->totalComprobante; //$this->total = number_format((float)$this->total,5,'.','' );  // totalComprobante;
                            $mr->totalImpuesto =   $this->totalImpuesto; //number_format((float)($mr->totalComprobante *  1 / $this->porcentajeIva), 5, '.', '');
                            // emisor del comprobante = proveedor (Central).
                            $central = new Bodega();
                            $central->readCentral();
                            $emisor = new ClienteFE();
                            $emisor->idBodega = $central->id;
                            $emisor->read();
                            $mr->idEmisor = $emisor->idBodega;
                            $mr->idTipoIdentificacionEmisor = $emisor->idTipoIdentificacion;
                            $mr->identificacionEmisor = $emisor->identificacion;
                            // receptor del comprobante = bodega registrada en el sistema.                        
                            $mr->idReceptor = $_SESSION['userSession']->idBodega;
                            $bodega = new ClienteFE();
                            $bodega->id = $_SESSION['userSession']->idBodega;
                            $bodega->read();
                            $mr->identificacionReceptor = $bodega->identificacion;
                            $mr->idTipoIdentificacionReceptor = $bodega->idTipoIdentificacion;
                            //
                            $mr->datosReceptor = $bodega; // receptor es la entidad que compra.
                            // busca el xml en bd.
                            $sql="SELECT xml 
                                from historicoComprobante
                                WHERE idFactura = :idFactura and xml is not null and idEstadoComprobante = 3
                                LIMIT 1";
                            $param= array(':idFactura'=> $this->id);
                            $data = DATA::Ejecutar($sql,$param);
                            if($data){
                                $mr->xml = $data[0]['xml'];
                                $mr->aceptar();
                            }
                            // else {
                            //     // el xml de acuse no existe o no fue ACEPTADO.

                            // }
                            //
                        }                       
                    }
                }
            }

            if($created)
                return true;
            else throw new Exception('Error al calcular SALDOS Y PROMEDIOS, debe realizar el cálculo manualmente.', 666);
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
            $sql="UPDATE distribucion 
                SET fecha=:fecha, idBodega=:idBodega, orden=:orden, idUsuario=:idUsuario
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':fecha'=>$this->fecha, ':idBodega'=>$this->idBodega, ':orden'=>$this->orden, ':idUsuario'=>$this->idUsuario);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
                return true;
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
            // recorre insumos y reversa.
            $sql='SELECT idProducto, cantidad, valor, idBodega 
                FROM productosXDistribucion x INNER JOIN distribucion d on d.id = x.idDistribucion
                WHERE idDistribucion= :id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param);
            if($data){
                // ROLLBACK.
                foreach ($data as $key => $value){
                    InventarioProducto::entrada( $value['idProducto'], $this->id, $value['cantidad'], $value['valor']);
                    // busca el id del insumo en la agencia.
                    $sql='SELECT id
                        FROM insumosXBodega  
                        WHERE idProducto= :idProducto and idBodega =:idBodega';
                    $param= array(':idProducto'=>$value['idProducto'], ':idBodega'=>$value['idBodega']);
                    $insumo= DATA::Ejecutar($sql, $param);
                    if($data){
                        // porcion del insumo de la agencia.
                        // busca si es artículo o producto (TOPPING - SABOR).
                        $sql='SELECT esVenta
                        FROM insumosXBodega x INNER JOIN producto p 
                        WHERE p.id= :idProducto';
                        $param= array(':idProducto'=>$value['idProducto']);
                        $porcion= DATA::Ejecutar($sql, $param);
                        //
                        if ($porcion[0]['esVenta']==0){        // artículo.
                            $porcion= 1;
                        }
                        else if ($porcion[0]['esVenta']==1){   // botella de sabor.
                            $porcion= 20;
                        }
                        else if ($porcion[0]['esVenta']==2){   // topping.
                            $porcion= 40;
                        }
                        InventarioInsumoXBodega::salida($insumo[0]['id'], $value['idBodega'], 'Reversa Distribucion: '. $this->orden, floatval($value['cantidad']*$porcion));
                    }                    
                }
            }
            $sql='UPDATE distribucion  
                set razon =:razon, idEstado=2
                WHERE id= :id';
            $param= array(':id'=>$this->id, ':razon'=> 'Reversa Orden Distribucion: ' . $this->orden);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data)
                return true; 
            else throw new Exception('Error al eliminar la orden de compra. Los insumos SI fueron eliminados.', 978);
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

    function ReadByCode(){
        try{ 
            $sql="SELECT id, fecha, idBodega, descripcion
                FROM distribucion
                WHERE idBodega= :idBodega";
            $param= array(':idBodega'=>$this->idBodega);
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

    public static function setClave($documento, $idDistr, $clave, $consecutivoFE=null){
        try {
            $sql='';
            $param= [];
            switch($documento){
                case 1: //fe
                case 4: //te
                case 8: //contingencia
                    $sql="UPDATE distribucion
                        SET clave=:clave, consecutivoFE=:consecutivoFE
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':clave'=>$clave, ':consecutivoFE'=>$consecutivoFE);
                break;
                case 3: // NC
                    $sql="UPDATE distribucion
                        SET claveNC=:claveNC
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':claveNC'=>$clave);
                break;
            }
            //
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
                return true;
            else throw new Exception('Error al guardar el histórico Distr.', 555);
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    public static function updateEstado($documento, $idDistr, $idEstadoComprobante, $fechaEmision){
        try {
            $sql='';
            $param= [];
            switch($documento){
                case 1: //fe
                case 4: //te
                case 8: //contingencia                
                    $sql="UPDATE distribucion
                        SET idEstadoComprobante=:idEstadoComprobante, fechaEmision=:fechaEmision
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':idEstadoComprobante'=>$idEstadoComprobante, ':fechaEmision'=>$fechaEmision);
                break;
                case 3: // NC
                    $sql="UPDATE distribucion
                        SET idEstadoNC=:idEstadoNC, fechaEmisionNC=:fechaEmisionNC
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':idEstadoNC'=>$idEstadoComprobante, ':fechaEmisionNC'=>$fechaEmision);
                break;
            }
            //
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
                return true;
            else throw new Exception('Error al guardar el histórico distr.', 556);
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    public static function updateIdEstadoComprobante($idDistr, $documento, $idEstadoComprobante){
        try {
            $sql='';
            $param= [];
            switch($documento){
                case 1: //fe
                case 4: //te
                case 8: //contingencia                
                    $sql="UPDATE distribucion
                        SET idEstadoComprobante=:idEstadoComprobante
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':idEstadoComprobante'=>$idEstadoComprobante);
                break;
                case 3: // NC
                    $sql="UPDATE distribucion
                        SET idEstadoNC=:idEstadoNC
                        WHERE id=:idDistr";
                    $param= array(':idDistr'=>$idDistr, ':idEstadoNC'=>$idEstadoComprobante);
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

    public function sendContingencia(){
        try {
            error_log("************************************************************");
            error_log("************************************************************");
            error_log("     [INFO] Iniciando Ejecución de contingencia por ID    ");
            error_log("************************************************************");
            error_log("************************************************************");
            // consulta datos de factura en bd.
            $this->Read();
            // envía la factura
            $this->contingencia();
        }
        catch(Exception $e){
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
        }
    } 

    public function sendContingenciaMasiva(){
        try {
            // busca facturas con error (5) y las reenvia con contingencia, para los documentos 1 - 4  (FE - TE)
            error_log("************************************************************");
            error_log("************************************************************");
            error_log("     [INFO] Iniciando Ejecución masiva de contingencia      ");
            error_log("                Para Distribuciones Externas                ");
            error_log("************************************************************");
            error_log("************************************************************");
            $sql="SELECT d.id, b.nombre as entidad, d.orden
                from distribucion d inner join bodega b on b.id = d.idBodega
                WHERE  d.idEstadoComprobante = 5
                ORDER BY orden asc";
                //idBodega=:idBodega and
            // $param= array(':idBodega'=>'0cf4f234-9479-4dcb-a8c0-faa4efe82db0');
            // $param= array(':idBodega'=>'f787b579-8306-4d68-a7ba-9ae328975270'); // carlos.echc11.
            $data = DATA::Ejecutar($sql);
            error_log("[INFO] Total de transacciones en Contingencia: ". count($data));
            if ($data){
                foreach ($data as $key => $transaccion){
                    error_log("[INFO] Contingencia Entidad (". $transaccion['entidad'] .") Transaccion (".$transaccion['orden'].")");
                    $this->id = $transaccion['id'];
                    $this->contingencia();
                }
            }else{                
                error_log("[INFO] No existen transacciones para el envio de contingencia)");
            }
            error_log("[INFO] Finaliza Contingencia Masiva de Comprobantes");
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

    public function contingencia(){
        try {
            // idDocumento 08 = Comprobante emitido en contingencia.
            // SituacionComprobante 02 = Envío en Contingencia
            // Estado de Comprobante 01 = Sin enviar.
            $sql="UPDATE distribucion
                SET idSituacionComprobante=:idSituacionComprobante , idDocumento=:idDocumento, idEstadoComprobante=:idEstadoComprobante
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':idSituacionComprobante'=>2 , ':idDocumento'=>8, ':idEstadoComprobante'=>1);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data){
                // lee la transaccion completa y re envia
                //error_log("[INFO] Contingencia Entidad (". $this->idEntidad .") Transaccion (".$this->consecutivo.")");
                // Valores del envio.
                $this->local= '001';//$obj["local"] ?? $_SESSION["userSession"]->local;
                $this->terminal= '00001'; //$obj["terminal"] ?? $_SESSION["userSession"]->terminal;
                $this->idCondicionVenta= 1;
                $this->idSituacionComprobante= 2;                
                $this->plazoCredito= 0;
                $this->idMedioPago= 1;
                $this->idCodigoMoneda = 55; // CRC
                $this->tipoCambio= 1.00; // tipo de cambio dinamico con BCCR                
                $this->enviarDocumentoElectronico();
                return true;
            }
            else throw new Exception('Error al actualizar la situación del distribucion - comprobante en Contingencia.', 45656);
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

    function enviarDocumentoElectronico(){
        try {
            // consulta datos de factura en bd.
            $this->Read();
            // receptor - Bodega externa.
            $receptor = new ClienteFE();
            $receptor->idBodega = $this->idBodega;
            $this->datosReceptor = $receptor->read();
            // emisor - Central.
            $central = new Bodega();
            $central->readCentral();
            $entidad = new ClienteFE();
            $entidad->idBodega = $central->id;
            $this->datosEntidad = $entidad->read();
            // envía la factura
            $this->consecutivo= $this->orden;
            FacturacionElectronica::$distr= true;
            FacturacionElectronica::iniciar($this);
        }
        catch(Exception $e){
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
        }
    }
     
}
?>



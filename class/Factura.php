<?php
//date_default_timezone_set('America/Costa_Rica');


if (isset($_POST["action"])) {
    $opt = $_POST["action"];
    unset($_POST['action']);
    // Classes    
    require_once("Conexion.php");
    require_once("Usuario.php");
    require_once("ClienteFE.php");
    require_once("facturacionElectronica.php");
    require_once("encdes.php");
    require_once("consumible.php");
    require_once("InventarioInsumoXBodega.php");
    require_once("OrdenXFactura.php");
    require_once("Receptor.php");
    require_once("Bodega.php");
    require_once("wsBCCR.php");
    require_once("mail/mail.php");
    require_once("referencia.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    require_once("productoXFactura.php");
    // Instance
    $factura = new Factura();
    switch ($opt) {
        case "ReadAllById":
            echo json_encode($factura->ReadAllById());
            break;
        case "Read":
            echo json_encode($factura->Read());
            break;
        case "ReadCancelada":
            echo json_encode($factura->ReadCancelada());
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
        case "sendContingencia":
            echo json_encode($factura->contingencia());
            break;
        case "LoadPreciosTamanos":
            echo json_encode($factura->LoadPreciosTamanos());
            break;
        case "sendContingenciaMasiva":
            $factura->sendContingenciaMasiva();
            break;
        case "sendMasiva":
            $factura->sendMasiva();
            break;
        case "sendNotaCredito":
            // Nota de Credito.
            $factura->idDocumentoNC = $_POST["idDocumentoNC"] ?? 3; // documento tipo 3: NC
            $factura->idReferencia = $_POST["idReferencia"] ?? 1; // código de referencia: 1 : Referencia a documento FE.
            $factura->razon = $_POST["razon"]; // Referencia a otro documento.
            $factura->notaCredito();
            break;
        case "ReadAllbyRange":
            echo json_encode($factura->ReadAllbyRange());
            break;
        case "ReadAllbyRangeExterna":
            echo json_encode($factura->ReadAllbyRangeExterna());
            break;
        case "ReadAllbyRangeInvVentas":
            echo json_encode($factura->ReadAllbyRangeInvVentas());
            break;
        case "ReadAllbyRangeUser":
            echo json_encode($factura->ReadAllbyRangeUser());
            break;
        case "mailSoporte":
            $factura->mailSoporte();
            break;
        case "ReadRespuestaRachazo":
            echo json_encode($factura->ReadRespuestaRachazo());
            break;
    }
}




class Factura
{
    //Factura
    public $local = "";
    public $terminal = "";
    public $idCondicionVenta = null;
    public $clave = null;
    public $consecutivoFE = null;
    public $idSituacionComprobante = null;
    public $idEstadoComprobante = null;
    public $idMedioPago = null;
    public $idDocumento = null; // FE - TE - ND - NC ...  documento para envio MH
    public $fechaEmision = "";
    public $totalVenta = null; //Precio del producto
    public $totalDescuentos = null;
    public $totalVentaneta = null;
    public $totalImpuesto = null;
    public $totalComprobante = null;
    public $idEmisor = null;
    public $informacionReferencia = [];
    public $detalleFactura = [];
    public $detalleOrden = [];
    public $datosReceptor = [];
    public $datosEntidad = [];
    public $lista = []; // Se usa para retornar los detalles de una factura
    public $consecutivo = [];
    public $usuario = "";
    public $bodega = "";
    public $plazoCredito = null;
    public $idCodigoMoneda = null;
    public $tipoCambio = null;
    public $montoEfectivo = null;
    public $montoTarjeta = null;
    // Referencia
    public $idDocumentoReferencia = null; // utilizado en COMPROBANTE EMITIDO DESPUES DE UNA NC.
    public $claveReferencia = null;
    public $fechaEmisionReferencia = null;
    // NC
    public $idDocumentoNC = null;
    public $claveNC = null;
    public $idReferencia = null;
    public $fechaEmisionNC = null;
    public $razon = null;
    public $reenvio = false;
    public $facturaRelacionada = false;

    //
    public $fechaInicial = '';
    public $fechaFinal = '';
    function __construct()
    {
        // identificador único
        if (isset($_POST["id"])) {
            $this->id = $_POST["id"];
        }

        if (isset($_POST["facturaRelacionada"])) {
            $this->facturaRelacionada = $_POST["facturaRelacionada"];
        }
        if (isset($_POST["obj"])) {
            $obj = json_decode($_POST["obj"], true);
            //Necesarias para la factura (Segun M Hacienda)
            require_once("UUID.php");
            // a. Datos de encabezado
            $this->id = $obj["id"] ?? UUID::v4();            
            $this->idCodigoActividad= $obj["idCodigoActividad"] ?? "154303";
            $this->fechaCreacion = $obj["fechaCreacion"] ?? null;  //  fecha de creacion en base de datos             
            $this->idBodega = $obj["idBodega"] ?? $_SESSION["userSession"]->idBodega;
            $this->consecutivo = $obj["consecutivo"] ?? null;
            $this->local = $obj["local"] ?? $_SESSION["userSession"]->local;
            $this->terminal = $obj["terminal"] ?? '00001';
            $this->idCondicionVenta = $obj["idCondicionVenta"] ?? 1;
            $this->idSituacionComprobante = $obj["idSituacionComprobante"] ?? 1;
            $this->idEstadoComprobante = $obj["idEstadoComprobante"] ?? 1;
            $this->plazoCredito = $obj["plazoCredito"] ?? 0;
            $this->idMedioPago = $obj["idMedioPago"] ?? 1;
            // c. Resumen de la factura/Total de la Factura 
            // definir si es servicio o mercancia (producto). En caso Tropical, siempre es mercancia
            $this->idCodigoMoneda = $obj["idCodigoMoneda"] ?? 55;
            $this->tipoCambio = $obj["tipoCambio"] ?? 1;  // 1 en colones.
            if ($this->idCodigoMoneda == 72) { // tipo dolar.
                $wsBCCR = new TipoCambio();
                $this->tipoCambio = $obj['tipoCambio'] ?? $wsBCCR->tipo_cambio()["venta"]; // tipo de cambio dinamico con BCCR
            }
            /*$this->totalServGravados= $obj['totalServGravados'] ?? 0;
            $this->totalServExentos= $obj['totalServExentos'] ?? 0;
            $this->totalMercanciasGravadas= $obj['totalMercanciasGravadas'] ?? 0;
            $this->totalMercanciasExentas= $obj['totalMercanciasExentas'] ?? 0;
            $this->totalGravado= $obj['totalGravado'] ?? 0;
            $this->totalExento= $obj['totalExento'] ?? 0;
            $this->totalVenta= $obj["totalVenta"] ?? 0;
            $this->totalDescuentos= $obj["totalDescuentos"] ?? 0;
            $this->totalVentaneta= $obj["totalVentaneta"] ?? 0;
            $this->totalImpuesto= $obj["totalImpuesto"] ?? 0;
            $this->totalComprobante= $obj["totalComprobante"] ?? 0;
            $this->montoEfectivo= $obj["montoEfectivo"] ?? null;
            $this->montoTarjeta= $obj["montoTarjeta"] ?? null;*/

            // exonerados
            $this->totalServGravados = $obj['totalServGravados'] ?? null;
            $this->totalServExonerado = $obj['totalServExonerado'] ?? null;
            $this->totalMercanciasGravadas = $obj['totalMercanciasGravadas'] ?? null;
            $this->totalMercanciasExonerada = $obj['totalMercanciasExonerada'] ?? null;
            $this->totalGravado = $obj['totalGravado'] ?? null;
            $this->totalExonerado = $obj['totalExonerado'] ?? null;
            // exentos
            $this->totalServExentos = $obj['totalServExentos'] ?? null;
            $this->totalMercanciasExentas = $obj['totalMercanciasExentas'] ?? null;
            $this->totalExento = $obj['totalExento'] ?? null;
            //
            $this->totalVenta = $obj["totalVenta"] ?? null;
            $this->totalDescuentos = $obj["totalDescuentos"] ?? null;
            $this->totalVentaneta = $obj["totalVentaneta"] ?? null;
            $this->totalImpuesto = $obj["totalImpuesto"] ?? null;
            $this->totalComprobante = $obj["totalComprobante"] ?? null;

            $this->montoEfectivo = $obj["montoEfectivo"] ?? null;
            $this->montoTarjeta = $obj["montoTarjeta"] ?? null;

            $this->fechaInicial = $obj["fechaInicial"] ?? null;
            $this->fechaFinal = $obj["fechaFinal"] ?? null;

            $this->idDocumento = $obj["idDocumento"] ?? 4; //$_SESSION["userSession"]->idDocumento; // Documento de Referencia.
            if ($this->idDocumento != "4")
                $this->idReceptor = $obj['idReceptor'] ?? Receptor::
                    default()->id; // si es null, utiliza el Receptor por defecto. En 4.3 ya NO default!!!!!!

            $this->fechaEmision = $obj["fechaEmision"] ?? null; // emision del comprobante electronico.
            //
            // si la bodega es interna usa el certificado principal.
            // bodega interna. 
            $central = new Bodega();
            $central->readCentral();
            $bodega = new Bodega();
            $bodega->ReadbyId($_SESSION['userSession']->idBodega);
            if ($bodega->tipo == $central->tipo) {
                $this->idEmisor =  $central->id;
            } else $this->idEmisor =  $_SESSION["userSession"]->idBodega;
            //
            $this->idUsuario =  $_SESSION["userSession"]->id;
            // detalle.
            $esExonerado = false;
            if (isset($obj["detalleFactura"])) {
                foreach ($obj["detalleFactura"] as $itemDetalle) {
                    // b. Detalle de la mercancía o servicio prestado
                    $item = new ProductoXFactura();
                    $item->idFactura = $this->id;
                    $item->idPrecio = $itemDetalle['idPrecio'];
                    $item->numeroLinea = $itemDetalle['numeroLinea'];
                    $item->idTipoCodigo = $itemDetalle['idTipoCodigo'] ?? 1;
                    $item->codigo = $itemDetalle['codigo'] ?? 999;
                    $item->cantidad = $itemDetalle['cantidad'] ?? 1;
                    $item->idUnidadMedida = $itemDetalle['idUnidadMedida'] ?? 78;
                    $item->detalle = $itemDetalle['detalle'];
                    $item->precioUnitario = $itemDetalle['precioUnitario'];
                    $item->montoTotal = $itemDetalle['montoTotal'];

                    /*Descuentos*/
                    $item->descuentos = [];
                    if (isset($itemDetalle["descuentos"])) {
                        include_once('descuentos.php');
                        foreach ($itemDetalle["descuentos"] as $itemDescuento) {
                            $desc = new Descuentos();
                            $desc->monto = $itemDescuento['monto'];
                            $desc->naturaleza = $itemDescuento['naturaleza'];
                            array_push($item->descuentos, $desc);
                        }
                    }

                    $item->subTotal = $itemDetalle['subTotal'];
                    $item->baseImponible = $itemDetalle['baseImponible'] ?? null;
                    /*Impuestos*/
                    $item->impuestos = [];
                    if (isset($itemDetalle["impuestos"])) {
                        include_once('impuestos.php');
                        foreach ($itemDetalle["impuestos"] as $itemImpuesto) {
                            $imp = new Impuestos();
                            $imp->idCodigoImpuesto = $itemImpuesto['idCodigoImpuesto'];  // Impuesto al Valor Agregado = 1
                            $imp->idCodigoTarifa = $itemImpuesto['codigoTarifa']; // Tarifa general 13% = 8
                            $imp->tarifaImpuesto = $itemImpuesto['tarifa']; //  13%
                            $imp->montoImpuesto = $itemImpuesto['monto'];
                            array_push($item->impuestos, $imp);
                        }
                    } 

                    /*Exoneraciones*/
                    $item->exoneraciones = [];
                    if (isset($itemDetalle['exoneraciones'])) {
                        include_once('exoneraciones.php');
                        $esExonerado = true;
                        foreach ($itemDetalle["exoneraciones"] as $itemExoneracion) {
                            $exo = new Exoneraciones();
                            $exo->tipoDocumento = $itemExoneracion['tipoDocumento'];
                            $exo->numeroDocumento = $itemExoneracion['numeroDocumento'];
                            $exo->nombreInstitucion = $itemExoneracion['nombreInstitucion'];
                            $exo->fechaEmision = $itemExoneracion['fechaEmision'];
                            $exo->porcentaje = $itemExoneracion['porcentaje'];
                            $exo->monto = $itemExoneracion['monto'];
                            array_push($item->exoneraciones, $exo);
                        }
                        $item->impuestoNeto = $itemDetalle["impuestoNeto"] ?? null;
                    }

                    $item->montoTotalLinea = $itemDetalle['montoTotalLinea']; // subtotal + impuesto.

                    array_push($this->detalleFactura, $item);
                }
            }
            // detalle de orden para presentar en pantalla de 
            if (isset($obj["detalleOrden"])) {
                foreach ($obj["detalleOrden"] as $itemOrden) {
                    $item = new OrdenXFactura();
                    $item->idTamano = $itemOrden['idTamano'];
                    $item->idSabor1 = $itemOrden['idSabor1'];
                    $item->idSabor2 = $itemOrden['idSabor2'];
                    $item->idTopping = $itemOrden['idTopping'];
                    array_push($this->detalleOrden, $item);
                }
            }
            //
            if (isset($_POST["dataReceptor"])) {
                $this->datosReceptor = new Receptor();
                $this->datosReceptor = json_decode($_POST["dataReceptor"], true);
            }
            // Referencias.
            if (isset($obj["informacionReferencia"])) {
                foreach ($obj["informacionReferencia"] as $ref) {
                    $item = new Referencia();
                    $item->tipodoc = $ref["tipodoc"];
                    $item->numero = $ref["numero"];
                    $item->razon = ($ref["razon"] == '' ? null : $ref["razon"]) ?? 'informacion de referencia';
                    $item->fechaEmision = $ref["fechaEmision"] ?? date_create();
                    $item->codigo = $ref["codigo"];
                    array_push($this->informacionReferencia, $item);
                }
            }

            /*if(isset($obj["ref"] )){
                foreach ($obj["ref"] as $ref) {
                    $factura->idDocumentoNC= $ref["idDocumentoNC"]; // documento al que se hace referencia.
                    $factura->idReferencia= $ref["idReferencia"]; // código de referencia: 4 : Referencia a otro documento.
                    $factura->razon= $ref["razon"]; // Referencia a otro documento. //Cancelacion documento electronico
                }                
            }*/
        }
    }

    function ReadAllbyRange()
    {
        try {
            $sql = 'SELECT fac.id, fac.idBodega, bod.nombre bodega, fac.fechaCreacion, fac.consecutivo, fac.totalComprobante, 
            fac.idUsuario, usr.nombre vendedor, fac.montoEfectivo, fac.montoTarjeta, fac.idEstadoComprobante, fac.totalComprobante, 
            fac.claveNC, fac.clave, fac.idReferencia
                FROM tropical.factura fac
                INNER JOIN tropical.bodega bod ON bod.id = fac.idBodega
                INNER JOIN tropical.usuario usr ON usr.id = fac.idUsuario
                INNER JOIN tropical.tipoBodega tp ON tp.id = bod.idTipoBodega
                INNER JOIN (SELECT idBodega FROM tropical.usuariosXBodega
                WHERE idUsuario = :idUsuario) bodegas ON bodegas.idBodega = fac.idBodega
                AND fac.fechaCreacion Between :fechaInicial AND :fechaFinal
                WHERE claveNC IS NULL AND tp.nombre = "Interna"
                ORDER BY fac.fechaCreacion DESC';

            $param = array(':idUsuario' => $_SESSION["userSession"]->id, ':fechaInicial' => $this->fechaInicial, ':fechaFinal' => $this->fechaFinal);
            $data = DATA::Ejecutar($sql, $param);
            return $data;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => 'Error al cargar la lista'
            )));
        }
    }

    function ReadRespuestaRachazo()
    {
        try {
            $sql = 'SELECT respuesta FROM historicoComprobante hc
            WHERE idFactura= :idFactura AND idEstadoComprobante>=4 order by fecha desc limit 1';
            $param = array(':idFactura' => $this->id);
            $data = DATA::Ejecutar($sql, $param);
            return $data;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => 'Error al cargar la lista'
            )));
        }
    }

    function ReadAllbyRangeExterna()
    {
        try {
            $sql = 'SELECT fac.id, fac.idBodega, bod.nombre bodega, fac.fechaCreacion, fac.consecutivo, fac.totalComprobante, fac.idUsuario, usr.nombre vendedor, fac.montoEfectivo, fac.montoTarjeta, fac.idEstadoComprobante, fac.totalComprobante, fac.claveNC
                FROM factura fac
                INNER JOIN bodega bod ON bod.idTipoBodega = :idTipoBodega AND bod.id = fac.idEmisor
                INNER JOIN usuario usr ON usr.id = fac.idUsuario
                INNER JOIN (SELECT idBodega FROM usuariosXBodega
                WHERE idUsuario = :idUsuario) bodegas ON bodegas.idBodega = fac.idBodega
                AND fac.fechaCreacion Between :fechaInicial AND :fechaFinal
                WHERE fac.idEmisor = :idEmisor AND claveNC IS NULL
                ORDER BY fac.fechaCreacion DESC';

            $param = array(':idUsuario' => $_SESSION["userSession"]->id, ':fechaInicial' => $this->fechaInicial, ':fechaFinal' => $this->fechaFinal, 'idEmisor' => $this->idEmisor, ':idTipoBodega' => '22a80c9e-5639-11e8-8242-54ee75873a12');
            $data = DATA::Ejecutar($sql, $param);
            return $data;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => 'Error al cargar la lista'
            )));
        }
    }

    function reGenerarFactura()
    {
        try {
            $nueva_factura = $this->Read();
            // referencia a la fatura cancelada.            
            $this->informacionReferencia = [];
            $item = new Referencia();
            $item->tipodoc = '01';  // factura electronica.
            $item->numero = $this->clave;
            $item->razon = 'Sustituye comprobante rechazado.';
            $item->fechaEmision = date_create();
            $item->codigo = '04';  // Referencia a otro documento. Al documento que se rechazó.
            array_push($this->informacionReferencia, $item);
            //
            $sql = "SELECT claveNC
                FROM factura
                WHERE id=:id";
            $param = array(':id' => $this->id);
            $idNC = DATA::Ejecutar($sql, $param);

            $this->id = UUID::v4();
            //$this->idReferencia = 'ref original= ';
            $this->idDocumentoNC = NULL;

            foreach ($this->detalleFactura as $key => $item) {
                $this->detalleFactura[$key]->idFactura = $this->id;
            }

            // $this->idDocumentoNC= $idNC[0]["claveNC"]; //Falta jalar este dato// documento al que se hace referencia.
            // $this->idReferencia= 4; // código de referencia: 4 : Referencia a otro documento.
            // $this->razon= "Cancelacion documento electronico"; // Referencia a otro documento.
            $this->reenvio = true;
            $this->Create();
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => 'Error al cargar la lista'
            )));
        }
    }

    function ReadAllById()
    {
        try {
            $sql = 'SELECT f.id, f.consecutivo, f.fechaCreacion, f.totalComprobante, f.montoEfectivo, f.montoTarjeta, b.nombre, u.userName, f.idEstadoComprobante
                FROM factura f
                INNER JOIN bodega b on f.idBodega = b.id
                INNER JOIN usuario u on u.id = f.idusuario
                WHERE f.idUsuario =:idUsuario
                ORDER BY f.consecutivo asc';
            $param = array(':idUsuario' => $_SESSION["userSession"]->id);
            $data = DATA::Ejecutar($sql, $param);
            return $data;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => 'Error al cargar la lista'
            )));
        }
    }

    function ReadAllbyRangeUser()
    {
        try {
            $sql = 'SELECT fac.id, fac.idBodega, bod.nombre bodega, fac.fechaCreacion, fac.consecutivo, fac.totalComprobante, 
                fac.idUsuario, usr.nombre vendedor, fac.montoEfectivo, fac.montoTarjeta, fac.idEstadoComprobante, fac.totalComprobante, 
                fac.claveNC, fac.clave, fac.idReferencia
                FROM factura fac
                INNER JOIN bodega bod on bod.id = fac.idBodega
                INNER JOIN usuario usr on usr.id = fac.idUsuario
                INNER JOIN (SELECT idBodega
                            FROM usuariosXBodega
                            WHERE idUsuario = :idUsuario) bodegas on bodegas.idBodega = fac.idBodega
                AND
                fac.fechaCreacion Between :fechaInicial and :fechaFinal
                AND fac.idUsuario =:idUsuario
                ORDER BY fac.consecutivo DESC';

            $param = array(':idUsuario' => $_SESSION["userSession"]->id, ':fechaInicial' => $this->fechaInicial, ':fechaFinal' => $this->fechaFinal);
            $data = DATA::Ejecutar($sql, $param);
            return $data;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => 'Error al cargar la lista'
            )));
        }
    }

    function ReadCancelada()
    {
        try {
            //
            $sql = 'SELECT tb.nombre FROM tropical.tipoBodega tb 
            INNER JOIN bodega b ON b.idTipoBodega = tb.id
            WHERE b.id=:idBodega';
            $param = array(':idBodega' => $_SESSION['userSession']->idBodega);
            $tipoBodega = DATA::Ejecutar($sql, $param);

            if ($tipoBodega[0]['nombre'] == "Interna") {
                $sql = 'SELECT fac.id, fac.idBodega, bod.nombre bodega, fac.fechaCreacion, fac.consecutivo, 
                fac.totalComprobante, fac.idUsuario, usr.nombre vendedor, fac.montoEfectivo, fac.montoTarjeta, 
                fac.idEstadoComprobante, fac.totalComprobante, fac.claveNC, fac.idEstadoNC, fac.clave, fac.idReferencia
                    FROM factura fac
                    INNER JOIN bodega bod ON bod.id = fac.idBodega
                    INNER JOIN usuario usr ON usr.id = fac.idUsuario
                    INNER JOIN tipoBodega tp ON tp.id = bod.idTipoBodega 
                    INNER JOIN (SELECT idBodega
                                FROM usuariosXBodega
                                WHERE idUsuario = :idUsuario) bodegas ON bodegas.idBodega = fac.idBodega
                    AND fac.fechaCreacion Between :fechaInicial AND :fechaFinal
                    AND fac.claveNC IS NOT NULL
                    WHERE tp.nombre = "Interna"
                    ORDER BY fac.fechaCreacion DESC';

                $param = array(':idUsuario' => $_SESSION["userSession"]->id, ':fechaInicial' => $this->fechaInicial, ':fechaFinal' => $this->fechaFinal);
                $data = DATA::Ejecutar($sql, $param);
            } else {
                $sql = 'SELECT fac.id, fac.idBodega, bod.nombre bodega, fac.fechaCreacion, fac.consecutivo, 
                fac.totalComprobante, fac.idUsuario, usr.nombre vendedor, fac.montoEfectivo, fac.montoTarjeta, 
                fac.idEstadoComprobante, fac.totalComprobante, fac.claveNC, fac.idEstadoNC, fac.clave, fac.idReferencia
                    FROM factura fac
                    INNER JOIN bodega bod ON bod.id = fac.idBodega
                    INNER JOIN usuario usr ON usr.id = fac.idUsuario
                    INNER JOIN tipoBodega tp ON tp.id = bod.idTipoBodega 
                    INNER JOIN (SELECT idBodega
                                FROM usuariosXBodega
                                WHERE idUsuario = :idUsuario) bodegas ON bodegas.idBodega = fac.idBodega
                    AND fac.fechaCreacion Between :fechaInicial AND :fechaFinal
                    AND fac.claveNC IS NOT NULL
                    WHERE tp.nombre = "Externa" AND fac.idBodega = :idBodega
                    ORDER BY fac.fechaCreacion DESC';

                $param = array(
                    ':idUsuario' => $_SESSION["userSession"]->id, ':fechaInicial' => $this->fechaInicial,
                    ':idBodega' => $_SESSION['userSession']->idBodega, ':fechaFinal' => $this->fechaFinal
                );
                $data = DATA::Ejecutar($sql, $param);
            }
            return $data;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => 'Error al cargar la lista'
            )));
        }
    }

    function Read()
    {
        try {
            $sql = 'SELECT idBodega, fechaCreacion, consecutivo, clave, idCodigoActividad, consecutivoFE, local, terminal, idCondicionVenta, idSituacionComprobante, idEstadoComprobante, plazoCredito, 
                idMedioPago, idCodigoMoneda, tipoCambio, totalServGravados, totalServExentos, totalMercanciasGravadas, totalMercanciasExentas, totalGravado, totalExento, fechaEmision, idDocumento, 
                totalVenta, totalDescuentos, totalVentaneta, totalImpuesto, totalComprobante, idReceptor, idEmisor, idUsuario, idDocumentoNC, claveNC, fechaEmisionNC,
                idReferencia, razon, idEstadoNC
                from factura
                where id=:id';
            $param = array(':id' => $this->id);
            $data = DATA::Ejecutar($sql, $param);
            foreach ($data as $key => $value) {
                $this->idBodega = $value['idBodega'];
                //$this->bodega =  // nombre de la bodega.
                $this->fechaCreacion = $value['fechaCreacion'];
                $this->consecutivo = $value['consecutivo'];
                $this->clave = $value['clave'] ?? null;
                $this->idCodigoActividad = $data[0]['idCodigoActividad'] ?? null;
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
                $this->detalleFactura = ProductoXFactura::ReadByIdFactura($this->id);
                $receptor = new Receptor();
                $receptor->id = $this->idReceptor;
                $this->datosReceptor = $receptor->read();
                $entidad = new ClienteFE();
                $entidad->idBodega = $this->idEmisor;
                $this->datosEntidad = $entidad->read();
            }
            return $this;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => 'Error al cargar el factura'
            )));
        }
    }

    function ReadVentas()
    {
        try {
            $sql = 'SELECT f.id, f.fechaCreacion, f.consecutivo, f.totalComprobante,
            (SELECT count(pxf.codigo) FROM tropical.productosXFactura pxf WHERE pxf.codigo="12oz" AND pxf.idFactura=f.id) AS _12oz, 
            (SELECT count(pxf.codigo) FROM tropical.productosXFactura pxf WHERE pxf.codigo="08oz" AND pxf.idFactura=f.id) AS _08oz 
            FROM tropical.factura f ORDER BY f.fechaCreacion DESC;';
            $data = DATA::Ejecutar($sql);
            return $data;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => 'Error al cargar la lista'
            )));
        }
    }

    function ReadAllbyRangeInvVentas()
    {
        try {
            $sql = 'SELECT f.id, f.fechaCreacion, f.consecutivo, f.totalComprobante,
                (SELECT count(pxf.codigo) FROM tropical.productosXFactura pxf WHERE pxf.codigo="12oz" AND pxf.idFactura=f.id) AS _12oz, 
                (SELECT count(pxf.codigo) FROM tropical.productosXFactura pxf WHERE pxf.codigo="08oz" AND pxf.idFactura=f.id) AS _08oz 
            FROM tropical.factura f 
            -- WHERE f.idEstadoNC<3 AND f.idEstadoNC>3 OR f.idEstadoNC IS NULL  
            WHERE (f.idEstadoNC!=3 OR f.idEstadoNC IS NULL)  
            AND f.idEstadoComprobante = 3             
            and f.fechaCreacion between :fechaInicial and :fechaFinal
            ORDER BY f.consecutivo desc';
            $param = array(':fechaInicial' => $this->fechaInicial, ':fechaFinal' => $this->fechaFinal);
            $data = DATA::Ejecutar($sql, $param);
            return $data;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => 'Error al cargar la lista'
            )));
        }
    }

    function enviarDocumentoElectronico()
    {
        try {
            // consulta datos de factura en bd.
            $this->Read();
            // envía la factura
            FacturacionElectronica::iniciar($this);
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
        }
    }

    function Create()
    {
        try {
            $sql = "INSERT INTO factura   (id, idBodega, local, terminal, idCodigoActividad, idCondicionVenta, idSituacionComprobante, idEstadoComprobante, plazoCredito, 
                idMedioPago, idCodigoMoneda, tipoCambio, totalServGravados, totalServExentos, totalMercanciasGravadas, totalMercanciasExentas, totalGravado, totalExento, idDocumento, 
                totalVenta, totalDescuentos, totalVentaneta, totalImpuesto, totalComprobante, idReceptor, idEmisor, idUsuario, montoEfectivo, idReferencia, idDocumentoNC, razon)
            VALUES  (:uuid, :idBodega, :local, :terminal, :idCodigoActividad,:idCondicionVenta, :idSituacionComprobante, :idEstadoComprobante, :plazoCredito,
                :idMedioPago, :idCodigoMoneda, :tipoCambio, :totalServGravados, :totalServExentos, :totalMercanciasGravadas, :totalMercanciasExentas, :totalGravado, :totalExento, :idDocumento, 
                :totalVenta, :totalDescuentos, :totalVentaneta, :totalImpuesto, :totalComprobante, :idReceptor, :idEmisor, :idUsuario, :montoEfectivo, :idReferencia, :idDocumentoNC, :razon)";
            $param = array(
                ':uuid' => $this->id,
                ':idBodega' => $this->idBodega,
                ':local' => $this->local,
                ':terminal' => $this->terminal,
                ':idCodigoActividad'=>$this->idCodigoActividad,
                ':idCondicionVenta' => $this->idCondicionVenta,
                ':idSituacionComprobante' => $this->idSituacionComprobante,
                ':idEstadoComprobante' => $this->idEstadoComprobante,
                ':plazoCredito' => $this->plazoCredito,
                ':idMedioPago' => $this->idMedioPago,
                ':idCodigoMoneda' => $this->idCodigoMoneda,
                ':tipoCambio' => $this->tipoCambio,
                ':totalServGravados' => $this->totalServGravados,
                ':totalServExentos' => $this->totalServExentos,
                ':totalMercanciasGravadas' => $this->totalMercanciasGravadas,
                ':totalMercanciasExentas' => $this->totalMercanciasExentas,
                ':totalGravado' => $this->totalGravado,
                ':totalExento' => $this->totalExento,
                ':idDocumento' => $this->idDocumento,
                ':totalVenta' => $this->totalVenta,
                ':totalDescuentos' => $this->totalDescuentos,
                ':totalVentaneta' => $this->totalVentaneta,
                ':totalImpuesto' => $this->totalImpuesto,
                ':totalComprobante' => $this->totalComprobante,
                ':idReceptor' => $this->idReceptor ?? null,
                ':idEmisor' => $this->idEmisor,
                ':idUsuario' => $this->idUsuario,
                ':idReferencia' => $this->idReferencia,
                ':idDocumentoNC' => $this->idDocumentoNC,
                ':razon' => $this->razon,
                ':montoEfectivo' => $this->montoEfectivo
            );
            $data = DATA::Ejecutar($sql, $param, false);
            if ($data) {
                //save array obj
                if (ProductoXFactura::Create($this->detalleFactura)) {
                    $this->actualizaInventario($this->detalleOrden);
                    // orden de factura para mostrar en despacho.
                    OrdenXFactura::$id = $this->id;
                    if ($this->reenvio != true) {
                        OrdenXFactura::Create($this->detalleOrden);
                    }
                    // envio de comprobantes en tiempo real.
                    $this->enviarDocumentoElectronico();
                    $this->getClave();
                    return $this;
                } else throw new Exception('[ERROR] al guardar los productos.', 03);
            } else throw new Exception('[ERROR] al guardar.', 02);
        } catch (Exception $e) {
            error_log("[ERROR]: " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => $e->getMessage()
            )));
        }
    }

    public static function setClave($documento, $idFactura, $clave, $consecutivoFE = null)
    {
        try {
            $sql = '';
            $param = [];
            switch ($documento) {
                case 1: //fe
                case 4: //te
                case 8: //contingencia
                    $sql = "UPDATE factura
                        SET clave=:clave, consecutivoFE=:consecutivoFE
                        WHERE id=:idFactura";
                    $param = array(':idFactura' => $idFactura, ':clave' => $clave, ':consecutivoFE' => $consecutivoFE);
                    break;
                case 3: // NC
                    $sql = "UPDATE factura
                        SET claveNC=:claveNC
                        WHERE id=:idFactura";
                    $param = array(':idFactura' => $idFactura, ':claveNC' => $clave);
                    break;
                case 5: // CCE 
                case 6: // CPCE 
                case 7: // RCE 
                    $sql = "UPDATE mensajeReceptor
                        SET consecutivoFE=:consecutivoFE
                        WHERE id=:id";
                    $param = array(':id' => $idFactura, ':consecutivoFE' => $consecutivoFE);
                    break;
            }
            //
            $data = DATA::Ejecutar($sql, $param, false);
            if ($data)
                return true;
            else throw new Exception('Error al guardar el histórico.', 03);
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    public function getClave()
    {
        try {
            $sql = "SELECT clave
                from factura
                WHERE id=:id";
            $param = array(':id' => $this->id);
            //
            $data = DATA::Ejecutar($sql, $param, true);
            if ($data)
                $this->clave = $data[0]['clave'];
            else $this->clave = null;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    public static function updateEstado($documento, $idFactura, $idEstadoComprobante, $fechaEmision)
    {
        try {
            $sql = '';
            $param = [];
            switch ($documento) {
                case 1: //fe
                case 4: //te
                case 8: //contingencia
                    $sql = "UPDATE factura
                        SET idEstadoComprobante=:idEstadoComprobante, fechaEmision=:fechaEmision
                        WHERE id=:idFactura";
                    $param = array(':idFactura' => $idFactura, ':idEstadoComprobante' => $idEstadoComprobante, ':fechaEmision' => $fechaEmision);
                    break;
                case 3: // NC
                    $sql = "UPDATE factura
                        SET idEstadoNC=:idEstadoNC, fechaEmisionNC=:fechaEmisionNC
                        WHERE id=:idFactura";
                    $param = array(':idFactura' => $idFactura, ':idEstadoNC' => $idEstadoComprobante, ':fechaEmisionNC' => $fechaEmision);
                    break;
                case 5: // CCE 
                case 6: // CPCE 
                case 7: // RCE 
                    $sql = "UPDATE mensajeReceptor
                        SET idEstadoComprobante=:idEstadoComprobante, fechaEmision=:fechaEmision
                        WHERE id=:id";
                    $param = array(':id' => $idFactura, ':idEstadoComprobante' => $idEstadoComprobante, ':fechaEmision' => $fechaEmision);
                    break;
            }
            //
            $data = DATA::Ejecutar($sql, $param, false);
            if ($data)
                return true;
            else throw new Exception('Error al guardar el histórico.', 03);
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    public static function updateIdEstadoComprobante($idFactura, $documento, $idEstadoComprobante)
    {
        try {
            $sql = '';
            $param = [];
            switch ($documento) {
                case 1: //fe
                case 4: //te
                case 8: //contingencia
                    $sql = "UPDATE factura
                        SET idEstadoComprobante=:idEstadoComprobante
                        WHERE id=:idFactura";
                    $param = array(':idFactura' => $idFactura, ':idEstadoComprobante' => $idEstadoComprobante);
                    break;
                case 3: // NC
                    $sql = "UPDATE factura
                        SET idEstadoNC=:idEstadoNC
                        WHERE id=:idFactura";
                    $param = array(':idFactura' => $idFactura, ':idEstadoNC' => $idEstadoComprobante);
                    break;
                case 5: // CCE 
                case 6: // CPCE 
                case 7: // RCE 
                    $sql = "UPDATE mensajeReceptor
                        SET idEstadoComprobante=:idEstadoComprobante
                        WHERE id=:id";
                    $param = array(':id' => $idFactura, ':idEstadoComprobante' => $idEstadoComprobante);
                    break;
            }
            //
            $data = DATA::Ejecutar($sql, $param, false);
            if ($data)
                return true;
            else throw new Exception('Error al actualizar el estado del comprobante.', 0456);
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            // debe notificar que no se esta actualizando el historico de comprobantes.
        }
    }

    function actualizaInventario($insumos)
    {
        if (!isset($this->consecutivo))
            $this->Read();

        if ($this->facturaRelacionada) {
            $this->Read();
            $insumos_tmp = [];

            foreach ($this->detalleFactura as $key => $value) {
                $value->detalle = str_replace(' ', '', $value->detalle);
                $producto_x_linea = explode(",", $value->detalle);


                $item = new OrdenXFactura();

                if ($producto_x_linea[0] == "08oz")
                    $item->idTamano = 0;
                else $item->idTamano = 1;

                foreach ($producto_x_linea as $cont => $lineaValue) {
                    $sql = "SELECT i.id FROM producto p
                        INNER JOIN insumosXBodega i
                        on p.id = i.idProducto
                        where p.nombreAbreviado = :nombreAbreviado
                        and i.idBodega = :idBodega;";
                    $param = array(':nombreAbreviado' => $lineaValue, ':idBodega' => $this->idBodega);
                    $data = DATA::Ejecutar($sql, $param);
                    if ($data) {
                        switch ($cont) {
                            case 1:
                                $item->idSabor1 = $data[0]["id"];
                                break;
                            case 2:
                                $item->idSabor2 = $data[0]["id"];
                                break;
                            case 3:
                                $item->idTopping = $data[0]["id"];
                                break;
                        }
                    }
                }
                array_push($insumos_tmp, $item);
            }
            $insumos = $insumos_tmp;
        }

        foreach ($insumos as $key => $value) {
            // resta inventario sabor y topping.
            if ($value->idTamano == 0)
                $porcion = 1;
            else $porcion = 1.4285714;
            InventarioInsumoXBodega::salida($value->idSabor1, $this->idBodega, 'factura#' . $this->consecutivo, $porcion);
            InventarioInsumoXBodega::salida($value->idSabor2, $this->idBodega, 'factura#' . $this->consecutivo, $porcion);
            InventarioInsumoXBodega::salida($value->idTopping, $this->idBodega, 'factura#' . $this->consecutivo, 1);
            // resta inventario consumibles.
            Consumible::salida($value->idTamano, $this->idBodega, $this->consecutivo);
        };
    }

    function Update()
    {
        try {
            $sql = "UPDATE factura 
                SET idUsuario=:idUsuario, fecha=:fecha, subTotal= :subTotal, iva=:iva, porcentajeIva=:porcentajeIva, descuento=:descuento, porcentajeDescuento=:porcentajeDescuento, total=:total
                WHERE id=:id";
            $param = array(
                ':id' => $this->id, ':idUsuario' => $this->idUsuario, ':fecha' => $this->fecha, ':subTotal' => $this->subTotal, ':iva' => $this->iva, ':porcentajeIva' => $this->porcentajeIva,
                ':descuento' => $this->descuento, ':porcentajeDescuento' => $this->porcentajeDescuento, ':total' => $this->total
            );
            $data = DATA::Ejecutar($sql, $param, false);
            if ($data) {
                //update array obj
                if ($this->listaProducto != null)
                    if (ProductosXFactura::Update($this->listaProducto))
                        return true;
                    else throw new Exception('Error al guardar las categorias.', 03);
                else {
                    // no tiene categorias
                    if (ProductosXFactura::Delete($this->id))
                        return true;
                    else throw new Exception('Error al guardar las categorias.', 04);
                }
            } else throw new Exception('Error al guardar.', 123);
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => $e->getMessage()
            )));
        }
    }

    public function sendContingenciaMasiva()
    {
        // busca facturas con error (5) y las reenvia con contingencia, para los documentos 1 - 4  (FE - TE)
        error_log("************************************************************");
        error_log("************************************************************");
        error_log("     [INFO] Iniciando Ejecución masiva de contingencia      ");
        error_log("************************************************************");
        error_log("************************************************************");
        $sql = "SELECT f.id, b.nombre as entidad, consecutivo
            from factura f inner join bodega b on b.id = f.idBodega
            WHERE  f.idEstadoComprobante = 5 and (f.idDocumento = 1 or  f.idDocumento = 4 or  f.idDocumento = 8) 
            ORDER BY consecutivo asc";
        //idBodega=:idBodega and
        // $param= array(':idBodega'=>'0cf4f234-9479-4dcb-a8c0-faa4efe82db0');
        // $param= array(':idBodega'=>'f787b579-8306-4d68-a7ba-9ae328975270'); // carlos.echc11.
        $data = DATA::Ejecutar($sql);
        error_log("[INFO] Total de transacciones en Contingencia: " . count($data));
        foreach ($data as $key => $transaccion) {
            error_log("[INFO] Contingencia Entidad (" . $transaccion['entidad'] . ") Transaccion (" . $transaccion['consecutivo'] . ")");
            $this->id = $transaccion['id'];
            $this->contingencia();
        }
        error_log("[INFO] Finaliza Contingencia Masiva de Comprobantes");
    }

    public function sendContingencia()
    {
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
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
        }
    }

    public function sendMasiva()
    {
        // busca facturas con estado (1) y (5) y las reenvia 
        error_log("************************************************************");
        error_log("************************************************************");
        error_log("     [INFO] Iniciando Re-envío masivo de facturas           ");
        error_log("************************************************************");
        error_log("************************************************************");

        $sql = "SELECT f.id, b.nombre as entidad, consecutivo
            from factura f inner join bodega b on b.id = f.idBodega
            WHERE  f.idEstadoComprobante = 5 and (f.idDocumento = 1 or  f.idDocumento = 4 or  f.idDocumento = 8) 
            ORDER BY consecutivo asc";
        $data = DATA::Ejecutar($sql);
        error_log("[INFO] Total de transacciones en Contingencia: " . count($data));
        foreach ($data as $key => $transaccion) {
            error_log("[INFO] Contingencia Entidad (" . $transaccion['entidad'] . ") Transaccion (" . $transaccion['consecutivo'] . ")");
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
            $this->read();
            // si la diferencia de minutos entre la creacion de la factura y el envio del documento es superior a 60 minutos, debe hacer el envio en CONTINGENCIA | SIN INTERNET.
            $fechaEmision= date_create();
            $fechaCreacion= date_create($this->fechaCreacion);
            // $diferenciaContingencia = $fechaCreacion->diff($fechaEmision);            
            $diferenciaContingencia = $fechaEmision->getTimestamp()   -  $fechaCreacion->getTimestamp();
            if($diferenciaContingencia > 3600 ){
                $this->idSituacionComprobante = 3;
            } else {
                $this->idSituacionComprobante = 1;
            }
            //
            $sql="UPDATE factura
                SET idSituacionComprobante=:idSituacionComprobante ,   idEstadoComprobante=:idEstadoComprobante
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':idSituacionComprobante'=>$this->idSituacionComprobante, ':idEstadoComprobante'=>1);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data){
                // lee la transaccion completa y re envia
                FacturacionElectronica::iniciar($this);
                // return true;
            }
            else throw new Exception('Error al actualizar la situación del comprobante en Contingencia.', 45656);            
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            if (!headers_sent()) {
                    header('HTTP/1.0 400 Error al leer');
                }
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public function notaCredito()
    {
        try {
            // check si ya existe la NC.
            $sql = "SELECT id, consecutivo
                FROM factura
                WHERE id=:id and (idEstadoNC IS NULL OR idEstadoNC = 5 OR idEstadoNC = 1)";
            $param = array(':id' => $this->id);
            $data = DATA::Ejecutar($sql, $param);
            // si hay comprobante sin NC, continua:
            if ($data) {
                // actualiza estado de comprobante con NC.
                $sql = "UPDATE factura
                    SET idDocumentoNC=:idDocumentoNC, idReferencia=:idReferencia, razon=:razon, idEstadoNC=:idEstadoNC
                    WHERE id=:id";
                $param = array(
                    ':id' => $this->id,
                    ':idDocumentoNC' => $this->idDocumentoNC,
                    ':idReferencia' => $this->idReferencia ?? $data[0]["consecutivo"],
                    ':razon' => $this->razon,
                    ':idEstadoNC' => 1
                );
                $data = DATA::Ejecutar($sql, $param, false);
                if ($data) {
                    $this->read();
                    // referencia a la fatura cancelada.
                    require_once("referencia.php");
                    $item = new Referencia();
                    $item->tipodoc = '01'; // factura electronica
                    $item->numero = $this->clave;  // clave del documento en referencia.
                    $item->razon = 'Aplica Nota de credito';  // nc por rechazo? | cual es la razon de hacer la referencia.
                    $item->fechaEmision = date_create($this->fechaEmision) ?? date_create()->format('c'); // fecha de la emisión del documento al que hace referencia.
                    $item->codigo = '01';  // Anula Documento de Referencia. ;
                    array_push($this->informacionReferencia, $item);
                    // envía la factura
                    FacturacionElectronica::iniciarNC($this);

                    if ($this->facturaRelacionada == true) {
                        $this->reGenerarFactura();
                    }
                    return true;
                } else throw new Exception('Error al guardar.', 02);
            } else throw new Exception('Warning, el comprobante (' . $this->id . ') ya tiene una Nota de Credito asignada.', 0763);
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => $e->getMessage()
            )));
        }
    }

    public function reenviarFactura()
    {
        try {
            // check si ya existe la NC.
            $sql = "SELECT id, consecutivo
                FROM factura
                WHERE id=:id and (idEstadoNC IS NULL OR idEstadoNC = 5 OR idEstadoNC = 1)";
            $param = array(':id' => $this->id);
            $data = DATA::Ejecutar($sql, $param);
            // si hay comprobante sin NC, continua:
            if ($data) {
                // actualiza estado de comprobante con NC.
                $sql = "UPDATE factura
                    SET idDocumentoNC=:idDocumentoNC, idEstadoComprobante=:idEstadoComprobante, idReferencia=:idReferencia, razon=:razon, idEstadoNC=:idEstadoNC
                    WHERE id=:id";
                $param = array(
                    ':id' => $this->id,
                    ':idDocumentoNC' => $this->idDocumentoNC,
                    ':idReferencia' => $this->idReferencia ?? $data[0]["consecutivo"],
                    ':razon' => $this->razon,
                    ':idEstadoNC' => 1,
                    ':idEstadoComprobante' => 11
                );
                $data = DATA::Ejecutar($sql, $param, false);
                if ($data) {
                    $this->read();
                    // referencia a la fatura cancelada.
                    require_once("referencia.php");
                    $item = new Referencia();
                    $item->tipodoc = '01'; // factura electronica
                    $item->numero = $this->clave;  // clave del documento en referencia.
                    $item->razon = 'Aplica Nota de credito';  // nc por rechazo? | cual es la razon de hacer la referencia.
                    $item->fechaEmision = $this->fechaEmision ?? date_create()->format('c'); // fecha de la emisión del documento al que hace referencia.
                    $item->codigo = '01';  // Anula Documento de Referencia. ;
                    array_push($this->informacionReferencia, $item);
                    // envía la factura
                    // FacturacionElectronica::iniciarNC($this);

                    if ($this->facturaRelacionada == true) {
                        $this->reGenerarFactura();
                    }
                    return true;
                } else throw new Exception('Error al guardar.', 02);
            } else throw new Exception('Warning, el comprobante (' . $this->id . ') ya tiene una Nota de Credito asignada.', 0763);
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => $e->getMessage()
            )));
        }
    }

    private function CheckRelatedItems()
    {
        try {
            $sql = "SELECT idProducto
                FROM categoriasXProducto x
                WHERE x.idProducto= :id";
            $param = array(':id' => $this->id);
            $data = DATA::Ejecutar($sql, $param);
            if (count($data))
                return true;
            else return false;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => $e->getMessage()
            )));
        }
    }

    function Delete()
    {
        try {
            if ($this->CheckRelatedItems()) {
                //$sessiondata array que devuelve si hay relaciones del objeto con otras tablas.
                $sessiondata['status'] = 1;
                $sessiondata['msg'] = 'Registro en uso';
                return $sessiondata;
            }
            $sql = 'DELETE FROM factura  
                WHERE id= :id';
            $param = array(':id' => $this->id);
            $data = DATA::Ejecutar($sql, $param, false);
            if ($data) {
                $sessiondata['status'] = 0;
                return $sessiondata;
            } else throw new Exception('Error al eliminar.', 978);
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => $e->getMessage()
            )));
        }
    }

    function LoadPreciosTamanos()
    {
        try {
            // ANTES DE CARGAR PRECIOS, VALIDA EL PERFIL DEL CONTRIBUYENTE
            $clientefe = new CLienteFE();
            if ($clientefe->checkProfile()) {
                //
                $sql = "SELECT id, tamano, precioVenta FROM preciosXBodega where idBodega = :idBodega;";
                $param = array(':idBodega' => $_SESSION["userSession"]->idBodega);
                $data = DATA::Ejecutar($sql, $param);
                if (count($data))
                    return $data;
                else return false;
            } else return "NOCONTRIB";
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => $e->getMessage()
            )));
        }
    }

    function mailSoporte()
    {
        try {
            $facturaMailSoporte = $_POST["facturaMailSoporte"];
            $this->id = $facturaMailSoporte[0];
            $mail = new Send_Mail();
            $mail->email_array_address_to = array("soporte@storylabscr.com");
            $mail->email_address_to = "soporte@storylabscr.com";
            $mail->email_subject = "TROPICAL FACTURA # " . $facturaMailSoporte[1] . " CON ESTADO : " . $facturaMailSoporte[6];
            $mail->email_user = "soporte@storylabscr.com";
            $mail->email_password = "Story2018+";
            $mail->email_from_name = "StoryLabs FE";
            $mail->email_SMTPSecure = "none";
            $mail->email_Host = "smtpout.secureserver.net";
            $mail->email_SMTPAuth = true;
            $mail->email_Port = 80;
            $mail->email_body = "<p># FACTURA : " . $facturaMailSoporte[1] . "</br>
                                    ESTADO    : " . $facturaMailSoporte[6] . "</br>                    
                                    TOTAL     : " . $facturaMailSoporte[5] . "</br>                     
                                    VENDEDOR  : " . $facturaMailSoporte[4] . "</br>
                                    FECHA     : " . $facturaMailSoporte[2] . "</br>
                                    ALMACEN   : " . $facturaMailSoporte[3] . "</br>
                                    UUID      : " . $facturaMailSoporte[0] . "</P>";
            // $mail->email_addAttachment = $path_fecha;
            $mail->send();

            $sql = "UPDATE factura SET idEstadoComprobante=:idEstadoComprobante WHERE id=:id";
            $param = array(':id' => $this->id, ':idEstadoComprobante' => 99);
            $data = DATA::Ejecutar($sql, $param, false);
            if ($data)
                return true;
            else throw new Exception('Error al actualizar el estado de la factura.', 666);
        } catch (Exception $e) {
            header('HTTP/1.0 400 Error al generar la factura');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => $e->getMessage()
            )));
        }
    }
}

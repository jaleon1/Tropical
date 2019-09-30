<?php
require_once("Conexion.php");
if (isset($_POST["action"])) {
    $opt = $_POST["action"];
    unset($_POST['action']);
    // Classes        
    require_once("Usuario.php");
    require_once("InventarioInsumoXBodega.php");
    require_once("consumible.php");
    require_once("Factura.php");
    require_once("Receptor.php");
    require_once("ClienteFE.php");
    require_once("encdes.php");
    require_once("facturacionElectronica.php");
    require_once("OrdenXFactura.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $productoXFactura = new ProductoXFactura();
    switch ($opt) {
        case "ReadByIdFactura":
            echo json_encode($productoXFactura->ReadByIdFactura($_POST['id']));
            break;
        case "reintegrarProductoByIdFactura":
            $productoXFactura->reintegrarProductoByIdFactura($_POST['id'], $_POST['razon'], $_POST['notaCredito']);
            break;
    }
}

class ProductoXFactura
{
    /*
    public static function Read(){
        try{
            $sql="SELECT detalle from productosXFactura
                where idFactura = :idDistribucion";
            $param= array(':idDistribucion'=>self::$id);
            $data = DATA::Ejecutar($sql,$param);            
            $lista = [];
            foreach ($data as $key => $value){
                $producto = new ProductoXFactura();
                $producto->detalle = $value['detalle']; //id del producto.       
                array_push ($lista, $producto);
            }
            return $lista;
        }
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }*/


    public static function reintegrarProductoByIdFactura($idFactura, $razon, $nc=false)
    {
        try {
            //Master
            $sql = "SELECT consecutivo, idMedioPago, totalComprobante, fechaCreacion, idBodega 
                FROM factura
                WHERE id =:id;";
            $param = array(':id' => $idFactura);
            $factura = DATA::Ejecutar($sql, $param);
            //Detalle
            $datoFactura = ProductoXFactura::ReadByIdFactura($idFactura);

            //ID Caja
            $sql = 'SELECT id FROM cajasXBodega
                WHERE idBodega= :idBodega AND
                :fechaCreacion BETWEEN fechaApertura AND fechaCierre;';
            $param = array(':fechaCreacion' => $factura[0]["fechaCreacion"], ':idBodega' => $factura[0]["idBodega"]);
            $idCaja = DATA::Ejecutar($sql, $param);
            // 153f802a-049f-11e9-a864-0800279cc012

            if (isset($idCaja[0]["id"])   && !isset($_POST["facturaRelacionada"])) {
                switch ($factura[0]["idMedioPago"]) {
                    case "1":
                        $sql = 'UPDATE cajasXBodega 
                            SET totalVentasEfectivo = totalVentasEfectivo - :totalComprobante 
                            WHERE id = :id';
                        break;
                    case "2":
                        $sql = 'UPDATE cajasXBodega 
                        SET totalVentasTarjeta = totalVentasTarjeta - :totalComprobante 
                        WHERE id = :id';
                        break;
                }
                $param = array(':id' => $idCaja[0]["id"], ':totalComprobante' => $factura[0]["totalComprobante"]);
                $idCaja = DATA::Ejecutar($sql, $param);
            }

            foreach ($datoFactura as $key => $value) {
                $value->detalle = str_replace(' ', '', $value->detalle);
                $producto_x_linea = explode(",", $value->detalle);

                $productos = [];

                foreach ($producto_x_linea as $item => $lineaValue) {
                    $sql = "SELECT id FROM producto
                    where nombreAbreviado = :nombreAbreviado;";
                    $param = array(':nombreAbreviado' => $lineaValue);
                    $data = DATA::Ejecutar($sql, $param);
                    if ($data) {
                        array_push($productos, $data[0]["id"]);
                    }
                }
            }
            if ($productos) {
                foreach ($productos as $item => $idProducto) {

                    $sql = "SELECT id, costoPromedio 
                    FROM insumosXBodega 
                    WHERE idProducto= :idProducto
                    AND idBodega = :idBodega;";
                    $param = array(':idProducto' => $idProducto, ':idBodega' => $factura[0]["idBodega"]);
                    $insumoXBodega = DATA::Ejecutar($sql, $param);

                    if ($producto_x_linea[0] == "08oz")
                        $porcion = 1;
                    else $porcion = 1.4285714;

                    if ($item == 2)
                        $porcion = 1;
                    // Entrada a inventario agencia.
                    InventarioInsumoXBodega::entrada($idProducto, $factura[0]["idBodega"], 'Nota Credito Fac#: ' . $factura[0]["consecutivo"], $porcion, $insumoXBodega[0]["costoPromedio"], false);
                }
                // ENTRADA DE CONSUMIBLES
                switch ($producto_x_linea[0]) {
                    case "12oz":
                        $tamano = 1;
                        break;
                    case "08oz":
                        $tamano = 0;
                        break;
                }
                Consumible::entrada($tamano, $factura[0]["idBodega"], $factura[0]["consecutivo"]);
            }

            $objFactura = new Factura();
            $objFactura->id = $idFactura;
            $objFactura->idDocumentoNC = 3;
            $objFactura->idReferencia = $factura[0]["consecutivo"];
            $objFactura->razon = $razon;
            if($nc == "false"){
                $objFactura->reenviarFactura();
            }
            else
                $objFactura->notaCredito();

        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => $e->getMessage()
            )));
        }
    }

    public static function ReadByIdFactura($idFactura)
    {
        try {
            $sql = "SELECT id, idFactura, idPrecio, numeroLinea, idTipoCodigo, codigo, cantidad, idUnidadMedida,
             unidadMedidaComercial, detalle, precioUnitario, montoTotal, montoDescuento, naturalezaDescuento, 
             subTotal, idCodigoImpuesto, idCodigoTarifa, tipoDocumento, tarifaImpuesto, montoImpuesto, montoTotalLinea,
                (SELECT clave FROM factura WHERE id=idFactura) AS clave
                from productosXFactura
                where idFactura = :id";
            $param = array(':id' => $idFactura);
            $data = DATA::Ejecutar($sql, $param);
            $lista = [];
            foreach ($data as $key => $value) {
                $producto = new ProductoXFactura();
                $producto->id = $value['id'];
                $producto->idFactura = $value['idFactura'];
                $producto->idPrecio = $value['idPrecio'];
                $producto->numeroLinea = $value['numeroLinea'];
                $producto->idTipoCodigo = $value['idTipoCodigo'];
                $producto->codigo = $value['codigo'];
                $producto->cantidad = $value['cantidad'];
                $producto->idUnidadMedida = $value['idUnidadMedida'];
                $producto->unidadMedidaComercial = $value['unidadMedidaComercial'];
                $producto->detalle = $value['detalle'];
                $producto->precioUnitario = $value['precioUnitario'];
                $producto->montoTotal = $value['montoTotal'];
                // descuentos                 
                $producto->montoDescuento = $value['montoDescuento'];
                $producto->naturalezaDescuento = $value['naturalezaDescuento'];
                //                
                $producto->subTotal = $value['subTotal'];
                // impuestos
                if (isset($value['idCodigoImpuesto'])) {
                    include_once('impuestos.php');
                    $producto->impuestos = [];
                    $imp = new Impuestos();
                    $imp->idCodigoImpuesto = $value['idCodigoImpuesto']; // Impuesto al Valor Agregado = 1
                    $imp->idCodigoTarifa = $value['idCodigoTarifa']; // Tarifa general 13% = 8
                    $imp->tarifaImpuesto = $value['tarifaImpuesto']; //  13%
                    $imp->montoImpuesto = $value['montoImpuesto'];
                    //$item->factorIVA= $itemImpuesto->factorIVA;
                    array_push($producto->impuestos, $imp);
                }
                // exoneraciones
                if (isset($value['tipoDocumento'])) {
                    include_once('exoneraciones.php');
                    $producto->exoneracion = [];
                    $exo = new Exoneraciones();
                    $exo->tipoDocumento = $value['tipoDocumento'] ?? null;
                    $exo->numeroDocumento = $value['numeroDocumento'] ?? null;
                    $exo->nombreInstitucion = $value['nombreInstitucion'] ?? null;
                    $exo->fechaEmision = $value['fechaEmision'] ?? null;
                    $exo->porcentaje = $value['porcentajeExoneracion'] ?? null;
                    $exo->monto = $value['montoExoneracion'] ?? null;
                    //$item->factorIVA= $itemImpuesto->factorIVA;
                    array_push($producto->exoneracion, $exo);
                }
                $producto->impuestoNeto = $value['impuestoNeto'] ?? null;
                //
                $producto->montoTotalLinea = $value['montoTotalLinea'];
                //$producto->claveFactura = $value['clave'];
                //
                array_push($lista, $producto);
            }
            return $lista;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            return false;
        }
    }

    public static function Create($obj)
    {
        try {
            $created = true;
            //$idUnidadMedida= 78;  // Unid.
            foreach ($obj as $item) {
                $sql = "INSERT INTO productosXFactura (id, idFactura, idPrecio, numeroLinea, idTipoCodigo, codigo, cantidad, 
                idUnidadMedida, detalle, precioUnitario, montoTotal, montoDescuento, naturalezaDescuento,
                        subTotal, idCodigoImpuesto, idCodigoTarifa, tarifaImpuesto, montoImpuesto, montoTotalLinea, impuestoNeto)
                    VALUES (uuid(), :idFactura, :idPrecio, :numeroLinea, :idTipoCodigo, :codigo, :cantidad, :idUnidadMedida, :detalle, :precioUnitario, :montoTotal, :montoDescuento, :naturalezaDescuento,                
                        :subTotal, :idCodigoImpuesto, :idCodigoTarifa, :tarifaImpuesto, :montoImpuesto, :montoTotalLinea, :impuestoNeto)";
                $param = array(
                    ':idFactura' => $item->idFactura,
                    ':idPrecio' => $item->idPrecio,
                    ':numeroLinea' => $item->numeroLinea,
                    ':idTipoCodigo' => $item->idTipoCodigo,
                    ':codigo' => $item->codigo,
                    ':cantidad' => $item->cantidad,
                    ':idUnidadMedida' => $item->idUnidadMedida,
                    ':detalle' => $item->detalle,
                    ':precioUnitario' => $item->precioUnitario,
                    ':montoTotal' => $item->montoTotal,
                    /* DESCUENTO */
                    ':montoDescuento' => $item->descuentos[0]->monto ?? null,
                    ':naturalezaDescuento' => $item->descuentos[0]->naturaleza ?? null,
                    ':subTotal' => $item->subTotal,
                    /* IVA */
                    ':idCodigoImpuesto' => $item->impuestos[0]->idCodigoImpuesto ?? null,
                    ':idCodigoTarifa' => $item->impuestos[0]->idCodigoTarifa ?? null,
                    ':tarifaImpuesto' => $item->impuestos[0]->tarifaImpuesto ?? null,
                    ':montoImpuesto' => $item->impuestos[0]->montoImpuesto ?? null,
                    /* EXONERACION */
                    // ':tipoDocumento' => $item->exoneraciones[0]->tipoDocumento ?? null,
                    // ':numeroDocumento' => $item->exoneraciones[0]->numeroDocumento ?? null,
                    // ':nombreInstitucion' => $item->exoneraciones[0]->nombreInstitucion ?? null,
                    // ':fechaEmision' => $item->exoneraciones[0]->fechaEmision ?? null,
                    // ':porcentajeExoneracion' => $item->exoneraciones[0]->porcentaje ?? null,
                    // ':montoExoneracion' => $item->exoneraciones[0]->monto ?? null,
                    ':impuestoNeto' => $item->impuestoNeto ?? null,
                    //
                    ':montoTotalLinea' => $item->montoTotalLinea
                );
                $data = DATA::Ejecutar($sql, $param, false);
            }
            return $created;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            return false;
        }
    }
}

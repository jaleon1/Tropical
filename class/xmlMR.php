<?php
include_once('mhHeader.php');
class xmlMR{
    static $arrayResp;

    public static function create($t){
        error_log('Iniciando creacion de MR XML');
        $transaccion= $t;
        //$esExonerado = false;
        //$esExento = false;
        // valida datos.
        if(!self::validar($transaccion))
            return self::$arrayResp;
        /*else {
            // busca valores de los ID.
            $transaccion->datosEntidad->idTipoIdentificacion = self::getIdentificacionCod($transaccion->datosEntidad->idTipoIdentificacion);
            $transaccion->datosReceptor->idTipoIdentificacion = self::getIdentificacionCod($transaccion->datosReceptor->idTipoIdentificacion);
            $transaccion->idSituacionComprobante =  self::getSituacionComprobanteCod($transaccion->idSituacionComprobante);
            $ubicacionEntidadCod= self::getUbicacionCod($transaccion->datosEntidad->idProvincia, $transaccion->datosEntidad->idCanton, $transaccion->datosEntidad->idDistrito, $transaccion->datosEntidad->idBarrio);
            $transaccion->idCondicionVenta = self::getCondicionVentaCod($transaccion->idCondicionVenta);
            //$transaccion->idEstadoComprobante = self::getEstadoComprobanteCod($transaccion->idEstadoComprobante);
            $transaccion->idCodigoMoneda = self::getCodigoMonedaCod($transaccion->idCodigoMoneda);
            $transaccion->idMedioPago = self::getMedioPagoCod($transaccion->idMedioPago);
        }*/
        // crea XML
        // Detalles Generales.        
        $xmlString = '<?xml version="1.0" encoding="utf-8"?>'
            .mhHeader::mr43.            
            '<Clave>' . $transaccion->claveDocumento . '</Clave>
            <NumeroCedulaEmisor>' . $transaccion->identificacionEmisor . '</NumeroCedulaEmisor>
            <FechaEmisionDoc>' . $transaccion->fechaEmisionDocumento . '</FechaEmisionDoc>
            <Mensaje>' . $transaccion->mensaje . '</Mensaje>
            <DetalleMensaje>' . $transaccion->detalle . '</DetalleMensaje>';
            if(isset($transaccion->totalImpuesto))
                $xmlString .= '<MontoTotalImpuesto>' . $transaccion->totalImpuesto . '</MontoTotalImpuesto>';
            $xmlString .= '<TotalFactura>' . $transaccion->totalComprobante . '</TotalFactura>
            <NumeroCedulaReceptor>' . $transaccion->identificacionReceptor . '</NumeroCedulaReceptor>
            <NumeroConsecutivoReceptor>' . $transaccion->consecutivoFE . '</NumeroConsecutivoReceptor>
            </MensajeReceptor>';
        //
        $arrayResp = array(
            "clave" => $transaccion->clave,
            //"xml"   => base64_encode($xmlString)
            "xml"   => $xmlString
        );
        // echo htmlentities($xmlString);
        // file_put_contents('t_fe.xml', $xmlString);
        return $arrayResp;
    }


    private static function validar($transaccion){
        // busca valores de datos relacionados con otras tablas.
        //self::getIdValues($transaccion);
        //
        if(empty($transaccion->clave)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (clave) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->consecutivo)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (consecutivo) no debe ser nulo o vacio'
            );
            return false;
        }
        // EMISOR - vendedor
        if(empty($transaccion->identificacionEmisor)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (identificacionEmisor) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->identificacionReceptor)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (identificacionReceptor) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->totalComprobante)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (totalComprobante) no debe ser nulo o vacio'
            );
            return false;
        }
        return true;
    }


}

?>
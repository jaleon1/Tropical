<?php
include_once('mhHeader.php');
class xmlTE{
    static $arrayResp;

    public static function create($t){
        error_log('Iniciando creacion de TE XML');
        $transaccion= $t;
        $esExonerado = false;
        $esExento = false;
        // valida datos.
        if(!self::validar($transaccion))
            return self::$arrayResp;
        else {
            // busca valores de los ID.
            $transaccion->datosEntidad->idTipoIdentificacion = self::getIdentificacionCod($transaccion->datosEntidad->idTipoIdentificacion);            
            $transaccion->idSituacionComprobante =  self::getSituacionComprobanteCod($transaccion->idSituacionComprobante);
            $ubicacionEntidadCod= self::getUbicacionCod($transaccion->datosEntidad->idProvincia, $transaccion->datosEntidad->idCanton, $transaccion->datosEntidad->idDistrito, $transaccion->datosEntidad->idBarrio);
            $transaccion->idCondicionVenta = self::getCondicionVentaCod($transaccion->idCondicionVenta);
            //$transaccion->idEstadoComprobante = self::getEstadoComprobanteCod($transaccion->idEstadoComprobante);
            $transaccion->idCodigoMoneda = self::getCodigoMonedaCod($transaccion->idCodigoMoneda);
            $transaccion->idMedioPago = self::getMedioPagoCod($transaccion->idMedioPago);
        }
        // crea XML
        // Detalles Generales.        
        $xmlString = '<?xml version="1.0" encoding="utf-8"?>'
            .mhHeader::te43.            
            '<Clave>' . $transaccion->clave . '</Clave>
            <CodigoActividad>'  . $transaccion->datosEntidad->idCodigoActividad .  '</CodigoActividad>
            <NumeroConsecutivo>' . $transaccion->consecutivoFE . '</NumeroConsecutivo>
            <FechaEmision>' . $transaccion->fechaEmision->format("c") . '</FechaEmision>
            <Emisor>
                <Nombre>' . $transaccion->datosEntidad->nombre . '</Nombre>
                <Identificacion>
                    <Tipo>' . $transaccion->datosEntidad->idTipoIdentificacion . '</Tipo>
                    <Numero>' . $transaccion->datosEntidad->identificacion . '</Numero>
                </Identificacion>';
        if(!empty($transaccion->datosEntidad->nombreComercial))
            $xmlString .= '<NombreComercial>' . $transaccion->datosEntidad->nombreComercial . '</NombreComercial>';
        // UBICACION
        $xmlString .= '
                <Ubicacion>
                    <Provincia>' . $ubicacionEntidadCod[0]->provincia . '</Provincia>
                    <Canton>' . $ubicacionEntidadCod[0]->canton . '</Canton>
                    <Distrito>' . $ubicacionEntidadCod[0]->distrito . '</Distrito>';
            if (!empty($ubicacionEntidadCod[0]->barrio))
                $xmlString .= '<Barrio>' . $ubicacionEntidadCod[0]->barrio . '</Barrio>';
            $xmlString .= '
                    <OtrasSenas>' . $transaccion->datosEntidad->otrasSenas . '</OtrasSenas>
                </Ubicacion>';
        // TELEFONO    
        if (!empty($transaccion->datosEntidad->numTelefono)){
            $xmlString .= '
                <Telefono>
                    <CodigoPais>' . 506 . '</CodigoPais>
                    <NumTelefono>' . $transaccion->datosEntidad->numTelefono. '</NumTelefono>
                </Telefono>';
        }
        // FAX
        /*if (!empty($transaccion->datosEntidad->numTelefonoFax))
        {
            $xmlString .= '
                <Fax>
                    <CodigoPais>' . $transaccion->datosEntidad->idCodigoPaisFax ?? 506 . '</CodigoPais>
                    <NumTelefono>' . $transaccion->datosEntidad->numTelefonoFax . '</NumTelefono>
                </Fax>';
        }*/
        // CORREO
        $xmlString .= '<CorreoElectronico>' . $transaccion->datosEntidad->correoElectronico . '</CorreoElectronico></Emisor>';
        // datos de la venta.
        $xmlString .= '<CondicionVenta>' . $transaccion->idCondicionVenta . '</CondicionVenta>';
        if (!empty($transaccion->plazoCredito))
            $xmlString .= '<PlazoCredito>' . $transaccion->plazoCredito . '</PlazoCredito>';
        $xmlString .= '<MedioPago>' . $transaccion->idMedioPago . '</MedioPago>
            <DetalleServicio>';
        // Linea detalle de la factura.
        $l = 1;
        foreach($transaccion->detalleFactura as $d){
            $xmlString .= '<LineaDetalle>
                      <NumeroLinea>' . $l . '</NumeroLinea>
                      <Cantidad>' . $d->cantidad . '</Cantidad>
                      <UnidadMedida>' . self::getUnidadMedidaCod($d->idUnidadMedida) . '</UnidadMedida>';
            if (!empty($d->detalle))
                $xmlString .= '<Detalle>' . $d->detalle . '</Detalle>';
            $xmlString .= '<PrecioUnitario>' . $d->precioUnitario . '</PrecioUnitario>
                      <MontoTotal>' . $d->montoTotal . '</MontoTotal>';
            // DESCUENTOS.
            if (isset($d->montoDescuento) && !empty($d->montoDescuento)){
                $xmlString .= '<Descuento><MontoDescuento>' . $d->montoDescuento . '</MontoDescuento>';
                //    
                if (isset($d->naturalezaDescuento) && !empty($d->naturalezaDescuento))
                    $xmlString .= '<NaturalezaDescuento>' . $d->naturalezaDescuento . '</NaturalezaDescuento>';
                $xmlString .= '</Descuento>';
            }
            //    
            $xmlString .= '<SubTotal>' . $d->subTotal . '</SubTotal>';
            // BASE IMPONIBLE, codigo impuesto = 07  **** PENDIENTE ****
            // IMPUESTOS. **** PENDIENTE   Factor IVA  ****  
            if (isset($d->impuestos[0]->idCodigoImpuesto) && !empty($d->impuestos[0]->idCodigoImpuesto)){ 
                //if($d->idCodigoTarifa != "1") // 1 = exento de impuesto. Se elimina el tag o se envia en CERO??
                foreach ($d->impuestos as $key => $imp){
                    if($imp->idCodigoImpuesto == '7'){
                        $xmlString .= '<BaseImponible>' . $imp->baseImponible . '</BaseImponible>';
                    }
                    $xmlString .= '<Impuesto>
                    <Codigo>' . self::getImpuestoCod($imp->idCodigoImpuesto) . '</Codigo> 
                    <CodigoTarifa>'. self::getTarifaCod($imp->idCodigoTarifa) .'</CodigoTarifa>
                    <Tarifa>' . $imp->tarifa . '</Tarifa>
                    <Monto>' . $imp->monto . '</Monto>'; 
                }                               
            }
            // EXONERACION. NO APLICA PARA TE. UNA EXONERACION SIEMPRE TIENE RECEPTOR.
            $xmlString .= '</Impuesto>';
            if (isset($d->tipoDocumento) && !empty($d->tipoDocumento))
                $xmlString .= '<ImpuestoNeto>' . $d->impuestoNeto . '</ImpuestoNeto>';
            $xmlString .= '<MontoTotalLinea>' . $d->montoTotalLinea . '</MontoTotalLinea>';
            // **** PENDIENTE OtrosCargos  ****
            $xmlString .= '</LineaDetalle>';
            $l++;
        }
        // RESUMEN DE FACTURA
        $xmlString .= '</DetalleServicio> <ResumenFactura>';
        if(!empty($transaccion->idCodigoMoneda) && $transaccion->idCodigoMoneda != 55){
            $xmlString .= '<CodigoTipoMoneda>
                <CodigoMoneda>'  .$transaccion->idCodigoMoneda.  '</CodigoMoneda>
                <TipoCambio>'  .$transaccion->tipoCambio.  '</TipoCambio>
            </CodigoTipoMoneda>';
        }
        //
        $xmlString .= '<TotalServGravados>' . $transaccion->totalServGravados . '</TotalServGravados>';
        // SI LA FACTURA TIENE EXONERACION.        
        if ($esExonerado)
            $xmlString .= '<TotalServExonerado>' . $transaccion->totalServExonerado . '</TotalServExonerado>';
        $xmlString .= '<TotalMercanciasGravadas>' . $transaccion->totalMercanciasGravadas . '</TotalMercanciasGravadas>';
        if ($esExonerado)
            $xmlString .= '<TotalMercExonerada>' . $transaccion->totalMercanciasExonerada . '</TotalMercExonerada>';
        $xmlString .= '<TotalGravado>' . $transaccion->totalGravado . '</TotalGravado>';
        if ($esExonerado)
            $xmlString .= '<TotalExonerado>' . $transaccion->totalExonerado . '</TotalExonerado>';
        
        // EXENTOS. *** PENDIENTE ***
        // if ($esExento){
        // <TotalServExentos>' . $transaccion->totalServExentos . '</TotalServExentos>
        // <TotalMercanciasExentas>' . $transaccion->totalMercanciasExentas . '</TotalMercanciasExentas>
        // <TotalExento>' . $transaccion->totalExento . '</TotalExento>
        //
        $xmlString .= '<TotalVenta>' . $transaccion->totalVenta . '</TotalVenta>
            <TotalDescuentos>' . $transaccion->totalDescuentos . '</TotalDescuentos>
            <TotalVentaNeta>' . $transaccion->totalVentaneta . '</TotalVentaNeta>
            <TotalImpuesto>' . $transaccion->totalImpuesto . '</TotalImpuesto>
            <TotalComprobante>' . $transaccion->totalComprobante . '</TotalComprobante>
            </ResumenFactura>';
        // referencias /**** PENDIENTE ****/
        foreach($transaccion->informacionReferencia as $ref){
            //self::getDocumentoReferenciaCod();
            //self::getReferenciaCod()
            $xmlString.= '
                <InformacionReferencia>
                    <TipoDoc>' . $ref->tipodoc . '</TipoDoc> 
                    <Numero>' . $ref->numero . '</Numero>
                    <FechaEmision>' .$ref->fechaEmision->format("c") . '</FechaEmision>
                    <Codigo>' . $ref->codigo . '</Codigo>
                    <Razon>' . $ref->razon . '</Razon>
                </InformacionReferencia>';            
        }
        // **** PENDITENTE OTROS ****
        if (!empty($transaccion->otros) && $otrosType != '')
        {
            $tipos = array("Otros", "OtroTexto", "OtroContenido");
            if (in_array($otrosType, $tipos))
            {
                $xmlString .= '
                    <Otros>
                <' . $otrosType . '>' . $otros . '</' . $otrosType . '>
                </Otros>';
            }
        }  
        //
        $xmlString .= '</TiqueteElectronico>';
        //
        $arrayResp = array(
            "clave" => $transaccion->clave,
            //"xml"   => base64_encode($xmlString)
            "xml"   => $xmlString
        );
        //echo htmlentities($xmlString);
        return $arrayResp;
    }

    private static function getIdValues($transaccion){

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
        if(empty($transaccion->datosEntidad->idCodigoActividad)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (idCodigoActividad) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->consecutivoFE)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El consecutivoFE no debe ser nulo o vacia'
            );
            return false;
        }
        if(empty($transaccion->fechaEmision)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (fechaEmision) no debe ser nulo o vacio'
            );
            return false;
        }
        // EMISOR
        if(empty($transaccion->datosEntidad->nombre)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (datosEntidad->nombre) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->datosEntidad->idTipoIdentificacion)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (datosEntidad->idTipoIdentificacion) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->datosEntidad->identificacion)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (datosEntidad->identificacion) no debe ser nulo o vacio'
            );
            return false;
        }
        // EMISOR:UBICACION
        if(empty($transaccion->datosEntidad->idProvincia)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (datosEntidad->idProvincia) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->datosEntidad->idCanton)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (datosEntidad->idCanton) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->datosEntidad->idDistrito)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (datosEntidad->idDistrito) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->datosEntidad->otrasSenas)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (datosEntidad->otrasSenas) no debe ser nulo o vacio'
            );
            return false;
        }
        //
        if(empty($transaccion->datosEntidad->correoElectronico)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (datosEntidad->correoElectronico) no debe ser nulo o vacio'
            );
            return false;
        }        
        // DETALLES DE LA VENTA.
        if(empty($transaccion->idCondicionVenta)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (idCondicionVenta) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->idMedioPago)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (idMedioPago) no debe ser nulo o vacio'
            );
            return false;
        }
        // LINEA DETALLE
        foreach($transaccion->detalleFactura as $d){
            if(empty($d->cantidad)){
                self::$arrayResp = array(
                    "error" => 'Error al construir XML de FE',
                    "mensaje" => 'El valor (cantidad) no debe ser nulo o vacio'
                );
                return false;
            }
            if(empty($d->idUnidadMedida)){
                self::$arrayResp = array(
                    "error" => 'Error al construir XML de FE',
                    "mensaje" => 'El valor (idUnidadMedida) no debe ser nulo o vacio'
                );
                return false;
            }
            if(empty($d->precioUnitario)){
                self::$arrayResp = array(
                    "error" => 'Error al construir XML de FE',
                    "mensaje" => 'El valor (precioUnitario) no debe ser nulo o vacio'
                );
                return false;
            }
            if(empty($d->montoTotal)){
                self::$arrayResp = array(
                    "error" => 'Error al construir XML de FE',
                    "mensaje" => 'El valor (montoTotal) no debe ser nulo o vacio'
                );
                return false;
            }
            if(empty($d->subTotal)){
                self::$arrayResp = array(
                    "error" => 'Error al construir XML de FE',
                    "mensaje" => 'El valor (subTotal) no debe ser nulo o vacio'
                );
                return false;
            }
            if(!empty($d->impuestos)){
                foreach ($d->impuestos as $key => $imp){
                    
                    if(empty($imp->idCodigoImpuesto)){
                        self::$arrayResp = array(
                            "error" => 'Error al construir XML de FE',
                            "mensaje" => 'El valor (idCodigoImpuesto) no debe ser nulo o vacio'
                        );
                        return false;
                    }

                    if(empty($imp->idCodigoTarifa)){
                        self::$arrayResp = array(
                            "error" => 'Error al construir XML de FE',
                            "mensaje" => 'El valor (codigoTarifa) no debe ser nulo o vacio'
                        );
                        return false;
                    }

                    if(empty($imp->tarifaImpuesto)){
                        self::$arrayResp = array(
                            "error" => 'Error al construir XML de FE',
                            "mensaje" => 'El valor (tarifa) no debe ser nulo o vacio'
                        );
                        return false;
                    }

                    if(empty($imp->montoImpuesto)){
                        self::$arrayResp = array(
                            "error" => 'Error al construir XML de FE',
                            "mensaje" => 'El valor (monto) no debe ser nulo o vacio'
                        );
                        return false;
                    }
                }

            }else{
                self::$arrayResp = array(
                    "error" => 'Error al construir XML de FE',
                    "mensaje" => 'El valor (impuestos) no debe ser nulo o vacio'
                );
                return false;
            }
            if(empty($d->montoTotalLinea)){
                self::$arrayResp = array(
                    "error" => 'Error al construir XML de FE',
                    "mensaje" => 'El valor (montoTotalLinea) no debe ser nulo o vacio'
                );
                return false;
            }
        }
        // RESUMEN
        if(empty($transaccion->totalVenta)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (totalVenta) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->totalDescuentos)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (totalDescuentos) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->totalVentaneta)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (totalVentaneta) no debe ser nulo o vacio'
            );
            return false;
        }
        if(empty($transaccion->totalImpuesto)){
            self::$arrayResp = array(
                "error" => 'Error al construir XML de FE',
                "mensaje" => 'El valor (totalImpuesto) no debe ser nulo o vacio'
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

    private static function getIdentificacionCod($id){
        try{
            $sql='SELECT codigo
                FROM tipoIdentificacion
                WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
                return $data[0]['codigo'];
            else throw new Exception('Error al consultar el codigo de tipo de identificacion' , ERROR_TIPO_IDENTIFICACION_NO_VALID);
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_TIPO_IDENTIFICACION_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getSituacionComprobanteCod($id){
        try{
            $sql='SELECT codigo
            FROM situacionComprobante
            WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
            {
                switch($data[0]['codigo']){
                    case '1':
                        return 'normal';
                    break;
                        case '2':
                        return 'contingencia';
                    break;
                        case '3':
                        return 'sinInternet';
                    break;
                    
                }
            }
            else throw new Exception('Error al consultar el codigo de situacion comprobante' , ERROR_SITUACION_COMPROBANTE_NO_VALID);
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_SITUACION_COMPROBANTE_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getDocumentoReferencia($id){
        try{
            switch($id){
                case '1':
                case '8': // El API  no tiene opción para enviar documento por contingencia.
                    return 'FE';
                    break;
                case '2':
                    return 'ND';
                    break;
                case '3':
                    return 'NC';
                    break;
                case '4':
                    return 'TE';
                    break;
                    case '5':
                return 'CCE';
                    break;
                    case '6':
                return 'CPCE';
                    break;
                case '7':
                    return 'RCE';
                    break;
                default: 
                    throw new Exception('Error al consultar el codigo de referencia' , ERROR_CODIGO_REFERENCIA_NO_VALID);
                    break;
            }            
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_CODIGO_REFERENCIA_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getDocumentoReferenciaCod($id){
        try{
            $sql='SELECT codigo
                FROM documentoReferencia
                WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
                return $data[0]['codigo'];
            else throw new Exception('Error al consultar el codigo de tipod de identificacion' , ERROR_CODIGO_REFERENCIA_NO_VALID);
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_CODIGO_REFERENCIA_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getReferenciaCod($id){
        try{
            $sql='SELECT codigo
                FROM referencia
                WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
                return $data[0]['codigo'];
            else throw new Exception('Error al consultar el codigo de tipod de identificacion' , ERROR_REFERENCIA_NO_VALID);
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_REFERENCIA_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getImpuestoCod($id){
        try{
            $sql='SELECT codigo
            FROM impuesto
            WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
                return $data[0]['codigo'];
            else throw new Exception('Error al consultar el codigo del impuesto' , ERROR_IMPUESTO_NO_VALID);
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_IMPUESTO_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getTarifaCod($id){
        try{
            $sql='SELECT codigo
            FROM tarifa
            WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
                return $data[0]['codigo'];
            else throw new Exception('Error al consultar el codigo del impuesto' , ERROR_IMPUESTO_NO_VALID);
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_IMPUESTO_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getDocumentoExoneracionAutorizacionCod($id){
        try{
            $sql='SELECT codigo
                FROM documentoExoneracionAutorizacion
                WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
                return $data[0]['codigo'];
            else throw new Exception('Error al consultar el codigo del impuesto' , ERROR_IMPUESTO_NO_VALID);
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_IMPUESTO_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getUnidadMedidaCod($id){
        try{
            $sql='SELECT simbolo
                FROM unidadMedida
                WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
                return $data[0]['simbolo'];
            else throw new Exception('Error al consultar el codigo de unidad medida' , ERROR_UNIDAD_MEDIDA_NO_VALID);
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_UNIDAD_MEDIDA_NO_VALID '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getUbicacionCod($idProvincia, $idCanton, $idDistrito, $idBarrio=1){
        try{
            $sql='SELECT p.codigo as provincia, c.codigo as canton, d.codigo as distrito, b.codigo as barrio
                FROM provincia p, canton c , distrito d, barrio b        
                where p.id=:provincia and c.id=:canton and d.id=:distrito and b.id=:barrio';
            $param= array(':provincia'=>$idProvincia, 
                ':canton'=>$idCanton,
                ':distrito'=>$idDistrito,
                ':barrio'=>$idBarrio??1,
            );
            $data= DATA::Ejecutar($sql,$param);
            $ubicacion= [];
            if($data){
                $item= new UbicacionCod();
                $item->provincia= $data[0]['provincia'];
                $item->canton= $data[0]['canton'];
                $item->distrito= $data[0]['distrito'];
                $item->barrio= $data[0]['barrio'];
                array_push($ubicacion, $item);
            }
            else throw new Exception('Error al consultar el codigo de la ubicacion' , ERROR_UBICACION_NO_VALID);
            return $ubicacion;            
        } 
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_UBICACION_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getMedioPagoCod($id){
        try{
            $sql='SELECT codigo
            FROM medioPago
            WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
                return $data[0]['codigo'];
            else throw new Exception('Error al consultar el codigo del medio de pago' , ERROR_MEDIOPAGO_NO_VALID);
        } 
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_MEDIOPAGO_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getCodigoMonedaCod($id){
        try{
            $sql='SELECT codigo
            FROM moneda
            WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
                return $data[0]['codigo'];
            else throw new Exception('Error al consultar el codigo de moneda' , ERROR_MONEDA_NO_VALID);
        } 
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_MONEDA_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getEstadoComprobanteCod($id){
        try{
            $sql='SELECT codigo
            FROM estadoComprobante
            WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
                return $data[0]['codigo'];
            else throw new Exception('Error al consultar el codigo de estado del comprobante' , ERROR_ESTADO_COMPROBANTE_NO_VALID);
        } 
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_ESTADO_COMPROBANTE_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }

    private static function getCondicionVentaCod($id){
        try{
            $sql='SELECT codigo
            FROM impuesto
            WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);     
            if($data)
                return $data[0]['codigo'];
            else throw new Exception('Error al consultar el codigo de Condicion venta' , ERROR_CONDICIONVENTA_NO_VALID);
        } 
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEntidad, self::$transaccion->idDocumento, 5, 'ERROR_CONDICIONVENTA_NO_VALID: '. $e->getMessage());
            Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$fechaEmision->format("c"));
        }
    }
}

?>
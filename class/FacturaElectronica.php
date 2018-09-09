<?php
define('ERROR_USERS_NO_VALID', '-500');
define('ERROR_TOKEN_NO_VALID', '-501');
define('ERROR_CLAVE_NO_VALID', '-502');

class FacturaElectronica{
    static $transaccion;

    public static function iniciar($t){
        try{
            self::$transaccion= $t;
            if(!isset($_SESSION['API']))
                throw new Exception('Error al guardar el certificado. '. $error_msg , ERROR_USERS_NO_VALID);
            self::APIGetToken();
            self::APICrearClave();
            self::APICrearXML();
        } 
        catch(Exception $e) {
            error_log("****** Error: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public static function APIGetToken(){
        try{
            $url= 'http://localhost/api.php';  
            $ch = curl_init();
            $post = [
                'w' => 'token',
                'r' => 'gettoken',
                'grant_type'=>'password', 
                'client_id'=> 'api-stag', 
                'username' => $_SESSION['API']->username,
                'password'=>  $_SESSION['API']->password
            ];
            curl_setopt_array($ch, array(
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,   
                CURLOPT_VERBOSE => true,                      
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $post
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                throw new Exception('Error al guardar el certificado. '. $error_msg , 033);
            }
            $sArray= json_decode($server_output);
            if(!isset($sArray->resp->access_token)){
                // ERROR CRÍTICO:
                // debe notificar al contibuyente. 
                throw new Exception('Error crítico al Solicitar token MH. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , ERROR_TOKEN_NO_VALID);
            }
            $_SESSION['API']->accessToken=$sArray->resp->access_token;
            $_SESSION['API']->expiresIn=$sArray->resp->expires_in;
            $_SESSION['API']->refreshExpiresIn=$sArray->resp->refresh_expires_in;
            $_SESSION['API']->refreshToken=$sArray->resp->refresh_token;
            error_log(" resp : ". $server_output);
            curl_close($ch);
            return true;
        } 
        catch(Exception $e) {
            error_log("****** Error: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public function APICrearClave(){
        try{
            $url= 'http://localhost/api.php';  
            $ch = curl_init();
            $post = [
                'w' => 'clave',
                'r' => 'clave',
                'tipoCedula'=>'fisico', 
                'cedula'=> $_SESSION['API']->identificacion,
                'situacion' => 'normal',
                'codigoPais'=> '506',
                'consecutivo'=> self::$transaccion->consecutivo,
                'codigoSeguridad'=> $_SESSION['API']->codigoSeguridad,
                'tipoDocumento'=> 'FE',
                'terminal'=> self::$transaccion->terminal,
                'sucursal'=> self::$transaccion->local
            ];
            curl_setopt_array($ch, array(
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,   
                CURLOPT_VERBOSE => true,                      
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $post
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                throw new Exception('Error al guardar el certificado. '. $error_msg , 033);
            }
            $sArray= json_decode($server_output);
            if(!isset($sArray->resp->clave)){
                // ERROR CRÍTICO:
                // debe notificar al contibuyente. 
                throw new Exception('Error crítico al crear clave MH. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , ERROR_CLAVE_NO_VALID);
            }
            $_SESSION['API']->clave= $sArray->resp->clave;
            $_SESSION['API']->consecutivo= $sArray->resp->consecutivo;
            error_log(" resp : ". $server_output);
            curl_close($ch);
            return true;
        } 
        catch(Exception $e) {
            error_log("****** Error: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public function APICrearXML(){
        try{
            $url= 'http://localhost/api.php';  
            $ch = curl_init();
            // detalle de la factura
            $detalles=[];
            foreach(self::$transaccion->detalleFactura as $d){
                array_push($detalles, array('cantidad'=> $d->cantidad,
                    'unidadMedida'=> 'Unid',
                    'detalle'=> $d->detalle,
                    'precioUnitario'=> $d->precioUnitario,
                    'montoTotal'=> $d->montoTotal,
                    'subtotal'=> $d->subTotal,
                    'montoTotalLinea'=> $d->montoTotalLinea,
                    'impuesto'=> array(array(
                        'codigo'=> $d->codigoImpuesto,
                        'tarifa'=> $d->tarifaImpuesto,
                        'monto'=> $d->montoImpuesto
                        )
                    )
                    )
                );
            }            
            //
            $post = [
                'w' => 'genXML',
                'r' => 'gen_xml_fe',
                'clave'=> $_SESSION['API']->clave,
                'consecutivo'=> $_SESSION['API']->consecutivo,
                'fecha_emision' => self::$transaccion->fechaEmision, // ej: '2018-09-09T13:41:00-06:00',
                /** Emisor **/
                'emisor_nombre'=> $_SESSION['API']->nombre,
                'emisor_tipo_indetif'=> '01', //$_SESSION['API']->idTipoIdentificacion,
                'emisor_num_identif'=> $_SESSION['API']->identificacion,
                'nombre_comercial'=> $_SESSION['API']->nombreComercial,
                'emisor_provincia'=> $_SESSION['API']->idProvincia,
                'emisor_canton'=> $_SESSION['API']->idCanton,
                'emisor_distrito'=> $_SESSION['API']->idDistrito,
                'emisor_barrio'=> $_SESSION['API']->idBarrio,
                'emisor_otras_senas'=> $_SESSION['API']->otrasSenas,
                // 'emisor_cod_pais_tel'=> '506',
                // 'emisor_tel'=> $_SESSION['API']->numTelefono,
                // 'emisor_cod_pais_fax'=> '506',
                // 'emisor_fax'=> '00000000',
                'emisor_email'=> $_SESSION['API']->correoElectronico,
                /** Receptor **/
                'receptor_nombre'=> 'temporal temporal',
                'receptor_tipo_identif'=> '01',
                'receptor_num_identif'=> '101230123',
                'receptor_provincia'=> '1',
                'receptor_canton'=> '01',
                'receptor_distrito'=> '01',
                'receptor_barrio'=> '01',
                // 'receptor_cod_pais_tel'=> '506',
                // 'receptor_tel'=> '84922891',
                // 'receptor_cod_pais_fax'=> '506',
                // 'receptor_fax'=> '00000000',
                'receptor_email'=> 'temporal.temporal@temp.com',
                /** Datos de la venta **/
                'condicion_venta'=> '01', /*** debe ser dinamico***/
                // 'plazo_credito'=> '0',
                'medio_pago'=> self::$transaccion->idMedioPago,
                'cod_moneda'=> 'CRC',
                'tipo_cambio'=> '564.48',
                'total_serv_gravados'=> '0',
                'total_serv_exentos'=> '10000',
                'total_merc_gravada'=> '10000',
                'total_merc_exenta'=> '0',
                'total_gravados'=> '10000',
                'total_exentos'=> '10000',
                'total_ventas'=> '20000',
                'total_descuentos'=> '100',
                'total_ventas_neta'=> '19900',
                'total_impuestos'=> '1170',
                'total_comprobante'=> '21070',
                'otros'=> 'Muchas gracias',
                /** Detalle **/
                'detalles'=>  json_encode($detalles, JSON_FORCE_OBJECT)
            ];
            curl_setopt_array($ch, array(
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,   
                CURLOPT_VERBOSE => true,                      
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30000000,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $post
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                throw new Exception('Error al guardar el certificado. '. $error_msg , 033);
            }
            $sArray= json_decode($server_output);
            $_SESSION['API']->xml= $sArray->resp->xml;
            error_log(" resp : ". $server_output);
            curl_close($ch);
            return true;
        } 
        catch(Exception $e) {
            error_log("****** Error: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public function APICifrarXml(){
        try{
            $url= 'http://localhost/api.php';  
            $ch = curl_init();
            $post = [
                'w' => 'signXML',
                'r' => 'signFE',
                'p12Url'=>'24081a92226d94fffee558aaa6acb563',  /** DEBE SER DINAMICO **/
                'inXml'=> $_SESSION['API']->xml,
                'pinP12' => $_SESSION['API']->pinp12,
                'tipodoc'=> 'FE'
            ];
            curl_setopt_array($ch, array(
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,   
                CURLOPT_VERBOSE => true,                      
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $post
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                throw new Exception('Error al guardar el certificado. '. $error_msg , 033);
            }
            $sArray= json_decode($server_output);
            $_SESSION['API']->xmlFirmado= $sArray->resp->xmlFirmado;
            error_log(" resp : ". $server_output);
            curl_close($ch);
            return true;
        } 
        catch(Exception $e) {
            error_log("****** Error: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public function APIEnviar(){
        try{
            $this->APIGetToken();
            $url= 'http://localhost/api.php';  
            $ch = curl_init();
            $post = [
                'w' => 'send',
                'r' => 'json',
                'token'=>$_SESSION['API']->accessToken,
                'clave'=> $_SESSION['API']->clave,
                'fecha' => '2018-09-09T13:41:00-06:00', // misma del xml.
                'emi_tipoIdentificacion'=> $_SESSION['API']->idTipoIdentificacion,
                'emi_numeroIdentificacion'=> $_SESSION['API']->identificacion,
                'recp_tipoIdentificacion'=> '01',
                'recp_numeroIdentificacion'=> '000000000',
                'comprobanteXml'=>	$_SESSION['API']->xmlFirmado,
                'client_id'=> 'api-stag' // api-prod
            ];
            curl_setopt_array($ch, array(
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,   
                CURLOPT_VERBOSE => true,                      
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $post
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                throw new Exception('Error al guardar el certificado. '. $error_msg , 033);
            }
            $sArray= json_decode($server_output);
            $_SESSION['API']->xmlFirmado= $sArray->resp->xmlFirmado;
            error_log(" resp : ". $server_output);
            curl_close($ch);
            return true;
        } 
        catch(Exception $e) {
            error_log("****** Error: ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public function APIConsultaComprobante(){
        try{
            error_log("API LOGIN ... ");
            //$url= 'http://104.131.5.198/api.php';
            $url= 'localhost/api.php';
            $ch = curl_init();
            $post = [
                'w' => 'consultar',
                'r' => 'consultarCom',
                'token'=>$_SESSION['API']->accessToken,
                'clave'=> $_SESSION['API']->clave,
                'client_id'=> 'api-stag' // api-prod
            ];  
            curl_setopt_array($ch, array(
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,   
                CURLOPT_VERBOSE => true,      
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 300,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $post
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                error_log("error: ". $error_msg);
                throw new Exception('Error al iniciar login API. '. $error_msg , 02);
            }
            curl_close($ch);
            // session de usuario ATV
            $sArray=json_decode($server_output);
                $this->indEstado= $sArray->resp->sessionKey;
            $_SESSION['API']->sessionKey= $this->sessionKey;
            error_log("sessionKey: ". $sArray->resp->sessionKey);
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
}
?>
<?php
include_once('historico.php');
require(dirname(__FILE__) . '/firmador/hacienda/firmador.php');

use Hacienda\Firmador;

require_once("invoice.php");
//
define('ERROR_USERS_NO_VALID', '-500');
define('ERROR_TOKEN_NO_VALID', '-501');
define('ERROR_CLAVE_NO_VALID', '-502');
define('ERROR_FEXML_NO_VALID', '-503');
define('ERROR_ENVIO_NO_VALID', '-504');
define('ERROR_ENVIOERR_NO_VALID', '-505');
define('ERROR_CONSULTA_NO_VALID', '-506');
define('ERROR_IMPUESTO_NO_VALID', '-507');
define('ERROR_MEDIOPAGO_NO_VALID', '-508');
define('ERROR_CERTIFICADOURL_NO_VALID', '-509');
define('ERROR_UBICACION_NO_VALID', '-510');
define('ERROR_SITUACION_COMPROBANTE_NO_VALID', '-511');
define('ERROR_TIPO_IDENTIFICACION_NO_VALID', '-512');
define('ERROR_UNIDAD_MEDIDA_NO_VALID', '-513');
define('ERROR_CONDICIONVENTA_NO_VALID', '-514');
define('ERROR_MONEDA_NO_VALID', '-515');
define('ERROR_ESTADO_COMPROBANTE_NO_VALID', '-516');
define('ERROR_CIFRAR_NO_VALID', '-517');
define('ERROR_CODIGO_REFERENCIA_NO_VALID', '-518');
define('ERROR_INICIAL', '-519');
define('ERROR_LECTURA_CONFIG', '-520');
define('ERROR_NDXML_NO_VALID', '-521');
define('ERROR_NCXML_NO_VALID', '-522');
define('ERROR_REFERENCIA_NO_VALID', '-523');
define('SSL_API', '0');

class FacturacionElectronica
{
    static $distr = false;
    static $transaccion;
    // static $fechaEmision;
    // static $apiUrl;
    // static $accessToken;
    // static $expiresIn;
    // static $refreshExpiresIn;
    // static $refreshToken;
    static $clave;
    // static $consecutivoFE;
    // static $xml;
    // static $xmlFirmado;
    static $apiMode;
    static $arrayResp;
    static $grant_type = 'password'; // 'refresh_token';

    public static function iniciarNC($t)
    {
        try {
            //date_default_timezone_set('America/Costa_Rica');
            self::$transaccion = $t;
            self::$transaccion->fechaEmision = date_create();
            // fe o nc
            self::$transaccion->idDocumento = 3; // NC

        } catch (Exception $e) {
            if (!self::$distr)
                Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$transaccion->fechaEmision->format("c"));
            else Distribucion::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$transaccion->fechaEmision->format("c"));
            historico::create(self::$transaccion->id, self::$transaccion->idEmisor, self::$transaccion->idDocumento, 5, 'ERROR_INICIAL: ' . $e->getMessage());
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
        }
    }

    public static function iniciar($t)
    {
        try {
            self::$transaccion = $t;
            self::$transaccion->fechaEmision = date_create();
            if (self::getClave(
                self::$transaccion->idDocumento,
                self::$transaccion->datosEntidad->idTipoIdentificacion,
                self::$transaccion->datosEntidad->identificacion,
                self::$transaccion->idSituacionComprobante,
                '506',
                self::$transaccion->consecutivo,
                self::$transaccion->datosEntidad->codigoSeguridad,
                self::$transaccion->local,
                self::$transaccion->terminal
            )) {
                // si el documento es MR, no actualiza la clave, utiliza al de la factura emitida.
                //if(self::$transaccion->idDocumento!=5 && self::$transaccion->idDocumento!=6 && self::$transaccion->idDocumento!=7){
                self::$transaccion->clave = self::$arrayResp['clave'];
                self::$transaccion->consecutivoFE = self::$arrayResp['consecutivoFE'];
                //}                
                //
                switch (self::$transaccion->idDocumento) {
                    case 1:
                        include_once('xmlFE.php');
                        self::$arrayResp = xmlFE::create(self::$transaccion);
                        break;
                    case 4:
                        include_once('xmlTE.php');
                        self::$arrayResp = xmlTE::create(self::$transaccion);
                        break;
                    case 2: //self::$arrayResp = self::APICrearNDXML();
                        break;
                    case 3:
                        // include_once('xmlNC.php');
                        // self::$arrayResp = xmlNC::create(self::$transaccion);
                        break;
                    case 5: // CCE
                    case 6: // CPCE
                    case 7: // RCE
                        include_once('xmlMR.php');
                        self::$arrayResp = xmlMR::create(self::$transaccion);
                        break;
                }
                //
                if (self::$arrayResp) {
                    // valida respuesta.
                    if (isset(self::$arrayResp['error'])) {
                        throw new Exception(self::$arrayResp['error'] . '(' . self::$arrayResp['mensaje'] . ')', ERROR_FEXML_NO_VALID);
                    }
                    // Cifrar
                    if (self::cifrarXml()) {
                        // token.
                        if (self::checkToken()) {
                            // envia documento.
                            if (self::send(self::$transaccion->clave, self::$transaccion->fechaEmision))
                                return true;
                        }
                    }
                } else throw new Exception(self::$arrayResp['error'] . '(' . self::$arrayResp['mensaje'] . ')', ERROR_FEXML_NO_VALID);
            } else throw new Exception(self::$arrayResp['error'] . '(' . self::$arrayResp['mensaje'] . ')', ERROR_CLAVE_NO_VALID);
        } catch (Exception $e) {
            if (!self::$distr)
                Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$transaccion->fechaEmision->format("c"));
            else Distribucion::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$transaccion->fechaEmision->format("c"));
            historico::create(self::$transaccion->id, self::$transaccion->idEmisor, self::$transaccion->idDocumento, 5, 'ERROR_INICIAL: ' . $e->getMessage());
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            return false;
        }
    }

    public static function getClave($tipoDocumento = "", $tipoCedula = "", $cedula = "", $situacion = "", $codigoPais = "", $consecutivo = "", $codigoSeguridad = "00000000", $sucursal = "001", $terminal = "00001")
    {
        $dia = date('d');
        $mes = date('m');
        $ano = date('y');
        //Validamos el parametro de cedula    
        if ($cedula == "" && strlen($cedula) == 0) {
            self::$arrayResp = array(
                "error" => "Error al crear clave",
                "mensaje" => "El valor cedula no debe ser vacio"
            );
            return false;
        } else if (!ctype_digit($cedula)) {
            self::$arrayResp = array(
                "error" => "Error al crear clave",
                "mensaje" => "El valor cedula no es numeral"
            );
            return false;
        }
        //Validamos el parametro de cedula    
        if ($codigoPais == "" && strlen($codigoPais) == 0) {
            self::$arrayResp = array(
                "error" => "Error al crear clave",
                "mensaje" => "El valor codigoPais no debe ser vacio"
            );
            return false;
        } else if (!ctype_digit($codigoPais)) {
            self::$arrayResp = array(
                "error" => "Error al crear clave",
                "mensaje" => "El valor codigoPais no es numeral"
            );
            return false;
        }
        //Validamos que venga el parametro de sucursal
        if ($sucursal == "" && strlen($sucursal) == 0) {
            $sucursal = "001";
        } else if (ctype_digit($sucursal)) {

            if (strlen($sucursal) < 3) {
                $sucursal = str_pad($sucursal, 3, "0", STR_PAD_LEFT);
            } else if (strlen($sucursal) != 3 && $sucursal != 0) {
                self::$arrayResp = array(
                    "error" => "Error al crear clave",
                    "mensaje" => "el tamaño de sucursal es diferente de 3 digitos"
                );
                return false;
            }
        } else {
            self::$arrayResp = array(
                "error" => "Error al crear clave",
                "mensaje" => "El valor sucursal no es numeral"
            );
            return false;
        }
        //Validamos que venga el parametro de terminal
        if ($terminal == "" && strlen($terminal) == 0) {
            $terminal = "00001";
        } else if (ctype_digit($terminal)) {

            if (strlen($terminal) < 5) {
                $terminal = str_pad($terminal, 5, "0", STR_PAD_LEFT);
            } else if (strlen($terminal) != 5 && $terminal != 0) {
                self::$arrayResp = array(
                    "error" => "Error al crear clave",
                    "mensaje" => "el tamaño de terminal es diferente de 5 digitos"
                );
                return false;
            }
        } else {
            self::$arrayResp = array(
                "error" => "Error al crear clave",
                "mensaje" => "El valor terminal no es numeral"
            );
            return false;
        }
        //Validamos el consecutivo
        if ($consecutivo == "" && strlen($consecutivo) == 0) {
            return "El consecutivo no puede ser vacio";
        } else if (strlen($consecutivo) < 10) {
            $consecutivo = str_pad($consecutivo, 10, "0", STR_PAD_LEFT);
        } else if (strlen($consecutivo) != 10 && $consecutivo != 0) {
            self::$arrayResp = array(
                "error" => "Error en consecutivo",
                "mensaje" => "el tamaño consecutivo es diferente de 10 digitos"
            );
            return false;
        }
        //Validamos el codigoSeguridad
        if ($codigoSeguridad == "" && strlen($codigoSeguridad) == 0) {
            return "El consecutivo no puede ser vacio";
        } else if (strlen($codigoSeguridad) < 8) {
            $codigoSeguridad = str_pad($codigoSeguridad, 8, "0", STR_PAD_LEFT);
        } else if (strlen($codigoSeguridad) != 8 && $codigoSeguridad != 0) {
            self::$arrayResp = array(
                "error" => "Error en codigo Seguridad",
                "mensaje" => "el tamaño codigo Seguridad es diferente de 8 digitos"
            );
            return false;
        }
        // valida tipo de documento.
        $tipos = array("FE", "ND", "NC", "TE", "CCE", "CPCE", "RCE", "FEC", "FEE", 1, 2, 3, 4, 5, 6, 7, 8);
        if (in_array($tipoDocumento, $tipos)) {
            switch ($tipoDocumento) {
                case 'FE': //Factura Electronica
                case 1:
                    $tipoDocumento = "01";
                    break;
                case 'ND': // Nota de Debito
                case 2:
                    $tipoDocumento = "02";
                    break;
                case 'NC': // Nota de Credito
                case 3:
                    $tipoDocumento = "03";
                    break;
                case 'TE': // Tiquete Electronico
                case 4:
                    $tipoDocumento = "04";
                    break;
                case 'CCE': // Confirmacion Comprabante Electronico
                case 5:
                    $tipoDocumento = "05";
                    break;
                case 'CPCE': // Confirmacion Parcial Comprbante Electronico
                case 6:
                    $tipoDocumento = "06";
                    break;
                case 'RCE': // Rechazo Comprobante Electronico
                case 7:
                    $tipoDocumento = "07";
                    break;
                case 'FEC': // Rechazo Comprobante Electronico
                case 8:
                    $tipoDocumento = "08";
                    break;
                case 'FEE': // Rechazo Comprobante Electronico
                case 9:
                    $tipoDocumento = "09";
                    break;
            }
        } else {
            self::$arrayResp = array(
                "error" => "Error al crear clave",
                "mensaje" => "No se encuentra tipo de documento"
            );
            return false;
        }
        $consecutivoFE = $sucursal . $terminal . $tipoDocumento . $consecutivo;
        //-----------------------------------------------//
        //Numero de Cedula + el indice identificador
        $identificacion;
        $cedulas = array("fisico", "juridico", "dimex", "nite", 1, 2, 3, 4);
        if (in_array($tipoCedula, $cedulas)) {
            switch ($tipoCedula) {
                case 'fisico': //fisico se agregan 3 ceros para completar los 12 caracteres
                case 1:
                    $identificacion = "000" . $cedula;
                    break;
                case 'juridico': // juridico se agregan 2 ceros para completar los 12 caracteres
                case 2:
                    $identificacion = "00" . $cedula;
                    break;
                case 'dimex': // dimex puede ser de 11 0 12 caracteres
                case 3:
                    if (strlen($cedula) == 11) {
                        //En caso de ser 11 caracteres se le agrega un 0
                        $identificacion = "0" . $cedula;
                    } else if (strlen($cedula) == 12) {
                        $identificacion = $cedula;
                    } else {
                        self::$arrayResp = array(
                            "error" => "Error al crear clave",
                            "mensaje" => "dimex incorrecto"
                        );
                        return false;
                    }
                    break;
                case 'nite': // nite se agregan 2 ceros para completar los 12 caracteres
                case 4:
                    $identificacion = "00" . $cedula;
                    break;
            }
        } else {
            self::$arrayResp = array(
                "error" => "Error al crear clave",
                "mensaje" => "No se encuentra tipo de cedula"
            );
            return false;
        }
        //-----------------------------------------------//
        //1	Normal	Comprobantes electronicos que son generados y transmitidos en el mismo acto de compra-venta y prestacion del servicio al sistema de validacion de comprobantes electronicos de la Direccion General de Tributacion de Costa Rica.
        //2	Contingencia	Comprobantes electronicos que sustituyen al comprobante fisico emitido por contingencia.
        //3	Sin internet	Comprobantes que han sido generados y expresados en formato electronico, pero no se cuenta con el respectivo acceso a internet para el envio inmediato de los mismos a la Direccion General de Tributacion de Costa Rica.
        $situaciones = array("normal", "contingencia", "sininternet", 1, 2, 3);
        if (in_array($situacion, $situaciones)) {
            switch ($situacion) {
                case 'normal': //normal
                    $situacion = 1;
                    break;
                case 'contingencia': // Situacion de contingencia
                    $situacion = 2;
                    break;
                case 'sininternet': //Situacion sin internet
                    $situacion = 3;
                    break;
            }
        } else {
            self::$arrayResp = array(
                "error" => "Error al crear clave",
                "mensaje" => "No se encuentra el tipo de situacion"
            );
            return false;
        }
        //-----------------------------------------------//     
        //Crea la clave 
        $clave = $codigoPais . $dia . $mes . $ano . $identificacion . $consecutivoFE . $situacion . $codigoSeguridad;
        self::$arrayResp = array(
            "clave" => $clave,
            "consecutivoFE" => $consecutivoFE
        );
        error_log("[INFO] API CLAVE: " .  $clave);
        if (!self::$distr)
            Factura::setClave(self::$transaccion->idDocumento, self::$transaccion->id, $clave, $consecutivoFE);
        else Distribucion::setClave(self::$transaccion->idDocumento, self::$transaccion->id, $clave, $consecutivoFE);
        return true;
    }

    public static function cifrarXml()
    {
        try {
            if (isset(self::$arrayResp['xml'])) {
                $pfx = Globals::certDir . self::$transaccion->datosEntidad->idBodega . DIRECTORY_SEPARATOR . self::$transaccion->datosEntidad->cpath;
                if (!file_exists($pfx))
                    throw new Exception('El certificado del emisor(' . self::$transaccion->datosEntidad->nombre . ') No existe.', ERROR_CERTIFICADOURL_NO_VALID);
                if (empty(self::$transaccion->datosEntidad->pinp12))
                    throw new Exception('El PIN del emisor(' . self::$transaccion->datosEntidad->nombre . ') No existe.', ERROR_CERTIFICADOURL_NO_VALID);
                $firmador = new Firmador();
                //$pfx    =  self::$transaccion->datosEntidad->certificado; // dirname(__FILE__) . DIRECTORY_SEPARATOR . '011187076308(prueba).p12'; // Ruta del archivo de la llave criptografica (*.p12)
                $pin    = self::$transaccion->datosEntidad->pinp12;
                $base64 = $firmador->firmarXml($pfx, $pin, self::$arrayResp['xml'], $firmador::TO_BASE64_STRING);
                //print_r($base64);
                self::$arrayResp = array(
                    "clave" => self::$transaccion->clave,
                    "xmlCifrado" => $base64
                );
                historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 1, 'XML Firmado a Enviar', base64_decode($base64));
                error_log("[INFO] API CIFRADO XML EXITOSO!");
                return true;
            } else throw new Exception('No existe el xml para cifrar', ERROR_CIFRAR_NO_VALID);
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            historico::create(self::$transaccion->id, self::$transaccion->idEmisor, self::$transaccion->idDocumento, 5, 'ERROR_TOKEN_NO_VALID: ' . $e->getMessage());
            if (!self::$distr)
                Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$transaccion->fechaEmision->format("c"));
            else Distribucion::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$transaccion->fechaEmision->format("c"));
            self::$arrayResp = array(
                "error" => $e->getCode(),
                "mensaje" => $e->getMessage()
            );
            return false;
        }
    }

    public static function checkToken()
    {
        //Revisa si tiene un TOKEN abierto.
        include_once('Bodega.php');
        $username = '';
        $password = '';
        switch (self::$transaccion->idDocumento) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 8:
            case 9:
                $username = self::$transaccion->datosEntidad->username;
                $password = self::$transaccion->datosEntidad->password;
                break;
            case 5:
            case 6:
            case 7:
                $username = self::$transaccion->datosReceptor->username;
                $password = self::$transaccion->datosReceptor->password;
                break;
        }
        self::$apiMode = strpos($username, 'prod');
        if (self::$apiMode === false)
            self::$apiMode = 'api-stag';
        else self::$apiMode = 'api-prod';
        if (isset(self::$transaccion->datosEntidad->accessToken) && !empty(self::$transaccion->datosEntidad->accessToken)) {
            //
            $tokenDatetime = date_create(self::$transaccion->datosEntidad->tokenDatetime);
            $currentDatetime = date_create();
            $tokenDiff = $currentDatetime->getTimestamp() - $tokenDatetime->getTimestamp(); // $tokenDatetime->diff($currentDatetime);
            // token: 300 segundos. Si es menor lo utiliza. Sino usa refresh-token 1200 segundos. Sino abre uno nuevo.
            if ($tokenDiff < (self::$transaccion->datosEntidad->expiresIn - 15)) {
                // utiliza acces token.
                error_log('[INFO] UTILIZA ACCESS TOKEN');
                return true;
            } else if ($tokenDiff < (self::$transaccion->datosEntidad->refreshExpiresIn - 15)) {
                // refresca token.
                static::$grant_type = "refresh_token";
                error_log('[INFO] SOLICITA REFRESH TOKEN');
                return static::openToken($username, $password);
            } else {
                // abre nuevo token.
                static::$grant_type = "password";
                error_log('[INFO] SOLICITA ACCESS TOKEN');
                return static::openToken($username, $password);
            }
        } else {
            // abre nuevo token.
            static::$grant_type = "password";
            return static::openToken($username, $password);
        }
    }

    public static function openToken($username = null, $password = null)
    {
        try {
            // URL: prod - stag
            $url;
            if (self::$apiMode == 'api-stag') {
                $url = "https://idp.comprobanteselectronicos.go.cr/auth/realms/rut-stag/protocol/openid-connect/token";
            } else if (self::$apiMode == 'api-prod') {
                $url = "https://idp.comprobanteselectronicos.go.cr/auth/realms/rut/protocol/openid-connect/token";
            }
            //
            $ch = curl_init();
            $post = '';
            if (static::$grant_type == "password") {
                $post = [
                    'client_id' =>  self::$apiMode,
                    'client_secret' => '',
                    'grant_type' => static::$grant_type,
                    'username' =>  $username,
                    'password' =>  $password
                ];
            }
            if (static::$grant_type == "refresh_token") {
                $post = [
                    'client_id' =>  self::$apiMode,
                    'client_secret' => '',
                    'grant_type' => static::$grant_type,
                    'refresh_token' => self::$transaccion->datosEntidad->refreshToken
                ];
            }
            /*$options = array(
                'http' => array(
                    'header' => "Content-type: application/x-www-form-urlencoded\r\n",
                    'method' => 'POST',
                    'content' => http_build_query($post)
                )
            );
            $context = stream_context_create($options);
            $result = file_get_contents($url, false, $context);*/
            curl_setopt_array($ch, array(
                //CURLOPT_HEADER, 0,
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_VERBOSE => 0,
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => http_build_query($post),
                CURLOPT_SSL_VERIFYHOST => SSL_API,
                CURLOPT_SSL_VERIFYPEER => SSL_API
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                throw new Exception('Error al abrir TOKEN. ' . $error_msg, ERROR_TOKEN_NO_VALID);
            }
            $information = curl_getinfo($ch);
            if ($information['http_code'] != 200) {
                if (strpos($server_output, 'Refresh token expired') || strpos($server_output, 'Session not active') !== false) {
                    static::$grant_type = "password";
                    return static::openToken($username, $password);
                } else throw new Exception('Error CRITICO al Solicitar TOKEN MH. ' . $server_output, ERROR_TOKEN_NO_VALID);
            }
            //
            $sArray = json_decode($server_output);
            //
            if (!isset($sArray->access_token)) {
                // ERROR CRITICO:
                // debe notificar al contibuyente. 
                throw new Exception('Error CRITICO al Solicitar TOKEN MH.', ERROR_TOKEN_NO_VALID);
            }
            //
            self::$transaccion->datosEntidad->accessToken      = $sArray->access_token;
            self::$transaccion->datosEntidad->expiresIn        = $sArray->expires_in;
            self::$transaccion->datosEntidad->refreshExpiresIn = $sArray->refresh_expires_in;
            self::$transaccion->datosEntidad->refreshToken     = $sArray->refresh_token;
            $tokenDatetime = date_create();
            // abre token.
            error_log('[INFO] OPEN TOKEN !!!');
            // error_log("[INFO] GET ACCESS TOKEN API MH = " . self::$transaccion->datosEntidad->accessToken);
            ClienteFE::setToken(
                self::$transaccion->datosEntidad->id,
                self::$transaccion->datosEntidad->accessToken,
                self::$transaccion->datosEntidad->expiresIn,
                self::$transaccion->datosEntidad->refreshExpiresIn,
                self::$transaccion->datosEntidad->refreshToken,
                $tokenDatetime->format("c")
            );
            return true;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 5, 'ERROR_TOKEN_NO_VALID: ' . $e->getMessage());
            if (!self::$distr)
                Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$transaccion->fechaEmision->format("c"));
            else Distribucion::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, self::$transaccion->fechaEmision->format("c"));
            //
            self::$arrayResp = array(
                "error" => $e->getCode(),
                "mensaje" => $e->getMessage()
            );
            return false;
        }
    }

    public static function send($clave = null, $fechaEmision = null)
    {
        try {
            $post = [
                'clave' => $clave,
                'fecha' => $fechaEmision->format("c"),
                'emisor' => array(
                    'tipoIdentificacion' => self::$transaccion->datosEntidad->idTipoIdentificacion,
                    'numeroIdentificacion' => self::$transaccion->datosEntidad->identificacion
                ),
                'comprobanteXml' => self::$arrayResp['xmlCifrado']
            ];
            $mensaje = json_encode($post);
            $header = array(
                'Authorization: bearer ' . self::$transaccion->datosEntidad->accessToken,
                'Content-Type: application/json'
            );
            $url    = (self::$apiMode == 'api-stag' ? "https://api.comprobanteselectronicos.go.cr/recepcion-sandbox/v1/recepcion/" : (self::$apiMode  == 'api-prod' ? "https://api.comprobanteselectronicos.go.cr/recepcion/v1/recepcion/" : null));
            //
            $ch = curl_init();
            curl_setopt_array($ch, array(
                CURLOPT_URL => $url,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_VERBOSE => 0,
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_HEADER => true,
                CURLOPT_HTTPHEADER => $header,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $mensaje,
                CURLOPT_SSL_VERIFYHOST => SSL_API,
                CURLOPT_SSL_VERIFYPEER => SSL_API
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            //
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                $timedOut = strpos($error_msg, 'Operation timed out');
                if ($timedOut === false)
                    throw new Exception('Error CRITICO al ENVIAR el comprobante. DEBE COMUNICARSE CON SOPORTE TECNICO: ' . $error_msg, ERROR_ENVIO_NO_VALID);
                else {
                    //timed out.
                    error_log("[ERROR]  (-600): " . $error_msg);
                    historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 6, $error_msg);
                    if (!self::$distr)
                        Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 6, $fechaEmision->format("c"));
                    else
                        Distribucion::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 6, $fechaEmision->format("c"));
                    return false;
                }
            }
            $information = curl_getinfo($ch);
            if ($information['http_code'] != 202) {
                $xError = strpos($server_output, 'X-Error-Cause');
                $responseT = 'Error General';
                if ($xError) {
                    //preg_match('/Clave: (.*?)\n/', $header, $clave);
                    preg_match('/X-Error-Cause: (.*?).(.*?)\n/', $server_output, $xE);
                    $responseT = $xE[0];
                }
                error_log("[WARNING] El documento (" . $clave . "): " . $responseT);
                $recibidoAnteriormente = $xError = strpos($server_output, 'ya fue recibido anteriormente.');
                if ($recibidoAnteriormente) {
                    historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 7, '[ERROR] ' . $responseT . ', STATUS(' . $information['http_code'] . ')');
                    if (!self::$distr)
                        Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 7, $fechaEmision->format("c"));
                    else Distribucion::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 6, $fechaEmision->format("c"));
                    return false;
                } else throw new Exception('Error CRITICO al ENVIAR el comprobante. DEBE COMUNICARSE CON SOPORTE TECNICO, STATUS(' . $information['http_code'] . '):  ' . $server_output, ERROR_ENVIO_NO_VALID);
            }
            //
            //$sArray= json_decode($server_output);   
            if ($information['http_code'] == 202) {
                // ERROR CRITICO: almacena estado= 5 (otros) - error al enviar comprobante.
                //throw new Exception('Error CRITICO al ENVIAR el comprobante. DEBE COMUNICARSE CON SOPORTE TECNICO: '. $server_output, ERROR_ENVIO_NO_VALID);
                historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 2, 'Comprobante ENVIADO EXITOSAMENTE, STATUS(' . $information['http_code'] . ')');
                if (!self::$distr) Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 2, $fechaEmision->format("c"));
                else Distribucion::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 2, $fechaEmision->format("c"));
            }
            //
            error_log("[INFO] API ENVIO EXITOSO!");
            curl_close($ch);
            return true;
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 5, 'ERROR_ENVIO_NO_VALID: ' . $e->getMessage());
            if (!self::$distr)  Factura::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, $fechaEmision->format("c"));
            else Distribucion::updateEstado(self::$transaccion->idDocumento, self::$transaccion->id, 5, $fechaEmision->format("c"));
            //
            self::$arrayResp = array(
                "error" => $e->getCode(),
                "mensaje" => $e->getMessage()
            );
            return false;
        }
    }

    public static function consulta($t, $invoice = false)
    {
        try {
            self::$transaccion = $t;
            error_log("[INFO] API CONSULTA CLAVE: " . self::$transaccion->clave);
            if (!self::checkToken())
                return false;
            $url;
            if (self::$apiMode == 'api-stag') {
                $url = "https://api.comprobanteselectronicos.go.cr/recepcion-sandbox/v1/recepcion/";
            } else if (self::$apiMode == 'api-prod') {
                $url = "https://api.comprobanteselectronicos.go.cr/recepcion/v1/recepcion/";
            }
            $ch = curl_init();
            $header = array(
                'Authorization: bearer ' . self::$transaccion->datosEntidad->accessToken,
                'Content-Type: application/json'
            );
            curl_setopt_array($ch, array(
                CURLOPT_URL => $url . self::$transaccion->clave,
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_VERBOSE => 0,
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_HEADER => true,
                CURLOPT_HTTPHEADER => $header,
                CURLOPT_CUSTOMREQUEST => "GET",
                CURLOPT_SSL_VERIFYHOST => SSL_API,
                CURLOPT_SSL_VERIFYPEER => SSL_API
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                throw new Exception('Error CRITICO al CONSULTAR el comprobante. ' . $error_msg, ERROR_CONSULTA_NO_VALID);
            }
            $information = curl_getinfo($ch);
            if ($information['http_code'] != 200) {
                // busca x-error-cause.
                $xError = strpos($header, 'X-Error-Cause');
                if ($xError) {
                    //preg_match('/Clave: (.*?)\n/', $header, $clave);
                    preg_match('/X-Error-Cause: (.*?).(.*?)\n/', $header, $xE);
                    $responseT = $xE[0];
                    // **** PENDIENTE VALIDAR REPETIDOS ****
                    $null = strpos($responseT, ' no ha sido recibido.');
                    if ($null === false) {
                        throw new Exception('Error CRITICO al consultar el comprobante. DEBE COMUNICARSE CON SOPORTE TECNICO: ' . $responseT, ERROR_CONSULTA_NO_VALID);
                    } else {
                        // clave invalida, no existe en ATV.
                        if (!self::$distr) Factura::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, 1);
                        else Distribucion::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, 1);
                        historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 1, 'La transaccion no fue enviada a los sistemas de ATV.');
                        throw new Exception('Documento no registrado en ATV: ' . $responseT, ERROR_CONSULTA_NO_VALID);
                    }
                    // throw new Exception('Error CRITICO al consultar el comprobante STATUS( '. $information['http_code'] .' ). '.$responseT, ERROR_CONSULTA_NO_VALID);
                } else throw new Exception('Error CRITICO al consultar el comprobante STATUS( ' . $information['http_code'] . ' ). ' . $server_output, ERROR_CONSULTA_NO_VALID);
            } else {
                $responseT = str_replace("-", "_", $body);
                $responseT = json_decode($responseT);
                error_log("[INFO] Estado del DOCUMENTO (" . self::$transaccion->clave . "): $responseT->ind_estado");
                // si el estado es procesando debe consultar de nuevo.
                if ($responseT->ind_estado == 'procesando') {
                    historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 2, $responseT->ind_estado);
                    if (!self::$distr) Factura::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, 2);
                    else Distribucion::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, 2);
                    //self::APIConsultaComprobante();
                } else if ($responseT->ind_estado == 'aceptado') {
                    $xml = base64_decode($responseT->respuesta_xml);
                    $fxml = simplexml_load_string($xml);
                    //
                    if (strpos((string) $fxml->NombreEmisor, 'DESCONOCIDO')  || (string) strpos($fxml->NumeroCedulaEmisor, '00000')) {
                        error_log("[WARNING] El documento (" . self::$transaccion->clave . ") TIENE VALORES NULOS (DESCONOCIDO-00000000)");
                        historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 4, "[WARNING] HAY VALORES NULOS (DESCONOCIDO-00000000)");
                    }
                    //                    
                    historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 3, '[' . $responseT->ind_estado . '] ' . (string) $fxml->DetalleMensaje, $xml);
                    if (!self::$distr) Factura::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, 3);
                    else Distribucion::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, 3);
                    //EMAIL
                    require_once("invoice.php");
                    if ($invoice && self::$transaccion->idDocumento == '1') {
                        Invoice::$email_array_address_to = [];
                        Invoice::create(self::$transaccion);
                    }
                } else if ($responseT->ind_estado == 'rechazado') {
                    // genera informe con los datos del rechazo. y pone estado de la transaccion pendiente para ser enviada cuando sea corregida.
                    $xml = base64_decode($responseT->respuesta_xml);
                    $fxml = simplexml_load_string($xml);
                    //
                    if (strpos((string) $fxml->NombreEmisor, 'DESCONOCIDO') || strpos((string) $fxml->NumeroCedulaEmisor, '000000000')  !== false) {
                        error_log("[WARNING] El documento (" . self::$transaccion->clave . ") TIENE VALORES NULOS (DESCONOCIDO-00000000)");
                        historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 4, "[WARNING] HAY VALORES NULOS (DESCONOCIDO-00000000)");
                    }
                    //
                    $resp400 = strpos((string) $fxml->DetalleMensaje, 'ya existe en nuestras bases de datos');
                    $respFirma = strpos((string) $fxml->DetalleMensaje, 'La firma del comprobante electronico no es valida');
                    if ($resp400) {
                        error_log("[WARNING] El documento (" . self::$transaccion->clave . ") Ya fue recibido anteriormente");
                        if (!self::$distr) Factura::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, 4);
                        else Distribucion::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, 4);
                        historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 4, "[WARNING]" . (string) $fxml->DetalleMensaje, $xml);
                        return true;
                    }
                    if ($respFirma) {
                        $errorFirma = 8;
                        if (self::$transaccion->idEstadoComprobante == 8)
                            $errorFirma = 9;
                        if (self::$transaccion->idEstadoComprobante == 9)
                            $errorFirma = 10;
                        if (self::$transaccion->idEstadoComprobante == 10)
                            $errorFirma = 4;
                        error_log("[ERROR] El documento (" . self::$transaccion->clave . ")  La firma del comprobante electronico no es valida (" . $errorFirma . ").");
                        historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, $errorFirma, '[' . $responseT->ind_estado . '] ' . (string) $fxml->DetalleMensaje, $xml);
                        if (!self::$distr) Factura::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, $errorFirma);
                        else Distribucion::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, $errorFirma);
                    } else {
                        error_log("[ERROR] El documento (" . self::$transaccion->clave . ") Fue rechazado, ver historico. " .  (string) $fxml->DetalleMensaje);
                        historico::create(self::$transaccion->id,  self::$transaccion->datosEntidad->idBodega, self::$transaccion->idDocumento, 4, '[' . $responseT->ind_estado . '] ' . (string) $fxml->DetalleMensaje, $xml);
                        if (!self::$distr) Factura::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, 4);
                        else Distribucion::updateIdEstadoComprobante(self::$transaccion->id, self::$transaccion->idDocumento, 4);
                    }
                }
            }
        } catch (Exception $e) {
            error_log("[ERROR]  (" . $e->getCode() . "): " . $e->getMessage());
            return false;
        }
    }
}

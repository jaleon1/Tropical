<?php
// include_once("settings.php");
// $corePath = $config['modules']['coreInstall'];
// include_once($corePath . "/core/boot.php");
/*CORS to the app access*/
// header('Access-Control-Allow-Origin: *');
// header('Access-Control-Allow-Headers: Cache-Control, Pragma, Origin, Authorization, Content-Type, X-Requested-With');
// header('Access-Control-Allow-Methods: GET, PUT, POST');
error_reporting(E_ALL);
ini_set('display_errors', 1);
require_once('Firma.php');
//
$fe = new FE();
// $fe->dia= $_POST["dia"];
// $fe->mes= $_POST["mes"];
// $fe->ann= $_POST["ann"];
// $fe->local= $_POST["local"];
// $fe->terminal= $_POST["terminal"];
// $fe->tipoComprobante= $_POST["tipoComprobante"];
//
$fe->CrearXml();
$fe->Token();
$fe->EnviarCurl();
// ***************************************************** //
abstract class tipo_Comprobantexx
{
    const facturaElectronica = '01'; 
    const notaDebito = '02'; 
    const notaCredito= '03'; 
    const tiqueteElectronico= '04';
    const confirmarComprobanteElectronico= '05';
    const confirmarParcialComprobanteElectronico= '06';
    const confirmarRechazo= '07';
}
abstract class tipoComprobante
{
    const normal = '1'; 
    const contingencia = '2'; 
    const sinInternet= '3';
}
abstract class tipoIdentificacion
{
    const fisica = '01'; 
    const juridica = '02'; 
    const DIMEX= '03';
    const NITE= '04';
}
abstract class condicionesVenta
{
    const contado = '01'; 
    const credito = '02'; 
    const consignacion= '03';
    const apartado= '04';
    const arrendamientoCompra = '05'; 
    const arrendamientoFinanciero = '06'; 
    const otros= '99';
}
abstract class medioPago
{
    const efectivo = '01'; 
    const tarjeta = '02'; 
    const cheque= '03';
    const transferencia= '04';
    const terceros = '05'; 
    const otros= '99';
}
class emirec
{
    public $tipoIdentificacion="";
    public $numeroIdentificacion="";
}
class FE{
    public $id=null;
    public $pais='506';
    public $dia="";
    public $mes="";
    public $ann="";
    public $identificacion="000111870763";
    public $local="";
    public $terminal="";
    public $tipocomprobante="";
    public $consecutivo="0000000001";
    public $situacion="1";
    public $codigoseguridad="99999999";
    //
    private $clave='';
    public $fecha='';    
    public $emisor='';
    public $receptor='';
    private $comprobanteXml='';
    //
    private $token='';

    //
    
    function CrearXml(){  
        $schema = new DOMDocument();
        $schemaXSDFile='../ATV/FacturaElectronica.xsd';
        $schema->loadXML($schemaXSDFile); //that is a String holding your XSD file contents
        $fieldsList = $schema->getElementsByTagName('element'); //get all elements 
        $metadataTemplate = '';
        foreach ($fieldsList as $element) {
            //add any special if statements here and modify the below to include any attributes needed
            $key = $element->getAttribute('name');
            $metadataTemplate .= '<' . $key . '>' . '</' . $key . '>';
        }

        //Manipulate the template adding your fields values:
        $metadataXml = simplexml_load_string($metadataTemplate);
        $metadataXml->fieldName = 'value';








        $numconsecutivo= '00100001010000000011';
        $key= "506290618000111870763".$numconsecutivo."199999999";
        $fechaEmision= '2018-06-29T00:00:00-06:00';
        //
        $header='<?xml version="1.0" encoding="utf-8"?>
        <FacturaElectronica 
             xmlns="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica" 
             xmlns:ds="http://www.w3.org/2000/09/xmldsig#" 
             xmlns:vc="http://www.w3.org/2007/XMLSchema-versioning" 
             xmlns:xs="http://www.w3.org/2001/XMLSchema">';
        //
        $infoFact='<Clave>'.$key.'</Clave>
            <NumeroConsecutivo>'.$numconsecutivo.'</NumeroConsecutivo>
            <FechaEmision>'.$fechaEmision.'</FechaEmision>';
        $nombre= 'Carlos Eduardo Chacón Calvo';
        $tipoIdentificacion= '01';
        $identificacion= '000111870763';
        $nombreComercial= 'Carlos Eduardo Chacón Calvo';
        $provincia= '1';
        $canton= '01';
        $distrito= '03';
        $barrio= '03';
        $otrasSenas= 'Fuente';
        $codigoPais= '506';
        $numTelefono= '84316310';
        $correoElectronico= 'carlos.echc11@gmail.com';
        //
        $emisor='<Emisor>
            <Nombre>'.$nombre.'</Nombre>
            <Identificacion>
                <Tipo>'.$tipoIdentificacion.'</Tipo>
                <Numero>'.$identificacion.'</Numero>
            </Identificacion>
            <NombreComercial>'.$nombreComercial.'</NombreComercial>
            <Ubicacion>
                <Provincia>'.$provincia.'</Provincia>
                <Canton>'.$canton.'</Canton>
                <Distrito>'.$distrito.'</Distrito>
                <Barrio>'.$barrio.'</Barrio>
                <OtrasSenas>'.$otrasSenas.'</OtrasSenas>
            </Ubicacion>
            <Telefono>
                <CodigoPais>'.$codigoPais.'</CodigoPais>
                <NumTelefono>'.$numTelefono.'</NumTelefono>
            </Telefono>
            <CorreoElectronico>'.$correoElectronico.'</CorreoElectronico>
        </Emisor>';
        $receptor='<Receptor></Receptor>';
        //
        $condicionVenta='01';
        $plazoCredito='0';
        $medioPago='01';
        $condicion='<CondicionVenta>'.$condicionVenta.'</CondicionVenta>
            <PlazoCredito>'.$plazoCredito.'</PlazoCredito>
            <MedioPago>'.$medioPago.'</MedioPago>';
        //
        $lineaDetalle='';
        $tipo='';
        $codigo='';


        $DetalleServicio='<DetalleServicio>
            <LineaDetalle>
                <NumeroLinea>1</NumeroLinea>
                <Codigo>
                <Tipo>04</Tipo>
                <Codigo>00001</Codigo>
                </Codigo>
                <Cantidad>1</Cantidad>
                <UnidadMedida>Sp</UnidadMedida>
                <UnidadMedidaComercial>Servicio Profesional</UnidadMedidaComercial>
                <Detalle>Honorarios Profesionales 1</Detalle>
                <PrecioUnitario>100</PrecioUnitario>
                <MontoTotal>100</MontoTotal>
                <MontoDescuento>0</MontoDescuento>
                <NaturalezaDescuento>0</NaturalezaDescuento>
                <SubTotal>100</SubTotal>
                <MontoTotalLinea>100</MontoTotalLinea>
            </LineaDetalle>
        </DetalleServicio>';
        
    }

    function Cifrar(){  


    }


    function EnviarCurl(){     
        $url = 'https://api.comprobanteselectronicos.go.cr/recepcion-sandbox/v1/recepcion/';
        $headers = array(
            'Authorization: Bearer ' . $this->token->access_token ,
            "content-type: application/json"
                      
        );
        $key= "50629061800011187076300100001010000000011199999999";
        $invoice= "PD94bWwgdmVyc2lvbj0iMS4wIiA/Pg0KDQo8ZG9tYWluIHhtbG5zPSJ1cm46amJvc3M6ZG9tYWluOjQuMCI+DQogICAgPGV4dGVuc2lvbnM+DQogICAgICAgIDxleHRlbnNpb24gbW9kdWxlPSJvcmcuamJvc3MuYXMuY2x1c3RlcmluZy5pbmZpbmlzcGFuIi8+DQogICAgICAgIDxleHRlbnNpb24gbW9kdWxlPSJvcmcuamJvc3MuYXMuY2x1c3RlcmluZy5qZ3JvdXBzIi8+DQogICAgICAgIDxleHRlbnNpb24gbW9kdWxlPSJvcmcuamJvc3MuYXMuY29ubmVjdG9yIi8+DQogICAgICAgIDxleHRlbnNpb24gbW";
        $content = "{\"clave\": \"$key\","
            . "\"fecha\": \"2018-10-03T00:00:00-0600\","
            . "\"emisor\": {\"tipoIdentificacion\": \"01\",\"numeroIdentificacion\": \"000111070763\"},"
            . "\"receptor\": {\"tipoIdentificacion\": \"01\",\"numeroIdentificacion\": \"000111070763\"},"
            //. "\n\t\"callbackUrl\": \"https://example.com/invoiceView\","
            . "\"comprobanteXml\": \"$invoice\"}";
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        // POST
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLINFO_HEADER_OUT, 1);
        curl_setopt($ch, CURLOPT_HEADER, 1);
        curl_setopt($ch,CURLOPT_VERBOSE, 1);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $content);
        $server_output = curl_exec ($ch);
        $information = curl_getinfo($ch);
        $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
        $header = substr($server_output, 0, $header_size);
        $body = substr($server_output, $header_size);
        $error_msg = "";
        if (curl_error($ch)) {
            $error_msg = curl_error($ch);
        }     
        curl_close($ch);
        //if(!$this->CheckResponse($information['http_code'], $server_output, $error_msg))
        //    return false;
        //
        // revisar estado tiquete.
        //
        $url = 'https://api.comprobanteselectronicos.go.cr/recepcion-sandbox/v1/recepcion/'.$key;
        $headers = array(            
            'Authorization: Bearer ' . $this->token->access_token        
        );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_HTTPGET, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLINFO_HEADER_OUT, true);
        curl_setopt($ch,CURLOPT_VERBOSE,true);    
        curl_setopt($ch, CURLOPT_HEADER, 1);  
        $server_output = curl_exec ($ch);
        $information = curl_getinfo($ch);
        $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
        $header = substr($server_output, 0, $header_size);
        $body = substr($server_output, $header_size);        
        //
        $error_msg = "";
        if (curl_error($ch)) {
            $error_msg = curl_error($ch);
        }
        curl_close($ch);
        //if($this->CheckResponse($information['http_code'], $server_output, $error_msg))
            $this->CheckState($information['http_code'], $body);
    }

    function CerrarSesion(){
        // Client client = ClientBuilder.newClient();
        // WebTarget target = client.target(IDP_URI + "/logout");
      
        // // Los tokens son los obtenidos durante la fase de login inicial.
        // Response response = target.request().header("Authorization", "Bearer " + getAccessToken())
        //              .post(Entity.form(new Form("refresh_token", getRefreshToken())));
    }

    function CheckState($httpcode, $body){
        $state= json_decode($body,true);
        if ($httpcode == 200 || $httpcode == 202) {
            if($state["ind-estado"]=="aceptado")
            {
                echo json_encode(array(
                    'code' => $httpcode ,
                    'msg' => $state["ind-estado"]));
            }
            else{
                header('HTTP/1.0 '.$httpcode.' Bad error');
                die(json_encode(array(
                    'code' => $httpcode ,
                    'msg' => $state["ind-estado"]))
                ); 
            }
        }
    }

    function CheckResponse($httpcode, $server_output, $error_msg=null){
        if ($httpcode > 203) { 
             //salida con error.
            header('HTTP/1.0 '.$httpcode.' Bad error');
            if ($error_msg!="") {
                die(json_encode(array(
                    'code' => $httpcode ,
                    'msg' => $error_msg))
                ); 
            }
            else {
                // X-Error-Cause
                if (strpos($server_output, 'X-Error-Cause') !== false) {
                    preg_match_all("/X-Error-Cause:\K[^{]*(?=X-H)/", $server_output, $xrr);
                    die(json_encode(array(
                        'code' => $httpcode ,
                        'msg' => $xrr[0][0]))
                    );
                }
                else
                    die(json_encode(array(
                        'code' => $httpcode ,
                        'msg' => $server_output))
                    ); 
            }
            return false;
        }
        else return true;
    }

    function Enviar(){
        //$this->clave= '50626061800011187076300100001010000000001199999999';//$this->Clave();
        //$date = DateTime::createFromFormat('Y-m-d\TH:i:s.uP', '2014-01-22T10:36:00.222Z');
        //$this->fecha="2016-01-01T00:00:00-0600";
        // $fact->emisor= new emirec();
        // $fact->emisor->tipoIdentificacion = tipoIdentificacion::fisica;
        // $fact->emisor->numeroIdentificacion = '000111870763';
        // $fact->receptor= new emirec();
        // $fact->receptor->tipoIdentificacion = tipoIdentificacion::fisica;
        // $fact->receptor->numeroIdentificacion = '000111870763';
        // $fact->comprobanteXml="";
        
        $fact = array(
            'clave' => '50626061800011187076300100001010000000001199999999', 
            'fecha' => '2016-01-01T00:00:00-0600',
            'emisor' => array(
                'tipoIdentificacion' => '01',
                'numeroIdentificacion' => '000111870763'
            ),
            'receptor' => array(
                'tipoIdentificacion' => '01',
                'numeroIdentificacion' => '000111870763'
            ),
            'comprobanteXml'=> '132'
        );
        $data = json_encode($fact);
        //
        $url = 'https://api.comprobanteselectronicos.go.cr/recepcion-sandbox/v1/recepcion/';
        $headers = array(
            'Content-Type:application/json',
            'Authorization: Bearer eyJhbGciOiJSUzI1NiJ9.eyJqdGkiOiIwNWZiY2JjZS03OWVlLTQ1ZDAtYmJhZi05NjU1MjhkNjllMjIiLCJleHAiOjE1MzAxNTgyMTksIm5iZiI6MCwiaWF0IjoxNTMwMTU3OTE5LCJpc3MiOiJodHRwczovL2lkcC5jb21wcm9iYW50ZXNlbGVjdHJvbmljb3MuZ28uY3IvYXV0aC9yZWFsbXMvcnV0LXN0YWciLCJhdWQiOiJhcGktc3RhZyIsInN1YiI6ImQwYzZlYzMzLTdjMWItNDg3NC1iNWRjLTBlOTJlMDUxNjViNSIsInR5cCI6IkJlYXJlciIsImF6cCI6ImFwaS1zdGFnIiwic2Vzc2lvbl9zdGF0ZSI6ImRmOTMxMWQ0LWNiM2ItNDcwNC04ODJhLTc0NGJkM2YzYWUzOCIsImNsaWVudF9zZXNzaW9uIjoiMzNkMWRiMGEtYWE5NC00M2NmLTk2Y2ItYzI2MGI0OWM2N2IzIiwiYWxsb3dlZC1vcmlnaW5zIjpbXSwicmVzb3VyY2VfYWNjZXNzIjp7ImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJ2aWV3LXByb2ZpbGUiXX19LCJuYW1lIjoiQ0FSTE9TIEVEVUFSRE8gQ0hBQ09OIENBTFZPIiwicHJlZmVycmVkX3VzZXJuYW1lIjoiY3BmLTAxLTExODctMDc2M0BzdGFnLmNvbXByb2JhbnRlc2VsZWN0cm9uaWNvcy5nby5jciIsImdpdmVuX25hbWUiOiJDQVJMT1MgRURVQVJETyIsImZhbWlseV9uYW1lIjoiQ0hBQ09OIENBTFZPIiwicG9saWN5LWlkIjoiNThhNjIwMzM3NmVhZTE0MDhjZTVlN2RkIiwiZW1haWwiOiJjcGYtMDEtMTE4Ny0wNzYzQHN0YWcuY29tcHJvYmFudGVzZWxlY3Ryb25pY29zLmdvLmNyIn0.LprsQFEC2JVWJbxvd0yxA0s_mI2Xbk2USuiAX6u4VqIyVzsJH0JZyG_zqHwj0tUpdaJxjHcdX1l0fn1gB-pmqWGb0MhG8yewiv7WztbavLxzRnE1cWp8EtwEeagHLV8ikFE9ocC8l3Ff5AY_aBhQm6E6JlruFmgGI5cAQYC2zL6V5ELfnZwBY60_V5aMFzSd380BHtZim8wrhcbUHW9rn1VSYRj_NSxdVQeTvFjjjO74V6cuTME2K2oK08JgvB12MPfk7LcDIMC_WxHfnKM6mm1mj4Jx__bc9Y9MyqpH5rCKGn-g-I4Y-V983nAxLwrFruftWRYLnQufYzZi6kPruA'
        );
        $options = array(
            'http' => array(
                'header' => $headers,
                'method'  => 'POST',
                'content' => '{"clave": "50626061800011187076300100001010000000001199999999",
                    "fecha": "2016-01-01T00:00:00-0600",
                    "emisor": {
                      "tipoIdentificacion": "01",
                      "numeroIdentificacion": "111870763"
                    },
                    "receptor": {
                      "tipoIdentificacion": "01",
                      "numeroIdentificacion": "111870763"
                    },
                    "comprobanteXml": "PD94bWwgdmVyc2lvbj0iMS4wIiA/Pg0KDQo8ZG9tYWluIHhtbG5zPSJ1cm46amJvc3M6ZG9tYWluOjQuMCI+DQogICAgPGV4dGVuc2lvbnM+DQogICAgICAgIDxleHRlbnNpb24gbW9kdWxlPSJvcmcuamJvc3MuYXMuY2x1c3RlcmluZy5pbmZpbmlzcGFuIi8+DQogICAgICAgIDxleHRlbnNpb24gbW9kdWxlPSJvcmcuamJvc3MuYXMuY2x1c3RlcmluZy5qZ3JvdXBzIi8+DQogICAgICAgIDxleHRlbnNpb24gbW9kdWxlPSJvcmcuamJvc3MuYXMuY29ubmVjdG9yIi8+DQogICAgICAgIDxleHRlbnNpb24gbW..."
                  }'
            )
        );
        $context  = stream_context_create($options);
        $result = @file_get_contents($url, false, $context);
        if ($result === FALSE) { 
            //$translate = simplexml_load_string($result);

            // return $translate[0];
            //header('HTTP/1.1 500 Internal Server Booooo');
            //header('Content-Type: application/json; charset=UTF-8');
            //die(json_encode(array('message' => 'ERROR', 'code' => 1337)));

            die(json_encode(array(
                'code' => 'com error' ,
                'msg' => $result))
            );
        }
        var_dump($result);

    }

    function Token(){
        $url= 'https://idp.comprobanteselectronicos.go.cr/auth/realms/rut-stag/protocol/openid-connect/token';
        $username= 'cpf-01-1187-0763@stag.comprobanteselectronicos.go.cr';
        $password='84vv>YH(-Hw!v!+:N!;-';
        //
        $data = array(
            'client_id' => 'api-stag', 
            'grant_type' => 'password',
            'username' => $username,
            'password' => $password
        );
        // $options = array(
        //     'http' => array(
        //         //'header'  => "Content-type: application/json\r\n",
        //         'content' => http_build_query($data)
        //     )
        // );
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL,$url);
        curl_setopt($ch, CURLOPT_POST, 1);
        //curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLINFO_HEADER_OUT, true);
        curl_setopt($ch,CURLOPT_VERBOSE,true);    
        curl_setopt($ch, CURLOPT_FAILONERROR, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
        $server_output = curl_exec ($ch);
        $information = curl_getinfo($ch);
        //
        if (curl_error($ch)) {
            $error_msg = curl_error($ch);
        }
        curl_close($ch);        
        if ($information['http_code'] == 200) { 
            $this->token =json_decode($server_output);
        } 
        else { 
            header('HTTP/1.0 '.$information['http_code'].' Bad error');
            if (isset($error_msg)) {
                die(json_encode(array(
                    'code' => 'token error' ,
                    'msg' => $error_msg))
                ); 
            }
            else {
                die(json_encode(array(
                    'code' => 'token error' ,
                    'msg' => $server_output))
                ); 
            }
        }
    }

    function Token2(){
        $url= 'https://idp.comprobanteselectronicos.go.cr/auth/realms/rut-stag/protocol/openid-connect/token';
        $username= 'cpf-01-1187-0763@stag.comprobanteselectronicos.go.cr';
        $password='84vv>YH(-Hw!v!+:N!;-';
        //
        $data = array('client_id' => 'api-stag', 
            'grant_type' => 'password',
            'username' => $username,
            'password' => $password
        );
        $options = array(
            'http' => array(
                //'header'  => "Content-type: application/json\r\n",
                'method'  => 'POST',
                'content' => http_build_query($data)
            )
        );
        // $post_data =http_build_query($request_params) ;
        $context  = stream_context_create($options);
        $result = file_get_contents($url, false, $context);
        if ($result === FALSE) { 
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => '$e->getCode()' ,
                'msg' => '$e->getMessage()'))
            );
        }
        else {
            $this->token =json_decode($result);
        }
        var_dump($result);

    }

    function Clave(){
        return $this->pais . $this->dia . $this->mes . $this->ann . $this->identificacion . $this->local . $this->terminal . $this->tipocomprobante . $this->consecutivo . $this->situacion . $this->codigoseguridad;

    }

}

?>
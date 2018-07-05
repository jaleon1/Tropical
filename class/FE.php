<?php
// cr libre api

  // --data 'w=ejemplo&r=hola'


$url = 'https://localhost/API-MH/www/api.php';
$headers = array(
    "content-type: application/x-www-form-urlencoded"                      
);
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




// include_once("settings.php");
// $corePath = $config['modules']['coreInstall'];
// include_once($corePath . "/core/boot.php");
/*CORS to the app access*/
// header('Access-Control-Allow-Origin: *');
// header('Access-Control-Allow-Headers: Cache-Control, Pragma, Origin, Authorization, Content-Type, X-Requested-With');
// header('Access-Control-Allow-Methods: GET, PUT, POST');
// error_reporting(E_ALL);
// ini_set('display_errors', 1);
// SIMULA LLAMADO A FACTURA ELECTRONICA.
// require_once('FacturaElectronica.php');
// $fe = new FacturaElectronica();
// $fe->idTransaccion= '3b31b046-75eb-11e8-abed-f2f00eda9710';
// $fe->Send();
// $fe->dia= $_POST["dia"];
// $fe->mes= $_POST["mes"];
// $fe->ann= $_POST["ann"];
// $fe->local= $_POST["local"];
// $fe->terminal= $_POST["terminal"];
// $fe->tipoComprobante= $_POST["tipoComprobante"];
//
// $fe->CrearXml();
// $fe->Token();
// $fe->EnviarCurl();
// ***************************************************** //
abstract class tipoComprobante
{
    const facturaElectronica = '01'; 
    const notaDebito = '02'; 
    const notaCredito= '03'; 
    const tiqueteElectronico= '04';
    const confirmarComprobanteElectronico= '05';
    const confirmarParcialComprobanteElectronico= '06';
    const confirmarRechazo= '07';
}
abstract class situacionComprobante
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
abstract class emisorReceptor
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

    function Clave(){
        return $this->pais . $this->dia . $this->mes . $this->ann . $this->identificacion . $this->local . $this->terminal . $this->tipocomprobante . $this->consecutivo . $this->situacion . $this->codigoseguridad;

    }

}

?>
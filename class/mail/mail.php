<?php
    // require 'Exception.php';
    // require 'PHPMailer.php';
    // require 'SMTP.php';
    // require 'OAuth.php';
    setlocale(LC_ALL,"es_ES");
    mb_internal_encoding('UTF-8');

    use PHPMailer\PHPMailer\PHPMailer;
    use PHPMailer\PHPMailer\OAuth;
    use PHPMailer\PHPMailer\Exception;
    use League\OAuth2\Client\Provider\Google;

    require 'vendor/autoload.php';

    class Send_Mail {

        public $email_array_address_to = null;
        public $email_subject = "";
        public $email_addAttachment = null;
        public $email_user = "";
        public $email_password = "";
        public $email_from_name = "";
        public $email_body = "";
        public $email_SMTPSecure = "";
        public $email_Host = "";
        public $email_SMTPAuth = "";
        public $email_Port = "";
        private $gmailCredentials= "";


        private function setCredentials(){
            //require_once('../globals.php');
            if (file_exists(Globals::gmailCredentials)) {
                $config = file_get_contents(Globals::gmailCredentials, true); 
                $jsonFile = json_decode($config, true);
                $this->gmailCredentials = $jsonFile['web'];
            }         
            else throw new Exception('[ERROR] Acceso denegado al Archivo de configuración.',ERROR_CONFI_FILE_NOT_FOUND);
        }       

        function send(){
            $phpmailer  = new PHPMailer(true);   // Passing `true` enables exceptions
            $phpmailer->CharSet = "UTF-8";
            //$phpmailer->MailerDebug = false;            
            try {
                $this->setCredentials();
                // get token.
                /*$client = new Google_Client();
                $client->setApplicationName("TropicalSNo");
                $client->setAuthConfig(Globals::gmailCredentials);
                $accessToken = $client->fetchAccessTokenWithAuthCode('Xfu05U-0sIt4NrvazUWM-9th');*/



                //
                $phpmailer->oauthRefreshToken = parse_ini_file(Globals::configFile, true)[Globals::app]['googleapiclienttoken']; 
                // client/user mail settings.
                $phpmailer->Username = $this->email_user;
                $phpmailer->Password = $this->email_password;
                //          
                $provider = new Google(
                    [
                        'clientId' => $this->gmailCredentials['client_id'],// $phpmailer->oauthClientId,
                        'clientSecret' => $this->gmailCredentials['client_secret'] //$phpmailer->oauthClientSecret
                        , 'redirectUri' => $this->gmailCredentials['auth_uri']
                    ]
                );
                //Server settings
                $phpmailer->Host = 'smtp.gmail.com';//$this->email_Host;
                $phpmailer->SMTPSecure = 'tls';//$this->email_SMTPSecure;
                // opcion de seguridad aumentada.
                // $mail->sign_cert_file="/xxx/key.pem"; 
                // $mail->sign_key_file="/xxx/key.pem"; 
                // $mail->sign_key_pass="yyy"; 
                $phpmailer->Port = 587;//(int)$this->email_Port;

                $phpmailer->IsSMTP(); // use SMTP Gmail
                $phpmailer->SMTPDebug = 2;
                $phpmailer->SMTPAuth = true;
                $phpmailer->AuthType = 'XOAUTH2';                

                $phpmailer->setOAuth(
                    new OAuth(
                        [
                            'provider' => $provider,
                            'clientId' => $this->gmailCredentials['client_id'], // $phpmailer->Username,
                            'clientSecret' => $this->gmailCredentials['client_secret'], // $phpmailer->Password,
                            'refreshToken' =>  $phpmailer->oauthRefreshToken,
                            'userName' => $this->email_user
                        ]
                    )
                );
    
                // mail settings
                $phpmailer->setFrom($phpmailer->Username, $this->email_from_name);

                foreach ($this->email_array_address_to as $address_to) {
                    $phpmailer->AddAddress($address_to); // recipients email                    
                }

                $phpmailer->Subject = $this->email_subject;	

                foreach ($this->email_addAttachment as $Attachment) {
                    $phpmailer->addAttachment($Attachment);
                }           

                $phpmailer->Body = $this->email_body;

                $phpmailer->IsHTML(true);

                if(!$phpmailer->Send()) {
                    error_log("****** Message was not sent. ******");
                    header('HTTP/1.0 400 El mensaje no se ha enviado');
                    die(json_encode(array(
                        'code' => '506',
                        'msg' => 'Ha ocurrido un error al enviar.'))
                    );
                } else {
                    error_log("Message has been sent.");
                }
            } catch (Exception $e) {
                error_log("[ERROR]  Mailer Error: (".$e->getCode()."): ". $e->getMessage());
                if (!headers_sent()) {
                    header('HTTP/1.0 400 Error al generar al enviar el email');
                }                
                die(json_encode(array(
                    'code' => $e->getCode() ,
                    'msg' => $e->getMessage()))
                );                                
            }
        }       

        
    }


?>
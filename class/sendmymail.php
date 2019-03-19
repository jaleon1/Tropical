<?php

    require("phpmailer/class.phpmailer.php"); // Requiere PHPMAILER para poder enviar el formulario desde el SMTP de google

    

    class EnviarMail{
        public $email_From="gpsmovilpro@gmail.com";
        public $email_Name="GPSMovilPRO";
        public $email_Address="info@gpsmovilcr.com";
        public $email_Subject="GPSMovilPRO - Nuevos Datos de Cliente";
        public $email_Cliente= "JASON ROJAS";
        public $email_Pwd= "Rmrm2088";


        function enviar(){
            $mail = new PHPMailer();

            $mail->From     = $this->email_From;
            $mail->FromName = $this->email_Name;
            $mail->AddAddress($this->email_Address); // Dirección a la que llegaran los mensajes.
        
            // Aquí van los datos que apareceran en el correo que reciba        
            $mail->WordWrap = 50;
            $mail->IsHTML(true);
            $mail->Subject  =  $this->email_Subject; // Asunto del mensaje.
            $mail->Body     =  "<br> Datos: " .  $this->email_Cliente . " <br/> Fin de datos del cliente.";
        
            // Datos del servidor SMTP, podemos usar el de Google, Outlook, etc...
            $mail->IsSMTP();
            $mail->Host = "ssl://smtp.gmail.com:465";  // Servidor de Salida. 465 es uno de los puertos que usa Google para su servidor SMTP
            $mail->SMTPAuth = true;
            $mail->Username = $this->email_From;  // Correo Electrónico
            $mail->Password = $this->email_Pwd; // Contraseña del correo
        
            if ($mail->Send())
                error_log("Correo Enviado Exitosamente");
            else
                error_log("Error al enviar el correo");
        }
    }
    
?>

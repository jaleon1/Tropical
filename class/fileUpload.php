<?php 
require_once("Conexion.php");
require_once("Usuario.php");
require_once("encdes.php");
require_once("ClienteFE.php");
if (!isset($_SESSION))
    session_start();
if (!empty($_FILES)) {    
        $cliente= new ClienteFE();
        $cliente->idBodega= $_SESSION['userSession']->idBodega;
        $cliente->ReadProfile();
        // Pasa el certificado al api.
        $cliente->APILogin();
        $cliente->APIUploadCert();
        echo "UPLOADED";
        return true;
}
else {
    error_log('no se almacena la data del path de certificado.');
    echo "upload err!";
    return false;
}
?>
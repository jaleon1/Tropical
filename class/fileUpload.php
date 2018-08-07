<?php 
require_once("Usuario.php");
if (!isset($_SESSION))
        session_start();
$uploaddir= '../../certUploads/'.$_SESSION['userSession']->idBodega.'/';
if (!file_exists($uploaddir)) 
    mkdir($uploaddir, 0600, true);
//$hashName= password_hash($_FILES['file']['name'], PASSWORD_DEFAULT);
//$uploadfile = $uploaddir . basename($hashName);
$uploadfile = $uploaddir . basename($_FILES['file']['name']);
if (!empty($_FILES)) {
    if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {        
        //echo "File is valid, and was successfully uploaded.\n";
        echo "UPLOADED";
        return true;
    } else {
        echo "Possible file upload attack!";
        return false;
    }
}
?>
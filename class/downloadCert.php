<?php
require_once("Usuario.php");
if (!isset($_SESSION))session_start();
//$file= '../../certUploads/'.$_SESSION['userSession']->idBodega.'/'.$_GET['certificado'];
$file= 'a.txt';
if (!file_exists($file))exit;
header("Content-disposition: attachment; filename=a.txt");
header("Content-type: plain/text");
readfile("a.txt");
?>
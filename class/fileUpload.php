<?php
require_once("Conexion.php");
require_once("Usuario.php");
require_once("encdes.php");
require_once("ClienteFE.php");
require_once("Globals.php");
if (!isset($_SESSION))
    session_start();
error_log("[INFO] Iniciando subida de certificado.");
$uploaddir = '../../CU/' . $_SESSION['userSession']->idBodega . DIRECTORY_SEPARATOR;
if (!file_exists($uploaddir))
    mkdir($uploaddir, 0755, true);
$cfile = encdes::cifrar($_FILES['file']['name']);
// busca si el string cifrado tiene un caracter: / ó \
$continuar = false;
while ($continuar == false) {
    if (strpos($cfile, '/') || strpos($cfile, '\\')) {
        $cfile = encdes::cifrar($_FILES['file']['name']);
        $continuar = false;
    } else $continuar = true;
}
//
$uploadfile = $uploaddir . explode('::', $cfile)[0];
if (!empty($_FILES)) {
    // elimina archivos previos, solo debe existir un certificado por agencia.
    $files = glob($uploaddir . '*'); // get all file names
    error_log("[INFO] Eliminando archivos existentes ");
    foreach ($files as $file) {
        if (is_file($file))
            unlink($file);
    }
    // mueve nuevo certificado.
    if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
        $sql = "UPDATE clienteFE 
                SET cpath=:cpath, nkey=:nkey
                WHERE idBodega=:idBodega";
        $param = array(
            ':idBodega' => $_SESSION['userSession']->idBodega,
            ':cpath' => explode('::', $cfile)[0],
            ':nkey' => explode('::', $cfile)[1]
        );
        $data = DATA::Ejecutar($sql, $param, false);
        if ($data) {
            error_log("[INFO] Local move and data ok");
            // sesion del usuario
            $cliente = new ClienteFE();
            $cliente->certificado = realpath($uploaddir) . DIRECTORY_SEPARATOR . $_FILES['file']['name'];
            // crea copia temporal sin cifrar para mover al API.
            copy($uploadfile, $cliente->certificado);
            chmod($cliente->certificado, 0777);
            unlink($cliente->certificado);
            error_log("[INFO] Certificado OK");
            echo "UPLOADED";
            return true;
        } else {
            error_log('[ERROR] No se almacena la data del path de certificado (-655).');
            echo "upload err!";
            return false;
        }
    } else {
        error_log('[ERROR] Local move failed (-656).');
        echo "upload attack!";
        return false;
    }
}

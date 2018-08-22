<?php 
require_once("Conexion.php");
require_once("Usuario.php");
require_once("encdes.php");
if (!isset($_SESSION))
    session_start();
    error_log('dir');
$uploaddir= '../../CU/'.$_SESSION['userSession']->idBodega.'/';
if (!file_exists($uploaddir)) 
    mkdir($uploaddir, 0700, true);
    error_log('dir ok');
$cfile= encdes::cifrar($_FILES['file']['name']);
error_log('cif');
$uploadfile = $uploaddir . explode('::', $cfile)[0];
if (!empty($_FILES)) {
    if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
        error_log('mv');
        $sql="UPDATE clienteFE 
                SET cpath=:cpath, nkey=:nkey
                WHERE idBodega=:idBodega";
        $param= array(':idBodega'=>$_SESSION['userSession']->idBodega, 
            ':cpath'=>explode('::', $cfile)[0], 
            ':nkey'=>explode('::', $cfile)[1]);
        $data = DATA::Ejecutar($sql,$param,false);
        if($data){
            echo "UPLOADED";
            return true;
        }
        else {
            error_log('data');
            echo "upload err!";
            return false;
        }
    } else {
        error_log('mvf');
        echo "upload attack!";
        return false;
    }
}
?>
<?php 
require_once("Conexion.php");
require_once("Usuario.php");
require_once("encdes.php");
if (!isset($_SESSION))
    session_start();
$uploaddir= '../../CU/'.$_SESSION['userSession']->idBodega.'/';
if (!file_exists($uploaddir)) 
    mkdir($uploaddir, 0777, true);
$cfile= encdes::cifrar($_FILES['file']['name']);
$uploadfile = $uploaddir . explode('::', $cfile)[0];
if (!empty($_FILES)) {
    //
    $content = "abc";
    $fp = fopen($_SERVER['DOCUMENT_ROOT'] . "/myText.txt","wb");
    fwrite($fp,$content);
    fclose($fp);
    //
    if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
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
            echo "upload err!";
            return false;
        }
    } else {
        echo "upload attack!";
        return false;
    }
}
?>
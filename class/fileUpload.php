<?php 
require_once("Conexion.php");
require_once("Usuario.php");
require_once("encdes.php");
require_once("ClienteFE.php");
if (!isset($_SESSION))
    session_start();
$uploaddir= '../../CU/'.$_SESSION['userSession']->idBodega.'/';
if (!file_exists($uploaddir)) 
    mkdir($uploaddir, 0700, true);
$cfile= encdes::cifrar($_FILES['file']['name']);
$uploadfile = $uploaddir . explode('::', $cfile)[0];
if (!empty($_FILES)) {
    if (move_uploaded_file($_FILES['file']['tmp_name'], $uploadfile)) {
        $sql="UPDATE clienteFE 
                SET cpath=:cpath, nkey=:nkey
                WHERE idBodega=:idBodega";
        $param= array(':idBodega'=>$_SESSION['userSession']->idBodega, 
            ':cpath'=>explode('::', $cfile)[0], 
            ':nkey'=>explode('::', $cfile)[1]);
        $data = DATA::Ejecutar($sql,$param,false);
        if($data){            
            // nombre de usuario para api.
            // $sql="SELECT email, password FROM tropical.clienteFE
            //     WHERE idBodega= :idBodega";
            // $param= array(':idBodega'=>$_SESSION['userSession']->idBodega);
            // $data = DATA::Ejecutar($sql,$param);
            // sesion del usuario
            $cliente= new ClienteFE();
            $cliente->idBodega= $_SESSION['userSession']->idBodega;
            $cliente->ReadProfile();
            $cliente->APILogin();
            // Pasa el certificado al api.
            echo "UPLOADED";
            return true;
        }
        else {
            error_log('no se almacena la data del path de certificado.');
            echo "upload err!";
            return false;
        }
    } else {
        error_log('mv failed');
        echo "upload attack!";
        return false;
    }
}
?>
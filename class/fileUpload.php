<?php 
require_once("Conexion.php");
require_once("Usuario.php");
require_once("encdes.php");
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
            echo "UPLOADED";
            // nombre de usuario.
            // $sql="SELECT userName
            //     FROM api_base.users
            //     WHERE id";
            // $param= array(':idBodega'=>$_SESSION['userSession']->idBodega, 
            //     ':cpath'=>explode('::', $cfile)[0], 
            //     ':nkey'=>explode('::', $cfile)[1]);
            // $data = DATA::Ejecutar($sql,$param,false);
            // Pasa el certificado al api.
            if (file_exists($uploadfile)){
                $url= 'http://104.131.5.198/api.php';                                
                $ch = curl_init();
                $post = [
                    'w' => 'fileUploader',
                    'r' => 'subir_certif',
                    'sessionKey'   => $_SESSION['userSession']->sessionKey,
                    'fileToUpload'   => $uploadfile,
                    'iam'   => $_SESSION['userSession']->ATVuserName
                ];  
                curl_setopt_array($ch, array(
                    CURLOPT_URL => $url,
                    CURLOPT_RETURNTRANSFER => true,   
                    CURLOPT_VERBOSE => true,                      
                    CURLOPT_MAXREDIRS => 10,
                    CURLOPT_TIMEOUT => 30,
                    //CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                    CURLOPT_CUSTOMREQUEST => "POST",
                    CURLOPT_POSTFIELDS => $post
                ));
                $server_output = curl_exec($ch);
                $information = curl_getinfo($ch);
                $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
                $header = substr($server_output, 0, $header_size);
                $body = substr($server_output, $header_size);
                $error_msg = "";
                if (curl_error($ch)) {
                    $error_msg = curl_error($ch);
                    error_log("error: ". $error_msg);
                }
                curl_close($ch);
            }
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
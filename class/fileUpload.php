<?php 
$uploaddir= '../../../certUploads/';
$hashName= password_hash($_FILES['file']['name'], PASSWORD_DEFAULT);
$uploadfile = $uploaddir . basename($hashName);
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
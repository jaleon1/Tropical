<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Usuario.php");
    require_once("encdes.php");
    require_once("Bodega.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $clientefe= new ClienteFE();
    switch($opt){
        case "ReadAll":
            echo json_encode($clientefe->ReadAll());
            break;
        case "ReadProfile":
            echo json_encode($clientefe->ReadProfile());
            break;
        case "ReadAllTipoIdentificacion":
            echo json_encode($clientefe->ReadAllTipoIdentificacion());
            break;
        case "ReadAllUbicacion":
            $clientefe->idProvincia = $_POST['idProvincia'];
            $clientefe->idCanton = $_POST['idCanton'];
            $clientefe->idDistrito = $_POST['idDistrito'];
            echo json_encode($clientefe->ReadAllUbicacion());
            break;        
        case "ReadAllProvincia":
            echo json_encode($clientefe->ReadAllProvincia());
            break;
        case "ReadAllCanton":
            $clientefe->idProvincia = $_POST['idProvincia'];
            echo json_encode($clientefe->ReadAllCanton());
            break;
        case "ReadAllDistrito":
            $clientefe->idCanton = $_POST['idCanton'];
            echo json_encode($clientefe->ReadAllDistrito());
            break;
        case "ReadAllBarrio":
            $clientefe->idDistrito = $_POST['idDistrito'];
            echo json_encode($clientefe->ReadAllBarrio());
            break;
        case "Create":
            echo $clientefe->Create();
            break;
        case "Update":
            $clientefe->Update();
            break;
        case "APILogin":
            $clientefe->ReadProfile(); // lee el perfil del contribuyente y loguea al API.
            break;
        case "Delete":
            $clientefe->Delete();
            break;
        case "DeleteCertificado":
            $clientefe->certificado = $_POST['certificado'];
            $clientefe->DeleteCertificado();
            break;
        case "testConnection":
            $clientefe->username= $_POST["username"];
            $clientefe->password= $_POST["password"];
            $clientefe->correoElectronico= $_POST["correoElectronico"];
            echo json_encode($clientefe->testConnection());
            break;      
    }
}

class Provincia{
    public $id;
    public $value;
    public static function Read(){
        try {
            $sql= 'SELECT id, provincia as value
                FROM tropical.provincia';
            $data= DATA::Ejecutar($sql);
            $lista = [];
            foreach ($data as $key => $value){
                $item = new Provincia();
                $item->id = $value['id']; 
                $item->value = $value['value'];
                array_push ($lista, $item);
            }
            return $lista;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }
}

class Canton{
    public $id;
    public $value;
    public static function Read($idProvincia){
        try {
            $sql= 'SELECT id, canton as value
                FROM tropical.canton
                WHERE idProvincia=:idProvincia';
            $param= array(':idProvincia'=>$idProvincia);
            $data= DATA::Ejecutar($sql,$param);
            $lista = [];
            foreach ($data as $key => $value){
                $item = new Canton();
                $item->id = $value['id']; 
                $item->value = $value['value'];
                array_push ($lista, $item);
            }
            return $lista;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }
}

class Distrito{
    public $id;
    public $value;
    public static function Read($idCanton){
        try {
            $sql= 'SELECT id, distrito as value
                FROM tropical.distrito
                WHERE idCanton=:idCanton';
            $param= array(':idCanton'=>$idCanton);
            $data= DATA::Ejecutar($sql,$param);
            $lista = [];
            foreach ($data as $key => $value){
                $item = new Distrito();
                $item->id = $value['id']; 
                $item->value = $value['value'];
                array_push ($lista, $item);
            }
            return $lista;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }
}

class Barrio{
    public $id;
    public $value;
    public static function Read($idDistrito){
        try {
            $sql= 'SELECT id, barrio as value
                FROM tropical.barrio
                WHERE idDistrito=:idDistrito';
            $param= array(':idDistrito'=>$idDistrito);
            $data= DATA::Ejecutar($sql,$param);
            $lista = [];
            foreach ($data as $key => $value){
                $item = new Barrio();
                $item->id = $value['id']; 
                $item->value = $value['value'];
                array_push ($lista, $item);
            }
            return $lista;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }
}

class UbicacionCod{
    public $provincia;
    public $canton;
    public $distrito;
    public $barrio;
}

class ClienteFE{
    public $id=null;
    public $codigoSeguridad='';
    public $idCodigoPais='';    
    public $nombre='';
    public $idTipoIdentificacion=null;
    public $identificacion='';
    public $nombreComercial=null;
    public $idDocumento;
    public $idProvincia=null;
    public $idCanton=null;
    public $idDistrito=null;
    public $idBarrio=null;
    public $otrasSenas=null;
    public $idCodigoPaisTel=null;
    public $numTelefono=null;
    public $idCodigoPaisFax=null;
    public $numTelefonoFax=null;
    public $correoElectronico=null;
    public $pinp12=null;
    public $idBodega=null;
    public $filesize= null;
    public $filename= null;
    public $filetype= null;
    public $estadoCertificado= 1;
    public $sessionKey;
    public $downloadCode; // codigo de descarga del certificado para cifrar xml.
    public $apiUrl;
    //
    public $ubicacion= [];

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["idBodega"]))
            $this->idBodega= $obj["idBodega"];
        else $this->idBodega= $_SESSION['userSession']->idBodega;
        if(isset($_POST["objC"])){
            $obj= json_decode($_POST["objC"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();         
            $this->codigoSeguridad= $obj["codigoSeguridad"];
            $this->idDocumento= $obj["idDocumento"] ?? 1;
            $this->nombre= $obj["nombre"] ?? '';   
            $this->idCodigoPais= $obj["idCodigoPais"] ?? null;                  
            $this->idTipoIdentificacion= $obj["idTipoIdentificacion"] ?? null;
            $this->identificacion= $obj["identificacion"] ?? null;
            $this->nombreComercial= $obj["nombreComercial"] ?? null;
            $this->idProvincia= $obj["idProvincia"] ?? null;
            $this->idCanton= $obj["idCanton"] ?? null;
            $this->idDistrito= $obj["idDistrito"] ?? null;
            $this->idBarrio= $obj["idBarrio"] ?? null;
            $this->otrasSenas= $obj["otrasSenas"] ?? null;
            $this->idCodigoPaisTel= $obj["idCodigoPaisTel"] ?? null;
            $this->numTelefono= $obj["numTelefono"] ?? null;
            //$this->idCodigoPaisFax= $obj["idCodigoPaisFax"] ?? null;
            //$this->numTelefonoFax= $obj["numTelefonoFax"] ?? null;
            $this->correoElectronico= $obj["correoElectronico"] ?? null;
            $this->username= $obj["username"] ?? null;
            $this->password= $obj["password"] ?? null;
            $this->certificado= $obj["certificado"] ?? null;
            $this->pinp12= $obj["pinp12"] ?? null;            
        }
    }

    function ReadAll(){
        try {
            $sql= '';
            $data= DATA::Ejecutar($sql);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function ReadAllTipoIdentificacion(){
        try {
            $sql= 'SELECT id, codigo, tipo as value
                FROM tipoIdentificacion';
            $data= DATA::Ejecutar($sql);
            return $data;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function ReadAllUbicacion(){
        try {
            array_push ($this->ubicacion,Provincia::Read());
            array_push ($this->ubicacion,Canton::Read($this->idProvincia));
            array_push ($this->ubicacion,Distrito::Read($this->idCanton));
            array_push ($this->ubicacion,Barrio::Read($this->idDistrito));
            return $this->ubicacion;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function ReadAllProvincia(){
        try {
            return Provincia::Read();            
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function ReadAllCanton(){
        try {
            return Canton::Read($this->idProvincia);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function ReadAllDistrito(){
        try {
            return Distrito::Read($this->idCanton);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function ReadAllBarrio(){
        try {
            return Barrio::Read($this->idDistrito);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }
    
    public function read(){
        try {
            $sql='SELECT id, idBodega, codigoSeguridad, idCodigoPais, idDocumento, nombre, idTipoIdentificacion, identificacion, nombreComercial, idProvincia, idCanton, idDistrito,
                    idBarrio, otrasSenas, numTelefono, correoElectronico, username, password, pinp12, downloadCode, certificado, cpath
                FROM clienteFE
                where idBodega=:idBodega';
            $param= array(':idBodega'=>$this->idBodega);
            $data= DATA::Ejecutar($sql, $param);
            if($data){
                $this->id= $data[0]['id'];
                $this->codigoSeguridad= $data[0]['codigoSeguridad'];
                $this->idCodigoPais= $data[0]['idCodigoPais'];
                $this->idDocumento= $data[0]['idDocumento'];
                $this->nombre= $data[0]['nombre'];
                $this->idTipoIdentificacion= $data[0]['idTipoIdentificacion'];
                $this->identificacion= $data[0]['identificacion'];
                $this->nombreComercial= $data[0]['nombreComercial'];
                $this->idProvincia= $data[0]['idProvincia'];
                $this->idCanton= $data[0]['idCanton'];
                $this->idDistrito= $data[0]['idDistrito'];
                $this->idBarrio= $data[0]['idBarrio'];
                $this->otrasSenas= $data[0]['otrasSenas'];
                $this->numTelefono= $data[0]['numTelefono']; 
                $this->correoElectronico= $data[0]['correoElectronico'];
                $this->username= encdes::decifrar($data[0]['username']);
                $this->password= encdes::decifrar($data[0]['password']);
                $this->pinp12= encdes::decifrar($data[0]['pinp12']);
                $this->downloadCode= $data[0]['downloadCode'];
                $this->certificado= $data[0]['certificado'];
                $this->cpath = $data[0]['cpath'];                
                // estado del certificado.
                if(file_exists(Globals::certDir.$this->id.DIRECTORY_SEPARATOR.$this->cpath))
                    $this->estadoCertificado=1;
                else $this->estadoCertificado=0;      
                $this->certificado= encdes::decifrar($data[0]['certificado']);
                return $this;
            }
            return null;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el contribuyente'))
            );
        }
    }

    function checkProfile(){
        try{
            // bodega interna. 
            // require_once("Bodega.php");
            $central = new Bodega();
            $central->readCentral();
            $bodega = new Bodega();
            $bodega->ReadbyId($_SESSION['userSession']->idBodega);
            $param='';
            if($bodega->tipo == $central->tipo){
                $param= array(':idBodega'=>$central->id);
            }
            else 
                $param= array(':idBodega'=>$_SESSION["userSession"]->idBodega);
            //
            $sql="SELECT id
                from clienteFE
                where idBodega=:idBodega";
            //
            $data= DATA::Ejecutar($sql,$param);
            if(count($data)){
                return true;
            }
            else {
                return false;
            }
        }
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function ReadProfile(){
        try {
            // bodega interna. 
            $central = new Bodega();
            $central->readCentral();
            $bodega = new Bodega();
            $bodega->ReadbyId($_SESSION['userSession']->idBodega);
            if($bodega->tipo == $central->tipo && $bodega->id != $central->id){
                // interna. Solo muestra certificado en central
                return "INTERNA";
            }
            $sql='SELECT id, codigoSeguridad, idCodigoPais, idDocumento, nombre, idTipoIdentificacion, identificacion, nombreComercial, idProvincia, idCanton, idDistrito, 
                    idBarrio, otrasSenas, numTelefono, correoElectronico, username, password, pinp12, downloadCode, certificado, cpath
                FROM clienteFE
                where idBodega=:idBodega';
            $param= array(':idBodega'=>$_SESSION['userSession']->idBodega);
            $data= DATA::Ejecutar($sql,$param);
            if($data){
                $this->id= $data[0]['id'];
                $this->codigoSeguridad= $data[0]['codigoSeguridad'];
                $this->idCodigoPais= $data[0]['idCodigoPais'];
                $this->idDocumento= $data[0]['idDocumento'];
                $this->nombre= $data[0]['nombre'];
                $this->idTipoIdentificacion= $data[0]['idTipoIdentificacion'];
                $this->identificacion= $data[0]['identificacion'];
                $this->nombreComercial= $data[0]['nombreComercial'];
                $this->idProvincia= $data[0]['idProvincia'];
                $this->idCanton= $data[0]['idCanton'];
                $this->idDistrito= $data[0]['idDistrito'];
                $this->idBarrio= $data[0]['idBarrio'];
                $this->otrasSenas= $data[0]['otrasSenas'];
                $this->numTelefono= $data[0]['numTelefono']; 
                $this->correoElectronico= $data[0]['correoElectronico'];
                $this->username= encdes::decifrar($data[0]['username']);
                $this->password= encdes::decifrar($data[0]['password']);
                $this->pinp12= encdes::decifrar($data[0]['pinp12']);
                $this->downloadCode= $data[0]['downloadCode'];
                $this->certificado= $data[0]['certificado'];
                $this->cpath = $data[0]['cpath'];    
                // estado del certificado.
                if(file_exists(Globals::certDir.$this->idBodega.'/'.$this->cpath) || file_exists(Globals::certDir.$this->idBodega.'\\'.$this->cpath))
                    $this->estadoCertificado=1;
                else
                    $this->estadoCertificado=0;   
                $this->certificado= encdes::decifrar($data[0]['certificado']);
                // variables para loguear al api server
                $_SESSION['APISERVER-username']= $this->username;
                $_SESSION['APISERVER-password']= $this->password;
                return $this;
            } else return null;
        }
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el contribuyente'))
            );
        }
    }

    function Check(){
        try {
            $sql='SELECT id
                FROM clienteFE  
                where idBodega=:idBodega';
            $param= array(':idBodega'=>$_SESSION['userSession']->idBodega);
            $data= DATA::Ejecutar($sql,$param);
            if($data){
                return true;
            }
            return false;
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    function createAPIProfile(){
        try{
            //guarda api_base.users
            $this->getApiUrl();
            $ch = curl_init();
            $post = [
                'w' => 'users',
                'r' => 'users_register',
                'fullName'   => $this->nombre,
                'userName'   => $this->username, // username dentro del API SERVER = username ATV.
                'email'   => $this->username,
                'about'   => 'StoryLabsUser',
                'country'   => 'CR',
                'pwd'   => $this->password
            ];  
            curl_setopt_array($ch, array(
                CURLOPT_URL => $this->apiUrl,
                CURLOPT_RETURNTRANSFER => true,   
                CURLOPT_VERBOSE => true,      
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $post
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                error_log("[ERROR]  ". $error_msg);
                throw new Exception('Error al crear usuario API SERVER. Comunicarse con Soporte Técnico', 055);
            }
            $sArray=json_decode($header);
            if(!isset($sArray->resp)){
                throw new Exception('Error CRITICO al inciar sesion del API y crear perfil. DEBE COMUNICARSE CON SOPORTE TECNICO', '66690');
            }
            if($sArray->resp=='-300')
                throw new Exception('[ERROR_USERS_NO_VALID] Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , $sArray->resp);
            if($sArray->resp=='-301')
                throw new Exception('[ERROR_USERS_WRONG_LOGIN_INFO] Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , $sArray->resp);
            if($sArray->resp=='-302')
                throw new Exception('[ERROR_USERS_NO_VALID_SESSION] Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , $sArray->resp);
            if($sArray->resp=='-303')
                throw new Exception('[ERROR_USERS_ACCESS_DENIED] Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , $sArray->resp);
            if($sArray->resp=='-304')
                throw new Exception('[USUARIO] Error, El usuario de ATV ya se encuentra registrado', $sArray->resp);
            if($sArray->resp=='-305')
                throw new Exception('[ERROR_USERS_NO_TOKEN] Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , $sArray->resp);
            //
            error_log("[INFO]  ". $server_output);
            curl_close($ch);
            // variables para loguear al api server
            $_SESSION['APISERVER-username']= $this->username;
            $_SESSION['APISERVER-password']= $this->password;      
            //
            return true;
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Create(){
        try {
            $this->createAPIProfile();
            //
            $sql="INSERT INTO clienteFE  (id, codigoSeguridad, idCodigoPais, idDocumento, nombre, idTipoIdentificacion, identificacion, nombreComercial, idProvincia,idCanton, idDistrito, idBarrio, otrasSenas, 
                idCodigoPaisTel, numTelefono, correoElectronico, username, password, certificado, idBodega, pinp12)
                VALUES (:id, :codigoSeguridad, :idCodigoPais, :idDocumento, :nombre, :idTipoIdentificacion, :identificacion, :nombreComercial, :idProvincia, :idCanton, :idDistrito, :idBarrio, :otrasSenas, 
                    :idCodigoPaisTel, :numTelefono, :correoElectronico, :username, :password, :certificado, :idBodega, :pinp12);";
            $param= array(':id'=>$this->id,
                ':codigoSeguridad'=>$this->codigoSeguridad, 
                ':idCodigoPais'=>$this->idCodigoPais,
                ':idDocumento'=>$this->idDocumento,
                ':nombre'=>$this->nombre,
                ':idTipoIdentificacion'=>$this->idTipoIdentificacion,
                ':identificacion'=>$this->identificacion,
                ':nombreComercial'=>$this->nombreComercial,
                ':idProvincia'=>$this->idProvincia,
                ':idCanton'=>$this->idCanton,
                ':idDistrito'=>$this->idDistrito,
                ':idBarrio'=>$this->idBarrio,
                ':otrasSenas'=>$this->otrasSenas,
                ':idCodigoPaisTel'=>$this->idCodigoPaisTel,
                ':numTelefono'=>$this->numTelefono,
                ':correoElectronico'=>$this->correoElectronico,
                ':username'=>encdes::cifrar($this->username),
                ':password'=>encdes::cifrar($this->password),
                ':certificado'=>encdes::cifrar($this->certificado),
                ':idBodega'=>$this->idBodega,
                ':pinp12'=>encdes::cifrar($this->pinp12),
            );
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
            {                
                $_SESSION['userSession']->bodega= $this->nombre;
                $_SESSION['userSession']->idDocumento= $this->idDocumento; // fe - te...   
                return true;               
            }
            else throw new Exception('Error al guardar.', 02);
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function updateAPIProfile(){
        try{
            // ... modifica datos del perfil en el api ...//
            $this->getApiUrl();
            $this->APILogin();
            $ch = curl_init();
            $post = [
                'w' => 'users',
                'r' => 'users_update_profile',
                'sessionKey'=> $_SESSION['APISERVER-sessionKey'],
                'iam'=> $_SESSION['APISERVER-username'],
                'fullName'   => $this->nombre,
                'userName'   => $this->username, // username dentro del API es el correo electronico del perfil o bodega.
                'email'   => $this->username,
                'about'   => 'StoryLabsUser Updated',
                'country'   => 'CR',
                'pwd'   => $this->password
            ];  
            curl_setopt_array($ch, array(
                CURLOPT_URL => $this->apiUrl,
                CURLOPT_RETURNTRANSFER => true,   
                CURLOPT_VERBOSE => true,      
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $post
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                error_log("[ERROR]  ". $error_msg);
                throw new Exception('Error al crear usuario API SERVER. Comunicarse con Soporte Técnico', 055);
            }
            $sArray=json_decode($header);
            if(!isset($sArray->resp)){
                throw new Exception('Error CRITICO al inciar sesion del API y actualizar perfil. DEBE COMUNICARSE CON SOPORTE TECNICO', '66615');
            }
            if($sArray->resp=='-304'){
                throw new Exception('Error, El usuario de ATV ya se encuentra registrado', '-304');
            }
            if($sArray->resp!='1'){
                throw new Exception('Error CRITICO al inciar sesion del API y actualizar perfil, STATUS('.$sArray->resp.') . DEBE COMUNICARSE CON SOPORTE TECNICO', '66615');
            }
            error_log("[INFO]: Perfil actualizado:  ". $sArray->resp);
            curl_close($ch);
            // Nuevas variables para loguear al api server
            $_SESSION['APISERVER-username']= $this->username;
            $_SESSION['APISERVER-password']= $this->password;
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Update(){
        try {
            $this->updateAPIProfile();
            $sql="UPDATE clienteFE 
                SET nombre=:nombre, codigoSeguridad=:codigoSeguridad, idCodigoPais=:idCodigoPais, idTipoIdentificacion=:idTipoIdentificacion, 
                    identificacion=:identificacion, nombreComercial=:nombreComercial, idProvincia=:idProvincia, idCanton=:idCanton, idDistrito=:idDistrito, 
                    idBarrio=:idBarrio, otrasSenas=:otrasSenas, numTelefono=:numTelefono, correoElectronico=:correoElectronico, username=:username, password=:password, 
                    certificado=:certificado, pinp12= :pinp12
                WHERE idBodega=:idBodega";
            $param= array(':nombre'=>$this->nombre, ':codigoSeguridad'=>$this->codigoSeguridad, ':idCodigoPais'=>$this->idCodigoPais, ':idTipoIdentificacion'=>$this->idTipoIdentificacion,
                ':identificacion'=>$this->identificacion, ':nombreComercial'=>$this->nombreComercial, ':idProvincia'=>$this->idProvincia,
                ':idCanton'=>$this->idCanton, ':idDistrito'=>$this->idDistrito, ':idBarrio'=>$this->idBarrio,
                ':otrasSenas'=>$this->otrasSenas, ':numTelefono'=>$this->numTelefono, ':correoElectronico'=>$this->correoElectronico,
                ':username'=>encdes::cifrar($this->username), ':password'=>encdes::cifrar($this->password), ':certificado'=>encdes::cifrar($this->certificado), ':idBodega'=>$this->idBodega, 
                ':pinp12'=>encdes::cifrar($this->pinp12)
            );
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                return true;
            }   
            else throw new Exception('Error al actualizar el perfil.', 123);
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    private function getApiUrl(){
        require_once('Globals.php');
        if (file_exists('../../../ini/config.ini')) {
            $set = parse_ini_file('../../../ini/config.ini',true); 
            $this->apiUrl = $set[Globals::app]['apiurl'];
        }         
        else throw new Exception('Acceso denegado al Archivo de configuración.',-1);
    }

    public function APILogin(){
        try{
            error_log("[INFO] API LOGIN ... ");
            //
            $this->getApiUrl();
            $ch = curl_init();
            $post = [
                'w' => 'users',
                'r' => 'users_log_me_in',
                'userName'   => $_SESSION['APISERVER-username'],
                'pwd'   => $_SESSION['APISERVER-password']
            ];  
            curl_setopt_array($ch, array(
                CURLOPT_URL => $this->apiUrl,
                CURLOPT_RETURNTRANSFER => true,   
                CURLOPT_VERBOSE => true,      
                CURLOPT_RETURNTRANSFER => true,
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $post
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                throw new Exception('Error al iniciar login API. '. $error_msg , 02);
            }
            curl_close($ch);
            // session de usuario ATV
            $sArray=json_decode($header);
            if(!isset($sArray->resp->sessionKey)){
                // ERROR CRITICO:
                // debe notificar al contibuyente. 
                if(isset($sArray->resp)){
                    if($sArray->resp=='-300')
                        throw new Exception('[ERROR_USERS_NO_VALID] Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , $sArray->resp);
                    if($sArray->resp=='-301')
                        throw new Exception('[ERROR_USERS_WRONG_LOGIN_INFO] Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , $sArray->resp);
                    if($sArray->resp=='-302')
                        throw new Exception('[ERROR_USERS_NO_VALID_SESSION] Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , $sArray->resp);
                    if($sArray->resp=='-303')
                        throw new Exception('[ERROR_USERS_ACCESS_DENIED] Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , $sArray->resp);
                    if($sArray->resp=='-304')
                        throw new Exception('[ERROR_USERS_EXISTS] Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , $sArray->resp);
                    if($sArray->resp=='-305')
                        throw new Exception('[ERROR_USERS_NO_TOKEN] Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , $sArray->resp);
                }
                throw new Exception('Error CRITICO al inciar sesion del API. DEBE COMUNICARSE CON SOPORTE TECNICO'. $error_msg , '66612');
            }            
            $this->sessionKey= $sArray->resp->sessionKey;
            $_SESSION['APISERVER-sessionKey']=  $this->sessionKey;
            error_log("sessionKey: ". $sArray->resp->sessionKey);
            return true;
        } 
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public function APIUploadCert(){
        try{
            error_log("[INFO] Subiendo certificado API CRL: ". $this->certificado);
            if (!file_exists($this->certificado)){
                throw new Exception('Error al guardar el certificado. El certificado no existe' , 002256);
            }
            $this->getApiUrl();
            $this->APILogin();
            $ch = curl_init();
            $post = [
                'w' => 'fileUploader',
                'r' => 'subir_certif',
                'sessionKey'=> $_SESSION['APISERVER-sessionKey'],
                'fileToUpload' => new CurlFile($this->certificado, 'application/x-pkcs12'),
                'iam'=> $_SESSION['APISERVER-username']
            ];
            curl_setopt_array($ch, array(
                CURLOPT_URL => $this->apiUrl,
                CURLOPT_RETURNTRANSFER => true,   
                CURLOPT_VERBOSE => true,                      
                CURLOPT_MAXREDIRS => 10,
                CURLOPT_TIMEOUT => 30,
                CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
                CURLOPT_CUSTOMREQUEST => "POST",
                CURLOPT_POSTFIELDS => $post
            ));
            $server_output = curl_exec($ch);
            $header_size = curl_getinfo($ch, CURLINFO_HEADER_SIZE);
            $header = substr($server_output, 0, $header_size);
            $body = substr($server_output, $header_size);
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                throw new Exception('Error al guardar el certificado. '. $error_msg , 033);
            }
            error_log("[INFO]: ". $server_output);
            $sArray= json_decode($server_output);
            if(!isset($sArray->resp->downloadCode)){
                // ERROR CRITICO:
                // debe notificar al contibuyente. 
                throw new Exception('Error CRITICO al leer downloadCode: '.$server_output, 0344);
            }
            // almacena dowloadCode en clienteFE
            $sql="UPDATE clienteFE
                SET downloadCode=:downloadCode
                WHERE idBodega=:idBodega";
            $param= array(':idBodega'=>$_SESSION['userSession']->idBodega, ':downloadCode'=>$sArray->resp->downloadCode);
            $data = DATA::Ejecutar($sql,$param, false);
            if($data)
                return true;
            else throw new Exception('Error al guardar el downloadCode.', 0345);
            //
            curl_close($ch);
            return true;
        } 
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function testConnection(){
        try{
            $url='';
            $apiMode = strpos($this->username, 'prod');
            if ($apiMode === false){
                $url= 'https://idp.comprobanteselectronicos.go.cr/auth/realms/rut-stag/protocol/openid-connect/token';
                $apiMode = 'api-stag';
            }
            else{
                $url= 'https://idp.comprobanteselectronicos.go.cr/auth/realms/rut/protocol/openid-connect/token';
                $apiMode = 'api-prod';
            }
            //
            $data = array(
                'client_id' => $apiMode, 
                'grant_type' => 'password',
                'username' => $this->username,
                'password' => $this->password
            );
            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL,$url);
            curl_setopt($ch, CURLOPT_POST, 1);
            //curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLINFO_HEADER_OUT, true);
            curl_setopt($ch,CURLOPT_VERBOSE,true);    
            curl_setopt($ch, CURLOPT_FAILONERROR, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($data));
            $server_output = curl_exec ($ch);
            $information = curl_getinfo($ch);            
            //
            $error_msg = "";
            if (curl_error($ch)) {
                $error_msg = curl_error($ch);
                throw new Exception('Error al adquirir token. '. $error_msg , -305);
            }
            if ($information['http_code'] == 200) { 
                $sArray= json_decode($server_output);
                $accessToken=$sArray->access_token;
                error_log("[INFO] PRUEBA DE CONEXION, TOKEN = " . $accessToken);
                curl_close($ch);
                return true;
            }
            else{
                throw new Exception('Error CRITICO al Solicitar token SERVER. DEBE COMUNICARSE CON SOPORTE TECNICO: '. $server_output , -305);                
            }            
        } 
        catch(Exception $e) {
            //curl_close($ch);
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    private function CheckRelatedItems(){
        try{
            $sql="SELECT id
                FROM /*  definir relacion */ R
                WHERE R./*definir campo relacion*/= :id";                
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param);
            if(count($data))
                return true;
            else return false;
        }
        catch(Exception $e){
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Delete(){
        try {              
            $sql='DELETE FROM clienteFE  
            WHERE id= :id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data){
                return $sessiondata['status']=0; 
            }
            else throw new Exception('Error al eliminar.', 978);
        }
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function DeleteCertificado(){
        try {
            //borra el certificado fisico
            $sql='SELECT cpath
                FROM clienteFE
                where idBodega=:idBodega';
            $param= array(':idBodega'=>$_SESSION['userSession']->idBodega);
            $data= DATA::Ejecutar($sql,$param);
            $cpath = $data[0]['cpath'];
            unlink('../../CU/'.$_SESSION['userSession']->idBodega.'/'.$cpath);   
            //borra registro
            $sql='UPDATE clienteFE
                SET certificado= "<eliminado por el usuario>", cpath= "", nkey= ""
                WHERE id= :id';
            $param= array(':id'=>$this->id);
            DATA::Ejecutar($sql, $param, false);
            error_log("[INFO]  Certificado eliminado");
        }
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode(),
                'msg' => $e->getMessage()))
            );
        }
    }

}

?>
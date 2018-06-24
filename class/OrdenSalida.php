<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once('Evento.php');
    require_once('Usuario.php');
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $ordensalida= new OrdenSalida();
    switch($opt){
        case "ReadAll":
            echo json_encode($ordensalida->ReadAll());
            break;
        case "Read":
            echo json_encode($ordensalida->Read());
            break;
        case "Create":
            $ordensalida->Create();
            break;
        // case "Update":
        //     $ordensalida->Update();
        //     break;
        // case "Delete":
        //     echo json_encode($ordensalida->Delete());
        //     break;   
    }
}

class OrdenSalida{
    public $id=null;
    public $numeroorden='';
    public $fecha='';
    public $fechaliquida='';
    public $idusuarioentrega='';
    public $idusuariorecibe='';
    public $usuarioentrega='';
    public $usuariorecibe='';
    public $idestado='';
    public $listainsumo=[];

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->fecha= $obj["fecha"] ?? '';
            $this->fechaliquida= $obj["fechaliquida"] ?? '';
            $this->usuarioentrega= $_SESSION['usersession']->id;
            $this->usuariorecibe= $obj["usuariorecibe"] ?? '';
            $this->idestado= $obj["estado"] ?? 0;
            //Insumos de la orden
            if (isset($obj["listainsumo"] )) {
                require_once("InsumosxOrdenSalida.php");    
                //            
                foreach ($obj["listainsumo"] as $objInsumo) {
                    $ins_ordensalida= new InsumosxOrdenSalida();
                    $ins_ordensalida->idordensalida= $this->id;
                    $ins_ordensalida->idinsumo= $objInsumo['id'];
                    $ins_ordensalida->cantidad= $objInsumo['cantidad'];
                    $ins_ordensalida->costopromedio= $objInsumo['costopromedio'];
                    array_push ($this->listainsumo, $ins_ordensalida);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT `id`,`fecha`,`numeroorden`,`idusuarioentrega`, (SELECT nombre FROM usuario WHERE id=idusuarioentrega) as usuarioentrega,
            `idusuariorecibe`, (SELECT nombre FROM usuario WHERE id=idusuariorecibe) as usuariorecibe, `fechaliquida`, `idestado`
                FROM     ordensalida       
                ORDER BY numeroorden asc';
            $data= DATA::Ejecutar($sql);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function Read(){
        try {
            $ordensalida=null;
            $insumoxordensalida=null;

            $sql_ordensalida=$sql='SELECT `id`,`fecha`,`numeroorden`,`idusuarioentrega`, (SELECT nombre FROM usuario WHERE id=idusuarioentrega) as usuarioentrega,
            `idusuariorecibe`, (SELECT nombre FROM usuario WHERE id=idusuariorecibe) as usuariorecibe, `fechaliquida`, `idestado`
            FROM ordensalida WHERE id=:id ORDER BY numeroorden asc';
            
            $sql_insumoxordensalida='SELECT id,idordensalida,idinsumo,(SELECT nombre FROM insumo WHERE id=idinsumo) AS nombreinsumo,cantidad,costopromedio FROM insumosxordensalida WHERE idordensalida=:id';

            $param= array(':id'=>$this->id);
            $ordensalida = DATA::Ejecutar($sql_ordensalida,$param);
            $insumoxordensalida = DATA::Ejecutar($sql_insumoxordensalida,$param);

            $this->id = $ordensalida[0]['id'];
            $this->fecha = $ordensalida[0]['fecha'];
            $this->numeroorden = $ordensalida[0]['numeroorden'];
            $this->idusuarioentrega = $ordensalida[0]['idusuarioentrega'];
            $this->usuarioentrega = $ordensalida[0]['usuarioentrega'];
            $this->idusuariorecibe = $ordensalida[0]['idusuariorecibe'];
            $this->usuariorecibe = $ordensalida[0]['usuariorecibe'];
            $this->fechaliquida = $ordensalida[0]['fechaliquida'];
            $this->idestado = $ordensalida[0]['idestado'];
            
            foreach ($insumoxordensalida as $key => $value){
                require_once("InsumosxOrdenSalida.php");
                $ins_ordensalida = new InsumosxOrdenSalida();
                
                $ins_ordensalida->id = $value['id'];
                $ins_ordensalida->idordensalida = $value['idordensalida'];
                $ins_ordensalida->idinsumo = $value['idinsumo'];
                $ins_ordensalida->nombreinsumo = $value['nombreinsumo'];
                $ins_ordensalida->cantidad = $value['cantidad'];
                $ins_ordensalida->costopromedio = $value['costopromedio'];
                array_push ($this->listainsumo, $ins_ordensalida);
            }
            return $this;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el ordensalida'))
            );
        }
    }

    function Create(){
        try {
            $ultimaorden="SELECT numeroorden+1 FROM ordensalida ORDER BY numeroorden DESC LIMIT 1";
            $numeroorden=DATA::Ejecutar($ultimaorden);
            if ($numeroorden==null) 
                $numeroorden[0][0]=1;
            
            $sql="INSERT INTO ordensalida   (`id`,`fecha`,`numeroorden`,`idusuarioentrega`,`idusuariorecibe`,`fechaliquida`,`idestado`) 
                VALUES (:uuid,:fecha,:numeroorden,:idusuarioentrega,
                :idusuariorecibe,:fechaliquida,:idestado)";
            $param= array(':uuid'=>$this->id, ':fecha'=>$this->fecha, ':numeroorden'=>$numeroorden[0][0],':idusuarioentrega'=>$this->usuarioentrega, 
            ':idusuariorecibe'=>$this->usuariorecibe, ':fechaliquida'=>$this->fechaliquida, ':idestado'=>$this->idestado);
            $data = DATA::Ejecutar($sql,$param, false);

            if($data)
            {
                //save array obj
                if(InsumosxOrdenSalida::Create($this->listainsumo))
                    return true;
                else throw new Exception('Error al guardar los insumos.', 03);
            }
            else throw new Exception('Error al guardar.', 02);
            
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Update(){
        try {
            $sql="UPDATE ordensalida 
                SET idproducto=:idproducto, idusuario=:idusuario, , idusuariorecibe=:idusuariorecibe, cantidad=:cantidad, idestado=:idestado
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':idproducto'=>$this->idproducto, ':idusuario'=>$this->idusuario, ':idusuariorecibe'=>$this->idusuariorecibe,
            ':cantidad'=>$this->cantidad, ':idestado'=>$this->idestado);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                //update array obj
                if($this->listainsumo!=null)
                    if(InsumosxOrdenSalida::Update($this->listainsumo))
                        return true;            
                    else throw new Exception('Error al guardar los roles.', 03);
                else {
                    // no tiene roles
                    if(InsumosxOrdenSalida::Delete($this->id))
                        return true;
                    else throw new Exception('Error al guardar los roles.', 04);
                }
            }
            else throw new Exception('Error al guardar.', 123);
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }   

    private function CheckRelatedItems(){
        try{
            $sql="SELECT idproducto
                FROM insumosxordensalida R
                WHERE R.idproducto= :id";                
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
            if($this->CheckRelatedItems()){
                //$sessiondata array que devuelve si hay relaciones del objeto con otras tablas.
                $sessiondata['status']=1; 
                $sessiondata['msg']='Registro en uso'; 
                return $sessiondata;           
            }                    
            $sql='DELETE FROM ordensalida  
            WHERE id= :id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data)
                return $sessiondata['status']=0; 
            else throw new Exception('Error al eliminar.', 978);
        }
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

}

function ReadNextAI(){
    try{ 
        $sql="SELECT numeroorden+1
        FROM ordensalida
        ORDER BY numeroorden DESC LIMIT 1";
        $data= DATA::Ejecutar($sql,$param); 
        if(count($data))
        return $data;
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

?>
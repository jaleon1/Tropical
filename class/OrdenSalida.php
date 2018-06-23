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
        // case "ReadAll":
        //     echo json_encode($ordensalida->ReadAll());
        //     break;
        // case "Read":
        //     echo json_encode($ordensalida->Read());
        //     break;
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
    public $usuarioentrega='';
    public $usuariorecibe='';
    public $estado='';
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
            $this->estado= $obj["estado"] ?? 0;
            //Insumos de la orden
            if (isset($obj["listainsumo"] )) {
                require_once("InsumosxOrdenSalida.php");    
                //            
                foreach ($obj["listainsumo"] as $objInsumo) {
                    $insprod= new InsumosxOrdenSalida();
                    $insprod->idordensalida= $this->id;
                    $insprod->idinsumo= $objInsumo['id'];
                    $insprod->cantidad= $objInsumo['cantidad'];
                    $insprod->costopromedio= $objInsumo['costopromedio'];
                    array_push ($this->listainsumo, $insprod);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, idproducto, (select nombre from producto where id=idproducto) as producto, idusuario, 
            (select nombre from usuario where id=idusuario) as usuario, 
            idusuariorecibe, (select nombre from usuario where id=idusuariorecibe) as usuariorecibe,cantidad, estado
                FROM     ordensalida       
                ORDER BY idproducto asc';
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
            $insumosxproducto=null;

            $sql_ordensalida='SELECT id, idusuario, (SELECT nombre FROM usuario WHERE id=idusuario) AS usuario, idproducto, 
            idusuariorecibe, (SELECT nombre FROM usuario WHERE id=idusuariorecibe) AS usuariorecibe,
            (SELECT nombre FROM producto WHERE id=idproducto) AS producto, cantidad, estado FROM ordensalida 
            WHERE id=:id';
            
            $sql_insumosxproducto='SELECT id,idordensalida,idinsumo,(SELECT nombre FROM insumo WHERE id=idinsumo) AS nombre,cantidad,costo FROM insumosxproducto WHERE idordensalida=:id';

            $param= array(':id'=>$this->id);
            $ordensalida = DATA::Ejecutar($sql_ordensalida,$param);
            $insumosxproducto = DATA::Ejecutar($sql_insumosxproducto,$param);

            $this->id = $ordensalida[0]['id'];
            $this->idproducto = $ordensalida[0]['idproducto'];
            $this->idusuario = $ordensalida[0]['idusuario'];
            $this->idusuariorecibe = $ordensalida[0]['idusuariorecibe'];
            $this->usuario = $ordensalida[0]['usuario'];
            $this->usuariorecibe = $ordensalida[0]['usuariorecibe'];
            $this->producto = $ordensalida[0]['producto'];
            $this->cantidad = $ordensalida[0]['cantidad'];
            $this->estado = $ordensalida[0]['estado'];
            
            foreach ($insumosxproducto as $key => $value){
                require_once("InsumosxOrdenSalida.php");
                $insprod = new InsumosxOrdenSalida();
                
                $insprod->id = $value['id'];
                $insprod->idinsumo = $value['idinsumo'];
                $insprod->nombre = $value['nombre'];
                $insprod->idordensalida = $value['idordensalida'];
                $insprod->cantidad = $value['cantidad'];
                $insprod->costo = $value['costo'];
                array_push ($this->listainsumo, $insprod);
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
            ':idusuariorecibe'=>$this->usuariorecibe, ':fechaliquida'=>$this->fechaliquida, ':idestado'=>$this->estado);
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
                SET idproducto=:idproducto, idusuario=:idusuario, , idusuariorecibe=:idusuariorecibe, cantidad=:cantidad, estado=:estado
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':idproducto'=>$this->idproducto, ':idusuario'=>$this->idusuario, ':idusuariorecibe'=>$this->idusuariorecibe,
            ':cantidad'=>$this->cantidad, ':estado'=>$this->estado);
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
                FROM insumosxproducto R
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
<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once('Evento.php');
    require_once('Usuario.php');
    require_once('InsumosxOrdenSalida.php');
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
        case "ReadbyOrden":
            echo json_encode($ordensalida->ReadbyOrden());
            break;
        case "Update":
            $ordensalida->Update();
            break;
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
    public $listainsumocantidad=[];

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->numeroorden= $obj["numeroorden"] ?? '';
            $this->fecha= $obj["fecha"] ?? '';
            $this->fechaliquida= $obj["fechaliquida"] ?? '';
            $this->idusuarioentrega= $_SESSION['userSession']->id;
            $this->idusuariorecibe= $obj["usuariorecibe"] ?? '';
            $this->idestado= $obj["estado"] ?? 0;
            //Insumos de la orden
            if (isset($obj["listainsumo"] )) {
                require_once("InsumosxOrdenSalida.php");    
                foreach ($obj["listainsumo"] as $objInsumo) {
                    $ins_ordensalida= new InsumosxOrdenSalida();
                    $ins_ordensalida->idordensalida= $this->id;
                    $ins_ordensalida->idInsumo= $objInsumo['id'];
                    $ins_ordensalida->cantidad= $objInsumo['cantidad'];
                    $ins_ordensalida->costoPromedio= $objInsumo['costoPromedio'];
                    array_push ($this->listainsumo, $ins_ordensalida);
                }
            }
            //Insumos de la orden
            if (isset($obj["listainsumo"] )) {
                require_once("InsumosxOrdenSalida.php");    
                foreach ($obj["listainsumocantidad"] as $objInsumoCantidad) {
                    $ins_ordensalida= new InsumosxOrdenSalida();
                    $ins_ordensalida->idordensalida= $this->id;
                    $ins_ordensalida->idInsumo= $objInsumoCantidad['id'];
                    $ins_ordensalida->cantidad= $objInsumoCantidad['cantidad'];
                    array_push ($this->listainsumocantidad, $ins_ordensalida);
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
            $sql_insumoxordensalida='SELECT id,idordensalida,idInsumo,(SELECT nombre FROM insumo WHERE id=idInsumo) AS nombreinsumo,cantidad,costoPromedio FROM insumosxordensalida WHERE idordensalida=:id';

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
                $ins_ordensalida->idInsumo = $value['idInsumo'];
                $ins_ordensalida->nombreinsumo = $value['nombreinsumo'];
                $ins_ordensalida->cantidad = $value['cantidad'];
                $ins_ordensalida->costoPromedio = $value['costoPromedio'];
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
            $sql="INSERT INTO ordenSalida (`id`,`fecha`,`idusuarioentrega`,`idusuariorecibe`,`idestado`) 
                VALUES (:uuid,:fecha,:idusuarioentrega,:idusuariorecibe,:idestado)";
            $param= array(':uuid'=>$this->id, ':fecha'=>$this->fecha,':idusuarioentrega'=>$this->idusuarioentrega, 
            ':idusuariorecibe'=>$this->idusuariorecibe,':idestado'=>0);
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
            $sql="UPDATE ordenSalida SET idusuariorecibe=:idusuariorecibe WHERE id=:id";
             $param= array(':id'=>$this->id,':idusuariorecibe'=>$this->idusuariorecibe);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                //update array obj
                if($this->listainsumo!=null)
                    if(InsumosxOrdenSalida::Update($this->listainsumo))
                        return true;            
                    else throw new Exception('Error al guardar la orden de salida.', 03);
                else {
                    // no tiene roles
                    if(InsumosxOrdenSalida::Delete($this->id))
                        return true;
                    else throw new Exception('Error al borrar la orden de salida.', 04);
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
            $sql="SELECT idProducto
                FROM insumosxordensalida R
                WHERE R.idProducto= :id";                
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
    
    function ReadbyOrden(){
        try {
            $sql='SELECT `ordensalida`.`id`,
            `ordensalida`.`numeroorden`,
            `ordensalida`.`fecha`,
            `ordensalida`.`idusuarioentrega`,
            `ordensalida`.`idusuariorecibe`,
            (SELECT nombre FROM usuario WHERE id=`ordensalida`.`idusuarioentrega`) AS usuarioentrega,
            (SELECT nombre FROM usuario WHERE id=`ordensalida`.`idusuariorecibe`) AS usuariorecibe,
            `ordensalida`.`fechaliquida`,
            `ordensalida`.`idestado`
            FROM `tropical`.`ordensalida` WHERE numeroorden=:numeroorden AND idestado=0';
            $param= array(':numeroorden'=>$this->numeroorden);
            $data= DATA::Ejecutar($sql,$param);     
            if(count($data)){
                $this->id = $data[0]['id'];
                $this->numeroorden = $data[0]['numeroorden'];
                $this->fecha = $data[0]['fecha'];
                $this->idusuarioentrega = $data[0]['idusuarioentrega'];
                $this->idusuariorecibe = $data[0]['idusuariorecibe'];
                $this->usuarioentrega = $data[0]['usuarioentrega'];
                $this->usuariorecibe = $data[0]['usuariorecibe'];
                $this->fechaliquida = $data[0]['fechaliquida'];
                $this->idestado = $data[0]['idestado'];
                // productos x distribucion.
                $this->listainsumo= InsumosxOrdenSalida::Read($this->id);
                //
                return $this;
            }
            else return null;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el distribucion'))
            );
        }
    }
}

?>
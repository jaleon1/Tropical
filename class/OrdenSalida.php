<?php
date_default_timezone_set('America/Costa_Rica');
error_reporting(0);
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
    $ordenSalida= new OrdenSalida();
    switch($opt){
        case "ReadAll":
            echo json_encode($ordenSalida->ReadAll());
            break;
        case "Read":
            echo json_encode($ordenSalida->Read());
            break;
        case "Create":
            echo json_encode($ordenSalida->Create());
            break;
        case "ReadbyOrden":
            echo json_encode($ordenSalida->ReadbyOrden());
            break;
        case "Update":
            echo json_encode($ordenSalida->Update());
            break;
        case "Delete":
            echo json_encode($ordenSalida->Delete());
            break;   
    }
}

class OrdenSalida{
    public $id=null;
    public $numeroOrden='';
    public $fecha='';
    public $fechaLiquida='';
    public $idUsuarioEntrega='';
    public $idUsuarioRecibe='';
    public $usuarioEntrega='';
    public $usuarioRecibe='';
    public $idEstado='';
    public $listaInsumo=[];
    public $listaInsumoCantidad=[];

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->numeroOrden= $obj["numeroOrden"] ?? '';
            $this->fecha= $obj["fecha"] ?? '';
            $this->fechaLiquida= $obj["fechaLiquida"] ?? '';
            $this->idUsuarioEntrega= $_SESSION['userSession']->id;
            $this->idUsuarioRecibe= $obj["usuarioRecibe"] ?? '';
            $this->idEstado= $obj["estado"] ?? 0;
            //Insumos de la orden
            if (isset($obj["listaInsumo"] )) {
                require_once("InsumosxOrdenSalida.php");    
                foreach ($obj["listaInsumo"] as $objInsumo) {
                    $ins_ordensalida= new InsumosxOrdenSalida();
                    $ins_ordensalida->idOrdenSalida= $this->id;
                    $ins_ordensalida->idInsumo= $objInsumo['id'];
                    $ins_ordensalida->cantidad= $objInsumo['cantidad'];
                    $ins_ordensalida->costoPromedio= $objInsumo['costoPromedio'];
                    array_push ($this->listaInsumo, $ins_ordensalida);
                }
            }
            //Insumos de la orden
            if (isset($obj["listaInsumo"] )) {
                require_once("InsumosxOrdenSalida.php");    
                foreach ($obj["listaInsumoCantidad"] as $objInsumoCantidad) {
                    $ins_ordensalida= new InsumosxOrdenSalida();
                    $ins_ordensalida->idOrdenSalida= $this->id;
                    $ins_ordensalida->idInsumo= $objInsumoCantidad['id'];
                    $ins_ordensalida->cantidad= $objInsumoCantidad['cantidad'];
                    array_push ($this->listaInsumoCantidad, $ins_ordensalida);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT `id`,`fecha`,`numeroOrden`,`idUsuarioEntrega`, (SELECT nombre FROM usuario WHERE id=idUsuarioEntrega) as usuarioEntrega,
            `idUsuarioRecibe`, (SELECT nombre FROM usuario WHERE id=idUsuarioRecibe) as usuarioRecibe, `fechaLiquida`, `idEstado`
                FROM     ordenSalida       
                ORDER BY numeroOrden asc';
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

    function Read(){
        try {
            $ordenSalida=null;
            $insumoxordensalida=null;

            $sql_ordensalida=$sql='SELECT `id`,`fecha`,`numeroOrden`,`idUsuarioEntrega`, 
            (SELECT nombre FROM usuario WHERE id=idUsuarioEntrega) as usuarioEntrega,
            `idUsuarioRecibe`, 
            (SELECT nombre FROM usuario WHERE id=idUsuarioRecibe) as usuarioRecibe, 
            `fechaLiquida`, 
            `idEstado`
            FROM ordenSalida WHERE id=:id ORDER BY numeroOrden asc';
            $sql_insumoxordensalida='SELECT id,idOrdenSalida,idInsumo,
            (SELECT nombre FROM insumo WHERE id=idInsumo) AS nombreInsumo,
            (SELECT codigo FROM insumo WHERE id=idInsumo) AS codigo,
            cantidad,
            costoPromedio 
            FROM insumosXOrdenSalida WHERE idOrdenSalida=:id';

            $param= array(':id'=>$this->id);
            $ordenSalida = DATA::Ejecutar($sql_ordensalida,$param);
            $insumoxordensalida = DATA::Ejecutar($sql_insumoxordensalida,$param);
            $this->id = $ordenSalida[0]['id'];
            $this->fecha = $ordenSalida[0]['fecha'];
            $this->numeroOrden = $ordenSalida[0]['numeroOrden'];
            $this->idUsuarioEntrega = $ordenSalida[0]['idUsuarioEntrega'];
            $this->usuarioEntrega = $ordenSalida[0]['usuarioEntrega'];
            $this->idUsuarioRecibe = $ordenSalida[0]['idUsuarioRecibe'];
            $this->usuarioRecibe = $ordenSalida[0]['usuarioRecibe'];
            $this->fechaLiquida = $ordenSalida[0]['fechaLiquida'];
            $this->idEstado = $ordenSalida[0]['idEstado'];
            
            foreach ($insumoxordensalida as $key => $value){
                require_once("InsumosxOrdenSalida.php");
                $ins_ordensalida = new InsumosxOrdenSalida();
                $ins_ordensalida->id = $value['id'];
                $ins_ordensalida->codigo = $value['codigo'];
                $ins_ordensalida->idOrdenSalida = $value['idOrdenSalida'];
                $ins_ordensalida->idInsumo = $value['idInsumo'];
                $ins_ordensalida->nombreInsumo = $value['nombreInsumo'];
                $ins_ordensalida->cantidad = $value['cantidad'];
                $ins_ordensalida->costoPromedio = $value['costoPromedio'];
                array_push ($this->listaInsumo, $ins_ordensalida);
            }
            return $this;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el ordenSalida'))
            );
        }
    }

    function Create(){
        try {           
            $sql="INSERT INTO tropical.ordenSalida (`id`,`fecha`,`idUsuarioEntrega`,`idUsuarioRecibe`,`idEstado`) 
                VALUES (:uuid,:fecha,:idUsuarioEntrega,:idUsuarioRecibe,:idEstado)";
            $param= array(':uuid'=>$this->id, ':fecha'=>$this->fecha,':idUsuarioEntrega'=>$this->idUsuarioEntrega, 
            ':idUsuarioRecibe'=>$this->idUsuarioRecibe,':idEstado'=>0);
            $data = DATA::Ejecutar($sql,$param, false);

            if($data)
            {
                //Obtiene el ultimo numero de Orden
                $sql="SELECT numeroOrden FROM tropical.ordenSalida order by numeroOrden desc limit 1;";
                $maxid=DATA::Ejecutar($sql);
                
                //save array obj
                if(InsumosxOrdenSalida::Create($this->listaInsumo))
                    if($this->CreateInventarioInsumo($this->listaInsumo))
                        return $maxid[0][0];
                else throw new Exception('Error al guardar los insumos.', 03);
            }
            else throw new Exception('Error al guardar.', 02);
            
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }
    //Orden Produccion (SALIDA)
    function CreateInventarioInsumo($obj){
        try {
            $created = true;
            require_once("Insumo.php");
            foreach ($obj as $item) {          
                
                $sql="SELECT saldoCantidad, saldoCosto, costoPromedio FROM insumo WHERE id=:idInsumo;";
                $param= array(':idInsumo'=>$item->idInsumo);
                $valor=DATA::Ejecutar($sql,$param);              
                
                $sql="SELECT fecha, numeroOrden FROM ordenSalida WHERE id=:idOrdenSalida;";
                $param= array(':idOrdenSalida'=>$item->idOrdenSalida);
                $data=DATA::Ejecutar($sql,$param);

                $costoAdquisicion = $item->cantidad*$item->costoPromedio;
                $sql="INSERT INTO inventarioInsumo   (id, idOrdenSalida, idInsumo, salida, saldo, valorSalida, valorSaldo, costoPromedio, fecha, ordenGuardada)
                    VALUES (uuid(), :idOrdenSalida, :idInsumo, :salida, :saldo, :valorSalida, :valorSaldo, :costoPromedio, :fecha, :ordenGuardada)";
                $param= array(':idOrdenSalida'=>$item->idOrdenSalida, 
                    ':idInsumo'=>$item->idInsumo,
                    ':salida'=>$item->cantidad,
                    ':saldo'=>$valor[0]['saldoCantidad'], 
                    ':valorSalida'=>(string)$costoAdquisicion,
                    ':valorSaldo'=>$valor[0]['saldoCosto'],
                    ':costoPromedio'=>$valor[0]['costoPromedio'],
                    ':fecha'=>$data[0]['fecha'],
                    ':ordenGuardada'=>$data[0]['numeroOrden']
                );
                DATA::Ejecutar($sql,$param,false);                
            }
            return $created;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    function Update(){
        try {
            $sql="UPDATE ordenSalida SET idUsuarioRecibe=:idUsuarioRecibe WHERE id=:id";
            $param= array(':id'=>$this->id,':idUsuarioRecibe'=>$this->idUsuarioRecibe);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data){
                $sql="SELECT numeroOrden FROM ordenSalida WHERE id=:id;";
                $param= array(':id'=>$this->id);
                $numeroOrden=DATA::Ejecutar($sql,$param);

                //update array obj
                if($this->listaInsumo!=null)
                    if(InsumosxOrdenSalida::Update($this->listaInsumo))
                        return $numeroOrden[0][0];            
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
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }   

    private function CheckRelatedItems(){
        try{
            $sql="SELECT id
                FROM tropical.ordenSalida
                WHERE id=:id and idEstado=1";          
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
            //Volver a sumar al Inventario de Insumos
            //Selecciona lista de insumos ligados a la orden
            $sql="SELECT idInsumo,idOrdenSalida,cantidad,costoPromedio,(SELECT numeroOrden FROM ordenSalida WHERE id=idOrdenSalida)
            AS consecutivo FROM insumosXOrdenSalida WHERE idOrdenSalida=:idOrdenSalida;";
            $param= array(':idOrdenSalida'=>$this->id);
            $insumos= DATA::Ejecutar($sql, $param);
            InsumosxOrdenSalida::UpdateSaldoCantidadInsumo2($insumos);

            $this->DeleteInventarioInsumo($insumos);

            $sql='DELETE FROM ordenSalida
            WHERE id= :id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql, $param, false);
            if($data)
                return $sessiondata['status']=0; 
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

    //Orden Produccion (ENTRADA)
    public function DeleteInventarioInsumo($obj){
        try {
            $created = true;
            require_once("Insumo.php");
            foreach ($obj as $item) {          
                
                $sql="SELECT saldoCantidad, saldoCosto, costoPromedio FROM insumo WHERE id=:idInsumo;";
                $param= array(':idInsumo'=>$item['idInsumo']);
                $valor=DATA::Ejecutar($sql,$param); 

                $sql="INSERT INTO ordenCancel (id,idOrdenSalida)VALUES(UUID(),:idOrdenSalida)";
                $param= array(':idOrdenSalida'=>$item['idOrdenSalida']);
                DATA::Ejecutar($sql,$param,false);

                $costoAdquisicion = $item['cantidad']*$item['costoPromedio'];
                $sql="INSERT INTO inventarioInsumo (id, idOrdenSalida, idInsumo, entrada, saldo, valorEntrada, valorSaldo, costoPromedio, fecha, ordenEliminada)
                VALUES (uuid(), :idOrdenSalida, :idInsumo, :entrada, :saldo, :valorEntrada, :valorSaldo, :costoPromedio, :fecha, :ordenEliminada)";
                $param= array(':idOrdenSalida'=>$item['idOrdenSalida'],
                    ':idInsumo'=>$item['idInsumo'],
                    ':entrada'=>$item['cantidad'],
                    ':saldo'=>$valor[0]['saldoCantidad'], 
                    ':valorEntrada'=>(string)$costoAdquisicion,
                    ':valorSaldo'=>$valor[0]['saldoCosto'],
                    ':costoPromedio'=>$valor[0]['costoPromedio'],
                    ':fecha'=>date("Y-m-d H:i:s"),
                    ':ordenEliminada'=>'eliminada'
                );
                DATA::Ejecutar($sql,$param,false);                
            }
            return $created;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }
    
    function ReadbyOrden(){
        try {
            $sql='SELECT `ordenSalida`.`id`,
            `ordenSalida`.`numeroOrden`,
            `ordenSalida`.`fecha`,
            `ordenSalida`.`idUsuarioEntrega`,
            `ordenSalida`.`idUsuarioRecibe`,
            (SELECT nombre FROM usuario WHERE id=`ordenSalida`.`idUsuarioEntrega`) AS usuarioEntrega,
            (SELECT nombre FROM usuario WHERE id=`ordenSalida`.`idUsuarioRecibe`) AS usuarioRecibe,
            `ordenSalida`.`fechaLiquida`,
            `ordenSalida`.`idEstado`
            FROM `tropical`.`ordenSalida` WHERE numeroOrden=:numeroOrden AND idEstado=0';
            $param= array(':numeroOrden'=>$this->numeroOrden);
            $data= DATA::Ejecutar($sql,$param);     
            if(count($data)){
                $this->id = $data[0]['id'];
                $this->numeroOrden = $data[0]['numeroOrden'];
                $this->fecha = $data[0]['fecha'];
                $this->idUsuarioEntrega = $data[0]['idUsuarioEntrega'];
                $this->idUsuarioRecibe = $data[0]['idUsuarioRecibe'];
                $this->usuarioEntrega = $data[0]['usuarioEntrega'];
                $this->usuarioRecibe = $data[0]['usuarioRecibe'];
                $this->fechaLiquida = $data[0]['fechaLiquida'];
                $this->idEstado = $data[0]['idEstado'];
                // productos x distribucion.
                $this->listaInsumo= InsumosxOrdenSalida::Read($this->id);
                //
                return $this;
            }
            else return null;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el distribucion'))
            );
        }
    }
}

?>
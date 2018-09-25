<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $insumo= new Insumo();
    switch($opt){
        case "ReadAll":
            echo json_encode($insumo->ReadAll());
            break;
        case "ReadAllInventario":
            echo json_encode($insumo->ReadAllInventario());
            break;
        case "Read":
            echo json_encode($insumo->Read());
            break;
        case "ReadSaldoPositivo":
            echo json_encode($insumo->ReadSaldoPositivo());
            break;
        case "Create":
            $insumo->Create();
            break;
        case "saldoCorrecto":
            echo json_encode($insumo->saldoCorrecto($_POST["cantidad"],$_POST["id"]));
            break;
        case "saldoCorrectoMod":
            echo json_encode($insumo->saldoCorrectoMod($_POST["cantidad"],$_POST["id"],$_POST["scant"]));
            break;
        case "Update":
            $insumo->Update();
            break;
        case "Delete":
            echo json_encode($insumo->Delete());
            break;   
        case "ReadByCode":  
            echo json_encode($insumo->ReadByCode());
            break;
    }
}

class Insumo{
    public $id=null;
    public $codigo='';
    public $nombre='';
    public $descripcion='';
    public $saldoCantidad=0;
    public $saldoCosto=0;
    public $costoPromedio=0;

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->id= $obj["id"] ?? null;
            $this->codigo= $obj["codigo"] ?? '';
            $this->nombre= $obj["nombre"] ?? '';
            $this->descripcion= $obj["descripcion"] ?? '';
            $this->saldoCantidad= $obj["saldoCantidad"] ?? 0;            
            $this->saldoCosto= $obj["saldoCosto"] ?? 0;
            $this->costoPromedio= $obj["costoPromedio"] ?? 0;
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT id, codigo, nombre, descripcion, saldoCantidad, saldoCosto, costoPromedio
                FROM  insumo       
                ORDER BY nombre asc';
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

    function ReadAllInventario(){
        try {
            $sql='SELECT `inventarioInsumo`.`id`,
            `inventarioInsumo`.`idOrdenCompra`,
            (SELECT orden FROM ordenCompra WHERE id=inventarioInsumo.idOrdenCompra) AS ordenCompra,
            `inventarioInsumo`.`idOrdenSalida`,
            (SELECT numeroOrden FROM ordenSalida WHERE id=inventarioInsumo.idOrdenSalida) AS ordenSalida,
            `inventarioInsumo`.`idInsumo`,
            (SELECT codigo FROM insumo WHERE id=inventarioInsumo.idInsumo) AS insumo,
            `inventarioInsumo`.`entrada`,
            `inventarioInsumo`.`salida`,
            `inventarioInsumo`.`saldo`,
            `inventarioInsumo`.`costoAdquisicion`,
            `inventarioInsumo`.`valorEntrada`,
            `inventarioInsumo`.`valorSalida`,
            `inventarioInsumo`.`valorSaldo`,
            `inventarioInsumo`.`costoPromedio`,
            `inventarioInsumo`.`fecha`
                FROM  inventarioInsumo       
                ORDER BY fecha desc';
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

    function ReadSaldoPositivo(){
        try {
            $sql='SELECT id, codigo, nombre, descripcion, saldoCantidad, saldoCosto, costoPromedio
                FROM insumo WHERE saldoCantidad>0;       
                ORDER BY nombre asc';
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

    function saldoCorrecto($cantidad,$id){
        try {
            $sql='SELECT saldoCantidad FROM insumo WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);
            if ($data[0][0]>=$cantidad) 
                return true;
            else
                return floatval($data[0][0]);
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }

    function saldoCorrectoMod($cantidad,$id,$scant){
        try {
            $sql='SELECT saldoCantidad FROM insumo WHERE id=:id';
            $param= array(':id'=>$id);
            $data= DATA::Ejecutar($sql,$param);
            if ($data[0][0] + $scant >=$cantidad) 
                return true;
            else
                return floatval($data[0][0]);
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
            $sql='SELECT id, codigo, nombre, descripcion, saldoCantidad, saldoCosto, costoPromedio
                FROM insumo  
                where id=:id';
            $param= array(':id'=>$this->id);
            $data= DATA::Ejecutar($sql,$param);
            return $data;
        }     
        catch(Exception $e) {
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el insumo'))
            );
        }
    }

    function Create(){
        try {
            $sql="INSERT INTO insumo (id, codigo, nombre, descripcion, saldoCantidad, saldoCosto, costoPromedio) VALUES (uuid(), :codigo, :nombre, :descripcion, :saldoCantidad, :saldoCosto, :costoPromedio);";
            //
            $param= array(':codigo'=>$this->codigo,':nombre'=>$this->nombre, ':descripcion'=>$this->descripcion, ':saldoCantidad'=>$this->saldoCantidad, ':saldoCosto'=>$this->saldoCosto, ':costoPromedio'=>$this->costoPromedio);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
            {
                //get id.
                //save array obj
                return true;
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
            $sql="UPDATE insumo 
                SET  codigo=:codigo, nombre=:nombre, descripcion=:descripcion, saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto, costoPromedio=:costoPromedio
                WHERE id=:id";
            $param= array(':id'=>$this->id, ':codigo'=>$this->codigo,':nombre'=>$this->nombre, ':descripcion'=>$this->descripcion, ':saldoCantidad'=>$this->saldoCantidad, ':saldoCosto'=>$this->saldoCosto, ':costoPromedio'=>$this->costoPromedio);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
                return true;
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
            $sql="SELECT id
                FROM insumosXOrdenSalida
                WHERE idInsumo= :id";                
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
            $sql='DELETE FROM insumo  
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

    function ReadByCode(){
        try{
            $sql="SELECT id, nombre, codigo, descripcion, saldoCantidad
                FROM insumo
                WHERE codigo like :codigo ";
            $param= array(':codigo'=>'%'.$this->codigo.'%');
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

    public static function UpdateSaldoPromedioEntrada($id, $ncantidad, $ncosto){
        try {

            $sql="CALL spUpdateSaldosPromedioInsumoEntrada(:mid, :ncantidad, :ncosto);";
            $param= array(':mid'=>$id, ':ncantidad'=>$ncantidad, ':ncosto'=>$ncosto);
            $data = DATA::Ejecutar($sql,$param,false);
            if($data)
                return true;
            else throw new Exception('Error al calcular SALDOS Y PROMEDIOS de insumos, debe realizar el cálculo manualmente.', 666);
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
?>
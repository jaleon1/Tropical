<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Insumo.php");
    require_once("Producto.php");
    require_once("Usuario.php");
    require_once("Evento.php");
    require_once("Rol.php");
    require_once("InventarioInsumoXBodega.php");
    //require_once("InventarioProducto.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $merma= new MermaAgencia();
    switch($opt){
        case "ReadAll":
            echo json_encode($merma->ReadAll());
            break;
        case "ReadCompleto":
            echo json_encode($merma->ReadCompleto());
            break;
        case "Create":
            echo json_encode($merma->Create());
            break;
        case "CreateInterno":
            echo json_encode($merma->CreateInterno());
            break;
        case "rollback":
            $merma->idInsumo = $_POST["idInsumo"];
            $merma->consecutivo = $_POST["consecutivo"];
            $merma->cantidad = $_POST["cantidad"];
            // $merma->costo = $_POST["costo"]??0;
            $merma->rollback();
            break;
        case "ReadAllbyRange":
            echo json_encode($merma->ReadAllbyRange());
            break;
        case "ReadAllbyRangeInterna":
            echo json_encode($merma->ReadAllbyRangeInterna());
            break;
    }
}

class MermaAgencia{
    public $id=null;
    public $idBodega= null;
    public $idProducto= null;
    public $idInsumo= null;
    public $descripcion='';
    public $cantidad=0;
    public $fecha;
    public $listaProducto= [];
    public $fechaInicial='';
    public $fechaFinal='';

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["idBodega"])){
            $this->idBodega= $_POST["idBodega"];
        }
        else $this->idBodega= $_SESSION['userSession']->idBodega;
        //
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            require_once("UUID.php");
            $this->id= $obj["id"] ?? UUID::v4();
            $this->idBodega= $obj['idBodega']?? $_SESSION['userSession']->idBodega;
            $this->fechaInicial= $obj["fechaInicial"] ?? '';
            $this->fechaFinal= $obj["fechaFinal"] ?? '';
            // merma
            if(isset($obj["listaProducto"])){
                $this->listaProducto= [];
                foreach ($obj["listaProducto"] as $itemlist) {
                    $item= new Insumo();
                    $item->id = $itemlist['idProducto'];
                    $item->cantidad = $itemlist['cantidad'];
                    $item->descripcion= $itemlist['descripcion'];
                    array_push ($this->listaProducto, $item);
                }
            }
        }
    }

    // metodos.

    function ReadAll(){
        try {
            $sql='SELECT m.id, m.idInsumo, b.nombre as agencia, p.codigo, m.consecutivo, p.nombre, m.cantidad, m.descripcion, m.fecha
                FROM mermaAgencia m 
                inner join insumosXBodega x on x.id = m.idInsumo
                inner join producto p on p.id = x.idProducto
                inner join bodega b on b.id = m.idBodega
                WHERE m.idBodega =:idBodega';
            $param= array(':idBodega'=> $this->idBodega);
            $data = DATA::Ejecutar($sql,$param);
            return $data;
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

    function ReadAllbyRange(){
        try {
            $sql='SELECT m.id, m.idInsumo, b.nombre as agencia, p.codigo, m.consecutivo, p.nombre, m.cantidad, m.descripcion, m.fecha
                FROM mermaAgencia m 
                inner join insumosXBodega x on x.id = m.idInsumo
                inner join producto p on p.id = x.idProducto
                inner join bodega b on b.id = m.idBodega
                WHERE m.idBodega =:idBodega AND m.fecha Between :fechaInicial and :fechaFinal';
            $param= array(':idBodega'=> $this->idBodega,':fechaInicial'=>$this->fechaInicial, ':fechaFinal'=>$this->fechaFinal);
            $data = DATA::Ejecutar($sql,$param);
            return $data;
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

    function ReadAllbyRangeInterna(){
        try {
            $sql='SELECT m.id, m.idInsumo, b.nombre as agencia, p.codigo, m.consecutivo, p.nombre, m.cantidad, m.descripcion, m.fecha
                FROM mermaAgencia m 
                inner join insumosXBodega x on x.id = m.idInsumo
                inner join producto p on p.id = x.idProducto
                inner join bodega b on b.id = m.idBodega';
            $data = DATA::Ejecutar($sql);
            return $data;
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

    function ReadCompleto(){
        try {
            $sql='SELECT m.id, m.idInsumo, b.nombre as agencia, p.codigo, m.consecutivo, p.nombre, m.cantidad, m.descripcion, m.fecha
                FROM mermaAgencia m 
                inner join insumosXBodega x on x.id = m.idInsumo
                inner join producto p on p.id = x.idProducto
                inner join bodega b on b.id = m.idBodega';
            $data = DATA::Ejecutar($sql);
            return $data;
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

    function Create(){
        try {
            $created=true;
            // insumos
            foreach ($this->listaProducto as $item) {
                require_once("UUID.php");
                $id= UUID::v4();
                // historico merma
                $sql="INSERT INTO mermaAgencia (id, idInsumo, cantidad, descripcion, idBodega)
                    VALUES (:id, :idInsumo, :cantidad, :descripcion, :idBodega)";
                $param= array(':id'=> $id,':idInsumo'=> $item->id, ':cantidad'=> $item->cantidad, ':descripcion'=> $item->descripcion, ':idBodega'=> $this->idBodega);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
                // consecutivo.
                $sql="SELECT consecutivo 
                    FROM mermaAgencia
                    WHERE id=:id";
                $param= array(':id'=> $id);
                $data = DATA::Ejecutar($sql);
                // actualiza item.
                InventarioInsumoXBodega::salida( $item->id, $this->idBodega, 'merma#'.$data[0]['consecutivo'], $item->cantidad);
                // ***************** imprimir. ***************************
                // ***************** imprimir. ***************************
                // ***************** imprimir. ***************************
            }
            //
            if($created)
                return true;
            else throw new Exception('Error al restar MERMA, debe realizar el procedimiento manualmente.', 666);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function CreateInterno(){
        try {
            $created=true;
            // insumos
            foreach ($this->listaProducto as $item) {
                require_once("UUID.php");
                $id= UUID::v4();
                // historico merma
                $sql="INSERT INTO mermaAgencia (id, idInsumo, cantidad, descripcion, idBodega)
                    VALUES (:id, :idInsumo, :cantidad, :descripcion, :idBodega)";
                $param= array(':id'=> $id,':idInsumo'=> $item->id, ':cantidad'=> $item->cantidad, ':descripcion'=> $item->descripcion, ':idBodega'=> $this->idBodega);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
                // consecutivo.
                $sql="SELECT consecutivo 
                    FROM mermaAgencia
                    WHERE id=:id";
                $param= array(':id'=> $id);
                $data = DATA::Ejecutar($sql);
                // actualiza item.
                InventarioInsumoXBodega::salida( $item->id, $this->idBodega, 'merma#'.$data[0]['consecutivo'], $item->cantidad);
                // ***************** imprimir. ***************************
                // ***************** imprimir. ***************************
                // ***************** imprimir. ***************************
            }
            //
            if($created)
                return true;
            else throw new Exception('Error al restar MERMA, debe realizar el procedimiento manualmente.', 666);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Rollback(){
        try {
            $sql="SELECT saldoCantidad, saldoCosto, costoPromedio
                    FROM insumosXBodega 
                    where id = :idInsumo;";
            $param= array(':idInsumo'=> $this->idInsumo);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                // Entrada a inventario agencia.
                InventarioInsumoXBodega::entrada($this->idInsumo, 'CancelaMerma:'.$this->consecutivo, $this->cantidad, $data[0]['costoPromedio']);
                // delete from mermaAgencia.
                $sql="DELETE 
                    FROM mermaAgencia
                    where id=:id";
                $param= array(':id'=>$this->id);
                DATA::Ejecutar($sql,$param);
                return true;
            }
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }
}

?>
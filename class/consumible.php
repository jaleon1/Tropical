<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Producto.php");
    require_once("InventarioInsumoXBodega.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $consumible= new Consumible();
    switch($opt){
        case "ReadAll":
            echo json_encode($consumible->ReadAll());
            break;
        case "Create":
            echo json_encode($consumible->Create());
            break;
        case "Delete":
            echo json_encode($consumible->Delete($consumible->id));
            break;  
        case "ReadByCode":
            echo json_encode($consumible->ReadByCode());
            break;
    }
}

class Consumible{
    public $id=null;
    public $idProducto=null;
    public $cantidad=0;
    public $codigo=0;
    public $tamano=0;

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->codigo= $obj["codigo"] ?? '';
            // consumible
            if(isset($obj["lista"] )){
                $this->lista= [];
                foreach ($obj["lista"] as $itemlist) {
                    $item= new Producto();
                    $item->id = $itemlist['id'];
                    $item->idProducto = $itemlist['idProducto'];
                    $item->cantidad = $itemlist['cantidad'];
                    $item->tamano = $itemlist['tamano'];
                    array_push ($this->lista, $item);
                }
            }
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT c.id, c.idProducto, p.codigo, p.nombre, c.cantidad, c.tamano
                FROM consumible c inner join producto p on p.id = c.idProducto';
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

    // busca los productos y les asigna un uuid nuevo para agregarlo como consumible
    function ReadByCode(){
        try{
            $sql="SELECT uuid() as id, id as idProducto, nombre, codigo
                FROM producto 
                WHERE codigo like :codigo";
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

    function Create(){
        try {
            $created=true;
            //borra los consumibles
            $this->Delete();
            // productos
            foreach ($this->lista as $item) {                
                // historico consumible
                $sql="INSERT INTO consumible (id, idProducto, cantidad, tamano)
                    VALUES (:id, :idProducto, :cantidad, :tamano)";
                $param= array(':id'=> $item->id, ':idProducto'=> $item->idProducto, ':cantidad'=> $item->cantidad, ':tamano'=> $item->tamano);
                $data = DATA::Ejecutar($sql,$param,false);
                if(!$data)
                    $created= false;
            }
            if($created)
                return true;
            else throw new Exception('Error al crear el consumible.', 66923);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    function Delete(){
        try {                  
            $sql='DELETE  FROM consumible';
                // WHERE id=:id';
            //$param= array(':id'=> $id);
            $data= DATA::Ejecutar($sql,null,false);
            if($data)
                return $sessiondata['status']=0;
            else throw new Exception('Error al eliminar.', 54649);
        }
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => $e->getMessage()))
            );
        }
    }

    public static function salida($tamano){
        try {                  
            $sql='SELECT idProducto, cantidad 
                FROM consumible
                WHERE  tamano=:tamano';
            $param= array(':tamano'=> $tamano);
            $data= DATA::Ejecutar($sql, $param);
            foreach ($data as $key => $value){
                self::salidaBodega($value['idProducto'], 'ordenXX', $value['cantidad']);
            }
        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // header('HTTP/1.0 400 Bad error');
            // die(json_encode(array(
            //     'code' => $e->getCode() ,
            //     'msg' => $e->getMessage()))
            // );
        }
    }

    public static function salidaBodega($idProducto, $outOrden, $outCantidad){
        try {
            $sql="SELECT saldoCantidad, costoPromedio 
                FROM insumosXBodega 
                WHERE idBodega=:idBodega and idProducto=:idProducto;";
            $param = array(':idProducto'=>$idProducto, ':idBodega'=>$_SESSION['userSession']->idBodega);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                // calculo de saldos. 
                // self::$valorSalida = floatval($data[0]['costoPromedio'] * $outCantidad);
                $saldoCantidad = $data[0]['saldoCantidad'] - $outCantidad;
                $saldoCosto = floatval($data[0]['costoPromedio'] * $saldoCantidad);
                if($saldoCantidad < 0){
                    $saldoCantidad = 0;
                    $saldoCosto = 0;
                }
                // agrega SALIDA histórico inventario.
                $sql="INSERT INTO inventarioBodega  (id, idOrdenSalida, idInsumo, salida, saldo, valorSalida, valorSaldo)
                    VALUES (uuid(), :idOrdenSalida, :idInsumo, :salida, :saldo, :valorSalida, :valorSaldo );";
                $param= array(':idOrdenSalida'=>$outOrden, 
                    ':idInsumo'=>$idInsumo,
                    ':salida'=>$outCantidad,
                    ':saldo'=>self::$saldoCantidad, 
                    ':valorSalida'=> self::$valorSalida,
                    ':valorSaldo'=>self::$saldoCosto
                );
                // actualiza saldos.
                $sql = 'UPDATE insumosXBodega
                    SET saldoCantidad=:saldoCantidad, saldoCosto=:saldoCosto
                    WHERE idBodega=:idBodega and idProducto=:idProducto;';
                $param = array(':idProducto'=>$idProducto, ':idBodega'=>$_SESSION['userSession']->idBodega, ':saldoCantidad'=>$saldoCantidad, ':saldoCosto'=>$saldoCosto);
                $data = DATA::Ejecutar($sql, $param, false);
                if($data) {
                    return true;
                }                
                else throw new Exception('Error al consultar actualizar los saldos de insumo x bodega ('.$idProducto.')' , ERROR_SALIDA_INVENTARIO_INSUMOXBODEGA);
            }
            else throw new Exception('Warning, el código de insumo no se encuentra en el inventario, no es posible actualizar por facturacion. ('.$idProducto.')' , ERROR_SALIDA_INVENTARIO_INSUMOXBODEGA);

        }
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            // header('HTTP/1.0 400 Bad error');
            // die(json_encode(array(
            //     'code' => $e->getCode() ,
            //     'msg' => $e->getMessage()))
            // );
        }
    }
}


?>
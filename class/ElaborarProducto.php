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
    require_once("Producto.php");
    require_once("InventarioProducto.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $elaborarProducto= new ElaborarProducto();
    switch($opt){
        case "Create":
            $elaborarProducto->Create();
            break; 
        case "RevierteOrdenSalida":
            $elaborarProducto->RevierteOrdenSalida();
            break; 
    }
}

class ElaborarProducto{
    public $numeroOrden;
    public $idOrdenSalida;
    public $listaProducto=[];
    public $fechaliquida;

    function __construct(){
        // identificador único
        // 
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->numeroOrden= $obj["numeroOrden"] ?? '';
            $this->idOrdenSalida= $obj["idOrdenSalida"] ??'';
            $this->fechaLiquida= $obj["fechaLiquida"] ?? '';
            //Productos
            if (isset($obj["listaProducto"] )) {
                require_once("Producto.php");    
                //            
                foreach ($obj["listaProducto"] as $objproducto) {
                    $producto= new Producto();
                    $producto->id= $objproducto['idProducto'];
                    $producto->cantidad= $objproducto['cantidad'];
                    $producto->costo= $objproducto['costo'];
                    array_push ($this->listaProducto, $producto);
                }
            }
        }
    }

    function Create(){
        try {
            $created = true;
            // $now = date("Y-m-d H:i:s", localtime());
            $cantidadProductos=0;
            foreach ($this->listaProducto as $item){
                $cantidadProductos += $item->cantidad;
            }
            $costopromedio=0; // Costo promedio Unitario de cada producto generado en la orden.
            //INSERTA los datos en porductosXOrdenSalida
            foreach ($this->listaProducto as $item){
                $costopromedio=$item->costo/$cantidadProductos;
                require_once("UUID.php");
                $id= $obj["id"] ?? UUID::v4();
                $sql="INSERT INTO productosXOrdenSalida (id,idOrdenSalida,idProducto,cantidad,costo) VALUES (:id,:idOrdenSalida,:idProducto,:cantidad,:costo)";
                $param=array(':id'=>$id,':idOrdenSalida'=>$this->numeroOrden,':idProducto'=>$item->id,':cantidad'=>$item->cantidad,':costo'=>$costopromedio);
                $data = DATA::Ejecutar($sql,$param,false);
            }
            //
            $sql="UPDATE ordenSalida 
                SET idEstado=1, fechaLiquida=:fechaLiquida
                WHERE numeroOrden=:numeroOrden";
            $param= array(':numeroOrden'=>$this->numeroOrden,':fechaLiquida'=>$this->fechaLiquida);
            $data = DATA::Ejecutar($sql,$param,false);
            //averiguar cuantos productos de venta llevo para dividir el costo.
            $cantidadproductos = 0;
            foreach ($this->listaProducto as $item) 
            {
                $cantidadproductos = $cantidadproductos + $item->cantidad;
            }
            foreach ($this->listaProducto as $item) 
            {
                $costounitario = $item->costo/$cantidadproductos;
                $totalproducto = $costounitario * $item->cantidad;
                // entrada a inventario. Actualiza los saldos y calcula promedio
                InventarioProducto::entrada($item->id, $this->idOrdenSalida, $item->cantidad, $costounitario);
            }
            return $created;
        }     
        catch(Exception $e) {
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    function RevierteOrdenSalida(){
        try {
            //Revierte los cambios en el Producto

            $sql = "SELECT numeroOrden FROM ordenSalida WHERE id=:idOrdenSalida";
            $param = array(':idOrdenSalida'=>$_POST["idOrdenSalida"]);
            $idOrdenSalida = DATA::Ejecutar($sql,$param);
            
            $sql="SELECT idProducto,cantidad,costo,(SELECT idOrdenSalida FROM ordenSalida WHERE id=productosXOrdenSalida.idOrdenSalida)
            AS idOrdenSalida FROM tropical.productosXOrdenSalida WHERE idOrdenSalida=".$idOrdenSalida[0][0];
            $listaProducto = DATA::Ejecutar($sql);

            foreach ($listaProducto as $item) 
            {
                // Revierte saldos y vuelve a calcular el promedio
                // Producto::RevierteProducto($item["idProducto"], $item["cantidad"], $item["costo"]);
                // $this->salida($item["idProducto"], $_POST["idOrdenSalida"], $item["cantidad"]);
                InventarioProducto::salida($item['idProducto'], $_POST["idOrdenSalida"], $item['cantidad']);
            }

            $sql="SELECT idInsumo,cantidad,costoPromedio,idOrdenSalida,(SELECT numeroOrden FROM ordenSalida WHERE id=idOrdenSalida)
            AS consecutivo FROM tropical.insumosXOrdenSalida WHERE idOrdenSalida="."'".$_POST["idOrdenSalida"]."'";
            $listaInsumos = DATA::Ejecutar($sql);

            foreach ($listaInsumos as $item)
            {
                $sql="CALL spRevierteInsumo(:mid, :ncantidad, :ncosto);";
                $param= array(':mid'=>$item["idInsumo"], ':ncantidad'=>$item["cantidad"], ':ncosto'=>$item["costoPromedio"]);
                $data = DATA::Ejecutar($sql,$param,false);       
            }

            $this->CreateInventarioInsumo($listaInsumos);

            if($data){
                $sql="UPDATE ordenSalida SET idEstado=2 WHERE numeroOrden=".$idOrdenSalida[0][0];
                $data = DATA::Ejecutar($sql);
                return true;
            }
            else throw new Exception('Error al calcular SALDOS Y PROMEDIOS, debe realizar el cálculo manualmente.', 666);
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }

    public function salida($idProducto, $outOrden, $outCantidad){
        try {
            $sql="SELECT saldoCantidad, costoPromedio FROM producto WHERE id=:idProducto;";
            $param = array(':idProducto'=>$idProducto);
            $data = DATA::Ejecutar($sql,$param);
            if($data){
                // calculo de saldos. 
                $valorSalida = floatval($data[0]['costoPromedio'] * $outCantidad);
                $saldoCantidad = $data[0]['saldoCantidad'] - $outCantidad;
                $saldoCosto = floatval($data[0]['costoPromedio'] * $saldoCantidad);
                // agrega ENTRADA histórico inventario.
                $sql="INSERT INTO inventarioProducto  (id, idOrdenSalida, idProducto, salida, saldo, valorSalida, valorSaldo)
                    VALUES (uuid(), :idOrdenSalida, :idProducto, :salida, :saldo, :valorSalida, :valorSaldo );";
                $param= array(':idOrdenSalida'=>$outOrden, 
                    ':idProducto'=>$idProducto,
                    ':salida'=>$outCantidad,
                    ':saldo'=>$saldoCantidad, 
                    ':valorSalida'=> $valorSalida,
                    ':valorSaldo'=>$saldoCosto
                );
                $data = DATA::Ejecutar($sql, $param, false);
            } 
            else throw new Exception('Error al consultar el codigo del producto para actualizar inventario ('.$idProducto.')' , ERROR_SALIDA_INVENTARIO_PRODUCTO);
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

    //Orden Produccion Cancelada (ENTRADA)
    public function CreateInventarioInsumo($obj){
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
                $sql="INSERT INTO inventarioInsumo (id, idOrdenSalida, idInsumo, entrada, saldo, valorEntrada, valorSaldo, costoPromedio, fecha, ordenCancelada)
                                       VALUES (uuid(),:idOrdenSalida, :idInsumo, :entrada, :saldo, :valorEntrada, :valorSaldo, :costoPromedio, :fecha, :ordenCancelada)";
                $param= array(':idOrdenSalida'=>$item['idOrdenSalida'], 
                    ':idInsumo'=>$item['idInsumo'],
                    ':entrada'=>$item['cantidad'],
                    ':saldo'=>$valor[0]['saldoCantidad'], 
                    ':valorEntrada'=>(string)$costoAdquisicion,
                    ':valorSaldo'=>$valor[0]['saldoCosto'],
                    ':costoPromedio'=>$valor[0]['costoPromedio'],
                    ':fecha'=>date("Y-m-d H:i:s"),
                    ':ordenCancelada'=>$item['consecutivo']
                );
                DATA::Ejecutar($sql,$param,false);                
            }
            return $created;
        }     
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            return false;
        }
    }


}

?>
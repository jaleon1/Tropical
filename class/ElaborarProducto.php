<?php
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
        // $this->$idOrdenSalida= $_POST["idOrdenSalida"] ??'';
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->numeroOrden= $obj["numeroOrden"] ?? '';
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
            $now = date("Y-m-d H:i:s", localtime());
            $cantidadProductos=0;
            foreach ($this->listaProducto as $item){
                $cantidadProductos += $item->cantidad;
            }
            $costopromedio=0;
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
                // Actualiza los saldos y calcula promedio
                Producto::UpdateSaldoProducto($item->id, $item->cantidad, $totalproducto);
                // entrada a inventario.
                InventarioProducto::entrada($item);
            }
            return $created;
        }     
        catch(Exception $e) {
            return false;
        }
    }

    function RevierteOrdenSalida(){
        try {
            //Revierte los cambios en el Producto

            $sql = "SELECT numeroOrden FROM ordenSalida WHERE id=:idOrdenSalida";
            $param = array(':idOrdenSalida'=>$_POST["idOrdenSalida"]);
            $idOrdenSalida = DATA::Ejecutar($sql,$param);
            
            $sql="SELECT idProducto,cantidad,costo FROM tropical.productosXOrdenSalida WHERE idOrdenSalida=".$idOrdenSalida[0][0];
            $listaProducto = DATA::Ejecutar($sql);

            foreach ($listaProducto as $item) 
            {
                // Revierte saldos y vuelve a calcular el promedio
                Producto::RevierteProducto($item["idProducto"], $item["cantidad"], $item["costo"]);
            }

            $sql="SELECT idInsumo,cantidad,costoPromedio FROM tropical.insumosXOrdenSalida WHERE idOrdenSalida="."'".$_POST["idOrdenSalida"]."'";
            $listaInsumos = DATA::Ejecutar($sql);

            foreach ($listaInsumos as $item) 
            {
                $sql="CALL spRevierteInsumo(:mid, :ncantidad, :ncosto);";
                $param= array(':mid'=>$item["idInsumo"], ':ncantidad'=>$item["cantidad"], ':ncosto'=>$item["costoPromedio"]);
                $data = DATA::Ejecutar($sql,$param,false);
            }

            if($data){
                $sql="UPDATE ordenSalida SET idEstado=2 WHERE numeroOrden=".$idOrdenSalida[0][0];
                $data = DATA::Ejecutar($sql);
                return true;
            }
            else throw new Exception('Error al calcular SALDOS Y PROMEDIOS, debe realizar el cálculo manualmente.', 666);
        }     
        catch(Exception $e) {
            return false;
        }
    }

}

?>
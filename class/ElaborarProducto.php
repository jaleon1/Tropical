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
    $elaborarProducto= new ElaborarProducto();
    switch($opt){
        case "Create":
            $elaborarProducto->Create();
            break; 
    }
}

class ElaborarProducto{
    public $numeroOrden;
    public $listaProducto=[];
    public $fechaliquida;

    function __construct(){
        // identificador único
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
                    $producto->saldoCantidad= $objproducto['cantidad'];
                    $producto->costoPromedio= $objproducto['costo'];
                    array_push ($this->listaProducto, $producto);
                }
            }
        }
    }

    function Create(){
        try {
            $created = true;
            // $now = date_create('now')->format('Y-m-d H:i:s');
            $now = date("Y-m-d H:i:s", localtime());
            $sql="UPDATE ordenSalida 
                SET idEstado=1, fechaLiquida=:fechaLiquida
                WHERE numeroOrden=:numeroOrden";
            $param= array(':numeroOrden'=>$this->numeroOrden,':fechaLiquida'=>$this->fechaLiquida);
            $data = DATA::Ejecutar($sql,$param,false);

            //averiguar cuantos productos de venta llevo para dividir el costo.
            $cantidadproductos = 0;
            foreach ($this->listaProducto as $item) 
            {
                $cantidadproductos = $cantidadproductos + $item->saldoCantidad;
            }

            foreach ($this->listaProducto as $item) 
            {
                $costounitario = $item->costoPromedio/$cantidadproductos;
                $totalproducto = $costounitario * $item->saldoCantidad;
                // Actualiza los saldos y calcula promedio
                Producto::UpdateSaldoProducto($item->id, $item->saldoCantidad, $totalproducto);
            }
            return $created;
        }     
        catch(Exception $e) {
            return false;
        }
    }

}

?>
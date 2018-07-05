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
    $productotemporal= new ProductoTemporal();
    switch($opt){
        case "Create":
            $productotemporal->Create();
            break; 
    }
}

class ProductoTemporal{
    public $numeroorden;
    public $listaproducto=[];

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"];
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->numeroorden= $obj["numeroorden"] ?? '';
            //Productos
            if (isset($obj["listaproducto"] )) {
                require_once("Producto.php");    
                //            
                foreach ($obj["listaproducto"] as $objproducto) {
                    $producto= new Producto();
                    $producto->id= $objproducto['idProducto'];
                    $producto->saldoCantidad= $objproducto['cantidad'];
                    $producto->costoPromedio= $objproducto['costo'];
                    array_push ($this->listaproducto, $producto);
                }
            }
        }
    }

    function Create(){
        try {
            $created = true;
            $now = date_create('now')->format('Y-m-d H:i:s');
            $sql="UPDATE ordensalida 
                SET idestado=1, fechaliquida=:fechaliquida
                WHERE numeroorden=:numeroorden";
            $param= array(':numeroorden'=>$this->numeroorden,':fechaliquida'=>$now);
            $data = DATA::Ejecutar($sql,$param,false);

            //averiguar cuantos productos de venta llevo para dividir el costo.
            $cantidadproducto = count($this->listaproducto);
            foreach ($this->listaproducto as $item) 
            {
                $costoxproducto = $item->costoPromedio/$cantidadproducto;
            }

            foreach ($this->listaproducto as $item) 
            {
                // Actualiza los saldos y calcula promedio
                Producto::UpdateSaldoProducto($item->id, $item->saldoCantidad, $costoxproducto);
            }
            return $created;
        }     
        catch(Exception $e) {
            return false;
        }
    }

}

?>
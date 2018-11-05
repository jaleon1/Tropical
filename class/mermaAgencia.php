<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    //require_once("Insumo.php");
    //require_once("Producto.php");
    require_once("InventarioInsumoXBodega.php");
    //require_once("InventarioProducto.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $merma= new Merma();
    switch($opt){
        case "ReadAll":
            echo json_encode($merma->ReadAll());
            break;
        case "Create":
            echo json_encode($merma->Create());
            break;
    }
}

class Merma{
    public $id=null;
    public $idBodega= null;
    public $idProducto= null;
    public $idInsumo= null;
    public $descripcion='';
    public $cantidad=0;
    public $fecha;
}

?>
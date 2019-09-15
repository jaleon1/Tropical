<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes    
    require_once("conexion.php");    
    //require_once("UUID.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $actividadEconomica= new ActividadEconomica();
    switch($opt){
        case "readAll":
            echo json_encode($actividadEconomica->readAll());
            break;
    }
}
class ActividadEconomica{
    public $id;
    public $simbolo;
    public $descripcion;
    
    public static function readAll(){
        try {
            $sql= 'SELECT id, nombre, codigo
                FROM actividadesEconomicas order by codigo asc';
            $data= DATA::Ejecutar($sql);
            $lista = [];
            foreach ($data as $key => $value){
                $item = new ActividadEconomica();
                $item->id = $value['id']; 
                $item->nombre = $value['nombre'];
                $item->codigo = $value['codigo'];
                array_push ($lista, $item);
            }
            return $lista;
        }     
        catch(Exception $e) { 
            error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            if (!headers_sent()) {
                    header('HTTP/1.0 400 Error al generar al cargar lista');
                }  
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar la lista'))
            );
        }
    }
}

?>
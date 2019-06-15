<?php
if(isset($_POST["action"])){
    $opt= $_POST["action"];
    unset($_POST['action']);
    // Classes
    require_once("Conexion.php");
    require_once("Usuario.php");
    // Session
    if (!isset($_SESSION))
        session_start();
    // Instance
    $reporteCaja= new ReporteCaja();
    switch($opt){
        case "ReadAll":
            echo json_encode($reporteCaja->ReadAll());
            break;
    }
}

class ReporteCaja{
    public $id=null;
    public $fechaInicial = "";
    public $fechaFinal = "";
     

    function __construct(){
        // identificador único
        if(isset($_POST["id"])){
            $this->id= $_POST["id"] ?? null;
        }
        if(isset($_POST["obj"])){
            $obj= json_decode($_POST["obj"],true);
            $this->fechaInicial= $obj["fechaInicial"] ?? null;
            $this->fechaFinal= $obj["fechaFinal"] ?? null;
        }
    }

    function ReadAll(){
        try {
            $sql='SELECT ca.idBodega, bo.nombre bodegaNombre, ca.montoApertura, ca.montoCierre, ca.fechaApertura, 
                    sum(ca.totalVentasEfectivo) ventasEfectivo, sum(ca.totalVentasTarjeta) ventasTarjeta, 
                    (date(ca.fechaApertura)) aperturaCaja
                FROM tropical.cajasXBodega ca
                INNER JOIN bodega bo
                ON bo.id = ca.idBodega
                WHERE fechaApertura BETWEEN :fechaInicial and :fechaFinal
                GROUP BY aperturaCaja, bo.nombre 
                ORDER BY fechaApertura DESC;';
            $param= array(':fechaInicial'=>$this->fechaInicial,':fechaFinal'=>$this->fechaFinal);
            $data= DATA::Ejecutar($sql,$param);
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

}

?>

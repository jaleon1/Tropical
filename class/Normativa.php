<?php
//
// datos de la normativa vigente
//
require_once('Conexion.php');

class Normativa{
    public $numeroResolucion;
    public $fechaResolucion;

    public function Datos(){
        $sql='SELECT numeroResolucion, fechaResolucion
            FROM normativa';
        //$param= array(':identificacion'=> $ident);
        $data= DATA::Ejecutar($sql);
        if(count($data)){
            $this->numeroResolucion= $data[0]['numeroResolucion'];
            $this->fechaResolucion= $data[0]['fechaResolucion']; 
            return  $this;
        }
        else return null;
    }
}

?>
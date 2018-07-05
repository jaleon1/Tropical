<?php
//
// datos del emisor de la factura
//
require_once('Conexion.php');

class Receptor{
    public $nombre= null;
    public $tipoIdentificacion= null;
    public $identificacion= null;
    public $identificacionExtranjero= null;
    public $nombreComercial= null;
    public $idUbicacion= null;
    public $idProvincia= null;
    public $idCanton= null;
    public $idDistrito= null;
    public $idBarrio= null;
    public $otrasSenas= null;
    public $idCodigoPaisTel= null;
    public $numTelefono= null;
    public $codigoPaisFax= null;
    public $numTelefonoFax= null;
    public $correoElectronico= null;

    public function Datos($ident){
        $sql='SELECT r.id, nombre, idtipoidentificacion, identificacion, identificacionExtranjero, nombrecomercial, ubicacion, idProvincia, idCanton, idDistrito, idBarrio, otrassenas, idCodigoPaisTel, numtelefono, idcodigopaisfax, numtelefonofax, correoelectronico
            FROM receptor r inner join factura f on f.idreceptor=r.id
            WHERE r.id= :identificacion';
        $param= array(':identificacion'=> $ident);
        $data= DATA::Ejecutar($sql, $param);
        if(count($data)){
            $this->nombre= $data[0]['nombre'];
            $this->tipoIdentificacion= $data[0]['idtipoidentificacion'];
            $this->identificacion= $data[0]['identificacion'];
            $this->identificacionExtranjero= $data[0]['identificacionExtranjero'];
            $this->nombreComercial= $data[0]['nombrecomercial'];
            $this->ubicacion= $data[0]['ubicacion'];
            $this->idProvincia= $data[0]['idProvincia'];
            $this->idCanton= $data[0]['idCanton'];
            $this->idDistrito= $data[0]['idDistrito'];
            $this->idBarrio= $data[0]['idBarrio'];
            $this->otrasSenas= $data[0]['otrassenas'];
            $this->idCodigoPaisTel= $data[0]['idCodigoPaisTel'];
            $this->numTelefono= $data[0]['numtelefono'];
            $this->idCodigoPaisFax= $data[0]['idcodigopaisfax'];
            $this->numTelefonoFax= $data[0]['numtelefonofax'];
            $this->correoElectronico= $data[0]['correoelectronico']; 
            return  $this;
        }
        else return null;
    }
}

?>
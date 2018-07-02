<?php
//
// datos del emisor de la factura
//
require_once('Conexion.php');

class Receptor{
    public $nombre= null;
    public $tipoIdentificacion= null;
    public $identificacion= null;
    public $identificacionextranjero= null;
    public $nombreComercial= null;
    public $idubicacion= null;
    public $idprovincia= null;
    public $idcanton= null;
    public $iddistrito= null;
    public $idbarrio= null;
    public $otrasSenas= null;
    public $idcodigoPaisTel= null;
    public $numTelefono= null;
    public $codigoPaisFax= null;
    public $numTelefonoFax= null;
    public $correoElectronico= null;

    public function Datos($ident){
        $sql='SELECT r.id, nombre, idtipoidentificacion, identificacion, identificacionextranjero, nombrecomercial, ubicacion, idprovincia, idcanton, iddistrito, idbarrio, otrassenas, idcodigopaistel, numtelefono, idcodigopaisfax, numtelefonofax, correoelectronico
            FROM receptor r inner join factura f on f.idreceptor=r.id
            WHERE r.id= :identificacion';
        $param= array(':identificacion'=> $ident);
        $data= DATA::Ejecutar($sql, $param);
        if(count($data)){
            $this->nombre= $data[0]['nombre'];
            $this->tipoIdentificacion= $data[0]['idtipoidentificacion'];
            $this->identificacion= $data[0]['identificacion'];
            $this->identificacionExtranjero= $data[0]['identificacionextranjero'];
            $this->nombreComercial= $data[0]['nombrecomercial'];
            $this->ubicacion= $data[0]['ubicacion'];
            $this->idprovincia= $data[0]['idprovincia'];
            $this->idcanton= $data[0]['idcanton'];
            $this->iddistrito= $data[0]['iddistrito'];
            $this->idbarrio= $data[0]['idbarrio'];
            $this->otrasSenas= $data[0]['otrassenas'];
            $this->idcodigoPaisTel= $data[0]['idcodigopaistel'];
            $this->numTelefono= $data[0]['numtelefono'];
            $this->idcodigoPaisFax= $data[0]['idcodigopaisfax'];
            $this->numTelefonoFax= $data[0]['numtelefonofax'];
            $this->correoElectronico= $data[0]['correoelectronico']; 
            return  $this;
        }
        else return null;
    }
}

?>
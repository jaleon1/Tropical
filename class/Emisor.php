<?php
//
// datos del receptor de la factura
//
require_once('Conexion.php');

class Emisor{
    public $id;
    public $codigoSeguridad;
    public $nombre;
    public $idCodigoPais;
    public $tipoIdentificacion;
    public $identificacion;
    public $nombreComercial;
    public $idProvincia;
    public $idCanton;
    public $idDistrito;
    public $idBarrio;
    public $otrasSenas;
    public $idCodigoPaisTel;
    public $numTelefono;
    public $idCodigoPaisFax;
    public $numTelefonoFax;
    public $correoElectronico;   

    public function Datos($id){
        $sql='SELECT id, codigoseguridad, idcodigopais, nombre, idtipoidentificacion, identificacion, nombrecomercial, idProvincia, idCanton, idDistrito, idBarrio, otrassenas, idCodigoPaisTel, numtelefono, idcodigopaisfax, numtelefonofax, correoelectronico
            FROM clienteFE
            WHERE id= :id';
        $param= array(':id'=> $id);
        $data= DATA::Ejecutar($sql, $param);
        if(count($data)){
            $this->codigoSeguridad= $data[0]['codigoseguridad'];
            $this->nombre= $data[0]['nombre'];
            $this->idCodigoPais= $data[0]['idcodigopais'];
            $this->tipoIdentificacion= $data[0]['idtipoidentificacion'];
            $this->identificacion= $data[0]['identificacion'];
            $this->nombreComercial= $data[0]['nombrecomercial'];
            $this->idProvincia= $data[0]['idProvincia'];
            $this->idCanton= $data[0]['idCanton'];
            $this->idDistrito= $data[0]['idDistrito'];
            $this->idBarrio= $data[0]['idBarrio'];
            $this->otrasSenas= $data[0]['otrassenas'];
            $this->idcodigopaisTel= $data[0]['idCodigoPaisTel'];
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
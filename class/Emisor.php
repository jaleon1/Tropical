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
    public $idprovincia;
    public $idcanton;
    public $iddistrito;
    public $idbarrio;
    public $otrasSenas;
    public $idcodigopaistel;
    public $numTelefono;
    public $idcodigoPaisFax;
    public $numTelefonoFax;
    public $correoElectronico;   

    public function Datos($id){
        $sql='SELECT id, codigoseguridad, idcodigopais, nombre, idtipoidentificacion, identificacion, nombrecomercial, idprovincia, idcanton, iddistrito, idbarrio, otrassenas, idcodigopaistel, numtelefono, idcodigopaisfax, numtelefonofax, correoelectronico
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
            $this->idprovincia= $data[0]['idprovincia'];
            $this->idcanton= $data[0]['idcanton'];
            $this->iddistrito= $data[0]['iddistrito'];
            $this->idbarrio= $data[0]['idbarrio'];
            $this->otrasSenas= $data[0]['otrassenas'];
            $this->idcodigopaisTel= $data[0]['idcodigopaistel'];
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
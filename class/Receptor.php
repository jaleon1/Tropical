<?php
//
// datos del emisor de la factura
//
require_once('Conexion.php');

class Receptor{
    public $id= null;
    public $nombre= null;
    public $idTipoIdentificacion= null;
    public $identificacion= null;
    public $identificacionExtranjero= null;
    public $nombreComercial= null;
    public $idProvincia= null;
    public $idCanton= null;
    public $idDistrito= null;
    public $idBarrio= null;
    public $otrasSenas= null;
    public $idCodigoPaisTel= null;
    public $numTelefono= null;
    public $idCodigoPaisFax= null;
    public $numTelefonoFax= null;
    public $correoElectronico= null;

    public function read(){
        try{
            $sql= 'SELECT  id, nombre, idTipoIdentificacion, identificacion, identificacionExtranjero, nombreComercial, idProvincia, idCanton, idDistrito, idBarrio, otrasSenas, idCodigoPaisTel, numTelefono, idCodigoPaisFax, numTelefonoFax, correoElectronico
            FROM receptor
            WHERE id= :id';
            $param= array(':id'=> $this->id);
            $data= DATA::Ejecutar($sql, $param);        
            if($data){
                $this->nombre= $data[0]['nombre'];
                $this->idTipoIdentificacion= $data[0]['idTipoIdentificacion'];
                $this->identificacion= $data[0]['identificacion'];
                $this->identificacionExtranjero= $data[0]['identificacionExtranjero'];
                $this->nombreComercial= $data[0]['nombreComercial'];
                $this->idProvincia= $data[0]['idProvincia'];
                $this->idCanton= $data[0]['idCanton'];
                $this->idDistrito= $data[0]['idDistrito'];
                $this->idBarrio= $data[0]['idBarrio'];
                $this->otrasSenas= $data[0]['otrasSenas'];
                $this->idCodigoPaisTel= $data[0]['idCodigoPaisTel'];
                $this->numTelefono= $data[0]['numTelefono'];
                $this->idCodigoPaisFax= $data[0]['idCodigoPaisFax'];
                $this->numTelefonoFax= $data[0]['numTelefonoFax'];
                $this->correoElectronico= $data[0]['correoElectronico']; 
                return  $this;
            }
            else return null;
        }
        catch(Exception $e) { error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
            header('HTTP/1.0 400 Bad error');
            die(json_encode(array(
                'code' => $e->getCode() ,
                'msg' => 'Error al cargar el receptor'))
            );
        }
    }

    public static function default(){
        $sql='SELECT r.id, nombre, idTipoIdentificacion, identificacion, identificacionExtranjero, nombreComercial, idProvincia, idCanton, idDistrito, idBarrio, otrasSenas, idCodigoPaisTel, numTelefono, idCodigoPaisFax, numTelefonoFax, correoElectronico
            FROM receptor r
            WHERE r.nombre="default"';
        $data= DATA::Ejecutar($sql);
        $receptor = new Receptor();
        if(count($data)){
            $receptor->id= $data[0]['id'];
            $receptor->nombre= $data[0]['nombre'];
            $receptor->idTipoIdentificacion= $data[0]['idTipoIdentificacion'];
            $receptor->identificacion= $data[0]['identificacion'];
            $receptor->identificacionExtranjero= $data[0]['identificacionExtranjero'];
            $receptor->nombreComercial= $data[0]['nombreComercial'];
            $receptor->idProvincia= $data[0]['idProvincia'];
            $receptor->idCanton= $data[0]['idCanton'];
            $receptor->idDistrito= $data[0]['idDistrito'];
            $receptor->idBarrio= $data[0]['idBarrio'];
            $receptor->otrasSenas= $data[0]['otrasSenas'];
            $receptor->idCodigoPaisTel= $data[0]['idCodigoPaisTel'];
            $receptor->numTelefono= $data[0]['numTelefono'];
            $receptor->idCodigoPaisFax= $data[0]['idCodigoPaisFax'];
            $receptor->numTelefonoFax= $data[0]['numTelefonoFax'];
            $receptor->correoElectronico= $data[0]['correoElectronico'];
            return $receptor;
        }
        else return null;
    }
}

?>
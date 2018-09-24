<?php
class Factura{
    public $idCondicionVenta; //contado, credito ...
    public $plazoCredito=null; //
    public $idMedioPago; //efectivo, tarjeta, cheque ...  
    public $codigoReferencia= null; // info. de documentos de rererencia. opt
    public $codigoMoneda;
    public $tipoCambio;
    public $totalServGravados;
    public $totalServExentos;
    public $totalMercanciasGravadas;
    public $totalMercanciasExentas;
    public $totalGravado;
    public $totalExento;
    // valores totales
    public $totalVenta;
    public $totalDescuentos;
    public $totalVentaNeta;
    public $totalImpuesto;
    public $totalComprobante;
    //
    public $idEmisor;
    public $idReceptor;

    public function Datos($ident){
        $sql='SELECT *
            FROM factura
            WHERE id= :id';
        $param= array(':id'=> $ident);
        $data= DATA::Ejecutar($sql, $param);
        if(count($data)){
            $this->fechaEmision= $data[0]['fechaemision'];
            $this->consecutivo= $data[0]['consecutivo'];
            $this->local= $data[0]['local'];
            $this->terminal= $data[0]['terminal'];
            $this->idCondicionVenta= $data[0]['idcondicionventa'];
            $this->idSituacionComprobante= $data[0]['idsituacioncomprobante'];
            $this->idEstadoComprobante= $data[0]['idestadocomprobante'];
            $this->plazoCredito= $data[0]['plazoCredito'];
            $this->idMedioPago= $data[0]['idMedioPago'];
            // $this->idcodigoMoneda= $data[0]['idcodigoMoneda'];
            // $this->tipoCambio= $data[0]['tipoCambio'];
            // ...
            // codigo referencia
            $this->codigoReferencia= $data[0]['codigoReferencia'];
            // totales
            $this->totalVenta= $data[0]['totalVenta'];
            $this->totalDescuentos= $data[0]['totalDescuentos'];
            $this->totalVentaNeta= $data[0]['totalVentaNeta']; 
            $this->totalImpuesto= $data[0]['totalImpuesto']; 
            $this->totalComprobante= $data[0]['totalComprobante'];
            //
            $this->idEmisor= $data[0]['idEmisor'];
            $this->idReceptor= $data[0]['idReceptor'];
            return  $this;
        }
        else return null;
    }
}

class ProductoXFactura{
    public $numeroLinea;
    public $tipoCodigo= null;
    public $codigo= null;
    public $cantidad;
    public $unidadMedida;
    public $unidadMedidaComercial= null; //opt
    public $detalle;
    public $precioUnitario;
    public $montoTotal;
    public $montoDescuento= null; // opt
    public $naturalezaDescuento= null; // opt
    public $subTotal;
    public $codigoImpuesto= null; // opt
    public $tarifaImpuesto= null; // opt
    public $montoImpuesto= null; // opt
    public $exoneracionImpuesto= null; // opt. Valor complex que contiene otros campos.
    public $TipoDocumento= null;  // opt
    public $NumeroDocumento= null; // opt
    public $NombreInstitucion= null; // opt
    public $FechaEmision= null; // opt
    public $PorcentajeCompra= null; // opt
    public $montoTotalLinea;
    

    public function Datos($idfactura){
        $sql='SELECT *
            FROM productoxfactura
            WHERE idfactura= :idfactura';
        $param= array(':idfactura'=> $idfactura);
        $data= DATA::Ejecutar($sql, $param);
        if(count($data)){
            $this->id= $data[0]['id'];
            $this->idProducto= $data[0]['idProducto'];
            $this->numeroLinea= $data[0]['numeroLinea'];
            $this->codigo= $data[0]['codigo'];
            $this->cantidad= $data[0]['cantidad'];
            $this->idUnidadMedida= $data[0]['idUnidadMedida'];
            $this->unidadMedidaComercial= $data[0]['unidadMedidaComercial'];
            $this->detalle= $data[0]['detalle'];
            $this->precioUnitario= $data[0]['precioUnitario'];
            $this->montoTotal= $data[0]['montoTotal'];
            $this->montoDescuento= $data[0]['montoDescuento'];
            $this->naturalezaDescuento= $data[0]['naturalezaDescuento'];
            $this->subTotal= $data[0]['subTotal'];
            $this->codigoImpuesto  = $data[0]['codigoImpuesto'];
            $this->tarifaImpuesto= $data[0]['tarifaImpuesto']; 
            $this->montoImpuesto= $data[0]['montoImpuesto'];
            $this->idExoneracionImpuesto  = $data[0]['idExoneracionImpuesto'];
            $this->montoTotalLinea= $data[0]['montoTotalLinea']; 
            
            return  $this;
        }
        else return null;
    }
}
?>
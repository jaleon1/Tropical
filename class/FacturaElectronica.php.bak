<?php
require_once("FacturaTemp.php");
require_once("Emisor.php");
require_once("Receptor.php");
require_once("Normativa.php");

class FacturaElectronica{
    private $id=null; // UUID de la transacción a enviar a hacienda. 
    public $idTransaccion;
    private $tipoComprobante= '01'; // 01: FE.
    // datos del JSON.
    private $clave;
    private $numConsecutivo; // compuesto por valor unicos de factura.
    private $dia;
    private $mes;
    private $ann;  
    private $FacturaElectronica; // documento xml con los valores de la factura.   
    private $factura; 
    private $detalle;
    private $emisor;
    private $token; // token de conexión.
    //
    // Métodos
    //
    function Send(){ 
        // Carga valores de las tablas.
        $this->CargaValores();
        // crea #clave
        $this->CreaClave();
        // crea xml     
        $this->CreaXml();
        // llave criptografica - base64
        // crea JSON
        // crea access_token-refresh_token
        // enviar
        // consultar
    }

    private function CargaValores(){
        // info de la factura.
        $this->factura= new Factura();
        if($this->factura->Datos($this->idTransaccion)==null){
            // debe notificar el error para un envío tipo 2: Contingencia
            $this->setContingencia();
            return false;
        }
        // detalle de la factura.
        $this->detalle= new ProductoXFactura();
        if($this->detalle->Datos($this->idTransaccion)==null){
            // debe notificar el error para un envío tipo 2: Contingencia
            $this->setContingencia();
            return false;
        }
        // info del emisor (cliente FE).      
        $this->emisor= new Emisor();
        if($this->emisor->Datos($this->factura->idEmisor)==null){
            // debe notificar el error para un envío tipo 2: Contingencia
            $this->setContingencia();
            return false;
        }
    }

    private function CreaClave(){
        $dia = date('d');
        $mes = date('m');
        $ano = date('y');
        //
        $this->numConsecutivo= $this->factura->local . $this->factura->terminal . $this->tipoComprobante . $this->factura->consecutivo;
        $this->clave= $this->emisor->idCodigoPais . $this->dia . $this->mes . $this->ann . $this->emisor->identificacion . $this->factura->local . $this->factura->terminal . $this->tipoComprobante . $this->factura->consecutivo . $this->factura->idSituacionComprobante . $this->emisor->codigoSeguridad;
    }

    public function CreaXml(){
        // encabezado de factura
        // $header='<FacturaElectronica 
        //      xmlns="https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica" 
        //      xmlns:ds="http://www.w3.org/2000/09/xmldsig#" 
        //      xmlns:vc="http://www.w3.org/2007/XMLSchema-versioning" 
        //      xmlns:xs="http://www.w3.org/2001/XMLSchema">';
        // root.
        $FacturaElectronica = new SimpleXMLElement('<?xml version="1.0" encoding="utf-8"?><FacturaElectronica></FacturaElectronica>');
        // namespace.
        $FacturaElectronica->addAttribute('xmlns', 'https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica');
        $FacturaElectronica->addAttribute('xmlns:ds', 'http://www.w3.org/2000/09/xmldsig#');
        $FacturaElectronica->addAttribute('xmlns:vc', 'http://www.w3.org/2007/XMLSchema-versioning');
        $FacturaElectronica->addAttribute('xmlns:xs', 'http://www.w3.org/2001/XMLSchema');
        //$FacturaElectronica->registerXPathNamespace('xmlns','https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica');
        // info general.
        $FacturaElectronica->addChild('Clave', $this->clave);
        $FacturaElectronica->addChild('NumeroConsecutivo', $this->numConsecutivo);
        $FacturaElectronica->addChild('FechaEmision', $this->factura->fechaEmision);
        // Emisor.
        $Emisor = $FacturaElectronica->addChild('Emisor');
            $Emisor->addChild('Nombre',$this->emisor->nombre);
            $Identificacion = $Emisor->addChild('Identificacion');
                $Identificacion->addChild('Tipo', $this->emisor->tipoIdentificacion);
                $Identificacion->addChild('Numero', $this->emisor->identificacion);
            if($this->emisor->nombreComercial!=null)
                $Emisor->addChild('NombreComercial',$this->emisor->nombreComercial);
            $Ubicacion= $Emisor->addChild('Ubicacion');
                $Ubicacion->addChild('Provincia', $this->emisor->idProvincia);
                $Ubicacion->addChild('Canton', $this->emisor->idCanton);
                $Ubicacion->addChild('Distrito', $this->emisor->idDistrito);
                if($this->emisor->idBarrio!=null)
                    $Ubicacion->addChild('Barrio', $this->emisor->idBarrio);                
                $Ubicacion->addChild('OtrasSenas', $this->emisor->otrasSenas);
            if($this->emisor->numTelefono!=null){
                $Telefono= $Emisor->addChild('Telefono');
                    $Telefono->addChild('CodigoPais', $this->emisor->idcodigopaisTel);
                    $Telefono->addChild('NumTelefono', $this->emisor->numTelefono);
            }
            if($this->emisor->numTelefonoFax!=null){
                $Telefono= $Emisor->addChild('Telefono');
                    $Telefono->addChild('CodigoPais', $this->emisor->codigoPaisFax);
                    $Telefono->addChild('NumTelefono', $this->emisor->numTelefonoFax);
            }
            $Emisor->addChild('CorreoElectronico', $this->emisor->correoElectronico);
        // Receptor.
        $receptor= new Receptor();
        $receptor->Datos($this->factura->idReceptor);
        if($receptor!=null){
            $Receptor = $FacturaElectronica->addChild('Receptor');                
                $Receptor->addChild('Nombre',$receptor->nombre);
                if($receptor->identificacion!=null){
                    $Identificacion = $Receptor->addChild('Identificacion');
                        $Identificacion->addChild('Tipo', $receptor->tipoIdentificacion);
                        $Identificacion->addChild('Numero', $receptor->identificacion);
                }
                if($receptor->ubicacion!=null && $receptor->ubicacion!='0'){
                $Ubicacion= $Receptor->addChild('Ubicacion');
                    $Ubicacion->addChild('Provincia', $receptor->provincia);
                    $Ubicacion->addChild('Canton', $receptor->canton);
                    $Ubicacion->addChild('Distrito', $receptor->distrito);
                    $Ubicacion->addChild('Barrio', $receptor->barrio);
                    $Ubicacion->addChild('OtrasSenas', $receptor->otrasSenas);
                }
                if($receptor->numTelefono!=null){
                    $Telefono= $Receptor->addChild('Telefono');
                        $Telefono->addChild('CodigoPais', $receptor->idCodigoPaisTel);
                        $Telefono->addChild('NumTelefono', $receptor->numTelefono);            
                }
                if($receptor->numTelefonoFax!=null){
                    $Telefono= $Receptor->addChild('Telefono');
                        $Telefono->addChild('CodigoPais', $receptor->codigoPaisFax);
                        $Telefono->addChild('NumTelefono', $receptor->numTelefonoFax);            
                }
                if($receptor->correoElectronico!=null)
                    $Receptor->addChild('CorreoElectronico', $receptor->correoElectronico);
        }
        // CondicionVenta.
        $FacturaElectronica->addChild('CondicionVenta', $this->factura->idCondicionVenta);
        if($this->factura->plazoCredito!=null)
            $FacturaElectronica->addChild('PlazoCredito', $this->factura->plazoCredito); //opt
        $FacturaElectronica->addChild('MedioPago', $this->factura->idMedioPago);
        // Detalle.
        $DetalleServicio= $FacturaElectronica->addChild('DetalleServicio');
            $LineaDetalle= $DetalleServicio->addChild('LineaDetalle');
                $LineaDetalle->addChild('NumeroLinea', $this->detalle->numeroLinea);
                if($this->detalle->codigo!=null){
                    $Codigo= $LineaDetalle->addChild('Codigo'); //opt
                        $Codigo->addChild('Tipo', $this->detalle->tipoCodigo);
                        $Codigo->addChild('Codigo', $this->detalle->codigo);
                }
                $LineaDetalle->addChild('Cantidad', $this->detalle->cantidad);
                $LineaDetalle->addChild('UnidadMedida', $this->detalle->unidadMedida);
                if($this->detalle->unidadMedidaComercial!=null)
                    $LineaDetalle->addChild('UnidadMedidaComercial', $this->detalle->unidadMedidaComercial); //opt
                $LineaDetalle->addChild('Detalle', $this->detalle->detalle);
                $LineaDetalle->addChild('PrecioUnitario', $this->detalle->precioUnitario);
                $LineaDetalle->addChild('MontoTotal', $this->detalle->montoTotal);
                if($this->detalle->montoDescuento!=null){
                    $LineaDetalle->addChild('MontoDescuento', $this->detalle->montoDescuento); // opt
                    $LineaDetalle->addChild('NaturalezaDescuento', $this->detalle->naturalezaDescuento); // opt
                }
                $LineaDetalle->addChild('SubTotal', $this->detalle->subTotal);
                if($this->detalle->codigoImpuesto!=null){
                    $Impuesto=$LineaDetalle->addChild('Impuesto'); // opt
                        $Impuesto->addChild('Codigo', $this->detalle->codigoImpuesto);
                        $Impuesto->addChild('Tarifa', $this->detalle->tarifaImpuesto);
                        $Impuesto->addChild('Monto', $this->detalle->montoImpuesto);
                    if($this->detalle->exoneracionImpuesto!=null){ 
                        $Exoneracion= $Impuesto->addChild('Exoneracion'); // opt
                            $Exoneracion->addChild('TipoDocumento', $this->detalle->tipoDocumento); 
                            $Exoneracion->addChild('NumeroDocumento', $this->detalle->numeroDocumento); 
                            $Exoneracion->addChild('NombreInstitucion', $this->detalle->nombreInstitucion);
                            $Exoneracion->addChild('FechaEmision', $this->detalle->fechaEmision);
                            $Exoneracion->addChild('MontoImpuesto', $this->detalle->montoImpuesto);
                            $Exoneracion->addChild('PorcentajeCompra', $this->detalle->porcentajeCompra);
                    }
                }
                $LineaDetalle->addChild('MontoTotalLinea', $this->detalle->montoTotalLinea);
        // ResumenFactura.
        if($this->factura->resumenFactura!=null && $this->factura->resumenFactura!='0'){
        $ResumenFactura= $FacturaElectronica->addChild('ResumenFactura'); // opt
            $ResumenFactura->addChild('CodigoMoneda');
            $ResumenFactura->addChild('TipoCambio');
            $ResumenFactura->addChild('TotalServGravados');
            $ResumenFactura->addChild('TotalServExentos');
            $ResumenFactura->addChild('TotalMercanciasGravadas');
            $ResumenFactura->addChild('TotalMercanciasExentas');
            $ResumenFactura->addChild('TotalGravado');
            $ResumenFactura->addChild('TotalExento');
            $ResumenFactura->addChild('TotalVenta');
            $ResumenFactura->addChild('TotalDescuentos');
            $ResumenFactura->addChild('TotalVentaNeta');
            $ResumenFactura->addChild('TotalImpuesto');
            $ResumenFactura->addChild('TotalComprobante');
        }
        // InformacionReferencia 
        if($this->factura->codigoReferencia!=null){
            $InformacionReferencia= $FacturaElectronica->addChild('ResumenFactura'); // opt
                $InformacionReferencia->addChild('TipoDoc'); //Tipo. en la tabla documento de referencia
                $InformacionReferencia->addChild('Numero'); // Número de documento de referencia. maxLength value="50"
                $InformacionReferencia->addChild('FechaEmision'); //Fecha y hora de emisión del documento de referencia
                $InformacionReferencia->addChild('Codigo'); // Código de la tabla  referencia.
                $InformacionReferencia->addChild('Razon'); // >Razón de referencia. :maxLength value="180"
        }
        // Normativa.
        $normativa= new Normativa();
        $normativa->Datos();
        $Normativa= $FacturaElectronica->addChild('Normativa');
            $Normativa->addChild('NumeroResolucion', $normativa->numeroResolucion);
            $Normativa->addChild('FechaResolucion', $normativa->fechaResolucion);
        // Otros.
        //
        //
        echo $FacturaElectronica->asXML();
    }

    private function setContingencia(){
        // cambia el valor de situacion comprobante de la factura en: 2
    }
}

?>
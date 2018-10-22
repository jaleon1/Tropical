<?php
    error_log("[INFO] Iniciando Consulta");
    include_once("Conexion.php");
    include_once("facturacionElectronica.php");
    include_once("ClienteFE.php");
    include_once("Receptor.php");
    include_once("Factura.php");
    include_once("encdes.php");
    require_once("ProductoXFactura.php");
    try{
        // Comprobantes 1-4-8.
        $sql='SELECT id
            from factura
            where idEstadoComprobante = 2
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            $factura = new Factura();
            $factura->id = $transaccion['id'];
            $factura = $factura->Read();
            FacturacionElectronica::APIConsultaComprobante($factura);
        }
        // Notas de crédito.
        $sql='SELECT id
            from factura
            where idEstadoNC = 2
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            $factura = new Factura();
            $factura->id = $transaccion['id'];
            $factura = $factura->Read();
            // clave  & idDocumento de NC
            $factura->clave = $factura->claveNC;
            $factura->idDocumento = $factura->idDocumentoNC;
            FacturacionElectronica::APIConsultaComprobante($factura);
        }
    } 
    catch(Exception $e) {
        error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
    }
    error_log("[INFO] Finaliza Consulta de Comprobantes");
?>
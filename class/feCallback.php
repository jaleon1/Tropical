<?php    
    include_once("Conexion.php");
    include_once("facturacionElectronica.php");
    include_once("ClienteFE.php");
    include_once("Distribucion.php");
    include_once("Bodega.php");
    include_once("ProductosXDistribucion.php");
    include_once("Receptor.php");
    include_once("Factura.php");
    include_once("encdes.php");
    require_once("productoXFactura.php");
    try{
        // Comprobantes 1-4-8.
        /*$sql='SELECT id
            from factura
            where idEstadoComprobante = 2
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Iniciando Consulta FE");
            $factura = new Factura();
            $factura->id = $transaccion['id'];
            $factura = $factura->Read();
            FacturacionElectronica::APIConsultaComprobante($factura);
            error_log("[INFO] Finaliza Consulta de Comprobantes");
        }
        // Notas de crédito.
        $sql='SELECT id
            from factura
            where idEstadoNC = 2
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Iniciando Consulta NC");
            $factura = new Factura();
            $factura->id = $transaccion['id'];
            $factura = $factura->Read();
            // clave  & idDocumento de NC
            $factura->clave = $factura->claveNC;
            $factura->idDocumento = $factura->idDocumentoNC;
            FacturacionElectronica::APIConsultaComprobante($factura);
            error_log("[INFO] Finaliza Consulta NC");
        }*/
        // Distribuciones.
        $sql='SELECT id
            from distribucion
            where idEstadoComprobante = 2
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Iniciando Consulta Distribucion");
            $distr = new Distribucion();
            $distr->id = $transaccion['id'];
            $distr = $distr->Read();
            //
            $central = new Bodega();
            $central->readCentral();
            $distr->idEmisor =  $central->id;
            $externa = new Bodega();
            // $externa->ReadbyId($distr["idBodega"]); // bodega receptor.
            if($externa->tipo != $central->tipo){
                $distr->esInterna= false;
                // receptor
                $receptor = new ClienteFE();
                $receptor->idBodega = $distr->idReceptor;
                $distr->datosReceptor = $receptor->read();
                // emisor - Central.
                $entidad = new ClienteFE();
                $entidad->idBodega = $central->id;
                $distr->datosEntidad = $entidad->read();
            }
            // idDocumento.
            $distr->idDocumento = 1;
            facturacionElectronica::APIConsultaComprobante($distr);
            error_log("[INFO] Finaliza Consulta de Distribucion");
        }
    } 
    catch(Exception $e){ 
        error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
    }    
?>
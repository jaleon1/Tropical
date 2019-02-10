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
    require_once("mensajeReceptor.php");
    try{
        // enviar en contingencia
        // Documentos 1-4-8.
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("     [INFO] Iniciando Ejecución AUTOMATICA DE CONTINGENCIA Y CONSULTA     ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql="SELECT f.id, b.nombre as bodega, consecutivo
            from factura f inner join bodega b on b.id = f.idBodega
            WHERE  f.idEstadoComprobante = 5 or f.idEstadoComprobante = 1 and (f.idDocumento = 1 or  f.idDocumento = 4 or  f.idDocumento = 8) 
            ORDER BY consecutivo asc";
        $data = DATA::Ejecutar($sql);
        error_log("[INFO] Total de transacciones en Contingencia: ". count($data));
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Contingencia Bodega (". $transaccion['bodega'] .") Transaccion (".$transaccion['consecutivo'].")");
            $factura = new Factura();
            $factura->id = $transaccion['id'];
            $factura->contingencia();                
        }
        error_log("[INFO] Finaliza Contingencia Masiva de Comprobantes"); 
        // timedout
        // Documentos 1-4-8.
        $sql='SELECT id
            from factura
            where idEstadoComprobante = 6
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Iniciando Consulta FE - TimedOut");
            $factura = new Factura();
            $factura->id = $transaccion['id'];
            $factura = $factura->Read();
            FacturacionElectronica::APIConsultaComprobante($factura);
            error_log("[INFO] Finaliza Consulta de Comprobantes - TimedOut");
        }
        // firma invalida
        // Documentos 1-4-8.
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("              [INFO] Iniciando Consulta FE - Firma Invalida               ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql='SELECT f.id, b.nombre as bodega, consecutivo
            from factura f inner join bodega b on b.id = f.idBodega
            where f.idEstadoComprobante = 8 or f.idEstadoComprobante = 9 or f.idEstadoComprobante = 10 and (f.idDocumento = 1 or  f.idDocumento = 4 or  f.idDocumento = 8) 
            order by f.idBodega';
        $dataFirma= DATA::Ejecutar($sql);
        error_log("[INFO] Total de transacciones Firma Invalida: ". count($dataFirma));
        foreach ($dataFirma as $key => $transaccion){
            error_log("[INFO] Firma Invalida Entidad (". $transaccion['entidad'] .") Transaccion (".$transaccion['consecutivo'].")");
            $factura = new Factura();
            $factura->id = $transaccion['id'];
            $factura = $factura->Read();
            FacturacionElectronica::APIConsultaComprobante($factura, true);
        }
        error_log("[INFO] Finaliza Consulta de Comprobantes - Firma Invalida");
        // Consulta Documentos 1-4-8.
        $sql='SELECT id
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
        // Notas de crédito. Documento 3
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
        }
        // Mensaje Receptor Documentos 5-6-7.
        $sql='SELECT id
            from mensajeReceptor
            where idEstadoComprobante = 2
            order by idReceptor';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Iniciando Consulta MR");
            $factura = new mensajeReceptor();
            $factura->id = $transaccion['id'];
            $factura = $factura->Read();
            $entidad = new ClienteFE();
            $entidad->idBodega = $factura->idReceptor;
            $factura->datosReceptor = $entidad->read();
            $factura->clave = $factura->clave.'-'.$factura->consecutivoFE;
            FacturacionElectronica::APIConsultaComprobante($factura);
            error_log("[INFO] Finaliza Consulta MR");
        }
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
            // emisor - Central.
            $entidad = new ClienteFE();
            $entidad->idBodega = $central->id;
            $distr->datosEntidad = $entidad->read();
            // receptor
            $receptor = new ClienteFE();
            $receptor->idBodega = $distr->idBodega;
            $distr->datosReceptor = $receptor->read();
            // idDocumento.
            $distr->idDocumento = 1;
            FacturacionElectronica::$distr= true;
            facturacionElectronica::APIConsultaComprobante($distr);
            error_log("[INFO] Finaliza Consulta de Distribucion");
        }
    }
    catch(Exception $e){ 
        error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
    }    
?>
<?php    
    if (!isset($_SESSION))
        session_start();
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
    require_once("referencia.php");
    try{
        // enviar en contingencia
        // Documentos 1-4-8.
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("     [INFO] Iniciando Ejecuci0n AUTOMATICA DE CONTINGENCIA Y CONSULTA     ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql="SELECT f.id, b.nombre as bodega, consecutivo
            from factura f inner join bodega b on b.id = f.idBodega
            WHERE  f.idEstadoComprobante = 5  and  (f.idDocumento = 1 or  f.idDocumento = 4 or  f.idDocumento = 8) 
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
        // timedout - Duplicadas
        // Documentos 1-4-8.
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("           [INFO] Iniciando Consulta FE - TimedOut | Duplicadas           ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql='SELECT id
            from factura f
            where idEstadoComprobante = 6 or f.idEstadoComprobante = 7
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Iniciando Consulta FE - TimedOut | Duplicadas");
            $factura = new Factura();
            $factura->id = $transaccion['id'];
            $factura = $factura->Read();
            FacturacionElectronica::APIConsultaComprobante($factura);
            error_log("[INFO] Finaliza Consulta de Comprobantes - TimedOut | Duplicadas");
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
            error_log("[INFO] Firma Invalida Bodega (". $transaccion['bodega'] .") Transaccion (".$transaccion['consecutivo'].")");
            $factura = new Factura();
            $factura->id = $transaccion['id'];
            $factura = $factura->Read();
            FacturacionElectronica::APIConsultaComprobante($factura, true);
        }
        error_log("[INFO] Finaliza Consulta de Comprobantes - Firma Invalida");
        // Consulta Documentos 1-4-8.
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("                      [INFO] Iniciando Consulta FE                        ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
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
        // nota de credito. reenvio.
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("                        [INFO] Iniciando Reenvio NC                       ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql='SELECT id
            from factura
            where idEstadoNC = 5
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Iniciando Reenvio NC");
            $factura = new Factura();
            $factura->id = $transaccion['id'];
            $factura = $factura->Read();
            //
            FacturacionElectronica::iniciarNC($factura);            
        }
        error_log("[INFO] Finaliza Reenvio NC");
        // timedout - Duplicadas NC
        // Documentos 3 estados 6 - 7
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("           [INFO] Iniciando Consulta NC - TimedOut | Duplicadas           ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql='SELECT id
            from factura f
            where idEstadoNC = 6 or f.idEstadoNC = 7
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Iniciando Consulta NC - TimedOut | Duplicadas");
            $factura = new Factura();
            $factura->id = $transaccion['id'];
            $factura = $factura->Read();
            // clave  & idDocumento de NC
            $factura->clave = $factura->claveNC;
            $factura->idDocumento = $factura->idDocumentoNC;
            FacturacionElectronica::APIConsultaComprobante($factura);            
        }
        error_log("[INFO] Finaliza Consulta de NC - TimedOut | Duplicadas");
        // Notas de credito. Documento 3
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("                        [INFO] Iniciando Consulta NC                      ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
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
        }
        error_log("[INFO] Finaliza Consulta NC");
        // Reenvio de MR en estado 5
        // Documentos 5-6-7.
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("                    [INFO] Iniciando REENVIO DE MR                        ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql="SELECT f.id, b.nombre as bodega, consecutivo, idReceptor
            from mensajeReceptor f inner join bodega b on b.id = f.idReceptor
            WHERE  f.idEstadoComprobante = 5
            ORDER BY consecutivo asc";
        $data = DATA::Ejecutar($sql);
        error_log("[INFO] Total de MR a Reenviar: ". count($data));
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Reenvio MR (". $transaccion['bodega'] .") Transaccion (".$transaccion['consecutivo'].")");
            $mr = new mensajeReceptor();
            $mr->id = $transaccion['id'];
            $mr->entidad = new ClienteFE();
            $mr->entidad->idBodega = $transaccion['idReceptor'];;
            $mr->datosReceptor = $mr->entidad->read();
            $mr->enviar();
        }
        error_log("[INFO] Finaliza Contingencia Masiva de Comprobantes"); 
        // Mensaje Receptor Documentos 5-6-7.
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("                      [INFO] Iniciando Consulta MR                        ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
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
        // ******************************************************************************************* /
        // ******************************************************************************************* /
        // ******************************************************************************************* /
        // ************************************ Distribucion *****************************************
        // ******************************************************************************************* /
        // ******************************************************************************************* /
        // ******************************************************************************************* /
        // enviar en contingencia DISTRIBUCION
        // Documentos 1-4-8.
        // datos de bodega central.
        $central = new Bodega();
        $central->readCentral();
        $entidad = new ClienteFE();
        $entidad->idBodega = $central->id;
        $emisorCentral = $entidad->read();
        //
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("           [INFO] Iniciando Ejecuci0n AUTOMATICA DE DISTRIBUCION          ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql="SELECT d.id, b.nombre as bodega, orden
            from distribucion d inner join bodega b on b.id = d.idBodega
            WHERE  d.idEstadoComprobante = 5
            ORDER BY orden asc";
        $data = DATA::Ejecutar($sql);
        error_log("[INFO] Total de Distribuciones en Contingencia: ". count($data));
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Distribucion - Contingencia Bodega (". $transaccion['bodega'] .") Orden (".$transaccion['orden'].")");
            $distr = new Distribucion();
            $distr->id = $transaccion['id'];
            $distr->contingencia();         
        }
        error_log("[INFO] Finaliza Contingencia Masiva de Distribucion - Comprobantes"); 
        // distribucion timedout - Duplicadas
        // Documentos 1-4-8.
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("   [INFO] Iniciando Consulta Distribucion - TimedOut | Duplicadas         ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql='SELECT id
            from distribucion d
            where idEstadoComprobante = 6 or d.idEstadoComprobante = 7
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Iniciando Consulta Distribucion - TimedOut | Duplicadas");
            $distr = new Distribucion();
            $distr->id = $transaccion['id'];
            $distr = $distr->Read();
            // emisor Central
            $distr->datosEntidad = $emisorCentral;
            $distr->idEmisor = $central->id;
            // receptor bodega externa
            $receptor = new ClienteFE();
            $receptor->idBodega = $distr->idBodega; // idBodega = bodega externa.
            $distr->datosReceptor = $receptor->read();
            // idDocumento.
            // $distr->idDocumento = 1;
            FacturacionElectronica::$distr= true;
            FacturacionElectronica::APIConsultaComprobante($distr, true);
            error_log("[INFO] Finaliza Consulta de Disctribucion - Comprobantes - TimedOut | Duplicadas");
        }
        // Distribucion firma invalida
        // Documentos 1-4-8.
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("          [INFO] Iniciando Consulta Distribucion - Firma Invalida         ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql='SELECT d.id, b.nombre as bodega, orden
            from distribucion d inner join bodega b on b.id = d.idBodega
            where d.idEstadoComprobante = 8 or d.idEstadoComprobante = 9 or d.idEstadoComprobante = 10 
            order by d.idBodega';
        $dataFirma= DATA::Ejecutar($sql);
        error_log("[INFO] Total de distribucion -  Firma Invalida: ". count($dataFirma));
        foreach ($dataFirma as $key => $transaccion){
            error_log("[INFO] Firma Invalida Bodega (". $transaccion['bodega'] .") Transaccion (".$transaccion['orden'].")");
            $distr = new Distribucion();
            $distr->id = $transaccion['id'];
            $distr = $distr->Read();
            // emisor Central
            $distr->datosEntidad = $emisorCentral;
            $distr->idEmisor = $central->id;
            // receptor bodega externa
            $receptor = new ClienteFE();
            $receptor->idBodega = $distr->idBodega; // idBodega = bodega externa.
            $distr->datosReceptor = $receptor->read();
            // idDocumento.
            // $distr->idDocumento = 1;
            FacturacionElectronica::$distr= true;
            FacturacionElectronica::APIConsultaComprobante($distr, true); // debe enviar email.
        }
        error_log("[INFO] Finaliza Consulta de Distribucion - Comprobantes - Firma Invalida");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("              [INFO] Iniciando Consulta FE - Distribucion                 ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
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
            // emisor - Central.         
            $distr->datosEntidad = $emisorCentral;
            $distr->idEmisor = $central->id;
            // receptor
            $receptor = new ClienteFE();
            $receptor->idBodega = $distr->idBodega;
            $distr->datosReceptor = $receptor->read();
            // idDocumento.
            $distr->idDocumento = 1;
            $distr->consecutivo = $distr->orden;
            FacturacionElectronica::$distr= true;
            facturacionElectronica::APIConsultaComprobante($distr, true); // debe enviar email.
            error_log("[INFO] Finaliza Consulta de Distribucion");
        }
        // nota de credito. reenvio. DISTR.
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("                   [INFO] Iniciando Reenvio NC  - DISTRIBUCION            ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql="SELECT d.id, b.nombre as bodega, orden
            from distribucion d inner join bodega b on b.id = d.idBodega
            WHERE  d.idEstadoNC = 5 
            ORDER BY orden asc";
        $data = DATA::Ejecutar($sql);
        error_log("[INFO] Total de Distribuciones NC en Contingencia: ". count($data));
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Distribucion - Contingencia - NC Bodega (". $transaccion['bodega'] .") Orden (".$transaccion['orden'].")");
            $distr = new Distribucion();
            $distr->id = $transaccion['id'];
            // idDocumento.
            $distr->idDocumento = 3;
            $distr->contingencia();         
        }
        error_log("[INFO] Finaliza Reenvio NC  - DISTRIBUCION");
        // timedout - Duplicadas NC - DISTR
        // Documentos 3 estados 6 - 7
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("   [INFO] Iniciando Consulta Distribucion - TimedOut | Duplicadas - NC    ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql='SELECT id
            from distribucion d
            where idEstadoNC = 6 or d.idEstadoNC = 7
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Iniciando Consulta Distribucion - TimedOut | Duplicadas - NC");
            $distr = new Distribucion();
            $distr->id = $transaccion['id'];
            $distr = $distr->Read();
            // emisor Central
            $distr->datosEntidad = $emisorCentral;
            $distr->idEmisor = $central->id;
            // receptor bodega externa
            $receptor = new ClienteFE();
            $receptor->idBodega = $distr->idBodega; // idBodega = bodega externa.
            $distr->datosReceptor = $receptor->read();
            // idDocumento.
            $distr->idDocumento = 3;
            FacturacionElectronica::$distr= true;
            FacturacionElectronica::APIConsultaComprobante($distr);
            error_log("[INFO] Finaliza Consulta de Disctribucion - Comprobantes - TimedOut | Duplicadas");
        }
        error_log("[INFO] Finaliza Consulta de NC - TimedOut | Duplicadas");
        // Notas de credito. Documento 3
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("           [INFO] Iniciando Consulta NC - DISTRIBUCION                    ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        $sql='SELECT id
            from distribucion
            where idEstadoNC = 2
            order by idBodega';
        $data= DATA::Ejecutar($sql);
        foreach ($data as $key => $transaccion){
            error_log("[INFO] Iniciando Consulta NC Distribucion");
            $distr = new Distribucion();
            $distr->id = $transaccion['id'];
            $distr = $distr->Read();
            // emisor - Central.         
            $distr->datosEntidad = $emisorCentral;
            $distr->idEmisor = $central->id;
            // receptor
            $receptor = new ClienteFE();
            $receptor->idBodega = $distr->idBodega;
            $distr->datosReceptor = $receptor->read();
            // idDocumento.
            $distr->idDocumento = 3;
            $distr->consecutivo = $distr->orden;
            FacturacionElectronica::$distr= true;
            facturacionElectronica::APIConsultaComprobante($distr); // debe enviar email.
            error_log("[INFO] Finaliza Consulta de Distribucion");
        }
        error_log("[INFO] Finaliza Consulta NC - DISTR");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
        error_log("                         [INFO] FINALIZA CALLBACK  FE                     ");
        error_log("**************************************************************************");
        error_log("**************************************************************************");
    }
    catch(Exception $e){ 
        error_log("[ERROR]  (".$e->getCode()."): ". $e->getMessage());
    }    
?>
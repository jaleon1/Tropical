CREATE DATABASE  IF NOT EXISTS `tropical` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `tropical`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 104.131.5.198    Database: tropical
-- ------------------------------------------------------
-- Server version	5.5.56-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bodega`
--

DROP TABLE IF EXISTS `bodega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bodega` (
  `id` char(36) NOT NULL,
  `idTipoBodega` char(36) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(400) DEFAULT NULL,
  `ubicacion` varchar(400) DEFAULT NULL,
  `contacto` varchar(400) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bodega_tipoBodega1_idx` (`idTipoBodega`),
  CONSTRAINT `fk_bodega_tipoBodega1` FOREIGN KEY (`idTipoBodega`) REFERENCES `tipoBodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bodega`
--

LOCK TABLES `bodega` WRITE;
/*!40000 ALTER TABLE `bodega` DISABLE KEYS */;
/*!40000 ALTER TABLE `bodega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clienteFE`
--

DROP TABLE IF EXISTS `clienteFE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clienteFE` (
  `id` char(36) NOT NULL,
  `codigoSeguridad` varchar(8) NOT NULL,
  `idCodigoPais` int(11) NOT NULL,
  `nombre` varchar(80) NOT NULL COMMENT 'Nombre o razon social',
  `idTipoIdentificacion` int(11) NOT NULL COMMENT 'FISICA\nJURIDICA\nDIMEX\nNITE',
  `identificacion` varchar(15) NOT NULL,
  `nombreComercial` varchar(80) DEFAULT NULL,
  `idProvincia` int(11) NOT NULL,
  `idCanton` int(11) NOT NULL,
  `idDistrito` int(11) NOT NULL,
  `idBarrio` int(11) DEFAULT NULL,
  `otrasSenas` varchar(160) NOT NULL,
  `idCodigoPaisTel` int(11) DEFAULT NULL,
  `numTelefono` varchar(20) DEFAULT NULL,
  `idCodigoPaisFax` char(11) DEFAULT NULL,
  `numTelefonoFax` varchar(20) DEFAULT NULL,
  `correoElectronico` varchar(150) DEFAULT NULL COMMENT ' \\s*\\w+([-+.'']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\\s* ',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienteFE`
--

LOCK TABLES `clienteFE` WRITE;
/*!40000 ALTER TABLE `clienteFE` DISABLE KEYS */;
INSERT INTO `clienteFE` VALUES ('1f85f425-1c4b-4212-9d97-72e413cffb3c','91239911',506,'Gustavo Reyes',1,'000','Tropical Sno',1,1,1,1,'Guadalupe',1,'',NULL,NULL,'');
/*!40000 ALTER TABLE `clienteFE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `condicionVenta`
--

DROP TABLE IF EXISTS `condicionVenta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `condicionVenta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `condicionVenta` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `condicionVenta`
--

LOCK TABLES `condicionVenta` WRITE;
/*!40000 ALTER TABLE `condicionVenta` DISABLE KEYS */;
INSERT INTO `condicionVenta` VALUES (1,'01','Contado'),(2,'02','Crédito'),(3,'03','Consignación'),(4,'04','Apartado'),(5,'05','Arrendamiento con opción de compra'),(6,'06','Arrendamiento en función financiera'),(7,'99','Otro');
/*!40000 ALTER TABLE `condicionVenta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalleOrden`
--

DROP TABLE IF EXISTS `detalleOrden`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `detalleOrden` (
  `id` char(36) NOT NULL,
  `tamano` tinyint(1) NOT NULL DEFAULT '0',
  `idFactura` char(36) NOT NULL,
  `idSabor2` char(36) NOT NULL,
  `idTopping` char(36) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_detalleOrden_factura1_idx` (`idFactura`),
  CONSTRAINT `fk_detalleOrden_factura1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de la orden vendida, tamaño, sabores, toppin';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalleOrden`
--

LOCK TABLES `detalleOrden` WRITE;
/*!40000 ALTER TABLE `detalleOrden` DISABLE KEYS */;
/*!40000 ALTER TABLE `detalleOrden` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `distribucion`
--

DROP TABLE IF EXISTS `distribucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distribucion` (
  `id` char(36) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `orden` int(11) DEFAULT '0',
  `idUsuario` char(36) NOT NULL,
  `idBodega` char(36) NOT NULL,
  `porcentajeDescuento` decimal(5,2) NOT NULL DEFAULT '0.00',
  `porcentajeIva` decimal(5,2) DEFAULT '0.00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_distribucion_usuario1_idx` (`idUsuario`),
  KEY `fk_distribucion_bodega1_idx` (`idBodega`),
  CONSTRAINT `fk_distribucion_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_distribucion_bodega1` FOREIGN KEY (`idBodega`) REFERENCES `bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distribucion`
--

LOCK TABLES `distribucion` WRITE;
/*!40000 ALTER TABLE `distribucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `distribucion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`storydb`@`%`*/ /*!50003 TRIGGER `tropical`.`distribucion_BEFORE_INSERT` BEFORE INSERT ON `distribucion` FOR EACH ROW
BEGIN
	-- ultima orden
	SELECT orden
	INTO @nnumeroorden
	FROM distribucion
	ORDER BY orden DESC LIMIT 1;
    IF @nnumeroorden IS NULL then
		set @nnumeroorden=0;
	END IF;
	-- asigna nuevo valor    
	SET NEW.orden = @nnumeroorden+1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `documentoExoneracionAutorizacion`
--

DROP TABLE IF EXISTS `documentoExoneracionAutorizacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentoExoneracionAutorizacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `documento` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentoExoneracionAutorizacion`
--

LOCK TABLES `documentoExoneracionAutorizacion` WRITE;
/*!40000 ALTER TABLE `documentoExoneracionAutorizacion` DISABLE KEYS */;
INSERT INTO `documentoExoneracionAutorizacion` VALUES (1,'01','Compras autorizadas'),(2,'02','Ventas exentas a diplomáticos'),(3,'03','Orden de compra (Instituciones públicas y otros organismos)'),(4,'04','Exenciones Dirección General de Hacienda'),(5,'05','Zonas Francas'),(6,'99','Otro');
/*!40000 ALTER TABLE `documentoExoneracionAutorizacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `documentoReferencia`
--

DROP TABLE IF EXISTS `documentoReferencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `documentoReferencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `documento` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `documentoReferencia`
--

LOCK TABLES `documentoReferencia` WRITE;
/*!40000 ALTER TABLE `documentoReferencia` DISABLE KEYS */;
INSERT INTO `documentoReferencia` VALUES (1,'01','Factura Electrónica'),(2,'02','Nota de débito electrónica'),(3,'03','Nota de crédito electrónica'),(4,'04','Tiquete electrónico'),(5,'05','Nota de despacho'),(6,'06','Contrato'),(7,'07','Procedimiento'),(8,'08','Comprobante emitido en contingencia'),(9,'99','Otro');
/*!40000 ALTER TABLE `documentoReferencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estado`
--

DROP TABLE IF EXISTS `estado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estado` (
  `id` char(36) NOT NULL,
  `nombre` varchar(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estado`
--

LOCK TABLES `estado` WRITE;
/*!40000 ALTER TABLE `estado` DISABLE KEYS */;
INSERT INTO `estado` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','EN PROCESO'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a61','LIQUIDADO');
/*!40000 ALTER TABLE `estado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estadoComprobante`
--

DROP TABLE IF EXISTS `estadoComprobante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `estadoComprobante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estadoComprobante`
--

LOCK TABLES `estadoComprobante` WRITE;
/*!40000 ALTER TABLE `estadoComprobante` DISABLE KEYS */;
INSERT INTO `estadoComprobante` VALUES (1,'01','Sin enviar'),(2,'02','Enviado'),(3,'03','Aceptado'),(4,'04','Rechazado'),(5,'99','Otros');
/*!40000 ALTER TABLE `estadoComprobante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `evento`
--

DROP TABLE IF EXISTS `evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `evento` (
  `id` char(36) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `url` varchar(400) NOT NULL,
  `menuPadre` varchar(100) DEFAULT 'home',
  `subMenuPadre` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','Dashboard','Dashboard.html','Bodega',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','Producto','Producto.html','Inventario',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','Inventario de Productos','InventarioProducto.html','Inventario',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','Factura de Productos','FacturaCli.html','Facturacion',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','Inventario de Facturas','InventarioFactura.html','Facturacion',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','Nuevo Usuario','Usuario.html','Sistema',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','Inventario de Usuarios','InventarioUsuario.html','Sistema',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','Nuevo Rol','Rol.html','Sistema',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','Inventario de Roles','InventarioRol.html','Sistema',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','Insumo','Insumo.html','Inventario',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','Inventario de Insumos','InventarioInsumo.html','Inventario',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','Elaborar Producto','ElaborarProducto.html','Inventario',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','Bodega','Bodega.html','Bodega',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','Lista de Bodegas','InventarioBodega.html','Bodega',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','Distribución','Distribucion.html','Bodega',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','Orden de Compra','OrdenCompra.html','Inventario',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','Orden de Salida','OrdenSalida.html','Inventario',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','Inventario Orden Salida','InventarioOrdenSalida.html','Inventario',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','Aceptar Distribucion','AceptarDistribucion.html','Bodega',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','Ip','ip.html','Sistema',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','Inventario Ip','InventarioIp.html','Sistema',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','Determinacion de Precios','DeterminacionPrecio.html','Inventario',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','Determinacion de Precios Ventas','DeterminacionPrecioVenta.html','Inventario',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','Inventario de Bodega','InsumosBodega.html','Inventario',NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','Fabricar','Fabricar.html','Facturacion',NULL);
/*!40000 ALTER TABLE `evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventosXRol`
--

DROP TABLE IF EXISTS `eventosXRol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eventosXRol` (
  `idEvento` char(36) NOT NULL,
  `idRol` char(36) NOT NULL,
  PRIMARY KEY (`idEvento`,`idRol`),
  KEY `fk_eventosXRol_rol1_idx` (`idRol`),
  CONSTRAINT `fk_eventosXRol_evento1` FOREIGN KEY (`idEvento`) REFERENCES `evento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_eventosXRol_rol1` FOREIGN KEY (`idRol`) REFERENCES `rol` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventosXRol`
--

LOCK TABLES `eventosXRol` WRITE;
/*!40000 ALTER TABLE `eventosXRol` DISABLE KEYS */;
INSERT INTO `eventosXRol` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','1ed3a48c-3e44-11e8-9ddb-54ee75873a80');
/*!40000 ALTER TABLE `eventosXRol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `factura` (
  `id` char(36) NOT NULL,
  `fechaCreacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `consecutivo` varchar(10) NOT NULL DEFAULT '0' COMMENT 'debe tener un trigger para aumentar su valor',
  `local` varchar(3) NOT NULL,
  `terminal` varchar(5) NOT NULL,
  `idCondicionVenta` int(11) NOT NULL,
  `idSituacionComprobante` int(11) NOT NULL DEFAULT '1',
  `idEstadoComprobante` char(11) NOT NULL DEFAULT '1',
  `plazoCredito` varchar(10) DEFAULT NULL,
  `idMedioPago` int(11) NOT NULL,
  `resumenFactura` tinyint(1) DEFAULT NULL,
  `idCodigoMoneda` int(11) DEFAULT NULL,
  `tipoCambio` decimal(18,5) DEFAULT NULL,
  `totalServGravados` decimal(18,5) DEFAULT NULL,
  `totalServExentos` decimal(18,5) DEFAULT NULL,
  `totalMercanciasGravadas` decimal(18,5) DEFAULT NULL,
  `totalMercanciaSexentas` decimal(18,5) DEFAULT NULL,
  `totalGravado` decimal(18,5) DEFAULT NULL,
  `totalExento` decimal(18,5) DEFAULT NULL,
  `fechaEmision` varchar(45) NOT NULL COMMENT 'Estandar:\n\n\nEj: usando ''T''\n2018-06-30T16:30:05-06:00',
  `codigoReferencia` int(11) DEFAULT NULL,
  `totalVenta` decimal(18,5) NOT NULL,
  `totalDescuentos` decimal(18,5) NOT NULL,
  `totalVentaneta` decimal(18,5) NOT NULL,
  `totalImpuesto` decimal(18,5) NOT NULL,
  `totalComprobante` decimal(18,5) NOT NULL,
  `idReceptor` char(36) DEFAULT NULL,
  `idEmisor` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_factura_clienteFE1_idx` (`idEmisor`),
  KEY `fk_factura_receptor1_idx` (`idReceptor`),
  KEY `fk_factura_medioPago1_idx` (`idMedioPago`),
  KEY `fk_factura_situacionComprobante1_idx` (`idSituacionComprobante`),
  KEY `fk_factura_moneda1_idx` (`idCodigoMoneda`),
  KEY `fk_factura_condicionVenta1_idx` (`idCondicionVenta`),
  KEY `fk_factura_estadoComprobante1_idx` (`idEstadoComprobante`),
  CONSTRAINT `fk_factura_clienteFE1` FOREIGN KEY (`idEmisor`) REFERENCES `clienteFE` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_condicionVenta1` FOREIGN KEY (`idCondicionVenta`) REFERENCES `condicionVenta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_estadoComprobante1` FOREIGN KEY (`idEstadoComprobante`) REFERENCES `estadoComprobante` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_medioPago1` FOREIGN KEY (`idMedioPago`) REFERENCES `medioPago` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_moneda1` FOREIGN KEY (`idCodigoMoneda`) REFERENCES `moneda` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_receptor1` FOREIGN KEY (`idReceptor`) REFERENCES `receptor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_situacionComprobante1` FOREIGN KEY (`idSituacionComprobante`) REFERENCES `situacionComprobante` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='facturas de ventas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`storydb`@`%`*/ /*!50003 TRIGGER `tropical`.`factura_BEFORE_INSERT` BEFORE INSERT ON `factura` FOR EACH ROW
BEGIN
	-- ultima orden
	SELECT consecutivo
	INTO @nnumeroconsecutivo
	FROM factura
	ORDER BY consecutivo DESC LIMIT 1;
    IF @nnumeroconsecutivo IS NULL then
		set @nnumeroconsecutivo=0;
	END IF;
	-- asigna nuevo valor    
	SET NEW.consecutivo = @nnumeroconsecutivo+1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `impuesto`
--

DROP TABLE IF EXISTS `impuesto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `impuesto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `tipo` int(1) DEFAULT NULL COMMENT '1: Impuesto 2: Excepciones',
  `valor` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `impuesto`
--

LOCK TABLES `impuesto` WRITE;
/*!40000 ALTER TABLE `impuesto` DISABLE KEYS */;
INSERT INTO `impuesto` VALUES (1,'01','Impuesto General sobre las Ventas',1,NULL),(2,'02','Impuesto Selectivo de Consumo',1,NULL),(3,'03','Impuesto Único a los combustibles',1,NULL),(4,'04','Impuesto específico de Bebidas Alcohólicas',1,NULL),(5,'05','Impuesto Específico sobre las bebidas envasadas sin contenido alcohólico y jabones de tocador',1,NULL),(6,'06','Impuesto a los Productos de Tabaco',1,NULL),(7,'07','Servicio',1,NULL),(8,'12','Impuesto Específico al Cemento',1,NULL),(9,'98','Otros',1,NULL),(10,'08','Impuesto General sobre las Ventas Diplomáticas',2,NULL),(11,'09','Impuesto General sobre las Ventas Compras Autorizadas',2,NULL),(12,'10','Impuesto General sobre las Ventas Instituciones Públicas y otros Organismos',2,NULL),(13,'11','Impuesto Selectivo de Consumo Compras Autorizadas',2,NULL),(14,'99','Otros',2,NULL);
/*!40000 ALTER TABLE `impuesto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumo`
--

DROP TABLE IF EXISTS `insumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insumo` (
  `id` char(36) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `saldoCantidad` decimal(10,0) NOT NULL,
  `saldoCosto` decimal(20,10) NOT NULL,
  `costoPromedio` decimal(20,10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `indexID` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Insumos para la elaboración de productos o que forman parte de la cadena de materiales. Materiales directos o indirectos.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumo`
--

LOCK TABLES `insumo` WRITE;
/*!40000 ALTER TABLE `insumo` DISABLE KEYS */;
/*!40000 ALTER TABLE `insumo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumosXBodega`
--

DROP TABLE IF EXISTS `insumosXBodega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insumosXBodega` (
  `id` char(36) NOT NULL,
  `idProducto` char(36) NOT NULL,
  `idBodega` char(36) NOT NULL,
  `saldoCantidad` decimal(10,0) NOT NULL,
  `saldoCosto` decimal(20,10) NOT NULL,
  `costoPromedio` decimal(20,10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_insumosXBodega_bodega1_idx` (`idBodega`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='insumos para la elaboración del producto final facturable al cliente';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumosXBodega`
--

LOCK TABLES `insumosXBodega` WRITE;
/*!40000 ALTER TABLE `insumosXBodega` DISABLE KEYS */;
/*!40000 ALTER TABLE `insumosXBodega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumosXOrdenCompra`
--

DROP TABLE IF EXISTS `insumosXOrdenCompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insumosXOrdenCompra` (
  `id` char(36) NOT NULL,
  `idOrdenCompra` char(36) NOT NULL,
  `idInsumo` char(36) NOT NULL,
  `costoUnitario` decimal(20,10) NOT NULL COMMENT 'valor unitario del producto (precio del proveedor)',
  `cantidadBueno` decimal(10,0) NOT NULL,
  `cantidadMalo` decimal(10,0) NOT NULL,
  `valorBueno` decimal(20,10) NOT NULL COMMENT 'Cuanto cuesta ',
  `valorMalo` decimal(20,10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_insumosXOrdenCompra_insumo1_idx` (`idInsumo`),
  KEY `fk_insumosXOrdenCompra_ordenCompra1_idx` (`idOrdenCompra`),
  CONSTRAINT `fk_insumosXOrdenCompra_ordenCompra1` FOREIGN KEY (`idOrdenCompra`) REFERENCES `ordenCompra` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumosXOrdenCompra_insumo1` FOREIGN KEY (`idInsumo`) REFERENCES `insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Almacena historial de Ordenes de compra o Facturas del proveedor y el valor historico original de los items comprados.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumosXOrdenCompra`
--

LOCK TABLES `insumosXOrdenCompra` WRITE;
/*!40000 ALTER TABLE `insumosXOrdenCompra` DISABLE KEYS */;
/*!40000 ALTER TABLE `insumosXOrdenCompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumosXOrdenCompraXBodega`
--

DROP TABLE IF EXISTS `insumosXOrdenCompraXBodega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insumosXOrdenCompraXBodega` (
  `id` char(36) NOT NULL,
  `idOrdenCompraBodega` char(36) NOT NULL,
  `idInsumo` char(36) NOT NULL,
  `costoUnitario` decimal(20,10) NOT NULL COMMENT 'valor unitario del producto (precio del proveedor)',
  `cantidadBueno` decimal(10,0) NOT NULL,
  `cantidadMalo` decimal(10,0) NOT NULL,
  `valorBueno` decimal(20,10) NOT NULL COMMENT 'Cuanto cuesta ',
  `valorMalo` decimal(20,10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_insumosXOrdenCompraXBodega_ordenCompraXBodega1_idx` (`idOrdenCompraBodega`),
  KEY `fk_insumosXOrdenCompraXBodega_producto1_idx` (`idInsumo`),
  CONSTRAINT `fk_insumosXOrdenCompraXBodega_ordenCompraXBodega1` FOREIGN KEY (`idOrdenCompraBodega`) REFERENCES `ordenCompraXBodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumosXOrdenCompraXBodega_producto1` FOREIGN KEY (`idInsumo`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='detalle de la orden de compra de la bodega. ';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumosXOrdenCompraXBodega`
--

LOCK TABLES `insumosXOrdenCompraXBodega` WRITE;
/*!40000 ALTER TABLE `insumosXOrdenCompraXBodega` DISABLE KEYS */;
/*!40000 ALTER TABLE `insumosXOrdenCompraXBodega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insumosXOrdenSalida`
--

DROP TABLE IF EXISTS `insumosXOrdenSalida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insumosXOrdenSalida` (
  `id` char(36) NOT NULL,
  `idOrdenSalida` char(36) NOT NULL,
  `idInsumo` char(36) NOT NULL,
  `cantidad` decimal(10,0) NOT NULL,
  `costoPromedio` decimal(20,10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_insumosXOrdenSalida_ordenSalida1_idx` (`idOrdenSalida`),
  KEY `fk_insumosXOrdenSalida_insumo1_idx` (`idInsumo`),
  CONSTRAINT `fk_insumosXOrdenSalida_ordenSalida1` FOREIGN KEY (`idOrdenSalida`) REFERENCES `ordenSalida` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumosXOrdenSalida_insumo1` FOREIGN KEY (`idInsumo`) REFERENCES `insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumosXOrdenSalida`
--

LOCK TABLES `insumosXOrdenSalida` WRITE;
/*!40000 ALTER TABLE `insumosXOrdenSalida` DISABLE KEYS */;
/*!40000 ALTER TABLE `insumosXOrdenSalida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipAutorizada`
--

DROP TABLE IF EXISTS `ipAutorizada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipAutorizada` (
  `ip` char(15) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipAutorizada`
--

LOCK TABLES `ipAutorizada` WRITE;
/*!40000 ALTER TABLE `ipAutorizada` DISABLE KEYS */;
INSERT INTO `ipAutorizada` VALUES ('10.129.29.217','2018-07-07 16:13:54'),('10.129.29.48','2018-07-16 04:25:49'),('10.129.29.85','2018-07-12 20:45:58'),('10.129.6.48','2018-07-16 04:26:21'),('10.129.6.59','2018-07-12 20:47:01'),('10.34.164.24','2018-07-05 19:50:17'),('10.34.165.15','2018-07-05 20:08:03'),('190.7.197.205','2018-07-08 01:10:49'),('192.168.0.14','2018-07-14 01:50:22'),('192.168.1.120','2018-07-07 00:27:25'),('192.168.1.123','2018-07-07 00:36:27'),('192.168.1.155','2018-07-07 00:37:20'),('192.168.1.18','2018-07-07 23:28:50'),('192.168.1.8','2018-07-07 23:28:50'),('192.168.1.81','2018-07-14 18:22:32'),('192.168.43.235','2018-07-08 01:10:49');
/*!40000 ALTER TABLE `ipAutorizada` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medioPago`
--

DROP TABLE IF EXISTS `medioPago`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medioPago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `medioPago` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medioPago`
--

LOCK TABLES `medioPago` WRITE;
/*!40000 ALTER TABLE `medioPago` DISABLE KEYS */;
INSERT INTO `medioPago` VALUES (1,'01','Efectivo'),(2,'02','Tarjeta'),(3,'03','Cheque'),(4,'04','Transferencia - depósito bancario'),(5,'05','Recaudo por terceros'),(6,'99','Otro');
/*!40000 ALTER TABLE `medioPago` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `moneda`
--

DROP TABLE IF EXISTS `moneda`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `moneda` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pais` varchar(150) DEFAULT NULL,
  `moneda` varchar(100) DEFAULT NULL,
  `codigo` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=269 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `moneda`
--

LOCK TABLES `moneda` WRITE;
/*!40000 ALTER TABLE `moneda` DISABLE KEYS */;
INSERT INTO `moneda` VALUES (1,'AFGANISTÁN','Afghani','AFN'),(2,'ALBANIA','Lek','ALL'),(3,'ALEMANIA','Euro','EUR'),(4,'ALGERIA','Dinar argelino','DZD'),(5,'ANDORRA','Euro','EUR'),(6,'ANGOLA','Kwanza','AOA'),(7,'ANGUILA','Dólar del Caribe Oriental','XCD'),(8,'ANTIGUA Y BARBUDA','Dólar del Caribe Oriental','XCD'),(9,'ANTÁRTIDA','Sin moneda universal',''),(10,'ARABIA SAUDITA','Riyal saudí','SAR'),(11,'ARGENTINA','Peso Argentino','ARS'),(12,'ARMENIA','Dram armenio','AMD'),(13,'ARUBA','Florín arubeño','AWG'),(14,'AUSTRALIA','Dólar australiano','AUD'),(15,'AUSTRIA','Euro','EUR'),(16,'AZERBAIYÁN','Manat azerbaiyano','AZN'),(17,'BAHAMAS (LAS)','Dólar de las Bahamas','BSD'),(18,'BAHRAIN','Dinar de Bahrein','BHD'),(19,'BANGLADESH','Taka','BDT'),(20,'BARBADOS','Dólar de Barbados','BBD'),(21,'BELICE','Dólar de Belice','BZD'),(22,'BENIN','Franco CFA BCEAO','XOF'),(23,'BERMUDA','Dólar de Bermudas','BMD'),(24,'BIELORRUSIA','Rublo bielorruso','BYR'),(25,'BOLIVIA (ESTADO PLURINACIONAL DE)','Boliviano','BOB'),(26,'BOLIVIA (ESTADO PLURINACIONAL DE)','Mvdol','BOV'),(27,'BONAIRE SAN EUSTAQUIO Y SABA','Dólar Americano','USD'),(28,'BOSNIA Y HERZEGOVINA','Marco bosnioherzegovino','BAM'),(29,'BOTSWANA','Pula','BWP'),(30,'BRASIL','Real Brasileño','BRL'),(31,'BRUNEI DARUSSALAM','Dólar de Brunei','BND'),(32,'BULGARIA','Lev búlgaro','BGN'),(33,'BURKINA FASO','Franco CFA BCEAO','XOF'),(34,'BURUNDI','Franco Burundi','BIF'),(35,'BUTÁN','Ngultrum','BTN'),(36,'BUTÁN','Rupia india','INR'),(37,'BÉLGICA','Euro','EUR'),(38,'CABO VERDE','Cabo Verde Escudo','CVE'),(39,'CAMBOYA','Riel','KHR'),(40,'CAMERÚN','Franco CFA BEAC','XAF'),(41,'CANADÁ','Dólar canadiense','CAD'),(42,'CHAD','Franco CFA BEAC','XAF'),(43,'CHILE','Unidad de Fomento','CLF'),(44,'CHILE','Peso chileno','CLP'),(45,'CHINA','Yuan','CNY'),(46,'CHIPRE','Euro','EUR'),(47,'COLOMBIA','Peso ColombianO','COP'),(48,'COLOMBIA','Unidad de Valor Real','COU'),(49,'COMOROS','Franco Comoro','KMF'),(50,'CONGO','Franco CFA BEAC','XAF'),(51,'CONGO (LA REPÚBLICA DEMOCRÁTICA DEL)','Franco congoleño','CDF'),(52,'COREA (LA REPÚBLICA DE)','Won','KRW'),(53,'COREA (LA REPÚBLICA DEMOCRÁTICA POPULAR)','Won norcoreano','KPW'),(54,'COSTA DE MARFIL','Franco CFA BCEAO','XOF'),(55,'COSTA RICA','Colón costarricense','CRC'),(56,'CROAcIA','Kuna','HRK'),(57,'CUBA','Peso Convertible','CUC'),(58,'CUBA','Peso Cubano','CUP'),(59,'CURAZAO','Florín antillano neerlandés','ANG'),(60,'DINAMARCA','Corona danesa','DKK'),(61,'DJIBOUTI','Franco de Djibouti','DJF'),(62,'DOMINICA','Dólar del Caribe Oriental','XCD'),(63,'ECUADOR','DÓlar americano','USD'),(64,'EGIPTO','Libra egipcia','EGP'),(65,'EL SALVADOR','Colón','SVC'),(66,'EL SALVADOR','Dólar americano','USD'),(67,'EMIRATOS ÁRABES UNIDOS','Dírham de los Emiratos Árabes Unidos','AED'),(68,'ERITREA','Nakfa','ERN'),(69,'ESLOVAQUIA','Euro','EUR'),(70,'ESLOVENIA','Euro','EUR'),(71,'ESPAÑA','Euro','EUR'),(72,'ESTADOS UNIDOS DE AMÉRICA','Dólar Americano','USD'),(73,'ESTADOS UNIDOS DE AMÉRICA','Dólar Americano (Next day)','USN'),(74,'ESTADOS UNIDOS E ISLAS MENORES','Dólar Americano','USD'),(75,'ESTONIA','Euro','EUR'),(76,'ETIOPÍA','Birr etíope','ETB'),(77,'FIJI','Dólar de Fiji','FJD'),(78,'FILIPINAS (LAS)','Peso filipino','PHP'),(79,'FINLANDIA','Euro','EUR'),(80,'FONDO MONETARIO INTERNACIONAL (IMF)','SDR (Derechos Especiales de Giro)','XDR'),(81,'FRANCIA','Euro','EUR'),(82,'GABÓN','Franco CFA BEAC','XAF'),(83,'GAMBIA','Dalasi','GMD'),(84,'GEORGIA','Lari','GEL'),(85,'GHANA','Cedi de Ghana','GHS'),(86,'GIBRALTAR','Libra de Gibraltar','GIP'),(87,'GRANADA','Dólar del Caribe Oriental','XCD'),(88,'GRECIA','Euro','EUR'),(89,'GROENLANDIA','Corona danesa','DKK'),(90,'GUADALUPE','Euro','EUR'),(91,'GUAM','Dólar americano','USD'),(92,'GUATEMALA','Quetzal','GTQ'),(93,'GUAYANA FRANCESA','Euro','EUR'),(94,'GUERNESEY','Libra esterlina','GBP'),(95,'GUINEA','Franco guineano','GNF'),(96,'GUINEA ECUATORIAL','Franco CFA BEAC','XAF'),(97,'GUINEA-BISSAU','Franco CFA BCEAO','XOF'),(98,'GUYANA','Dólar guyanés','GYD'),(99,'HAITÍ','Gourde','HTG'),(100,'HAITÓ','Dólar americano','USD'),(101,'HONDURAS','Lempira','HNL'),(102,'HONG KONG','Dolar de Hong Kong','HKD'),(103,'HUNGRÍA','Florín','HUF'),(104,'INDIA','Rupia india','INR'),(105,'INDONESIA','Rupia','IDR'),(106,'IRAQ','Dinar iraquí','IQD'),(107,'IRLANDA','Euro','EUR'),(108,'IRÁN (REPÚBLICA ISLÁMICA DE)','Rial iraní','IRR'),(109,'ISLA BOUVET','Corona noruega','NOK'),(110,'ISLA DE MAN','Libra esterlina','GBP'),(111,'ISLA DE NAVIDAD','Dólar australiano','AUD'),(112,'ISLA HEARD E ISLAS McDONALD','Dólar australiano','AUD'),(113,'ISLA NORFOLK','Dólar australiano','AUD'),(114,'ISLANDIA','Corona islandesa','ISK'),(115,'ISLAS ALAND','Euro','EUR'),(116,'ISLAS CAIMÁN','Dólar de las Islas Caimán','KYD'),(117,'ISLAS COCO','Dólar australiano','AUD'),(118,'ISLAS COOK','Dólar neozelandés','NZD'),(119,'ISLAS FEROE','Corona danesa','DKK'),(120,'ISLAS GEORGIAS DEL SUR Y SANDWICH DEL SUR','Sin moneda universal',''),(121,'ISLAS MALVINAS','Libra malvinense','FKP'),(122,'ISLAS MARIANAS DEL NORTE','Dólar Americano','USD'),(123,'ISLAS MARSHALL','Dólar americano','USD'),(124,'ISLAS SALOMÓN','Dólar de las Islas Salomón','SBD'),(125,'ISLAS VIRGENES (EE.UU.)','Dólar Americano','USD'),(126,'ISLAS VÍRGENES (BRITÁNICA)','Dólar Americano','USD'),(127,'ISRAEL','Nuevo Shekel Israelí','ILS'),(128,'ITALIA','Euro','EUR'),(129,'JAMAICA','Dólar jamaiquino','JMD'),(130,'JAPÓN','Yen','JPY'),(131,'JERSEY','Libra esterlina','GBP'),(132,'JORDANIA','Dinar jordano','JOD'),(133,'KAZAJSTÁN','Tenge','KZT'),(134,'KENIA','Chelín keniano','KES'),(135,'KIRGUISTÁN','Som','KGS'),(136,'KIRIBATI','Dólar australiano','AUD'),(137,'KUWAIT','Dinar kuwaití','KWD'),(138,'LAO REPÚBLICA DEMOCRÁTICA POPULAR','Kip','LAK'),(139,'LESOTHO','Loti','LSL'),(140,'LESOTHO','Rand','ZAR'),(141,'LETONIA','Euro','EUR'),(142,'LIBERIA','Dólar liberiano','LRD'),(143,'LIBIA','Dinar libio','LYD'),(144,'LIECHTENSTEIN','Franco suizo','CHF'),(145,'LITUANIA','Euro','EUR'),(146,'LUXEMBOURG','Euro','EUR'),(147,'LÍBANO','Libra libanesa','LBP'),(148,'MACAO','Pataca','MOP'),(149,'MACEDONIA (Ex República Yugoslava)','Denar','MKD'),(150,'MADAGASCAR','Ariary malgache','MGA'),(151,'MALASIA','Ringgit malayo','MYR'),(152,'MALAWI','Kwacha','MWK'),(153,'MALDIVAS','Rufiyaa','MVR'),(154,'MALTA','Euro','EUR'),(155,'MALÍ','Franco CFA BCEAO','XOF'),(156,'MARRUECOS','Dirham marroquí','MAD'),(157,'MARTINICA','Euro','EUR'),(158,'MAURICIO','Rupia de Mauricio','MUR'),(159,'MAURITANIA','Ouguiya','MRO'),(160,'MAYOTTE','Euro','EUR'),(161,'MICRONESIA (ESTADOS FEDERADOS DE)','Dólar americano','USD'),(162,'MOLDAVIA','Leu moldavo','MDL'),(163,'MONGOLIA','Tugrik','MNT'),(164,'MONTENEGRO','Euro','EUR'),(165,'MONTSERRAT','Dólar del Caribe Oriental','XCD'),(166,'MOZAMBIQUE','Metical mozambiqueño','MZN'),(167,'MYANMAR','Kyat','MMK'),(168,'MÉXICO','Peso MexicanO','MXN'),(169,'MÉXICO','Unidad de Inversion Mexicana (UDI)','MXV'),(170,'MÓNACO','Euro','EUR'),(171,'NAMIBIA','Dólar de Namibia','NAD'),(172,'NAMIBIA','Rand','ZAR'),(173,'NAURU','Dólar australiano','AUD'),(174,'NEPAL','Rupia nepalí','NPR'),(175,'NICARAGUA','Cordoba Oro','NIO'),(176,'NIGER','Franco CFA BCEAO','XOF'),(177,'NIGERIA','Naira','NGN'),(178,'NIUE','Dólar neozelandés','NZD'),(179,'NORUEGA','Corona noruega','NOK'),(180,'NUEVA CALEDONIA','Franco CFP','XPF'),(181,'NUEVA ZELANDA','Dólar neozelandés','NZD'),(182,'OMÁN','Rial omaní','OMR'),(183,'PAKISTÁN','Rupia pakistaní','PKR'),(184,'PALAU','Dólar Americano','USD'),(185,'PALESTINA, ESTADO DE','Sin moneda universal',''),(186,'PANAMÁ','Balboa','PAB'),(187,'PANAMÁ','Dólar Americano','USD'),(188,'PAPUA NUEVA GUINEA','Kina','PGK'),(189,'PARAGUAY','Guaraní','PYG'),(190,'PAÍSES BAJOS','Euro','EUR'),(191,'PAÍSES MIEMBROS DEL GRUPO BANCO AFRICANO DEL DESARROLLO','Unidad de cuenta del BAD','XUA'),(192,'PERú','Nuevo Sol','PEN'),(193,'PITCAIRN','Dólar neozelandés','NZD'),(194,'POLINESIA FRANCESA','CFP Franc','XPF'),(195,'POLONIA','Zloty','PLN'),(196,'PORTUGAL','Euro','EUR'),(197,'PUERTO RICO','Dólar Americano','USD'),(198,'QATAR','Riyal catarí','QAR'),(199,'REINO UNIDO DE GRAN BRETAÑA E IRLANDA DEL NORTE','Libra esterlina','GBP'),(200,'REPÚBLICA CENTROAFRICANA','Franco CFA BEAC','XAF'),(201,'REPÚBLICA CHECA','Corona checa','CZK'),(202,'REPÚBLICA DOMINICANA','Peso Dominicano','DOP'),(203,'REPÚBLICA ÁRABE SIRIA','Libra Siria','SYP'),(204,'RUANDA','Franco ruandés','RWF'),(205,'RUMANIA','Leu rumano','RON'),(206,'RUSIA','Rublo ruso','RUB'),(207,'RÉUNION','Euro','EUR'),(208,'SAHARA OCCIDENTAL','Dirham marroquí','MAD'),(209,'SAMOA','Tala','WST'),(210,'SAMOA AMERICANA','Dólar Americano','USD'),(211,'SAN BARTOLOMÉ','Euro','EUR'),(212,'SAN CRISTÓBAL Y NIEVES','Dólar del Caribe Oriental','XCD'),(213,'SAN MARINO','Euro','EUR'),(214,'SAN MARTIN (PARTE FRANCESA)','Euro','EUR'),(215,'SAN PEDRO Y MIQUELÓN','Euro','EUR'),(216,'SAN VICENTE Y LAS GRANADINAS','Dólar del Caribe Oriental','XCD'),(217,'SANTA ELENA, ASCENSIÓN Y TRISTÁN DE ACUÑA','Libra de Santa Helena','SHP'),(218,'SANTA LUCÍA','Dólar del Caribe Oriental','XCD'),(219,'SANTA SEDE','Euro','EUR'),(220,'SANTO TOMÉ Y PRÍNCIPE','Dobra','STD'),(221,'SENEGAL','Franco CFA BCEAO','XOF'),(222,'SERBIA','Dinar serbio','RSD'),(223,'SEYCHELLES','Rupia seychelense','SCR'),(224,'SIERRA LEONA','Leone','SLL'),(225,'SINGAPUR','Dolar de Singapur','SGD'),(226,'SINT MAARTEN (PARTE HOLANDESA)','Florín antillano neerlandés','ANG'),(227,'SISTEMA UNITARIO DE COMPENSACION REGIONAL DE PAGOS \"\"SUCRE\"\"','Sucre','XSU'),(228,'SOMALIA','Chelín somalí','SOS'),(229,'SRI LANKA','Rupia de Sri Lanka','LKR'),(230,'SUDÁFRICA','Rand','ZAR'),(231,'SUDÁN','Libra sudanesa','SDG'),(232,'SUDÁN DEL SUR','Libra sursudanesa','SSP'),(233,'SUECIA','Corona sueca','SEK'),(234,'SUIZA','Euro WIR','CHE'),(235,'SUIZA','Franco suizo','CHF'),(236,'SUIZA','Franco WIR','CHW'),(237,'SURINAME','Dólar surinamés','SRD'),(238,'SVALBARD AND JAN MAYEN','Corona noruega','NOK'),(239,'SWAZILANDIA','Lilangeni','SZL'),(240,'TAILANDIA','Baht','THB'),(241,'TAIWÁN (PROVINCIA DE CHINA)','Nuevo dólar taiwanés','TWD'),(242,'TANZANIA, REPÚBLICA UNIDA DE','Chelín tanzano','TZS'),(243,'TAYIKISTÁN','Somoni','TJS'),(244,'TERRITORIO BRITÁNICO DEL OCÉANO ÍNDICO','Dólar Americano','USD'),(245,'TERRITORIOS AUSTRALES FRANCESES','Euro','EUR'),(246,'TIMOR ORIENTAL','Dólar Americano','USD'),(247,'TOGO','Franco CFA BCEAO','XOF'),(248,'TOKELAU','Dólar neozelandés','NZD'),(249,'TONGA','Pa’anga','TOP'),(250,'TRINIDAD Y TOBAGO','Dólar trinitense','TTD'),(251,'TURCOS Y CAICOS','Dólar Americano','USD'),(252,'TURKMENISTÁN','Manat turcomano','TMT'),(253,'TURQUÍA','Lira turca','TRY'),(254,'TUVALU','Dólar australiano','AUD'),(255,'TÚNEZ','Dinar tunecino','TND'),(256,'UCRANIA','Hryvnia','UAH'),(257,'UGANDA','Chelín ugandés','UGX'),(258,'UNIÓN EUROPEA','Euro','EUR'),(259,'URUGUAY','Uruguay Peso en Unidades Indexadas (URUIURUI)','UYI'),(260,'URUGUAY','Peso Uruguayo','UYU'),(261,'UZBEKISTÁN','Som uzbeko','UZS'),(262,'VANUATU','Vatu','VUV'),(263,'VENEZUELA (REPÚBLICA BOLIVARIANA DE)','Bolívar','VEF'),(264,'VIETNAM','Dong','VND'),(265,'WALLIS Y FUTUNA','Franco CFP','XPF'),(266,'YEMEN','Rial yemení','YER'),(267,'ZAMBIA','Kwacha zambiano','ZMW'),(268,'ZIMBABWE','Dólar zimbabuense','ZWL');
/*!40000 ALTER TABLE `moneda` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `normativa`
--

DROP TABLE IF EXISTS `normativa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `normativa` (
  `numeroResolucion` varchar(100) NOT NULL,
  `fechareSolucion` varchar(45) NOT NULL,
  PRIMARY KEY (`numeroResolucion`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `normativa`
--

LOCK TABLES `normativa` WRITE;
/*!40000 ALTER TABLE `normativa` DISABLE KEYS */;
INSERT INTO `normativa` VALUES ('DGT-R-48-2016','07-10-2016 08:00:00');
/*!40000 ALTER TABLE `normativa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenCompra`
--

DROP TABLE IF EXISTS `ordenCompra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenCompra` (
  `id` char(36) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `idProveedor` char(36) DEFAULT NULL,
  `orden` varchar(100) DEFAULT NULL,
  `idUsuario` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ordenCompra_usuario1_idx` (`idUsuario`),
  KEY `fk_ordenCompra_proveedor_idx` (`idProveedor`),
  CONSTRAINT `fk_ordenCompra_proveedor` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordenCompra_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Almacena historial de Ordenes de compra o Facturas del proveedor y el valor historico original de los items comprados.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenCompra`
--

LOCK TABLES `ordenCompra` WRITE;
/*!40000 ALTER TABLE `ordenCompra` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenCompra` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenCompraXBodega`
--

DROP TABLE IF EXISTS `ordenCompraXBodega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenCompraXBodega` (
  `id` char(36) NOT NULL,
  `fecha` timestamp NULL DEFAULT NULL,
  `orden` varchar(45) DEFAULT NULL,
  `idUsuario` char(36) NOT NULL,
  `idBodega` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ordenCompraXBodega_usuario1_idx` (`idUsuario`),
  KEY `fk_ordenCompraXBodega_bodega1_idx` (`idBodega`),
  CONSTRAINT `fk_ordenCompraXBodega_bodega1` FOREIGN KEY (`idBodega`) REFERENCES `bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordenCompraXBodega_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Ordenes de compra de productos en las franquicias. Una bodega interna mantiene el costopromedio del prodcuto de la "Bodega principal" una bodega externa es el precio venta del la bodega principal el que define su costo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenCompraXBodega`
--

LOCK TABLES `ordenCompraXBodega` WRITE;
/*!40000 ALTER TABLE `ordenCompraXBodega` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenCompraXBodega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordenSalida`
--

DROP TABLE IF EXISTS `ordenSalida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ordenSalida` (
  `id` char(36) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `numeroOrden` int(11) NOT NULL DEFAULT '0',
  `idUsuarioEntrega` char(36) DEFAULT NULL,
  `idUsuarioRecibe` char(36) DEFAULT NULL,
  `fechaLiquida` timestamp NULL DEFAULT NULL,
  `idEstado` char(36) NOT NULL COMMENT 'PROCESO\nLIQUIDADO',
  PRIMARY KEY (`id`),
  KEY `fk_ordenSalida_usuario1_idx` (`idUsuarioEntrega`),
  KEY `fk_ordenSalida_usuario2_idx` (`idUsuarioRecibe`),
  KEY `fk_ordenSalida_estado1_idx` (`idEstado`),
  KEY `Orden` (`numeroOrden`),
  CONSTRAINT `fk_ordenSalida_estado1` FOREIGN KEY (`idEstado`) REFERENCES `estado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordenSalida_usuario1` FOREIGN KEY (`idUsuarioEntrega`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordenSalida_usuario2` FOREIGN KEY (`idUsuarioRecibe`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Orden de salida de materia prima o insumo para elaboración de producto';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenSalida`
--

LOCK TABLES `ordenSalida` WRITE;
/*!40000 ALTER TABLE `ordenSalida` DISABLE KEYS */;
/*!40000 ALTER TABLE `ordenSalida` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`storydb`@`%`*/ /*!50003 TRIGGER `tropical`.`ordensalida_BEFORE_INSERT` BEFORE INSERT ON `ordenSalida` FOR EACH ROW
BEGIN
	-- ultima orden
	SELECT numeroOrden
	INTO @nnumeroorden
	FROM ordenSalida
	ORDER BY numeroOrden DESC LIMIT 1;
    IF @nnumeroorden IS NULL then
		set @nnumeroorden=0;
	END IF;
	-- asigna nuevo valor    
	SET NEW.numeroOrden = @nnumeroorden+1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `preciosXBodega`
--

DROP TABLE IF EXISTS `preciosXBodega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preciosXBodega` (
  `id` char(36) NOT NULL,
  `idBodega` char(36) NOT NULL,
  `tamano` varchar(4) NOT NULL COMMENT 'Tamaño del copo',
  `precioVenta` decimal(18,5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_preciosXBodega_bodega1_idx` (`idBodega`),
  CONSTRAINT `fk_preciosXBodega_bodega1` FOREIGN KEY (`idBodega`) REFERENCES `bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preciosXBodega`
--

LOCK TABLES `preciosXBodega` WRITE;
/*!40000 ALTER TABLE `preciosXBodega` DISABLE KEYS */;
/*!40000 ALTER TABLE `preciosXBodega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `producto` (
  `id` char(36) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `txtColor` varchar(45) DEFAULT NULL,
  `bgColor` varchar(45) DEFAULT NULL,
  `nombreAbreviado` varchar(45) DEFAULT NULL COMMENT 'impresion en tiquete de caja o pantalla',
  `descripcion` varchar(500) DEFAULT NULL,
  `saldoCantidad` decimal(10,0) NOT NULL,
  `saldoCosto` decimal(20,10) NOT NULL,
  `costoPromedio` decimal(20,10) NOT NULL,
  `precioVenta` decimal(20,10) NOT NULL,
  `esVenta` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productosXDistribucion`
--

DROP TABLE IF EXISTS `productosXDistribucion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productosXDistribucion` (
  `id` char(36) NOT NULL,
  `idDistribucion` char(36) NOT NULL,
  `idProducto` char(36) NOT NULL,
  `cantidad` decimal(10,0) NOT NULL,
  `valor` decimal(20,10) NOT NULL COMMENT 'Cuanto cuesta ',
  PRIMARY KEY (`id`),
  KEY `fk_productosXDistribucion_distribucion1_idx` (`idDistribucion`),
  KEY `fk_productosXDistribucion_producto1_idx` (`idProducto`),
  CONSTRAINT `fk_productosXDistribucion_distribucion1` FOREIGN KEY (`idDistribucion`) REFERENCES `distribucion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productosXDistribucion_producto1` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productosXDistribucion`
--

LOCK TABLES `productosXDistribucion` WRITE;
/*!40000 ALTER TABLE `productosXDistribucion` DISABLE KEYS */;
/*!40000 ALTER TABLE `productosXDistribucion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productosXFactura`
--

DROP TABLE IF EXISTS `productosXFactura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productosXFactura` (
  `id` char(36) NOT NULL,
  `idFactura` char(36) NOT NULL,
  `idPrecio` char(36) DEFAULT NULL,
  `numeroLinea` int(4) NOT NULL DEFAULT '0' COMMENT 'Maximo de lineas por factura = 1000.',
  `idTipoCodigo` int(11) DEFAULT NULL,
  `codigo` varchar(20) DEFAULT NULL,
  `cantidad` decimal(16,3) NOT NULL DEFAULT '0.000',
  `idUnidadMedida` int(11) NOT NULL,
  `unidadMedidaComercial` varchar(20) DEFAULT NULL,
  `detalle` varchar(160) NOT NULL,
  `precioUnitario` decimal(18,5) NOT NULL,
  `montoTotal` decimal(18,5) NOT NULL,
  `montoDescuento` decimal(18,5) DEFAULT NULL,
  `naturalezaDescuento` varchar(80) DEFAULT NULL,
  `subTotal` decimal(18,5) NOT NULL,
  `codigoImpuesto` varchar(2) DEFAULT NULL,
  `tarifaImpuesto` decimal(4,2) DEFAULT NULL,
  `montoImpuesto` decimal(18,5) DEFAULT NULL,
  `idExoneracionImpuesto` int(11) DEFAULT NULL,
  `montoTotalLinea` decimal(18,5) NOT NULL DEFAULT '0.00000',
  PRIMARY KEY (`id`),
  KEY `fk_productosXFactura_factura1_idx` (`idFactura`),
  KEY `fk_productosXFactura_preciosXBodega1_idx` (`idPrecio`),
  KEY `fk_productosXFactura_unidadMedida1_idx` (`idUnidadMedida`),
  KEY `fk_productosXFactura_tipoCodigo1_idx` (`idTipoCodigo`),
  KEY `fk_productosXFactura_impuesto1_idx` (`codigoImpuesto`),
  KEY `fk_productosXFactura_documentoExoneracionAutorizacion1_idx` (`idExoneracionImpuesto`),
  CONSTRAINT `fk_productosXFactura_factura1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productosXFactura_preciosXBodega1` FOREIGN KEY (`idPrecio`) REFERENCES `preciosXBodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productosXFactura_unidadMedida1` FOREIGN KEY (`idUnidadMedida`) REFERENCES `unidadMedida` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productosXFactura_tipoCodigo1` FOREIGN KEY (`idTipoCodigo`) REFERENCES `tipoCodigo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productosXFactura_impuesto1` FOREIGN KEY (`codigoImpuesto`) REFERENCES `impuesto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productosXFactura_documentoExoneracionAutorizacion1` FOREIGN KEY (`idExoneracionImpuesto`) REFERENCES `documentoExoneracionAutorizacion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Productos vendidos en una factura (Detalle).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productosXFactura`
--

LOCK TABLES `productosXFactura` WRITE;
/*!40000 ALTER TABLE `productosXFactura` DISABLE KEYS */;
/*!40000 ALTER TABLE `productosXFactura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proveedor` (
  `id` char(36) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO proveedor VALUES ('0f8aef81-7400-4a36-93f9-b929d4889d0e','Estándar');

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receptor`
--

DROP TABLE IF EXISTS `receptor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receptor` (
  `id` char(36) NOT NULL,
  `nombre` varchar(80) NOT NULL COMMENT 'Nombre o razon social',
  `idTipoIdentificacion` int(11) DEFAULT NULL,
  `identificacion` varchar(15) DEFAULT NULL,
  `identificacionExtranjero` varchar(20) DEFAULT NULL,
  `nombreComercial` varchar(80) DEFAULT NULL,
  `ubicacion` tinyint(1) DEFAULT NULL,
  `idProvincia` int(11) DEFAULT NULL,
  `idCanton` int(11) DEFAULT NULL,
  `idDistrito` int(11) DEFAULT NULL,
  `idBarrio` int(11) DEFAULT NULL,
  `otrasSenas` varchar(160) DEFAULT NULL,
  `idCodigoPaisTel` char(11) DEFAULT NULL,
  `numTelefono` varchar(20) DEFAULT NULL,
  `idCodigoPaisFax` char(11) DEFAULT NULL,
  `numTelefonoFax` varchar(20) DEFAULT NULL,
  `correoElectronico` varchar(200) DEFAULT NULL COMMENT '\\s*\\w+([-+.'']\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\\s* ',
  PRIMARY KEY (`id`),
  KEY `fk_receptor_tipoIdentificacion1_idx` (`idTipoIdentificacion`),
  CONSTRAINT `fk_receptor_tipoIdentificacion1` FOREIGN KEY (`idTipoIdentificacion`) REFERENCES `tipoIdentificacion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Receptor de facturas de ventas - Clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receptor`
--

LOCK TABLES `receptor` WRITE;
/*!40000 ALTER TABLE `receptor` DISABLE KEYS */;
/*!40000 ALTER TABLE `receptor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referencia`
--

DROP TABLE IF EXISTS `referencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `referencia` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referencia`
--

LOCK TABLES `referencia` WRITE;
/*!40000 ALTER TABLE `referencia` DISABLE KEYS */;
INSERT INTO `referencia` VALUES (1,'01','Anula Documento de Referencia'),(2,'02','Corrige texto documento de referencia'),(3,'03','Corrige monto'),(4,'04','Referencia a otro documento'),(5,'05','Sustituye comprobante provisional por contingencia'),(6,'99','Otros');
/*!40000 ALTER TABLE `referencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rol` (
  `id` char(36) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(400) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES ('0f8aef81-7400-4a36-93f9-b929d4889d0e','admin-seguridad','administra usuarios y conexiones'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','Admin','Administrador del Sistema'),('7f9f8011-f9db-4330-b931-552141a089a4','admin-tropical','administrador de sistema Tropical'),('e8d2f620-dd38-4e21-8b7f-7949412f65d6','local-comercial','administrado de local comercial');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rolesXUsuario`
--

DROP TABLE IF EXISTS `rolesXUsuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rolesXUsuario` (
  `idRol` char(36) NOT NULL,
  `idUsuario` char(36) NOT NULL,
  PRIMARY KEY (`idRol`,`idUsuario`),
  KEY `fk_rolesXUsuario_usuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_rolesXUsuario_rol1` FOREIGN KEY (`idRol`) REFERENCES `rol` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rolesXUsuario_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rolesXUsuario`
--

LOCK TABLES `rolesXUsuario` WRITE;
/*!40000 ALTER TABLE `rolesXUsuario` DISABLE KEYS */;
INSERT INTO `rolesXUsuario` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','1ed3a48c-3e44-11e8-9ddb-54ee75873a60');
/*!40000 ALTER TABLE `rolesXUsuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `situacionComprobante`
--

DROP TABLE IF EXISTS `situacionComprobante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `situacionComprobante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `situacionComprobante`
--

LOCK TABLES `situacionComprobante` WRITE;
/*!40000 ALTER TABLE `situacionComprobante` DISABLE KEYS */;
INSERT INTO `situacionComprobante` VALUES (1,'1','Normal'),(2,'2','Contingencia'),(3,'3','Sin Internet');
/*!40000 ALTER TABLE `situacionComprobante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoBodega`
--

DROP TABLE IF EXISTS `tipoBodega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoBodega` (
  `id` char(36) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoBodega`
--

LOCK TABLES `tipoBodega` WRITE;
/*!40000 ALTER TABLE `tipoBodega` DISABLE KEYS */;
INSERT INTO `tipoBodega` VALUES ('22a80c9e-5639-11e8-8242-54ee75873a11','Interna'),('22a80c9e-5639-11e8-8242-54ee75873a12','Externa');
/*!40000 ALTER TABLE `tipoBodega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoCodigo`
--

DROP TABLE IF EXISTS `tipoCodigo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoCodigo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoCodigo`
--

LOCK TABLES `tipoCodigo` WRITE;
/*!40000 ALTER TABLE `tipoCodigo` DISABLE KEYS */;
INSERT INTO `tipoCodigo` VALUES (5,'99','Otros');
/*!40000 ALTER TABLE `tipoCodigo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipoIdentificacion`
--

DROP TABLE IF EXISTS `tipoIdentificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tipoIdentificacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `tipo` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipoIdentificacion`
--

LOCK TABLES `tipoIdentificacion` WRITE;
/*!40000 ALTER TABLE `tipoIdentificacion` DISABLE KEYS */;
INSERT INTO `tipoIdentificacion` VALUES (1,'01','Cédula física'),(2,'02','Cédula jurídica'),(3,'03','DIMEX'),(4,'04','NITE');
/*!40000 ALTER TABLE `tipoIdentificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unidadMedida`
--

DROP TABLE IF EXISTS `unidadMedida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unidadMedida` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `simbolo` varchar(10) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unidadMedida`
--

LOCK TABLES `unidadMedida` WRITE;
/*!40000 ALTER TABLE `unidadMedida` DISABLE KEYS */;
INSERT INTO `unidadMedida` VALUES (1,'Sp','Servicios Profesionales'),(2,'m','Metro'),(3,'kg','Kilogramo'),(4,'s','Segundo'),(5,'A','Ampere'),(6,'K','Kelvin'),(7,'mol','Mol'),(8,'cd','Candela'),(9,'m²','metro cuadrado'),(10,'m³','metro cúbico'),(11,'m/s','metro por segundo'),(12,'m/s²','metro por segundo cuadrado'),(13,'1/m','1 por metro'),(14,'kg/m³','kilogramo por metro cúbico'),(15,'A/m²','ampere por metro cuadrado'),(16,'A/m','ampere por metro'),(17,'mol/m³','mol por metro cúbico'),(18,'cd/m²','candela por metro cuadrado'),(19,'1','uno (indice de refracción)'),(20,'rad','radián'),(21,'sr','estereorradián'),(22,'Hz','hertz'),(23,'N','newton'),(24,'Pa','pascal'),(25,'J','Joule'),(26,'W','Watt'),(27,'C','coulomb'),(28,'V','volt'),(29,'F','farad'),(30,'Ohm','ohm'),(31,'S','siemens'),(32,'Wb','weber'),(33,'T','tesla'),(34,'H','henry'),(35,'°C','grado Celsius'),(36,'lm','lumen'),(37,'lx','lux'),(38,'Bq','Becquerel'),(39,'Gy','gray'),(40,'Sv','sievert'),(41,'kat','katal'),(42,'Pa·s','pascal segundo'),(43,'N·m','newton metro'),(44,'N/m','newton por metro'),(45,'rad/s','radián por segundo'),(46,'rad/s²','radián por segundo cuadrado'),(47,'W/m²','watt por metro cuadrado'),(48,'J/K','joule por kelvin'),(49,'J/(kg·K)','joule por kilogramo kelvin'),(50,'J/kg','joule por kilogramo'),(51,'W/(m·K)','watt por metro kevin'),(52,'J/m³','joule por metro cúbico'),(53,'V/m','volt por metro'),(54,'C/m³','coulomb por metro cúbico'),(55,'C/m²','coulomb por metro cuadrado'),(56,'F/m','farad por metro'),(57,'H/m','henry por metro'),(58,'J/mol','joule por mol'),(59,'J/(mol·K)','joule por mol kelvin'),(60,'C/kg','coulomb por kilogramo'),(61,'Gy/s','gray por segundo'),(62,'W/sr','watt por estereorradián'),(63,'W/(m²·sr)','watt por metro cuadrado estereorradián'),(64,'kat/m³','katal por metro cúbico'),(65,'min','minuto'),(66,'h','hora'),(67,'d','día'),(68,'º','grado'),(69,'´','minuto'),(70,'´´','segundo'),(71,'L','litro'),(72,'t','tonelada'),(73,'Np','neper'),(74,'B','bel'),(75,'eV','electronvolt'),(76,'u','unidad de masa atómica unificada'),(77,'ua','unidad astronómica'),(78,'Unid','Unidad'),(79,'Gal','Galón'),(80,'g','Gramo'),(81,'Km','Kilometro'),(82,'ln','pulgada'),(83,'cm','centímetro'),(84,'mL','mililitro'),(85,'mm','Milímetro'),(86,'Oz','Onzas'),(87,'Otros','Se debe indicar la descripción de la medida a utilizar');
/*!40000 ALTER TABLE `unidadMedida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `id` char(36) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `userName` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','administrador de sistema','admin','$2y$10$CwVlbwIWdHbxlQqo3yJHj.zo7BRekPGM.NCIjn02fIc0f7uz9gpua',NULL,1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuariosXBodega`
--

DROP TABLE IF EXISTS `usuariosXBodega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuariosXBodega` (
  `idUsuario` char(36) NOT NULL,
  `idBodega` char(36) NOT NULL,
  PRIMARY KEY (`idUsuario`,`idBodega`),
  KEY `fk_usuariosXBodega_bodega1_idx` (`idBodega`),
  CONSTRAINT `fk_usuariosXBodega_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuariosXBodega_bodega1` FOREIGN KEY (`idBodega`) REFERENCES `bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuariosXBodega`
--

LOCK TABLES `usuariosXBodega` WRITE;
/*!40000 ALTER TABLE `usuariosXBodega` DISABLE KEYS */;
/*!40000 ALTER TABLE `usuariosXBodega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'tropical'
--

--
-- Dumping routines for database 'tropical'
--
/*!50003 DROP PROCEDURE IF EXISTS `spUpdateSaldosPromedioArticuloEntrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`storydb`@`%` PROCEDURE `spUpdateSaldosPromedioArticuloEntrada`(
	IN mid char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(15,10)
)
BEGIN
	DECLARE msaldocantidad decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(20,10) DEFAULT null;
    DECLARE mcostopromedio  decimal(20,10) DEFAULT null;
    --
	SELECT saldocantidad, saldocosto 
	INTO msaldocantidad, msaldocosto
	FROM producto
	WHERE id= mid;
	-- Calculo de saldos y promedio    
	set msaldocantidad = msaldocantidad + ncantidad;
	set msaldocosto=  msaldocosto + ncosto;
	set mcostopromedio= msaldocosto / msaldocantidad;
	--
	UPDATE producto
	SET saldocantidad=msaldocantidad, saldocosto=msaldocosto, costopromedio = mcostopromedio
	WHERE id= mid;  
	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spUpdateSaldosPromedioInsumoBodegaEntrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`storydb`@`%` PROCEDURE `spUpdateSaldosPromedioInsumoBodegaEntrada`(
	-- IN mid char(36),
	IN nidproducto char(36),
	IN nidbodega char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(20,10)
)
BEGIN
	DECLARE msaldocantidad  decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(20,10) DEFAULT 0;
    DECLARE mcostopromedio  decimal(20,10)DEFAULT 0;
	-- verifica si el insumo se encuentra en el inventario.
	SELECT saldocantidad, saldocosto
	INTO msaldocantidad, msaldocosto
	FROM insumosXBodega
	WHERE idproducto= nidproducto AND idBodega= nidbodega;
    -- si no hay saldo de cantidad debe crear el insumo
	IF msaldocantidad is null THEN
		SET msaldocantidad= 0;
        SET msaldocosto= 0;
        SET mcostopromedio= 0;   
		INSERT INTO insumosXBodega VALUES (uuid(), nidproducto, nidbodega, msaldocantidad, msaldocosto, mcostopromedio);          
	END IF;
	-- Calculo de saldos y promedio
	set msaldocantidad= msaldocantidad + ncantidad;
	set msaldocosto=  msaldocosto + ncosto;
	set mcostopromedio= msaldocosto / msaldocantidad;
	--
	UPDATE insumosXBodega
	SET saldocantidad=msaldocantidad, saldocosto=msaldocosto, costopromedio = mcostopromedio
	WHERE idproducto= nidproducto AND idBodega= nidbodega;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spUpdateSaldosPromedioInsumoEntrada` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`storydb`@`%` PROCEDURE `spUpdateSaldosPromedioInsumoEntrada`(
	IN mid char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(20,10)
)
BEGIN
	DECLARE msaldocantidad  decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(20,10) DEFAULT 0;
    DECLARE mcostopromedio  decimal(20,10)DEFAULT 0;
    --
	SELECT saldocantidad, saldocosto 
	INTO msaldocantidad, msaldocosto
	FROM insumo
	WHERE id= mid;
	-- Calculo de saldos y promedio
    IF msaldocantidad is not null THEN
		set msaldocantidad = msaldocantidad + ncantidad;
		set msaldocosto=  msaldocosto + ncosto;
		set mcostopromedio= msaldocosto / msaldocantidad;
		--
		UPDATE insumo
		SET saldocantidad=msaldocantidad, saldocosto=msaldocosto, costopromedio = mcostopromedio
		WHERE id= mid;  
	ELSE 
		CALL spUpdateSaldosPromedioArticuloEntrada(mid, ncantidad, ncosto);
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spUpdateSaldosPromedioProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`storydb`@`%` PROCEDURE `spUpdateSaldosPromedioProducto`(
	IN nidproducto char(36),
	IN ncantidad DECIMAL(10,0),
    IN ncosto DECIMAL(20,10)
)
BEGIN
	DECLARE msaldocantidad  decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(20,10) DEFAULT null;
    DECLARE mcostopromedio  decimal(20,10)DEFAULT null;
	-- verifica si el producto se encuentra en el inventario.
	SELECT saldocantidad, costopromedio, saldocosto
	INTO msaldocantidad, mcostopromedio, msaldocosto
	FROM producto
	WHERE id= nidproducto;
	
	-- Calculo de saldos y promedio
	set msaldocantidad = msaldocantidad + ncantidad;
	set msaldocosto=  msaldocosto + ncosto;
	set mcostopromedio= msaldocosto / msaldocantidad;
	--
	UPDATE producto
	SET saldocantidad=msaldocantidad, saldocosto=msaldocosto, costopromedio = mcostopromedio
	WHERE id= nidproducto;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `spUpdateSaldosPromedioProductoSalida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
CREATE DEFINER=`storydb`@`%` PROCEDURE `spUpdateSaldosPromedioProductoSalida`(
	IN mid char(36),
	IN ncantidad DECIMAL(10,0)
)
BEGIN
	DECLARE msaldocantidad  decimal(10,0) DEFAULT null;
    DECLARE msaldocosto  decimal(20,10) DEFAULT null;
    DECLARE mcostopromedio  decimal(20,10)DEFAULT null;
    --
	SELECT saldocantidad, costopromedio
	INTO msaldocantidad, mcostopromedio
	FROM producto
	WHERE id= mid;
	-- Calculo de saldos y promedio
	set msaldocantidad = msaldocantidad - ncantidad;
	set msaldocosto= mcostopromedio * msaldocantidad;
	--
	UPDATE producto
	SET saldocantidad=msaldocantidad, saldocosto=msaldocosto 
	WHERE id= mid; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-15 22:28:11

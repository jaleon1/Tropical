-- MySQL dump 10.14  Distrib 5.5.56-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: tropical
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
-- Table structure for table `barrio`
--

use tropical;

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
  `local` int(3) NOT NULL,
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
INSERT INTO `bodega` VALUES ('63363882-a840-4517-9786-67f148f6a587','22a80c9e-5639-11e8-8242-54ee75873a11','MALL SAN PEDRO','Tropical Sno Mall San Pedro','Mall San Pedro, 2do nivel','Viviana Ramírez','88255767',NULL,1),('715da8ec-e431-43e3-9dfc-f77e5c64c296','22a80c9e-5639-11e8-8242-54ee75873a11','TRES RÍOS','Tropical Sno Tres Ríos','San Juan, La Unión','Viviana Ramírez','88255767',NULL,2),('72a5afa7-dcba-4539-8257-ed1e18b1ce94','22a80c9e-5639-11e8-8242-54ee75873a11','Tropical Sno Central','Oficinas Centrales Tropical Sno','Montelimar','Viviana Ramírez','88255767',NULL,3),('d6cd8440-8906-4e4a-9e08-8af36695c5eb','22a80c9e-5639-11e8-8242-54ee75873a12','Agencia Plaza Lincoln','Agencia Plaza Lincoln','Moravia','Esteban Carballo','56445252',NULL,4);
/*!40000 ALTER TABLE `bodega` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tropical`.`bodega_BEFORE_INSERT` BEFORE INSERT ON `bodega` FOR EACH ROW
BEGIN
	SELECT local
	INTO @lastLocal
	FROM bodega
	ORDER BY local DESC LIMIT 1;
    IF @lastLocal IS NULL then
		set @lastLocal=1;
	END IF;	
	SET NEW.local = @lastLocal+1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cajaDefault`
--

DROP TABLE IF EXISTS `cajaDefault`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cajaDefault` (
  `montoDefaultApertura` decimal(15,8) NOT NULL,
  PRIMARY KEY (`montoDefaultApertura`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cajaDefault`
--

LOCK TABLES `cajaDefault` WRITE;
/*!40000 ALTER TABLE `cajaDefault` DISABLE KEYS */;
INSERT INTO `cajaDefault` VALUES (30000.00000000);
/*!40000 ALTER TABLE `cajaDefault` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cajasXBodega`
--

DROP TABLE IF EXISTS `cajasXBodega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cajasXBodega` (
  `id` char(36) NOT NULL,
  `idBodega` char(36) DEFAULT NULL,
  `idUsuarioCajero` char(36) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `montoApertura` varchar(45) DEFAULT NULL,
  `montoCierre` varchar(45) DEFAULT NULL,
  `totalVentasEfectivo` decimal(18,5) DEFAULT NULL,
  `totalVentasTarjeta` decimal(18,5) DEFAULT NULL,
  `fechaApertura` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fechaCierre` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cajasXBodega`
--

LOCK TABLES `cajasXBodega` WRITE;
/*!40000 ALTER TABLE `cajasXBodega` DISABLE KEYS */;
INSERT INTO `cajasXBodega` VALUES ('1df718dc-c02f-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1e03b970-2778-43fb-aff6-444043d2bf51','0','0','30000.00000000',NULL,NULL,'2018-09-24 19:22:03','2018-09-24 19:22:15'),('305370a7-c1bd-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1ed3a48c-3e44-11e8-9ddb-54ee75873a60','0','30000','30000.00000000',NULL,NULL,'2018-09-26 18:51:33','2018-09-26 18:51:42'),('37287f32-c1c8-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1e03b970-2778-43fb-aff6-444043d2bf51','0','30000','30000.00000000',NULL,NULL,'2018-09-26 20:10:29','2018-09-26 20:10:42'),('43b28b99-c0d8-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1e03b970-2778-43fb-aff6-444043d2bf51','0','0','30000.00000000',2500.00000,1500.00000,'2018-09-25 15:32:51','2018-09-26 20:00:13'),('486dbb46-c273-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1e03b970-2778-43fb-aff6-444043d2bf51','0','30000','30000.00000000',35000.00000,2500.00000,'2018-09-27 16:35:02','2018-09-28 14:03:20'),('72dcf5c5-c1c7-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1e03b970-2778-43fb-aff6-444043d2bf51','0','30000','30000.00000000',5000.00000,3000.00000,'2018-09-26 20:05:00','2018-09-26 20:08:31'),('79d4ac07-c2a1-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1ed3a48c-3e44-11e8-9ddb-54ee75873a60','0','30000','30000.00000000',2500.00000,NULL,'2018-09-27 22:05:42','2018-09-27 22:06:06'),('8bb322e2-c726-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1e03b970-2778-43fb-aff6-444043d2bf51','1','30000',NULL,NULL,NULL,'2018-10-03 16:08:20',NULL),('ce30a681-c2a3-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1ed3a48c-3e44-11e8-9ddb-54ee75873a60','0','30000','30000.00000000',NULL,2500.00000,'2018-09-27 22:22:22','2018-09-28 00:29:39'),('d00917cd-c1c6-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1e03b970-2778-43fb-aff6-444043d2bf51','0','30000','30000.00000000',NULL,NULL,'2018-09-26 20:00:27','2018-09-26 20:00:38'),('ee5686d4-c085-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1ed3a48c-3e44-11e8-9ddb-54ee75873a60','0','0','30000.00000000',NULL,NULL,'2018-09-25 05:43:29','2018-09-25 05:43:36'),('f73b6402-c25f-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1e03b970-2778-43fb-aff6-444043d2bf51','0','30000','30000.00000000',NULL,NULL,'2018-09-27 14:16:46','2018-09-27 14:16:54'),('fcb1bca1-c25b-11e8-8d13-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1e03b970-2778-43fb-aff6-444043d2bf51','0','30000','30000.00000000',5000.00000,5500.00000,'2018-09-27 13:48:17','2018-09-27 14:05:29');
/*!40000 ALTER TABLE `cajasXBodega` ENABLE KEYS */;
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
  `username` varchar(150) NOT NULL,
  `password` varchar(150) NOT NULL,
  `certificado` varchar(150) NOT NULL,
  `idBodega` char(36) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cpath` varchar(150) DEFAULT NULL,
  `nkey` varchar(150) DEFAULT NULL,
  `downloadCode` varchar(100) DEFAULT NULL,
  `pinp12` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienteFE`
--

LOCK TABLES `clienteFE` WRITE;
/*!40000 ALTER TABLE `clienteFE` DISABLE KEYS */;
INSERT INTO `clienteFE` VALUES ('69f797b5-7578-4a61-bbc9-379b87603ab5','00011154',52,'Carlos Chacon Calvo',1,'111870763','12345',1,1,1,1,'12312555',52,'84316310',NULL,NULL,'carlos.echc11@gmail.com','HdlJnKuWQmlHXh8zGS/rRkjRwm6l2DZTtN6xDaRJP3Rs0hgYx5erP3CxbOlbvmfEml7IwA==::28012e3642e27ec21e112cb17aac531b','qoO1cH2fepGpcRkSC78OreM4+io=::69a2d1c1362282eaeca5884549b59608','ySlrCVN0ILu5TEg9d1Mr::6b71daf39fd80d6d13757584093ffddb','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-11 00:39:06','wBTtr26P0FqnTgaBmsKb','214f517ed62d840e20a2d859161682f1','453622838f2219f56988a74a00fd386c','4aShyQ==::d650b3d58220d94cfc650d5fd187f58a'),('dffb85e7-ea87-4573-a7b7-be1807fc1def','00001111',52,'Carlos Chacon Calvo',1,'111870763','StoryLabs',1,1,1,1,'12345',52,'84316310',NULL,NULL,'carlos.echc11@gmail.com','pnxK7JkV2/RUJZD6saFIKcqwStVG+ajzN3plWCRnt+Z3gZo5GC+PZEYhezNiFSXtsq/4+g==::29165aa749799db5e3dd00bda71c25e0','C81LS4nmRRqq5DGvIFelMhUTe0I=::c9ec8169adc009ff1a516062917641ba','WuB6W/OpXfxSm0YjDA==::44b8418a715f5c477efeab7aad5ec33d','72a5afa7-dcba-4539-8257-ed1e18b1ce94','2018-09-28 14:33:03','jillfzntKhw0XWA4AQ==','b05c7e319bf6390880775e2bdcd1e637','f5b531e9f82a8b3089b3860a8310030d','78+Y9g==::152cc66cd84ac76923fefa4983252266');
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
-- Table structure for table `consumible`
--

DROP TABLE IF EXISTS `consumible`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consumible` (
  `id` char(36) NOT NULL,
  `idProducto` char(36) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `tamano` varchar(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_idProducto_idx` (`idProducto`),
  CONSTRAINT `fk_idProducto` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Lista de productos consumibles en una venta.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumible`
--

LOCK TABLES `consumible` WRITE;
/*!40000 ALTER TABLE `consumible` DISABLE KEYS */;
INSERT INTO `consumible` VALUES ('220e1365-c0d6-11e8-8d13-0800279cc012','0cdf88ba-a62f-11e8-b258-0800279cc012',1,'0'),('258bc813-c0d6-11e8-8d13-0800279cc012','1c01164d-a62f-11e8-b258-0800279cc012',1,'0'),('28493401-c0d6-11e8-8d13-0800279cc012','b948f654-a636-11e8-b258-0800279cc012',1,'0'),('2c6116f7-c0d6-11e8-8d13-0800279cc012','a7cc750c-a62e-11e8-b258-0800279cc012',1,'0'),('3261de81-c0d6-11e8-8d13-0800279cc012','0cdf88ba-a62f-11e8-b258-0800279cc012',1,'1'),('34c8d636-c0d6-11e8-8d13-0800279cc012','1c01164d-a62f-11e8-b258-0800279cc012',1,'1'),('3f15dad3-c0d6-11e8-8d13-0800279cc012','b8d5372b-a62e-11e8-b258-0800279cc012',1,'1'),('4c3cbe98-c0d6-11e8-8d13-0800279cc012','9c6e039f-a638-11e8-b258-0800279cc012',1,'1');
/*!40000 ALTER TABLE `consumible` ENABLE KEYS */;
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
  `idSabor1` char(36) NOT NULL,
  `idSabor2` char(36) NOT NULL,
  `idTopping` char(36) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_detalleOrden_factura1_idx` (`idFactura`),
  KEY `fk_detalleOrden_sabor1_idx` (`idSabor1`),
  KEY `fk_detalleOrden_sabor2_idx` (`idSabor2`),
  KEY `fk_detalleOrden_topping_idx` (`idTopping`),
  CONSTRAINT `fk_detalleOrden_factura1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleOrden_sabor1` FOREIGN KEY (`idSabor1`) REFERENCES `insumosXBodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleOrden_sabor2` FOREIGN KEY (`idSabor2`) REFERENCES `insumosXBodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalleOrden_topping` FOREIGN KEY (`idTopping`) REFERENCES `insumosXBodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Detalle de la orden vendida, tamaño, sabores, toppin';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalleOrden`
--

LOCK TABLES `detalleOrden` WRITE;
/*!40000 ALTER TABLE `detalleOrden` DISABLE KEYS */;
INSERT INTO `detalleOrden` VALUES ('0600f889-c326-11e8-8d13-0800279cc012',1,'3f6731fc-4c22-4092-b945-53d774a698a1','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('06053bea-c326-11e8-8d13-0800279cc012',1,'3f6731fc-4c22-4092-b945-53d774a698a1','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('060a4390-c326-11e8-8d13-0800279cc012',1,'3f6731fc-4c22-4092-b945-53d774a698a1','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('060f65bc-c326-11e8-8d13-0800279cc012',1,'3f6731fc-4c22-4092-b945-53d774a698a1','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('061472c9-c326-11e8-8d13-0800279cc012',1,'3f6731fc-4c22-4092-b945-53d774a698a1','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('061fe616-c326-11e8-8d13-0800279cc012',1,'3f6731fc-4c22-4092-b945-53d774a698a1','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('06278e51-c326-11e8-8d13-0800279cc012',1,'3f6731fc-4c22-4092-b945-53d774a698a1','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('06eb4bab-c25c-11e8-8d13-0800279cc012',1,'f1068a5c-1448-4f93-99cd-d17cbdcd082b','b0569046-c19a-11e8-8d13-0800279cc012','b0569046-c19a-11e8-8d13-0800279cc012','b2e605c6-c1ae-11e8-8d13-0800279cc012',1),('1b6fca34-c25c-11e8-8d13-0800279cc012',0,'d972ec75-32f1-4e54-9616-b27430166bfd','b05cb468-c19a-11e8-8d13-0800279cc012','b05cb468-c19a-11e8-8d13-0800279cc012','b2e605c6-c1ae-11e8-8d13-0800279cc012',1),('1b7439d9-c25c-11e8-8d13-0800279cc012',0,'d972ec75-32f1-4e54-9616-b27430166bfd','b05cb468-c19a-11e8-8d13-0800279cc012','b05cb468-c19a-11e8-8d13-0800279cc012','b2e605c6-c1ae-11e8-8d13-0800279cc012',1),('26398045-c25c-11e8-8d13-0800279cc012',1,'1af65ded-a670-4382-a497-ef31856200dc','b0569046-c19a-11e8-8d13-0800279cc012','b0569046-c19a-11e8-8d13-0800279cc012','b2e605c6-c1ae-11e8-8d13-0800279cc012',1),('332dcd71-c25c-11e8-8d13-0800279cc012',1,'8a92406a-cb9d-4d16-b6f4-a1fe0c5e9ba1','b0569046-c19a-11e8-8d13-0800279cc012','b05cb468-c19a-11e8-8d13-0800279cc012',NULL,1),('52db1b70-c19b-11e8-8d13-0800279cc012',1,'16469d1d-d36a-47a2-a1ec-e644ff9f49c7','b0569046-c19a-11e8-8d13-0800279cc012','b05cb468-c19a-11e8-8d13-0800279cc012',NULL,1),('57e7528f-c2b2-11e8-8d13-0800279cc012',1,'7449f37e-4f29-408d-810b-77bc46e32e46','b0569046-c19a-11e8-8d13-0800279cc012','b05cb468-c19a-11e8-8d13-0800279cc012','b2e605c6-c1ae-11e8-8d13-0800279cc012',1),('6a2f519d-c19b-11e8-8d13-0800279cc012',0,'f0ebcd3b-c417-4e93-9728-2eeb1df6f06a','b0569046-c19a-11e8-8d13-0800279cc012','b05cb468-c19a-11e8-8d13-0800279cc012',NULL,1),('7ecc0dd8-c2a1-11e8-8d13-0800279cc012',1,'83b642b0-91e2-4fb2-8c73-4d58a333c1d2','b05cb468-c19a-11e8-8d13-0800279cc012','b05cb468-c19a-11e8-8d13-0800279cc012','b2e605c6-c1ae-11e8-8d13-0800279cc012',1),('815635a6-c1c7-11e8-8d13-0800279cc012',1,'b1e99443-fbd2-4aa3-a3ce-f9717696678c','b05cb468-c19a-11e8-8d13-0800279cc012','b05cb468-c19a-11e8-8d13-0800279cc012','b2e605c6-c1ae-11e8-8d13-0800279cc012',1),('8d024582-c1c7-11e8-8d13-0800279cc012',0,'0ac26497-4dfd-4836-8996-49ada654f672','b0569046-c19a-11e8-8d13-0800279cc012','b0569046-c19a-11e8-8d13-0800279cc012','b2e605c6-c1ae-11e8-8d13-0800279cc012',1),('934decb3-c726-11e8-8d13-0800279cc012',1,'a0f87372-7bba-489b-a189-dddb8feab4dd','b0569046-c19a-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012','b2e605c6-c1ae-11e8-8d13-0800279cc012',1),('99de1f51-c1c7-11e8-8d13-0800279cc012',1,'f0a4ab8c-bc58-4577-9f0d-0eb56571d94f','b0569046-c19a-11e8-8d13-0800279cc012','b05cb468-c19a-11e8-8d13-0800279cc012','b2e605c6-c1ae-11e8-8d13-0800279cc012',1),('a64537fd-c1c7-11e8-8d13-0800279cc012',0,'f66f4433-3e9d-47b9-9a2a-77e9d64f9555','b0569046-c19a-11e8-8d13-0800279cc012','b05cb468-c19a-11e8-8d13-0800279cc012',NULL,1),('dccde038-c325-11e8-8d13-0800279cc012',0,'9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('dcd2020e-c325-11e8-8d13-0800279cc012',0,'9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('dcd72bf7-c325-11e8-8d13-0800279cc012',0,'9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('dcdc3e45-c325-11e8-8d13-0800279cc012',0,'9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('dce14601-c325-11e8-8d13-0800279cc012',0,'9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('dce66ac4-c325-11e8-8d13-0800279cc012',0,'9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('dceb7d95-c325-11e8-8d13-0800279cc012',0,'9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('dcf5a3a1-c325-11e8-8d13-0800279cc012',0,'9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('dcfd46ab-c325-11e8-8d13-0800279cc012',0,'9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1),('dd025944-c325-11e8-8d13-0800279cc012',0,'9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','56796c9d-c325-11e8-8d13-0800279cc012','56796c9d-c325-11e8-8d13-0800279cc012',NULL,1);
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
  `idEstado` char(36) NOT NULL DEFAULT '0',
  `fechaAceptacion` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_distribucion_usuario1_idx` (`idUsuario`),
  KEY `fk_distribucion_bodega1_idx` (`idBodega`),
  KEY `fk_distribucion_estado1_idx` (`idEstado`),
  CONSTRAINT `fk_distribucion_bodega1` FOREIGN KEY (`idBodega`) REFERENCES `bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_distribucion_estado1` FOREIGN KEY (`idEstado`) REFERENCES `estado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_distribucion_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distribucion`
--

LOCK TABLES `distribucion` WRITE;
/*!40000 ALTER TABLE `distribucion` DISABLE KEYS */;
INSERT INTO `distribucion` VALUES ('3adc5a92-9937-425b-af4e-82118300dced','2018-09-26 14:44:36',1,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','715da8ec-e431-43e3-9dfc-f77e5c64c296',0.00,13.00,'1','2018-09-26 14:44:36'),('63cc0b1b-bc55-48da-a179-39578a0d45dc','2018-09-28 13:49:36',4,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','715da8ec-e431-43e3-9dfc-f77e5c64c296',0.00,13.00,'1','2018-09-28 13:49:36'),('d14e4f26-f176-49e1-9e0a-6343fbcbf445','2018-09-27 14:10:18',3,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','d6cd8440-8906-4e4a-9e08-8af36695c5eb',0.00,13.00,'0',NULL),('fe45d517-feb4-436a-9767-a338eadc22a2','2018-09-26 17:07:50',2,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','715da8ec-e431-43e3-9dfc-f77e5c64c296',0.00,13.00,'1','2018-09-26 17:07:50');
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
	
	SELECT orden
	INTO @nnumeroorden
	FROM distribucion
	ORDER BY orden DESC LIMIT 1;
    IF @nnumeroorden IS NULL then
		set @nnumeroorden=0;
	END IF;
	
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
INSERT INTO `estado` VALUES ('0','EN PROCESO'),('1','LIQUIDADO'),('2','CANCELADO');
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
  `icono` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `evento`
--

LOCK TABLES `evento` WRITE;
/*!40000 ALTER TABLE `evento` DISABLE KEYS */;
INSERT INTO `evento` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873104','Reporte Producto','InventarioProductoReporte.html','Reportes',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','Dashboard','Dashboard.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','Nuevo Producto Terminado','Producto.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','Inventario de Producto Terminado','InventarioProducto.html','Reportes',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','Facturacion Agencia','FacturaCli.html','Facturacion',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','Lista de Facturas','InventarioFactura.html','Facturacion',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','Nuevo Usuario','Usuario.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','Lista de Usuarios','InventarioUsuario.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','Nuevo Rol','Rol.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','Lista de Roles','InventarioRol.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','Nueva Materia Prima','Insumo.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','Inventario de Materia Prima','InventarioInsumo.html','Reportes',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','Elaborar Producto Terminado','ElaborarProducto.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','Nueva Agencia','Bodega.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','Lista de Agencias','InventarioBodega.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','Traslados y Facturacion','Distribucion.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','Entradas de Insumos','OrdenCompra.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','Orden de Produccion','OrdenSalida.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','Inventario Orden de Produccion','InventarioOrdenSalida.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','Ingreso Bodega de Agencia','AceptarDistribucion.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','Agregar Ip','ip.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','Lista de IP','InventarioIp.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','Determinacion de Precios Tropical Sno','DeterminacionPrecio.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','Determinacion de Precios Agencia','DeterminacionPrecioVenta.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','Inventario por Agencia','InsumosBodega.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','Despacho','Fabricar.html','Facturacion',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a96','Ver Traslados y Facturación','InventarioDistribucion.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a97','Facturacion Electrónica','clienteFE.html','Sistema',NULL,'fa fa-cog'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a98','Gestion de Cajas','Caja.html','Facturacion',NULL,'fa fa-money'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a99','Merma','merma.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75874100','Lista Merma','InventarioMerma.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75874101','Gestion de consumibles','consumibles.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75874102','Mis Cajas','misCajas.html','Facturacion',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75874103','Mis Facturas','misFacturas.html','Facturacion',NULL,NULL),('3fb7769f-c17b-11e8-8d13-0800279cc012','Reporte Orden Compra','InventarioOrdenCompra.html','Reportes',NULL,NULL),('a3e14a75-bf88-11e8-8d13-0800279cc012','Reporte Materia Prima','InventarioInsumoReporte.html','Reportes',NULL,NULL),('b2b8b944-c2db-11e8-8d13-0800279cc012','Reporte Ventas','InventarioVentasReporte.html','Reportes',NULL,NULL);
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
INSERT INTO `eventosXRol` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873104','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','31221f87-1b60-48d1-a0ce-68457d1298c1'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','5f9bd173-9369-47d5-a1b8-fe5ab8234c61'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','5f9bd173-9369-47d5-a1b8-fe5ab8234c61'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','31221f87-1b60-48d1-a0ce-68457d1298c1'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a96','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a97','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a98','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a99','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75874100','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75874101','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75874102','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75874102','5f9bd173-9369-47d5-a1b8-fe5ab8234c61'),('1ed3a48c-3e44-11e8-9ddb-54ee75874103','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75874103','5f9bd173-9369-47d5-a1b8-fe5ab8234c61'),('3fb7769f-c17b-11e8-8d13-0800279cc012','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('a3e14a75-bf88-11e8-8d13-0800279cc012','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('b2b8b944-c2db-11e8-8d13-0800279cc012','1ed3a48c-3e44-11e8-9ddb-54ee75873a80');
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
  `idBodega` char(36) DEFAULT NULL,
  `fechaCreacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `consecutivo` int(11) NOT NULL DEFAULT '0' COMMENT 'debe tener un trigger para aumentar su valor',
  `local` varchar(3) NOT NULL,
  `terminal` varchar(5) NOT NULL,
  `idCondicionVenta` int(11) NOT NULL,
  `idSituacionComprobante` int(11) NOT NULL DEFAULT '1',
  `idEstadoComprobante` char(11) NOT NULL DEFAULT '1',
  `plazoCredito` varchar(10) DEFAULT NULL,
  `idMedioPago` int(11) NOT NULL,
  `idCodigoMoneda` int(11) DEFAULT NULL,
  `tipoCambio` decimal(18,5) DEFAULT NULL,
  `totalServGravados` decimal(18,5) DEFAULT NULL,
  `totalServExentos` decimal(18,5) DEFAULT NULL,
  `totalMercanciasGravadas` decimal(18,5) DEFAULT NULL,
  `totalMercanciasExentas` decimal(18,5) DEFAULT NULL,
  `totalGravado` decimal(18,5) DEFAULT NULL,
  `totalExento` decimal(18,5) DEFAULT NULL,
  `fechaEmision` varchar(45) DEFAULT NULL COMMENT 'Estandar:\n\n\nEj: usando ''T''\n2018-06-30T16:30:05-06:00',
  `codigoReferencia` int(11) DEFAULT NULL,
  `totalVenta` decimal(18,5) NOT NULL,
  `totalDescuentos` decimal(18,5) NOT NULL,
  `totalVentaneta` decimal(18,5) NOT NULL,
  `totalImpuesto` decimal(18,5) NOT NULL,
  `totalComprobante` decimal(18,5) NOT NULL,
  `idReceptor` char(36) DEFAULT NULL,
  `idEmisor` char(36) NOT NULL,
  `idUsuario` char(36) NOT NULL,
  `tipoDocumento` varchar(2) DEFAULT NULL,
  `montoEfectivo` decimal(18,5) DEFAULT NULL,
  `montoTarjeta` decimal(18,5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_factura_clienteFE1_idx` (`idEmisor`),
  KEY `fk_factura_receptor1_idx` (`idReceptor`),
  KEY `fk_factura_medioPago1_idx` (`idMedioPago`),
  CONSTRAINT `fk_factura_clienteFE1` FOREIGN KEY (`idEmisor`) REFERENCES `clienteFE` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_receptor1` FOREIGN KEY (`idReceptor`) REFERENCES `receptor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='facturas de ventas';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES ('0ac26497-4dfd-4836-8996-49ada654f672','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-26 20:05:46',4,'2','00001',1,1,'5','0',2,55,582.83000,0.00000,0.00000,1327.43363,0.00000,1327.43363,0.00000,'2018-09-26T14:05:45-06:00',1,1327.43363,0.00000,1327.43363,172.56637,1500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',NULL,NULL),('16469d1d-d36a-47a2-a1ec-e644ff9f49c7','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-26 14:49:11',1,'2','00001',1,1,'5','0',1,55,582.83000,0.00000,0.00000,2212.38938,0.00000,2212.38938,0.00000,'2018-09-26T08:49:09-06:00',1,2212.38938,0.00000,2212.38938,287.61062,2500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',NULL,NULL),('1af65ded-a670-4382-a497-ef31856200dc','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-27 13:49:31',9,'2','00001',1,1,'4','0',1,55,582.83000,0.00000,0.00000,2212.38938,0.00000,2212.38938,0.00000,'2018-09-27T07:49:27-06:00',1,2212.38938,0.00000,2212.38938,287.61062,2500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',NULL,NULL),('3f6731fc-4c22-4092-b945-53d774a698a1','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-28 13:54:35',14,'2','00001',1,1,'4','0',1,55,582.83000,0.00000,0.00000,15486.72566,0.00000,15486.72566,0.00000,'2018-09-28T07:54:32-06:00',1,15486.72566,0.00000,15486.72566,2013.27434,17500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',18000.00000,NULL),('7449f37e-4f29-408d-810b-77bc46e32e46','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-28 00:06:34',12,'2','00001',1,1,'4','0',2,55,582.83000,0.00000,0.00000,2212.38938,0.00000,2212.38938,0.00000,'2018-09-27T18:06:27-06:00',1,2212.38938,0.00000,2212.38938,287.61062,2500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1ed3a48c-3e44-11e8-9ddb-54ee75873a60','FE',0.00000,NULL),('83b642b0-91e2-4fb2-8c73-4d58a333c1d2','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-27 22:05:58',11,'2','00001',1,1,'5','0',1,55,582.83000,0.00000,0.00000,2212.38938,0.00000,2212.38938,0.00000,'2018-09-27T16:05:51-06:00',1,2212.38938,0.00000,2212.38938,287.61062,2500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1ed3a48c-3e44-11e8-9ddb-54ee75873a60','FE',2500.00000,NULL),('8a92406a-cb9d-4d16-b6f4-a1fe0c5e9ba1','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-27 13:49:53',10,'2','00001',1,1,'4','0',2,55,582.83000,0.00000,0.00000,2212.38938,0.00000,2212.38938,0.00000,'2018-09-27T07:49:49-06:00',1,2212.38938,0.00000,2212.38938,287.61062,2500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',NULL,NULL),('9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-28 13:53:27',13,'2','00001',1,1,'4','0',1,55,582.83000,0.00000,0.00000,13274.33628,0.00000,13274.33628,0.00000,'2018-09-28T07:53:23-06:00',1,13274.33628,0.00000,13274.33628,1725.66372,15000.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',15000.00000,NULL),('a0f87372-7bba-489b-a189-dddb8feab4dd','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-10-03 16:08:38',15,'2','00001',1,1,'4','0',1,55,582.83000,0.00000,0.00000,2212.38938,0.00000,2212.38938,0.00000,'2018-10-03T10:08:33-06:00',1,2212.38938,0.00000,2212.38938,287.61062,2500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',2500.00000,NULL),('b1e99443-fbd2-4aa3-a3ce-f9717696678c','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-26 20:05:28',3,'2','00001',1,1,'5','0',1,55,582.83000,0.00000,0.00000,2212.38938,0.00000,2212.38938,0.00000,'2018-09-26T14:05:25-06:00',1,2212.38938,0.00000,2212.38938,287.61062,2500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',NULL,NULL),('d972ec75-32f1-4e54-9616-b27430166bfd','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-27 13:49:16',8,'2','00001',1,1,'4','0',2,55,582.83000,0.00000,0.00000,2654.86726,0.00000,2654.86726,0.00000,'2018-09-27T07:49:09-06:00',1,2654.86726,0.00000,2654.86726,345.13274,3000.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',NULL,NULL),('f0a4ab8c-bc58-4577-9f0d-0eb56571d94f','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-26 20:06:09',5,'2','00001',1,1,'5','0',1,55,582.83000,0.00000,0.00000,2212.38938,0.00000,2212.38938,0.00000,'2018-09-26T14:06:06-06:00',1,2212.38938,0.00000,2212.38938,287.61062,2500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',NULL,NULL),('f0ebcd3b-c417-4e93-9728-2eeb1df6f06a','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-26 14:49:50',2,'2','00001',1,1,'5','0',2,55,582.83000,0.00000,0.00000,1327.43363,0.00000,1327.43363,0.00000,'2018-09-26T08:49:48-06:00',1,1327.43363,0.00000,1327.43363,172.56637,1500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',NULL,NULL),('f1068a5c-1448-4f93-99cd-d17cbdcd082b','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-27 13:48:39',7,'2','00001',1,1,'4','0',1,55,582.83000,0.00000,0.00000,2212.38938,0.00000,2212.38938,0.00000,'2018-09-27T07:48:35-06:00',1,2212.38938,0.00000,2212.38938,287.61062,2500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',NULL,NULL),('f66f4433-3e9d-47b9-9a2a-77e9d64f9555','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-26 20:06:29',6,'2','00001',1,1,'5','0',2,55,582.83000,0.00000,0.00000,1327.43363,0.00000,1327.43363,0.00000,'2018-09-26T14:06:27-06:00',1,1327.43363,0.00000,1327.43363,172.56637,1500.00000,'3636f62d-c29a-4d5f-81fa-479c5c152455','69f797b5-7578-4a61-bbc9-379b87603ab5','1e03b970-2778-43fb-aff6-444043d2bf51','FE',NULL,NULL);
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
	
	SELECT consecutivo
	INTO @nnumeroconsecutivo
	FROM factura
	ORDER BY consecutivo DESC LIMIT 1;
    IF @nnumeroconsecutivo IS NULL then
		set @nnumeroconsecutivo=0;
	END IF;
	
	SET NEW.consecutivo = @nnumeroconsecutivo+1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `historicoComprobante`
--

DROP TABLE IF EXISTS `historicoComprobante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `historicoComprobante` (
  `id` char(36) NOT NULL,
  `idFactura` char(36) NOT NULL,
  `idEstadoComprobante` int(11) NOT NULL,
  `respuesta` varchar(1000) DEFAULT NULL,
  `xml` varchar(10000) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `fk_factura_idx` (`idFactura`),
  KEY `fk_estado_idx` (`idEstadoComprobante`),
  CONSTRAINT `fk_factura` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Tabla de histórico de comprobantes enviados a MH.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historicoComprobante`
--

LOCK TABLES `historicoComprobante` WRITE;
/*!40000 ALTER TABLE `historicoComprobante` DISABLE KEYS */;
INSERT INTO `historicoComprobante` VALUES ('53562c7a-c19b-11e8-8d13-0800279cc012','16469d1d-d36a-47a2-a1ec-e644ff9f49c7',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50626091800011187076300200001010000000001100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000001</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-26T08:49:09-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>01</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>Venta de producto 12oz, BLUH, PINE, NTOP</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>2212.38938</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>2212.38938</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>2212.38938</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>2212.38938</TotalVentaNeta>\r\n        <TotalImpuesto>287.61062</TotalImpuesto>\r\n        <TotalComprobante>2500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-26 14:49:09'),('5486fb6d-c19b-11e8-8d13-0800279cc012','16469d1d-d36a-47a2-a1ec-e644ff9f49c7',5,'Comprobante ENVIADO con error, STATUS(400): \r\n{\"resp\":{\"Status\":400,\"to\":\"api-stag\",\"text\":[\"HTTP\\/1.1 100 Continue\\r\",\"\\r\",\"HTTP\\/1.1 400 Bad Request\\r\",\"Date: Wed, 26 Sep 2018 14:49:11 GMT\\r\",\"Content-Type: application\\/json\\r\",\"Content-Length: 0\\r\",\"Connection: keep-alive\\r\",\"Set-Cookie: __cfduid=d7f65d235b0ff5d45dc78ed381b4e987f1537973351; expires=Thu, 26-Sep-19 14:49:11 GMT; path=\\/; domain=.comprobanteselectronicos.go.cr; HttpOnly\\r\",\"Accept: *\\/*\\r\",\"Accept-Encoding: gzip\\r\",\"Access-Control-Allow-Headers: Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers\\r\",\"Access-Control-Allow-Methods: GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, CONNECT, PATCH\\r\",\"Access-Control-Allow-Origin: *\\r\",\"Access-Control-Max-Age: 3600\\r\",\"Breadcrumbid: ID-pebpriin0301-prod-comprobanteselectronicos-go-cr-44533-1536981307497-0-12296471\\r\",\"Jmsxgroupid: 50626091800011187076300200001010000000001100011154\\r\",\"User-Agent: Tyk\\/v2.7.0\\r\",\"X-Error-',NULL,'2018-09-26 14:49:11'),('6ac709d7-c19b-11e8-8d13-0800279cc012','f0ebcd3b-c417-4e93-9728-2eeb1df6f06a',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50626091800011187076300200001010000000002100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000002</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-26T08:49:48-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>02</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>Venta de producto 08oz, BLUH, PINE, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>1327.43363</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>1327.43363</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>1327.43363</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>1327.43363</TotalVentaNeta>\r\n        <TotalImpuesto>172.56637</TotalImpuesto>\r\n        <TotalComprobante>1500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-26 14:49:49'),('6bc4935a-c19b-11e8-8d13-0800279cc012','f0ebcd3b-c417-4e93-9728-2eeb1df6f06a',5,'Comprobante ENVIADO con error, STATUS(400): \r\n{\"resp\":{\"Status\":400,\"to\":\"api-stag\",\"text\":[\"HTTP\\/1.1 100 Continue\\r\",\"\\r\",\"HTTP\\/1.1 400 Bad Request\\r\",\"Date: Wed, 26 Sep 2018 14:49:50 GMT\\r\",\"Content-Type: application\\/json\\r\",\"Content-Length: 0\\r\",\"Connection: keep-alive\\r\",\"Set-Cookie: __cfduid=d7092a5ef64601b02078f0f57a05b11451537973390; expires=Thu, 26-Sep-19 14:49:50 GMT; path=\\/; domain=.comprobanteselectronicos.go.cr; HttpOnly\\r\",\"Accept: *\\/*\\r\",\"Accept-Encoding: gzip\\r\",\"Access-Control-Allow-Headers: Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers\\r\",\"Access-Control-Allow-Methods: GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, CONNECT, PATCH\\r\",\"Access-Control-Allow-Origin: *\\r\",\"Access-Control-Max-Age: 3600\\r\",\"Breadcrumbid: ID-pebpriin0301-prod-comprobanteselectronicos-go-cr-44533-1536981307497-0-12297187\\r\",\"Jmsxgroupid: 50626091800011187076300200001010000000002100011154\\r\",\"User-Agent: Tyk\\/v2.7.0\\r\",\"X-Error-',NULL,'2018-09-26 14:49:50'),('81de9a55-c1c7-11e8-8d13-0800279cc012','b1e99443-fbd2-4aa3-a3ce-f9717696678c',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50626091800011187076300200001010000000003100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000003</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-26T14:05:25-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>01</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>Venta de producto 12oz, PINE, PINE, TCOC</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>2212.38938</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>2212.38938</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>2212.38938</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>2212.38938</TotalVentaNeta>\r\n        <TotalImpuesto>287.61062</TotalImpuesto>\r\n        <TotalComprobante>2500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-26 20:05:25'),('8353faa0-c1c7-11e8-8d13-0800279cc012','b1e99443-fbd2-4aa3-a3ce-f9717696678c',5,'Comprobante ENVIADO con error, STATUS(400): \r\n{\"resp\":{\"Status\":400,\"to\":\"api-stag\",\"text\":[\"HTTP\\/1.1 100 Continue\\r\",\"\\r\",\"HTTP\\/1.1 400 Bad Request\\r\",\"Date: Wed, 26 Sep 2018 20:05:28 GMT\\r\",\"Content-Type: application\\/json\\r\",\"Content-Length: 0\\r\",\"Connection: keep-alive\\r\",\"Set-Cookie: __cfduid=db3a7a44177fdfb945e0f7929ba1406e21537992327; expires=Thu, 26-Sep-19 20:05:27 GMT; path=\\/; domain=.comprobanteselectronicos.go.cr; HttpOnly\\r\",\"Accept: *\\/*\\r\",\"Accept-Encoding: gzip\\r\",\"Access-Control-Allow-Headers: Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers\\r\",\"Access-Control-Allow-Methods: GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, CONNECT, PATCH\\r\",\"Access-Control-Allow-Origin: *\\r\",\"Access-Control-Max-Age: 3600\\r\",\"Breadcrumbid: ID-pebpriin0201-prod-comprobanteselectronicos-go-cr-39058-1536980662875-0-12656217\\r\",\"Jmsxgroupid: 50626091800011187076300200001010000000003100011154\\r\",\"User-Agent: Tyk\\/v2.7.0\\r\",\"X-Error-',NULL,'2018-09-26 20:05:28'),('8d8ef917-c1c7-11e8-8d13-0800279cc012','0ac26497-4dfd-4836-8996-49ada654f672',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50626091800011187076300200001010000000004100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000004</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-26T14:05:45-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>02</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>Venta de producto 08oz, BLUH, BLUH, TCOC</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>1327.43363</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>1327.43363</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>1327.43363</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>1327.43363</TotalVentaNeta>\r\n        <TotalImpuesto>172.56637</TotalImpuesto>\r\n        <TotalComprobante>1500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-26 20:05:45'),('8e7d97bd-c1c7-11e8-8d13-0800279cc012','0ac26497-4dfd-4836-8996-49ada654f672',5,'Comprobante ENVIADO con error, STATUS(400): \r\n{\"resp\":{\"Status\":400,\"to\":\"api-stag\",\"text\":[\"HTTP\\/1.1 100 Continue\\r\",\"\\r\",\"HTTP\\/1.1 400 Bad Request\\r\",\"Date: Wed, 26 Sep 2018 20:05:46 GMT\\r\",\"Content-Type: application\\/json\\r\",\"Content-Length: 0\\r\",\"Connection: keep-alive\\r\",\"Set-Cookie: __cfduid=d8e509d2e16ff218e1c2e7b0298d3bae91537992346; expires=Thu, 26-Sep-19 20:05:46 GMT; path=\\/; domain=.comprobanteselectronicos.go.cr; HttpOnly\\r\",\"Accept: *\\/*\\r\",\"Accept-Encoding: gzip\\r\",\"Access-Control-Allow-Headers: Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers\\r\",\"Access-Control-Allow-Methods: GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, CONNECT, PATCH\\r\",\"Access-Control-Allow-Origin: *\\r\",\"Access-Control-Max-Age: 3600\\r\",\"Breadcrumbid: ID-pebpriin0101-prod-comprobanteselectronicos-go-cr-39517-1537713567632-0-4113263\\r\",\"Jmsxgroupid: 50626091800011187076300200001010000000004100011154\\r\",\"User-Agent: Tyk\\/v2.7.0\\r\",\"X-Error-C',NULL,'2018-09-26 20:05:46'),('9a6636da-c1c7-11e8-8d13-0800279cc012','f0a4ab8c-bc58-4577-9f0d-0eb56571d94f',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50626091800011187076300200001010000000005100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000005</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-26T14:06:06-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>01</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>Venta de producto 12oz, BLUH, PINE, TCOC</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>2212.38938</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>2212.38938</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>2212.38938</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>2212.38938</TotalVentaNeta>\r\n        <TotalImpuesto>287.61062</TotalImpuesto>\r\n        <TotalComprobante>2500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-26 20:06:06'),('9c3d2fa7-c1c7-11e8-8d13-0800279cc012','f0a4ab8c-bc58-4577-9f0d-0eb56571d94f',5,'Comprobante ENVIADO con error, STATUS(400): \r\n{\"resp\":{\"Status\":400,\"to\":\"api-stag\",\"text\":[\"HTTP\\/1.1 100 Continue\\r\",\"\\r\",\"HTTP\\/1.1 400 Bad Request\\r\",\"Date: Wed, 26 Sep 2018 20:06:09 GMT\\r\",\"Content-Type: application\\/json\\r\",\"Content-Length: 0\\r\",\"Connection: keep-alive\\r\",\"Set-Cookie: __cfduid=de4232f5b181653fd5d8ddaaf7f2fd5dc1537992369; expires=Thu, 26-Sep-19 20:06:09 GMT; path=\\/; domain=.comprobanteselectronicos.go.cr; HttpOnly\\r\",\"Accept: *\\/*\\r\",\"Accept-Encoding: gzip\\r\",\"Access-Control-Allow-Headers: Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers\\r\",\"Access-Control-Allow-Methods: GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, CONNECT, PATCH\\r\",\"Access-Control-Allow-Origin: *\\r\",\"Access-Control-Max-Age: 3600\\r\",\"Breadcrumbid: ID-pebpriin0301-prod-comprobanteselectronicos-go-cr-44533-1536981307497-0-12646971\\r\",\"Jmsxgroupid: 50626091800011187076300200001010000000005100011154\\r\",\"User-Agent: Tyk\\/v2.7.0\\r\",\"X-Error-',NULL,'2018-09-26 20:06:09'),('a6bf9d66-c1c7-11e8-8d13-0800279cc012','f66f4433-3e9d-47b9-9a2a-77e9d64f9555',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50626091800011187076300200001010000000006100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000006</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-26T14:06:27-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>02</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>Venta de producto 08oz, BLUH, PINE, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>1327.43363</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>1327.43363</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>1327.43363</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>1327.43363</TotalVentaNeta>\r\n        <TotalImpuesto>172.56637</TotalImpuesto>\r\n        <TotalComprobante>1500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-26 20:06:27'),('a7c34994-c1c7-11e8-8d13-0800279cc012','f66f4433-3e9d-47b9-9a2a-77e9d64f9555',5,'Comprobante ENVIADO con error, STATUS(400): \r\n{\"resp\":{\"Status\":400,\"to\":\"api-stag\",\"text\":[\"HTTP\\/1.1 100 Continue\\r\",\"\\r\",\"HTTP\\/1.1 400 Bad Request\\r\",\"Date: Wed, 26 Sep 2018 20:06:29 GMT\\r\",\"Content-Type: application\\/json\\r\",\"Content-Length: 0\\r\",\"Connection: keep-alive\\r\",\"Set-Cookie: __cfduid=dbb91d29b3cad7b9d41de0128afa41c1d1537992389; expires=Thu, 26-Sep-19 20:06:29 GMT; path=\\/; domain=.comprobanteselectronicos.go.cr; HttpOnly\\r\",\"Accept: *\\/*\\r\",\"Accept-Encoding: gzip\\r\",\"Access-Control-Allow-Headers: Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers\\r\",\"Access-Control-Allow-Methods: GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, CONNECT, PATCH\\r\",\"Access-Control-Allow-Origin: *\\r\",\"Access-Control-Max-Age: 3600\\r\",\"Breadcrumbid: ID-pebpriin0201-prod-comprobanteselectronicos-go-cr-39058-1536980662875-0-12657605\\r\",\"Jmsxgroupid: 50626091800011187076300200001010000000006100011154\\r\",\"User-Agent: Tyk\\/v2.7.0\\r\",\"X-Error-',NULL,'2018-09-26 20:06:29'),('0777d893-c25c-11e8-8d13-0800279cc012','f1068a5c-1448-4f93-99cd-d17cbdcd082b',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50627091800011187076300200001010000000007100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000007</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-27T07:48:35-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>01</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, BLUH, BLUH, TCOC</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>2212.38938</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>2212.38938</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>2212.38938</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>2212.38938</TotalVentaNeta>\r\n        <TotalImpuesto>287.61062</TotalImpuesto>\r\n        <TotalComprobante>2500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-27 13:48:35'),('08505246-c25c-11e8-8d13-0800279cc012','f1068a5c-1448-4f93-99cd-d17cbdcd082b',2,'Comprobante ENVIADO, STATUS(202)',NULL,'2018-09-27 13:48:36'),('08c0daf1-c25c-11e8-8d13-0800279cc012','f1068a5c-1448-4f93-99cd-d17cbdcd082b',2,'procesando',NULL,'2018-09-27 13:48:37'),('09296c7b-c25c-11e8-8d13-0800279cc012','f1068a5c-1448-4f93-99cd-d17cbdcd082b',2,'procesando',NULL,'2018-09-27 13:48:38'),('09b6aaf3-c25c-11e8-8d13-0800279cc012','f1068a5c-1448-4f93-99cd-d17cbdcd082b',4,'rechazado','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<MensajeHacienda xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeHacienda\">\n    <Clave>50627091800011187076300200001010000000007100011154</Clave>\n    <NombreEmisor>Carlos Chacon Calvo</NombreEmisor>\n    <TipoIdentificacionEmisor>01</TipoIdentificacionEmisor>\n    <NumeroCedulaEmisor>111870763</NumeroCedulaEmisor>\n    <NombreReceptor>Carlos Chacon Calvo</NombreReceptor>\n    <TipoIdentificacionReceptor>01</TipoIdentificacionReceptor>\n    <NumeroCedulaReceptor>111870763</NumeroCedulaReceptor>\n    <Mensaje>3</Mensaje>\n    <DetalleMensaje>Este comprobante fue aceptado en el ambiente de pruebas, por lo cual no tiene validez para fines tributarios\n\nEl comprobante electrónico tiene los siguientes errores: \n\n[\ncodigo, mensaje, fila, columna\n-99, \"La numeración consecutiva del comprobante que se esta utilizando para este archivo XML ya existe en nuestras bases de datos.\", 0, 0\n-37, \"Estimado obligado tributario los datos suministrados en provincia, cantón y distrito del \'emisor\' no concuerdan con la información registrada en la Dirección General de Tributación, favor proceder actualizar sus datos.\", 0, 0\n\n]</DetalleMensaje>\n    <MontoTotalImpuesto>287.61062</MontoTotalImpuesto>\n    <TotalFactura>2500.00000</TotalFactura>\n<ds:Signature Id=\"id-65d9780dc2670c69234c73a93507d5a9\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><ds:SignedInfo><ds:CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/><ds:SignatureMethod Algorithm=\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\"/><ds:Reference Id=\"r-id-1\" Type=\"\" URI=\"\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/TR/1999/REC-xpath-19991116\"><ds:XPath>not(ancestor-or-self::ds:Signature)</ds:XPath></ds:Transform><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>vkcNVvrglmK3+hWT6FcFWgHJ5dgpHI7rdL/CFb3QAN8=</ds:DigestValue></ds:Reference><ds:Reference Type=\"http://uri.etsi.org/01903#SignedProperties\" URI=\"#xades-id-65d9780dc2670c69234c73a93507d5a9\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>e1qj+7ozoXG94+57I0DMnwWy4MRnsWVtw2Et++QGhdw=</ds:DigestValue></ds:Reference></ds:SignedInfo><ds:SignatureValue Id=\"value-id-65d9780dc2670c69234c73a93507d5a9\">ClZrT1ckfsfjYvgUgNljsFfYGJ3HaraIhomZ1hKkG3Vq6/n4HRb3U91F+zMdpgh3k2tI0tRoSJzWFNKlqimv8QWCdWSmPZ+s52+KmTaxcBQ4QhYTsczDPAVSsT8fLkNlE0v9dtyXeC2UxKepsbkNoW9RtKMnqlQU3Ck5nWJger13JaRbc/5nOMq5g11kBRRs0Gj3k6LNhWR3Ze0K2b1obJnIFrjA0+6B+ywo3uNLRtpyfc8+h4ugviEoOgFGjBDIFbDGN43jyASNG9PvS/xv4P1meG8Zk/WT/+0/1MhhDJes/FTHVZWxJypNvl1uSSQA828vIHXrFLSh2huWCekCww==</ds:SignatureValue><ds:KeyInfo><ds:X509Data><ds:X509Certificate>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</ds:X509Certificate><ds:X509Certificate>MIILSDCCCTCgAwIBAgITEgAAAAPvYiK7jLNK4wAAAAAAAzANBgkqhkiG9w0BAQ0FADB8MRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEPMA0GA1UEChMGTUlDSVRUMQ0wCwYDVQQLEwREQ0ZEMTIwMAYDVQQDEylDQSBQT0xJVElDQSBQRVJTT05BIEpVUklESUNBIC0gUFJVRUJBUyB2MjAeFw0xNTAzMTAyMjIzNDdaFw0yMzAzMTAyMjMzNDdaMIGlMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEkMCIGA1UEChMbQkFOQ08gQ0VOVFJBTCBERSBDT1NUQSBSSUNBMSIwIAYDVQQLExlESVZJU0lPTiBTSVNURU1BUyBERSBQQUdPMTEwLwYDVQQDEyhDQSBTSU5QRSAtIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq+zjbxp0Q5XaBHOMOFP49Avdovq/qrNl5NE+uMTVpCzo5uMod6/8iBobC4qin3aeQiWMQbw+gD+eBwJx7TpTMw2ViM9rBv6nEWOLOB+95MIWft/Smu7DTqTfbyQOjPOjA/RFkA3QeTGIWt6zVdv4HriIvi5BN0baXOU+iGyL179I8i5uD6TlqZdsLG4ToPv4SaunaWlqCNAtE9U9TeLFXcV+hiXZsh66mplcR6qeoTc9zaPO+68iTMzYH1/Iiroal1jblMzZ6VpaAr2U/2GQmzi4K3NQ6uM9hIp2I9FVlUo0CYpcdq/hDUkj5VjRYolfieSHFgjWzLm8Ps+TMMe6sQIDAQABo4IGlzCCBpMwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFAKP71QhjkHYoMoAoo5y5ATxz0jxMIIFCgYDVR0gBIIFATCCBP0wgfEGB2CBPAEBAQEwgeUwgbYGCCsGAQUFBwICMIGpHoGmAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABkAGUAIABsAGEAIABSAGEA7QB6ACAAQwBvAHMAdABhAHIAcgBpAGMAZQBuAHMAZQAgAGQAZQAgAEMAZQByAHQAaQBmAGkAYwBhAGMAaQDzAG4AIABEAGkAZwBpAHQAYQBsACAAUABSAFUARQBCAEEAUwAgAHYAMjAqBggrBgEFBQcCARYeaHR0cDovL2ZkaXBydWViYXMuZG16LXAubG9jYWwAMIIBMwYIYIE8AQEBAQEwggElMIH2BggrBgEFBQcCAjCB6R6B5gBJAG0AcABsAGUAbQBlAG4AdABhACAAbABhACAAUABvAGwA7QB0AGkAYwBhACAAZABlACAAQwBBACAARQBtAGkAcwBvAHIAYQAgAHAAYQByAGEAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFkBghggTwBAQEBBjCCAVYwggEmBggrBgEFBQcCAjCCARgeggEUAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABTAGUAbABsAG8AIABFAGwAZQBjAHQAcgDzAG4AaQBjAG8AIABkAGUAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFmBghggTwBAQEBBzCCAVgwggEoBggrBgEFBQcCAjCCARoeggEWAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABBAGcAZQBuAHQAZQAgAEUAbABlAGMAdAByAPMAbgBpAGMAbwAgAGQAZQAgAFAAZQByAHMAbwBuAGEAIABKAHUAcgDtAGQAaQBjAGEAIABwAGUAcgB0AGUAbgBlAGMAaQBlAG4AdABlACAAYQAgAGwAYQAgAFAASwBJACAATgBhAGMAaQBvAG4AYQBsACAAZABlACAAQwBvAHMAdABhACAAUgBpAGMAYQAgAFAAUgBVAEUAQgBBAFMAIAB2ADIwKgYIKwYBBQUHAgEWHmh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsADAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAfBgNVHSMEGDAWgBSEmr44xE3kUOd4PC/mbGmSsBzYXDB0BgNVHR8EbTBrMGmgZ6BlhmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcmwwfwYIKwYBBQUHAQEEczBxMG8GCCsGAQUFBzAChmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcnQwDQYJKoZIhvcNAQENBQADggIBAE1SoIlIQzn2thpr8UlZWrPqxMm8vnFJUQql9O6K8ZaJ9ZFJZY8oF1V4Mf8Ouljhyec37YaTh0a4rhOaN2eyDASqKA+6ThP5LaA0+Zm+E4/BRhLhYWj+vYlOQVVKfNzwMnMcdbbYGgL1orRWG+WHhYZr82s6OAezoB4P+XO2554tYusGR76SopNnkSiLiGb8UL0A4qq7fzowURmJEit5bADa7mQVhRwwdlevMngaWRUhdcZVKjCrwoDYBaSGJiILOIXqHHWi1pW/QhysnGZ6bT+R1eYY37IfHRea8f3urbrOcy5XqlSanjFBWcSjQfUtVbI4D4n4InZuF9y2lRIUcP/J4YnKz9K78bf3RnSlIPyCRhceifHW49/KQM5OHrLogK2S+tyttxyxqgXHUCWu9fLAc03cEAdab04HxqW0E2ULquUe7UljXPUm9Ya95FUiERBJj+xZOHYBftTwNsd2bcDHMWgfvtCqWWcl4g8McnTn9c9T7q2jJ9BBjg6OhPMf+/d3e/pFLLn+OEWaq8PMCHN032icFewi2Bzk3o9Daq0HYu/P+w+pP2WajNpw+3Wo8GDtTSDWDiFRmBUrizVa1gX0qp4fsiUx9FfL8d+4SooY4QLjhjIc9OV5OVSEH/G6Yq2YbsBIQDw1DGZ1K9Vl15DBtYIX6oXCaKdULzQR3fQ/</ds:X509Certificate><ds:X509Certificate>MIIM5TCCCs2gAwIBAgITSAAAAAk+FKoquz2LmAAAAAAACTANBgkqhkiG9w0BAQ0FADBwMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQ0wCwYDVQQLEwREQ0ZEMQ8wDQYDVQQKEwZNSUNJVFQxCzAJBgNVBAYTAkNSMSYwJAYDVQQDEx1DQSBSQUlaIE5BQ0lPTkFMIC0gUFJVRUJBUyB2MjAeFw0xNTAzMDkyMTU3MjZaFw0zMTAzMDkyMjA3MjZaMHwxGTAXBgNVBAUTEENQSi05LTk5OS05OTk5OTkxCzAJBgNVBAYTAkNSMQ8wDQYDVQQKEwZNSUNJVFQxDTALBgNVBAsTBERDRkQxMjAwBgNVBAMTKUNBIFBPTElUSUNBIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqn7lrxp/k6KJum9OjWlGruL0/vFj9zZgtyzEJRtxWPgo3gKirpefP/5taRCyE5ovQ0cpGV1R9fOHJmD5JgAUuPh3PBJCGQypo/xHqxSKO4gKoJrCacolqNiijQ5Uc+cX+z4vIDKgYp3e7DwGsv+PaZPUBeQEkG2VUgwiP5tOwAYjKfglEqTpQL0MpYJkAZfN2HEYFN5Vj3HMSu5QVMwucRvrDHTx9rx+GQXO7nGWsROsGqZ/0ngd4DnehV805pdZ7SmZWuK2Vx8qDtdCx/SeN5CQ//BaKVyUhvaEzbY1ai0bMfyUeamKixHcRA9PrQi9ADJMVhV3wEJXjPPQcvJ3WrEwcpKXLESC1SovMwGfM6KDtTaBQLaIZEA1l/eepslwtvgl5wLxUY7nIj6JsHDWSG3MEgPUbS22YsIUbP3LyMp6Uo0d0P8kZiqUZMxshOxA43P8w7brbGa+8tvNpQhVQ1rZDYpbjYGFFj1eTCf1aRBsJ1NqfFVwYqTQt9SVkcE+o8mTSn+TC3LcRb2LFfox/xhaQvke4cq/STd0EiNJ3oVCcAHsIs+pfGSUUGFYFnM2zG7AVe+8duFZU1m+HRSsiwREnP/fs12MC18+tepIq3W0Z5IAmP6WR63W+AB45lBBGR0mwtNmTsEVpTd56Kt97eUbdxw4s/M+uqVTOEm/Br0CAwEAA','2018-09-27 13:48:39'),('1c168615-c25c-11e8-8d13-0800279cc012','d972ec75-32f1-4e54-9616-b27430166bfd',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50627091800011187076300200001010000000008100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000008</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-27T07:49:09-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>02</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, PINE, PINE, TCOC</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>2</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, PINE, PINE, TCOC</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>2654.86726</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>2654.86726</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>2654.86726</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>2654.86726</TotalVentaNeta>\r\n        <TotalImpuesto>345.13274</TotalImpuesto>\r\n        <TotalComprobante>3000.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-27 13:49:09'),('1e1854c2-c25c-11e8-8d13-0800279cc012','d972ec75-32f1-4e54-9616-b27430166bfd',2,'Comprobante ENVIADO, STATUS(202)',NULL,'2018-09-27 13:49:13'),('1eb0e745-c25c-11e8-8d13-0800279cc012','d972ec75-32f1-4e54-9616-b27430166bfd',2,'procesando',NULL,'2018-09-27 13:49:14'),('1f7098d6-c25c-11e8-8d13-0800279cc012','d972ec75-32f1-4e54-9616-b27430166bfd',2,'procesando',NULL,'2018-09-27 13:49:15'),('203a2e04-c25c-11e8-8d13-0800279cc012','d972ec75-32f1-4e54-9616-b27430166bfd',4,'rechazado','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<MensajeHacienda xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeHacienda\">\n    <Clave>50627091800011187076300200001010000000008100011154</Clave>\n    <NombreEmisor>Carlos Chacon Calvo</NombreEmisor>\n    <TipoIdentificacionEmisor>01</TipoIdentificacionEmisor>\n    <NumeroCedulaEmisor>111870763</NumeroCedulaEmisor>\n    <NombreReceptor>Carlos Chacon Calvo</NombreReceptor>\n    <TipoIdentificacionReceptor>01</TipoIdentificacionReceptor>\n    <NumeroCedulaReceptor>111870763</NumeroCedulaReceptor>\n    <Mensaje>3</Mensaje>\n    <DetalleMensaje>Este comprobante fue aceptado en el ambiente de pruebas, por lo cual no tiene validez para fines tributarios\n\nEl comprobante electrónico tiene los siguientes errores: \n\n[\ncodigo, mensaje, fila, columna\n-99, \"La numeración consecutiva del comprobante que se esta utilizando para este archivo XML ya existe en nuestras bases de datos.\", 0, 0\n-37, \"Estimado obligado tributario los datos suministrados en provincia, cantón y distrito del \'emisor\' no concuerdan con la información registrada en la Dirección General de Tributación, favor proceder actualizar sus datos.\", 0, 0\n\n]</DetalleMensaje>\n    <MontoTotalImpuesto>345.13274</MontoTotalImpuesto>\n    <TotalFactura>3000.00000</TotalFactura>\n<ds:Signature Id=\"id-90d8a1db2c876295573261b48cdde1b7\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><ds:SignedInfo><ds:CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/><ds:SignatureMethod Algorithm=\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\"/><ds:Reference Id=\"r-id-1\" Type=\"\" URI=\"\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/TR/1999/REC-xpath-19991116\"><ds:XPath>not(ancestor-or-self::ds:Signature)</ds:XPath></ds:Transform><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>fDGTvEbRhQGSw3+fSFs8Mq6ZURepi4hsvKpWyKYQdDc=</ds:DigestValue></ds:Reference><ds:Reference Type=\"http://uri.etsi.org/01903#SignedProperties\" URI=\"#xades-id-90d8a1db2c876295573261b48cdde1b7\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>zs1XC1MHF2m+NCdxsxvaXq5ZyiFm3oMMM8/C9K8Lags=</ds:DigestValue></ds:Reference></ds:SignedInfo><ds:SignatureValue Id=\"value-id-90d8a1db2c876295573261b48cdde1b7\">Pr6/txUqyI9vVRSmVsp3juiNF2zP9m7+M6177Z5ejgeSPz3HKZY8iTheKjNluXmGov3OKE3ffCkoJ+T+eJURu39b4nYbPlkNuoEneYzBFQEyu/c6+idF3W3DwTVHrx/f7H1FppVRsDPDs3ms/TQEcoYGE4bpA3kfI3pkpVnvrta7AX5+T1/DQvr88uEXN/f9FP5AwCiB2DpykSmGtt+5BTm/faHpuHRAgWlcJt1bUGFKfQ9mnNIr5VJlYwLlqZHFtk7kG+RXYvH1II28MnzQoNcqh2zrhczcj/kLm3TMC/ZANFHRAd1+XX3ubUh2bz/aCbEiUbDlz2i/eb1L4eihiA==</ds:SignatureValue><ds:KeyInfo><ds:X509Data><ds:X509Certificate>MIILSDCCCTCgAwIBAgITEgAAAAPvYiK7jLNK4wAAAAAAAzANBgkqhkiG9w0BAQ0FADB8MRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEPMA0GA1UEChMGTUlDSVRUMQ0wCwYDVQQLEwREQ0ZEMTIwMAYDVQQDEylDQSBQT0xJVElDQSBQRVJTT05BIEpVUklESUNBIC0gUFJVRUJBUyB2MjAeFw0xNTAzMTAyMjIzNDdaFw0yMzAzMTAyMjMzNDdaMIGlMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEkMCIGA1UEChMbQkFOQ08gQ0VOVFJBTCBERSBDT1NUQSBSSUNBMSIwIAYDVQQLExlESVZJU0lPTiBTSVNURU1BUyBERSBQQUdPMTEwLwYDVQQDEyhDQSBTSU5QRSAtIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq+zjbxp0Q5XaBHOMOFP49Avdovq/qrNl5NE+uMTVpCzo5uMod6/8iBobC4qin3aeQiWMQbw+gD+eBwJx7TpTMw2ViM9rBv6nEWOLOB+95MIWft/Smu7DTqTfbyQOjPOjA/RFkA3QeTGIWt6zVdv4HriIvi5BN0baXOU+iGyL179I8i5uD6TlqZdsLG4ToPv4SaunaWlqCNAtE9U9TeLFXcV+hiXZsh66mplcR6qeoTc9zaPO+68iTMzYH1/Iiroal1jblMzZ6VpaAr2U/2GQmzi4K3NQ6uM9hIp2I9FVlUo0CYpcdq/hDUkj5VjRYolfieSHFgjWzLm8Ps+TMMe6sQIDAQABo4IGlzCCBpMwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFAKP71QhjkHYoMoAoo5y5ATxz0jxMIIFCgYDVR0gBIIFATCCBP0wgfEGB2CBPAEBAQEwgeUwgbYGCCsGAQUFBwICMIGpHoGmAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABkAGUAIABsAGEAIABSAGEA7QB6ACAAQwBvAHMAdABhAHIAcgBpAGMAZQBuAHMAZQAgAGQAZQAgAEMAZQByAHQAaQBmAGkAYwBhAGMAaQDzAG4AIABEAGkAZwBpAHQAYQBsACAAUABSAFUARQBCAEEAUwAgAHYAMjAqBggrBgEFBQcCARYeaHR0cDovL2ZkaXBydWViYXMuZG16LXAubG9jYWwAMIIBMwYIYIE8AQEBAQEwggElMIH2BggrBgEFBQcCAjCB6R6B5gBJAG0AcABsAGUAbQBlAG4AdABhACAAbABhACAAUABvAGwA7QB0AGkAYwBhACAAZABlACAAQwBBACAARQBtAGkAcwBvAHIAYQAgAHAAYQByAGEAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFkBghggTwBAQEBBjCCAVYwggEmBggrBgEFBQcCAjCCARgeggEUAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABTAGUAbABsAG8AIABFAGwAZQBjAHQAcgDzAG4AaQBjAG8AIABkAGUAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFmBghggTwBAQEBBzCCAVgwggEoBggrBgEFBQcCAjCCARoeggEWAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABBAGcAZQBuAHQAZQAgAEUAbABlAGMAdAByAPMAbgBpAGMAbwAgAGQAZQAgAFAAZQByAHMAbwBuAGEAIABKAHUAcgDtAGQAaQBjAGEAIABwAGUAcgB0AGUAbgBlAGMAaQBlAG4AdABlACAAYQAgAGwAYQAgAFAASwBJACAATgBhAGMAaQBvAG4AYQBsACAAZABlACAAQwBvAHMAdABhACAAUgBpAGMAYQAgAFAAUgBVAEUAQgBBAFMAIAB2ADIwKgYIKwYBBQUHAgEWHmh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsADAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAfBgNVHSMEGDAWgBSEmr44xE3kUOd4PC/mbGmSsBzYXDB0BgNVHR8EbTBrMGmgZ6BlhmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcmwwfwYIKwYBBQUHAQEEczBxMG8GCCsGAQUFBzAChmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcnQwDQYJKoZIhvcNAQENBQADggIBAE1SoIlIQzn2thpr8UlZWrPqxMm8vnFJUQql9O6K8ZaJ9ZFJZY8oF1V4Mf8Ouljhyec37YaTh0a4rhOaN2eyDASqKA+6ThP5LaA0+Zm+E4/BRhLhYWj+vYlOQVVKfNzwMnMcdbbYGgL1orRWG+WHhYZr82s6OAezoB4P+XO2554tYusGR76SopNnkSiLiGb8UL0A4qq7fzowURmJEit5bADa7mQVhRwwdlevMngaWRUhdcZVKjCrwoDYBaSGJiILOIXqHHWi1pW/QhysnGZ6bT+R1eYY37IfHRea8f3urbrOcy5XqlSanjFBWcSjQfUtVbI4D4n4InZuF9y2lRIUcP/J4YnKz9K78bf3RnSlIPyCRhceifHW49/KQM5OHrLogK2S+tyttxyxqgXHUCWu9fLAc03cEAdab04HxqW0E2ULquUe7UljXPUm9Ya95FUiERBJj+xZOHYBftTwNsd2bcDHMWgfvtCqWWcl4g8McnTn9c9T7q2jJ9BBjg6OhPMf+/d3e/pFLLn+OEWaq8PMCHN032icFewi2Bzk3o9Daq0HYu/P+w+pP2WajNpw+3Wo8GDtTSDWDiFRmBUrizVa1gX0qp4fsiUx9FfL8d+4SooY4QLjhjIc9OV5OVSEH/G6Yq2YbsBIQDw1DGZ1K9Vl15DBtYIX6oXCaKdULzQR3fQ/</ds:X509Certificate><ds:X509Certificate>MIIF6TCCBNGgAwIBAgITYwAABakiV715urMhcwAAAAAFqTANBgkqhkiG9w0BAQsFADCBpTEZMBcGA1UEBRMQQ1BKLTktOTk5LTk5OTk5OTELMAkGA1UEBhMCQ1IxJDAiBgNVBAoTG0JBTkNPIENFTlRSQUwgREUgQ09TVEEgUklDQTEiMCAGA1UECxMZRElWSVNJT04gU0lTVEVNQVMgREUgUEFHTzExMC8GA1UEAxMoQ0EgU0lOUEUgLSBQRVJTT05BIEpVUklESUNBIC0gUFJVRUJBUyB2MjAeFw0xNzAzMDkxNTI1NTFaFw0yMTAzMDgxNTI1NTFaMIGsMRkwFwYDVQQFExBDUEotMi0xMDAtMDQyMDA1MQswCQYDVQQGEwJDUjEZMBcGA1UEChMQUEVSU09OQSBKVVJJRElDQTEpMCcGA1UECxMgRElSRUNDSU9OIEdFTkVSQUwgREUgVFJJQlVUQUNJT04xPDA6BgNVBAMTM01JTklTVEVSSU8gREUgSEFDSUVOREEgKFNFTExPIEVMRUNUUk9OSUNPKShQUlVFQkFTKTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALvfpCPAGN0xQQwHUJtiXu7FuWGFKbNrRPNTYOzzpIxwWyZ4B0CBKEXITGVfq8WaD+ddt57W1lfV3kPrl7MytnsEoSQKSEqmUTGkdVULdN67GKwNQf+eRwTUSBn4S1hlR9aYiT9uXrZFiRQ7McSwuGRiUC9jb9RW+REfmpUKjon6E/Di6L6450yzl9mPdnTNTUPBQ1FZ0e4SDCe0VczAoTTZDkcomq5Y6x9AlmXx57RgvsoyB7OhhrPmuruGjqw4ojs3DIo8R9P4PEEWJAZgcZ6BjBnw5btho55/NKSgXJbNSG3I9hp5+mBpZhSD0bFDxTw5aimmhyAIXkbniQBfUdsCAwEAAaOCAgcwggIDMA4GA1UdDwEB/wQEAwIGwDAdBgNVHQ4EFgQUK9GjpFVEZvnyj0dwyRDEGeXriAYwHwYDVR0jBBgwFoAUAo/vVCGOQdigygCijnLkBPHPSPEwdQYDVR0fBG4wbDBqoGigZoZkaHR0cDovL2ZkaXBydWViYXMuZG16LXAubG9jYWwvcmVwb3NpdG9yaW8vQ0ElMjBTSU5QRSUyMC0lMjBQRVJTT05BJTIwSlVSSURJQ0ElMjAtJTIwUFJVRUJBUyUyMHYyLmNybDCBsgYIKwYBBQUHAQEEgaUwgaIwcAYIKwYBBQUHMAKGZGh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsL3JlcG9zaXRvcmlvL0NBJTIwU0lOUEUlMjAtJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcnQwLgYIKwYBBQUHMAGGImh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsL29jc3AwPAYJKwYBBAGCNxUHBC8wLQYlKwYBBAGCNxUIs8RmgsThT4HlkyCEy4MYhNedawqG/OJzgvmTRAIBZAIBJjATBgNVHSUEDDAKBggrBgEFBQcDBDAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMEMBUGA1UdIAQOMAwwCgYIYIE8AQEBAQYwDQYJKoZIhvcNAQELBQADggEBAA1dTG7fE2H7VKbtMPalmMgsytSbOkAY0oqPKoKAQPYZLjGnLh0OdjwFnjvRSNeREX7tXy3nWs36iWiGlu9E9HIl+wA432BOInXZjm3sh+6pd81pksRd66oyM0ft4gAwVndDtRd9HnfLqZfV5zsXFD2htG1mHfuzuiQFuUJ34U06VeL6TwP+jbBFe1ooiyG3YMkyoJAlB3LgJHPYgR5HxdmSdfYYW8/ssJTl2jyYMK3qJP5MWmCrklUZxeJqbSzFbu7DlJVXTdt70p1zjDFCdQROzs9C9kctgshkZTHf73It8LslGRRdYXVl1v6LyQy2j7ltX8ihfe/tTHVWWP1BG0M=</ds:X509Certificate><ds:X509Certificate>MIIM5TCCCs2gAwIBAgITSAAAAAk+FKoquz2LmAAAAAAACTANBgkqhkiG9w0BAQ0FADBwMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQ0wCwYDVQQLEwREQ0ZEMQ8wDQYDVQQKEwZNSUNJVFQxCzAJBgNVBAYTAkNSMSYwJAYDVQQDEx1DQSBSQUlaIE5BQ0lPTkFMIC0gUFJVRUJBUyB2MjAeFw0xNTAzMDkyMTU3MjZaFw0zMTAzMDkyMjA3MjZaMHwxGTAXBgNVBAUTEENQSi05LTk5OS05OTk5OTkxCzAJBgNVBAYTAkNSMQ8wDQYDVQQKEwZNSUNJVFQxDTALBgNVBAsTBERDRkQxMjAwBgNVBAMTKUNBIFBPTElUSUNBIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqn7lrxp/k6KJum9OjWlGruL0/vFj9zZgtyzEJRtxWPgo3gKirpefP/5taRCyE5ovQ0cpGV1R9fOHJmD5JgAUuPh3PBJCGQypo/xHqxSKO4gKoJrCacolqNiijQ5Uc+cX+z4vIDKgYp3e7DwGsv+PaZPUBeQEkG2VUgwiP5tOwAYjKfglEqTpQL0MpYJkAZfN2HEYFN5Vj3HMSu5QVMwucRvrDHTx9rx+GQXO7nGWsROsGqZ/0ngd4DnehV805pdZ7SmZWuK2Vx8qDtdCx/SeN5CQ//BaKVyUhvaEzbY1ai0bMfyUeamKixHcRA9PrQi9ADJMVhV3wEJXjPPQcvJ3WrEwcpKXLESC1SovMwGfM6KDtTaBQLaIZEA1l/eepslwtvgl5wLxUY7nIj6JsHDWSG3MEgPUbS22YsIUbP3LyMp6Uo0d0P8kZiqUZMxshOxA43P8w7brbGa+8tvNpQhVQ1rZDYpbjYGFFj1eTCf1aRBsJ1NqfFVwYqTQt9SVkcE+o8mTSn+TC3LcRb2LFfox/xhaQvke4cq/STd0EiNJ3oVCcAHsIs+pfGSUUGFYFnM2zG7AVe+8duFZU1m+HRSsiwREnP/fs12MC18+tepIq3W0Z5IAmP6WR63W+AB45lBBGR0mwtNmTsEVpTd56Kt97eUbdxw4s/M+uqVTOEm/Br0CAwEAA','2018-09-27 13:49:16'),('26d49a26-c25c-11e8-8d13-0800279cc012','1af65ded-a670-4382-a497-ef31856200dc',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50627091800011187076300200001010000000009100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000009</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-27T07:49:27-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>01</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, BLUH, BLUH, TCOC</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>2212.38938</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>2212.38938</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>2212.38938</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>2212.38938</TotalVentaNeta>\r\n        <TotalImpuesto>287.61062</TotalImpuesto>\r\n        <TotalComprobante>2500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-27 13:49:27'),('278f587c-c25c-11e8-8d13-0800279cc012','1af65ded-a670-4382-a497-ef31856200dc',2,'Comprobante ENVIADO, STATUS(202)',NULL,'2018-09-27 13:49:29'),('281c06b7-c25c-11e8-8d13-0800279cc012','1af65ded-a670-4382-a497-ef31856200dc',2,'procesando',NULL,'2018-09-27 13:49:30'),('286a9103-c25c-11e8-8d13-0800279cc012','1af65ded-a670-4382-a497-ef31856200dc',2,'procesando',NULL,'2018-09-27 13:49:30'),('28baf4fb-c25c-11e8-8d13-0800279cc012','1af65ded-a670-4382-a497-ef31856200dc',2,'procesando',NULL,'2018-09-27 13:49:31'),('290d95f7-c25c-11e8-8d13-0800279cc012','1af65ded-a670-4382-a497-ef31856200dc',4,'rechazado','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<MensajeHacienda xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeHacienda\">\n    <Clave>50627091800011187076300200001010000000009100011154</Clave>\n    <NombreEmisor>Carlos Chacon Calvo</NombreEmisor>\n    <TipoIdentificacionEmisor>01</TipoIdentificacionEmisor>\n    <NumeroCedulaEmisor>111870763</NumeroCedulaEmisor>\n    <NombreReceptor>Carlos Chacon Calvo</NombreReceptor>\n    <TipoIdentificacionReceptor>01</TipoIdentificacionReceptor>\n    <NumeroCedulaReceptor>111870763</NumeroCedulaReceptor>\n    <Mensaje>3</Mensaje>\n    <DetalleMensaje>Este comprobante fue aceptado en el ambiente de pruebas, por lo cual no tiene validez para fines tributarios\n\nEl comprobante electrónico tiene los siguientes errores: \n\n[\ncodigo, mensaje, fila, columna\n-99, \"La numeración consecutiva del comprobante que se esta utilizando para este archivo XML ya existe en nuestras bases de datos.\", 0, 0\n-37, \"Estimado obligado tributario los datos suministrados en provincia, cantón y distrito del \'emisor\' no concuerdan con la información registrada en la Dirección General de Tributación, favor proceder actualizar sus datos.\", 0, 0\n\n]</DetalleMensaje>\n    <MontoTotalImpuesto>287.61062</MontoTotalImpuesto>\n    <TotalFactura>2500.00000</TotalFactura>\n<ds:Signature Id=\"id-b30fa57a4278c44e046529e0dd2a94af\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><ds:SignedInfo><ds:CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/><ds:SignatureMethod Algorithm=\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\"/><ds:Reference Id=\"r-id-1\" Type=\"\" URI=\"\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/TR/1999/REC-xpath-19991116\"><ds:XPath>not(ancestor-or-self::ds:Signature)</ds:XPath></ds:Transform><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>OGLj1zUSF6gPBYVdc5RXokAXVrEob10GYsYfxupEMWs=</ds:DigestValue></ds:Reference><ds:Reference Type=\"http://uri.etsi.org/01903#SignedProperties\" URI=\"#xades-id-b30fa57a4278c44e046529e0dd2a94af\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>vECnzh1ngyiAqofwvDIr31Xeh4yrs+bt1RkxzSAX/bc=</ds:DigestValue></ds:Reference></ds:SignedInfo><ds:SignatureValue Id=\"value-id-b30fa57a4278c44e046529e0dd2a94af\">PiAyT2qB1Czy8wCrXcvQeU0sup2d+I8+umt98Z+T37PavHNDME04Cxs0mwzTydo8bHzyVvUOV9InxQsVva+eKS/zGwzTb9IE+uIkuWPruWQCyZEENoHIOxlcbguGbyh5fGNuDbPomgNZ2QUMmr/Gfl7JX3wlE6hwDqUVevtNR5hg0Wg3QlJ2+VOol+FgZn/1sK90ALlSSG3v3M1Vr+jue5obNojCaT8F68VWPjYm77khscUAqBPLneoDodfCbWbaOqncdRRxBYr9sCprsDmPX6GEBqtlQs23c+sAcFRV0BOg7ayRyTYWWWve+1TIo5KIaqB9bT1pSTbmP7pTAeaMWg==</ds:SignatureValue><ds:KeyInfo><ds:X509Data><ds:X509Certificate>MIILSDCCCTCgAwIBAgITEgAAAAPvYiK7jLNK4wAAAAAAAzANBgkqhkiG9w0BAQ0FADB8MRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEPMA0GA1UEChMGTUlDSVRUMQ0wCwYDVQQLEwREQ0ZEMTIwMAYDVQQDEylDQSBQT0xJVElDQSBQRVJTT05BIEpVUklESUNBIC0gUFJVRUJBUyB2MjAeFw0xNTAzMTAyMjIzNDdaFw0yMzAzMTAyMjMzNDdaMIGlMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEkMCIGA1UEChMbQkFOQ08gQ0VOVFJBTCBERSBDT1NUQSBSSUNBMSIwIAYDVQQLExlESVZJU0lPTiBTSVNURU1BUyBERSBQQUdPMTEwLwYDVQQDEyhDQSBTSU5QRSAtIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq+zjbxp0Q5XaBHOMOFP49Avdovq/qrNl5NE+uMTVpCzo5uMod6/8iBobC4qin3aeQiWMQbw+gD+eBwJx7TpTMw2ViM9rBv6nEWOLOB+95MIWft/Smu7DTqTfbyQOjPOjA/RFkA3QeTGIWt6zVdv4HriIvi5BN0baXOU+iGyL179I8i5uD6TlqZdsLG4ToPv4SaunaWlqCNAtE9U9TeLFXcV+hiXZsh66mplcR6qeoTc9zaPO+68iTMzYH1/Iiroal1jblMzZ6VpaAr2U/2GQmzi4K3NQ6uM9hIp2I9FVlUo0CYpcdq/hDUkj5VjRYolfieSHFgjWzLm8Ps+TMMe6sQIDAQABo4IGlzCCBpMwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFAKP71QhjkHYoMoAoo5y5ATxz0jxMIIFCgYDVR0gBIIFATCCBP0wgfEGB2CBPAEBAQEwgeUwgbYGCCsGAQUFBwICMIGpHoGmAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABkAGUAIABsAGEAIABSAGEA7QB6ACAAQwBvAHMAdABhAHIAcgBpAGMAZQBuAHMAZQAgAGQAZQAgAEMAZQByAHQAaQBmAGkAYwBhAGMAaQDzAG4AIABEAGkAZwBpAHQAYQBsACAAUABSAFUARQBCAEEAUwAgAHYAMjAqBggrBgEFBQcCARYeaHR0cDovL2ZkaXBydWViYXMuZG16LXAubG9jYWwAMIIBMwYIYIE8AQEBAQEwggElMIH2BggrBgEFBQcCAjCB6R6B5gBJAG0AcABsAGUAbQBlAG4AdABhACAAbABhACAAUABvAGwA7QB0AGkAYwBhACAAZABlACAAQwBBACAARQBtAGkAcwBvAHIAYQAgAHAAYQByAGEAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFkBghggTwBAQEBBjCCAVYwggEmBggrBgEFBQcCAjCCARgeggEUAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABTAGUAbABsAG8AIABFAGwAZQBjAHQAcgDzAG4AaQBjAG8AIABkAGUAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFmBghggTwBAQEBBzCCAVgwggEoBggrBgEFBQcCAjCCARoeggEWAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABBAGcAZQBuAHQAZQAgAEUAbABlAGMAdAByAPMAbgBpAGMAbwAgAGQAZQAgAFAAZQByAHMAbwBuAGEAIABKAHUAcgDtAGQAaQBjAGEAIABwAGUAcgB0AGUAbgBlAGMAaQBlAG4AdABlACAAYQAgAGwAYQAgAFAASwBJACAATgBhAGMAaQBvAG4AYQBsACAAZABlACAAQwBvAHMAdABhACAAUgBpAGMAYQAgAFAAUgBVAEUAQgBBAFMAIAB2ADIwKgYIKwYBBQUHAgEWHmh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsADAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAfBgNVHSMEGDAWgBSEmr44xE3kUOd4PC/mbGmSsBzYXDB0BgNVHR8EbTBrMGmgZ6BlhmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcmwwfwYIKwYBBQUHAQEEczBxMG8GCCsGAQUFBzAChmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcnQwDQYJKoZIhvcNAQENBQADggIBAE1SoIlIQzn2thpr8UlZWrPqxMm8vnFJUQql9O6K8ZaJ9ZFJZY8oF1V4Mf8Ouljhyec37YaTh0a4rhOaN2eyDASqKA+6ThP5LaA0+Zm+E4/BRhLhYWj+vYlOQVVKfNzwMnMcdbbYGgL1orRWG+WHhYZr82s6OAezoB4P+XO2554tYusGR76SopNnkSiLiGb8UL0A4qq7fzowURmJEit5bADa7mQVhRwwdlevMngaWRUhdcZVKjCrwoDYBaSGJiILOIXqHHWi1pW/QhysnGZ6bT+R1eYY37IfHRea8f3urbrOcy5XqlSanjFBWcSjQfUtVbI4D4n4InZuF9y2lRIUcP/J4YnKz9K78bf3RnSlIPyCRhceifHW49/KQM5OHrLogK2S+tyttxyxqgXHUCWu9fLAc03cEAdab04HxqW0E2ULquUe7UljXPUm9Ya95FUiERBJj+xZOHYBftTwNsd2bcDHMWgfvtCqWWcl4g8McnTn9c9T7q2jJ9BBjg6OhPMf+/d3e/pFLLn+OEWaq8PMCHN032icFewi2Bzk3o9Daq0HYu/P+w+pP2WajNpw+3Wo8GDtTSDWDiFRmBUrizVa1gX0qp4fsiUx9FfL8d+4SooY4QLjhjIc9OV5OVSEH/G6Yq2YbsBIQDw1DGZ1K9Vl15DBtYIX6oXCaKdULzQR3fQ/</ds:X509Certificate><ds:X509Certificate>MIIF6TCCBNGgAwIBAgITYwAABakiV715urMhcwAAAAAFqTANBgkqhkiG9w0BAQsFADCBpTEZMBcGA1UEBRMQQ1BKLTktOTk5LTk5OTk5OTELMAkGA1UEBhMCQ1IxJDAiBgNVBAoTG0JBTkNPIENFTlRSQUwgREUgQ09TVEEgUklDQTEiMCAGA1UECxMZRElWSVNJT04gU0lTVEVNQVMgREUgUEFHTzExMC8GA1UEAxMoQ0EgU0lOUEUgLSBQRVJTT05BIEpVUklESUNBIC0gUFJVRUJBUyB2MjAeFw0xNzAzMDkxNTI1NTFaFw0yMTAzMDgxNTI1NTFaMIGsMRkwFwYDVQQFExBDUEotMi0xMDAtMDQyMDA1MQswCQYDVQQGEwJDUjEZMBcGA1UEChMQUEVSU09OQSBKVVJJRElDQTEpMCcGA1UECxMgRElSRUNDSU9OIEdFTkVSQUwgREUgVFJJQlVUQUNJT04xPDA6BgNVBAMTM01JTklTVEVSSU8gREUgSEFDSUVOREEgKFNFTExPIEVMRUNUUk9OSUNPKShQUlVFQkFTKTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALvfpCPAGN0xQQwHUJtiXu7FuWGFKbNrRPNTYOzzpIxwWyZ4B0CBKEXITGVfq8WaD+ddt57W1lfV3kPrl7MytnsEoSQKSEqmUTGkdVULdN67GKwNQf+eRwTUSBn4S1hlR9aYiT9uXrZFiRQ7McSwuGRiUC9jb9RW+REfmpUKjon6E/Di6L6450yzl9mPdnTNTUPBQ1FZ0e4SDCe0VczAoTTZDkcomq5Y6x9AlmXx57RgvsoyB7OhhrPmuruGjqw4ojs3DIo8R9P4PEEWJAZgcZ6BjBnw5btho55/NKSgXJbNSG3I9hp5+mBpZhSD0bFDxTw5aimmhyAIXkbniQBfUdsCAwEAAaOCAgcwggIDMA4GA1UdDwEB/wQEAwIGwDAdBgNVHQ4EFgQUK9GjpFVEZvnyj0dwyRDEGeXriAYwHwYDVR0jBBgwFoAUAo/vVCGOQdigygCijnLkBPHPSPEwdQYDVR0fBG4wbDBqoGigZoZkaHR0cDovL2ZkaXBydWViYXMuZG16LXAubG9jYWwvcmVwb3NpdG9yaW8vQ0ElMjBTSU5QRSUyMC0lMjBQRVJTT05BJTIwSlVSSURJQ0ElMjAtJTIwUFJVRUJBUyUyMHYyLmNybDCBsgYIKwYBBQUHAQEEgaUwgaIwcAYIKwYBBQUHMAKGZGh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsL3JlcG9zaXRvcmlvL0NBJTIwU0lOUEUlMjAtJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcnQwLgYIKwYBBQUHMAGGImh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsL29jc3AwPAYJKwYBBAGCNxUHBC8wLQYlKwYBBAGCNxUIs8RmgsThT4HlkyCEy4MYhNedawqG/OJzgvmTRAIBZAIBJjATBgNVHSUEDDAKBggrBgEFBQcDBDAbBgkrBgEEAYI3FQoEDjAMMAoGCCsGAQUFBwMEMBUGA1UdIAQOMAwwCgYIYIE8AQEBAQYwDQYJKoZIhvcNAQELBQADggEBAA1dTG7fE2H7VKbtMPalmMgsytSbOkAY0oqPKoKAQPYZLjGnLh0OdjwFnjvRSNeREX7tXy3nWs36iWiGlu9E9HIl+wA432BOInXZjm3sh+6pd81pksRd66oyM0ft4gAwVndDtRd9HnfLqZfV5zsXFD2htG1mHfuzuiQFuUJ34U06VeL6TwP+jbBFe1ooiyG3YMkyoJAlB3LgJHPYgR5HxdmSdfYYW8/ssJTl2jyYMK3qJP5MWmCrklUZxeJqbSzFbu7DlJVXTdt70p1zjDFCdQROzs9C9kctgshkZTHf73It8LslGRRdYXVl1v6LyQy2j7ltX8ihfe/tTHVWWP1BG0M=</ds:X509Certificate><ds:X509Certificate>MIIM5TCCCs2gAwIBAgITSAAAAAk+FKoquz2LmAAAAAAACTANBgkqhkiG9w0BAQ0FADBwMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQ0wCwYDVQQLEwREQ0ZEMQ8wDQYDVQQKEwZNSUNJVFQxCzAJBgNVBAYTAkNSMSYwJAYDVQQDEx1DQSBSQUlaIE5BQ0lPTkFMIC0gUFJVRUJBUyB2MjAeFw0xNTAzMDkyMTU3MjZaFw0zMTAzMDkyMjA3MjZaMHwxGTAXBgNVBAUTEENQSi05LTk5OS05OTk5OTkxCzAJBgNVBAYTAkNSMQ8wDQYDVQQKEwZNSUNJVFQxDTALBgNVBAsTBERDRkQxMjAwBgNVBAMTKUNBIFBPTElUSUNBIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqn7lrxp/k6KJum9OjWlGruL0/vFj9zZgtyzEJRtxWPgo3gKirpefP/5taRCyE5ovQ0cpGV1R9fOHJmD5JgAUuPh3PBJCGQypo/xHqxSKO4gKoJrCacolqNiijQ5Uc+cX+z4vIDKgYp3e7DwGsv+PaZPUBeQEkG2VUgwiP5tOwAYjKfglEqTpQL0MpYJkAZfN2HEYFN5Vj3HMSu5QVMwucRvrDHTx9rx+GQXO7nGWsROsGqZ/0ngd4DnehV805pdZ7SmZWuK2Vx8qDtdCx/SeN5CQ//BaKVyUhvaEzbY1ai0bMfyUeamKixHcRA9PrQi9ADJMVhV3wEJXjPPQcvJ3WrEwcpKXLESC1SovMwGfM6KDtTaBQLaIZEA1l/eepslwtvgl5wLxUY7nIj6JsHDWSG3MEgPUbS22YsIUbP3LyMp6Uo0d0P8kZiqUZMxshOxA43P8w7brbGa+8tvNpQhVQ1rZDYpbjYGFFj1eTCf1aRBsJ1NqfFVwYqTQt9SVkcE+o8mTSn+TC3LcRb2LFfox/xhaQvke4cq/STd0EiNJ3oVCcAHsIs+pfGSUUGFYFnM2zG7AVe+8duFZU1m+HRSsiwREnP/fs12MC18+tepIq3W0Z5IAmP6WR63W+AB45lBBGR0mwtNmTsEVpTd56Kt97eUbdxw4s/M+uqVTOEm/Br0CAwEAA','2018-09-27 13:49:31'),('33cb7e04-c25c-11e8-8d13-0800279cc012','8a92406a-cb9d-4d16-b6f4-a1fe0c5e9ba1',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50627091800011187076300200001010000000010100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000010</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-27T07:49:49-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>02</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, BLUH, PINE, NTOP</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>2212.38938</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>2212.38938</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>2212.38938</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>2212.38938</TotalVentaNeta>\r\n        <TotalImpuesto>287.61062</TotalImpuesto>\r\n        <TotalComprobante>2500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-27 13:49:49'),('34aa14bd-c25c-11e8-8d13-0800279cc012','8a92406a-cb9d-4d16-b6f4-a1fe0c5e9ba1',2,'Comprobante ENVIADO, STATUS(202)',NULL,'2018-09-27 13:49:51'),('34f6b8ff-c25c-11e8-8d13-0800279cc012','8a92406a-cb9d-4d16-b6f4-a1fe0c5e9ba1',2,'procesando',NULL,'2018-09-27 13:49:51'),('35469a48-c25c-11e8-8d13-0800279cc012','8a92406a-cb9d-4d16-b6f4-a1fe0c5e9ba1',2,'procesando',NULL,'2018-09-27 13:49:52'),('35dc5bb1-c25c-11e8-8d13-0800279cc012','8a92406a-cb9d-4d16-b6f4-a1fe0c5e9ba1',4,'rechazado','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<MensajeHacienda xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeHacienda\">\n    <Clave>50627091800011187076300200001010000000010100011154</Clave>\n    <NombreEmisor>Carlos Chacon Calvo</NombreEmisor>\n    <TipoIdentificacionEmisor>01</TipoIdentificacionEmisor>\n    <NumeroCedulaEmisor>111870763</NumeroCedulaEmisor>\n    <NombreReceptor>Carlos Chacon Calvo</NombreReceptor>\n    <TipoIdentificacionReceptor>01</TipoIdentificacionReceptor>\n    <NumeroCedulaReceptor>111870763</NumeroCedulaReceptor>\n    <Mensaje>3</Mensaje>\n    <DetalleMensaje>Este comprobante fue aceptado en el ambiente de pruebas, por lo cual no tiene validez para fines tributarios\n\nEl comprobante electrónico tiene los siguientes errores: \n\n[\ncodigo, mensaje, fila, columna\n-99, \"La numeración consecutiva del comprobante que se esta utilizando para este archivo XML ya existe en nuestras bases de datos.\", 0, 0\n-37, \"Estimado obligado tributario los datos suministrados en provincia, cantón y distrito del \'emisor\' no concuerdan con la información registrada en la Dirección General de Tributación, favor proceder actualizar sus datos.\", 0, 0\n\n]</DetalleMensaje>\n    <MontoTotalImpuesto>287.61062</MontoTotalImpuesto>\n    <TotalFactura>2500.00000</TotalFactura>\n<ds:Signature Id=\"id-3aeb72ae9f62529f02fe8c5790b8e10e\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><ds:SignedInfo><ds:CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/><ds:SignatureMethod Algorithm=\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\"/><ds:Reference Id=\"r-id-1\" Type=\"\" URI=\"\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/TR/1999/REC-xpath-19991116\"><ds:XPath>not(ancestor-or-self::ds:Signature)</ds:XPath></ds:Transform><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>5uVlS0jSacWK+BdKDhkc2wtQ65saWpTutkFo1b1qXlo=</ds:DigestValue></ds:Reference><ds:Reference Type=\"http://uri.etsi.org/01903#SignedProperties\" URI=\"#xades-id-3aeb72ae9f62529f02fe8c5790b8e10e\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>XXhjQar8qlftbFtz3TZp1wQht2t7DBDl1YkKPsNBmf4=</ds:DigestValue></ds:Reference></ds:SignedInfo><ds:SignatureValue Id=\"value-id-3aeb72ae9f62529f02fe8c5790b8e10e\">rn5O+ZYs/FmBvN1NMJeIypx4JdfFi4EprIaCEfbG4K63mW0fc9TvpF0qN9Iok9pU8MyQtQ2SU1jtm3cwNJg5gOWKucEKVkgGOt1/gEtmJ5wP24d1tesl3Q4cRq2rX+y8J43CM+GtjQEomsWv72AbNh20rmKpHe7p9h2w/K7RJ7GbfXSUD7VtiGNBR/4NGbscWkV0O0QRiEZogBoZe/+VrW1wEG6wSJ98HfGkQIPKY2OFfSahxDLFueWEIcpnXlq5cr9tbjab0KTKwUQP0Af2L6ZakzJ8gtSoAkeVyEycMBexgpt7IKfGv9+0glrSPwYG3V1Ma3pDA2lDAtECNjazuQ==</ds:SignatureValue><ds:KeyInfo><ds:X509Data><ds:X509Certificate>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</ds:X509Certificate><ds:X509Certificate>MIILSDCCCTCgAwIBAgITEgAAAAPvYiK7jLNK4wAAAAAAAzANBgkqhkiG9w0BAQ0FADB8MRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEPMA0GA1UEChMGTUlDSVRUMQ0wCwYDVQQLEwREQ0ZEMTIwMAYDVQQDEylDQSBQT0xJVElDQSBQRVJTT05BIEpVUklESUNBIC0gUFJVRUJBUyB2MjAeFw0xNTAzMTAyMjIzNDdaFw0yMzAzMTAyMjMzNDdaMIGlMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEkMCIGA1UEChMbQkFOQ08gQ0VOVFJBTCBERSBDT1NUQSBSSUNBMSIwIAYDVQQLExlESVZJU0lPTiBTSVNURU1BUyBERSBQQUdPMTEwLwYDVQQDEyhDQSBTSU5QRSAtIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq+zjbxp0Q5XaBHOMOFP49Avdovq/qrNl5NE+uMTVpCzo5uMod6/8iBobC4qin3aeQiWMQbw+gD+eBwJx7TpTMw2ViM9rBv6nEWOLOB+95MIWft/Smu7DTqTfbyQOjPOjA/RFkA3QeTGIWt6zVdv4HriIvi5BN0baXOU+iGyL179I8i5uD6TlqZdsLG4ToPv4SaunaWlqCNAtE9U9TeLFXcV+hiXZsh66mplcR6qeoTc9zaPO+68iTMzYH1/Iiroal1jblMzZ6VpaAr2U/2GQmzi4K3NQ6uM9hIp2I9FVlUo0CYpcdq/hDUkj5VjRYolfieSHFgjWzLm8Ps+TMMe6sQIDAQABo4IGlzCCBpMwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFAKP71QhjkHYoMoAoo5y5ATxz0jxMIIFCgYDVR0gBIIFATCCBP0wgfEGB2CBPAEBAQEwgeUwgbYGCCsGAQUFBwICMIGpHoGmAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABkAGUAIABsAGEAIABSAGEA7QB6ACAAQwBvAHMAdABhAHIAcgBpAGMAZQBuAHMAZQAgAGQAZQAgAEMAZQByAHQAaQBmAGkAYwBhAGMAaQDzAG4AIABEAGkAZwBpAHQAYQBsACAAUABSAFUARQBCAEEAUwAgAHYAMjAqBggrBgEFBQcCARYeaHR0cDovL2ZkaXBydWViYXMuZG16LXAubG9jYWwAMIIBMwYIYIE8AQEBAQEwggElMIH2BggrBgEFBQcCAjCB6R6B5gBJAG0AcABsAGUAbQBlAG4AdABhACAAbABhACAAUABvAGwA7QB0AGkAYwBhACAAZABlACAAQwBBACAARQBtAGkAcwBvAHIAYQAgAHAAYQByAGEAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFkBghggTwBAQEBBjCCAVYwggEmBggrBgEFBQcCAjCCARgeggEUAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABTAGUAbABsAG8AIABFAGwAZQBjAHQAcgDzAG4AaQBjAG8AIABkAGUAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFmBghggTwBAQEBBzCCAVgwggEoBggrBgEFBQcCAjCCARoeggEWAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABBAGcAZQBuAHQAZQAgAEUAbABlAGMAdAByAPMAbgBpAGMAbwAgAGQAZQAgAFAAZQByAHMAbwBuAGEAIABKAHUAcgDtAGQAaQBjAGEAIABwAGUAcgB0AGUAbgBlAGMAaQBlAG4AdABlACAAYQAgAGwAYQAgAFAASwBJACAATgBhAGMAaQBvAG4AYQBsACAAZABlACAAQwBvAHMAdABhACAAUgBpAGMAYQAgAFAAUgBVAEUAQgBBAFMAIAB2ADIwKgYIKwYBBQUHAgEWHmh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsADAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAfBgNVHSMEGDAWgBSEmr44xE3kUOd4PC/mbGmSsBzYXDB0BgNVHR8EbTBrMGmgZ6BlhmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcmwwfwYIKwYBBQUHAQEEczBxMG8GCCsGAQUFBzAChmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcnQwDQYJKoZIhvcNAQENBQADggIBAE1SoIlIQzn2thpr8UlZWrPqxMm8vnFJUQql9O6K8ZaJ9ZFJZY8oF1V4Mf8Ouljhyec37YaTh0a4rhOaN2eyDASqKA+6ThP5LaA0+Zm+E4/BRhLhYWj+vYlOQVVKfNzwMnMcdbbYGgL1orRWG+WHhYZr82s6OAezoB4P+XO2554tYusGR76SopNnkSiLiGb8UL0A4qq7fzowURmJEit5bADa7mQVhRwwdlevMngaWRUhdcZVKjCrwoDYBaSGJiILOIXqHHWi1pW/QhysnGZ6bT+R1eYY37IfHRea8f3urbrOcy5XqlSanjFBWcSjQfUtVbI4D4n4InZuF9y2lRIUcP/J4YnKz9K78bf3RnSlIPyCRhceifHW49/KQM5OHrLogK2S+tyttxyxqgXHUCWu9fLAc03cEAdab04HxqW0E2ULquUe7UljXPUm9Ya95FUiERBJj+xZOHYBftTwNsd2bcDHMWgfvtCqWWcl4g8McnTn9c9T7q2jJ9BBjg6OhPMf+/d3e/pFLLn+OEWaq8PMCHN032icFewi2Bzk3o9Daq0HYu/P+w+pP2WajNpw+3Wo8GDtTSDWDiFRmBUrizVa1gX0qp4fsiUx9FfL8d+4SooY4QLjhjIc9OV5OVSEH/G6Yq2YbsBIQDw1DGZ1K9Vl15DBtYIX6oXCaKdULzQR3fQ/</ds:X509Certificate><ds:X509Certificate>MIIM5TCCCs2gAwIBAgITSAAAAAk+FKoquz2LmAAAAAAACTANBgkqhkiG9w0BAQ0FADBwMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQ0wCwYDVQQLEwREQ0ZEMQ8wDQYDVQQKEwZNSUNJVFQxCzAJBgNVBAYTAkNSMSYwJAYDVQQDEx1DQSBSQUlaIE5BQ0lPTkFMIC0gUFJVRUJBUyB2MjAeFw0xNTAzMDkyMTU3MjZaFw0zMTAzMDkyMjA3MjZaMHwxGTAXBgNVBAUTEENQSi05LTk5OS05OTk5OTkxCzAJBgNVBAYTAkNSMQ8wDQYDVQQKEwZNSUNJVFQxDTALBgNVBAsTBERDRkQxMjAwBgNVBAMTKUNBIFBPTElUSUNBIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqn7lrxp/k6KJum9OjWlGruL0/vFj9zZgtyzEJRtxWPgo3gKirpefP/5taRCyE5ovQ0cpGV1R9fOHJmD5JgAUuPh3PBJCGQypo/xHqxSKO4gKoJrCacolqNiijQ5Uc+cX+z4vIDKgYp3e7DwGsv+PaZPUBeQEkG2VUgwiP5tOwAYjKfglEqTpQL0MpYJkAZfN2HEYFN5Vj3HMSu5QVMwucRvrDHTx9rx+GQXO7nGWsROsGqZ/0ngd4DnehV805pdZ7SmZWuK2Vx8qDtdCx/SeN5CQ//BaKVyUhvaEzbY1ai0bMfyUeamKixHcRA9PrQi9ADJMVhV3wEJXjPPQcvJ3WrEwcpKXLESC1SovMwGfM6KDtTaBQLaIZEA1l/eepslwtvgl5wLxUY7nIj6JsHDWSG3MEgPUbS22YsIUbP3LyMp6Uo0d0P8kZiqUZMxshOxA43P8w7brbGa+8tvNpQhVQ1rZDYpbjYGFFj1eTCf1aRBsJ1NqfFVwYqTQt9SVkcE+o8mTSn+TC3LcRb2LFfox/xhaQvke4cq/STd0EiNJ3oVCcAHsIs+pfGSUUGFYFnM2zG7AVe+8duFZU1m+HRSsiwREnP/fs12MC18+tepIq3W0Z5IAmP6WR63W+AB45lBBGR0mwtNmTsEVpTd56Kt97eUbdxw4s/M+uqVTOEm/Br0CAwEAA','2018-09-27 13:49:53'),('7f59455a-c2a1-11e8-8d13-0800279cc012','83b642b0-91e2-4fb2-8c73-4d58a333c1d2',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50627091800011187076300200001010000000011100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000011</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-27T16:05:51-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>01</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, PINE, PINE, TCOC</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>2212.38938</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>2212.38938</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>2212.38938</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>2212.38938</TotalVentaNeta>\r\n        <TotalImpuesto>287.61062</TotalImpuesto>\r\n        <TotalComprobante>2500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-27 22:05:51'),('836adc49-c2a1-11e8-8d13-0800279cc012','83b642b0-91e2-4fb2-8c73-4d58a333c1d2',5,'Comprobante ENVIADO con error, STATUS(400): \r\n{\"resp\":{\"Status\":400,\"to\":\"api-stag\",\"text\":[\"HTTP\\/1.1 100 Continue\\r\",\"\\r\",\"HTTP\\/1.1 400 Bad Request\\r\",\"Date: Thu, 27 Sep 2018 22:05:58 GMT\\r\",\"Content-Type: application\\/json\\r\",\"Content-Length: 0\\r\",\"Connection: keep-alive\\r\",\"Set-Cookie: __cfduid=d0eb7fe355c98f74e64db3aa8e5347aea1538085958; expires=Fri, 27-Sep-19 22:05:58 GMT; path=\\/; domain=.comprobanteselectronicos.go.cr; HttpOnly\\r\",\"Accept: *\\/*\\r\",\"Accept-Encoding: gzip\\r\",\"Access-Control-Allow-Headers: Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers\\r\",\"Access-Control-Allow-Methods: GET, HEAD, POST, PUT, DELETE, TRACE, OPTIONS, CONNECT, PATCH\\r\",\"Access-Control-Allow-Origin: *\\r\",\"Access-Control-Max-Age: 3600\\r\",\"Breadcrumbid: ID-pebpriin0301-prod-comprobanteselectronicos-go-cr-44533-1536981307497-0-14157579\\r\",\"Jmsxgroupid: 50627091800011187076300200001010000000011100011154\\r\",\"User-Agent: Tyk\\/v2.7.0\\r\",\"X-Error-',NULL,'2018-09-27 22:05:58'),('5886d079-c2b2-11e8-8d13-0800279cc012','7449f37e-4f29-408d-810b-77bc46e32e46',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50628091800011187076300200001010000000012100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000012</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-27T18:06:27-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>02</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, BLUH, PINE, TCOC</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>2212.38938</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>2212.38938</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>2212.38938</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>2212.38938</TotalVentaNeta>\r\n        <TotalImpuesto>287.61062</TotalImpuesto>\r\n        <TotalComprobante>2500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-28 00:06:27'),('59b4b084-c2b2-11e8-8d13-0800279cc012','7449f37e-4f29-408d-810b-77bc46e32e46',2,'Comprobante ENVIADO, STATUS(202)',NULL,'2018-09-28 00:06:29'),('5a2cac39-c2b2-11e8-8d13-0800279cc012','7449f37e-4f29-408d-810b-77bc46e32e46',2,'procesando',NULL,'2018-09-28 00:06:30'),('5a9013a4-c2b2-11e8-8d13-0800279cc012','7449f37e-4f29-408d-810b-77bc46e32e46',2,'procesando',NULL,'2018-09-28 00:06:31'),('5af8e6b0-c2b2-11e8-8d13-0800279cc012','7449f37e-4f29-408d-810b-77bc46e32e46',2,'procesando',NULL,'2018-09-28 00:06:32'),('5b8d8190-c2b2-11e8-8d13-0800279cc012','7449f37e-4f29-408d-810b-77bc46e32e46',2,'procesando',NULL,'2018-09-28 00:06:33'),('5bfb766a-c2b2-11e8-8d13-0800279cc012','7449f37e-4f29-408d-810b-77bc46e32e46',2,'procesando',NULL,'2018-09-28 00:06:33'),('5c6cc1fb-c2b2-11e8-8d13-0800279cc012','7449f37e-4f29-408d-810b-77bc46e32e46',4,'rechazado','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<MensajeHacienda xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeHacienda\">\n    <Clave>50628091800011187076300200001010000000012100011154</Clave>\n    <NombreEmisor>Carlos Chacon Calvo</NombreEmisor>\n    <TipoIdentificacionEmisor>01</TipoIdentificacionEmisor>\n    <NumeroCedulaEmisor>111870763</NumeroCedulaEmisor>\n    <NombreReceptor>Carlos Chacon Calvo</NombreReceptor>\n    <TipoIdentificacionReceptor>01</TipoIdentificacionReceptor>\n    <NumeroCedulaReceptor>111870763</NumeroCedulaReceptor>\n    <Mensaje>3</Mensaje>\n    <DetalleMensaje>Este comprobante fue aceptado en el ambiente de pruebas, por lo cual no tiene validez para fines tributarios\n\nEl comprobante electrónico tiene los siguientes errores: \n\n[\ncodigo, mensaje, fila, columna\n-16, \"El archivo XML, fue enviado a la Dirección General de Tributación de manera extemporánea; con base en lo estipulado en el artículo 9 y 15 ambos de la resolución 48-2016\", 0, 0\n-99, \"La numeración consecutiva del comprobante que se esta utilizando para este archivo XML ya existe en nuestras bases de datos.\", 0, 0\n-37, \"Estimado obligado tributario los datos suministrados en provincia, cantón y distrito del \'emisor\' no concuerdan con la información registrada en la Dirección General de Tributación, favor proceder actualizar sus datos.\", 0, 0\n\n]</DetalleMensaje>\n    <MontoTotalImpuesto>287.61062</MontoTotalImpuesto>\n    <TotalFactura>2500.00000</TotalFactura>\n<ds:Signature Id=\"id-dd57712367481ca1ef8d30a41d3e1b31\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><ds:SignedInfo><ds:CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/><ds:SignatureMethod Algorithm=\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\"/><ds:Reference Id=\"r-id-1\" Type=\"\" URI=\"\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/TR/1999/REC-xpath-19991116\"><ds:XPath>not(ancestor-or-self::ds:Signature)</ds:XPath></ds:Transform><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>CgACnu3lHHGH7KTIBjEQHah3kVIK3ik5a9LDTTkhcoY=</ds:DigestValue></ds:Reference><ds:Reference Type=\"http://uri.etsi.org/01903#SignedProperties\" URI=\"#xades-id-dd57712367481ca1ef8d30a41d3e1b31\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>L+NVmPXeJHX5Al4L3KZx3GXucaqSM+u5SH/mHPfPf9I=</ds:DigestValue></ds:Reference></ds:SignedInfo><ds:SignatureValue Id=\"value-id-dd57712367481ca1ef8d30a41d3e1b31\">aQMd5K5P0uVGjrlyFJ0Gh3YJkSgNM9VdWaDU3iWCURaFVcApvCk48m2zofmMD8swJjNMLOYvCHih5fcLlA38y+ZYqGOY9WuDyi+tIHZC0ioogkpoEgQxjOc+Bg/NdIQjSZ91Bpl+Fiem3KYI8kQOlXI61SCu+77XamoRUVvMS3ahxaZyG5fraR+yGuBU0fGI23QuNLXoE0Zwba03BwjQYcF6DDRVzMEfEERK4WP4VHqRzXOoERcYZ2ItBRwIrIX3ShF5G838ALFsgg6oSSmrT2afzit4KJ115UIo24fLajhCHtX+1tlIeE4xMNor+XJKDdf6pEWOD1CIOZeTqwmP4w==</ds:SignatureValue><ds:KeyInfo><ds:X509Data><ds:X509Certificate>MIILSDCCCTCgAwIBAgITEgAAAAPvYiK7jLNK4wAAAAAAAzANBgkqhkiG9w0BAQ0FADB8MRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEPMA0GA1UEChMGTUlDSVRUMQ0wCwYDVQQLEwREQ0ZEMTIwMAYDVQQDEylDQSBQT0xJVElDQSBQRVJTT05BIEpVUklESUNBIC0gUFJVRUJBUyB2MjAeFw0xNTAzMTAyMjIzNDdaFw0yMzAzMTAyMjMzNDdaMIGlMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEkMCIGA1UEChMbQkFOQ08gQ0VOVFJBTCBERSBDT1NUQSBSSUNBMSIwIAYDVQQLExlESVZJU0lPTiBTSVNURU1BUyBERSBQQUdPMTEwLwYDVQQDEyhDQSBTSU5QRSAtIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq+zjbxp0Q5XaBHOMOFP49Avdovq/qrNl5NE+uMTVpCzo5uMod6/8iBobC4qin3aeQiWMQbw+gD+eBwJx7TpTMw2ViM9rBv6nEWOLOB+95MIWft/Smu7DTqTfbyQOjPOjA/RFkA3QeTGIWt6zVdv4HriIvi5BN0baXOU+iGyL179I8i5uD6TlqZdsLG4ToPv4SaunaWlqCNAtE9U9TeLFXcV+hiXZsh66mplcR6qeoTc9zaPO+68iTMzYH1/Iiroal1jblMzZ6VpaAr2U/2GQmzi4K3NQ6uM9hIp2I9FVlUo0CYpcdq/hDUkj5VjRYolfieSHFgjWzLm8Ps+TMMe6sQIDAQABo4IGlzCCBpMwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFAKP71QhjkHYoMoAoo5y5ATxz0jxMIIFCgYDVR0gBIIFATCCBP0wgfEGB2CBPAEBAQEwgeUwgbYGCCsGAQUFBwICMIGpHoGmAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABkAGUAIABsAGEAIABSAGEA7QB6ACAAQwBvAHMAdABhAHIAcgBpAGMAZQBuAHMAZQAgAGQAZQAgAEMAZQByAHQAaQBmAGkAYwBhAGMAaQDzAG4AIABEAGkAZwBpAHQAYQBsACAAUABSAFUARQBCAEEAUwAgAHYAMjAqBggrBgEFBQcCARYeaHR0cDovL2ZkaXBydWViYXMuZG16LXAubG9jYWwAMIIBMwYIYIE8AQEBAQEwggElMIH2BggrBgEFBQcCAjCB6R6B5gBJAG0AcABsAGUAbQBlAG4AdABhACAAbABhACAAUABvAGwA7QB0AGkAYwBhACAAZABlACAAQwBBACAARQBtAGkAcwBvAHIAYQAgAHAAYQByAGEAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFkBghggTwBAQEBBjCCAVYwggEmBggrBgEFBQcCAjCCARgeggEUAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABTAGUAbABsAG8AIABFAGwAZQBjAHQAcgDzAG4AaQBjAG8AIABkAGUAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFmBghggTwBAQEBBzCCAVgwggEoBggrBgEFBQcCAjCCARoeggEWAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABBAGcAZQBuAHQAZQAgAEUAbABlAGMAdAByAPMAbgBpAGMAbwAgAGQAZQAgAFAAZQByAHMAbwBuAGEAIABKAHUAcgDtAGQAaQBjAGEAIABwAGUAcgB0AGUAbgBlAGMAaQBlAG4AdABlACAAYQAgAGwAYQAgAFAASwBJACAATgBhAGMAaQBvAG4AYQBsACAAZABlACAAQwBvAHMAdABhACAAUgBpAGMAYQAgAFAAUgBVAEUAQgBBAFMAIAB2ADIwKgYIKwYBBQUHAgEWHmh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsADAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAfBgNVHSMEGDAWgBSEmr44xE3kUOd4PC/mbGmSsBzYXDB0BgNVHR8EbTBrMGmgZ6BlhmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcmwwfwYIKwYBBQUHAQEEczBxMG8GCCsGAQUFBzAChmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcnQwDQYJKoZIhvcNAQENBQADggIBAE1SoIlIQzn2thpr8UlZWrPqxMm8vnFJUQql9O6K8ZaJ9ZFJZY8oF1V4Mf8Ouljhyec37YaTh0a4rhOaN2eyDASqKA+6ThP5LaA0+Zm+E4/BRhLhYWj+vYlOQVVKfNzwMnMcdbbYGgL1orRWG+WHhYZr82s6OAezoB4P+XO2554tYusGR76SopNnkSiLiGb8UL0A4qq7fzowURmJEit5bADa7mQVhRwwdlevMngaWRUhdcZVKjCrwoDYBaSGJiILOIXqHHWi1pW/QhysnGZ6bT+R1eYY37IfHRea8f3urbrOcy5XqlSanjFBWcSjQfUtVbI4D4n4InZuF9y2lRIUcP/J4YnKz9K78bf3RnSlIPyCRhceifHW49/KQM5OHrLogK2S+tyttxyxqgXHUCWu9fLAc03cEAdab04HxqW0E2ULquUe7UljXPUm9Ya95FUiERBJj+xZOHYBftTwNsd2bcDHMWgfvtCqWWcl4g8McnTn9c9T7q2jJ9BBjg6OhPMf+/d3e/pFLLn+OEWaq8PMCHN032icFewi2Bzk3o9Daq0HYu/P+w+pP2WajNpw+3Wo8GDtTSDWDiFRmBUrizVa1gX0qp4fsiUx9FfL8d+4SooY4QLjhjIc9OV5OVSEH/G6Yq2YbsBIQDw1DGZ1K9Vl15DBtYIX6oXCaKdULzQR3fQ/</ds:X509Certificate><ds:X509Certificate>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</ds:X509Certificate><ds:X509Certificate>MIIM5TCCCs2gAwIBAgITSAAAAAk+FKoquz2LmAAAAAAACTANBgkqhkiG9w0BAQ0FADBwMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQ0wCwYDVQQLEwREQ0ZEMQ8wDQYDVQQKEwZNSUNJVFQxCzAJBgNVBAYTAkNSMSYwJAYDVQQDEx1DQSBSQUlaIE5BQ0lPTkFMIC0gUFJVRUJBUyB2MjAeFw0xNTAzMDkyMTU3MjZaFw0zMTAzMDkyMjA3MjZaMHwxGTAXBgNVBAUTEENQSi05LTk5OS05OTk5OTkxCzAJBgNVBAYTAkNSMQ8wDQYDVQQKEwZNSUNJVFQxDTALBgNVBAsTBERDRkQxMjAwBgNVBAMTKUNBIFBPTElUSUNBIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqn7lrxp/k6KJum9OjWlGruL0/vFj9zZgtyzEJRtxWPgo3gKirpefP/5taRCyE5ovQ0cpGV1R9fOHJmD5JgAUuPh3PBJCGQypo/xHqxSKO4gKoJrCacolqNiijQ5Uc+cX+z4vIDKgYp3e7DwGsv+PaZPUBeQEkG2VUgwiP5tOwAYjKfglEqTpQL0MpYJkAZfN2HEYFN5Vj3HMSu5QVMwucRvrDHTx9rx+GQXO7nGWsROsGqZ/0ngd4DnehV805pdZ7SmZWuK2Vx8qDtdCx/SeN5CQ//BaKVyUhvaEzbY1ai0bMfyUeamKixHcRA9PrQi9ADJMVhV3wEJXjPPQcvJ3WrEwcpKXLESC1SovMwGfM6KDtTaBQLaIZEA1l/eepslwtvgl5wLxUY7nIj6JsHDWSG3MEgPUbS22YsIUbP3LyMp6Uo0d0P8kZiqUZMxshOxA43P8w7brbGa+8tvNpQhVQ1rZDYpbjYGFFj1eTCf1aRBsJ1NqfFVwYqTQt9S','2018-09-28 00:06:34'),('dda356c1-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50628091800011187076300200001010000000013100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000013</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-28T07:53:23-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>01</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>2</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>3</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>4</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>5</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>6</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>7</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>8</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>9</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>10</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>08oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>1327.43363</PrecioUnitario>\r\n                  <MontoTotal>1327.43363</MontoTotal>\r\n                  <SubTotal>1327.43363</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>172.56637</Monto></Impuesto><MontoTotalLinea>1500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>13274.33628</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>13274.33628</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>13274.33628</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>13274.33628</TotalVentaNeta>\r\n        <TotalImpuesto>1725.66372</TotalImpuesto>\r\n        <TotalComprobante>15000.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-28 13:53:23'),('decaee60-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd',2,'Comprobante ENVIADO, STATUS(202)',NULL,'2018-09-28 13:53:25'),('df5fc8a0-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd',2,'procesando',NULL,'2018-09-28 13:53:26'),('e0167cf9-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd',4,'rechazado','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<MensajeHacienda xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeHacienda\">\n    <Clave>50628091800011187076300200001010000000013100011154</Clave>\n    <NombreEmisor>Carlos Chacon Calvo</NombreEmisor>\n    <TipoIdentificacionEmisor>01</TipoIdentificacionEmisor>\n    <NumeroCedulaEmisor>111870763</NumeroCedulaEmisor>\n    <NombreReceptor>Carlos Chacon Calvo</NombreReceptor>\n    <TipoIdentificacionReceptor>01</TipoIdentificacionReceptor>\n    <NumeroCedulaReceptor>111870763</NumeroCedulaReceptor>\n    <Mensaje>3</Mensaje>\n    <DetalleMensaje>Este comprobante fue aceptado en el ambiente de pruebas, por lo cual no tiene validez para fines tributarios\n\nEl comprobante electrónico tiene los siguientes errores: \n\n[\ncodigo, mensaje, fila, columna\n-99, \"La numeración consecutiva del comprobante que se esta utilizando para este archivo XML ya existe en nuestras bases de datos.\", 0, 0\n-37, \"Estimado obligado tributario los datos suministrados en provincia, cantón y distrito del \'emisor\' no concuerdan con la información registrada en la Dirección General de Tributación, favor proceder actualizar sus datos.\", 0, 0\n-54, \"El monto total de impuestos no coincide con la suma de los campos denominados \'Monto del Impuesto\'\", 0, 0\n\n]</DetalleMensaje>\n    <MontoTotalImpuesto>1725.66372</MontoTotalImpuesto>\n    <TotalFactura>15000.00000</TotalFactura>\n<ds:Signature Id=\"id-86875e578bffd4f5ac8524a0af0c4213\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><ds:SignedInfo><ds:CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/><ds:SignatureMethod Algorithm=\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\"/><ds:Reference Id=\"r-id-1\" Type=\"\" URI=\"\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/TR/1999/REC-xpath-19991116\"><ds:XPath>not(ancestor-or-self::ds:Signature)</ds:XPath></ds:Transform><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>RcQNFy02OEliqEmyfb25VUQzs754F6bJL73HBouWZso=</ds:DigestValue></ds:Reference><ds:Reference Type=\"http://uri.etsi.org/01903#SignedProperties\" URI=\"#xades-id-86875e578bffd4f5ac8524a0af0c4213\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>0C2PbS24ZJJrnGosy7/PpPiq6vurrMnvSglqrEhtyq0=</ds:DigestValue></ds:Reference></ds:SignedInfo><ds:SignatureValue Id=\"value-id-86875e578bffd4f5ac8524a0af0c4213\">Ea9cfeW1wy8GTJQB5XAIOZ119TtzyaR8FH87vPWW6NlYYm38GF2M32mvCIcn2QXeUZGRds78oICSYWfzejrRMrzxMyqvJJTa6qjv1a7xolljF1wnTEqi+cQCnvT9pmA6baun7d9vDVq5V/BbkW/IBa9M9jbImA8Fu5XA32lUImv9WATXE6phfJpF3DVnVpXH4vBoJ+9ZdVdj/5SGVgx9ONdaJJkbm7Lx1otJ6dAYUT7LxqO5Q4ERCz9C86Ajs5IxEMx4isizZGponk1KAkyEFfHhpBF0LU7mGKpXbnfL9xEse+bjoP81Tv4ys/GOF94xexlNZDd4tX6GVApWSPAhQg==</ds:SignatureValue><ds:KeyInfo><ds:X509Data><ds:X509Certificate>MIILSDCCCTCgAwIBAgITEgAAAAPvYiK7jLNK4wAAAAAAAzANBgkqhkiG9w0BAQ0FADB8MRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEPMA0GA1UEChMGTUlDSVRUMQ0wCwYDVQQLEwREQ0ZEMTIwMAYDVQQDEylDQSBQT0xJVElDQSBQRVJTT05BIEpVUklESUNBIC0gUFJVRUJBUyB2MjAeFw0xNTAzMTAyMjIzNDdaFw0yMzAzMTAyMjMzNDdaMIGlMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEkMCIGA1UEChMbQkFOQ08gQ0VOVFJBTCBERSBDT1NUQSBSSUNBMSIwIAYDVQQLExlESVZJU0lPTiBTSVNURU1BUyBERSBQQUdPMTEwLwYDVQQDEyhDQSBTSU5QRSAtIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq+zjbxp0Q5XaBHOMOFP49Avdovq/qrNl5NE+uMTVpCzo5uMod6/8iBobC4qin3aeQiWMQbw+gD+eBwJx7TpTMw2ViM9rBv6nEWOLOB+95MIWft/Smu7DTqTfbyQOjPOjA/RFkA3QeTGIWt6zVdv4HriIvi5BN0baXOU+iGyL179I8i5uD6TlqZdsLG4ToPv4SaunaWlqCNAtE9U9TeLFXcV+hiXZsh66mplcR6qeoTc9zaPO+68iTMzYH1/Iiroal1jblMzZ6VpaAr2U/2GQmzi4K3NQ6uM9hIp2I9FVlUo0CYpcdq/hDUkj5VjRYolfieSHFgjWzLm8Ps+TMMe6sQIDAQABo4IGlzCCBpMwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFAKP71QhjkHYoMoAoo5y5ATxz0jxMIIFCgYDVR0gBIIFATCCBP0wgfEGB2CBPAEBAQEwgeUwgbYGCCsGAQUFBwICMIGpHoGmAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABkAGUAIABsAGEAIABSAGEA7QB6ACAAQwBvAHMAdABhAHIAcgBpAGMAZQBuAHMAZQAgAGQAZQAgAEMAZQByAHQAaQBmAGkAYwBhAGMAaQDzAG4AIABEAGkAZwBpAHQAYQBsACAAUABSAFUARQBCAEEAUwAgAHYAMjAqBggrBgEFBQcCARYeaHR0cDovL2ZkaXBydWViYXMuZG16LXAubG9jYWwAMIIBMwYIYIE8AQEBAQEwggElMIH2BggrBgEFBQcCAjCB6R6B5gBJAG0AcABsAGUAbQBlAG4AdABhACAAbABhACAAUABvAGwA7QB0AGkAYwBhACAAZABlACAAQwBBACAARQBtAGkAcwBvAHIAYQAgAHAAYQByAGEAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFkBghggTwBAQEBBjCCAVYwggEmBggrBgEFBQcCAjCCARgeggEUAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABTAGUAbABsAG8AIABFAGwAZQBjAHQAcgDzAG4AaQBjAG8AIABkAGUAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFmBghggTwBAQEBBzCCAVgwggEoBggrBgEFBQcCAjCCARoeggEWAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABBAGcAZQBuAHQAZQAgAEUAbABlAGMAdAByAPMAbgBpAGMAbwAgAGQAZQAgAFAAZQByAHMAbwBuAGEAIABKAHUAcgDtAGQAaQBjAGEAIABwAGUAcgB0AGUAbgBlAGMAaQBlAG4AdABlACAAYQAgAGwAYQAgAFAASwBJACAATgBhAGMAaQBvAG4AYQBsACAAZABlACAAQwBvAHMAdABhACAAUgBpAGMAYQAgAFAAUgBVAEUAQgBBAFMAIAB2ADIwKgYIKwYBBQUHAgEWHmh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsADAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAfBgNVHSMEGDAWgBSEmr44xE3kUOd4PC/mbGmSsBzYXDB0BgNVHR8EbTBrMGmgZ6BlhmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcmwwfwYIKwYBBQUHAQEEczBxMG8GCCsGAQUFBzAChmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcnQwDQYJKoZIhvcNAQENBQADggIBAE1SoIlIQzn2thpr8UlZWrPqxMm8vnFJUQql9O6K8ZaJ9ZFJZY8oF1V4Mf8Ouljhyec37YaTh0a4rhOaN2eyDASqKA+6ThP5LaA0+Zm+E4/BRhLhYWj+vYlOQVVKfNzwMnMcdbbYGgL1orRWG+WHhYZr82s6OAezoB4P+XO2554tYusGR76SopNnkSiLiGb8UL0A4qq7fzowURmJEit5bADa7mQVhRwwdlevMngaWRUhdcZVKjCrwoDYBaSGJiILOIXqHHWi1pW/QhysnGZ6bT+R1eYY37IfHRea8f3urbrOcy5XqlSanjFBWcSjQfUtVbI4D4n4InZuF9y2lRIUcP/J4YnKz9K78bf3RnSlIPyCRhceifHW49/KQM5OHrLogK2S+tyttxyxqgXHUCWu9fLAc03cEAdab04HxqW0E2ULquUe7UljXPUm9Ya95FUiERBJj+xZOHYBftTwNsd2bcDHMWgfvtCqWWcl4g8McnTn9c9T7q2jJ9BBjg6OhPMf+/d3e/pFLLn+OEWaq8PMCHN032icFewi2Bzk3o9Daq0HYu/P+w+pP2WajNpw+3Wo8GDtTSDWDiFRmBUrizVa1gX0qp4fsiUx9FfL8d+4SooY4QLjhjIc9OV5OVSEH/G6Yq2YbsBIQDw1DGZ1K9Vl15DBtYIX6oXCaKdULzQR3fQ/</ds:X509Certificate><ds:X509Certificate>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</ds:X509Certificate><ds:X509Certificate>MIIM5TCCCs2gAwIBAgITSAAAAAk+FKoquz2LmAAAAAAACTANBgkqhkiG9w0BAQ0FADBwMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQ0wCwYDVQQLEwREQ0ZEMQ8wDQYDVQQKEwZNSUNJVFQxCzAJBgNVBAYTAkNSMSYwJAYDVQQDEx1DQSBSQUlaIE5BQ0lPTkFMIC0gUFJVRUJBUyB2MjAeFw0xNTAzMDkyMTU3MjZaFw0zMTAzMDkyMjA3MjZaMHwxGTAXBgNVBAUTEENQSi05LTk5OS05OTk5OTkxCzAJBgNVBAYTAkNSMQ8wDQYDVQQKEwZNSUNJVFQxDTALBgNVBAsTBERDRkQxMjAwBgNVBAMTKUNBIFBPTElUSUNBIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqn7lrxp/k6KJum9OjWlGruL0/vFj9zZgtyzEJRtxWPgo3gKirpefP/5taRCyE5ovQ0cpGV1R9fOHJmD5JgAUuPh3PBJCGQypo/xHqxSKO4gKoJrCacolqNiijQ5Uc+cX+z4vIDKgYp3e7DwGsv+PaZPUBeQEkG2VUgwiP5tOwAYjKfglEqTpQL0MpYJkAZfN2HEYFN5Vj3HMSu5QVMwucRvrDHTx9rx+GQXO7nGWsROsGqZ/0ngd4DnehV805pdZ7SmZWuK2Vx8qDtdCx/SeN5CQ//BaKVyUhvaEzbY1ai0bMfyUeamKixHcRA9PrQi9ADJMVhV3wEJXjPPQcvJ3WrEwcpKXLESC1SovMwGfM6KDtTaBQLaIZEA1l/eepslwtvgl5wLxUY7nIj6JsHDWSG3MEgPUbS22YsIUbP3LyMp6Uo0d0P8kZiqUZMxshOxA43P8w7brbGa+8tvNpQhVQ1rZDYpbjYGFFj1eTCf1aRBsJ1NqfFVwYqTQt9SVkcE+o8mTSn+TC3LcRb2LFfox/xhaQvke4cq/STd0EiNJ3oVCcAHsIs+pfGSUUGFYFnM','2018-09-28 13:53:27'),('06b6bde5-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50628091800011187076300200001010000000014100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000014</NumeroConsecutivo>\r\n        <FechaEmision>2018-09-28T07:54:32-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>01</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>2</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>3</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>4</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>5</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>6</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle><LineaDetalle>\r\n                  <NumeroLinea>7</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, VECH, VECH, NTOP</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>15486.72566</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>15486.72566</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>15486.72566</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>15486.72566</TotalVentaNeta>\r\n        <TotalImpuesto>2013.27434</TotalImpuesto>\r\n        <TotalComprobante>17500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-09-28 13:54:32'),('07a0fa72-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1',2,'Comprobante ENVIADO, STATUS(202)',NULL,'2018-09-28 13:54:33'),('07f33f7b-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1',2,'procesando',NULL,'2018-09-28 13:54:34'),('085fe6ad-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1',2,'procesando',NULL,'2018-09-28 13:54:35'),('08cdac69-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1',4,'rechazado','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<MensajeHacienda xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeHacienda\">\n    <Clave>50628091800011187076300200001010000000014100011154</Clave>\n    <NombreEmisor>Carlos Chacon Calvo</NombreEmisor>\n    <TipoIdentificacionEmisor>01</TipoIdentificacionEmisor>\n    <NumeroCedulaEmisor>111870763</NumeroCedulaEmisor>\n    <NombreReceptor>Carlos Chacon Calvo</NombreReceptor>\n    <TipoIdentificacionReceptor>01</TipoIdentificacionReceptor>\n    <NumeroCedulaReceptor>111870763</NumeroCedulaReceptor>\n    <Mensaje>3</Mensaje>\n    <DetalleMensaje>Este comprobante fue aceptado en el ambiente de pruebas, por lo cual no tiene validez para fines tributarios\n\nEl comprobante electrónico tiene los siguientes errores: \n\n[\ncodigo, mensaje, fila, columna\n-99, \"La numeración consecutiva del comprobante que se esta utilizando para este archivo XML ya existe en nuestras bases de datos.\", 0, 0\n-37, \"Estimado obligado tributario los datos suministrados en provincia, cantón y distrito del \'emisor\' no concuerdan con la información registrada en la Dirección General de Tributación, favor proceder actualizar sus datos.\", 0, 0\n\n]</DetalleMensaje>\n    <MontoTotalImpuesto>2013.27434</MontoTotalImpuesto>\n    <TotalFactura>17500.00000</TotalFactura>\n<ds:Signature Id=\"id-66e015f76730715c3b36b76f5c78a279\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><ds:SignedInfo><ds:CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/><ds:SignatureMethod Algorithm=\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\"/><ds:Reference Id=\"r-id-1\" Type=\"\" URI=\"\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/TR/1999/REC-xpath-19991116\"><ds:XPath>not(ancestor-or-self::ds:Signature)</ds:XPath></ds:Transform><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>LUmwffQiXkGRHJntF0mYRhZ6nCxVSp8arzdk61GeFwk=</ds:DigestValue></ds:Reference><ds:Reference Type=\"http://uri.etsi.org/01903#SignedProperties\" URI=\"#xades-id-66e015f76730715c3b36b76f5c78a279\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>k+wXuXk4E5qlWkX77RJNULu/3oJRPqArRirgy7tdhqw=</ds:DigestValue></ds:Reference></ds:SignedInfo><ds:SignatureValue Id=\"value-id-66e015f76730715c3b36b76f5c78a279\">Da5zchFDQg6fDrkkxM3+1IwtXJuO4Ya3dRTpN0aHq8ouOC25JLg4oUhF0bWnKl0/vEWqSN8KtskqxRiGe1OjN8FkVzrmW56UJEWPBjZCnMorLloO7tRPxGbcdNKr1kEzIofkaB3LrFsoYsQwWvWX4Dmac58KQGzIgoCML19UdFuwV7u4/kXk/iyFiXsxPpaCDQp31s2mreXJa5X0Nh+BU0HMW9MnIBwxAxmCs8WYbsqaOfQuLfe4lNO0RSB7rJEHL2gIQTWSpeCCimvX1+uYClvgepJY9MJHn89jZq1JaIh5V8vBD5coWDxcrdykfV6eBXkk3w44YOq1orQ+7KrW4Q==</ds:SignatureValue><ds:KeyInfo><ds:X509Data><ds:X509Certificate>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</ds:X509Certificate><ds:X509Certificate>MIILSDCCCTCgAwIBAgITEgAAAAPvYiK7jLNK4wAAAAAAAzANBgkqhkiG9w0BAQ0FADB8MRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEPMA0GA1UEChMGTUlDSVRUMQ0wCwYDVQQLEwREQ0ZEMTIwMAYDVQQDEylDQSBQT0xJVElDQSBQRVJTT05BIEpVUklESUNBIC0gUFJVRUJBUyB2MjAeFw0xNTAzMTAyMjIzNDdaFw0yMzAzMTAyMjMzNDdaMIGlMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEkMCIGA1UEChMbQkFOQ08gQ0VOVFJBTCBERSBDT1NUQSBSSUNBMSIwIAYDVQQLExlESVZJU0lPTiBTSVNURU1BUyBERSBQQUdPMTEwLwYDVQQDEyhDQSBTSU5QRSAtIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq+zjbxp0Q5XaBHOMOFP49Avdovq/qrNl5NE+uMTVpCzo5uMod6/8iBobC4qin3aeQiWMQbw+gD+eBwJx7TpTMw2ViM9rBv6nEWOLOB+95MIWft/Smu7DTqTfbyQOjPOjA/RFkA3QeTGIWt6zVdv4HriIvi5BN0baXOU+iGyL179I8i5uD6TlqZdsLG4ToPv4SaunaWlqCNAtE9U9TeLFXcV+hiXZsh66mplcR6qeoTc9zaPO+68iTMzYH1/Iiroal1jblMzZ6VpaAr2U/2GQmzi4K3NQ6uM9hIp2I9FVlUo0CYpcdq/hDUkj5VjRYolfieSHFgjWzLm8Ps+TMMe6sQIDAQABo4IGlzCCBpMwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFAKP71QhjkHYoMoAoo5y5ATxz0jxMIIFCgYDVR0gBIIFATCCBP0wgfEGB2CBPAEBAQEwgeUwgbYGCCsGAQUFBwICMIGpHoGmAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABkAGUAIABsAGEAIABSAGEA7QB6ACAAQwBvAHMAdABhAHIAcgBpAGMAZQBuAHMAZQAgAGQAZQAgAEMAZQByAHQAaQBmAGkAYwBhAGMAaQDzAG4AIABEAGkAZwBpAHQAYQBsACAAUABSAFUARQBCAEEAUwAgAHYAMjAqBggrBgEFBQcCARYeaHR0cDovL2ZkaXBydWViYXMuZG16LXAubG9jYWwAMIIBMwYIYIE8AQEBAQEwggElMIH2BggrBgEFBQcCAjCB6R6B5gBJAG0AcABsAGUAbQBlAG4AdABhACAAbABhACAAUABvAGwA7QB0AGkAYwBhACAAZABlACAAQwBBACAARQBtAGkAcwBvAHIAYQAgAHAAYQByAGEAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFkBghggTwBAQEBBjCCAVYwggEmBggrBgEFBQcCAjCCARgeggEUAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABTAGUAbABsAG8AIABFAGwAZQBjAHQAcgDzAG4AaQBjAG8AIABkAGUAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFmBghggTwBAQEBBzCCAVgwggEoBggrBgEFBQcCAjCCARoeggEWAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABBAGcAZQBuAHQAZQAgAEUAbABlAGMAdAByAPMAbgBpAGMAbwAgAGQAZQAgAFAAZQByAHMAbwBuAGEAIABKAHUAcgDtAGQAaQBjAGEAIABwAGUAcgB0AGUAbgBlAGMAaQBlAG4AdABlACAAYQAgAGwAYQAgAFAASwBJACAATgBhAGMAaQBvAG4AYQBsACAAZABlACAAQwBvAHMAdABhACAAUgBpAGMAYQAgAFAAUgBVAEUAQgBBAFMAIAB2ADIwKgYIKwYBBQUHAgEWHmh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsADAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAfBgNVHSMEGDAWgBSEmr44xE3kUOd4PC/mbGmSsBzYXDB0BgNVHR8EbTBrMGmgZ6BlhmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcmwwfwYIKwYBBQUHAQEEczBxMG8GCCsGAQUFBzAChmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcnQwDQYJKoZIhvcNAQENBQADggIBAE1SoIlIQzn2thpr8UlZWrPqxMm8vnFJUQql9O6K8ZaJ9ZFJZY8oF1V4Mf8Ouljhyec37YaTh0a4rhOaN2eyDASqKA+6ThP5LaA0+Zm+E4/BRhLhYWj+vYlOQVVKfNzwMnMcdbbYGgL1orRWG+WHhYZr82s6OAezoB4P+XO2554tYusGR76SopNnkSiLiGb8UL0A4qq7fzowURmJEit5bADa7mQVhRwwdlevMngaWRUhdcZVKjCrwoDYBaSGJiILOIXqHHWi1pW/QhysnGZ6bT+R1eYY37IfHRea8f3urbrOcy5XqlSanjFBWcSjQfUtVbI4D4n4InZuF9y2lRIUcP/J4YnKz9K78bf3RnSlIPyCRhceifHW49/KQM5OHrLogK2S+tyttxyxqgXHUCWu9fLAc03cEAdab04HxqW0E2ULquUe7UljXPUm9Ya95FUiERBJj+xZOHYBftTwNsd2bcDHMWgfvtCqWWcl4g8McnTn9c9T7q2jJ9BBjg6OhPMf+/d3e/pFLLn+OEWaq8PMCHN032icFewi2Bzk3o9Daq0HYu/P+w+pP2WajNpw+3Wo8GDtTSDWDiFRmBUrizVa1gX0qp4fsiUx9FfL8d+4SooY4QLjhjIc9OV5OVSEH/G6Yq2YbsBIQDw1DGZ1K9Vl15DBtYIX6oXCaKdULzQR3fQ/</ds:X509Certificate><ds:X509Certificate>MIIM5TCCCs2gAwIBAgITSAAAAAk+FKoquz2LmAAAAAAACTANBgkqhkiG9w0BAQ0FADBwMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQ0wCwYDVQQLEwREQ0ZEMQ8wDQYDVQQKEwZNSUNJVFQxCzAJBgNVBAYTAkNSMSYwJAYDVQQDEx1DQSBSQUlaIE5BQ0lPTkFMIC0gUFJVRUJBUyB2MjAeFw0xNTAzMDkyMTU3MjZaFw0zMTAzMDkyMjA3MjZaMHwxGTAXBgNVBAUTEENQSi05LTk5OS05OTk5OTkxCzAJBgNVBAYTAkNSMQ8wDQYDVQQKEwZNSUNJVFQxDTALBgNVBAsTBERDRkQxMjAwBgNVBAMTKUNBIFBPTElUSUNBIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqn7lrxp/k6KJum9OjWlGruL0/vFj9zZgtyzEJRtxWPgo3gKirpefP/5taRCyE5ovQ0cpGV1R9fOHJmD5JgAUuPh3PBJCGQypo/xHqxSKO4gKoJrCacolqNiijQ5Uc+cX+z4vIDKgYp3e7DwGsv+PaZPUBeQEkG2VUgwiP5tOwAYjKfglEqTpQL0MpYJkAZfN2HEYFN5Vj3HMSu5QVMwucRvrDHTx9rx+GQXO7nGWsROsGqZ/0ngd4DnehV805pdZ7SmZWuK2Vx8qDtdCx/SeN5CQ//BaKVyUhvaEzbY1ai0bMfyUeamKixHcRA9PrQi9ADJMVhV3wEJXjPPQcvJ3WrEwcpKXLESC1SovMwGfM6KDtTaBQLaIZEA1l/eepslwtvgl5wLxUY7nIj6JsHDWSG3MEgPUbS22YsIUbP3LyMp6Uo0d0P8kZiqUZMxshOxA43P8w7brbGa+8tvNpQhVQ1rZDYpbjYGFFj1eTCf1aRBsJ1NqfFVwYqTQt9SVkcE+o8mTSn+TC3LcRb2LFfox/xhaQvke4cq/STd0EiNJ3oVCcAHsIs+pfGSUUGFYFnM2zG7AVe+8duFZU1m+HRSsiwREnP/fs12MC18+tepIq3W0Z5IAmP6WR63W+AB45lBBGR0mwtNmTsEVpTd56Kt97eUbdxw4s/M+uqVTOEm/Br0CAwE','2018-09-28 13:54:35'),('93c725e9-c726-11e8-8d13-0800279cc012','a0f87372-7bba-489b-a189-dddb8feab4dd',1,'xml a enviar','<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n    <FacturaElectronica xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:schemaLocation=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/facturaElectronica FacturaElectronica_V.4.2.xsd\">\r\n        <Clave>50603101800011187076300200001010000000015100011154</Clave>\r\n        <NumeroConsecutivo>00200001010000000015</NumeroConsecutivo>\r\n        <FechaEmision>2018-10-03T10:08:33-06:00</FechaEmision>\r\n        <Emisor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion>\r\n            <NombreComercial>12345</NombreComercial>\r\n            <Ubicacion>\r\n                <Provincia>1</Provincia>\r\n                <Canton>01</Canton>\r\n                <Distrito>01</Distrito>\r\n                <Barrio>01</Barrio>\r\n                <OtrasSenas>12312555</OtrasSenas>\r\n            </Ubicacion>\r\n            <Telefono>\r\n                <CodigoPais>506</CodigoPais>\r\n                <NumTelefono>84316310</NumTelefono>\r\n            </Telefono><CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Emisor>\r\n        <Receptor>\r\n            <Nombre>Carlos Chacon Calvo</Nombre>\r\n            <Identificacion>\r\n                <Tipo>01</Tipo>\r\n                <Numero>111870763</Numero>\r\n            </Identificacion><Telefono>\r\n                              <CodigoPais>506</CodigoPais>\r\n                              <NumTelefono>84922891</NumTelefono>\r\n                    </Telefono>\r\n            <CorreoElectronico>carlos.echc11@gmail.com</CorreoElectronico>\r\n        </Receptor>\r\n        <CondicionVenta>01</CondicionVenta>\r\n        <PlazoCredito>0</PlazoCredito>\r\n        <MedioPago>01</MedioPago>\r\n        <DetalleServicio>\r\n        <LineaDetalle>\r\n                  <NumeroLinea>1</NumeroLinea>\r\n                  <Cantidad>1.000</Cantidad>\r\n                  <UnidadMedida>Unid</UnidadMedida>\r\n                  <Detalle>12oz, BLUH, VECH, TCOC</Detalle>\r\n                  <PrecioUnitario>2212.38938</PrecioUnitario>\r\n                  <MontoTotal>2212.38938</MontoTotal>\r\n                  <SubTotal>2212.38938</SubTotal><Impuesto>\r\n                <Codigo>01</Codigo>\r\n                <Tarifa>13.00</Tarifa>\r\n                <Monto>287.61062</Monto></Impuesto><MontoTotalLinea>2500.00000</MontoTotalLinea></LineaDetalle></DetalleServicio>\r\n        <ResumenFactura>\r\n        <CodigoMoneda>CRC</CodigoMoneda>\r\n        <TipoCambio>582.83000</TipoCambio>\r\n        <TotalServGravados>0.00000</TotalServGravados>\r\n        <TotalServExentos>0.00000</TotalServExentos>\r\n        <TotalMercanciasGravadas>2212.38938</TotalMercanciasGravadas>\r\n        <TotalMercanciasExentas>0.00000</TotalMercanciasExentas>\r\n        <TotalGravado>2212.38938</TotalGravado>\r\n        <TotalExento>0.00000</TotalExento>\r\n        <TotalVenta>2212.38938</TotalVenta>\r\n        <TotalDescuentos>0.00000</TotalDescuentos>\r\n        <TotalVentaNeta>2212.38938</TotalVentaNeta>\r\n        <TotalImpuesto>287.61062</TotalImpuesto>\r\n        <TotalComprobante>2500.00000</TotalComprobante>\r\n        </ResumenFactura>\r\n        <Normativa>\r\n        <NumeroResolucion>DGT-R-48-2016</NumeroResolucion>\r\n        <FechaResolucion>07-10-2016 08:00:00</FechaResolucion>\r\n        </Normativa>\r\n        <Otros>\r\n        <OtroTexto>Tropical SNO</OtroTexto>\r\n        </Otros>\r\n        </FacturaElectronica>','2018-10-03 16:08:33'),('9530f647-c726-11e8-8d13-0800279cc012','a0f87372-7bba-489b-a189-dddb8feab4dd',2,'Comprobante ENVIADO, STATUS(202)',NULL,'2018-10-03 16:08:36'),('959b5760-c726-11e8-8d13-0800279cc012','a0f87372-7bba-489b-a189-dddb8feab4dd',2,'procesando',NULL,'2018-10-03 16:08:36'),('95fbffb8-c726-11e8-8d13-0800279cc012','a0f87372-7bba-489b-a189-dddb8feab4dd',2,'procesando',NULL,'2018-10-03 16:08:37'),('966290f0-c726-11e8-8d13-0800279cc012','a0f87372-7bba-489b-a189-dddb8feab4dd',4,'rechazado','<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<MensajeHacienda xmlns=\"https://tribunet.hacienda.go.cr/docs/esquemas/2017/v4.2/mensajeHacienda\">\n    <Clave>50603101800011187076300200001010000000015100011154</Clave>\n    <NombreEmisor>Carlos Chacon Calvo</NombreEmisor>\n    <TipoIdentificacionEmisor>01</TipoIdentificacionEmisor>\n    <NumeroCedulaEmisor>111870763</NumeroCedulaEmisor>\n    <NombreReceptor>Carlos Chacon Calvo</NombreReceptor>\n    <TipoIdentificacionReceptor>01</TipoIdentificacionReceptor>\n    <NumeroCedulaReceptor>111870763</NumeroCedulaReceptor>\n    <Mensaje>3</Mensaje>\n    <DetalleMensaje>Este comprobante fue aceptado en el ambiente de pruebas, por lo cual no tiene validez para fines tributarios\n\nEl comprobante electrónico tiene los siguientes errores: \n\n[\ncodigo, mensaje, fila, columna\n-99, \"La numeración consecutiva del comprobante que se esta utilizando para este archivo XML ya existe en nuestras bases de datos.\", 0, 0\n-37, \"Estimado obligado tributario los datos suministrados en provincia, cantón y distrito del \'emisor\' no concuerdan con la información registrada en la Dirección General de Tributación, favor proceder actualizar sus datos.\", 0, 0\n\n]</DetalleMensaje>\n    <MontoTotalImpuesto>287.61062</MontoTotalImpuesto>\n    <TotalFactura>2500.00000</TotalFactura>\n<ds:Signature Id=\"id-022cda7578cc9fe33036920ba8d5147c\" xmlns:ds=\"http://www.w3.org/2000/09/xmldsig#\"><ds:SignedInfo><ds:CanonicalizationMethod Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/><ds:SignatureMethod Algorithm=\"http://www.w3.org/2001/04/xmldsig-more#rsa-sha256\"/><ds:Reference Id=\"r-id-1\" Type=\"\" URI=\"\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/TR/1999/REC-xpath-19991116\"><ds:XPath>not(ancestor-or-self::ds:Signature)</ds:XPath></ds:Transform><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>ShPQFmLvTQVxXCwXWBMDS5IFuMHJgbeB0w2iW5pm5yQ=</ds:DigestValue></ds:Reference><ds:Reference Type=\"http://uri.etsi.org/01903#SignedProperties\" URI=\"#xades-id-022cda7578cc9fe33036920ba8d5147c\"><ds:Transforms><ds:Transform Algorithm=\"http://www.w3.org/2001/10/xml-exc-c14n#\"/></ds:Transforms><ds:DigestMethod Algorithm=\"http://www.w3.org/2001/04/xmlenc#sha256\"/><ds:DigestValue>KViShyWlYiXFkZDHvJuXHAZn+I2/iwWhjljkkeMbCwU=</ds:DigestValue></ds:Reference></ds:SignedInfo><ds:SignatureValue Id=\"value-id-022cda7578cc9fe33036920ba8d5147c\">ohxPO0LU7W+BqxFUgPrLaPJDhqFHNQUlIXCVPic968S1iiCEdUAIOywqRMV2HKPReIFYMDR53A/D5IHZhXvyZ1A7rcmOBCOjXQaJfDyQdyFKiLwqmc1pA+xCYn/geYODVNgv/SAnKPovOSzlVQIiq/5IqxaRf9XBY/EzgAaUHs7C/vXxfsoJ7PAtM/mEpsGSYE/Phf/Jwk1zvXRa3v1BJkw4CsAmLe6aCu+3ntMYwowoyLVCamg2t/RSOthl3CwS1fV++HUuKYMtf2yO0hICY2ge9CVamAlubRQ4pApdmhfje6FWbNknjssQK0LQYJPKlyZE/Evym5Mr/RT4HZSD8A==</ds:SignatureValue><ds:KeyInfo><ds:X509Data><ds:X509Certificate>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</ds:X509Certificate><ds:X509Certificate>MIILSDCCCTCgAwIBAgITEgAAAAPvYiK7jLNK4wAAAAAAAzANBgkqhkiG9w0BAQ0FADB8MRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEPMA0GA1UEChMGTUlDSVRUMQ0wCwYDVQQLEwREQ0ZEMTIwMAYDVQQDEylDQSBQT0xJVElDQSBQRVJTT05BIEpVUklESUNBIC0gUFJVRUJBUyB2MjAeFw0xNTAzMTAyMjIzNDdaFw0yMzAzMTAyMjMzNDdaMIGlMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQswCQYDVQQGEwJDUjEkMCIGA1UEChMbQkFOQ08gQ0VOVFJBTCBERSBDT1NUQSBSSUNBMSIwIAYDVQQLExlESVZJU0lPTiBTSVNURU1BUyBERSBQQUdPMTEwLwYDVQQDEyhDQSBTSU5QRSAtIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq+zjbxp0Q5XaBHOMOFP49Avdovq/qrNl5NE+uMTVpCzo5uMod6/8iBobC4qin3aeQiWMQbw+gD+eBwJx7TpTMw2ViM9rBv6nEWOLOB+95MIWft/Smu7DTqTfbyQOjPOjA/RFkA3QeTGIWt6zVdv4HriIvi5BN0baXOU+iGyL179I8i5uD6TlqZdsLG4ToPv4SaunaWlqCNAtE9U9TeLFXcV+hiXZsh66mplcR6qeoTc9zaPO+68iTMzYH1/Iiroal1jblMzZ6VpaAr2U/2GQmzi4K3NQ6uM9hIp2I9FVlUo0CYpcdq/hDUkj5VjRYolfieSHFgjWzLm8Ps+TMMe6sQIDAQABo4IGlzCCBpMwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFAKP71QhjkHYoMoAoo5y5ATxz0jxMIIFCgYDVR0gBIIFATCCBP0wgfEGB2CBPAEBAQEwgeUwgbYGCCsGAQUFBwICMIGpHoGmAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABkAGUAIABsAGEAIABSAGEA7QB6ACAAQwBvAHMAdABhAHIAcgBpAGMAZQBuAHMAZQAgAGQAZQAgAEMAZQByAHQAaQBmAGkAYwBhAGMAaQDzAG4AIABEAGkAZwBpAHQAYQBsACAAUABSAFUARQBCAEEAUwAgAHYAMjAqBggrBgEFBQcCARYeaHR0cDovL2ZkaXBydWViYXMuZG16LXAubG9jYWwAMIIBMwYIYIE8AQEBAQEwggElMIH2BggrBgEFBQcCAjCB6R6B5gBJAG0AcABsAGUAbQBlAG4AdABhACAAbABhACAAUABvAGwA7QB0AGkAYwBhACAAZABlACAAQwBBACAARQBtAGkAcwBvAHIAYQAgAHAAYQByAGEAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFkBghggTwBAQEBBjCCAVYwggEmBggrBgEFBQcCAjCCARgeggEUAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABTAGUAbABsAG8AIABFAGwAZQBjAHQAcgDzAG4AaQBjAG8AIABkAGUAIABQAGUAcgBzAG8AbgBhACAASgB1AHIA7QBkAGkAYwBhACAAcABlAHIAdABlAG4AZQBjAGkAZQBuAHQAZQAgAGEAIABsAGEAIABQAEsASQAgAE4AYQBjAGkAbwBuAGEAbAAgAGQAZQAgAEMAbwBzAHQAYQAgAFIAaQBjAGEAIABQAFIAVQBFAEIAQQBTACAAdgAyMCoGCCsGAQUFBwIBFh5odHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbAAwggFmBghggTwBAQEBBzCCAVgwggEoBggrBgEFBQcCAjCCARoeggEWAEkAbQBwAGwAZQBtAGUAbgB0AGEAIABsAGEAIABQAG8AbADtAHQAaQBjAGEAIABwAGEAcgBhACAAQwBlAHIAdABpAGYAaQBjAGEAZABvAHMAIABkAGUAIABBAGcAZQBuAHQAZQAgAEUAbABlAGMAdAByAPMAbgBpAGMAbwAgAGQAZQAgAFAAZQByAHMAbwBuAGEAIABKAHUAcgDtAGQAaQBjAGEAIABwAGUAcgB0AGUAbgBlAGMAaQBlAG4AdABlACAAYQAgAGwAYQAgAFAASwBJACAATgBhAGMAaQBvAG4AYQBsACAAZABlACAAQwBvAHMAdABhACAAUgBpAGMAYQAgAFAAUgBVAEUAQgBBAFMAIAB2ADIwKgYIKwYBBQUHAgEWHmh0dHA6Ly9mZGlwcnVlYmFzLmRtei1wLmxvY2FsADAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAfBgNVHSMEGDAWgBSEmr44xE3kUOd4PC/mbGmSsBzYXDB0BgNVHR8EbTBrMGmgZ6BlhmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcmwwfwYIKwYBBQUHAQEEczBxMG8GCCsGAQUFBzAChmNodHRwOi8vZmRpcHJ1ZWJhcy5kbXotcC5sb2NhbC9yZXBvc2l0b3Jpby9DQSUyMFBPTElUSUNBJTIwUEVSU09OQSUyMEpVUklESUNBJTIwLSUyMFBSVUVCQVMlMjB2Mi5jcnQwDQYJKoZIhvcNAQENBQADggIBAE1SoIlIQzn2thpr8UlZWrPqxMm8vnFJUQql9O6K8ZaJ9ZFJZY8oF1V4Mf8Ouljhyec37YaTh0a4rhOaN2eyDASqKA+6ThP5LaA0+Zm+E4/BRhLhYWj+vYlOQVVKfNzwMnMcdbbYGgL1orRWG+WHhYZr82s6OAezoB4P+XO2554tYusGR76SopNnkSiLiGb8UL0A4qq7fzowURmJEit5bADa7mQVhRwwdlevMngaWRUhdcZVKjCrwoDYBaSGJiILOIXqHHWi1pW/QhysnGZ6bT+R1eYY37IfHRea8f3urbrOcy5XqlSanjFBWcSjQfUtVbI4D4n4InZuF9y2lRIUcP/J4YnKz9K78bf3RnSlIPyCRhceifHW49/KQM5OHrLogK2S+tyttxyxqgXHUCWu9fLAc03cEAdab04HxqW0E2ULquUe7UljXPUm9Ya95FUiERBJj+xZOHYBftTwNsd2bcDHMWgfvtCqWWcl4g8McnTn9c9T7q2jJ9BBjg6OhPMf+/d3e/pFLLn+OEWaq8PMCHN032icFewi2Bzk3o9Daq0HYu/P+w+pP2WajNpw+3Wo8GDtTSDWDiFRmBUrizVa1gX0qp4fsiUx9FfL8d+4SooY4QLjhjIc9OV5OVSEH/G6Yq2YbsBIQDw1DGZ1K9Vl15DBtYIX6oXCaKdULzQR3fQ/</ds:X509Certificate><ds:X509Certificate>MIIM5TCCCs2gAwIBAgITSAAAAAk+FKoquz2LmAAAAAAACTANBgkqhkiG9w0BAQ0FADBwMRkwFwYDVQQFExBDUEotOS05OTktOTk5OTk5MQ0wCwYDVQQLEwREQ0ZEMQ8wDQYDVQQKEwZNSUNJVFQxCzAJBgNVBAYTAkNSMSYwJAYDVQQDEx1DQSBSQUlaIE5BQ0lPTkFMIC0gUFJVRUJBUyB2MjAeFw0xNTAzMDkyMTU3MjZaFw0zMTAzMDkyMjA3MjZaMHwxGTAXBgNVBAUTEENQSi05LTk5OS05OTk5OTkxCzAJBgNVBAYTAkNSMQ8wDQYDVQQKEwZNSUNJVFQxDTALBgNVBAsTBERDRkQxMjAwBgNVBAMTKUNBIFBPTElUSUNBIFBFUlNPTkEgSlVSSURJQ0EgLSBQUlVFQkFTIHYyMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqn7lrxp/k6KJum9OjWlGruL0/vFj9zZgtyzEJRtxWPgo3gKirpefP/5taRCyE5ovQ0cpGV1R9fOHJmD5JgAUuPh3PBJCGQypo/xHqxSKO4gKoJrCacolqNiijQ5Uc+cX+z4vIDKgYp3e7DwGsv+PaZPUBeQEkG2VUgwiP5tOwAYjKfglEqTpQL0MpYJkAZfN2HEYFN5Vj3HMSu5QVMwucRvrDHTx9rx+GQXO7nGWsROsGqZ/0ngd4DnehV805pdZ7SmZWuK2Vx8qDtdCx/SeN5CQ//BaKVyUhvaEzbY1ai0bMfyUeamKixHcRA9PrQi9ADJMVhV3wEJXjPPQcvJ3WrEwcpKXLESC1SovMwGfM6KDtTaBQLaIZEA1l/eepslwtvgl5wLxUY7nIj6JsHDWSG3MEgPUbS22YsIUbP3LyMp6Uo0d0P8kZiqUZMxshOxA43P8w7brbGa+8tvNpQhVQ1rZDYpbjYGFFj1eTCf1aRBsJ1NqfFVwYqTQt9SVkcE+o8mTSn+TC3LcRb2LFfox/xhaQvke4cq/STd0EiNJ3oVCcAHsIs+pfGSUUGFYFnM2zG7AVe+8duFZU1m+HRSsiwREnP/fs12MC18+tepIq3W0Z5IAmP6WR63W+AB45lBBGR0mwtNmTsEVpTd56Kt97eUbdxw4s/M+uqVTOEm/Br0CAwEAA','2018-10-03 16:08:38');
/*!40000 ALTER TABLE `historicoComprobante` ENABLE KEYS */;
UNLOCK TABLES;

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
  `saldoCosto` decimal(18,5) NOT NULL,
  `costoPromedio` decimal(18,5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `indexID` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Insumos para la elaboración de productos o que forman parte de la cadena de materiales. Materiales directos o indirectos.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumo`
--

LOCK TABLES `insumo` WRITE;
/*!40000 ALTER TABLE `insumo` DISABLE KEYS */;
INSERT INTO `insumo` VALUES ('05790041-a564-11e8-b258-0800279cc012','TS-GL-PEACH','SABORIZANTE DE MELOCOTÓN','SABORIZANTE DE MELOCOTÓN (SOBRE DE 66 GRS.)',30,87487.80000,2916.26000),('13ab320e-a564-11e8-b258-0800279cc012','TS-GL-PINAC','SABORIZANTE DE PIÑA COLADA','SABORIZANTE DE PIÑA COLADA (SOBRE DE 66 GRS.)',50,145813.00000,2916.26000),('13ca1534-a563-11e8-b258-0800279cc012','TS-GL-BLUEH','SABORIZANTE DE HAWAIANO AZUL','SABORIZANTE DE HAWAIANO AZUL (SOBRE DE 66 GRS.)',18,52492.68000,2916.26000),('1f4a1e68-a564-11e8-b258-0800279cc012','TS-GL-PINEA','SABORIZANTE DE PIÑA','SABORIZANTE DE PIÑA (SOBRE DE 66 GRS.)x',9,26246.34000,2916.26000),('1f4dd79e-b219-11e8-8061-0800279cc012','TA-CR-BANAN','TOPPING DE CREMA DE BANANO','TOPPING DE CREMA DE BANANO (1 PAQUETE DE 1/4 DE GALÓN)',116,197200.00000,1700.00000),('23065829-a563-11e8-b258-0800279cc012','TS-GL-BLUER','SABORIZANTE DE FRAMBUESA AZUL','SABORIZANTE DE FRAMBUESA AZUL (SOBRE DE 66 GRS.)',35,102069.10000,2916.26000),('288df5d9-a562-11e8-b258-0800279cc012','TS-GL-BANAN','SABORIZANTE DE BANANO','SABORIZANTE DE BANANO (SOBRE DE 66 GRS.)',33,96236.58000,2916.26000),('3207f1c7-a563-11e8-b258-0800279cc012','TS-GL-BUBBL','SABORIZANTE DE CHICLE','SABORIZANTE DE CHICLE (SOBRE DE 66 GRS.)',40,116650.40000,2916.26000),('38c89fa7-c194-11e8-8d13-0800279cc012','TS-GL-BLACK','SABORIZANTE DE CEREZA NEGRA','SABORIZANTE DE CEREZA NEGRA (SOBRE DE 66 GRS.)',14,40827.64000,2916.26000),('3ecf3d23-a564-11e8-b258-0800279cc012','TS-GL-REDRA','SABORIZANTE DE FRAMBUESA ROJA','SABORIZANTE DE FRAMBUESA ROJA (SOBRE DE 66 GRS.)',10,29162.60000,2916.26000),('3f1c9bfd-a563-11e8-b258-0800279cc012','TS-GL-COCON','SABORIZANTE DE COCO','SABORIZANTE DE COCO (SOBRE DE 66 GRS.)',35,102069.10000,2916.26000),('49729c89-aa05-11e8-b258-0800279cc012','SUGAR','AZÚCAR POR KILO','AZÚCAR MOLIDA PARA LA ELABORACIÓN DEL SIROPE',68,39884.00000,590.00000),('49c61303-a563-11e8-b258-0800279cc012','TS-GL-COLA','SABORIZANTE DE COLA','SABORIZANTE DE COLA (SOBRE DE 66 GRS.)',10,29162.60000,2916.26000),('4ae37adc-a564-11e8-b258-0800279cc012','TS-GL-ROOTB','SABORIZANTE DE ZARZA','SABORIZANTE DE ZARZA (SOBRE DE 66 GRS.)',5,14581.30000,2916.26000),('579da3be-a564-11e8-b258-0800279cc012','TS-GL-STRAW','SABORIZANTE DE FRESA','SABORIZANTE DE FRESA (SOBRE DE 66 GRS.)',49,142896.74000,2916.26000),('60901a78-a563-11e8-b258-0800279cc012','TS-GL-COTTO','SABORIZANTE DE ALGODÓN DE AZÚCAR','SABORIZANTE DE ALGODÓN DE AZÚCAR (SOBRE DE 66 GRS.)',25,72906.50000,2916.26000),('68de4c79-a564-11e8-b258-0800279cc012','TS-GL-VANIL','SABORIZANTE DE VAINILLA','SABORIZANTE DE VAINILLA (SOBRE DE 66 GRS.)',10,29162.60000,2916.26000),('69c3ca7d-a562-11e8-b258-0800279cc012','TS-GL-BLUEB','SABORIZANTE DE ARANDANO','SABORIZANTE DE ARANDANO (SOBRE DE 66 GRS.)',10,29162.60000,2916.26000),('6f2ce09a-b5cd-11e8-8061-0800279cc012','AGUA','AGUA','AGUA POR LITRO',99986,158778.40320,1.58800),('7115e5f0-a563-11e8-b258-0800279cc012','TS-GL-FRESH','SABORIZANTE DE LIMA FRESCA','SABORIZANTE DE LIMA FRESCA (SOBRE DE 66 GRS.)',25,72906.50000,2916.26000),('77dd8384-a564-11e8-b258-0800279cc012','TS-GL-VERCH','SABORIZANTE DE MUY CEREZA','SABORIZANTE DE MUY CEREZA (SOBRE DE 66 GRS.)',9,26246.34000,2916.26000),('80378f7b-a563-11e8-b258-0800279cc012','TS-GL-GRAPE','SABORIZANTE DE UVA','SABORIZANTE DE UVA (SOBRE DE 66 GRS.)',30,87487.80000,2916.26000),('88d146c4-a564-11e8-b258-0800279cc012','TS-GL-WATER','SABORIZANTE DE SANDIA','SABORIZANTE DE SANDIA (SOBRE DE 66 GRS.)',35,102069.10000,2916.26000),('95758034-a564-11e8-b258-0800279cc012','TS-GL-GUAVA','SABORIZANTE DE GUAYABA','SABORIZANTE DE GUAYABA (SOBRE DE 45 GRS.)',20,14581.40000,729.07000),('a91d532b-a564-11e8-b258-0800279cc012','TS-GL-PASSI','SABORIZANTE DE MARACUYÁ','SABORIZANTE DE MARACUYÁ (SOBRE DE 45 GRS.)',20,14581.40000,729.07000),('af2720df-a563-11e8-b258-0800279cc012','TS-GL-GREEN','SABORIZANTE DE MANZANA VERDE','SABORIZANTE DE MANZANA VERDE (SOBRE DE 66 GRS.)',20,58325.20000,2916.26000),('bbab150a-a563-11e8-b258-0800279cc012','TS-GL-LEMON','SABORIZANTE DE LIMÓN','SABORIZANTE DE LIMÓN (SOBRE DE 66 GRS.)',25,72906.50000,2916.26000),('c575b337-a563-11e8-b258-0800279cc012','TS-GL-MANGO','SABORIZANTE DE MANGO','SABORIZANTE DE MANGO (SOBRE DE 66 GRS.)',40,116650.40000,2916.26000),('c6bc9c49-a564-11e8-b258-0800279cc012','TA-CR-COCON','TOPPING DE CREMA DE COCO','TOPPING DE CREMA DE COCO (1 PAQUETE 1/4 DE GALÓN)',230,391000.00000,1700.00000),('e71632e9-a564-11e8-b258-0800279cc012','TA-CR-VANIL','TOPPING DE CREMA DE VAINILLA','TOPPING DE CREMA DE VAINILLA (1 PAQUETE DE 1/4 DE GALÓN)',801,1361700.00000,1700.00000),('f698abac-a563-11e8-b258-0800279cc012','TS-GL-ORANG','SABORIZANTE DE NARANJA','SABORIZANTE DE NARANJA (SOBRE DE 66 GRS.)',20,58325.20000,2916.26000);
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
  `saldoCantidad` decimal(18,5) NOT NULL,
  `saldoCosto` decimal(18,5) NOT NULL,
  `costoPromedio` decimal(18,5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_insumosXBodega_bodega1_idx` (`idBodega`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='insumos para la elaboración del producto final facturable al cliente';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumosXBodega`
--

LOCK TABLES `insumosXBodega` WRITE;
/*!40000 ALTER TABLE `insumosXBodega` DISABLE KEYS */;
INSERT INTO `insumosXBodega` VALUES ('56796c9d-c325-11e8-8d13-0800279cc012','49acc603-a64d-11e8-b258-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296',-1.42855,0.00000,0.00000),('b0569046-c19a-11e8-8d13-0800279cc012','eca0acc2-a64b-11e8-b258-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296',6.57143,0.00000,0.00000),('b05cb468-c19a-11e8-8d13-0800279cc012','ef3fcb6a-a64c-11e8-b258-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296',6.00000,0.00000,0.00000),('b2e605c6-c1ae-11e8-8d13-0800279cc012','5510045b-b5ce-11e8-8061-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296',10.00000,0.00000,0.00000);
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
  `idInsumo` char(36) NOT NULL COMMENT 'INSUMO / ARTICULO - NO RELACIONADO POR DIRECTRIZ DEL NEGOCIO.',
  `costoUnitario` decimal(18,5) NOT NULL COMMENT 'valor unitario del producto (precio del proveedor)',
  `cantidadBueno` decimal(10,0) NOT NULL,
  `cantidadMalo` decimal(10,0) NOT NULL,
  `valorBueno` decimal(18,5) NOT NULL COMMENT 'Cuanto cuesta ',
  `valorMalo` decimal(18,5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_insumosXOrdenCompra_ordenCompra1_idx` (`idOrdenCompra`),
  CONSTRAINT `fk_insumosXOrdenCompra_ordenCompra1` FOREIGN KEY (`idOrdenCompra`) REFERENCES `ordenCompra` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Almacena historial de Ordenes de compra o Facturas del proveedor y el valor historico original de los items comprados.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumosXOrdenCompra`
--

LOCK TABLES `insumosXOrdenCompra` WRITE;
/*!40000 ALTER TABLE `insumosXOrdenCompra` DISABLE KEYS */;
INSERT INTO `insumosXOrdenCompra` VALUES ('0155ea5f-c030-11e8-8d13-0800279cc012','4b48eea8-1b78-41c9-b213-7de4de904a7e','1f4dd79e-b219-11e8-8061-0800279cc012',2916.26000,34,1,99152.84000,2916.26000),('0428873a-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','07903351-a62e-11e8-b258-0800279cc012',1018140.01000,3,0,3054420.03000,0.00000),('08090ab8-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','0cdf88ba-a62f-11e8-b258-0800279cc012',9.23000,24000,0,221520.00000,0.00000),('11b94112-c199-11e8-8d13-0800279cc012','2434f68a-3338-4e32-9122-da0ecf185ab4','6f2ce09a-b5cd-11e8-8061-0800279cc012',1.58800,100000,0,158800.00000,0.00000),('14f9a63d-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','ecd762a7-a58c-11e8-b258-0800279cc012',7.00000,2000,0,14000.00000,0.00000),('1e142d20-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','0a7ce055-a58d-11e8-b258-0800279cc012',7.00000,2000,0,14000.00000,0.00000),('294dceac-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','1c01164d-a62f-11e8-b258-0800279cc012',26.40000,23848,10,629587.20000,264.00000),('35f20ca0-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','22ce212a-a62e-11e8-b258-0800279cc012',17862.11000,10,0,178621.10000,0.00000),('365a70da-c19d-11e8-8d13-0800279cc012','0e5448ff-e81f-4a3a-93d8-62d4aaacd65e','1f4dd79e-b219-11e8-8061-0800279cc012',1700.00000,116,0,197200.00000,0.00000),('396a71ab-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','417029a9-a58d-11e8-b258-0800279cc012',46660.19000,2,0,93320.38000,0.00000),('3a4eda94-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','bbab150a-a563-11e8-b258-0800279cc012',2916.26000,25,0,72906.50000,0.00000),('41e90536-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','2a2a3a5f-a58a-11e8-b258-0800279cc012',22965.00000,3,0,68895.00000,0.00000),('423a1ff7-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','467a2aa7-a62f-11e8-b258-0800279cc012',55408.98000,2,0,110817.96000,0.00000),('43c4f55a-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','c575b337-a563-11e8-b258-0800279cc012',2916.26000,40,0,116650.40000,0.00000),('4c5eb18a-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','3150ac55-a62f-11e8-b258-0800279cc012',113734.22000,1,0,113734.22000,0.00000),('4d8ae788-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','4393476b-a62e-11e8-b258-0800279cc012',1020.69000,168,0,171475.92000,0.00000),('4fed9ac3-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','f698abac-a563-11e8-b258-0800279cc012',2916.26000,20,0,58325.20000,0.00000),('51e3841c-c19d-11e8-8d13-0800279cc012','0e5448ff-e81f-4a3a-93d8-62d4aaacd65e','c6bc9c49-a564-11e8-b258-0800279cc012',1700.00000,231,0,392700.00000,0.00000),('56ce6050-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','76638b19-a58d-11e8-b258-0800279cc012',34995.15000,2,0,69990.30000,0.00000),('5782fb9b-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','779381ea-a58a-11e8-b258-0800279cc012',255.17000,60,0,15310.20000,0.00000),('58eb0e5a-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','05790041-a564-11e8-b258-0800279cc012',2916.26000,30,0,87487.80000,0.00000),('60f93990-c19d-11e8-8d13-0800279cc012','0e5448ff-e81f-4a3a-93d8-62d4aaacd65e','e71632e9-a564-11e8-b258-0800279cc012',1700.00000,801,1,1361700.00000,1700.00000),('62550abf-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','a040d8d4-a58d-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('66edfd79-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','13ab320e-a564-11e8-b258-0800279cc012',2916.26000,50,0,145813.00000,0.00000),('6a79302d-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','be639949-a58d-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('6ea57782-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','9bc3c191-a58a-11e8-b258-0800279cc012',127.59000,60,0,7655.40000,0.00000),('705766d6-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','1f4a1e68-a564-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('7590686a-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','e6539ab5-a58d-11e8-b258-0800279cc012',10206.92000,4,0,40827.68000,0.00000),('7ad8b081-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','3ecf3d23-a564-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('7c5c2d9a-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','5e7d3cd0-a62e-11e8-b258-0800279cc012',61241.50000,4,0,244966.00000,0.00000),('7ec70962-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','0d36c8db-a58e-11e8-b258-0800279cc012',7873.91000,2,0,15747.82000,0.00000),('84a65f7b-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','8fc42890-a62e-11e8-b258-0800279cc012',12248.30000,10,0,122483.00000,0.00000),('883ca309-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','4ae37adc-a564-11e8-b258-0800279cc012',2916.26000,5,0,14581.30000,0.00000),('8a219de5-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','1ffe07bf-a58e-11e8-b258-0800279cc012',7348.98000,8,0,58791.84000,0.00000),('8bae229b-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','288df5d9-a562-11e8-b258-0800279cc012',2916.26000,34,1,99152.84000,2916.26000),('8f4bbddb-c0d6-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','3cfa35a7-a562-11e8-b258-0800279cc012',2916.26000,15,0,43743.90000,0.00000),('9203eb8d-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','fc0acd5f-a58a-11e8-b258-0800279cc012',1913.80000,40,0,76552.00000,0.00000),('94bfe2cc-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','38c89fa7-c194-11e8-8d13-0800279cc012',2916.26000,15,0,43743.90000,0.00000),('96726903-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','579da3be-a564-11e8-b258-0800279cc012',2916.26000,49,1,142896.74000,2916.26000),('9d9c9b67-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','318efd1b-a58e-11e8-b258-0800279cc012',5832.52000,8,0,46660.16000,0.00000),('9e36f990-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','68de4c79-a564-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('9fd53229-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','0da5e444-a62a-11e8-b258-0800279cc012',1488.51000,144,0,214345.44000,0.00000),('a2fbf18f-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','13ca1534-a563-11e8-b258-0800279cc012',2916.26000,19,1,55408.94000,2916.26000),('a7167bcd-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','4c65ebb3-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('a7e2b191-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','77dd8384-a564-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('aaaf7958-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','409bd3ad-a58b-11e8-b258-0800279cc012',22965.56000,1,0,22965.56000,0.00000),('b263e28c-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','88d146c4-a564-11e8-b258-0800279cc012',2916.26000,35,0,102069.10000,0.00000),('b3ac29b2-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','69c3ca7d-a562-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('b58cfa3e-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','62b8fea9-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('ba457c0f-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','4eea04f4-a58b-11e8-b258-0800279cc012',6124.15000,2,0,12248.30000,0.00000),('bcc4877a-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','79605c96-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('be2d7646-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','23065829-a563-11e8-b258-0800279cc012',2916.26000,35,0,102069.10000,0.00000),('c6468414-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','67b239ae-a58b-11e8-b258-0800279cc012',1275.86000,6,0,7655.16000,0.00000),('c6af3251-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','95758034-a564-11e8-b258-0800279cc012',729.07000,20,0,14581.40000,0.00000),('c80abcbf-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','3207f1c7-a563-11e8-b258-0800279cc012',2916.26000,40,0,116650.40000,0.00000),('c8e7e6b5-c198-11e8-8d13-0800279cc012','5ef4c173-d8ae-422c-aa2a-270bea48746b','49729c89-aa05-11e8-b258-0800279cc012',590.00000,80,0,47200.00000,0.00000),('cbd3affc-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','945818b4-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('d03ddbdc-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','3f1c9bfd-a563-11e8-b258-0800279cc012',2916.26000,35,0,102069.10000,0.00000),('d33bab9f-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','a17c90c5-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('d41f880d-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','a7cc750c-a62e-11e8-b258-0800279cc012',23.32000,13997,8,326410.04000,186.56000),('d4b218de-c195-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','a91d532b-a564-11e8-b258-0800279cc012',729.07000,20,0,14581.40000,0.00000),('d7ebb6e5-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','49c61303-a563-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('dba57154-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','b58ecc55-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('e0916819-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','60901a78-a563-11e8-b258-0800279cc012',2916.26000,25,0,72906.50000,0.00000),('e1098fac-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','b8d5372b-a62e-11e8-b258-0800279cc012',29.16000,6000,0,174960.00000,0.00000),('e31a179d-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','e4833657-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('ea779eb3-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','f1aeee28-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('ea8f9bfc-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','7115e5f0-a563-11e8-b258-0800279cc012',2916.26000,25,0,72906.50000,0.00000),('f31c8e96-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','b948f654-a636-11e8-b258-0800279cc012',110.57000,14032,5,1551518.24000,552.85000),('f3f3f3f6-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','80378f7b-a563-11e8-b258-0800279cc012',2916.26000,30,0,87487.80000,0.00000),('fbffc87b-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','af2720df-a563-11e8-b258-0800279cc012',2916.26000,20,0,58325.20000,0.00000),('fc5a5da7-c197-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','fe1e806b-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('fefe07ef-c196-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b','9c6e039f-a638-11e8-b258-0800279cc012',110.93000,5990,4,664470.70000,443.72000);
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
  `costoUnitario` decimal(18,5) NOT NULL COMMENT 'valor unitario del producto (precio del proveedor)',
  `cantidadBueno` decimal(10,0) NOT NULL,
  `cantidadMalo` decimal(10,0) NOT NULL,
  `valorBueno` decimal(18,5) NOT NULL COMMENT 'Cuanto cuesta ',
  `valorMalo` decimal(18,5) NOT NULL,
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
  `cantidad` decimal(10,2) DEFAULT NULL,
  `costoPromedio` decimal(18,5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_insumosXOrdenSalida_ordenSalida1_idx` (`idOrdenSalida`),
  KEY `fk_insumosXOrdenSalida_insumo1_idx` (`idInsumo`),
  CONSTRAINT `fk_insumosXOrdenSalida_insumo1` FOREIGN KEY (`idInsumo`) REFERENCES `insumo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumosXOrdenSalida_ordenSalida1` FOREIGN KEY (`idOrdenSalida`) REFERENCES `ordenSalida` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insumosXOrdenSalida`
--

LOCK TABLES `insumosXOrdenSalida` WRITE;
/*!40000 ALTER TABLE `insumosXOrdenSalida` DISABLE KEYS */;
INSERT INTO `insumosXOrdenSalida` VALUES ('35dea1ed-c19b-11e8-8d13-0800279cc012','3cdf5c31-286c-4c65-a8d0-c127b5cc2949','6f2ce09a-b5cd-11e8-8061-0800279cc012',2.40,1.58800),('35e8af86-c19b-11e8-8d13-0800279cc012','3cdf5c31-286c-4c65-a8d0-c127b5cc2949','49729c89-aa05-11e8-b258-0800279cc012',2.60,590.00000),('35f2ec28-c19b-11e8-8d13-0800279cc012','3cdf5c31-286c-4c65-a8d0-c127b5cc2949','288df5d9-a562-11e8-b258-0800279cc012',1.00,2916.26000),('3d2b015a-c325-11e8-8d13-0800279cc012','bbfde1ee-d1f1-4812-af16-37f481e27d01','6f2ce09a-b5cd-11e8-8061-0800279cc012',2.60,1.58800),('3d3548ce-c325-11e8-8d13-0800279cc012','bbfde1ee-d1f1-4812-af16-37f481e27d01','49729c89-aa05-11e8-b258-0800279cc012',2.40,590.00000),('3d3f50a8-c325-11e8-8d13-0800279cc012','bbfde1ee-d1f1-4812-af16-37f481e27d01','77dd8384-a564-11e8-b258-0800279cc012',1.00,2916.26000),('46fcc80c-c199-11e8-8d13-0800279cc012','4e3f6512-daf1-4a15-9388-2edc82061e52','6f2ce09a-b5cd-11e8-8061-0800279cc012',4.80,1.58800),('470bfcc8-c199-11e8-8d13-0800279cc012','4e3f6512-daf1-4a15-9388-2edc82061e52','49729c89-aa05-11e8-b258-0800279cc012',5.20,590.00000),('4717a199-c199-11e8-8d13-0800279cc012','4e3f6512-daf1-4a15-9388-2edc82061e52','13ca1534-a563-11e8-b258-0800279cc012',1.00,2916.26000),('4721ca6a-c199-11e8-8d13-0800279cc012','4e3f6512-daf1-4a15-9388-2edc82061e52','1f4a1e68-a564-11e8-b258-0800279cc012',1.00,2916.26000),('79a37c3b-c19d-11e8-8d13-0800279cc012','537351da-43a1-4761-89ec-9910aa482de3','6f2ce09a-b5cd-11e8-8061-0800279cc012',0.75,1.58800),('79aee259-c19d-11e8-8d13-0800279cc012','537351da-43a1-4761-89ec-9910aa482de3','c6bc9c49-a564-11e8-b258-0800279cc012',1.00,1700.00000),('a0048d64-c25c-11e8-8d13-0800279cc012','4c9abe66-ffe7-4db6-9b52-4ebd9529651a','6f2ce09a-b5cd-11e8-8061-0800279cc012',2.60,1.58800),('a00ebecf-c25c-11e8-8d13-0800279cc012','4c9abe66-ffe7-4db6-9b52-4ebd9529651a','49729c89-aa05-11e8-b258-0800279cc012',2.40,590.00000),('a018e5d2-c25c-11e8-8d13-0800279cc012','4c9abe66-ffe7-4db6-9b52-4ebd9529651a','38c89fa7-c194-11e8-8d13-0800279cc012',1.00,2916.26000);
/*!40000 ALTER TABLE `insumosXOrdenSalida` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventarioInsumo`
--

DROP TABLE IF EXISTS `inventarioInsumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventarioInsumo` (
  `id` char(36) NOT NULL,
  `idOrdenCompra` char(36) DEFAULT NULL,
  `idOrdenSalida` char(36) DEFAULT NULL,
  `idMerma` char(36) DEFAULT NULL,
  `idInsumo` char(36) NOT NULL,
  `entrada` decimal(10,0) DEFAULT NULL,
  `salida` decimal(10,0) DEFAULT NULL,
  `saldo` decimal(10,0) NOT NULL,
  `costoAdquisicion` decimal(10,0) DEFAULT NULL,
  `valorEntrada` decimal(18,5) DEFAULT NULL,
  `valorSalida` decimal(18,5) DEFAULT NULL,
  `valorSaldo` decimal(18,5) NOT NULL,
  `costoPromedio` decimal(18,5) NOT NULL,
  `fecha` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventarioInsumo`
--

LOCK TABLES `inventarioInsumo` WRITE;
/*!40000 ALTER TABLE `inventarioInsumo` DISABLE KEYS */;
INSERT INTO `inventarioInsumo` VALUES ('01601854-c030-11e8-8d13-0800279cc012','4b48eea8-1b78-41c9-b213-7de4de904a7e',NULL,NULL,'1f4dd79e-b219-11e8-8061-0800279cc012',34,NULL,34,2916,99152.84000,NULL,99152.84000,2916.26000,'2018-09-24 19:28:24'),('11be8be9-c199-11e8-8d13-0800279cc012','2434f68a-3338-4e32-9122-da0ecf185ab4',NULL,NULL,'6f2ce09a-b5cd-11e8-8061-0800279cc012',100000,NULL,100000,2,158800.00000,NULL,158800.00000,1.58800,'2018-09-26 14:33:00'),('35fda08e-c19b-11e8-8d13-0800279cc012',NULL,'3cdf5c31-286c-4c65-a8d0-c127b5cc2949',NULL,'6f2ce09a-b5cd-11e8-8061-0800279cc012',NULL,2,99993,NULL,NULL,3.81120,158788.24880,1.58800,'2018-09-26 14:45:25'),('3603b26a-c19b-11e8-8d13-0800279cc012',NULL,'3cdf5c31-286c-4c65-a8d0-c127b5cc2949',NULL,'49729c89-aa05-11e8-b258-0800279cc012',NULL,3,72,NULL,NULL,1534.00000,42716.00000,590.00000,'2018-09-26 14:45:25'),('3608ec14-c19b-11e8-8d13-0800279cc012',NULL,'3cdf5c31-286c-4c65-a8d0-c127b5cc2949',NULL,'288df5d9-a562-11e8-b258-0800279cc012',NULL,1,33,NULL,NULL,2916.26000,96236.58000,2916.26000,'2018-09-26 14:45:25'),('365fb9cd-c19d-11e8-8d13-0800279cc012','0e5448ff-e81f-4a3a-93d8-62d4aaacd65e',NULL,NULL,'1f4dd79e-b219-11e8-8061-0800279cc012',116,NULL,116,1700,197200.00000,NULL,197200.00000,1700.00000,'2018-09-26 15:02:40'),('3a53fecb-c195-11e8-8d13-0800279cc012','7398e294-2785-403c-8672-83e8786c487d',NULL,NULL,'bbab150a-a563-11e8-b258-0800279cc012',25,NULL,25,2916,72906.50000,NULL,72906.50000,2916.26000,'2018-09-26 14:05:30'),('3a5a8da7-c199-11e8-8d13-0800279cc012',NULL,'4e3f6512-daf1-4a15-9388-2edc82061e52',NULL,'6f2ce09a-b5cd-11e8-8061-0800279cc012',NULL,5,99995,NULL,NULL,7.62240,158792.37760,1.58800,'2018-09-26 14:30:37'),('3a5f7194-c199-11e8-8d13-0800279cc012',NULL,'4e3f6512-daf1-4a15-9388-2edc82061e52',NULL,'49729c89-aa05-11e8-b258-0800279cc012',NULL,5,75,NULL,NULL,3068.00000,44132.00000,590.00000,'2018-09-26 14:30:37'),('3a6482e5-c199-11e8-8d13-0800279cc012',NULL,'4e3f6512-daf1-4a15-9388-2edc82061e52',NULL,'13ca1534-a563-11e8-b258-0800279cc012',NULL,1,18,NULL,NULL,2916.26000,52492.68000,2916.26000,'2018-09-26 14:30:37'),('3a6ec277-c199-11e8-8d13-0800279cc012',NULL,'4e3f6512-daf1-4a15-9388-2edc82061e52',NULL,'1f4a1e68-a564-11e8-b258-0800279cc012',NULL,1,9,NULL,NULL,2916.26000,26246.34000,2916.26000,'2018-09-26 14:30:37'),('3d451f0a-c325-11e8-8d13-0800279cc012',NULL,'bbfde1ee-d1f1-4812-af16-37f481e27d01',NULL,'6f2ce09a-b5cd-11e8-8061-0800279cc012',NULL,3,99986,NULL,NULL,4.12880,158778.40320,1.58800,'2018-09-28 13:45:56'),('3d49cce4-c325-11e8-8d13-0800279cc012',NULL,'bbfde1ee-d1f1-4812-af16-37f481e27d01',NULL,'49729c89-aa05-11e8-b258-0800279cc012',NULL,2,68,NULL,NULL,1416.00000,39884.00000,590.00000,'2018-09-28 13:45:56'),('3d4ef688-c325-11e8-8d13-0800279cc012',NULL,'bbfde1ee-d1f1-4812-af16-37f481e27d01',NULL,'77dd8384-a564-11e8-b258-0800279cc012',NULL,1,9,NULL,NULL,2916.26000,26246.34000,2916.26000,'2018-09-28 13:45:56'),('43cb8fda-c195-11e8-8d13-0800279cc012','1df3dca8-2a3d-45e6-aced-5f195917f370',NULL,NULL,'c575b337-a563-11e8-b258-0800279cc012',40,NULL,40,2916,116650.40000,NULL,116650.40000,2916.26000,'2018-09-26 14:05:46'),('4ff2df38-c195-11e8-8d13-0800279cc012','6f1e01ba-7b07-45ca-a734-130250ba834a',NULL,NULL,'f698abac-a563-11e8-b258-0800279cc012',20,NULL,20,2916,58325.20000,NULL,58325.20000,2916.26000,'2018-09-26 14:06:07'),('51e8da8b-c19d-11e8-8d13-0800279cc012','a64ee5d5-e890-4d20-8603-28089ed61c67',NULL,NULL,'c6bc9c49-a564-11e8-b258-0800279cc012',231,NULL,231,1700,392700.00000,NULL,392700.00000,1700.00000,'2018-09-26 15:03:26'),('58f04738-c195-11e8-8d13-0800279cc012','be46a0e9-8f83-45f4-9c15-b4f7816df6dc',NULL,NULL,'05790041-a564-11e8-b258-0800279cc012',30,NULL,30,2916,87487.80000,NULL,87487.80000,2916.26000,'2018-09-26 14:06:22'),('61038a88-c19d-11e8-8d13-0800279cc012','a8c1ff1a-6213-438f-9227-9ff0e9c99d8f',NULL,NULL,'e71632e9-a564-11e8-b258-0800279cc012',801,NULL,801,1700,1361700.00000,NULL,1361700.00000,1700.00000,'2018-09-26 15:03:51'),('66f48837-c195-11e8-8d13-0800279cc012','4483621e-05a7-4eb0-896e-6f1a242da720',NULL,NULL,'13ab320e-a564-11e8-b258-0800279cc012',50,NULL,50,2916,145813.00000,NULL,145813.00000,2916.26000,'2018-09-26 14:06:45'),('705cac44-c195-11e8-8d13-0800279cc012','838a741b-d1c6-400d-8ada-053e159542b4',NULL,NULL,'1f4a1e68-a564-11e8-b258-0800279cc012',10,NULL,10,2916,29162.60000,NULL,29162.60000,2916.26000,'2018-09-26 14:07:01'),('79b5c817-c19d-11e8-8d13-0800279cc012',NULL,'537351da-43a1-4761-89ec-9910aa482de3',NULL,'6f2ce09a-b5cd-11e8-8061-0800279cc012',NULL,1,99992,NULL,NULL,1.19100,158787.69300,1.58800,'2018-09-26 15:01:30'),('79c89e8f-c19d-11e8-8d13-0800279cc012',NULL,'537351da-43a1-4761-89ec-9910aa482de3',NULL,'c6bc9c49-a564-11e8-b258-0800279cc012',NULL,1,230,NULL,NULL,1700.00000,391000.00000,1700.00000,'2018-09-26 15:01:30'),('7addf169-c195-11e8-8d13-0800279cc012','946fbffe-3db6-4de3-b349-a0eecc50ea2b',NULL,NULL,'3ecf3d23-a564-11e8-b258-0800279cc012',10,NULL,10,2916,29162.60000,NULL,29162.60000,2916.26000,'2018-09-26 14:07:19'),('8841ebb3-c195-11e8-8d13-0800279cc012','af1caa7d-c603-4631-87f9-bcf54f7f195a',NULL,NULL,'4ae37adc-a564-11e8-b258-0800279cc012',5,NULL,5,2916,14581.30000,NULL,14581.30000,2916.26000,'2018-09-26 14:07:41'),('8bb4a802-c194-11e8-8d13-0800279cc012','cdfc4171-d03f-4857-883d-72e7ebb7a32d',NULL,NULL,'288df5d9-a562-11e8-b258-0800279cc012',34,NULL,34,2916,99152.84000,NULL,99152.84000,2916.26000,'2018-09-26 14:00:37'),('8f5649f4-c0d6-11e8-8d13-0800279cc012',NULL,NULL,NULL,'3cfa35a7-a562-11e8-b258-0800279cc012',15,NULL,15,2916,43743.90000,NULL,43743.90000,2916.26000,'2018-09-25 15:20:39'),('94c52047-c194-11e8-8d13-0800279cc012','0a3dc5dc-ac78-4295-b1c2-67db7e636417',NULL,NULL,'38c89fa7-c194-11e8-8d13-0800279cc012',15,NULL,15,2916,43743.90000,NULL,43743.90000,2916.26000,'2018-09-26 14:00:53'),('967a36c1-c195-11e8-8d13-0800279cc012','6bc66510-7331-4796-8d91-07077bb4f7e7',NULL,NULL,'579da3be-a564-11e8-b258-0800279cc012',49,NULL,49,2916,142896.74000,NULL,142896.74000,2916.26000,'2018-09-26 14:08:05'),('9e3c4d0e-c195-11e8-8d13-0800279cc012','8fc625e8-862c-4b70-b34d-1814185257a2',NULL,NULL,'68de4c79-a564-11e8-b258-0800279cc012',10,NULL,10,2916,29162.60000,NULL,29162.60000,2916.26000,'2018-09-26 14:08:18'),('a0239a70-c25c-11e8-8d13-0800279cc012',NULL,'4c9abe66-ffe7-4db6-9b52-4ebd9529651a',NULL,'6f2ce09a-b5cd-11e8-8061-0800279cc012',NULL,3,99989,NULL,NULL,4.12880,158783.16720,1.58800,'2018-09-27 13:49:58'),('a029b44d-c25c-11e8-8d13-0800279cc012',NULL,'4c9abe66-ffe7-4db6-9b52-4ebd9529651a',NULL,'49729c89-aa05-11e8-b258-0800279cc012',NULL,2,70,NULL,NULL,1416.00000,41064.00000,590.00000,'2018-09-27 13:49:58'),('a02ef224-c25c-11e8-8d13-0800279cc012',NULL,'4c9abe66-ffe7-4db6-9b52-4ebd9529651a',NULL,'38c89fa7-c194-11e8-8d13-0800279cc012',NULL,1,14,NULL,NULL,2916.26000,40827.64000,2916.26000,'2018-09-27 13:49:58'),('a3027f35-c194-11e8-8d13-0800279cc012','186baa4d-22e4-408b-b0d4-4e619ae2dc2d',NULL,NULL,'13ca1534-a563-11e8-b258-0800279cc012',19,NULL,19,2916,55408.94000,NULL,55408.94000,2916.26000,'2018-09-26 14:01:16'),('a7e7dc4e-c195-11e8-8d13-0800279cc012','a958e346-3e15-4c6a-9967-f7e55bd33973',NULL,NULL,'77dd8384-a564-11e8-b258-0800279cc012',10,NULL,10,2916,29162.60000,NULL,29162.60000,2916.26000,'2018-09-26 14:08:34'),('b269193e-c195-11e8-8d13-0800279cc012','983e858e-6af5-4d10-82e7-ae5173a94101',NULL,NULL,'88d146c4-a564-11e8-b258-0800279cc012',35,NULL,35,2916,102069.10000,NULL,102069.10000,2916.26000,'2018-09-26 14:08:52'),('b3b18619-c194-11e8-8d13-0800279cc012','dd6f39b8-ec7e-4ebc-8c51-1794f2f4e3fe',NULL,NULL,'69c3ca7d-a562-11e8-b258-0800279cc012',10,NULL,10,2916,29162.60000,NULL,29162.60000,2916.26000,'2018-09-26 14:01:44'),('be32b99c-c194-11e8-8d13-0800279cc012','9bdc52fa-49d7-42a8-8464-c95fb2da9820',NULL,NULL,'23065829-a563-11e8-b258-0800279cc012',35,NULL,35,2916,102069.10000,NULL,102069.10000,2916.26000,'2018-09-26 14:02:02'),('c6b47ae4-c195-11e8-8d13-0800279cc012','b7132d86-1b7f-4820-86f9-9a7e415a67af',NULL,NULL,'95758034-a564-11e8-b258-0800279cc012',20,NULL,20,729,14581.40000,NULL,14581.40000,729.07000,'2018-09-26 14:09:26'),('c80fe22a-c194-11e8-8d13-0800279cc012','634e6f6a-a979-489e-9b0f-c682d91e3229',NULL,NULL,'3207f1c7-a563-11e8-b258-0800279cc012',40,NULL,40,2916,116650.40000,NULL,116650.40000,2916.26000,'2018-09-26 14:02:19'),('c8ed1261-c198-11e8-8d13-0800279cc012','5ef4c173-d8ae-422c-aa2a-270bea48746b',NULL,NULL,'49729c89-aa05-11e8-b258-0800279cc012',80,NULL,80,590,47200.00000,NULL,47200.00000,590.00000,'2018-09-26 14:30:58'),('d043272e-c194-11e8-8d13-0800279cc012','b5af1866-c4c0-449b-bd9c-8d4c94fd067f',NULL,NULL,'3f1c9bfd-a563-11e8-b258-0800279cc012',35,NULL,35,2916,102069.10000,NULL,102069.10000,2916.26000,'2018-09-26 14:02:32'),('d4b75c51-c195-11e8-8d13-0800279cc012','720f9051-5808-4012-87df-9205550568e3',NULL,NULL,'a91d532b-a564-11e8-b258-0800279cc012',20,NULL,20,729,14581.40000,NULL,14581.40000,729.07000,'2018-09-26 14:09:49'),('d7f0eaae-c194-11e8-8d13-0800279cc012','180542dd-4650-4954-939a-8dfae270f013',NULL,NULL,'49c61303-a563-11e8-b258-0800279cc012',10,NULL,10,2916,29162.60000,NULL,29162.60000,2916.26000,'2018-09-26 14:02:45'),('e0969d1d-c194-11e8-8d13-0800279cc012','01a86fa3-605e-4053-9e17-5c6404130f7b',NULL,NULL,'60901a78-a563-11e8-b258-0800279cc012',25,NULL,25,2916,72906.50000,NULL,72906.50000,2916.26000,'2018-09-26 14:03:00'),('ea94cff2-c194-11e8-8d13-0800279cc012','79a1cffa-c4cd-4779-8aa7-4df7b1746a4d',NULL,NULL,'7115e5f0-a563-11e8-b258-0800279cc012',25,NULL,25,2916,72906.50000,NULL,72906.50000,2916.26000,'2018-09-26 14:03:16'),('f3f92e47-c194-11e8-8d13-0800279cc012','16c980e4-8de0-4457-b0bf-d4a78040b78e',NULL,NULL,'80378f7b-a563-11e8-b258-0800279cc012',30,NULL,30,2916,87487.80000,NULL,87487.80000,2916.26000,'2018-09-26 14:03:32'),('fc0a313d-c194-11e8-8d13-0800279cc012','52438d18-a5ef-4f41-b59c-f0c5f25bbefe',NULL,NULL,'af2720df-a563-11e8-b258-0800279cc012',20,NULL,20,2916,58325.20000,NULL,58325.20000,2916.26000,'2018-09-26 14:03:46');
/*!40000 ALTER TABLE `inventarioInsumo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventarioProducto`
--

DROP TABLE IF EXISTS `inventarioProducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventarioProducto` (
  `id` char(36) NOT NULL,
  `idOrdenEntrada` char(36) DEFAULT NULL,
  `idOrdenSalida` char(36) DEFAULT NULL,
  `idProducto` char(36) NOT NULL,
  `entrada` decimal(10,0) DEFAULT NULL,
  `salida` decimal(10,0) DEFAULT NULL,
  `saldo` decimal(10,0) NOT NULL,
  `costoAdquisicion` decimal(10,0) DEFAULT NULL,
  `valorEntrada` decimal(18,5) DEFAULT NULL,
  `valorSalida` decimal(18,5) DEFAULT NULL,
  `valorSaldo` decimal(18,5) NOT NULL,
  `costoPromedio` decimal(18,5) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventarioProducto`
--

LOCK TABLES `inventarioProducto` WRITE;
/*!40000 ALTER TABLE `inventarioProducto` DISABLE KEYS */;
INSERT INTO `inventarioProducto` VALUES ('0432da99-c196-11e8-8d13-0800279cc012','cd7659a9-9b29-4f51-a30f-b1b846d36f08',NULL,'07903351-a62e-11e8-b258-0800279cc012',3,NULL,3,1018140,3054420.03000,NULL,3054420.03000,1018140.01000,'2018-09-26 14:11:09'),('0811119f-c197-11e8-8d13-0800279cc012','b555d814-b5c1-4b81-bdc7-618aeff90393',NULL,'0cdf88ba-a62f-11e8-b258-0800279cc012',24000,NULL,24000,9,221520.00000,NULL,221520.00000,9.23000,'2018-09-26 14:18:25'),('1026ab3f-c25f-11e8-8d13-0800279cc012',NULL,'d14e4f26-f176-49e1-9e0a-6343fbcbf445','0cdf88ba-a62f-11e8-b258-0800279cc012',NULL,30,23970,NULL,NULL,276.90000,221243.10000,0.00000,'2018-09-27 14:10:18'),('103c476e-c25f-11e8-8d13-0800279cc012',NULL,'d14e4f26-f176-49e1-9e0a-6343fbcbf445','1c01164d-a62f-11e8-b258-0800279cc012',NULL,30,23818,NULL,NULL,792.00000,628795.20000,0.00000,'2018-09-27 14:10:18'),('104ccfcb-c25f-11e8-8d13-0800279cc012',NULL,'d14e4f26-f176-49e1-9e0a-6343fbcbf445','779381ea-a58a-11e8-b258-0800279cc012',NULL,30,30,NULL,NULL,7655.10000,7655.10000,0.00000,'2018-09-27 14:10:18'),('14feac11-c197-11e8-8d13-0800279cc012','f129bdce-bd88-4ef1-8c92-e4858bcbdb0a',NULL,'ecd762a7-a58c-11e8-b258-0800279cc012',2000,NULL,2000,7,14000.00000,NULL,14000.00000,7.00000,'2018-09-26 14:18:47'),('1e244e29-c197-11e8-8d13-0800279cc012','3839cb93-1654-4e5a-b6fc-6a0ea568fded',NULL,'0a7ce055-a58d-11e8-b258-0800279cc012',2000,NULL,2000,7,14000.00000,NULL,14000.00000,7.00000,'2018-09-26 14:19:02'),('295445f1-c197-11e8-8d13-0800279cc012','9183c55a-bf41-4195-ab57-8ce4635ba5d1',NULL,'1c01164d-a62f-11e8-b258-0800279cc012',23848,NULL,23848,26,629587.20000,NULL,629587.20000,26.40000,'2018-09-26 14:19:21'),('3237242a-c19a-11e8-8d13-0800279cc012','4e3f6512-daf1-4a15-9388-2edc82061e52',NULL,'eca0acc2-a64b-11e8-b258-0800279cc012',4,NULL,4,1114,4454.07120,NULL,4454.07120,1113.51780,'2018-09-26 14:41:04'),('324149c3-c19a-11e8-8d13-0800279cc012','4e3f6512-daf1-4a15-9388-2edc82061e52',NULL,'ef3fcb6a-a64c-11e8-b258-0800279cc012',4,NULL,4,1114,4454.07120,NULL,4454.07120,1113.51780,'2018-09-26 14:41:04'),('35f752b7-c196-11e8-8d13-0800279cc012','a0daedc4-32c9-4e7b-8146-44cf81774fa7',NULL,'22ce212a-a62e-11e8-b258-0800279cc012',10,NULL,10,17862,178621.10000,NULL,178621.10000,17862.11000,'2018-09-26 14:12:32'),('396faaf8-c197-11e8-8d13-0800279cc012','0766f0ba-0cd8-419f-9aff-3c0b23079ab7',NULL,'417029a9-a58d-11e8-b258-0800279cc012',2,NULL,2,46660,93320.38000,NULL,93320.38000,46660.19000,'2018-09-26 14:19:48'),('4056e2fc-c19b-11e8-8d13-0800279cc012','3cdf5c31-286c-4c65-a8d0-c127b5cc2949',NULL,'b298fd5c-a64b-11e8-b258-0800279cc012',4,NULL,4,1114,4454.07120,NULL,4454.07120,1113.51780,'2018-09-26 14:48:37'),('41ee47a7-c196-11e8-8d13-0800279cc012','bd866b56-13b0-4829-b437-1a88056f57d9',NULL,'2a2a3a5f-a58a-11e8-b258-0800279cc012',3,NULL,3,22965,68895.00000,NULL,68895.00000,22965.00000,'2018-09-26 14:12:53'),('423f52ed-c197-11e8-8d13-0800279cc012','9c6a4cc1-1c28-4ab3-9d33-d593d852daa5',NULL,'467a2aa7-a62f-11e8-b258-0800279cc012',2,NULL,2,55409,110817.96000,NULL,110817.96000,55408.98000,'2018-09-26 14:20:03'),('4c63bfce-c197-11e8-8d13-0800279cc012','718030f0-ee93-4179-8d5d-e848cabafde6',NULL,'3150ac55-a62f-11e8-b258-0800279cc012',1,NULL,1,113734,113734.22000,NULL,113734.22000,113734.22000,'2018-09-26 14:20:20'),('4d7bfe33-c325-11e8-8d13-0800279cc012','bbfde1ee-d1f1-4812-af16-37f481e27d01',NULL,'49acc603-a64d-11e8-b258-0800279cc012',4,NULL,4,1084,4336.38880,NULL,4336.38880,1084.09720,'2018-09-28 13:49:21'),('4d902647-c196-11e8-8d13-0800279cc012','9f354ea2-c9bd-457b-8278-c5c6c77285de',NULL,'4393476b-a62e-11e8-b258-0800279cc012',168,NULL,168,1021,171475.92000,NULL,171475.92000,1020.69000,'2018-09-26 14:13:12'),('566a26b1-c325-11e8-8d13-0800279cc012',NULL,'63cc0b1b-bc55-48da-a179-39578a0d45dc','49acc603-a64d-11e8-b258-0800279cc012',NULL,2,2,NULL,NULL,2168.19440,2168.19440,0.00000,'2018-09-28 13:49:36'),('56d47036-c197-11e8-8d13-0800279cc012','cc0dad03-e2e0-42c6-a968-be9516ae4013',NULL,'76638b19-a58d-11e8-b258-0800279cc012',2,NULL,2,34995,69990.30000,NULL,69990.30000,34995.15000,'2018-09-26 14:20:37'),('57881c7b-c196-11e8-8d13-0800279cc012','c481ba09-0218-4347-a79c-f311eb2bfc5e',NULL,'779381ea-a58a-11e8-b258-0800279cc012',60,NULL,60,255,15310.20000,NULL,15310.20000,255.17000,'2018-09-26 14:13:29'),('625a5de6-c197-11e8-8d13-0800279cc012','7113c4c9-aa05-4b4c-b47d-b6e93088b3a0',NULL,'a040d8d4-a58d-11e8-b258-0800279cc012',10,NULL,10,2916,29162.60000,NULL,29162.60000,2916.26000,'2018-09-26 14:20:56'),('6a7e54e6-c197-11e8-8d13-0800279cc012','4fd68222-77a9-4fd1-bcc0-d04ee1be9bdd',NULL,'be639949-a58d-11e8-b258-0800279cc012',10,NULL,10,2916,29162.60000,NULL,29162.60000,2916.26000,'2018-09-26 14:21:10'),('6eaab710-c196-11e8-8d13-0800279cc012','dff1a6ff-bbbf-4b55-92ac-7b22a0c83d3e',NULL,'9bc3c191-a58a-11e8-b258-0800279cc012',60,NULL,60,128,7655.40000,NULL,7655.40000,127.59000,'2018-09-26 14:14:08'),('759aa8af-c197-11e8-8d13-0800279cc012','0d8e8bdd-a7f2-4973-b1b5-6bba98fe5204',NULL,'e6539ab5-a58d-11e8-b258-0800279cc012',4,NULL,4,10207,40827.68000,NULL,40827.68000,10206.92000,'2018-09-26 14:21:29'),('7c666a27-c196-11e8-8d13-0800279cc012','c975c806-4b90-4d52-a237-0fb12e78f52f',NULL,'5e7d3cd0-a62e-11e8-b258-0800279cc012',4,NULL,4,61242,244966.00000,NULL,244966.00000,61241.50000,'2018-09-26 14:14:31'),('7ecc39e1-c197-11e8-8d13-0800279cc012','7330de70-f5bd-4a91-8bec-924f4f05e919',NULL,'0d36c8db-a58e-11e8-b258-0800279cc012',2,NULL,2,7874,15747.82000,NULL,15747.82000,7873.91000,'2018-09-26 14:21:44'),('84ab8c87-c196-11e8-8d13-0800279cc012','53932399-7ada-4fcd-a79e-b08441f21566',NULL,'8fc42890-a62e-11e8-b258-0800279cc012',10,NULL,10,12248,122483.00000,NULL,122483.00000,12248.30000,'2018-09-26 14:14:44'),('898c5197-c19d-11e8-8d13-0800279cc012','537351da-43a1-4761-89ec-9910aa482de3',NULL,'5510045b-b5ce-11e8-8061-0800279cc012',1,NULL,1,1701,1701.19100,NULL,1701.19100,1701.19100,'2018-09-26 15:04:59'),('8a26d6d0-c197-11e8-8d13-0800279cc012','e4e54945-587a-4854-a0f4-813b1ca4f32e',NULL,'1ffe07bf-a58e-11e8-b258-0800279cc012',8,NULL,8,7349,58791.84000,NULL,58791.84000,7348.98000,'2018-09-26 14:22:03'),('92093b24-c196-11e8-8d13-0800279cc012','d008d9dc-9f85-4318-9447-f453ae5e0f99',NULL,'fc0acd5f-a58a-11e8-b258-0800279cc012',40,NULL,40,1914,76552.00000,NULL,76552.00000,1913.80000,'2018-09-26 14:15:07'),('9da6dfa9-c197-11e8-8d13-0800279cc012','58125964-06b9-4bb2-8f06-fe164eb47de3',NULL,'318efd1b-a58e-11e8-b258-0800279cc012',8,NULL,8,5833,46660.16000,NULL,46660.16000,5832.52000,'2018-09-26 14:22:36'),('9fdf82a2-c196-11e8-8d13-0800279cc012','2c4122ec-0cc0-4deb-8085-870ecea094cb',NULL,'0da5e444-a62a-11e8-b258-0800279cc012',144,NULL,144,1489,214345.44000,NULL,214345.44000,1488.51000,'2018-09-26 14:15:30'),('a71ba00d-c197-11e8-8d13-0800279cc012','31b73ace-ba0c-493a-a217-a651158cae6e',NULL,'4c65ebb3-a58e-11e8-b258-0800279cc012',2,NULL,2,6707,13414.80000,NULL,13414.80000,6707.40000,'2018-09-26 14:22:52'),('aab4a57b-c196-11e8-8d13-0800279cc012','abbcaaa2-a557-409b-9020-8718965d7547',NULL,'409bd3ad-a58b-11e8-b258-0800279cc012',1,NULL,1,22966,22965.56000,NULL,22965.56000,22965.56000,'2018-09-26 14:15:48'),('b032d844-c19a-11e8-8d13-0800279cc012',NULL,'3adc5a92-9937-425b-af4e-82118300dced','eca0acc2-a64b-11e8-b258-0800279cc012',NULL,2,2,NULL,NULL,2227.03560,2227.03560,0.00000,'2018-09-26 14:44:36'),('b04210d0-c19a-11e8-8d13-0800279cc012',NULL,'3adc5a92-9937-425b-af4e-82118300dced','ef3fcb6a-a64c-11e8-b258-0800279cc012',NULL,2,2,NULL,NULL,2227.03560,2227.03560,0.00000,'2018-09-26 14:44:36'),('b2d69928-c1ae-11e8-8d13-0800279cc012',NULL,'fe45d517-feb4-436a-9767-a338eadc22a2','5510045b-b5ce-11e8-8061-0800279cc012',NULL,1,0,NULL,NULL,1701.19100,0.00000,0.00000,'2018-09-26 17:07:50'),('b5938f90-c197-11e8-8d13-0800279cc012','89ca38f0-9548-4a42-aade-cb580aebbda2',NULL,'62b8fea9-a58e-11e8-b258-0800279cc012',2,NULL,2,6707,13414.80000,NULL,13414.80000,6707.40000,'2018-09-26 14:23:16'),('ba4aaec0-c196-11e8-8d13-0800279cc012','8bbf6664-eee1-4f24-bf35-ec40adcab598',NULL,'4eea04f4-a58b-11e8-b258-0800279cc012',2,NULL,2,6124,12248.30000,NULL,12248.30000,6124.15000,'2018-09-26 14:16:14'),('bcc9e849-c197-11e8-8d13-0800279cc012','3df4846c-43e8-45b3-8526-e0189f28318f',NULL,'79605c96-a58e-11e8-b258-0800279cc012',2,NULL,2,6707,13414.80000,NULL,13414.80000,6707.40000,'2018-09-26 14:23:28'),('c650f53f-c196-11e8-8d13-0800279cc012','630e8951-6fb2-4ab3-ad97-0687baad80ca',NULL,'67b239ae-a58b-11e8-b258-0800279cc012',6,NULL,6,1276,7655.16000,NULL,7655.16000,1275.86000,'2018-09-26 14:16:35'),('cbd8ff9d-c197-11e8-8d13-0800279cc012','8c6fd295-c912-40e1-9c6f-b595d135aa51',NULL,'945818b4-a58e-11e8-b258-0800279cc012',2,NULL,2,6707,13414.80000,NULL,13414.80000,6707.40000,'2018-09-26 14:23:53'),('d340cc97-c197-11e8-8d13-0800279cc012','2a6c213a-1dc1-40b0-a8fa-d6abe7cbe278',NULL,'a17c90c5-a58e-11e8-b258-0800279cc012',2,NULL,2,6707,13414.80000,NULL,13414.80000,6707.40000,'2018-09-26 14:24:06'),('d42608f6-c196-11e8-8d13-0800279cc012','bb5cbb51-f4bf-43c2-8367-6cc29f3fc590',NULL,'a7cc750c-a62e-11e8-b258-0800279cc012',13997,NULL,13997,23,326410.04000,NULL,326410.04000,23.32000,'2018-09-26 14:16:58'),('dbabfdb1-c197-11e8-8d13-0800279cc012','4e0c2a2c-e241-40b7-8f5c-2f4260df0dca',NULL,'b58ecc55-a58e-11e8-b258-0800279cc012',2,NULL,2,6707,13414.80000,NULL,13414.80000,6707.40000,'2018-09-26 14:24:20'),('e10eae33-c196-11e8-8d13-0800279cc012','34ee7bd9-7d3e-4832-b50f-6f3a8340fc3a',NULL,'b8d5372b-a62e-11e8-b258-0800279cc012',6000,NULL,6000,29,174960.00000,NULL,174960.00000,29.16000,'2018-09-26 14:17:19'),('e31f40b2-c197-11e8-8d13-0800279cc012','b61dd5d8-5347-4670-be5c-2fee33ce4b4d',NULL,'e4833657-a58e-11e8-b258-0800279cc012',2,NULL,2,6707,13414.80000,NULL,13414.80000,6707.40000,'2018-09-26 14:24:32'),('ea7cc78e-c197-11e8-8d13-0800279cc012','cd5dc24b-dc7c-4ae8-96ea-99c7c1064edd',NULL,'f1aeee28-a58e-11e8-b258-0800279cc012',2,NULL,2,6707,13414.80000,NULL,13414.80000,6707.40000,'2018-09-26 14:24:45'),('f322e947-c196-11e8-8d13-0800279cc012','a4551136-0e17-4b60-93bf-9afc4880f131',NULL,'b948f654-a636-11e8-b258-0800279cc012',14032,NULL,14032,111,1551518.24000,NULL,1551518.24000,110.57000,'2018-09-26 14:17:50'),('fc60cfde-c197-11e8-8d13-0800279cc012','1a0e60ba-ca32-4499-802e-c7d4f0006003',NULL,'fe1e806b-a58e-11e8-b258-0800279cc012',2,NULL,2,6707,13414.80000,NULL,13414.80000,6707.40000,'2018-09-26 14:25:15'),('ff033515-c196-11e8-8d13-0800279cc012','1819d2e3-bd7b-49b1-8ee0-d2d9b8095e1d',NULL,'9c6e039f-a638-11e8-b258-0800279cc012',5990,NULL,5990,111,664470.70000,NULL,664470.70000,110.93000,'2018-09-26 14:18:10');
/*!40000 ALTER TABLE `inventarioProducto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipAutorizada`
--

DROP TABLE IF EXISTS `ipAutorizada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipAutorizada` (
  `ip` char(200) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipAutorizada`
--

LOCK TABLES `ipAutorizada` WRITE;
/*!40000 ALTER TABLE `ipAutorizada` DISABLE KEYS */;
INSERT INTO `ipAutorizada` VALUES ('10.0.0.113','2018-09-23 23:24:52'),('10.129.29.185','2018-07-27 14:05:48'),('10.129.29.198','2018-07-28 05:20:58'),('10.129.29.217','2018-07-07 16:13:54'),('10.129.29.48','2018-07-16 04:25:49'),('10.129.29.64','2018-07-17 05:47:45'),('10.129.29.85','2018-07-12 20:45:58'),('10.129.6.21','2018-07-25 01:56:20'),('10.129.6.30','2018-09-06 16:01:16'),('10.129.6.48','2018-07-16 04:26:21'),('10.129.6.59','2018-07-12 20:47:01'),('10.129.6.73','2018-07-08 01:10:49'),('10.129.6.85','2018-08-01 22:33:37'),('10.237.121.166','2018-09-27 23:09:18'),('10.240.221.235','2018-09-28 00:00:20'),('10.242.14.99','2018-09-27 23:31:03'),('10.3.164.16','2018-09-10 18:18:34'),('10.3.164.216','2018-09-10 18:24:25'),('10.34.164.22','2018-09-10 20:40:53'),('10.34.164.23','2018-08-16 16:30:00'),('10.34.164.24','2018-07-05 19:50:17'),('10.34.165.15','2018-07-05 20:08:03'),('10.34.165.20','2018-09-04 00:45:36'),('10.42.0.23','2018-08-30 22:41:27'),('168.81.162.245','2018-08-14 15:00:52'),('172.20.10.5','2018-08-04 00:16:02'),('192.168.0.100','2018-07-17 17:18:00'),('192.168.0.101','2018-08-03 23:04:10'),('192.168.0.102','2018-08-15 18:37:12'),('192.168.0.12','2018-09-17 17:05:39'),('192.168.0.120','2018-08-14 15:02:07'),('192.168.0.121','2018-07-07 00:27:25'),('192.168.0.13','2018-08-21 01:25:47'),('192.168.0.14','2018-07-14 01:50:22'),('192.168.0.20','2018-07-20 16:22:22'),('192.168.0.21','2018-08-03 07:46:05'),('192.168.0.25','2018-08-03 09:37:39'),('192.168.1.10','2018-09-19 06:30:08'),('192.168.1.100','2018-08-21 16:44:39'),('192.168.1.105','2018-08-16 16:30:00'),('192.168.1.11','2018-08-11 00:15:44'),('192.168.1.123','2018-07-07 00:36:27'),('192.168.1.155','2018-07-07 00:37:20'),('192.168.1.18','2018-07-07 23:28:50'),('192.168.1.5','2018-07-30 02:58:54'),('192.168.1.7','2018-07-07 00:27:25'),('192.168.1.8','2018-07-07 23:28:50'),('192.168.1.81','2018-07-14 18:22:32'),('192.168.10.100','2018-10-02 17:22:58'),('192.168.10.101','2018-08-16 18:38:17'),('192.168.10.102','2018-08-16 18:38:24'),('192.168.10.20','2018-08-14 15:00:03'),('192.168.10.21','2018-08-14 15:00:13'),('192.168.43.235','2018-07-08 01:10:49'),('192.168.43.4','2018-07-20 21:35:54'),('198.168.0.10','2018-09-17 17:30:08'),('198.168.0.15','2018-09-17 17:30:08'),('198.168.1.10','2018-09-19 06:30:08'),('201.191.198.223','2018-09-27 23:13:19');
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
-- Table structure for table `mermaInsumo`
--

DROP TABLE IF EXISTS `mermaInsumo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mermaInsumo` (
  `id` char(36) NOT NULL,
  `idInsumo` char(36) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `descripcion` varchar(450) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `consecutivo` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Histórico de merma de Insumo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mermaInsumo`
--

LOCK TABLES `mermaInsumo` WRITE;
/*!40000 ALTER TABLE `mermaInsumo` DISABLE KEYS */;
/*!40000 ALTER TABLE `mermaInsumo` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tropical`.`mermaInsumo_BEFORE_INSERT` BEFORE INSERT ON `mermaInsumo` FOR EACH ROW
BEGIN
	SELECT consecutivo
	INTO @nnumeroconsecutivo
	FROM mermaInsumo
	ORDER BY consecutivo DESC LIMIT 1;
    IF @nnumeroconsecutivo IS NULL then
		set @nnumeroconsecutivo=0;
	END IF;
	
	SET NEW.consecutivo = @nnumeroconsecutivo+1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `mermaProducto`
--

DROP TABLE IF EXISTS `mermaProducto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mermaProducto` (
  `id` char(36) NOT NULL,
  `idProducto` char(36) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `descripcion` varchar(450) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `consecutivo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Histórico de merma de Producto terminado';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mermaProducto`
--

LOCK TABLES `mermaProducto` WRITE;
/*!40000 ALTER TABLE `mermaProducto` DISABLE KEYS */;
/*!40000 ALTER TABLE `mermaProducto` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `tropical`.`mermaProducto_BEFORE_INSERT` BEFORE INSERT ON `mermaProducto` FOR EACH ROW
BEGIN
	SELECT consecutivo
	INTO @nnumeroconsecutivo
	FROM mermaProducto
	ORDER BY consecutivo DESC LIMIT 1;
    IF @nnumeroconsecutivo IS NULL then
		set @nnumeroconsecutivo=0;
	END IF;
	
	SET NEW.consecutivo = @nnumeroconsecutivo+1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

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
  `idProveedor` char(36) NOT NULL DEFAULT '0f8aef81-7400-4a36-93f9-b929d4889d0e',
  `orden` varchar(100) DEFAULT NULL,
  `idUsuario` char(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ordenCompra_usuario1_idx` (`idUsuario`),
  CONSTRAINT `fk_ordenCompra_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Almacena historial de Ordenes de compra o Facturas del proveedor y el valor historico original de los items comprados.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordenCompra`
--

LOCK TABLES `ordenCompra` WRITE;
/*!40000 ALTER TABLE `ordenCompra` DISABLE KEYS */;
INSERT INTO `ordenCompra` VALUES ('01a86fa3-605e-4053-9e17-5c6404130f7b','2018-09-26 14:03:00','','247671','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('0e5448ff-e81f-4a3a-93d8-62d4aaacd65e','2018-09-26 15:02:40','Proveedor Estándar','2018-0004450','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('2434f68a-3338-4e32-9122-da0ecf185ab4','2018-09-26 14:33:00','Proveedor Estándar','000001','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('4b48eea8-1b78-41c9-b213-7de4de904a7e','2018-09-28 01:16:59','Proveedor Estándar','00000','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('5ef4c173-d8ae-422c-aa2a-270bea48746b','2018-09-26 14:30:58','Proveedor Estándar','123456','1ed3a48c-3e44-11e8-9ddb-54ee75873a60');
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
INSERT INTO `ordenSalida` VALUES ('3cdf5c31-286c-4c65-a8d0-c127b5cc2949','2018-09-26 14:48:37',2,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','fd9d2be6-6999-40ce-9954-1462c9ca0ffb','2018-09-26 14:46:10','1'),('4c9abe66-ffe7-4db6-9b52-4ebd9529651a','2018-09-27 13:49:58',4,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','fd9d2be6-6999-40ce-9954-1462c9ca0ffb',NULL,'0'),('4e3f6512-daf1-4a15-9388-2edc82061e52','2018-09-26 14:41:04',1,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','fd9d2be6-6999-40ce-9954-1462c9ca0ffb','2018-09-26 14:38:37','1'),('537351da-43a1-4761-89ec-9910aa482de3','2018-09-26 15:04:59',3,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','fd9d2be6-6999-40ce-9954-1462c9ca0ffb','2018-09-26 15:02:32','1'),('bbfde1ee-d1f1-4812-af16-37f481e27d01','2018-09-28 13:49:21',5,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','fd9d2be6-6999-40ce-9954-1462c9ca0ffb','2018-09-28 13:46:51','1');
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
	
	SELECT numeroOrden
	INTO @nnumeroorden
	FROM ordenSalida
	ORDER BY numeroOrden DESC LIMIT 1;
    IF @nnumeroorden IS NULL then
		set @nnumeroorden=0;
	END IF;
	
	SET NEW.numeroOrden = @nnumeroorden+1;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `pais`
--

DROP TABLE IF EXISTS `pais`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) DEFAULT NULL,
  `iso2` varchar(2) DEFAULT NULL,
  `iso3` varchar(3) DEFAULT NULL,
  `codigoTelefono` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=247 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pais`
--

LOCK TABLES `pais` WRITE;
/*!40000 ALTER TABLE `pais` DISABLE KEYS */;
INSERT INTO `pais` VALUES (1,'AFGANISTÁN','AF','AFG',93),(2,'ALBANIA','AL','ALB',355),(3,'ALEMANIA','DE','DEU',49),(4,'ALGERIA','DZ','DZA',213),(5,'ANDORRA','AD','AND',376),(6,'ANGOLA','AO','AGO',244),(7,'ANGUILA','AI','AIA',1264),(8,'ANTÁRTIDA','AQ','ATA',672),(9,'ANTIGUA Y BARBUDA','AG','ATG',1268),(10,'ANTILLAS NEERLANDESAS','AN','ANT',599),(11,'ARABIA SAUDITA','SA','SAU',966),(12,'ARGENTINA','AR','ARG',54),(13,'ARMENIA','AM','ARM',374),(14,'ARUBA','AW','ABW',297),(15,'AUSTRALIA','AU','AUS',61),(16,'AUSTRIA','AT','AUT',43),(17,'AZERBAYÁN','AZ','AZE',994),(18,'BÉLGICA','BE','BEL',32),(19,'BAHAMAS','BS','BHS',1242),(20,'BAHREIN','BH','BHR',973),(21,'BANGLADESH','BD','BGD',880),(22,'BARBADOS','BB','BRB',1246),(23,'BELICE','BZ','BLZ',501),(24,'BENÍN','BJ','BEN',229),(25,'BHUTÁN','BT','BTN',975),(26,'BIELORRUSIA','BY','BLR',375),(27,'BIRMANIA','MM','MMR',95),(28,'BOLIVIA','BO','BOL',591),(29,'BOSNIA Y HERZEGOVINA','BA','BIH',387),(30,'BOTSUANA','BW','BWA',267),(31,'BRASIL','BR','BRA',55),(32,'BRUNÉI','BN','BRN',673),(33,'BULGARIA','BG','BGR',359),(34,'BURKINA FASO','BF','BFA',226),(35,'BURUNDI','BI','BDI',257),(36,'CABO VERDE','CV','CPV',238),(37,'CAMBOYA','KH','KHM',855),(38,'CAMERÚN','CM','CMR',237),(39,'CANADÁ','CA','CAN',1),(40,'CHAD','TD','TCD',235),(41,'CHILE','CL','CHL',56),(42,'CHINA','CN','CHN',86),(43,'CHIPRE','CY','CYP',357),(44,'CIUDAD DEL VATICANO','VA','VAT',39),(45,'COLOMBIA','CO','COL',57),(46,'COMORAS','KM','COM',269),(47,'CONGO','CG','COG',242),(48,'CONGO','CD','COD',243),(49,'COREA DEL NORTE','KP','PRK',850),(50,'COREA DEL SUR','KR','KOR',82),(51,'COSTA DE MARFIL','CI','CIV',225),(52,'COSTA RICA','CR','CRI',506),(53,'CROACIA','HR','HRV',385),(54,'CUBA','CU','CUB',53),(55,'DINAMARCA','DK','DNK',45),(56,'DOMINICA','DM','DMA',1767),(57,'ECUADOR','EC','ECU',593),(58,'EGIPTO','EG','EGY',20),(59,'EL SALVADOR','SV','SLV',503),(60,'EMIRATOS ÁRABES UNIDOS','AE','ARE',971),(61,'ERITREA','ER','ERI',291),(62,'ESLOVAQUIA','SK','SVK',421),(63,'ESLOVENIA','SI','SVN',386),(64,'ESPAÑA','ES','ESP',34),(65,'ESTADOS UNIDOS DE AMÉRICA','US','USA',1),(66,'ESTONIA','EE','EST',372),(67,'ETIOPÍA','ET','ETH',251),(68,'FILIPINAS','PH','PHL',63),(69,'FINLANDIA','FI','FIN',358),(70,'FIYI','FJ','FJI',679),(71,'FRANCIA','FR','FRA',33),(72,'GABÓN','GA','GAB',241),(73,'GAMBIA','GM','GMB',220),(74,'GEORGIA','GE','GEO',995),(75,'GHANA','GH','GHA',233),(76,'GIBRALTAR','GI','GIB',350),(77,'GRANADA','GD','GRD',1473),(78,'GRECIA','GR','GRC',30),(79,'GROENLANDIA','GL','GRL',299),(80,'GUADALUPE','GP','GLP',0),(81,'GUAM','GU','GUM',1671),(82,'GUATEMALA','GT','GTM',502),(83,'GUAYANA FRANCESA','GF','GUF',0),(84,'GUERNSEY','GG','GGY',0),(85,'GUINEA','GN','GIN',224),(86,'GUINEA ECUATORIAL','GQ','GNQ',240),(87,'GUINEA-BISSAU','GW','GNB',245),(88,'GUYANA','GY','GUY',592),(89,'HAITÍ','HT','HTI',509),(90,'HONDURAS','HN','HND',504),(91,'HONG KONG','HK','HKG',852),(92,'HUNGRÍA','HU','HUN',36),(93,'INDIA','IN','IND',91),(94,'INDONESIA','ID','IDN',62),(95,'IRÁN','IR','IRN',98),(96,'IRAK','IQ','IRQ',964),(97,'IRLANDA','IE','IRL',353),(98,'ISLA BOUVET','BV','BVT',0),(99,'ISLA DE MAN','IM','IMN',44),(100,'ISLA DE NAVIDAD','CX','CXR',61),(101,'ISLA NORFOLK','NF','NFK',0),(102,'ISLANDIA','IS','ISL',354),(103,'ISLAS BERMUDAS','BM','BMU',1441),(104,'ISLAS CAIMÁN','KY','CYM',1345),(105,'ISLAS COCOS (KEELING)','CC','CCK',61),(106,'ISLAS COOK','CK','COK',682),(107,'ISLAS DE ÅLAND','AX','ALA',0),(108,'ISLAS FEROE','FO','FRO',298),(109,'ISLAS GEORGIAS DEL SUR Y SANDWICH DEL SUR','GS','SGS',0),(110,'ISLAS HEARD Y MCDONALD','HM','HMD',0),(111,'ISLAS MALDIVAS','MV','MDV',960),(112,'ISLAS MALVINAS','FK','FLK',500),(113,'ISLAS MARIANAS DEL NORTE','MP','MNP',1670),(114,'ISLAS MARSHALL','MH','MHL',692),(115,'ISLAS PITCAIRN','PN','PCN',870),(116,'ISLAS SALOMÓN','SB','SLB',677),(117,'ISLAS TURCAS Y CAICOS','TC','TCA',1649),(118,'ISLAS ULTRAMARINAS MENORES DE ESTADOS UNIDOS','UM','UMI',0),(119,'ISLAS VÍRGENES BRITÁNICAS','VG','VG',1284),(120,'ISLAS VÍRGENES DE LOS ESTADOS UNIDOS','VI','VIR',1340),(121,'ISRAEL','IL','ISR',972),(122,'ITALIA','IT','ITA',39),(123,'JAMAICA','JM','JAM',1876),(124,'JAPÓN','JP','JPN',81),(125,'JERSEY','JE','JEY',0),(126,'JORDANIA','JO','JOR',962),(127,'KAZAJISTÁN','KZ','KAZ',7),(128,'KENIA','KE','KEN',254),(129,'KIRGIZSTÁN','KG','KGZ',996),(130,'KIRIBATI','KI','KIR',686),(131,'KUWAIT','KW','KWT',965),(132,'LÍBANO','LB','LBN',961),(133,'LAOS','LA','LAO',856),(134,'LESOTO','LS','LSO',266),(135,'LETONIA','LV','LVA',371),(136,'LIBERIA','LR','LBR',231),(137,'LIBIA','LY','LBY',218),(138,'LIECHTENSTEIN','LI','LIE',423),(139,'LITUANIA','LT','LTU',370),(140,'LUXEMBURGO','LU','LUX',352),(141,'MÉXICO','MX','MEX',52),(142,'MÓNACO','MC','MCO',377),(143,'MACAO','MO','MAC',853),(144,'MACEDÔNIA','MK','MKD',389),(145,'MADAGASCAR','MG','MDG',261),(146,'MALASIA','MY','MYS',60),(147,'MALAWI','MW','MWI',265),(148,'MALI','ML','MLI',223),(149,'MALTA','MT','MLT',356),(150,'MARRUECOS','MA','MAR',212),(151,'MARTINICA','MQ','MTQ',0),(152,'MAURICIO','MU','MUS',230),(153,'MAURITANIA','MR','MRT',222),(154,'MAYOTTE','YT','MYT',262),(155,'MICRONESIA','FM','FSM',691),(156,'MOLDAVIA','MD','MDA',373),(157,'MONGOLIA','MN','MNG',976),(158,'MONTENEGRO','ME','MNE',382),(159,'MONTSERRAT','MS','MSR',1664),(160,'MOZAMBIQUE','MZ','MOZ',258),(161,'NAMIBIA','NA','NAM',264),(162,'NAURU','NR','NRU',674),(163,'NEPAL','NP','NPL',977),(164,'NICARAGUA','NI','NIC',505),(165,'NIGER','NE','NER',227),(166,'NIGERIA','NG','NGA',234),(167,'NIUE','NU','NIU',683),(168,'NORUEGA','NO','NOR',47),(169,'NUEVA CALEDONIA','NC','NCL',687),(170,'NUEVA ZELANDA','NZ','NZL',64),(171,'OMÁN','OM','OMN',968),(172,'PAÍSES BAJOS','NL','NLD',31),(173,'PAKISTÁN','PK','PAK',92),(174,'PALAU','PW','PLW',680),(175,'PALESTINA','PS','PSE',0),(176,'PANAMÁ','PA','PAN',507),(177,'PAPÚA NUEVA GUINEA','PG','PNG',675),(178,'PARAGUAY','PY','PRY',595),(179,'PERÚ','PE','PER',51),(180,'POLINESIA FRANCESA','PF','PYF',689),(181,'POLONIA','PL','POL',48),(182,'PORTUGAL','PT','PRT',351),(183,'PUERTO RICO','PR','PRI',1),(184,'QATAR','QA','QAT',974),(185,'REINO UNIDO','GB','GBR',44),(186,'REPÚBLICA CENTROAFRICANA','CF','CAF',236),(187,'REPÚBLICA CHECA','CZ','CZE',420),(188,'REPÚBLICA DOMINICANA','DO','DOM',1809),(189,'REUNIÓN','RE','REU',0),(190,'RUANDA','RW','RWA',250),(191,'RUMANÍA','RO','ROU',40),(192,'RUSIA','RU','RUS',7),(193,'SAHARA OCCIDENTAL','EH','ESH',0),(194,'SAMOA','WS','WSM',685),(195,'SAMOA AMERICANA','AS','ASM',1684),(196,'SAN BARTOLOMÉ','BL','BLM',590),(197,'SAN CRISTÓBAL Y NIEVES','KN','KNA',1869),(198,'SAN MARINO','SM','SMR',378),(199,'SAN MARTÍN (FRANCIA)','MF','MAF',1599),(200,'SAN PEDRO Y MIQUELÓN','PM','SPM',508),(201,'SAN VICENTE Y LAS GRANADINAS','VC','VCT',1784),(202,'SANTA ELENA','SH','SHN',290),(203,'SANTA LUCÍA','LC','LCA',1758),(204,'SANTO TOMÉ Y PRÍNCIPE','ST','STP',239),(205,'SENEGAL','SN','SEN',221),(206,'SERBIA','RS','SRB',381),(207,'SEYCHELLES','SC','SYC',248),(208,'SIERRA LEONA','SL','SLE',232),(209,'SINGAPUR','SG','SGP',65),(210,'SIRIA','SY','SYR',963),(211,'SOMALIA','SO','SOM',252),(212,'SRI LANKA','LK','LKA',94),(213,'SUDÁFRICA','ZA','ZAF',27),(214,'SUDÁN','SD','SDN',249),(215,'SUECIA','SE','SWE',46),(216,'SUIZA','CH','CHE',41),(217,'SURINÁM','SR','SUR',597),(218,'SVALBARD Y JAN MAYEN','SJ','SJM',0),(219,'SWAZILANDIA','SZ','SWZ',268),(220,'TADJIKISTÁN','TJ','TJK',992),(221,'TAILANDIA','TH','THA',66),(222,'TAIWÁN','TW','TWN',886),(223,'TANZANIA','TZ','TZA',255),(224,'TERRITORIO BRITÁNICO DEL OCÉANO ÍNDICO','IO','IOT',0),(225,'TERRITORIOS AUSTRALES Y ANTÁRTICAS FRANCESES','TF','ATF',0),(226,'TIMOR ORIENTAL','TL','TLS',670),(227,'TOGO','TG','TGO',228),(228,'TOKELAU','TK','TKL',690),(229,'TONGA','TO','TON',676),(230,'TRINIDAD Y TOBAGO','TT','TTO',1868),(231,'TUNEZ','TN','TUN',216),(232,'TURKMENISTÁN','TM','TKM',993),(233,'TURQUÍA','TR','TUR',90),(234,'TUVALU','TV','TUV',688),(235,'UCRANIA','UA','UKR',380),(236,'UGANDA','UG','UGA',256),(237,'URUGUAY','UY','URY',598),(238,'UZBEKISTÁN','UZ','UZB',998),(239,'VANUATU','VU','VUT',678),(240,'VENEZUELA','VE','VEN',58),(241,'VIETNAM','VN','VNM',84),(242,'WALLIS Y FUTUNA','WF','WLF',681),(243,'YEMEN','YE','YEM',967),(244,'YIBUTI','DJ','DJI',253),(245,'ZAMBIA','ZM','ZMB',260),(246,'ZIMBABUE','ZW','ZWE',263);
/*!40000 ALTER TABLE `pais` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `preciosXBodega` VALUES ('39d0f5a3-b5df-11e8-8061-0800279cc012','d6cd8440-8906-4e4a-9e08-8af36695c5eb','0',1500.00000),('39d6ff0a-b5df-11e8-8061-0800279cc012','d6cd8440-8906-4e4a-9e08-8af36695c5eb','1',2500.00000),('63363882-a840-4517-9786-67f148f6a580','63363882-a840-4517-9786-67f148f6a587','1',2500.00000),('63363882-a840-4517-9786-67f148f6a581','63363882-a840-4517-9786-67f148f6a587','0',1500.00000),('8079b095-91ad-11e8-b0db-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1',2500.00000),('88bed187-8a3e-11e8-abed-f2f00eda9788','72a5afa7-dcba-4539-8257-ed1e18b1ce94','1',2500.00000),('88d26ca7-8a3e-11e8-abed-f2f00eda9788','72a5afa7-dcba-4539-8257-ed1e18b1ce94','0',1500.00000),('8a9277b7-91ad-11e8-b0db-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','0',1500.00000);
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
  `saldoCosto` decimal(18,5) NOT NULL,
  `costoPromedio` decimal(18,5) NOT NULL,
  `precioVenta` decimal(18,5) NOT NULL,
  `esVenta` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES ('002c4bf1-a64d-11e8-b258-0800279cc012','SIR-REDRA','SIROPE DE FRAMBUESA ROJA','#080708','#e36c9e','RERA','BOTELLA DE SIROPE DE FRAMBUESA ROJA 750 ML',0,0.00000,0.00000,0.00000,1),('03156aa0-a64c-11e8-b258-0800279cc012','SIR-BLUER','SIROPE DE FRAMBUESA AZUL','#fff9f9','#1325c7','BLUR','BOTELLA DE SIROPE DE FRAMBUESA AZUL 750 ML',0,0.00000,0.00000,0.00000,1),('07903351-a62e-11e8-b258-0800279cc012','MS-SI100E','RASPADORA DE HIELO','#000000','#ffffff','RASP','SWAN SI-100 RASPADORA DE HIELO EN BLOQUE (115 VOLT)',3,3054420.03000,1018140.01000,0.00000,0),('0a7ce055-a58d-11e8-b258-0800279cc012','CP-FHGLOVES-L','GUANTES TALLA L','','','GUAL','GUANTES PLÁSTICOS MANIPULADORES DE ALIMENTOS TALLA L',2000,14000.00000,7.00000,0.00000,0),('0cdf88ba-a62f-11e8-b258-0800279cc012','CP-NAPKINS','SERVILLETAS','','','SERV','SERVILLETAS CON LOGO IMPRESO',23970,221243.10000,9.23000,0.00000,0),('0d36c8db-a58e-11e8-b258-0800279cc012','AP-P-CPO-21','LÁMINA TRANSLÚCIDA PEQUEÑA','','','LAMP','LÁMINA PLÁSTICA TRANSLÚCIDA PROTECTORA PARA PÓSTER PEQUEÑA (21X33 PULGADAS)',2,15747.82000,7873.91000,0.00000,0),('0da5e444-a62a-11e8-b258-0800279cc012','AC-ICEPAIL','CUBOS PARA HIELO','#000000','#ffffff','CUBS','CUBOS PLASTICOS PARA FABRICAR HIELO',144,214345.44000,1488.51000,0.00000,0),('103cd805-a64d-11e8-b258-0800279cc012','SIR-ROOTB','SIROPE DE ZARZA','#faf4f4','#804821','ROOT','BOTELLA DE SIROPE DE ZARZA 750 ML',0,0.00000,0.00000,0.00000,1),('130612f5-a64c-11e8-b258-0800279cc012','SIR-BUBBL','SIROPE DE CHICLE','#59c4db','#2348c9','BUBB','BOTELLA DE SIROPE DE CHICLE 750 ML',0,0.00000,0.00000,0.00000,1),('1c01164d-a62f-11e8-b258-0800279cc012','CP-SPOONS-C1','CUCHARAS','','','CUCR','CUCHARAS PLÁSTICAS',23818,628795.20000,26.40000,0.00000,0),('1ffe07bf-a58e-11e8-b258-0800279cc012','CL-APRON-FBL','DELANTAL PLÁSTICO','','','DELA','DELANTAL PLÁSTICO COMPLETO',8,58791.84000,7348.98000,0.00000,0),('205d81ff-a64d-11e8-b258-0800279cc012','SIR-STRAW','SIROPE DE FRESA','#0a0a0a','#d94065','STRW','BOTELLA DE SIROPE DE FRESA 750 ML',0,0.00000,0.00000,0.00000,1),('20d7dfd1-a64c-11e8-b258-0800279cc012','SIR-COCON','SIROPE DE COCO','#0d0c0c','#f6f7cc','COCO','BOTELLA DE SIROPE DE COCO 750 ML',0,0.00000,0.00000,0.00000,1),('22ce212a-a62e-11e8-b258-0800279cc012','P-100-12','CUCHILLAS','','','CUCH','CUCHILLAS (SI-100E, SI-150E, SI-200E, SI-38)',10,178621.10000,17862.11000,0.00000,0),('2a2a3a5f-a58a-11e8-b258-0800279cc012','P-FOOT-LA','CONTROL DE PIE','','','PIE','CAJA DE CONTROLADOR DE PIE, PEDAL Y MANGUERA',3,68895.00000,22965.00000,0.00000,0),('3150ac55-a62f-11e8-b258-0800279cc012','AP-P-WCS-28','MOLDURA PARA PÓSTER 4 PATAS','','','MOL4','MOLDURA PARA PÓSTER (WINDMASTER) CON PATAS (28X44 PULGADAS)',1,113734.22000,113734.22000,0.00000,0),('318d41d8-a64c-11e8-b258-0800279cc012','SIR-COLA','SIROPE DE COLA','#f7efef','#f74e29','COLA','BOTELLA DE SIROPE DE COLA 750 ML',0,0.00000,0.00000,0.00000,1),('318efd1b-a58e-11e8-b258-0800279cc012','CL-HAT-OTTO','GORRA MESH','','','MESH','GORRA MESH CON LOGO',8,46660.16000,5832.52000,0.00000,0),('3ab03f8d-a64d-11e8-b258-0800279cc012','SIR-VANIL','SIROPE DE VAINILLA','#0f0e0e','#dec9c9','VANI','BOTELLA DE SIROPE DE VAINILLA 750 ML',0,0.00000,0.00000,0.00000,1),('409bd3ad-a58b-11e8-b258-0800279cc012','AC-QBTREE','ÁRBOL SECADOR PARA BOTELLAS','','','TREE','ARBOL SECADOR PARA BOTELLAS',1,22965.56000,22965.56000,0.00000,0),('417029a9-a58d-11e8-b258-0800279cc012','AP-P-OPF-21','MOLDURA PARA PÓSTER PEQUEÑA','','','MOLP','MOLDURA PARA PÓSTER EXTERIORES PEQUEÑA (21X33 PULGADAS)',2,93320.38000,46660.19000,0.00000,0),('4393476b-a62e-11e8-b258-0800279cc012','AC-QB-TS-17','BOTELLAS MARCA TROPICAL SNO','','','BOTL','BOTELLAS PLÁSTICAS  CON LA MARCA TROPICAL SNO (INCLUYE ETIQUETAS Y TAPAS)',168,171475.92000,1020.69000,0.00000,0),('467a2aa7-a62f-11e8-b258-0800279cc012','AP-P-OPF-28','MOLDURA PARA PÓSTER GRANDE','','','MOLG','MOLDURA PARA PÓSTER EXTERIORES GRANDE (28 X 44 PULGADAS)',2,110817.96000,55408.98000,0.00000,0),('49acc603-a64d-11e8-b258-0800279cc012','SIR-VERCH','SIROPE DE MUY CEREZA','#faf1f1','#8a1c23','VECH','BOTELLA DE SIROPE DE MUY CEREZA 750 ML',2,2168.19440,1084.09720,0.00000,1),('4bbe7eff-a64c-11e8-b258-0800279cc012','SIR-COTTO','SIROPE DE ALGODÓN DE AZÚCAR','#0d0c0c','#ca91d4','COTT','BOTELLA DE SIROPE DE ALGODÓN DE AZÚCAR 750 ML',0,0.00000,0.00000,0.00000,1),('4c65ebb3-a58e-11e8-b258-0800279cc012','CL-TM-BL-LG','CAMISETA CUELLO AZUL L','','','CAZL','CAMISETA PARA HOMBRE, CUELLO AZUL, TALLA L',2,13414.80000,6707.40000,0.00000,0),('4eea04f4-a58b-11e8-b258-0800279cc012','AC-ICECHIP','CARGADOR DE HIELO','#6e3838','','CARG','CARGADOR DE HIELO',2,12248.30000,6124.15000,0.00000,0),('5510045b-b5ce-11e8-8061-0800279cc012','TOP-COCO','TOPPING DE CREMA DE COCO','#000000','#faf9f9','TCOC','BOTELLA DE TOPPING DE COCO (950 MILILITROS)',0,0.00000,1701.19100,0.00000,2),('58a4d4af-a64d-11e8-b258-0800279cc012','SIR-WATER','SIROPE DE SANDÍA','#fff4f4','#b3617a','WMEL','BOTELLA DE SIROPE DE SANDÍA 750 ML',0,0.00000,0.00000,0.00000,1),('5dd13d02-a64c-11e8-b258-0800279cc012','SIR-FRESH','SIROPE DE LIMA FRESCA','#0d0c0c','#17ed46','FRSH','BOTELLA DE SIROPE DE LIMA FRESCA 750 ML',0,0.00000,0.00000,0.00000,1),('5e7d3cd0-a62e-11e8-b258-0800279cc012','AC-RACK-DLX','EXHIBIDOR PARA BOTELLAS','','','RACK','RACK PLÁSTICO EXHIBIDOR DE LUJO PARA BOTELLAS (PARA 12 UNIDADES)',4,244966.00000,61241.50000,0.00000,0),('62b8fea9-a58e-11e8-b258-0800279cc012','CL-TM-BL-ME','CAMISETA CUELLO AZUL M','','','CAZM','CAMISETA PARA HOMBRE, CUELLO AZUL, TALLA M',2,13414.80000,6707.40000,0.00000,0),('67b239ae-a58b-11e8-b258-0800279cc012','AC-QTSQUEEZE','BOTELLA MEZCLADORA','','','B-ME','BOTELLA MEZCLADORA PARA TOPPINGS',6,7655.16000,1275.86000,0.00000,0),('6c395541-a64c-11e8-b258-0800279cc012','SIR-GRAPE','SIROPE DE UVA','#f7eaea','#6d2d94','GRAP','BOTELLA DE SIROPE DE UVA 750 ML',0,0.00000,0.00000,0.00000,1),('6d4eaa4e-a64d-11e8-b258-0800279cc012','SIR-GUAVA','SIROPE DE GUAYABA','#0a0a0a','#f79955','GUAV','BOTELLA DE SIROPE DE GUAYABA 750 ML',0,0.00000,0.00000,0.00000,1),('76638b19-a58d-11e8-b258-0800279cc012','AP-BANNER17-TS','BANDERA TROPICAL SNO','','','FLAG','BANDERA TROPICAL SNO 2017',2,69990.30000,34995.15000,0.00000,0),('779381ea-a58a-11e8-b258-0800279cc012','AC-QSPOUTS','TAPAS VERTEDORAS (AZULES)','','','T-AZU','TAPAS VERTEDORAS DE LIQUIDO (AZULES)',30,7655.10000,255.17000,0.00000,0),('79605c96-a58e-11e8-b258-0800279cc012','CL-TM-BL-SM','CAMISETA CUELLO AZUL S','','','CAZS','CAMISETA PARA HOMBRE, CUELLO AZUL, TALLA S',2,13414.80000,6707.40000,0.00000,0),('7b1ead74-a64d-11e8-b258-0800279cc012','SIR-PASSI','SIROPE DE MARACUYÁ','#0a0a0a','#e0d8ac','PASS','BOTELLA DE SIROPE DE MARACUYÁ 750 ML',0,0.00000,0.00000,0.00000,1),('7b6a94ac-a64c-11e8-b258-0800279cc012','SIR-GREEN','SIROPE DE MANZANA VERDE','#0a0a0a','#77fa74','GREE','BOTELLA DE SIROPE DE MANZANA VERDE 750 ML',0,0.00000,0.00000,0.00000,1),('8950fd32-b5ce-11e8-8061-0800279cc012','TOP-VANIL','TOPPING DE CREMA DE VAINILLA','#000000','#f0f799','TVAN','BOTELLA DE TOPPING DE VAINILLA (950 MILILITROS)',0,0.00000,0.00000,0.00000,2),('89cd9b84-a64c-11e8-b258-0800279cc012','SIR-LEMON','SIROPE DE LIMÓN','#080707','#21a61f','LEMO','BOTELLA DE SIROPE DE LIMÓN 750 ML',0,0.00000,0.00000,0.00000,1),('8fc42890-a62e-11e8-b258-0800279cc012','AC-QTCRATE','CAJAS TRASNPORTADORAS','','','CTRA','CAJAS PLÁSTICAS TRANSPORTADORAS DE BOTELLAS (PARA 12 UNIDADES)',10,122483.00000,12248.30000,0.00000,0),('945818b4-a58e-11e8-b258-0800279cc012','CL-TM-HG-LG','CAMISETA GRIS L','','','CGRL','CAMISETA DE HOMBRE, CUELLO GRIS, TALLA L',2,13414.80000,6707.40000,0.00000,0),('97a7dcda-a64c-11e8-b258-0800279cc012','SIR-MANGO','SIROPE DE MANGO','#0d0d0d','#eb9f45','MANG','BOTELLA DE SIROPE DE MANGO 750 ML',0,0.00000,0.00000,0.00000,1),('9bc3c191-a58a-11e8-b258-0800279cc012','AC-QSPOUTCAPS','TAPAS VERTEDORAS (NARANJA)','','','T-NAR','TAPAS  DE PLÁSTICO PARA TAPAR LAS VERTEDORAS DE LIQUIDO (NARANJA)',60,7655.40000,127.59000,0.00000,0),('9c6e039f-a638-11e8-b258-0800279cc012','CP-SPILLS-12','VASO ANTI-DERRAME 12OZ','#000000','#ffffff','AT12','VASOS ANTI-DERRAME, PLÁSTICO AZUL, 12 ONZAS',5990,664470.70000,110.93000,0.00000,0),('a040d8d4-a58d-11e8-b258-0800279cc012','AP-P15-SET-28','PÓSTER GRANDE','','','POSG','PÓSTER GRANDE (28X44 PULGADAS) ',10,29162.60000,2916.26000,0.00000,0),('a074eb83-b5ce-11e8-8061-0800279cc012','TOP-BANA','TOPPING DE CREMA DE BANANO','','#c7c93c','TBAN','BOTELLA DE TOPPING DE BANANO (950 MILILITROS)',0,0.00000,0.00000,0.00000,2),('a17c90c5-a58e-11e8-b258-0800279cc012','CL-TM-HG-ME','CAMISETA GRIS M','','','CGRM','CAMISETA DE HOMBRE, CUELLO GRIS, TALLA M',2,13414.80000,6707.40000,0.00000,0),('a4b0b267-a64c-11e8-b258-0800279cc012','SIR-ORANGE','SIROPE DE NARANJA','#0a0a0a','#fa9601','ORAN','BOTELLA DE SIROPE DE NARANJA 750 ML',0,0.00000,0.00000,0.00000,1),('a7cc750c-a62e-11e8-b258-0800279cc012','CP-CUPTS-08','VASOS DE 8OZ','','','V8OZ','VASOS DE ESTEREOFÓN CON LOGO TROPICAL SNO 8OZ',13997,326410.04000,23.32000,0.00000,0),('b298fd5c-a64b-11e8-b258-0800279cc012','SIR-BANAN','SIROPE DE BANANO','#000000','#eaf5a5','BANA','BOTELLA DE SIROPE DE BANANO 750 ML',4,4454.07120,1113.51780,0.00000,1),('b58ecc55-a58e-11e8-b258-0800279cc012','CL-TM-HG-SM','CAMISETA GRIS S','','','CGRS','CAMISETA DE HOMBRE, CUELLO GRIS, TALLA S ',2,13414.80000,6707.40000,0.00000,0),('b8d5372b-a62e-11e8-b258-0800279cc012','CP-CUPTS-16','VASOS DE 12OZ','','','V12O','VASOS DE ESTEREOFÓN CON LOGO TROPICAL SNO 12OZ',6000,174960.00000,29.16000,0.00000,0),('b948f654-a636-11e8-b258-0800279cc012','CP-SPILLS-08','VASO ANTI-DERRAME 8OZ','#000000','#ffffff','ANT8','VASOS ANTI-DERRAME, PLÁSTICO VERDE, 8 ONZAS',14032,1551518.24000,110.57000,0.00000,0),('be639949-a58d-11e8-b258-0800279cc012','AP-P15-SET-21','PÓSTER PEQUEÑO','','','POSP','PÓSTER PEQUEÑO (21X33 PULGADAS) ',10,29162.60000,2916.26000,0.00000,0),('c585ac10-a64b-11e8-b258-0800279cc012','SIR-BLACK','SIROPE DE CEREZA NEGRA','#f7f4f4','#661111','blak','BOTELLA DE SIROPE DE CEREZA NEGRA 750 ML',0,0.00000,0.00000,0.00000,1),('cb2f62a6-a64c-11e8-b258-0800279cc012','SIR-PEACH','SIROPE DE MELOCOTÓN','#0a0a0a','#ebc285','PECH','BOTELLA DE SIROPE DE MELOCOTÓN 750 ML',0,0.00000,0.00000,0.00000,1),('d8ddbbf4-a64b-11e8-b258-0800279cc012','SIR-BLUEB','SIROPE DE ARÁNDANO','#fffbfb','#23128f','BLUB','BOTELLA DE SIROPE DE ARÁNDANO 750 ML',0,0.00000,0.00000,0.00000,1),('ded11f42-a64c-11e8-b258-0800279cc012','SIR-PINAC','SIROPE DE PIÑA COLADA','#0f0f0f','#e3db90','PINC','BOTELLA DE SIROPE DE PIÑA COLADA 750 ML',0,0.00000,0.00000,0.00000,1),('e4833657-a58e-11e8-b258-0800279cc012','CL-TM-RR-TS-LG','CAMISETA ROYAL L','','','ROYL','CAMISETA PARA HOMBRE, ROYAL RINGER, TROPICAL SNO, TALLA L',2,13414.80000,6707.40000,0.00000,0),('e6539ab5-a58d-11e8-b258-0800279cc012','AP-P-CPO-28','LÁMINA TRANSLÚCIDA GRANDE','','','LAMG','LÁMINA PLÁSTICA TRANSLÚCIDA PROTECTORA PARA PÓSTER GRANDE (28*44 PULGADAS)',4,40827.68000,10206.92000,0.00000,0),('eca0acc2-a64b-11e8-b258-0800279cc012','SIR-BLUEH','SIROPE DE HAWAIANO AZUL','#74f5f5','#3b6ca6','BLUH','BOTELLA DE SIROPE DE HAWAIANO AZUL 750 ML',2,2227.03560,1113.51780,0.00000,1),('ecd762a7-a58c-11e8-b258-0800279cc012','CP-FHGLOVES-M','GUANTES TALLA M','','','GUAM','GUANTES PLÁSTICOS MANIPULADORES DE ALIMENTOS TALLA M',2000,14000.00000,7.00000,0.00000,0),('ef3fcb6a-a64c-11e8-b258-0800279cc012','SIR-PINEA','SIROPE DE PIÑA','#0f0f0f','#e6f074','PINE','BOTELLA DE SIROPE DE PIÑA 750 ML',2,2227.03560,1113.51780,0.00000,1),('f1aeee28-a58e-11e8-b258-0800279cc012','CL-TM-RR-TS-ME','CAMISETA ROYAL M','','','ROYM','CAMISETA PARA HOMBRE, ROYAL RINGER, TROPICAL SNO, TALLA M',2,13414.80000,6707.40000,0.00000,0),('fc0acd5f-a58a-11e8-b258-0800279cc012','AC-MIXJUGS','GALONES MEZCLADORES','','','MEZC','GALONES PLÁSTICOS MEZCLADORES CON SUS TAPAS',40,76552.00000,1913.80000,0.00000,0),('fe1e806b-a58e-11e8-b258-0800279cc012','CL-TM-RR-TS-SM','CAMISETA ROYAL S','','','ROYS','CAMISETA PARA HOMBRE, ROYAL RINGER, TROPICAL SNO, TALLA S',2,13414.80000,6707.40000,0.00000,0);
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
  `valor` decimal(18,5) NOT NULL COMMENT 'Cuanto cuesta ',
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
INSERT INTO `productosXDistribucion` VALUES ('1021733b-c25f-11e8-8d13-0800279cc012','d14e4f26-f176-49e1-9e0a-6343fbcbf445','0cdf88ba-a62f-11e8-b258-0800279cc012',30,0.00000),('1035bb92-c25f-11e8-8d13-0800279cc012','d14e4f26-f176-49e1-9e0a-6343fbcbf445','1c01164d-a62f-11e8-b258-0800279cc012',30,0.00000),('10479ba1-c25f-11e8-8d13-0800279cc012','d14e4f26-f176-49e1-9e0a-6343fbcbf445','779381ea-a58a-11e8-b258-0800279cc012',30,0.00000),('5664ea0e-c325-11e8-8d13-0800279cc012','63cc0b1b-bc55-48da-a179-39578a0d45dc','49acc603-a64d-11e8-b258-0800279cc012',2,0.00000),('b02d90b6-c19a-11e8-8d13-0800279cc012','3adc5a92-9937-425b-af4e-82118300dced','eca0acc2-a64b-11e8-b258-0800279cc012',2,0.00000),('b03cd1a2-c19a-11e8-8d13-0800279cc012','3adc5a92-9937-425b-af4e-82118300dced','ef3fcb6a-a64c-11e8-b258-0800279cc012',2,0.00000),('b2d1584d-c1ae-11e8-8d13-0800279cc012','fe45d517-feb4-436a-9767-a338eadc22a2','5510045b-b5ce-11e8-8061-0800279cc012',1,0.00000);
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
  CONSTRAINT `fk_productosXFactura_factura1` FOREIGN KEY (`idFactura`) REFERENCES `factura` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Productos vendidos en una factura (Detalle).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productosXFactura`
--

LOCK TABLES `productosXFactura` WRITE;
/*!40000 ALTER TABLE `productosXFactura` DISABLE KEYS */;
INSERT INTO `productosXFactura` VALUES ('0580f72c-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1','8079b095-91ad-11e8-b0db-0800279cc012',1,1,'12oz',1.000,78,NULL,'12oz, VECH, VECH, NTOP',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('05861466-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1','8079b095-91ad-11e8-b0db-0800279cc012',2,1,'12oz',1.000,78,NULL,'12oz, VECH, VECH, NTOP',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('058db201-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1','8079b095-91ad-11e8-b0db-0800279cc012',3,1,'12oz',1.000,78,NULL,'12oz, VECH, VECH, NTOP',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('0592bb98-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1','8079b095-91ad-11e8-b0db-0800279cc012',4,1,'12oz',1.000,78,NULL,'12oz, VECH, VECH, NTOP',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('0597fb80-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1','8079b095-91ad-11e8-b0db-0800279cc012',5,1,'12oz',1.000,78,NULL,'12oz, VECH, VECH, NTOP',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('059ceb00-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1','8079b095-91ad-11e8-b0db-0800279cc012',6,1,'12oz',1.000,78,NULL,'12oz, VECH, VECH, NTOP',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('05a1f8e1-c326-11e8-8d13-0800279cc012','3f6731fc-4c22-4092-b945-53d774a698a1','8079b095-91ad-11e8-b0db-0800279cc012',7,1,'12oz',1.000,78,NULL,'12oz, VECH, VECH, NTOP',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('06cfe6d4-c25c-11e8-8d13-0800279cc012','f1068a5c-1448-4f93-99cd-d17cbdcd082b','8079b095-91ad-11e8-b0db-0800279cc012',1,1,'12oz',1.000,78,NULL,'12oz, BLUH, BLUH, TCOC',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('1b40123c-c25c-11e8-8d13-0800279cc012','d972ec75-32f1-4e54-9616-b27430166bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',1,1,'08oz',1.000,78,NULL,'08oz, PINE, PINE, TCOC',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('1b4a5a69-c25c-11e8-8d13-0800279cc012','d972ec75-32f1-4e54-9616-b27430166bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',2,1,'08oz',1.000,78,NULL,'08oz, PINE, PINE, TCOC',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('262359d7-c25c-11e8-8d13-0800279cc012','1af65ded-a670-4382-a497-ef31856200dc','8079b095-91ad-11e8-b0db-0800279cc012',1,1,'12oz',1.000,78,NULL,'12oz, BLUH, BLUH, TCOC',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('331c69e2-c25c-11e8-8d13-0800279cc012','8a92406a-cb9d-4d16-b6f4-a1fe0c5e9ba1','8079b095-91ad-11e8-b0db-0800279cc012',1,1,'12oz',1.000,78,NULL,'12oz, BLUH, PINE, NTOP',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('52c428cf-c19b-11e8-8d13-0800279cc012','16469d1d-d36a-47a2-a1ec-e644ff9f49c7','8079b095-91ad-11e8-b0db-0800279cc012',1,1,'12oz',1.000,78,NULL,'Venta de producto 12oz, BLUH, PINE, NTOP',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('57d22dd8-c2b2-11e8-8d13-0800279cc012','7449f37e-4f29-408d-810b-77bc46e32e46','8079b095-91ad-11e8-b0db-0800279cc012',1,1,'12oz',1.000,78,NULL,'12oz, BLUH, PINE, TCOC',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('6a1d70b2-c19b-11e8-8d13-0800279cc012','f0ebcd3b-c417-4e93-9728-2eeb1df6f06a','8a9277b7-91ad-11e8-b0db-0800279cc012',1,1,'08oz',1.000,78,NULL,'Venta de producto 08oz, BLUH, PINE, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('7eb702f2-c2a1-11e8-8d13-0800279cc012','83b642b0-91e2-4fb2-8c73-4d58a333c1d2','8079b095-91ad-11e8-b0db-0800279cc012',1,1,'12oz',1.000,78,NULL,'12oz, PINE, PINE, TCOC',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('813b798a-c1c7-11e8-8d13-0800279cc012','b1e99443-fbd2-4aa3-a3ce-f9717696678c','8079b095-91ad-11e8-b0db-0800279cc012',1,1,'12oz',1.000,78,NULL,'Venta de producto 12oz, PINE, PINE, TCOC',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('8cede166-c1c7-11e8-8d13-0800279cc012','0ac26497-4dfd-4836-8996-49ada654f672','8a9277b7-91ad-11e8-b0db-0800279cc012',1,1,'08oz',1.000,78,NULL,'Venta de producto 08oz, BLUH, BLUH, TCOC',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('9331480b-c726-11e8-8d13-0800279cc012','a0f87372-7bba-489b-a189-dddb8feab4dd','8079b095-91ad-11e8-b0db-0800279cc012',1,1,'12oz',1.000,78,NULL,'12oz, BLUH, VECH, TCOC',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('99c38768-c1c7-11e8-8d13-0800279cc012','f0a4ab8c-bc58-4577-9f0d-0eb56571d94f','8079b095-91ad-11e8-b0db-0800279cc012',1,1,'12oz',1.000,78,NULL,'Venta de producto 12oz, BLUH, PINE, TCOC',2212.38938,2212.38938,0.00000,'No aplican descuentos',2212.38938,'1',13.00,287.61062,NULL,2500.00000),('a635d8aa-c1c7-11e8-8d13-0800279cc012','f66f4433-3e9d-47b9-9a2a-77e9d64f9555','8a9277b7-91ad-11e8-b0db-0800279cc012',1,1,'08oz',1.000,78,NULL,'Venta de producto 08oz, BLUH, PINE, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('dc1c3af0-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',1,1,'08oz',1.000,78,NULL,'08oz, VECH, VECH, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('dc22aae8-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',2,1,'08oz',1.000,78,NULL,'08oz, VECH, VECH, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('dc27be81-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',3,1,'08oz',1.000,78,NULL,'08oz, VECH, VECH, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('dc2cce2f-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',4,1,'08oz',1.000,78,NULL,'08oz, VECH, VECH, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('dc31d49f-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',5,1,'08oz',1.000,78,NULL,'08oz, VECH, VECH, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('dc36f264-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',6,1,'08oz',1.000,78,NULL,'08oz, VECH, VECH, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('dc412030-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',7,1,'08oz',1.000,78,NULL,'08oz, VECH, VECH, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('dc48b3df-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',8,1,'08oz',1.000,78,NULL,'08oz, VECH, VECH, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('dc4dda3b-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',9,1,'08oz',1.000,78,NULL,'08oz, VECH, VECH, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000),('dc52f555-c325-11e8-8d13-0800279cc012','9f3ec02d-6c0c-4425-9e3c-4ad7a4e89bfd','8a9277b7-91ad-11e8-b0db-0800279cc012',10,1,'08oz',1.000,78,NULL,'08oz, VECH, VECH, NTOP',1327.43363,1327.43363,0.00000,'No aplican descuentos',1327.43363,'1',13.00,172.56637,NULL,1500.00000);
/*!40000 ALTER TABLE `productosXFactura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productosXOrdenSalida`
--

DROP TABLE IF EXISTS `productosXOrdenSalida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productosXOrdenSalida` (
  `id` char(36) NOT NULL,
  `idOrdenSalida` char(36) NOT NULL,
  `idProducto` char(36) NOT NULL,
  `cantidad` decimal(10,2) NOT NULL,
  `costo` decimal(18,5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productosXOrdenSalida`
--

LOCK TABLES `productosXOrdenSalida` WRITE;
/*!40000 ALTER TABLE `productosXOrdenSalida` DISABLE KEYS */;
INSERT INTO `productosXOrdenSalida` VALUES ('0ba0adde-8b64-43d7-9189-cd26128427d1','1','eca0acc2-a64b-11e8-b258-0800279cc012',4.00,1113.51780),('1a9deab4-0b5e-48c8-ba8a-6fdc9aa8ea8b','3','5510045b-b5ce-11e8-8061-0800279cc012',1.00,1701.19100),('60518a7d-cfd3-478a-9ef1-9d382a8f7ff7','1','ef3fcb6a-a64c-11e8-b258-0800279cc012',4.00,1113.51780),('b590341e-7762-4b46-bb61-3da3289f2aa2','2','b298fd5c-a64b-11e8-b258-0800279cc012',4.00,1113.51780),('ff1069ef-2b2f-4e79-81c7-54861dbb172c','5','49acc603-a64d-11e8-b258-0800279cc012',4.00,1084.09720);
/*!40000 ALTER TABLE `productosXOrdenSalida` ENABLE KEYS */;
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

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES ('0f8aef81-7400-4a36-93f9-b929d4889d0e','Estándar');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provincia`
--

DROP TABLE IF EXISTS `provincia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provincia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` int(2) DEFAULT NULL,
  `provincia` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provincia`
--

LOCK TABLES `provincia` WRITE;
/*!40000 ALTER TABLE `provincia` DISABLE KEYS */;
INSERT INTO `provincia` VALUES (1,1,'San José'),(2,2,'Alajuela'),(3,3,'Cartago'),(4,4,'Heredia'),(5,5,'Guanacaste'),(6,6,'Puntarenas'),(7,7,'Limón');
/*!40000 ALTER TABLE `provincia` ENABLE KEYS */;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Receptor de facturas de ventas - Clientes';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receptor`
--

LOCK TABLES `receptor` WRITE;
/*!40000 ALTER TABLE `receptor` DISABLE KEYS */;
INSERT INTO `receptor` VALUES ('3636f62d-c29a-4d5f-81fa-479c5c152455','default',1,'000000000','1','default',1,1,1,1,'default','52',NULL,NULL,NULL,'default@default.com');
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
INSERT INTO `rol` VALUES ('0f8aef81-7400-4a36-93f9-b929d4889d0e','admin-seguridad','administra usuarios y conexiones'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','Admin','Administrador del Sistema'),('31221f87-1b60-48d1-a0ce-68457d1298c1','Despacho','Despacho de productos vendidos en sucursales'),('5f9bd173-9369-47d5-a1b8-fe5ab8234c61','Vendedor','Vendedor en Agencia'),('7f9f8011-f9db-4330-b931-552141a089a4','admin-tropical','administrador de sistema Tropical'),('e8d2f620-dd38-4e21-8b7f-7949412f65d6','local-comercial','administrado de local comercial');
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
INSERT INTO `rolesXUsuario` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('31221f87-1b60-48d1-a0ce-68457d1298c1','9d27aedd-992d-475a-a01b-09b1c2aa2714'),('5f9bd173-9369-47d5-a1b8-fe5ab8234c61','1e03b970-2778-43fb-aff6-444043d2bf51'),('5f9bd173-9369-47d5-a1b8-fe5ab8234c61','756f31d0-fdbb-40c5-8fe9-0e1dfbef7db3'),('e8d2f620-dd38-4e21-8b7f-7949412f65d6','291a7a1c-17a4-4062-8a70-3b9db409113a'),('e8d2f620-dd38-4e21-8b7f-7949412f65d6','f874513a-3fc2-4fc7-b48e-46cb96af4901'),('e8d2f620-dd38-4e21-8b7f-7949412f65d6','fd9d2be6-6999-40ce-9954-1462c9ca0ffb');
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
INSERT INTO `tipoCodigo` VALUES (5,'99','Otros'),(1,'01','Código del producto del vendedor'),(2,'02','Código del producto del comprador'),(3,'03','Código del producto asignado por la industria'),(4,'04','Código uso interno');
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
INSERT INTO `usuario` VALUES ('1e03b970-2778-43fb-aff6-444043d2bf51','Olga Arias','vendedor1','$2y$10$TCTT.gMFpX9DuGmd3H47.OtlzFL5xwL0xmnLsqgbJgsUErn3s3pfu','',1),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','administrador de sistema','admin','$2y$10$CwVlbwIWdHbxlQqo3yJHj.zo7BRekPGM.NCIjn02fIc0f7uz9gpua','',1),('291a7a1c-17a4-4062-8a70-3b9db409113a','Viviana Ramirez','viviana','$2y$10$T97UtIZFneCNUS9VkosBr.RvKHhOb/C2LomBHnPBZODQig3JC3Xj.','',1),('756f31d0-fdbb-40c5-8fe9-0e1dfbef7db3','Wayne Rooney','rooney','$2y$10$gskJ/mg9gMZgHu2GPczufO0K01y9YgxRL3i3JgCil1axynETYgo2e','',1),('9d27aedd-992d-475a-a01b-09b1c2aa2714','Despacho San Pedro','despachosp','$2y$10$eOzcp6F611LXGf4a2YcNBu5MiY3lUSda1yqxpS5A2kcPfzu4moTF2','',1),('f874513a-3fc2-4fc7-b48e-46cb96af4901','Prueba Despacho','despacho1','$2y$10$7jCKUBwL7XPSrnXBR1B6oeZJEjfVGshXXGj/IuuiYNarGjIVqFd42','',1),('fd9d2be6-6999-40ce-9954-1462c9ca0ffb','Margarita Gutierrez','bodeguero','$2y$10$WmGBZz2UEYPOYIWefTW4N.Y7M0E2S9zvvN0pbDMvBm6FKv4gn/LqS','',1);
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
  CONSTRAINT `fk_usuariosXBodega_bodega1` FOREIGN KEY (`idBodega`) REFERENCES `bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuariosXBodega_usuario1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuariosXBodega`
--

LOCK TABLES `usuariosXBodega` WRITE;
/*!40000 ALTER TABLE `usuariosXBodega` DISABLE KEYS */;
INSERT INTO `usuariosXBodega` VALUES ('1e03b970-2778-43fb-aff6-444043d2bf51','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','63363882-a840-4517-9786-67f148f6a587'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','72a5afa7-dcba-4539-8257-ed1e18b1ce94'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','d6cd8440-8906-4e4a-9e08-8af36695c5eb'),('291a7a1c-17a4-4062-8a70-3b9db409113a','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('756f31d0-fdbb-40c5-8fe9-0e1dfbef7db3','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('9d27aedd-992d-475a-a01b-09b1c2aa2714','63363882-a840-4517-9786-67f148f6a587'),('f874513a-3fc2-4fc7-b48e-46cb96af4901','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('fd9d2be6-6999-40ce-9954-1462c9ca0ffb','72a5afa7-dcba-4539-8257-ed1e18b1ce94');
/*!40000 ALTER TABLE `usuariosXBodega` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-07 13:33:44

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
-- Table structure for table `bodega`
--
use tropical;

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
INSERT INTO `bodega` VALUES ('63363882-a840-4517-9786-67f148f6a587','22a80c9e-5639-11e8-8242-54ee75873a11','MALL SAN PEDRO','Tropical Sno Mall San Pedro','Mall San Pedro, 2do nivel','Viviana Ramírez','88255767',NULL),('715da8ec-e431-43e3-9dfc-f77e5c64c296','22a80c9e-5639-11e8-8242-54ee75873a11','TRES RÍOS','Tropical Sno Tres Ríos','San Juan, La Unión','Viviana Ramírez','88255767',NULL),('72a5afa7-dcba-4539-8257-ed1e18b1ce94','22a80c9e-5639-11e8-8242-54ee75873a11','Tropical Sno Central','Oficinas Centrales Tropical Sno','Montelimar','Viviana Ramírez','88255767',NULL),('8f5e581d-206e-4fa1-8f85-9e0a28e77eab','22a80c9e-5639-11e8-8242-54ee75873a12','Agencia Plaza Lincoln','Plaza Lincoln','Moravia','Esteban Carballo','56445252',NULL);
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
  `username` varchar(150) NOT NULL,
  `password` varchar(150) NOT NULL,
  `certificado` varchar(150) NOT NULL,
  `idBodega` char(36) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cpath` varchar(150) DEFAULT NULL,
  `nkey` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienteFE`
--

LOCK TABLES `clienteFE` WRITE;
/*!40000 ALTER TABLE `clienteFE` DISABLE KEYS */;
INSERT INTO `clienteFE` VALUES ('1f85f425-1c4b-4212-9d97-72e413cffb3c','91239911',506,'Gustavo Reyes',1,'000','Tropical Sno',1,1,1,1,'Guadalupe',1,'',NULL,NULL,'','','','','','0000-00-00 00:00:00',NULL,NULL);
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
INSERT INTO `detalleOrden` VALUES ('0fc218b9-b2d2-11e8-8061-0800279cc012',1,'a4c106d6-866a-45df-9691-0b1ef140c55a','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('1f2e2346-b2b7-11e8-8061-0800279cc012',1,'26f02e9e-7b94-42f1-ad94-ed0e1de9c34b','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('1f332f67-b2b7-11e8-8061-0800279cc012',1,'26f02e9e-7b94-42f1-ad94-ed0e1de9c34b','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('1f384336-b2b7-11e8-8061-0800279cc012',1,'26f02e9e-7b94-42f1-ad94-ed0e1de9c34b','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('205b1733-b2d3-11e8-8061-0800279cc012',1,'8314c873-5fda-4eb6-9c15-a3c779baace0','fb6b6bdd-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('20c942f5-b2d1-11e8-8061-0800279cc012',1,'941ed927-7db1-4e1c-8cff-9a6d57309062','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('20ce4267-b2d1-11e8-8061-0800279cc012',1,'941ed927-7db1-4e1c-8cff-9a6d57309062','fb6b6bdd-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012',NULL,1),('20d48c15-b2d1-11e8-8061-0800279cc012',0,'941ed927-7db1-4e1c-8cff-9a6d57309062','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('31fd56ab-b2d2-11e8-8061-0800279cc012',1,'f0bf8f9b-c27b-400e-b873-9c69fd85e07f','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('4181c124-b2d1-11e8-8061-0800279cc012',1,'b0d7edab-9c12-4ee3-9302-15dd4c7c3e87','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012',NULL,1),('418bec0a-b2d1-11e8-8061-0800279cc012',0,'b0d7edab-9c12-4ee3-9302-15dd4c7c3e87','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('41924ea7-b2d1-11e8-8061-0800279cc012',0,'b0d7edab-9c12-4ee3-9302-15dd4c7c3e87','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('419761ca-b2d1-11e8-8061-0800279cc012',1,'b0d7edab-9c12-4ee3-9302-15dd4c7c3e87','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('43d866c3-b2d2-11e8-8061-0800279cc012',1,'5e50d70f-f155-4e24-85f1-90d31de7cf87','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('4dc6fd89-b2b8-11e8-8061-0800279cc012',1,'2d1c702f-f55c-476b-9b26-444eb8abef39','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('4dd11e3a-b2b8-11e8-8061-0800279cc012',1,'2d1c702f-f55c-476b-9b26-444eb8abef39','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('4dd78974-b2b8-11e8-8061-0800279cc012',1,'2d1c702f-f55c-476b-9b26-444eb8abef39','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('507abd5d-b2d3-11e8-8061-0800279cc012',1,'64154c35-c5d6-4945-bc0e-a277d8c081ea','fb6b6bdd-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('541948a0-b2b9-11e8-8061-0800279cc012',1,'8437e99f-212c-42c8-b916-bffcf0eb1c09','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('541e6bdb-b2b9-11e8-8061-0800279cc012',1,'8437e99f-212c-42c8-b916-bffcf0eb1c09','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('54237602-b2b9-11e8-8061-0800279cc012',1,'8437e99f-212c-42c8-b916-bffcf0eb1c09','fb6b6bdd-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('542da033-b2b9-11e8-8061-0800279cc012',1,'8437e99f-212c-42c8-b916-bffcf0eb1c09','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('5f7fa108-b2c0-11e8-8061-0800279cc012',1,'d359d7b0-1f72-4c59-93a8-dc8e95863607','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('66dded7a-b2ba-11e8-8061-0800279cc012',1,'616995c6-99b6-477b-b5cb-c4e848e28811','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('66e43bb0-b2ba-11e8-8061-0800279cc012',1,'616995c6-99b6-477b-b5cb-c4e848e28811','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('66e963c9-b2ba-11e8-8061-0800279cc012',1,'616995c6-99b6-477b-b5cb-c4e848e28811','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('66ee69fa-b2ba-11e8-8061-0800279cc012',1,'616995c6-99b6-477b-b5cb-c4e848e28811','fb6b6bdd-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('66f37a52-b2ba-11e8-8061-0800279cc012',1,'616995c6-99b6-477b-b5cb-c4e848e28811','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('66f89ccb-b2ba-11e8-8061-0800279cc012',1,'616995c6-99b6-477b-b5cb-c4e848e28811','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('79571902-b2d4-11e8-8061-0800279cc012',1,'5389bc11-356c-437b-99e1-d284f93adb0b','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('8833358f-b2b6-11e8-8061-0800279cc012',1,'639b1713-71e9-4865-91e2-11481823406a','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('88385618-b2b6-11e8-8061-0800279cc012',0,'639b1713-71e9-4865-91e2-11481823406a','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('883d4a25-b2b6-11e8-8061-0800279cc012',0,'639b1713-71e9-4865-91e2-11481823406a','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('88425b3b-b2b6-11e8-8061-0800279cc012',0,'639b1713-71e9-4865-91e2-11481823406a','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('88477b25-b2b6-11e8-8061-0800279cc012',0,'639b1713-71e9-4865-91e2-11481823406a','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('a15fefef-b2b7-11e8-8061-0800279cc012',1,'7aa10a7c-a051-4bd0-bd1a-91365bf52e83','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('a948ef76-b2d4-11e8-8061-0800279cc012',1,'ddd8332a-9a4d-4347-8129-be1adecb7d17','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('aeec77b3-b2bf-11e8-8061-0800279cc012',1,'9613d3c2-c885-437a-a56a-b367221422ea','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('c02c2ec7-b2d3-11e8-8061-0800279cc012',1,'c6fb6213-d5c7-4dfb-8dea-cc4e911d4f6d','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('c09c8b0a-b2d2-11e8-8061-0800279cc012',1,'d451c605-3100-4bf4-a1da-6afdf6578b12','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('cbfc998c-b2b6-11e8-8061-0800279cc012',1,'2eb392f9-cf1f-4f7f-bf55-7315e759005d','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('cc01b19e-b2b6-11e8-8061-0800279cc012',1,'2eb392f9-cf1f-4f7f-bf55-7315e759005d','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('cc06cc8f-b2b6-11e8-8061-0800279cc012',1,'2eb392f9-cf1f-4f7f-bf55-7315e759005d','fb6b6bdd-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('cc0bdeae-b2b6-11e8-8061-0800279cc012',1,'2eb392f9-cf1f-4f7f-bf55-7315e759005d','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('cc10e001-b2b6-11e8-8061-0800279cc012',1,'2eb392f9-cf1f-4f7f-bf55-7315e759005d','fb6b6bdd-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('cc15f517-b2b6-11e8-8061-0800279cc012',1,'2eb392f9-cf1f-4f7f-bf55-7315e759005d','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('d22c6d3a-b2d2-11e8-8061-0800279cc012',1,'de6b9abf-e05a-44e9-84f8-6d92dd069bc1','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('dac3334b-b2d1-11e8-8061-0800279cc012',1,'436501fc-5938-4ea4-bc7f-576379ce04ef','fb6b6bdd-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('e0bb2ba2-b2b7-11e8-8061-0800279cc012',1,'088e2e44-1076-423b-8aee-516bce5817c7','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('f0d436d3-b2d2-11e8-8061-0800279cc012',1,'ea3a9e40-cbb2-4ff4-b254-268b4834c424','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('f0da9a59-b2d2-11e8-8061-0800279cc012',1,'ea3a9e40-cbb2-4ff4-b254-268b4834c424','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('f0e0e85c-b2d2-11e8-8061-0800279cc012',1,'ea3a9e40-cbb2-4ff4-b254-268b4834c424','fb6b6bdd-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('f0e603f7-b2d2-11e8-8061-0800279cc012',1,'ea3a9e40-cbb2-4ff4-b254-268b4834c424','fb6b6bdd-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('f0eb1b87-b2d2-11e8-8061-0800279cc012',0,'ea3a9e40-cbb2-4ff4-b254-268b4834c424','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('fa7b65dc-b2b9-11e8-8061-0800279cc012',1,'97b9d5a0-12fe-4fa0-b402-6c4214a9838d','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('fa805c4b-b2b9-11e8-8061-0800279cc012',1,'97b9d5a0-12fe-4fa0-b402-6c4214a9838d','c0005f3e-b2b3-11e8-8061-0800279cc012','c0005f3e-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('fa857ac7-b2b9-11e8-8061-0800279cc012',1,'97b9d5a0-12fe-4fa0-b402-6c4214a9838d','fb6b6bdd-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1),('fa8a8a45-b2b9-11e8-8061-0800279cc012',1,'97b9d5a0-12fe-4fa0-b402-6c4214a9838d','c0005f3e-b2b3-11e8-8061-0800279cc012','fb6b6bdd-b2b3-11e8-8061-0800279cc012','6906188e-b2b6-11e8-8061-0800279cc012',1);
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
INSERT INTO `distribucion` VALUES ('094dfea1-91d4-429d-b724-a95ff543188d','2018-09-07 15:37:52',2,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','715da8ec-e431-43e3-9dfc-f77e5c64c296',0.00,13.00,'1','2018-09-07 15:37:52'),('504def28-3f12-4f9d-adff-ec4992eb801e','2018-09-07 15:55:15',4,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','715da8ec-e431-43e3-9dfc-f77e5c64c296',0.00,13.00,'1','2018-09-07 15:55:15'),('a3282b47-f01b-4b66-b6f1-48d467ebc4ab','2018-09-07 15:41:41',3,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','715da8ec-e431-43e3-9dfc-f77e5c64c296',0.00,13.00,'1','2018-09-07 15:41:41'),('d987b01d-b9e9-4ed7-9284-f47cd856bef2','2018-09-07 15:36:12',1,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','715da8ec-e431-43e3-9dfc-f77e5c64c296',0.00,13.00,'1','2018-09-07 15:36:12');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`tropicalusr`@`%`*/ /*!50003 TRIGGER `tropical`.`distribucion_BEFORE_INSERT` BEFORE INSERT ON `distribucion` FOR EACH ROW
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
INSERT INTO `estado` VALUES ('0','EN PROCESO'),('1','LIQUIDADO');
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
INSERT INTO `evento` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','Dashboard','Dashboard.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','Nuevo Producto Terminado','Producto.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','Inventario de Producto Terminado','InventarioProducto.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','Facturacion Agencia','FacturaCli.html','Facturacion',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','Lista de Facturas','InventarioFactura.html','Facturacion',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','Nuevo Usuario','Usuario.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','Lista de Usuarios','InventarioUsuario.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','Nuevo Rol','Rol.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','Lista de Roles','InventarioRol.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','Nueva Materia Prima','Insumo.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','Inventario de Materia Prima','InventarioInsumo.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','Elaborar Producto Terminado','ElaborarProducto.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','Nueva Agencia','Bodega.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','Lista de Agencias','InventarioBodega.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','Traslados y Facturacion','Distribucion.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','Entradas de Insumos','OrdenCompra.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','Orden de Produccion','OrdenSalida.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','Inventario Orden de Produccion','InventarioOrdenSalida.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','Ingreso Bodega de Agencia','AceptarDistribucion.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','Agregar Ip','ip.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','Lista de IP','InventarioIp.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','Determinacion de Precios Tropical Sno','DeterminacionPrecio.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','Determinacion de Precios Agencia','DeterminacionPrecioVenta.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','Inventario por Agencia','InsumosBodega.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','Despacho','Fabricar.html','Facturacion',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a96','Ver Traslados y Facturación','InventarioDistribucion.html','Agencia',NULL,NULL);
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
INSERT INTO `eventosXRol` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','5f9bd173-9369-47d5-a1b8-fe5ab8234c61'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','5f9bd173-9369-47d5-a1b8-fe5ab8234c61'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','31221f87-1b60-48d1-a0ce-68457d1298c1'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a96','1ed3a48c-3e44-11e8-9ddb-54ee75873a80');
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
  `idUsuario` char(36) NOT NULL,
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
INSERT INTO `factura` VALUES ('088e2e44-1076-423b-8aee-516bce5817c7','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 16:05:45',5,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('26f02e9e-7b94-42f1-ad94-ed0e1de9c34b','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 16:00:20',3,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,7500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('2d1c702f-f55c-476b-9b26-444eb8abef39','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 16:08:47',6,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,7500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('2eb392f9-cf1f-4f7f-bf55-7315e759005d','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 15:58:00',2,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,15000.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('436501fc-5938-4ea4-bc7f-576379ce04ef','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:11:42',14,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('5389bc11-356c-437b-99e1-d284f93adb0b','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:30:27',24,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('5e50d70f-f155-4e24-85f1-90d31de7cf87','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:14:38',17,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('616995c6-99b6-477b-b5cb-c4e848e28811','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 16:23:48',9,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,15000.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('639b1713-71e9-4865-91e2-11481823406a','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 15:56:06',1,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,8500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('64154c35-c5d6-4945-bc0e-a277d8c081ea','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:22:09',22,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('7aa10a7c-a051-4bd0-bd1a-91365bf52e83','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 16:03:58',4,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('8314c873-5fda-4eb6-9c15-a3c779baace0','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:20:48',21,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('8437e99f-212c-42c8-b916-bffcf0eb1c09','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 16:16:07',7,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,10000.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('941ed927-7db1-4e1c-8cff-9a6d57309062','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:06:29',12,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,6500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('9613d3c2-c885-437a-a56a-b367221422ea','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 17:01:37',10,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('97b9d5a0-12fe-4fa0-b402-6c4214a9838d','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 16:20:46',8,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,10000.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('a4c106d6-866a-45df-9691-0b1ef140c55a','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:13:11',15,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('b0d7edab-9c12-4ee3-9302-15dd4c7c3e87','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:07:24',13,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,8000.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('c6fb6213-d5c7-4dfb-8dea-cc4e911d4f6d','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:25:16',23,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('d359d7b0-1f72-4c59-93a8-dc8e95863607','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 17:06:33',11,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('d451c605-3100-4bf4-a1da-6afdf6578b12','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:18:07',18,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('ddd8332a-9a4d-4347-8129-be1adecb7d17','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:31:47',25,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('de6b9abf-e05a-44e9-84f8-6d92dd069bc1','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:18:37',19,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('ea3a9e40-cbb2-4ff4-b254-268b4834c424','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:19:28',20,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,11500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('f0bf8f9b-c27b-400e-b873-9c69fd85e07f','715da8ec-e431-43e3-9dfc-f77e5c64c296','2018-09-07 19:14:08',16,'001','00001',1,1,'1',NULL,1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'Fri de September 2018',NULL,2500.00000,0.00000,0.00000,0.00000,0.00000,NULL,'1f85f425-1c4b-4212-9d97-72e413cffb3c','1ed3a48c-3e44-11e8-9ddb-54ee75873a60');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`tropicalusr`@`%`*/ /*!50003 TRIGGER `tropical`.`factura_BEFORE_INSERT` BEFORE INSERT ON `factura` FOR EACH ROW
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
INSERT INTO `insumo` VALUES ('05790041-a564-11e8-b258-0800279cc012','TS-GL-PEACH','SABORIZANTE DE MELOCOTÓN','SABORIZANTE DE MELOCOTÓN (SOBRE DE 66 GRS.)',30,87487.80000,2916.26000),('13ab320e-a564-11e8-b258-0800279cc012','TS-GL-PINAC','SABORIZANTE DE PIÑA COLADA','SABORIZANTE DE PIÑA COLADA (SOBRE DE 66 GRS.)',50,145813.00000,2916.26000),('13ca1534-a563-11e8-b258-0800279cc012','TS-GL-BLUEH','SABORIZANTE DE HAWAIANO AZUL','SABORIZANTE DE HAWAIANO AZUL (SOBRE DE 66 GRS.)',19,55408.94000,2916.26000),('1f4a1e68-a564-11e8-b258-0800279cc012','TS-GL-PINEA','SABORIZANTE DE PIÑA','SABORIZANTE DE PIÑA (SOBRE DE 66 GRS.)x',10,29162.60000,2916.26000),('1f4dd79e-b219-11e8-8061-0800279cc012','TA-CR-NANAN','TOPPING DE CREMA DE BANANO','TOPPING DE CREMA DE BANANO (1 PAQUETE DE 1/4 DE GALÓN)',0,0.00000,0.00000),('23065829-a563-11e8-b258-0800279cc012','TS-GL-BLUER','SABORIZANTE DE FRAMBUESA AZUL','SABORIZANTE DE FRAMBUESA AZUL (SOBRE DE 66 GRS.)',35,102069.10000,2916.26000),('288df5d9-a562-11e8-b258-0800279cc012','TS-GL-BANAN','SABORIZANTE DE BANANO','SABORIZANTE DE BANANO (SOBRE DE 66 GRS.)',24,69990.24000,2916.26000),('3207f1c7-a563-11e8-b258-0800279cc012','TS-GL-BUBBL','SABORIZANTE DE CHICLE','SABORIZANTE DE CHICLE (SOBRE DE 66 GRS.)',40,116650.40000,2916.26000),('3cfa35a7-a562-11e8-b258-0800279cc012','TS-GL-BLACK','SABORIZANTE DE CEREZA NEGRA','SABORIZANTE DE CEREZA NEGRA (SOBRE DE 66 GRS.)',5,14581.30000,2916.26000),('3ecf3d23-a564-11e8-b258-0800279cc012','TS-GL-REDRA','SABORIZANTE DE FRAMBUESA ROJA','SABORIZANTE DE FRAMBUESA ROJA (SOBRE DE 66 GRS.)',10,29162.60000,2916.26000),('3f1c9bfd-a563-11e8-b258-0800279cc012','TS-GL-COCON','SABORIZANTE DE COCO','SABORIZANTE DE COCO (SOBRE DE 66 GRS.)',35,102069.10000,2916.26000),('49729c89-aa05-11e8-b258-0800279cc012','SUGAR','AZÚCAR POR KILO','AZÚCAR MOLIDA PARA LA ELABORACIÓN DEL SIROPE',80,47200.00000,590.00000),('49c61303-a563-11e8-b258-0800279cc012','TS-GL-COLA','SABORIZANTE DE COLA','SABORIZANTE DE COLA (SOBRE DE 66 GRS.)',10,29162.60000,2916.26000),('4ae37adc-a564-11e8-b258-0800279cc012','TS-GL-ROOTB','SABORIZANTE DE ZARZA','SABORIZANTE DE ZARZA (SOBRE DE 66 GRS.)',5,14581.30000,2916.26000),('579da3be-a564-11e8-b258-0800279cc012','TS-GL-STRAW','SABORIZANTE DE FRESA','SABORIZANTE DE FRESA (SOBRE DE 66 GRS.)',49,142896.74000,2916.26000),('60901a78-a563-11e8-b258-0800279cc012','TS-GL-COTTO','SABORIZANTE DE ALGODÓN DE AZÚCAR','SABORIZANTE DE ALGODÓN DE AZÚCAR (SOBRE DE 66 GRS.)',25,72906.50000,2916.26000),('68de4c79-a564-11e8-b258-0800279cc012','TS-GL-VANIL','SABORIZANTE DE VAINILLA','SABORIZANTE DE VAINILLA (SOBRE DE 66 GRS.)',20,58325.20000,2916.26000),('69c3ca7d-a562-11e8-b258-0800279cc012','TS-GL-BLUEB','SABORIZANTE DE ARANDANO','SABORIZANTE DE ARANDANO (SOBRE DE 66 GRS.)',10,29162.60000,2916.26000),('7115e5f0-a563-11e8-b258-0800279cc012','TS-GL-FRESH','SABORIZANTE DE LIMA FRESCA','SABORIZANTE DE LIMA FRESCA (SOBRE DE 66 GRS.)',25,72906.50000,2916.26000),('77dd8384-a564-11e8-b258-0800279cc012','TS-GL-VERCH','SABORIZANTE DE MUY CEREZA','SABORIZANTE DE MUY CEREZA (SOBRE DE 66 GRS.)',10,29162.60000,2916.26000),('7f6b7136-aa08-11e8-b258-0800279cc012','AGUA','AGUA','2.6 LITROS DE AGUA PARA FABRICAR 4 BOTELLAS DE SIROPE',0,0.00000,0.00000),('80378f7b-a563-11e8-b258-0800279cc012','TS-GL-GRAPE','SABORIZANTE DE UVA','SABORIZANTE DE UVA (SOBRE DE 66 GRS.)',30,87487.80000,2916.26000),('88d146c4-a564-11e8-b258-0800279cc012','TS-GL-WATER','SABORIZANTE DE SANDIA','SABORIZANTE DE SANDIA (SOBRE DE 66 GRS.)',35,102069.10000,2916.26000),('95758034-a564-11e8-b258-0800279cc012','TS-GL-GUAVA','SABORIZANTE DE GUAYABA','SABORIZANTE DE GUAYABA (SOBRE DE 45 GRS.)',20,14581.40000,729.07000),('a91d532b-a564-11e8-b258-0800279cc012','TS-GL-PASSI','SABORIZANTE DE MARACUYÁ','SABORIZANTE DE MARACUYÁ (SOBRE DE 45 GRS.)',20,14581.40000,729.07000),('af2720df-a563-11e8-b258-0800279cc012','TS-GL-GREEN','SABORIZANTE DE MANZANA VERDE','SABORIZANTE DE MANZANA VERDE (SOBRE DE 66 GRS.)',20,58325.20000,2916.26000),('bbab150a-a563-11e8-b258-0800279cc012','TS-GL-LEMON','SABORIZANTE DE LIMÓN','SABORIZANTE DE LIMÓN (SOBRE DE 66 GRS.)',25,72906.50000,2916.26000),('c575b337-a563-11e8-b258-0800279cc012','TS-GL-MANGO','SABORIZANTE DE MANGO','SABORIZANTE DE MANGO (SOBRE DE 66 GRS.)',40,116650.40000,2916.26000),('c6bc9c49-a564-11e8-b258-0800279cc012','TA-CR-COCON','TOPPING DE CREMA DE COCO','TOPPING DE CREMA DE COCO (1 PAQUETE 1/4 DE GALÓN)',50,0.00000,0.00000),('e71632e9-a564-11e8-b258-0800279cc012','TA-CR-VANIL','TOPPING DE CREMA DE VAINILLA','TOPPING DE CREMA DE VAINILLA (1 PAQUETE DE 1/4 DE GALÓN)',0,0.00000,0.00000),('f698abac-a563-11e8-b258-0800279cc012','TS-GL-ORANG','SABORIZANTE DE NARANJA','SABORIZANTE DE NARANJA (SOBRE DE 66 GRS.)',20,58325.20000,2916.26000);
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
INSERT INTO `insumosXBodega` VALUES ('6906188e-b2b6-11e8-8061-0800279cc012','e6a2c172-b2b5-11e8-8061-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296',944,0.00000,0.00000),('8415fb75-b2b4-11e8-8061-0800279cc012','67b239ae-a58b-11e8-b258-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296',6,0.00000,0.00000),('c0005f3e-b2b3-11e8-8061-0800279cc012','b298fd5c-a64b-11e8-b258-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296',138,0.00000,0.00000),('fb6b6bdd-b2b3-11e8-8061-0800279cc012','c585ac10-a64b-11e8-b258-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296',46,0.00000,0.00000);
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
INSERT INTO `insumosXOrdenCompra` VALUES ('00e54fb5-b212-11e8-8061-0800279cc012','7c1d7adc-e080-4e8d-b164-461723034c44','69c3ca7d-a562-11e8-b258-0800279cc012',2916.26000,40,0,116650.40000,0.00000),('0dfa1a6d-b21d-11e8-8061-0800279cc012','cc68088f-04d2-48ee-a639-fd78ef62caeb','417029a9-a58d-11e8-b258-0800279cc012',46660.19000,2,0,93320.38000,0.00000),('118b5a16-b212-11e8-8061-0800279cc012','038387ca-2ce4-4b85-9a1d-7059899c98d3','3207f1c7-a563-11e8-b258-0800279cc012',2916.26000,40,0,116650.40000,0.00000),('17f723c0-b21d-11e8-8061-0800279cc012','825cb4da-2faa-475f-883f-69a2c50f02b7','3150ac55-a62f-11e8-b258-0800279cc012',113734.22000,1,0,113734.22000,0.00000),('1d26460e-b214-11e8-8061-0800279cc012','81022101-8a72-4b49-a0fb-2e0f44221e04','f698abac-a563-11e8-b258-0800279cc012',2916.26000,20,0,58325.20000,0.00000),('22e5b1aa-b21d-11e8-8061-0800279cc012','0d79dd94-bed9-4948-a24e-8d30f115bea5','76638b19-a58d-11e8-b258-0800279cc012',34995.15000,2,0,69990.30000,0.00000),('250de9db-b21c-11e8-8061-0800279cc012','72485202-cf69-44d7-aac9-5e33e00e8e40','5e7d3cd0-a62e-11e8-b258-0800279cc012',61241.50000,4,0,244966.00000,0.00000),('282288a1-b214-11e8-8061-0800279cc012','e853ba53-9b6a-4f60-a554-1e8af254d2b6','05790041-a564-11e8-b258-0800279cc012',2916.26000,30,0,87487.80000,0.00000),('2e74be42-b2b6-11e8-8061-0800279cc012','66bd0ebf-1e2a-4b1f-be6d-3f879d20101e','c6bc9c49-a564-11e8-b258-0800279cc012',0.00000,100,0,0.00000,0.00000),('316b70aa-b21d-11e8-8061-0800279cc012','a80696f4-86b7-44cb-b301-c364f1a9c438','a040d8d4-a58d-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('34a1c424-b214-11e8-8061-0800279cc012','61a0d3bd-5304-49df-9ba2-0e53e1ab5eac','13ab320e-a564-11e8-b258-0800279cc012',2916.26000,50,0,145813.00000,0.00000),('3797220e-b21c-11e8-8061-0800279cc012','75a314d2-4dbf-4781-842a-4b425d49581e','8fc42890-a62e-11e8-b258-0800279cc012',12248.30000,10,0,122483.00000,0.00000),('39527e5d-b21d-11e8-8061-0800279cc012','e7e21c85-d951-4c93-918b-28084d7647b2','be639949-a58d-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('3b44e1b4-b212-11e8-8061-0800279cc012','2c7bc839-29ff-40e6-a07e-596204222a3a','3f1c9bfd-a563-11e8-b258-0800279cc012',2916.26000,35,0,102069.10000,0.00000),('3d939b14-b214-11e8-8061-0800279cc012','a668fe54-3cca-4684-a050-9619e926fd8f','1f4a1e68-a564-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('42e2925c-b21c-11e8-8061-0800279cc012','7331a4f8-7977-440f-b484-7ccd8d20bb1d','fc0acd5f-a58a-11e8-b258-0800279cc012',1913.80000,40,0,76552.00000,0.00000),('444c7364-b21d-11e8-8061-0800279cc012','cf40b6e9-16a7-4370-8f69-516e5a9c65b8','e6539ab5-a58d-11e8-b258-0800279cc012',10206.92000,4,0,40827.68000,0.00000),('4839c069-b214-11e8-8061-0800279cc012','5b17f57e-5cb9-49da-8053-b7a960211123','3ecf3d23-a564-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('4d426f78-b219-11e8-8061-0800279cc012','f66eec6f-838f-41e7-840d-ede41e0cbc6f','07903351-a62e-11e8-b258-0800279cc012',1018140.01000,3,0,3054420.03000,0.00000),('51f1da11-b21c-11e8-8061-0800279cc012','80237d63-092c-4e2f-85eb-ccba077ed83f','0da5e444-a62a-11e8-b258-0800279cc012',1488.51000,144,0,214345.44000,0.00000),('5292d066-b21d-11e8-8061-0800279cc012','cff2949c-2e0c-48be-bf10-10129154aea7','0d36c8db-a58e-11e8-b258-0800279cc012',7873.91000,2,0,15747.82000,0.00000),('557c2294-b212-11e8-8061-0800279cc012','19a01974-2e72-478c-816a-7705c65c1521','49c61303-a563-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('59e8c764-b213-11e8-8061-0800279cc012','a9867341-ce6c-4b37-a59e-7ec5bb8b4631','60901a78-a563-11e8-b258-0800279cc012',2916.26000,25,0,72906.50000,0.00000),('5c9b92ed-b21c-11e8-8061-0800279cc012','5b5e1483-cf79-4aaa-bcbb-8291c8a524da','409bd3ad-a58b-11e8-b258-0800279cc012',22965.56000,1,0,22965.56000,0.00000),('5d67d245-b21d-11e8-8061-0800279cc012','7c9f1ab2-99cc-45a9-b260-f5b0427cd826','1ffe07bf-a58e-11e8-b258-0800279cc012',7348.98000,8,0,58791.84000,0.00000),('624a4911-b218-11e8-8061-0800279cc012','346ca9e0-eb8b-4f40-9e6b-0be35402790f','68de4c79-a564-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('67fff1e9-b21d-11e8-8061-0800279cc012','0e699ccd-9629-4210-bd0f-2123282df94e','318efd1b-a58e-11e8-b258-0800279cc012',5832.52000,8,0,46660.16000,0.00000),('68a9803a-b21c-11e8-8061-0800279cc012','c85d0301-99ad-478c-9104-552d388d1745','4eea04f4-a58b-11e8-b258-0800279cc012',6124.15000,2,0,12248.30000,0.00000),('6f120132-b218-11e8-8061-0800279cc012','7e2ae092-a58f-4cf1-8e8f-77974672e0f4','77dd8384-a564-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('727fe3c9-b21d-11e8-8061-0800279cc012','8b275864-8416-4916-be0e-67025ee69b59','4c65ebb3-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('75e83565-b213-11e8-8061-0800279cc012','13bb6d52-08e7-4e81-b03a-ea902f4e9097','7115e5f0-a563-11e8-b258-0800279cc012',2916.26000,25,0,72906.50000,0.00000),('7864690b-b21c-11e8-8061-0800279cc012','36fe2a2f-62d1-4dbe-8f62-035bfc0f02c6','67b239ae-a58b-11e8-b258-0800279cc012',1275.86000,6,0,7655.16000,0.00000),('7eb7eb60-b21d-11e8-8061-0800279cc012','62343f31-e28b-43ad-9823-ad6d06f851ac','62b8fea9-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('847131fb-b218-11e8-8061-0800279cc012','85ec13ea-2dda-4c37-b918-6c81e66664e6','88d146c4-a564-11e8-b258-0800279cc012',2916.26000,35,0,102069.10000,0.00000),('86f7d151-b21d-11e8-8061-0800279cc012','05ba6975-0265-4fe9-acd4-48cab9b90171','79605c96-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('88599e05-b21c-11e8-8061-0800279cc012','0f48e2ce-d2dd-415c-b898-b775ab570832','a7cc750c-a62e-11e8-b258-0800279cc012',23.32000,13997,8,326410.04000,186.56000),('90af770b-b218-11e8-8061-0800279cc012','0d6d5d4e-38dd-4241-b422-d09effb9ccb0','a91d532b-a564-11e8-b258-0800279cc012',729.07000,20,0,14581.40000,0.00000),('921bac92-b21d-11e8-8061-0800279cc012','9acd274b-9173-4951-adb4-a32636b6b394','945818b4-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('946273c7-b21c-11e8-8061-0800279cc012','f6ad7365-1cbd-4714-9f25-2b5814fc32c4','b8d5372b-a62e-11e8-b258-0800279cc012',29.16000,6000,0,174960.00000,0.00000),('9861bc87-b21d-11e8-8061-0800279cc012','a6dafec0-6b90-4f0f-b6ec-919bf65b50ed','a17c90c5-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('9ee0badc-b21d-11e8-8061-0800279cc012','10837394-e78e-47e9-aca0-186cd8767bb1','b58ecc55-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('a4147485-b21c-11e8-8061-0800279cc012','455dad15-6358-4832-acff-cf553f6c13d4','b948f654-a636-11e8-b258-0800279cc012',110.57000,14032,5,1551518.24000,552.85000),('a6cbeb01-b219-11e8-8061-0800279cc012','dab50c9d-59bb-4e63-b5e7-db2f3387a18e','22ce212a-a62e-11e8-b258-0800279cc012',17862.11000,10,0,178621.10000,0.00000),('a9b40943-b218-11e8-8061-0800279cc012','1bfac502-a64c-445f-8707-09419137dcfd','95758034-a564-11e8-b258-0800279cc012',729.07000,20,0,14581.40000,0.00000),('ad039ae0-b21d-11e8-8061-0800279cc012','d61d4791-dcc4-451a-b9b4-02279094563e','e4833657-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('b086b369-b219-11e8-8061-0800279cc012','d0d7e7eb-0e83-432b-9668-5d12118e0768','2a2a3a5f-a58a-11e8-b258-0800279cc012',22965.00000,3,0,68895.00000,0.00000),('b28fd531-b21d-11e8-8061-0800279cc012','531a2044-5dcb-490d-ba2d-b9d9e987bd3d','f1aeee28-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('b3b85dd9-b21c-11e8-8061-0800279cc012','d60b62b6-11e1-4c4b-9555-4bb049a966b7','9c6e039f-a638-11e8-b258-0800279cc012',110.93000,5990,4,664470.70000,443.72000),('b95087d9-b214-11e8-8061-0800279cc012','d1dcfbf2-0af3-4caa-8d1f-09662e805002','4ae37adc-a564-11e8-b258-0800279cc012',2916.26000,5,0,14581.30000,0.00000),('bbb9e257-b21d-11e8-8061-0800279cc012','4366be2c-6433-402f-a252-be2ecd430e81','fe1e806b-a58e-11e8-b258-0800279cc012',6707.40000,2,0,13414.80000,0.00000),('be202c99-b21c-11e8-8061-0800279cc012','b6c22bd3-af57-4f43-86c5-4251a2f56fc2','0cdf88ba-a62f-11e8-b258-0800279cc012',9.23000,24000,0,221520.00000,0.00000),('be541084-b219-11e8-8061-0800279cc012','4143f4ac-f150-42a4-949c-e6c41248aadd','4393476b-a62e-11e8-b258-0800279cc012',1020.69000,168,0,171475.92000,0.00000),('c1165999-b211-11e8-8061-0800279cc012','f0c4d17a-b94f-433d-8a47-6dd1806098ce','288df5d9-a562-11e8-b258-0800279cc012',2916.26000,34,1,99152.84000,2916.26000),('c4ddfb96-b214-11e8-8061-0800279cc012','f723c474-91c4-490d-b14d-f453c755c217','579da3be-a564-11e8-b258-0800279cc012',2916.26000,50,0,145813.00000,0.00000),('cbf3ef5c-b21c-11e8-8061-0800279cc012','48f0ecad-be03-4d88-bc8e-edc510e289c6','ecd762a7-a58c-11e8-b258-0800279cc012',7.00000,2000,0,14000.00000,0.00000),('cdab02bc-b211-11e8-8061-0800279cc012','c716bf55-97d0-47fc-bff9-f4787f7d90c9','3cfa35a7-a562-11e8-b258-0800279cc012',2916.26000,15,0,43743.90000,0.00000),('d06cd80c-b214-11e8-8061-0800279cc012','78b06a77-38a5-4500-8971-1b98a8fedf63','68de4c79-a564-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('d09eff78-b219-11e8-8061-0800279cc012','e844aa26-8227-4146-b0a8-c2c601f9c1d6','779381ea-a58a-11e8-b258-0800279cc012',255.17000,60,0,15310.20000,0.00000),('d49d1186-b213-11e8-8061-0800279cc012','104e7216-9ab4-4d89-89ab-c91863137237','80378f7b-a563-11e8-b258-0800279cc012',2916.26000,30,0,87487.80000,0.00000),('d7dd1a21-b21c-11e8-8061-0800279cc012','798fa154-bcfd-4461-9423-ae75e134457c','0a7ce055-a58d-11e8-b258-0800279cc012',7.00000,2000,0,14000.00000,0.00000),('da5e421c-b211-11e8-8061-0800279cc012','389b088d-34d2-48d2-9f81-1247091a304b','69c3ca7d-a562-11e8-b258-0800279cc012',2916.26000,10,0,29162.60000,0.00000),('df221c54-b213-11e8-8061-0800279cc012','c3fe2f4c-b70c-45ac-95a4-9e7d6fbe2ddf','af2720df-a563-11e8-b258-0800279cc012',2916.26000,20,0,58325.20000,0.00000),('e2e3caaa-b21c-11e8-8061-0800279cc012','c779bb33-b9a9-4511-9f10-2c2e1ab0ef64','1c01164d-a62f-11e8-b258-0800279cc012',26.40000,23848,10,629587.20000,264.00000),('e45390f8-b211-11e8-8061-0800279cc012','6bf0ce08-81d5-44fe-bef2-f9c039046dc7','13ca1534-a563-11e8-b258-0800279cc012',2916.26000,19,1,55408.94000,2916.26000),('e66a4f5c-b219-11e8-8061-0800279cc012','b1b4281b-11fa-4241-88d6-5d7c4361a356','9bc3c191-a58a-11e8-b258-0800279cc012',127.59000,60,0,7655.40000,0.00000),('eb300d10-b213-11e8-8061-0800279cc012','6a23dfb3-de02-48a5-8f6c-587941dcc9d1','bbab150a-a563-11e8-b258-0800279cc012',2916.26000,25,0,72906.50000,0.00000),('f3e4b3ae-b211-11e8-8061-0800279cc012','ca07f024-e209-4260-b8c3-43c1a6c056d4','23065829-a563-11e8-b258-0800279cc012',2916.26000,35,0,102069.10000,0.00000),('f678dd56-b213-11e8-8061-0800279cc012','14eeb88c-2c09-4192-a5d0-ea69d499a810','c575b337-a563-11e8-b258-0800279cc012',2916.26000,40,0,116650.40000,0.00000),('f8c22501-b21c-11e8-8061-0800279cc012','d85fe9ed-c735-4f5e-8d7a-56cc401732df','467a2aa7-a62f-11e8-b258-0800279cc012',55408.98000,2,0,110817.96000,0.00000);
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
INSERT INTO `insumosXOrdenSalida` VALUES ('06c66af6-b2b2-11e8-8061-0800279cc012','519ed508-b941-4fd5-adc2-ca7ca0841d4a','288df5d9-a562-11e8-b258-0800279cc012',10.00,2916.26000),('37839e53-b2b2-11e8-8061-0800279cc012','42e349af-f267-4c92-996e-df5383deca56','3cfa35a7-a562-11e8-b258-0800279cc012',10.00,2916.26000),('3b07f07a-b2b6-11e8-8061-0800279cc012','336005c7-f58b-4b51-9541-69357ac31cd7','c6bc9c49-a564-11e8-b258-0800279cc012',50.00,0.00000);
/*!40000 ALTER TABLE `insumosXOrdenSalida` ENABLE KEYS */;
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
INSERT INTO `ipAutorizada` VALUES ('10.129.29.185','2018-07-27 14:05:48'),('10.129.29.198','2018-07-28 05:20:58'),('10.129.29.217','2018-07-07 16:13:54'),('10.129.29.48','2018-07-16 04:25:49'),('10.129.29.64','2018-07-17 05:47:45'),('10.129.29.85','2018-07-12 20:45:58'),('10.129.6.21','2018-07-25 01:56:20'),('10.129.6.30','2018-09-06 16:01:16'),('10.129.6.48','2018-07-16 04:26:21'),('10.129.6.59','2018-07-12 20:47:01'),('10.129.6.73','2018-07-08 01:10:49'),('10.129.6.85','2018-08-01 22:33:37'),('10.34.164.23','2018-08-16 16:30:00'),('10.34.164.24','2018-07-05 19:50:17'),('10.34.165.15','2018-07-05 20:08:03'),('10.34.165.20','2018-09-04 00:45:36'),('10.42.0.23','2018-08-30 22:41:27'),('168.81.162.245','2018-08-14 15:00:52'),('172.20.10.5','2018-08-04 00:16:02'),('192.168.0.100','2018-07-17 17:18:00'),('192.168.0.101','2018-08-03 23:04:10'),('192.168.0.102','2018-08-15 18:37:12'),('192.168.0.120','2018-08-14 15:02:07'),('192.168.0.121','2018-07-07 00:27:25'),('192.168.0.13','2018-08-21 01:25:47'),('192.168.0.14','2018-07-14 01:50:22'),('192.168.0.20','2018-07-20 16:22:22'),('192.168.0.21','2018-08-03 07:46:05'),('192.168.0.25','2018-08-03 09:37:39'),('192.168.1.100','2018-08-21 16:44:39'),('192.168.1.105','2018-08-16 16:30:00'),('192.168.1.11','2018-08-11 00:15:44'),('192.168.1.123','2018-07-07 00:36:27'),('192.168.1.155','2018-07-07 00:37:20'),('192.168.1.18','2018-07-07 23:28:50'),('192.168.1.5','2018-07-30 02:58:54'),('192.168.1.7','2018-07-07 00:27:25'),('192.168.1.8','2018-07-07 23:28:50'),('192.168.1.81','2018-07-14 18:22:32'),('192.168.10.101','2018-08-16 18:38:17'),('192.168.10.102','2018-08-16 18:38:24'),('192.168.10.20','2018-08-14 15:00:03'),('192.168.10.21','2018-08-14 15:00:13'),('192.168.43.235','2018-07-08 01:10:49'),('192.168.43.4','2018-07-20 21:35:54');
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
INSERT INTO `ordenCompra` VALUES ('038387ca-2ce4-4b85-9a1d-7059899c98d3','2018-09-06 20:18:50','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('05ba6975-0265-4fe9-acd4-48cab9b90171','2018-09-06 21:40:52','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('0d6d5d4e-38dd-4241-b422-d09effb9ccb0','2018-09-06 21:05:21','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('0d79dd94-bed9-4948-a24e-8d30f115bea5','2018-09-06 21:38:04','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('0e699ccd-9629-4210-bd0f-2123282df94e','2018-09-06 21:40:00','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('0f48e2ce-d2dd-415c-b898-b775ab570832','2018-09-06 21:33:45','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('104e7216-9ab4-4d89-89ab-c91863137237','2018-09-06 20:31:27','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('10837394-e78e-47e9-aca0-186cd8767bb1','2018-09-06 21:41:32','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('13bb6d52-08e7-4e81-b03a-ea902f4e9097','2018-09-06 20:28:48','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('14eeb88c-2c09-4192-a5d0-ea69d499a810','2018-09-06 20:32:24','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('19a01974-2e72-478c-816a-7705c65c1521','2018-09-06 20:20:44','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('1bfac502-a64c-445f-8707-09419137dcfd','2018-09-06 21:06:03','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('2c7bc839-29ff-40e6-a07e-596204222a3a','2018-09-06 20:20:00','Proveedor Estándar','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('346ca9e0-eb8b-4f40-9e6b-0be35402790f','2018-09-06 21:04:03','Proveedor Estándar','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('36fe2a2f-62d1-4dbe-8f62-035bfc0f02c6','2018-09-06 21:33:18','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('389b088d-34d2-48d2-9f81-1247091a304b','2018-09-06 20:17:18','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('4143f4ac-f150-42a4-949c-e6c41248aadd','2018-09-06 21:13:47','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('4366be2c-6433-402f-a252-be2ecd430e81','2018-09-06 21:42:20','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('455dad15-6358-4832-acff-cf553f6c13d4','2018-09-06 21:34:31','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('48f0ecad-be03-4d88-bc8e-edc510e289c6','2018-09-06 21:35:38','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('531a2044-5dcb-490d-ba2d-b9d9e987bd3d','2018-09-06 21:42:05','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('5b17f57e-5cb9-49da-8053-b7a960211123','2018-09-06 20:34:41','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('5b5e1483-cf79-4aaa-bcbb-8291c8a524da','2018-09-06 21:32:31','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('61a0d3bd-5304-49df-9ba2-0e53e1ab5eac','2018-09-06 20:34:08','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('62343f31-e28b-43ad-9823-ad6d06f851ac','2018-09-06 21:40:38','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('66bd0ebf-1e2a-4b1f-be6d-3f879d20101e','2018-09-07 15:53:36','Proveedor Estándar','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('6a23dfb3-de02-48a5-8f6c-587941dcc9d1','2018-09-06 20:32:05','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('6bf0ce08-81d5-44fe-bef2-f9c039046dc7','2018-09-06 20:17:34','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('72485202-cf69-44d7-aac9-5e33e00e8e40','2018-09-06 21:30:58','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('7331a4f8-7977-440f-b484-7ccd8d20bb1d','2018-09-06 21:31:48','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('75a314d2-4dbf-4781-842a-4b425d49581e','2018-09-06 21:31:29','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('78b06a77-38a5-4500-8971-1b98a8fedf63','2018-09-06 20:38:30','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('798fa154-bcfd-4461-9423-ae75e134457c','2018-09-06 21:35:58','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('7c1d7adc-e080-4e8d-b164-461723034c44','2018-09-06 20:18:22','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('7c9f1ab2-99cc-45a9-b260-f5b0427cd826','2018-09-06 21:39:42','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('7e2ae092-a58f-4cf1-8e8f-77974672e0f4','2018-09-06 21:04:24','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('80237d63-092c-4e2f-85eb-ccba077ed83f','2018-09-06 21:32:13','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('81022101-8a72-4b49-a0fb-2e0f44221e04','2018-09-06 20:33:29','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('825cb4da-2faa-475f-883f-69a2c50f02b7','2018-09-06 21:37:46','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('85ec13ea-2dda-4c37-b918-6c81e66664e6','2018-09-06 21:05:00','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('8a96286e-6bfe-4d49-98c2-30fe4b901f92','2018-09-06 21:10:48','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('8b275864-8416-4916-be0e-67025ee69b59','2018-09-06 21:40:17','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('9acd274b-9173-4951-adb4-a32636b6b394','2018-09-06 21:41:10','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('a668fe54-3cca-4684-a050-9619e926fd8f','2018-09-06 20:34:23','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('a6dafec0-6b90-4f0f-b6ec-919bf65b50ed','2018-09-06 21:41:21','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('a80696f4-86b7-44cb-b301-c364f1a9c438','2018-09-06 21:38:28','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('a9867341-ce6c-4b37-a59e-7ec5bb8b4631','2018-09-06 20:28:01','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('b1b4281b-11fa-4241-88d6-5d7c4361a356','2018-09-06 21:14:54','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('b6c22bd3-af57-4f43-86c5-4251a2f56fc2','2018-09-06 21:35:15','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('c3fe2f4c-b70c-45ac-95a4-9e7d6fbe2ddf','2018-09-06 20:31:45','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('c716bf55-97d0-47fc-bff9-f4787f7d90c9','2018-09-06 20:16:56','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('c779bb33-b9a9-4511-9f10-2c2e1ab0ef64','2018-09-06 21:36:17','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('c85d0301-99ad-478c-9104-552d388d1745','2018-09-06 21:32:51','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('ca07f024-e209-4260-b8c3-43c1a6c056d4','2018-09-06 20:18:01','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('cc68088f-04d2-48ee-a639-fd78ef62caeb','2018-09-06 21:37:29','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('cf40b6e9-16a7-4370-8f69-516e5a9c65b8','2018-09-06 21:39:00','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('cff2949c-2e0c-48be-bf10-10129154aea7','2018-09-06 21:39:24','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('d0d7e7eb-0e83-432b-9668-5d12118e0768','2018-09-06 21:13:24','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('d1dcfbf2-0af3-4caa-8d1f-09662e805002','2018-09-06 20:37:51','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('d60b62b6-11e1-4c4b-9555-4bb049a966b7','2018-09-06 21:34:57','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('d61d4791-dcc4-451a-b9b4-02279094563e','2018-09-06 21:41:56','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('d85fe9ed-c735-4f5e-8d7a-56cc401732df','2018-09-06 21:36:53','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('dab50c9d-59bb-4e63-b5e7-db2f3387a18e','2018-09-06 21:13:07','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('e7e21c85-d951-4c93-918b-28084d7647b2','2018-09-06 21:38:41','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('e844aa26-8227-4146-b0a8-c2c601f9c1d6','2018-09-06 21:14:17','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('e853ba53-9b6a-4f60-a554-1e8af254d2b6','2018-09-06 20:33:47','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('f0c4d17a-b94f-433d-8a47-6dd1806098ce','2018-09-06 20:16:35','Proveedor Estándar','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('f66eec6f-838f-41e7-840d-ede41e0cbc6f','2018-09-06 21:10:37','Proveedor Estándar','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('f6ad7365-1cbd-4714-9f25-2b5814fc32c4','2018-09-06 21:34:05','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('f723c474-91c4-490d-b14d-f453c755c217','2018-09-06 20:38:10','','','1ed3a48c-3e44-11e8-9ddb-54ee75873a60');
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
INSERT INTO `ordenSalida` VALUES ('336005c7-f58b-4b51-9541-69357ac31cd7','2018-09-07 15:54:27',3,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','f874513a-3fc2-4fc7-b48e-46cb96af4901','2018-09-07 15:54:27','1'),('42e349af-f267-4c92-996e-df5383deca56','2018-09-07 15:27:55',2,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','1e03b970-2778-43fb-aff6-444043d2bf51','2018-09-07 15:27:55','1'),('519ed508-b941-4fd5-adc2-ca7ca0841d4a','2018-09-07 15:27:36',1,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','f874513a-3fc2-4fc7-b48e-46cb96af4901','2018-09-07 15:27:36','1');
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
/*!50003 CREATE*/ /*!50017 DEFINER=`tropicalusr`@`%`*/ /*!50003 TRIGGER `tropical`.`ordensalida_BEFORE_INSERT` BEFORE INSERT ON `ordenSalida` FOR EACH ROW
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
INSERT INTO `preciosXBodega` VALUES ('63363882-a840-4517-9786-67f148f6a580','63363882-a840-4517-9786-67f148f6a587','1',2500.00000),('63363882-a840-4517-9786-67f148f6a581','63363882-a840-4517-9786-67f148f6a587','0',1500.00000),('8079b095-91ad-11e8-b0db-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','1',2500.00000),('88bed187-8a3e-11e8-abed-f2f00eda9788','72a5afa7-dcba-4539-8257-ed1e18b1ce94','1',2500.00000),('88d26ca7-8a3e-11e8-abed-f2f00eda9788','72a5afa7-dcba-4539-8257-ed1e18b1ce94','0',1500.00000),('8a9277b7-91ad-11e8-b0db-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296','0',1500.00000);
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
INSERT INTO `producto` VALUES ('002c4bf1-a64d-11e8-b258-0800279cc012','SIR-REDRA','SIROPE DE FRAMBUESA ROJA','#080708','#e36c9e','RERA','BOTELLA DE SIROPE DE FRAMBUESA ROJA 750 ML',0,0.00000,0.00000,0.00000,1),('03156aa0-a64c-11e8-b258-0800279cc012','SIR-BLUER','SIROPE DE FRAMBUESA AZUL','#fff9f9','#1325c7','BLUR','BOTELLA DE SIROPE DE FRAMBUESA AZUL 750 ML',0,0.00000,0.00000,0.00000,1),('07903351-a62e-11e8-b258-0800279cc012','MS-SI100E','RASPADORA DE HIELO','#000000','#ffffff','RASP','SWAN SI-100 RASPADORA DE HIELO EN BLOQUE (115 VOLT)',3,3054420.03000,1018140.01000,0.00000,0),('0a7ce055-a58d-11e8-b258-0800279cc012','CP-FHGLOVES-L','GUANTES TALLA L','','','GUAL','GUANTES PLÁSTICOS MANIPULADORES DE ALIMENTOS TALLA L',2000,14000.00000,7.00000,0.00000,0),('0cdf88ba-a62f-11e8-b258-0800279cc012','CP-NAPKINS','SERVILLETAS','','','SERV','SERVILLETAS CON LOGO IMPRESO',24000,221520.00000,9.23000,0.00000,0),('0d36c8db-a58e-11e8-b258-0800279cc012','AP-P-CPO-21','LÁMINA TRANSLÚCIDA PEQUEÑA','','','LAMP','LÁMINA PLÁSTICA TRANSLÚCIDA PROTECTORA PARA PÓSTER PEQUEÑA (21X33 PULGADAS)',2,15747.82000,7873.91000,0.00000,0),('0da5e444-a62a-11e8-b258-0800279cc012','AC-ICEPAIL','CUBOS PARA HIELO','#000000','#ffffff','CUBS','CUBOS PLASTICOS PARA FABRICAR HIELO',144,214345.44000,1488.51000,0.00000,0),('103cd805-a64d-11e8-b258-0800279cc012','SIR-ROOTB','SIROPE DE ZARZA','#faf4f4','#804821','ROOT','BOTELLA DE SIROPE DE ZARZA 750 ML',0,0.00000,0.00000,0.00000,1),('130612f5-a64c-11e8-b258-0800279cc012','SIR-BUBBL','SIROPE DE CHICLE','#59c4db','#2348c9','BUBB','BOTELLA DE SIROPE DE CHICLE 750 ML',0,0.00000,0.00000,0.00000,1),('1c01164d-a62f-11e8-b258-0800279cc012','CP-SPOONS-C1','CUCHARAS','','','CUCR','CUCHARAS PLÁSTICAS',23848,629587.20000,26.40000,0.00000,0),('1ffe07bf-a58e-11e8-b258-0800279cc012','CL-APRON-FBL','DELANTAL PLÁSTICO','','','DELA','DELANTAL PLÁSTICO COMPLETO',8,58791.84000,7348.98000,0.00000,0),('205d81ff-a64d-11e8-b258-0800279cc012','SIR-STRAW','SIROPE DE FRESA','#0a0a0a','#d94065','STRW','BOTELLA DE SIROPE DE FRESA 750 ML',0,0.00000,0.00000,0.00000,1),('20d7dfd1-a64c-11e8-b258-0800279cc012','SIR-COCON','SIROPE DE COCO','#0d0c0c','#f6f7cc','COCO','BOTELLA DE SIROPE DE COCO 750 ML',0,0.00000,0.00000,0.00000,1),('22ce212a-a62e-11e8-b258-0800279cc012','P-100-12','CUCHILLAS','','','CUCH','CUCHILLAS (SI-100E, SI-150E, SI-200E, SI-38)',10,178621.10000,17862.11000,0.00000,0),('2a2a3a5f-a58a-11e8-b258-0800279cc012','P-FOOT-LA','CONTROL DE PIE','','','PIE','CAJA DE CONTROLADOR DE PIE, PEDAL Y MANGUERA',3,68895.00000,22965.00000,0.00000,0),('3150ac55-a62f-11e8-b258-0800279cc012','AP-P-WCS-28','MOLDURA PARA PÓSTER 4 PATAS','','','MOL4','MOLDURA PARA PÓSTER (WINDMASTER) CON PATAS (28X44 PULGADAS)',1,113734.22000,113734.22000,0.00000,0),('318d41d8-a64c-11e8-b258-0800279cc012','SIR-COLA','SIROPE DE COLA','#f7efef','#f74e29','COLA','BOTELLA DE SIROPE DE COLA 750 ML',0,0.00000,0.00000,0.00000,1),('318efd1b-a58e-11e8-b258-0800279cc012','CL-HAT-OTTO','GORRA MESH','','','MESH','GORRA MESH CON LOGO',8,46660.16000,5832.52000,0.00000,0),('3ab03f8d-a64d-11e8-b258-0800279cc012','SIR-VANIL','SIROPE DE VAINILLA','#0f0e0e','#dec9c9','VANI','BOTELLA DE SIROPE DE VAINILLA 750 ML',0,0.00000,0.00000,0.00000,1),('409bd3ad-a58b-11e8-b258-0800279cc012','AC-QBTREE','ÁRBOL SECADOR PARA BOTELLAS','','','TREE','ÁRBOL SECADOR PARA BOTELLAS',1,22965.56000,22965.56000,0.00000,0),('417029a9-a58d-11e8-b258-0800279cc012','AP-P-OPF-21','MOLDURA PARA PÓSTER PEQUEÑA','','','MOLP','MOLDURA PARA PÓSTER EXTERIORES PEQUEÑA (21X33 PULGADAS)',2,93320.38000,46660.19000,0.00000,0),('4393476b-a62e-11e8-b258-0800279cc012','AC-QB-TS-17','BOTELLAS MARCA TROPICAL SNO','','','BOTL','BOTELLAS PLÁSTICAS  CON LA MARCA TROPICAL SNO (INCLUYE ETIQUETAS Y TAPAS)',168,171475.92000,1020.69000,0.00000,0),('467a2aa7-a62f-11e8-b258-0800279cc012','AP-P-OPF-28','MOLDURA PARA PÓSTER GRANDE','','','MOLG','MOLDURA PARA PÓSTER EXTERIORES GRANDE (28 X 44 PULGADAS)',2,110817.96000,55408.98000,0.00000,0),('49acc603-a64d-11e8-b258-0800279cc012','SIR-VERCH','SIROPE DE MUY CEREZA','#faf1f1','#8a1c23','VECH','BOTELLA DE SIROPE DE MUY CEREZA 750 ML',0,0.00000,0.00000,0.00000,1),('4bbe7eff-a64c-11e8-b258-0800279cc012','SIR-COTTO','SIROPE DE ALGODÓN DE AZÚCAR','#0d0c0c','#ca91d4','COTT','BOTELLA DE SIROPE DE ALGODÓN DE AZÚCAR 750 ML',0,0.00000,0.00000,0.00000,1),('4c65ebb3-a58e-11e8-b258-0800279cc012','CL-TM-BL-LG','CAMISETA CUELLO AZUL L','','','CAZL','CAMISETA PARA HOMBRE, CUELLO AZUL, TALLA L',2,13414.80000,6707.40000,0.00000,0),('4eea04f4-a58b-11e8-b258-0800279cc012','AC-ICECHIP','CARGADOR DE HIELO','','','CARG','CARGADOR DE HIELO',2,12248.30000,6124.15000,0.00000,0),('58a4d4af-a64d-11e8-b258-0800279cc012','SIR-WATER','SIROPE DE SANDÍA','#fff4f4','#b3617a','WMEL','BOTELLA DE SIROPE DE SANDÍA 750 ML',0,0.00000,0.00000,0.00000,1),('5dd13d02-a64c-11e8-b258-0800279cc012','SIR-FRESH','SIROPE DE LIMA FRESCA','#0d0c0c','#17ed46','FRSH','BOTELLA DE SIROPE DE LIMA FRESCA 750 ML',0,0.00000,0.00000,0.00000,1),('5e7d3cd0-a62e-11e8-b258-0800279cc012','AC-RACK-DLX','EXHIBIDOR PARA BOTELLAS','','','RACK','RACK PLÁSTICO EXHIBIDOR DE LUJO PARA BOTELLAS (PARA 12 UNIDADES)',4,244966.00000,61241.50000,0.00000,0),('62b8fea9-a58e-11e8-b258-0800279cc012','CL-TM-BL-ME','CAMISETA CUELLO AZUL M','','','CAZM','CAMISETA PARA HOMBRE, CUELLO AZUL, TALLA M',2,13414.80000,6707.40000,0.00000,0),('67b239ae-a58b-11e8-b258-0800279cc012','AC-QTSQUEEZE','BOTELLA MEZCLADORA','','','B-ME','BOTELLA MEZCLADORA PARA TOPPINGS',0,0.00000,1275.86000,0.00000,0),('6c395541-a64c-11e8-b258-0800279cc012','SIR-GRAPE','SIROPE DE UVA','#f7eaea','#6d2d94','GRAP','BOTELLA DE SIROPE DE UVA 750 ML',0,0.00000,0.00000,0.00000,1),('6d4eaa4e-a64d-11e8-b258-0800279cc012','SIR-GUAVA','SIROPE DE GUAYABA','#0a0a0a','#f79955','GUAV','BOTELLA DE SIROPE DE GUAYABA 750 ML',0,0.00000,0.00000,0.00000,1),('76638b19-a58d-11e8-b258-0800279cc012','AP-BANNER17-TS','BANDERA TROPICAL SNO','','','FLAG','BANDERA TROPICAL SNO 2017',2,69990.30000,34995.15000,2500.00000,0),('779381ea-a58a-11e8-b258-0800279cc012','AC-QSPOUTS','TAPAS VERTEDORAS (AZULES)','','','T-AZU','TAPAS VERTEDORAS DE LIQUIDO (AZULES)',60,15310.20000,255.17000,0.00000,0),('79605c96-a58e-11e8-b258-0800279cc012','CL-TM-BL-SM','CAMISETA CUELLO AZUL S','','','CAZS','CAMISETA PARA HOMBRE, CUELLO AZUL, TALLA S',2,13414.80000,6707.40000,0.00000,0),('7b1ead74-a64d-11e8-b258-0800279cc012','SIR-PASSI','SIROPE DE MARACUYÁ','#0a0a0a','#e0d8ac','PASS','BOTELLA DE SIROPE DE MARACUYÁ 750 ML',0,0.00000,0.00000,0.00000,1),('7b6a94ac-a64c-11e8-b258-0800279cc012','SIR-GREEN','SIROPE DE MANZANA VERDE','#0a0a0a','#77fa74','GREE','BOTELLA DE SIROPE DE MANZANA VERDE 750 ML',0,0.00000,0.00000,0.00000,1),('89cd9b84-a64c-11e8-b258-0800279cc012','SIR-LEMON','SIROPE DE LIMÓN','#080707','#21a61f','LEMO','BOTELLA DE SIROPE DE LIMÓN 750 ML',0,0.00000,0.00000,0.00000,1),('8fc42890-a62e-11e8-b258-0800279cc012','AC-QTCRATE','CAJAS TRASNPORTADORAS','','','CTRA','CAJAS PLÁSTICAS TRANSPORTADORAS DE BOTELLAS (PARA 12 UNIDADES)',10,122483.00000,12248.30000,0.00000,0),('945818b4-a58e-11e8-b258-0800279cc012','CL-TM-HG-LG','CAMISETA GRIS L','','','CGRL','CAMISETA DE HOMBRE, CUELLO GRIS, TALLA L',2,13414.80000,6707.40000,0.00000,0),('97a7dcda-a64c-11e8-b258-0800279cc012','SIR-MANGO','SIROPE DE MANGO','#0d0d0d','#eb9f45','MANG','BOTELLA DE SIROPE DE MANGO 750 ML',0,0.00000,0.00000,0.00000,1),('9bc3c191-a58a-11e8-b258-0800279cc012','AC-QSPOUTCAPS','TAPAS VERTEDORAS (NARANJA)','','','T-NAR','TAPAS  DE PLÁSTICO PARA TAPAR LAS VERTEDORAS DE LIQUIDO (NARANJA)',60,7655.40000,127.59000,0.00000,0),('9c6e039f-a638-11e8-b258-0800279cc012','CP-SPILLS-12','VASO ANTI-DERRAME 12OZ','#000000','#ffffff','AT12','VASOS ANTI-DERRAME, PLÁSTICO AZUL, 12 ONZAS',5990,664470.70000,110.93000,0.00000,0),('a040d8d4-a58d-11e8-b258-0800279cc012','AP-P15-SET-28','PÓSTER GRANDE','','','POSG','PÓSTER GRANDE (28X44 PULGADAS) ',10,29162.60000,2916.26000,0.00000,0),('a17c90c5-a58e-11e8-b258-0800279cc012','CL-TM-HG-ME','CAMISETA GRIS M','','','CGRM','CAMISETA DE HOMBRE, CUELLO GRIS, TALLA M',2,13414.80000,6707.40000,0.00000,0),('a4b0b267-a64c-11e8-b258-0800279cc012','SIR-ORANGE','SIROPE DE NARANJA','#0a0a0a','#fa9601','ORAN','BOTELLA DE SIROPE DE NARANJA 750 ML',0,0.00000,0.00000,0.00000,1),('a7cc750c-a62e-11e8-b258-0800279cc012','CP-CUPTS-08','VASOS DE 8OZ','','','V8OZ','VASOS DE ESTEREOFÓN CON LOGO TROPICAL SNO 8OZ',13997,326410.04000,23.32000,0.00000,0),('b298fd5c-a64b-11e8-b258-0800279cc012','SIR-BANAN','SIROPE DE BANANO','#000000','#eaf5a5','bana','BOTELLA DE SIROPE DE BANANO 750 ML',0,0.00000,1458.13000,2500.00000,1),('b58ecc55-a58e-11e8-b258-0800279cc012','CL-TM-HG-SM','CAMISETA GRIS S','','','CGRS','CAMISETA DE HOMBRE, CUELLO GRIS, TALLA S ',2,13414.80000,6707.40000,0.00000,0),('b8d5372b-a62e-11e8-b258-0800279cc012','CP-CUPTS-16','VASOS DE 12OZ','','','V12O','VASOS DE ESTEREOFÓN CON LOGO TROPICAL SNO 12OZ',6000,174960.00000,29.16000,0.00000,0),('b948f654-a636-11e8-b258-0800279cc012','CP-SPILLS-08','VASO ANTI-DERRAME 8OZ','#000000','#ffffff','ANT8','VASOS ANTI-DERRAME, PLÁSTICO VERDE, 8 ONZAS',14032,1551518.24000,110.57000,0.00000,0),('be639949-a58d-11e8-b258-0800279cc012','AP-P15-SET-21','PÓSTER PEQUEÑO','','','POSP','PÓSTER PEQUEÑO (21X33 PULGADAS) ',10,29162.60000,2916.26000,0.00000,0),('c585ac10-a64b-11e8-b258-0800279cc012','SIR-BLACK','SIROPE DE CEREZA NEGRA','#f7f4f4','#661111','blak','BOTELLA DE SIROPE DE CEREZA NEGRA 750 ML',10,14581.30000,1458.13000,0.00000,1),('cb2f62a6-a64c-11e8-b258-0800279cc012','SIR-PEACH','SIROPE DE MELOCOTÓN','#0a0a0a','#ebc285','PECH','BOTELLA DE SIROPE DE MELOCOTÓN 750 ML',0,0.00000,0.00000,0.00000,1),('d8ddbbf4-a64b-11e8-b258-0800279cc012','SIR-BLUEB','SIROPE DE ARÁNDANO','#fffbfb','#23128f','BLUB','BOTELLA DE SIROPE DE ARÁNDANO 750 ML',0,0.00000,0.00000,0.00000,1),('ded11f42-a64c-11e8-b258-0800279cc012','SIR-PINAC','SIROPE DE PIÑA COLADA','#0f0f0f','#e3db90','PINC','BOTELLA DE SIROPE DE PIÑA COLADA 750 ML',0,0.00000,0.00000,0.00000,1),('e4833657-a58e-11e8-b258-0800279cc012','CL-TM-RR-TS-LG','CAMISETA ROYAL L','','','ROYL','CAMISETA PARA HOMBRE, ROYAL RINGER, TROPICAL SNO, TALLA L',2,13414.80000,6707.40000,0.00000,0),('e6539ab5-a58d-11e8-b258-0800279cc012','AP-P-CPO-28','LÁMINA TRANSLÚCIDA GRANDE','','','LAMG','LÁMINA PLÁSTICA TRANSLÚCIDA PROTECTORA PARA PÓSTER GRANDE (28*44 PULGADAS)',4,40827.68000,10206.92000,0.00000,0),('e6a2c172-b2b5-11e8-8061-0800279cc012','CC-COCO','COCO','#f8fcfc','#7a2e2e','coco','Topping de COCO',50,0.00000,0.00000,0.00000,2),('eca0acc2-a64b-11e8-b258-0800279cc012','SIR-BLUEH','SIROPE DE HAWAIANO AZUL','#74f5f5','#3b6ca6','BLUH','BOTELLA DE SIROPE DE HAWAIANO AZUL 750 ML',0,0.00000,0.00000,0.00000,1),('ecd762a7-a58c-11e8-b258-0800279cc012','CP-FHGLOVES-M','GUANTES TALLA M','','','GUAM','GUANTES PLÁSTICOS MANIPULADORES DE ALIMENTOS TALLA M',2000,14000.00000,7.00000,0.00000,0),('ef3fcb6a-a64c-11e8-b258-0800279cc012','SIR-PINEA','SIROPE DE PIÑA','#0f0f0f','#e6f074','PINE','BOTELLA DE SIROPE DE PIÑA 750 ML',0,0.00000,0.00000,0.00000,1),('f1aeee28-a58e-11e8-b258-0800279cc012','CL-TM-RR-TS-ME','CAMISETA ROYAL M','','','ROYM','CAMISETA PARA HOMBRE, ROYAL RINGER, TROPICAL SNO, TALLA M',2,13414.80000,6707.40000,0.00000,0),('fc0acd5f-a58a-11e8-b258-0800279cc012','AC-MIXJUGS','GALONES MEZCLADORES','','','MEZC','GALONES PLÁSTICOS MEZCLADORES CON SUS TAPAS',40,76552.00000,1913.80000,0.00000,0),('fe1e806b-a58e-11e8-b258-0800279cc012','CL-TM-RR-TS-SM','CAMISETA ROYAL S','','','ROYS','CAMISETA PARA HOMBRE, ROYAL RINGER, TROPICAL SNO, TALLA S',2,13414.80000,6707.40000,0.00000,0);
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
INSERT INTO `productosXDistribucion` VALUES ('68f6e991-b2b6-11e8-8061-0800279cc012','504def28-3f12-4f9d-adff-ec4992eb801e','e6a2c172-b2b5-11e8-8061-0800279cc012',50,0.00000),('83fdea80-b2b4-11e8-8061-0800279cc012','a3282b47-f01b-4b66-b6f1-48d467ebc4ab','67b239ae-a58b-11e8-b258-0800279cc012',6,0.00000),('bfec42e5-b2b3-11e8-8061-0800279cc012','d987b01d-b9e9-4ed7-9284-f47cd856bef2','b298fd5c-a64b-11e8-b258-0800279cc012',20,0.00000),('fb5c389b-b2b3-11e8-8061-0800279cc012','094dfea1-91d4-429d-b724-a95ff543188d','c585ac10-a64b-11e8-b258-0800279cc012',10,0.00000);
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
INSERT INTO `productosXFactura` VALUES ('0fadc441-b2d2-11e8-8061-0800279cc012','a4c106d6-866a-45df-9691-0b1ef140c55a','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('1ee0a4b0-b2b7-11e8-8061-0800279cc012','26f02e9e-7b94-42f1-ad94-ed0e1de9c34b','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('1ee6deaa-b2b7-11e8-8061-0800279cc012','26f02e9e-7b94-42f1-ad94-ed0e1de9c34b','8079b095-91ad-11e8-b0db-0800279cc012',2,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('1eed5116-b2b7-11e8-8061-0800279cc012','26f02e9e-7b94-42f1-ad94-ed0e1de9c34b','8079b095-91ad-11e8-b0db-0800279cc012',3,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('20406de8-b2d3-11e8-8061-0800279cc012','8314c873-5fda-4eb6-9c15-a3c779baace0','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, blak, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('2089a106-b2d1-11e8-8061-0800279cc012','941ed927-7db1-4e1c-8cff-9a6d57309062','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('208eb7b1-b2d1-11e8-8061-0800279cc012','941ed927-7db1-4e1c-8cff-9a6d57309062','8079b095-91ad-11e8-b0db-0800279cc012',2,NULL,NULL,1.000,33,NULL,'12oz, blak, blak, Sin Topping',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('2093b9ce-b2d1-11e8-8061-0800279cc012','941ed927-7db1-4e1c-8cff-9a6d57309062','8a9277b7-91ad-11e8-b0db-0800279cc012',3,NULL,NULL,1.000,33,NULL,'08oz, bana, blak, coco',1500.00000,0.00000,NULL,NULL,1500.00000,NULL,NULL,NULL,NULL,1500.00000),('31e7b31b-b2d2-11e8-8061-0800279cc012','f0bf8f9b-c27b-400e-b873-9c69fd85e07f','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('412f4b08-b2d1-11e8-8061-0800279cc012','b0d7edab-9c12-4ee3-9302-15dd4c7c3e87','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, Sin Topping',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('41343da0-b2d1-11e8-8061-0800279cc012','b0d7edab-9c12-4ee3-9302-15dd4c7c3e87','8a9277b7-91ad-11e8-b0db-0800279cc012',2,NULL,NULL,1.000,33,NULL,'08oz, bana, blak, coco',1500.00000,0.00000,NULL,NULL,1500.00000,NULL,NULL,NULL,NULL,1500.00000),('413e753b-b2d1-11e8-8061-0800279cc012','b0d7edab-9c12-4ee3-9302-15dd4c7c3e87','8a9277b7-91ad-11e8-b0db-0800279cc012',3,NULL,NULL,1.000,33,NULL,'08oz, bana, blak, coco',1500.00000,0.00000,NULL,NULL,1500.00000,NULL,NULL,NULL,NULL,1500.00000),('4144c70d-b2d1-11e8-8061-0800279cc012','b0d7edab-9c12-4ee3-9302-15dd4c7c3e87','8079b095-91ad-11e8-b0db-0800279cc012',4,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('43bb0f6c-b2d2-11e8-8061-0800279cc012','5e50d70f-f155-4e24-85f1-90d31de7cf87','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('4d862291-b2b8-11e8-8061-0800279cc012','2d1c702f-f55c-476b-9b26-444eb8abef39','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('4d8c8619-b2b8-11e8-8061-0800279cc012','2d1c702f-f55c-476b-9b26-444eb8abef39','8079b095-91ad-11e8-b0db-0800279cc012',2,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('4d92ec7e-b2b8-11e8-8061-0800279cc012','2d1c702f-f55c-476b-9b26-444eb8abef39','8079b095-91ad-11e8-b0db-0800279cc012',3,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('50652b55-b2d3-11e8-8061-0800279cc012','64154c35-c5d6-4945-bc0e-a277d8c081ea','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, blak, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('53b8ae3a-b2b9-11e8-8061-0800279cc012','8437e99f-212c-42c8-b916-bffcf0eb1c09','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('53bef8e0-b2b9-11e8-8061-0800279cc012','8437e99f-212c-42c8-b916-bffcf0eb1c09','8079b095-91ad-11e8-b0db-0800279cc012',2,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('53c4193f-b2b9-11e8-8061-0800279cc012','8437e99f-212c-42c8-b916-bffcf0eb1c09','8079b095-91ad-11e8-b0db-0800279cc012',3,NULL,NULL,1.000,33,NULL,'12oz, blak, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('53c928b0-b2b9-11e8-8061-0800279cc012','8437e99f-212c-42c8-b916-bffcf0eb1c09','8079b095-91ad-11e8-b0db-0800279cc012',4,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('5f6b6464-b2c0-11e8-8061-0800279cc012','d359d7b0-1f72-4c59-93a8-dc8e95863607','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('665723c3-b2ba-11e8-8061-0800279cc012','616995c6-99b6-477b-b5cb-c4e848e28811','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('665c4594-b2ba-11e8-8061-0800279cc012','616995c6-99b6-477b-b5cb-c4e848e28811','8079b095-91ad-11e8-b0db-0800279cc012',2,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('66614b6f-b2ba-11e8-8061-0800279cc012','616995c6-99b6-477b-b5cb-c4e848e28811','8079b095-91ad-11e8-b0db-0800279cc012',3,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('66667048-b2ba-11e8-8061-0800279cc012','616995c6-99b6-477b-b5cb-c4e848e28811','8079b095-91ad-11e8-b0db-0800279cc012',4,NULL,NULL,1.000,33,NULL,'12oz, blak, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('666b9f62-b2ba-11e8-8061-0800279cc012','616995c6-99b6-477b-b5cb-c4e848e28811','8079b095-91ad-11e8-b0db-0800279cc012',5,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('66709546-b2ba-11e8-8061-0800279cc012','616995c6-99b6-477b-b5cb-c4e848e28811','8079b095-91ad-11e8-b0db-0800279cc012',6,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('7941d42a-b2d4-11e8-8061-0800279cc012','5389bc11-356c-437b-99e1-d284f93adb0b','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('87be1d00-b2b6-11e8-8061-0800279cc012','639b1713-71e9-4865-91e2-11481823406a','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('87c32e15-b2b6-11e8-8061-0800279cc012','639b1713-71e9-4865-91e2-11481823406a','8a9277b7-91ad-11e8-b0db-0800279cc012',2,NULL,NULL,1.000,33,NULL,'08oz, bana, blak, coco',1500.00000,0.00000,NULL,NULL,1500.00000,NULL,NULL,NULL,NULL,1500.00000),('87cd6225-b2b6-11e8-8061-0800279cc012','639b1713-71e9-4865-91e2-11481823406a','8a9277b7-91ad-11e8-b0db-0800279cc012',3,NULL,NULL,1.000,33,NULL,'08oz, bana, bana, coco',1500.00000,0.00000,NULL,NULL,1500.00000,NULL,NULL,NULL,NULL,1500.00000),('87d3bfec-b2b6-11e8-8061-0800279cc012','639b1713-71e9-4865-91e2-11481823406a','8a9277b7-91ad-11e8-b0db-0800279cc012',4,NULL,NULL,1.000,33,NULL,'08oz, bana, blak, coco',1500.00000,0.00000,NULL,NULL,1500.00000,NULL,NULL,NULL,NULL,1500.00000),('87da0cee-b2b6-11e8-8061-0800279cc012','639b1713-71e9-4865-91e2-11481823406a','8a9277b7-91ad-11e8-b0db-0800279cc012',5,NULL,NULL,1.000,33,NULL,'08oz, bana, blak, coco',1500.00000,0.00000,NULL,NULL,1500.00000,NULL,NULL,NULL,NULL,1500.00000),('a1453e7c-b2b7-11e8-8061-0800279cc012','7aa10a7c-a051-4bd0-bd1a-91365bf52e83','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('a9349696-b2d4-11e8-8061-0800279cc012','ddd8332a-9a4d-4347-8129-be1adecb7d17','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('aed6d5d6-b2bf-11e8-8061-0800279cc012','9613d3c2-c885-437a-a56a-b367221422ea','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('c0154d1b-b2d3-11e8-8061-0800279cc012','c6fb6213-d5c7-4dfb-8dea-cc4e911d4f6d','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('c088071d-b2d2-11e8-8061-0800279cc012','d451c605-3100-4bf4-a1da-6afdf6578b12','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('cb6b8dd5-b2b6-11e8-8061-0800279cc012','2eb392f9-cf1f-4f7f-bf55-7315e759005d','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('cb71fda5-b2b6-11e8-8061-0800279cc012','2eb392f9-cf1f-4f7f-bf55-7315e759005d','8079b095-91ad-11e8-b0db-0800279cc012',2,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('cb770b5c-b2b6-11e8-8061-0800279cc012','2eb392f9-cf1f-4f7f-bf55-7315e759005d','8079b095-91ad-11e8-b0db-0800279cc012',3,NULL,NULL,1.000,33,NULL,'12oz, blak, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('cb7c0a01-b2b6-11e8-8061-0800279cc012','2eb392f9-cf1f-4f7f-bf55-7315e759005d','8079b095-91ad-11e8-b0db-0800279cc012',4,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('cb813784-b2b6-11e8-8061-0800279cc012','2eb392f9-cf1f-4f7f-bf55-7315e759005d','8079b095-91ad-11e8-b0db-0800279cc012',5,NULL,NULL,1.000,33,NULL,'12oz, blak, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('cb864c39-b2b6-11e8-8061-0800279cc012','2eb392f9-cf1f-4f7f-bf55-7315e759005d','8079b095-91ad-11e8-b0db-0800279cc012',6,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('d2107e45-b2d2-11e8-8061-0800279cc012','de6b9abf-e05a-44e9-84f8-6d92dd069bc1','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('daa88e36-b2d1-11e8-8061-0800279cc012','436501fc-5938-4ea4-bc7f-576379ce04ef','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, blak, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('e0a6e8ac-b2b7-11e8-8061-0800279cc012','088e2e44-1076-423b-8aee-516bce5817c7','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('f06336fc-b2d2-11e8-8061-0800279cc012','ea3a9e40-cbb2-4ff4-b254-268b4834c424','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('f0682106-b2d2-11e8-8061-0800279cc012','ea3a9e40-cbb2-4ff4-b254-268b4834c424','8079b095-91ad-11e8-b0db-0800279cc012',2,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('f06d333b-b2d2-11e8-8061-0800279cc012','ea3a9e40-cbb2-4ff4-b254-268b4834c424','8079b095-91ad-11e8-b0db-0800279cc012',3,NULL,NULL,1.000,33,NULL,'12oz, blak, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('f0725c96-b2d2-11e8-8061-0800279cc012','ea3a9e40-cbb2-4ff4-b254-268b4834c424','8079b095-91ad-11e8-b0db-0800279cc012',4,NULL,NULL,1.000,33,NULL,'12oz, blak, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('f0778910-b2d2-11e8-8061-0800279cc012','ea3a9e40-cbb2-4ff4-b254-268b4834c424','8a9277b7-91ad-11e8-b0db-0800279cc012',5,NULL,NULL,1.000,33,NULL,'08oz, bana, bana, coco',1500.00000,0.00000,NULL,NULL,1500.00000,NULL,NULL,NULL,NULL,1500.00000),('fa1d47c5-b2b9-11e8-8061-0800279cc012','97b9d5a0-12fe-4fa0-b402-6c4214a9838d','8079b095-91ad-11e8-b0db-0800279cc012',1,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('fa2396a3-b2b9-11e8-8061-0800279cc012','97b9d5a0-12fe-4fa0-b402-6c4214a9838d','8079b095-91ad-11e8-b0db-0800279cc012',2,NULL,NULL,1.000,33,NULL,'12oz, bana, bana, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('fa28a9e2-b2b9-11e8-8061-0800279cc012','97b9d5a0-12fe-4fa0-b402-6c4214a9838d','8079b095-91ad-11e8-b0db-0800279cc012',3,NULL,NULL,1.000,33,NULL,'12oz, blak, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000),('fa2dbaa6-b2b9-11e8-8061-0800279cc012','97b9d5a0-12fe-4fa0-b402-6c4214a9838d','8079b095-91ad-11e8-b0db-0800279cc012',4,NULL,NULL,1.000,33,NULL,'12oz, bana, blak, coco',2500.00000,0.00000,NULL,NULL,2500.00000,NULL,NULL,NULL,NULL,2500.00000);
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
INSERT INTO `rolesXUsuario` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('31221f87-1b60-48d1-a0ce-68457d1298c1','9d27aedd-992d-475a-a01b-09b1c2aa2714'),('31221f87-1b60-48d1-a0ce-68457d1298c1','f874513a-3fc2-4fc7-b48e-46cb96af4901'),('5f9bd173-9369-47d5-a1b8-fe5ab8234c61','1e03b970-2778-43fb-aff6-444043d2bf51'),('e8d2f620-dd38-4e21-8b7f-7949412f65d6','291a7a1c-17a4-4062-8a70-3b9db409113a'),('e8d2f620-dd38-4e21-8b7f-7949412f65d6','fd9d2be6-6999-40ce-9954-1462c9ca0ffb');
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
INSERT INTO `usuario` VALUES ('1e03b970-2778-43fb-aff6-444043d2bf51','Olga Arias','Vendedor 1','$2y$10$sKLZBY4EO5BzBrWeUm0sQOEADIzuviIUwY17LAP8x3KqDMgm9py/a','',1),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','administrador de sistema','admin','$2y$10$CwVlbwIWdHbxlQqo3yJHj.zo7BRekPGM.NCIjn02fIc0f7uz9gpua','',1),('291a7a1c-17a4-4062-8a70-3b9db409113a','Viviana Ramirez','Viviana','$2y$10$T97UtIZFneCNUS9VkosBr.RvKHhOb/C2LomBHnPBZODQig3JC3Xj.','',1),('9d27aedd-992d-475a-a01b-09b1c2aa2714','Despacho San Pedro','DespachoSP','$2y$10$eOzcp6F611LXGf4a2YcNBu5MiY3lUSda1yqxpS5A2kcPfzu4moTF2','',1),('f874513a-3fc2-4fc7-b48e-46cb96af4901','Prueba Despacho','Despacho1','$2y$10$7jCKUBwL7XPSrnXBR1B6oeZJEjfVGshXXGj/IuuiYNarGjIVqFd42','',1),('fd9d2be6-6999-40ce-9954-1462c9ca0ffb','Margarita Gutierrez','Bodeguero','$2y$10$WmGBZz2UEYPOYIWefTW4N.Y7M0E2S9zvvN0pbDMvBm6FKv4gn/LqS','',1);
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
INSERT INTO `usuariosXBodega` VALUES ('1e03b970-2778-43fb-aff6-444043d2bf51','63363882-a840-4517-9786-67f148f6a587'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','63363882-a840-4517-9786-67f148f6a587'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','72a5afa7-dcba-4539-8257-ed1e18b1ce94'),('291a7a1c-17a4-4062-8a70-3b9db409113a','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('9d27aedd-992d-475a-a01b-09b1c2aa2714','63363882-a840-4517-9786-67f148f6a587'),('f874513a-3fc2-4fc7-b48e-46cb96af4901','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('fd9d2be6-6999-40ce-9954-1462c9ca0ffb','72a5afa7-dcba-4539-8257-ed1e18b1ce94');
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

-- Dump completed on 2018-09-10 12:05:04

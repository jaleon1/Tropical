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

DROP TABLE IF EXISTS `barrio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barrio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idDistrito` int(11) DEFAULT NULL,
  `codigo` int(2) unsigned zerofill DEFAULT NULL,
  `barrio` varchar(80) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6604 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barrio`
--

LOCK TABLES `barrio` WRITE;
/*!40000 ALTER TABLE `barrio` DISABLE KEYS */;
INSERT INTO `barrio` VALUES (1,1,01,'Amón'),(2,1,02,'Aranjuez'),(3,1,03,'California (parte)'),(4,1,04,'Carmen'),(5,1,05,'Empalme'),(6,1,06,'Escalante'),(7,1,07,'Otoya.'),(8,2,01,'Bajos de la Unión'),(9,2,02,'Claret'),(10,2,03,'Cocacola'),(11,2,04,'Iglesias Flores'),(12,2,05,'Mantica'),(13,2,06,'México'),(14,2,07,'Paso de la Vaca'),(15,2,08,'Pitahaya.'),(16,3,01,'Almendares'),(17,3,02,'Ángeles'),(18,3,03,'Bolívar'),(19,3,04,'Carit'),(20,3,05,'Colón (parte)'),(21,3,06,'Corazón de Jesús'),(22,3,07,'Cristo Rey'),(23,3,08,'Cuba'),(24,3,09,'Dolorosa (parte)'),(25,3,10,'Merced'),(26,3,11,'Pacífico (parte)'),(27,3,12,'Pinos'),(28,3,13,'Salubridad'),(29,3,14,'San Bosco'),(30,3,15,'San Francisco'),(31,3,16,'Santa Lucía'),(32,3,17,'Silos.'),(33,4,01,'Bellavista'),(34,4,02,'California (parte)'),(35,4,03,'Carlos María Jiménez'),(36,4,04,'Dolorosa (parte)'),(37,4,05,'Dos Pinos'),(38,4,06,'Francisco Peralta (parte)'),(39,4,07,'González Lahmann'),(40,4,08,'González Víquez'),(41,4,09,'Güell'),(42,4,10,'La Cruz'),(43,4,11,'Lomas de Ocloro'),(44,4,12,'Luján'),(45,4,13,'Milflor'),(46,4,14,'Naciones Unidas'),(47,4,15,'Pacífico (parte)'),(48,4,16,'San Cayetano (parte)'),(49,4,17,'Soledad'),(50,4,18,'Tabacalera'),(51,4,19,'Vasconia.'),(52,5,01,'Alborada'),(53,5,02,'Calderón Muñoz'),(54,5,03,'Cerrito'),(55,5,04,'Córdoba'),(56,5,05,'Gloria'),(57,5,06,'Jardín'),(58,5,07,'Luisas'),(59,5,08,'Mangos'),(60,5,09,'Montealegre'),(61,5,10,'Moreno Cañas'),(62,5,11,'Quesada Durán'),(63,5,12,'San Dimas'),(64,5,13,'San Gerardo (parte)'),(65,5,14,'Trébol'),(66,5,15,'Ujarrás'),(67,5,16,'Vista Hermosa'),(68,5,17,'Yoses Sur'),(69,5,18,'Zapote (centro).'),(70,6,01,'Ahogados (parte)'),(71,6,02,'Bosque'),(72,6,03,'Cabañas'),(73,6,04,'Camelias'),(74,6,05,'Coopeguaria'),(75,6,06,'Faro'),(76,6,07,'Fátima'),(77,6,08,'Hispano'),(78,6,09,'I Griega'),(79,6,10,'Lincoln'),(80,6,11,'Lomas de San Francisco'),(81,6,12,'Maalot'),(82,6,13,'Méndez'),(83,6,14,'Pacífica'),(84,6,15,'San Francisco de Dos Ríos (centro)'),(85,6,16,'Sauces'),(86,6,17,'Saucitos'),(87,6,18,'Zurquí.'),(88,7,01,'Alborada'),(89,7,02,'Ánimas'),(90,7,03,'Árboles'),(91,7,04,'Bajos del Torres'),(92,7,05,'Carranza'),(93,7,06,'Corazón de Jesús'),(94,7,07,'Cristal'),(95,7,08,'Carvajal Castro'),(96,7,09,'Jardines de Autopista'),(97,7,10,'La Caja'),(98,7,11,'La Carpio'),(99,7,12,'Magnolia'),(100,7,13,'Marimil'),(101,7,14,'Monserrat'),(102,7,15,'Peregrina'),(103,7,16,'Robledal'),(104,7,17,'Rossiter Carballo'),(105,7,18,'Santander'),(106,7,19,'Saturno'),(107,7,20,'Uruca (centro)'),(108,7,21,'Vuelta del Virilla.'),(109,8,01,'Américas'),(110,8,02,'Bajo Cañada (parte)'),(111,8,03,'Balcón Verde'),(112,8,04,'Colón (parte)'),(113,8,05,'Del Pino'),(114,8,06,'Holanda'),(115,8,07,'La Luisa'),(116,8,08,'La Salle'),(117,8,09,'Lomalinda'),(118,8,10,'Morenos'),(119,8,11,'Niza'),(120,8,12,'Rancho Luna'),(121,8,13,'Rohrmoser (parte)'),(122,8,14,'Roma'),(123,8,15,'Sabana'),(124,8,16,'Tovar.'),(125,9,01,'Alfa'),(126,9,02,'Asturias'),(127,9,03,'Asunción'),(128,9,04,'Bribrí'),(129,9,05,'Favorita Norte'),(130,9,06,'Favorita Sur'),(131,9,07,'Galicia'),(132,9,08,'Geroma'),(133,9,09,'Hispania'),(134,9,10,'Libertad'),(135,9,11,'Lomas del Río'),(136,9,12,'Llanos del Sol'),(137,9,13,'María Reina'),(138,9,14,'Metrópolis'),(139,9,15,'Navarra'),(140,9,16,'Pavas (centro)'),(141,9,17,'Pueblo Nuevo'),(142,9,18,'Residencial del Oeste'),(143,9,19,'Rincón Grande'),(144,9,20,'Rohrmoser (parte)'),(145,9,21,'Rotonda'),(146,9,22,'San Pedro'),(147,9,23,'Santa Bárbara'),(148,9,24,'Santa Catalina'),(149,9,25,'Santa Fé'),(150,9,26,'Triángulo'),(151,9,27,'Villa Esperanza.'),(152,10,01,'Bajo Cañada (parte)'),(153,10,02,'Belgrano'),(154,10,03,'Hatillo Centro'),(155,10,04,'Hatillo 1'),(156,10,05,'Hatillo 2'),(157,10,06,'Hatillo 3'),(158,10,07,'Hatillo 4'),(159,10,08,'Hatillo 5'),(160,10,09,'Hatillo 6'),(161,10,10,'Hatillo 7'),(162,10,11,'Hatillo 8'),(163,10,12,'Quince de Setiembre'),(164,10,13,'Sagrada Familia'),(165,10,14,'Tiribí'),(166,10,15,'Topacio'),(167,10,16,'Veinticinco de Julio'),(168,10,17,'Vivienda en Marcha.'),(169,11,01,'Bengala'),(170,11,02,'Bilbao'),(171,11,03,'Cañada del Sur'),(172,11,04,'Carmen'),(173,11,05,'Cascajal'),(174,11,06,'Cerro Azul'),(175,11,07,'Colombari'),(176,11,08,'Domingo Savio'),(177,11,09,'Guacamaya'),(178,11,10,'Jazmín'),(179,11,11,'Hogar Propio'),(180,11,12,'Kennedy'),(181,11,13,'López Mateos'),(182,11,14,'Luna Park'),(183,11,15,'Martínez'),(184,11,16,'Mojados'),(185,11,17,'Mongito'),(186,11,18,'Monte Azúl'),(187,11,19,'Musmanni'),(188,11,20,'Paso Ancho'),(189,11,21,'Presidentes'),(190,11,22,'San Cayetano (parte)'),(191,11,23,'San Martín'),(192,11,24,'San Sebastián (centro)'),(193,11,25,'Santa Rosa'),(194,11,26,'Seminario'),(195,11,27,'Sorobarú.'),(196,12,01,'Alto Carrizal'),(197,12,02,'Carrizal (parte)'),(198,12,03,'Faroles'),(199,12,04,'Guapinol'),(200,12,05,'Hulera'),(201,12,06,'Itabas'),(202,12,07,'Jaboncillo'),(203,12,08,'Profesores (parte).'),(204,13,01,'Avellana'),(205,13,02,'Bebedero'),(206,13,03,'Belo Horizonte (parte)'),(207,13,04,'Carrizal (parte)'),(208,13,05,'Curío'),(209,13,06,'Chirca'),(210,13,07,'Chiverral'),(211,13,08,'Entierrillo'),(212,13,09,'Filtros'),(213,13,10,'Guayabos'),(214,13,11,'Hojablanca'),(215,13,12,'Juan Santana'),(216,13,13,'Lajas'),(217,13,14,'Masilla'),(218,13,15,'Muta'),(219,13,16,'Pedrero'),(220,13,17,'Perú'),(221,13,18,'Profesores (parte)'),(222,13,19,'Sabanillas'),(223,13,20,'Salitrillos'),(224,13,21,'Santa Eduvigis'),(225,13,22,'Santa Teresa'),(226,13,23,'Tejarcillos'),(227,13,24,'Torrotillo'),(228,13,25,'Vista de Oro.'),(229,14,01,'Anonos'),(230,14,02,'Ayala'),(231,14,03,'Bajo Anonos'),(232,14,04,'Bajo Palomas'),(233,14,05,'Belo Horizonte (parte)'),(234,14,06,'Betina'),(235,14,07,'Ceiba'),(236,14,08,'Facio Castro'),(237,14,09,'Guachipelín'),(238,14,10,'Herrera'),(239,14,11,'Laureles'),(240,14,12,'León'),(241,14,13,'Loma Real'),(242,14,14,'Matapalo'),(243,14,15,'Maynard'),(244,14,16,'Mirador'),(245,14,17,'Miravalles'),(246,14,18,'Palermo'),(247,14,19,'Palma de Mallorca'),(248,14,20,'Pinar'),(249,14,21,'Primavera'),(250,14,22,'Quesada'),(251,14,23,'Real de Pereira (parte)'),(252,14,24,'Santa Marta'),(253,14,25,'Tena'),(254,14,26,'Trejos Montealegre'),(255,14,27,'Vista Alegre.'),(256,15,01,'Altamira'),(257,15,02,'Bellavista'),(258,15,03,'Calle Fallas'),(259,15,04,'Camaquirí'),(260,15,05,'Capilla'),(261,15,06,'Centro de Amigos'),(262,15,07,'Cerámica'),(263,15,08,'Colonia del Sur'),(264,15,09,'Contadores'),(265,15,10,'Cruce'),(266,15,11,'Cucubres'),(267,15,12,'Dorados'),(268,15,13,'Florita'),(269,15,14,'Fortuna'),(270,15,15,'Jardín'),(271,15,16,'Loto'),(272,15,17,'Metrópoli'),(273,15,18,'Monseñor Sanabria'),(274,15,19,'Monteclaro'),(275,15,20,'Palogrande'),(276,15,21,'Pinos'),(277,15,22,'Retoños'),(278,15,23,'Río Jorco'),(279,15,24,'Sabara'),(280,15,25,'San Esteban Rey'),(281,15,26,'San Jerónimo'),(282,15,27,'San José'),(283,15,28,'San Roque'),(284,15,29,'Tauros'),(285,15,30,'Torremolinos'),(286,15,31,'Venecia'),(287,15,32,'Vista Verde.'),(288,16,01,'Ángeles'),(289,16,02,'Capri'),(290,16,03,'Damas Israelitas'),(291,16,04,'Girasol'),(292,16,05,'Higuito'),(293,16,06,'Lindavista'),(294,16,07,'Lomas de Jorco'),(295,16,08,'Llano'),(296,16,09,'Meseguer'),(297,16,10,'Olivos'),(298,16,11,'Orquídeas'),(299,16,12,'Peñascal'),(300,16,13,'Rinconada'),(301,16,14,'Rodillal'),(302,16,15,'Sabanilla'),(303,16,16,'San Martín'),(304,16,17,'Santa Eduvigis'),(305,16,18,'Valverde.'),(306,16,19,'Alto Alumbre'),(307,16,20,'Hoyo'),(308,16,21,'Jericó'),(309,16,22,'Manzano'),(310,16,23,'Pacaya'),(311,16,24,'Roblar'),(312,16,25,'Ticalpes (parte)'),(313,16,26,'Calle Naranjos.'),(314,17,01,'Calabacitas'),(315,17,02,'Calle Común'),(316,17,03,'Cruz Roja'),(317,17,04,'Itaipú'),(318,17,05,'Máquinas'),(319,17,06,'Mota'),(320,17,07,'Novedades'),(321,17,08,'Pedrito Monge'),(322,17,09,'Río'),(323,17,10,'Robles.'),(324,18,01,'Alpino'),(325,18,02,'Arco Iris'),(326,18,03,'Bambú'),(327,18,04,'Berlay'),(328,18,05,'Guaria'),(329,18,06,'Huaso (parte)'),(330,18,07,'Juncales'),(331,18,08,'Lajas'),(332,18,09,'Macarena'),(333,18,10,'Maiquetía'),(334,18,11,'Méndez.'),(335,19,01,'Acacias'),(336,19,02,'Calle Amador'),(337,19,03,'Constancia'),(338,19,04,'Churuca'),(339,19,05,'Huetares'),(340,19,06,'Plazoleta'),(341,19,07,'Pueblo Nuevo'),(342,19,08,'Río Damas'),(343,19,09,'Rotondas'),(344,19,10,'Solar.'),(345,20,01,'Bajos de Tarrazú'),(346,20,02,'Bustamante'),(347,20,03,'Santa Elena (parte)'),(348,20,04,'Violeta.'),(349,21,01,'Aguacate'),(350,21,02,'Balneario'),(351,21,03,'Don Bosco'),(352,21,04,'Guatuso'),(353,21,05,'Güízaro'),(354,21,06,'Jerusalén'),(355,21,07,'Lince'),(356,21,08,'Mesas'),(357,21,09,'Quebrada Honda'),(358,21,10,'Ticalpes (parte).'),(359,22,01,'Empalme (parte)'),(360,22,02,'Lucha (parte)'),(361,22,03,'San Cristóbal Sur'),(362,22,04,'Sierra.'),(363,23,01,'Bajo Tigre'),(364,23,02,'Chirogres'),(365,23,03,'Guadarrama'),(366,23,04,'Joya'),(367,23,05,'La Fila (parte)'),(368,23,06,'Llano bonito'),(369,23,07,'Quebrada Honda'),(370,23,08,'Trinidad (parte).'),(371,24,01,'Cajita'),(372,24,02,'Dorado'),(373,24,03,'Dos Cercas'),(374,24,04,'Fomentera'),(375,24,05,'Nuestra Señora de la Esperanza'),(376,24,06,'San Lorenzo.'),(377,25,01,'Ángeles'),(378,25,02,'Autofores'),(379,25,03,'Balboa'),(380,25,04,'Coopelot'),(381,25,05,'Gardenia'),(382,25,06,'Higuerones'),(383,25,07,'Leo'),(384,25,08,'Mónaco'),(385,25,09,'Sagitario'),(386,25,10,'Santa Cecilia'),(387,25,11,'Tejar (parte)'),(388,25,12,'Treviso'),(389,25,13,'Unidas'),(390,25,14,'Valencia'),(391,25,15,'Vizcaya.'),(392,26,01,'Cartonera'),(393,26,02,'Claveles'),(394,26,03,'Damasco'),(395,26,04,'Diamante'),(396,26,05,'Esmeraldas'),(397,26,06,'Fortuna'),(398,26,07,'Fortunita'),(399,26,08,'Porvenir'),(400,26,09,'Raya'),(401,26,10,'Riberalta'),(402,26,11,'Villanueva.'),(403,27,01,'Letras'),(404,27,02,'Balcón Verde.'),(405,28,01,'Ángeles'),(406,28,00,'Bajo Badilla'),(407,28,02,'Bajo Moras'),(408,28,00,'Buenos Aires'),(409,28,03,'Cañales Abajo'),(410,28,00,'Corazón de María'),(411,28,04,'Cañales Arriba'),(412,28,00,'Jarasal'),(413,28,05,'Carit'),(414,28,00,'Junquillo Arriba'),(415,28,06,'Charcón (parte)'),(416,28,00,'Pueblo Nuevo'),(417,28,07,'Cirrí'),(418,28,00,'San Isidro.'),(419,28,08,'Junquillo Abajo'),(420,28,09,'Pozos'),(421,28,10,'San Francisco'),(422,28,11,'San Martín'),(423,28,12,'Zapote.'),(424,29,01,'Alto Palma'),(425,29,02,'Bajo Lanas'),(426,29,03,'Bajo Legua'),(427,29,04,'Bajo Legüita'),(428,29,05,'Bajo Quesada'),(429,29,06,'Bocana'),(430,29,07,'Carmona'),(431,29,08,'Cerbatana'),(432,29,09,'Charquillos'),(433,29,10,'Jilgueral'),(434,29,11,'Llano Grande'),(435,29,12,'Mercedes Norte'),(436,29,13,'Potenciana'),(437,29,14,'Quebrada Honda'),(438,29,15,'Quivel'),(439,29,16,'Rancho Largo'),(440,29,17,'Salitrales'),(441,29,18,'Santa Marta'),(442,29,19,'Túfares'),(443,29,20,'Tulín'),(444,29,21,'Víbora'),(445,29,22,'Zapotal.'),(446,30,01,'Alto Barbacoas'),(447,30,02,'Bajo Burgos'),(448,30,03,'Cortezal'),(449,30,04,'Guatuso'),(450,30,05,'Piedades'),(451,30,06,'San Juan.'),(452,31,01,'Cacao'),(453,31,02,'Cuesta Mora'),(454,31,03,'Grifo Bajo'),(455,31,04,'Poró'),(456,31,05,'Pueblo Nuevo'),(457,31,06,'Salitrillo.'),(458,32,01,'Bijagual'),(459,32,02,'Floralia'),(460,32,03,'Punta de Lanza'),(461,32,04,'San Rafael Abajo.'),(462,33,01,'Alto Cebadilla'),(463,33,02,'Bajo Chacones'),(464,33,03,'Copalar'),(465,33,04,'Pedernal'),(466,33,05,'Polca'),(467,33,06,'Sabanas.'),(468,34,01,'Bajo Guevara'),(469,34,02,'Planta'),(470,34,03,'Rinconada.'),(471,35,01,'Bajo Herrera'),(472,35,02,'Calle Herrera'),(473,35,03,'Cruce Guanacaste'),(474,35,04,'Charcón (parte)'),(475,35,05,'Estero'),(476,35,06,'Río Viejo'),(477,35,07,'Salitral'),(478,35,08,'Tinamaste.'),(479,36,01,'Alto Concepción'),(480,36,02,'Alto Pérez Astúa'),(481,36,03,'Ángeles'),(482,36,04,'Angostura (parte)'),(483,36,05,'Arenal'),(484,36,06,'Bajo Chires'),(485,36,07,'Bajo de Guarumal'),(486,36,08,'Bajo el Rey'),(487,36,09,'Bajo Vega'),(488,36,10,'Cerdas'),(489,36,11,'Fila Aguacate'),(490,36,12,'Gamalotillo 1 (Colonia)'),(491,36,13,'Gamalotillo 2 (Gamalotillo)'),(492,36,14,'Gamalotillo 3 (Tierra Fértil)'),(493,36,15,'Gloria'),(494,36,16,'Guarumal'),(495,36,17,'Guarumalito'),(496,36,18,'Mastatal'),(497,36,19,'Pericos'),(498,36,20,'Río Negro (parte)'),(499,36,21,'San Miguel'),(500,36,22,'San Vicente'),(501,36,23,'Santa Rosa'),(502,36,24,'Vista de Mar'),(503,36,25,'Zapatón.'),(504,37,01,'Corea'),(505,37,02,'I Griega'),(506,37,03,'Las Tres Marías'),(507,37,04,'Santa Cecilia'),(508,37,05,'Rodeo'),(509,37,06,'Sitio.'),(510,37,07,'Alto Pastora'),(511,37,08,'Bajo Canet'),(512,37,09,'Bajo San Juan'),(513,37,10,'Canet'),(514,37,11,'Cedral (parte)'),(515,37,12,'Guadalupe'),(516,37,13,'Llano Piedra'),(517,37,14,'San Cayetano'),(518,37,15,'San Guillermo'),(519,37,16,'Sabana (parte)'),(520,37,17,'San Pedro.'),(521,38,01,'Alto Guarumal'),(522,38,02,'Alto Portal'),(523,38,03,'Alto Zapotal'),(524,38,04,'Ardilla'),(525,38,05,'Bajo Quebrada Honda'),(526,38,06,'Bajo Reyes'),(527,38,07,'Bajo Zapotal'),(528,38,08,'Cerro Nara'),(529,38,09,'Concepción'),(530,38,10,'Chilamate'),(531,38,11,'Delicias'),(532,38,12,'Esperanza'),(533,38,13,'Esquipulas'),(534,38,14,'La Pacaya'),(535,38,15,'Las Pavas'),(536,38,16,'Mata de Caña'),(537,38,17,'Miramar'),(538,38,18,'Nápoles'),(539,38,19,'Naranjillo'),(540,38,20,'Palma'),(541,38,21,'Quebrada Arroyo'),(542,38,22,'Rodeo'),(543,38,23,'Sabana (parte)'),(544,38,24,'Salado'),(545,38,25,'San Bernardo'),(546,38,26,'San Francisco'),(547,38,27,'San Martín'),(548,38,28,'Santa Cecilia'),(549,38,29,'Santa Marta'),(550,38,30,'Santa Rosa'),(551,38,31,'Zapotal.'),(552,39,01,'Alto Chiral'),(553,39,02,'San Juan (Alto San Juan)'),(554,39,03,'Bajo Jénaro'),(555,39,04,'Bajo San José'),(556,39,05,'Jamaica'),(557,39,06,'Quebrada Seca (Santa Ana)'),(558,39,07,'San Jerónimo'),(559,39,08,'San Josecito.'),(560,40,01,'Guatuso'),(561,40,02,'Mirador.'),(562,40,03,'Alfonso XIII'),(563,40,04,'Barro'),(564,40,05,'Cinco Esquinas (parte)'),(565,40,06,'Corazón de Jesús'),(566,40,07,'Guapinol'),(567,40,08,'Las Mercedes'),(568,40,09,'Lomas de Aserrí'),(569,40,10,'Lourdes'),(570,40,11,'María Auxiliadora'),(571,40,12,'Mesas'),(572,40,13,'Poás'),(573,40,14,'Santa Rita'),(574,40,15,'Sáurez'),(575,40,16,'Tres Marías'),(576,40,17,'Vereda.'),(577,41,01,'Bajos de Praga'),(578,41,02,'Máquina Vieja'),(579,41,03,'Tigre.'),(580,42,01,'Calvario'),(581,42,02,'Ceiba Alta (parte)'),(582,42,03,'Jocotal'),(583,42,04,'Legua de Naranjo'),(584,42,05,'Mangos'),(585,42,06,'Meseta'),(586,42,07,'Monte Redondo'),(587,42,08,'Ojo de Agua'),(588,42,09,'Rosalía'),(589,42,10,'Uruca.'),(590,43,01,'La Fila (parte)'),(591,43,00,'Pueblo Nuevo.'),(592,43,02,'Limonal'),(593,43,03,'Los Solano'),(594,43,04,'Rancho Grande'),(595,43,05,'Salitral'),(596,43,06,'Tranquerillas'),(597,43,07,'Trinidad (parte)'),(598,43,08,'Villanueva.'),(599,44,01,'Alto Buenavista'),(600,44,02,'Altos del Aguacate'),(601,44,03,'Bajo Bijagual'),(602,44,04,'Bajo Máquinas'),(603,44,05,'Bajo Venegas (parte)'),(604,44,06,'Carmen (parte).'),(605,45,01,'Ojo de Agua (parte)'),(606,45,02,'Portuguez.'),(607,46,01,'Cinco Esquinas (parte)'),(608,46,02,'Santa Teresita.'),(609,46,03,'Cerro'),(610,46,04,'Cuesta Grande'),(611,46,05,'Guinealillo'),(612,46,06,'Huaso (parte)'),(613,46,07,'Lagunillas'),(614,46,08,'Palo Blanco'),(615,46,09,'Quebradas'),(616,46,10,'Rincón.'),(617,47,01,'Alhambra'),(618,47,00,'Cabriola'),(619,47,02,'Brasil'),(620,47,00,'Cedral'),(621,47,03,'Carreras'),(622,47,00,'Cuesta Achiotal'),(623,47,04,'Colonia del Prado'),(624,47,00,'Llano León'),(625,47,05,'Llano Limón'),(626,47,00,'Michoacán'),(627,47,06,'Nuevo Brasil'),(628,47,00,'Quebrada Honda'),(629,47,07,'Piñal'),(630,47,00,'Rodeo'),(631,47,08,'San Bosco'),(632,47,00,'Santísima Trinidad'),(633,47,09,'San Vicente'),(634,47,00,'Ticufres.'),(635,47,10,'Tablera.'),(636,48,01,'Bajo Claras'),(637,48,02,'Bajo Morado'),(638,48,03,'Corrogres'),(639,48,04,'Monte Negro.'),(640,49,01,'Bajo Bustamante'),(641,49,02,'Bajo Lima'),(642,49,03,'Bajo Loaiza'),(643,49,04,'Cañas'),(644,49,05,'Corralar'),(645,49,06,'Morado'),(646,49,07,'Piedras Blancas'),(647,49,08,'Salto.'),(648,50,01,'Chile'),(649,50,02,'Danta'),(650,50,03,'Palma'),(651,50,04,'Quebrada Grande.'),(652,51,01,'Cordel'),(653,51,02,'Chucás'),(654,51,03,'Jateo'),(655,51,04,'Llano Grande'),(656,51,05,'Monte Frío (Potrerillos).'),(657,52,01,'Pito.'),(658,53,01,'San Juan'),(659,53,02,'San Martín'),(660,53,03,'Quebrada Honda.'),(661,54,01,'Árboles'),(662,54,02,'Colonia del Río'),(663,54,03,'El Alto (parte)'),(664,54,04,'Fátima'),(665,54,05,'Independencia'),(666,54,06,'Jardín'),(667,54,07,'Magnolia'),(668,54,08,'Maravilla'),(669,54,09,'Margarita'),(670,54,10,'Minerva'),(671,54,11,'Moreno Cañas'),(672,54,12,'Orquídea'),(673,54,13,'Pilar Jiménez'),(674,54,14,'Rothe'),(675,54,15,'San Gerardo'),(676,54,16,'Santa Cecilia'),(677,54,17,'Santa Eduvigis'),(678,54,18,'Santo Cristo'),(679,54,19,'Unión'),(680,54,20,'Yurusti.'),(681,55,01,'Carlos María Ulloa'),(682,55,02,'San Francisco (centro)'),(683,55,03,'Tournón.'),(684,56,01,'Calle Blancos (centro)'),(685,56,02,'Ciprés'),(686,56,03,'Encanto'),(687,56,04,'Esquivel Bonilla'),(688,56,05,'Montelimar'),(689,56,06,'Pinos'),(690,56,07,'San Antonio'),(691,56,08,'San Gabriel'),(692,56,09,'Santo Tomás'),(693,56,10,'Volio.'),(694,57,01,'Bruncas'),(695,57,02,'Carmen'),(696,57,03,'Claraval'),(697,57,04,'Cruz'),(698,57,05,'Cuesta Grande (parte)'),(699,57,06,'Estéfana (parte)'),(700,57,07,'Hortensias'),(701,57,08,'Jaboncillal'),(702,57,09,'Jardines de la Paz'),(703,57,10,'Lourdes'),(704,57,11,'Praderas'),(705,57,12,'Tepeyac'),(706,57,13,'Térraba'),(707,57,14,'Villalta'),(708,57,15,'Villaverde'),(709,57,16,'Vista del Valle.'),(710,58,01,'Ángeles'),(711,58,02,'El Alto (parte)'),(712,58,03,'Floresta'),(713,58,04,'Korobó'),(714,58,05,'La Mora'),(715,58,06,'Morita'),(716,58,07,'Mozotal'),(717,58,08,'Nazareno'),(718,58,09,'Orquídea'),(719,58,10,'Rodrigo Facio'),(720,58,11,'Santa Clara (parte)'),(721,58,12,'Setillal'),(722,58,13,'Vista del Monte.'),(723,59,01,'Mirador.'),(724,59,02,'Corralillo'),(725,59,03,'Guayabillos'),(726,59,04,'Isla'),(727,59,05,'San Miguel'),(728,59,00,'Vista de Mar.'),(729,60,01,'Ana Frank'),(730,60,02,'Castores'),(731,60,03,'Cuadros'),(732,60,04,'Don Carlos'),(733,60,05,'El Alto (parte)'),(734,60,06,'Flor de Liz'),(735,60,07,'Kurú'),(736,60,08,'Lomas de Tepeyac'),(737,60,09,'Lupita'),(738,60,10,'Montesol'),(739,60,11,'Nogales'),(740,60,12,'Pueblo'),(741,60,13,'Violetas.'),(742,61,01,'Aguas Lindas'),(743,61,02,'Cabañas'),(744,61,03,'Casa Blanca'),(745,61,04,'Lajas (parte)'),(746,61,05,'Obando'),(747,61,06,'Paso Machete (parte)'),(748,61,07,'San Rafael.'),(749,61,08,'Corrogres'),(750,61,09,'Pilas.'),(751,62,01,'Paso Machete (parte)'),(752,62,02,'Robalillo.'),(753,62,03,'Alto Raicero'),(754,62,04,'Chirracal'),(755,62,05,'Matinilla'),(756,62,06,'Pabellón'),(757,62,07,'Perico.'),(758,63,01,'Alto Palomas'),(759,63,02,'Concepción'),(760,63,03,'Cuevas'),(761,63,04,'Chispa'),(762,63,05,'Gavilanes'),(763,63,06,'Honduras'),(764,63,07,'Lajas (parte)'),(765,63,08,'Lindora'),(766,63,09,'Manantial'),(767,63,10,'Real de Pereira (parte)'),(768,63,11,'Valle del sol.'),(769,64,01,'Chimba'),(770,64,02,'Guapinol'),(771,64,03,'Mata Grande'),(772,64,04,'Mina'),(773,64,05,'Paso Machete (parte)'),(774,64,06,'Río Uruca.'),(775,65,01,'Caraña'),(776,65,02,'Cebadilla'),(777,65,03,'Finquitas'),(778,65,04,'Montaña del Sol'),(779,65,05,'Rincón San Marcos'),(780,65,06,'Triunfo.'),(781,66,01,'Canjel'),(782,66,02,'Copey.'),(783,67,01,'Bellavista'),(784,67,02,'Chorotega'),(785,67,03,'Lagunilla'),(786,67,04,'Macha'),(787,67,05,'Madrigal.'),(788,68,01,'Aguilar Machado'),(789,68,02,'Cochea'),(790,68,03,'El Alto'),(791,68,04,'Faro del Suroeste'),(792,68,05,'Filtros'),(793,68,06,'Pueblo Escondido'),(794,68,07,'Vistas de Alajuelita.'),(795,69,01,'Caracas'),(796,69,02,'Cascabela'),(797,69,03,'Llano'),(798,69,04,'Piedra de fuego.'),(799,69,05,'Lámparas.'),(800,70,01,'Almendros'),(801,70,02,'Boca del Monte'),(802,70,03,'Chirivico'),(803,70,04,'Monte Alto'),(804,70,05,'Once de Abril'),(805,70,06,'Progreso'),(806,70,07,'Tejar (parte)'),(807,70,08,'Vista de San José'),(808,70,09,'Vista Real.'),(809,71,01,'Aurora'),(810,71,02,'Corina Rodríguez'),(811,71,03,'Esquipulas Dos'),(812,71,04,'La Guápil'),(813,71,05,'Peralta'),(814,71,06,'Verbena.'),(815,71,07,'Palo Campano.'),(816,72,01,'Alamos'),(817,72,02,'Alpes'),(818,72,03,'Arias'),(819,72,04,'Brisa'),(820,72,05,'Cedros'),(821,72,06,'Corazón de Jesús'),(822,72,07,'Durazno'),(823,72,08,'Girasoles (parte)'),(824,72,09,'Huacas'),(825,72,10,'Magnolias'),(826,72,11,'Mercedes'),(827,72,12,'Monte Azul'),(828,72,13,'San Francisco'),(829,72,14,'San Martín'),(830,72,15,'Villa Solidarista.'),(831,73,01,'Fanguillo'),(832,73,02,'I Griega'),(833,73,03,'Loma Bonita'),(834,73,04,'Nubes'),(835,73,05,'Patio de Agua'),(836,73,06,'Villa Emaus.'),(837,74,01,'Calera'),(838,74,02,'Carmen'),(839,74,03,'Gemelas'),(840,74,04,'Josué'),(841,74,05,'Manzanos'),(842,74,06,'Murtal'),(843,74,07,'Sitrae'),(844,74,08,'Valle Felíz.'),(845,74,09,'Alto Palma (parte)'),(846,74,10,'Platanares'),(847,74,11,'Rodeo (parte).'),(848,75,01,'Cornelia'),(849,75,02,'Girasoles (parte)'),(850,75,03,'Horizontes'),(851,75,04,'Irazú'),(852,75,05,'Jardines'),(853,75,06,'Labrador'),(854,75,07,'Patalillo'),(855,75,08,'Santa Marta'),(856,75,09,'Trapiche'),(857,75,10,'Villalinda'),(858,75,11,'Villanova.'),(859,76,01,'Avilés'),(860,76,02,'Cerro Indio'),(861,76,03,'Guaba'),(862,76,04,'Rojizo'),(863,76,05,'Sinaí.'),(864,76,06,'Canoa'),(865,76,07,'Cascajal'),(866,76,08,'Choco'),(867,76,09,'Isla'),(868,76,10,'Monserrat'),(869,76,11,'Patillos'),(870,76,12,'Rodeo (parte)'),(871,76,13,'Santa Rita de Casia'),(872,76,14,'Tierras Morenas'),(873,76,15,'Vegas de Cajón'),(874,76,16,'Venita.'),(875,77,01,'Abarca'),(876,77,02,'Corral'),(877,77,03,'María Auxiliadora'),(878,77,04,'Ortiga'),(879,77,05,'Pozos'),(880,77,06,'San Martín (San Gerardo)'),(881,77,07,'San Luis'),(882,77,08,'Turrujal'),(883,77,09,'Vereda.'),(884,77,10,'Aguablanca (parte)'),(885,77,11,'Alto Escalera'),(886,77,12,'Alto Los Mora'),(887,77,13,'Ángeles'),(888,77,14,'Chirraca (parte)'),(889,77,15,'Esperanza'),(890,77,16,'Potrerillos'),(891,77,17,'Resbalón'),(892,77,18,'Tablazo.'),(893,78,01,'Alto Sierra'),(894,78,02,'Alto Vigía'),(895,78,03,'Bajo Arias'),(896,78,04,'Bajo Bermúdez'),(897,78,05,'Bajo Calvo'),(898,78,06,'Bajo Cárdenas'),(899,78,07,'Bajo Moras'),(900,78,08,'Coyolar'),(901,78,09,'Hondonada'),(902,78,10,'La Cruz'),(903,78,11,'Lagunillas (parte)'),(904,78,12,'Ococa'),(905,78,13,'Toledo'),(906,78,14,'Zapote.'),(907,79,01,'San Pablo'),(908,79,02,'Agua Blanca (parte)'),(909,79,03,'Bajo Cerdas'),(910,79,04,'Bajos de Jorco'),(911,79,05,'Bolívar'),(912,79,06,'Cañadas'),(913,79,07,'Caragral'),(914,79,08,'Corazón de Jesús'),(915,79,09,'Charcalillo'),(916,79,10,'Chirraca (parte)'),(917,79,11,'Fila'),(918,79,12,'Jaular'),(919,79,13,'Lagunillas (parte)'),(920,79,14,'La Mina'),(921,79,15,'La Pita'),(922,79,16,'Los Monge'),(923,79,17,'Playa'),(924,79,18,'San Pablo'),(925,79,19,'Sevilla.'),(926,80,01,'Bajo Los Cruces'),(927,80,02,'Ceiba Alta (parte)'),(928,80,03,'Ceiba Baja'),(929,80,04,'Ceiba Este'),(930,80,05,'Escuadra'),(931,80,06,'Gravilias'),(932,80,07,'Lindavista'),(933,80,08,'Llano Bonito'),(934,80,09,'Mesa'),(935,80,10,'Naranjal'),(936,80,11,'Perpetuo Socorro'),(937,80,12,'Tejar'),(938,80,13,'Tiquires.'),(939,81,01,'Alto Parritón'),(940,81,02,'Bajo Palma'),(941,81,03,'Bajo Pérez'),(942,81,04,'Bijagual'),(943,81,05,'Breñón'),(944,81,06,'Caspirola'),(945,81,07,'Colorado'),(946,81,08,'Cuesta Aguacate'),(947,81,09,'Limas'),(948,81,10,'Parritón'),(949,81,11,'Plomo'),(950,81,12,'Sabanas'),(951,81,13,'San Jerónimo'),(952,81,14,'Soledad'),(953,81,15,'Téruel'),(954,81,16,'Tiquiritos'),(955,81,17,'Uruca'),(956,81,18,'Zoncuano.'),(957,82,01,'Acacias'),(958,82,02,'Arboleda'),(959,82,03,'Asturias'),(960,82,04,'Estudiantes'),(961,82,05,'Florida'),(962,82,06,'González Truque'),(963,82,07,'Jesús Jiménez Zamora'),(964,82,08,'Lindavista'),(965,82,09,'Rosas'),(966,82,10,'San Jerónimo'),(967,82,11,'Santa Eduvigis'),(968,82,12,'Valle'),(969,82,13,'Versalles'),(970,82,14,'Villafranca'),(971,82,15,'Virginia.'),(972,83,01,'Bajo Piuses'),(973,83,02,'Copey'),(974,83,03,'Leiva Urcuyo'),(975,83,04,'Lilas'),(976,83,05,'Lomas del Pinar'),(977,83,06,'Montecarlo'),(978,83,07,'Santa Teresa.'),(979,84,01,'Apolo'),(980,84,02,'Dalia'),(981,84,03,'Estancia'),(982,84,04,'Fletcher'),(983,84,05,'Franjo'),(984,84,06,'Jardines de Tibás'),(985,84,07,'Jardines La Trinidad'),(986,84,08,'Monterreal'),(987,84,09,'Palmeras'),(988,84,10,'Santa Mónica'),(989,84,11,'Talamanca'),(990,84,12,'Vergel.'),(991,85,01,'Doña Fabiola'),(992,85,02,'Garabito.'),(993,86,01,'Anselmo Alvarado'),(994,86,02,'Balsa'),(995,86,03,'Cuatro Reinas'),(996,86,04,'Orquídeas'),(997,86,05,'Rey'),(998,86,06,'San Agustín.'),(999,87,01,'Alondra'),(1000,87,02,'Americano'),(1001,87,03,'Américas'),(1002,87,04,'Bajo Isla'),(1003,87,05,'Bajo Varelas'),(1004,87,06,'Barro de Olla'),(1005,87,07,'Caragua'),(1006,87,08,'Carmen'),(1007,87,09,'Colegios'),(1008,87,10,'Colegios Norte'),(1009,87,11,'Chaves'),(1010,87,12,'El Alto (parte)'),(1011,87,13,'Flor'),(1012,87,14,'Florencia'),(1013,87,15,'Guaria'),(1014,87,16,'Guaria Oriental'),(1015,87,17,'Isla'),(1016,87,18,'Jardines de Moravia'),(1017,87,19,'La Casa'),(1018,87,20,'Ladrillera'),(1019,87,21,'Robles'),(1020,87,22,'Romeral'),(1021,87,23,'Sagrado Corazón'),(1022,87,24,'San Blas'),(1023,87,25,'San Jorge'),(1024,87,26,'San Martín'),(1025,87,27,'San Rafael'),(1026,87,28,'Santa Clara (parte)'),(1027,87,29,'Santo Tomás'),(1028,87,30,'Saprissa.'),(1029,88,01,'Alto Palma (parte)'),(1030,88,02,'Platanares'),(1031,88,03,'Tornillal'),(1032,88,04,'Torre.'),(1033,89,01,'Altos de Trinidad'),(1034,89,02,'Cipreses'),(1035,89,03,'Colonia'),(1036,89,04,'Moral'),(1037,89,05,'Níspero'),(1038,89,06,'Rosal'),(1039,89,07,'Ruano'),(1040,89,08,'Sitios'),(1041,89,09,'Tanques'),(1042,89,10,'Virilla.'),(1043,90,01,'Alhambra'),(1044,90,02,'Azáleas'),(1045,90,03,'Carmiol'),(1046,90,04,'Cedral'),(1047,90,05,'Dent (parte)'),(1048,90,06,'Francisco Peralta (parte)'),(1049,90,07,'Fuentes'),(1050,90,08,'Granja'),(1051,90,09,'Kezia'),(1052,90,10,'Lourdes'),(1053,90,11,'Monterrey'),(1054,90,12,'Nadori'),(1055,90,13,'Oriente'),(1056,90,14,'Pinto'),(1057,90,15,'Prados del Este'),(1058,90,16,'Roosevelt'),(1059,90,17,'San Gerardo (parte)'),(1060,90,18,'Santa Marta'),(1061,90,19,'Saprissa'),(1062,90,20,'Vargas Araya'),(1063,90,21,'Yoses.'),(1064,91,01,'Arboleda'),(1065,91,02,'Bloquera'),(1066,91,03,'Cedros'),(1067,91,04,'El Cristo (parte)'),(1068,91,05,'Españolita'),(1069,91,06,'Luciana'),(1070,91,07,'Marsella'),(1071,91,08,'Maravilla'),(1072,91,09,'Rodeo'),(1073,91,10,'Rosales'),(1074,91,11,'San Marino.'),(1075,92,01,'Alma Máter'),(1076,92,02,'Damiana'),(1077,92,03,'Dent (parte)'),(1078,92,04,'Guaymí'),(1079,92,05,'Paso Hondo'),(1080,92,06,'Paulina.'),(1081,93,01,'Alameda'),(1082,93,02,'Andrómeda'),(1083,93,03,'Begonia'),(1084,93,04,'Cuesta Grande (parte)'),(1085,93,05,'El Cristo (parte)'),(1086,93,06,'Estéfana (parte)'),(1087,93,07,'Europa'),(1088,93,08,'Liburgia'),(1089,93,09,'Mansiones (parte)'),(1090,93,10,'Maruz'),(1091,93,11,'Salitrillos.'),(1092,94,01,'Alto Poró'),(1093,94,02,'Bolsón'),(1094,94,03,'Purires.'),(1095,95,01,'Alto Limón'),(1096,95,02,'Florecilla'),(1097,95,03,'Limón'),(1098,95,04,'Palmar'),(1099,95,05,'Pita Villa Colina.'),(1100,96,01,'Bajo Laguna'),(1101,96,02,'El Barro'),(1102,96,03,'Llano Bonito (San Juan de Mata)'),(1103,96,04,'Molenillo'),(1104,96,05,'Paso Agres'),(1105,96,06,'Surtubal'),(1106,96,07,'Tronco Negro.'),(1107,97,01,'Pital'),(1108,97,02,'Potenciana Arriba'),(1109,97,03,'Quebrada Azul'),(1110,97,04,'San Francisco'),(1111,97,05,'San Rafael.'),(1112,98,01,'Alto Espavel'),(1113,98,02,'Angostura (parte)'),(1114,98,03,'Bijagualito'),(1115,98,04,'Bola'),(1116,98,05,'Carara'),(1117,98,06,'Cima'),(1118,98,07,'Delicias'),(1119,98,08,'El Sur'),(1120,98,09,'Esperanza'),(1121,98,10,'Fila Negra'),(1122,98,11,'Galán'),(1123,98,12,'La Trampa'),(1124,98,13,'Lajas'),(1125,98,14,'Mata de Platano'),(1126,98,15,'Montelimar'),(1127,98,16,'Pacayal'),(1128,98,17,'Pavona'),(1129,98,18,'Quina'),(1130,98,19,'Río Negro'),(1131,98,20,'Río Seco'),(1132,98,21,'San Francísco'),(1133,98,22,'San Gabriel'),(1134,98,23,'San Isidro'),(1135,98,24,'San Jerónimo'),(1136,98,25,'Tulín.'),(1137,99,01,'Bandera'),(1138,99,02,'Higueronal'),(1139,99,03,'Llano'),(1140,99,04,'Nubes'),(1141,99,05,'San Rafael.'),(1142,99,06,'Botella'),(1143,99,07,'Cedral'),(1144,99,08,'Guaria'),(1145,99,09,'Naranjo'),(1146,99,10,'Quebrada Grande (parte)'),(1147,99,11,'Reyes'),(1148,99,12,'San Joaquín'),(1149,99,13,'San Lucas'),(1150,99,14,'Sukia'),(1151,99,15,'Vapor.'),(1152,100,01,'Cabeceras de Tarrazú'),(1153,100,02,'Chonta (parte)'),(1154,100,03,'Quebradillas.'),(1155,101,01,'Bernardo Ureña.'),(1156,101,02,'Alto Cañazo'),(1157,101,03,'Alto indio'),(1158,101,04,'Alto Miramar'),(1159,101,05,'Cañón (parte)'),(1160,101,06,'Cima'),(1161,101,07,'Cruce Chinchilla'),(1162,101,08,'Florida'),(1163,101,09,'Garrafa'),(1164,101,10,'Jaboncillo'),(1165,101,11,'Madreselva'),(1166,101,12,'Ojo de Agua (parte)'),(1167,101,13,'Paso Macho (parte)'),(1168,101,14,'Pedregoso'),(1169,101,15,'Providencia'),(1170,101,16,'Quebrada Grande (parte)'),(1171,101,17,'Quebrador'),(1172,101,18,'Río Blanco'),(1173,101,19,'Salsipuedes (parte)'),(1174,101,20,'San Carlos'),(1175,101,21,'San Gerardo'),(1176,101,22,'Trinidad'),(1177,101,23,'Vueltas.'),(1178,102,01,'Ahogados (parte)'),(1179,102,02,'Aromático'),(1180,102,03,'Cipreses'),(1181,102,04,'Chapultepec'),(1182,102,05,'Dorados'),(1183,102,06,'Guayabos'),(1184,102,07,'Hacienda Vieja'),(1185,102,08,'Hogar'),(1186,102,09,'José María Zeledón'),(1187,102,10,'Laguna'),(1188,102,11,'La Lía'),(1189,102,12,'Mallorca'),(1190,102,13,'María Auxiliadora'),(1191,102,14,'Miramontes'),(1192,102,15,'Nopalera'),(1193,102,16,'Plaza del Sol'),(1194,102,17,'Prado'),(1195,102,18,'San José'),(1196,102,19,'Santa Cecilia'),(1197,102,20,'Tacaco.'),(1198,103,01,'Biarquiria'),(1199,103,02,'Eucalipto'),(1200,103,03,'Freses'),(1201,103,04,'Granadilla Norte'),(1202,103,05,'Granadilla Sur'),(1203,103,06,'Montaña Rusa (parte).'),(1204,104,01,'Araucauria (parte)'),(1205,104,02,'Lomas de Ayarco'),(1206,104,03,'Pinares.'),(1207,105,01,'Colina'),(1208,105,02,'Lomas de San Pancracio'),(1209,105,03,'Ponderosa'),(1210,105,04,'Quince de Agosto.'),(1211,106,01,'Aeropuerto'),(1212,106,02,'Alto Alonso'),(1213,106,03,'Boruca'),(1214,106,04,'Boston'),(1215,106,05,'Cementerio'),(1216,106,06,'Cooperativa'),(1217,106,07,'Cristo Rey'),(1218,106,08,'Doce de Marzo'),(1219,106,09,'Dorotea'),(1220,106,10,'Durán Picado'),(1221,106,11,'España'),(1222,106,12,'Estadio'),(1223,106,13,'Evans Gordon Wilson'),(1224,106,14,'González'),(1225,106,15,'Hospital'),(1226,106,16,'Hoyón'),(1227,106,17,'I Griega'),(1228,106,18,'Las Américas'),(1229,106,19,'Lomas de Cocorí'),(1230,106,20,'Luis Monge'),(1231,106,21,'Morazán'),(1232,106,22,'Pavones'),(1233,106,23,'Pedregoso'),(1234,106,24,'Pocito'),(1235,106,25,'Prado'),(1236,106,26,'Romero'),(1237,106,27,'Sagrada Familia'),(1238,106,28,'San Andrés'),(1239,106,29,'San Luis'),(1240,106,30,'San Rafael Sur'),(1241,106,31,'San Vicente'),(1242,106,32,'Santa Cecilia'),(1243,106,33,'Sinaí'),(1244,106,34,'Tierra Prometida'),(1245,106,35,'Tormenta'),(1246,106,36,'Unesco'),(1247,106,37,'Valverde.'),(1248,106,38,'Alto Ceibo'),(1249,106,39,'Alto Huacas'),(1250,106,40,'Alto Sajaral'),(1251,106,41,'Alto San Juan'),(1252,106,42,'Alto Tumbas'),(1253,106,43,'Angostura'),(1254,106,44,'Bajo Ceibo'),(1255,106,45,'Bajo Esperanzas'),(1256,106,46,'Bajo Mora'),(1257,106,47,'Bijaguales'),(1258,106,48,'Bocana'),(1259,106,49,'Bonita'),(1260,106,50,'Ceibo'),(1261,106,51,'Ceniza'),(1262,106,52,'Dorado'),(1263,106,53,'Esperanzas'),(1264,106,54,'Guadalupe'),(1265,106,55,'Guaria'),(1266,106,56,'Higuerones'),(1267,106,57,'Jilguero'),(1268,106,58,'Jilguero Sur'),(1269,106,59,'Los Guayabos'),(1270,106,60,'María Auxiliadora'),(1271,106,61,'Miravalles'),(1272,106,62,'Morete'),(1273,106,63,'Ojo de Agua'),(1274,106,64,'Ocho de Diciembre'),(1275,106,65,'Pacuarito'),(1276,106,66,'Palma'),(1277,106,67,'Paso Beita'),(1278,106,68,'Paso Lagarto'),(1279,106,69,'Quebrada Honda (parte)'),(1280,106,70,'Quebrada Vueltas'),(1281,106,71,'Quebradas'),(1282,106,72,'Roble'),(1283,106,73,'Rosario'),(1284,106,74,'San Agustín'),(1285,106,75,'San Jorge'),(1286,106,76,'San Juan de Miramar'),(1287,106,77,'San Lorenzo'),(1288,106,78,'San Rafael Norte'),(1289,106,79,'Santa Fé'),(1290,106,80,'Santa Marta'),(1291,106,81,'Suiza (parte)'),(1292,106,82,'Tajo'),(1293,106,83,'Toledo'),(1294,106,84,'Tronconales'),(1295,106,85,'Tuis'),(1296,106,86,'Villanueva.'),(1297,107,01,'Arepa'),(1298,107,02,'Carmen'),(1299,107,03,'Chanchos'),(1300,107,04,'Hermosa'),(1301,107,05,'Linda'),(1302,107,06,'Linda Arriba'),(1303,107,07,'Miraflores'),(1304,107,08,'Paraíso de la Tierra'),(1305,107,09,'Peñas Blancas'),(1306,107,10,'Quizarrá (parte)'),(1307,107,11,'San Blas'),(1308,107,12,'San Luis'),(1309,107,13,'Santa Cruz'),(1310,107,14,'Santa Elena'),(1311,107,15,'Trinidad.'),(1312,108,01,'Alto Brisas'),(1313,108,02,'Ángeles'),(1314,108,03,'Aurora'),(1315,108,04,'Chiles'),(1316,108,05,'Crematorio'),(1317,108,06,'Daniel Flores'),(1318,108,07,'Laboratorio'),(1319,108,08,'Los Pinos'),(1320,108,09,'Loma Verde'),(1321,108,10,'Lourdes'),(1322,108,11,'Rosas'),(1323,108,12,'Rosa Iris'),(1324,108,13,'San Francisco'),(1325,108,14,'Santa Margarita'),(1326,108,15,'Trocha'),(1327,108,16,'Villa Ligia.'),(1328,108,17,'Aguas Buenas (parte)'),(1329,108,18,'Bajos de Pacuar'),(1330,108,19,'Concepción (parte)'),(1331,108,20,'Corazón de Jesús'),(1332,108,21,'Juntas de Pacuar'),(1333,108,22,'Paso Bote'),(1334,108,23,'Patio de Agua'),(1335,108,24,'Peje'),(1336,108,25,'Percal'),(1337,108,26,'Pinar del Río'),(1338,108,27,'Quebrada Honda (parte)'),(1339,108,28,'Repunta'),(1340,108,29,'Reyes'),(1341,108,30,'Ribera'),(1342,108,31,'Suiza (parte).'),(1343,109,01,'Linda Vista'),(1344,109,02,'Lourdes.'),(1345,109,03,'Alaska'),(1346,109,04,'Altamira'),(1347,109,05,'Alto Jaular'),(1348,109,06,'Ángeles'),(1349,109,07,'Boquete'),(1350,109,08,'Buenavista'),(1351,109,09,'Canaán'),(1352,109,10,'Chimirol'),(1353,109,11,'Chispa'),(1354,109,12,'Chuma'),(1355,109,13,'División (parte)'),(1356,109,14,'Guadalupe'),(1357,109,15,'Herradura'),(1358,109,16,'La Bambú'),(1359,109,17,'Los Monges'),(1360,109,18,'Monterrey'),(1361,109,19,'Palmital'),(1362,109,20,'Piedra Alta'),(1363,109,21,'Playa Quesada'),(1364,109,22,'Playas'),(1365,109,23,'Pueblo Nuevo'),(1366,109,24,'Río Blanco'),(1367,109,25,'San Antonio'),(1368,109,26,'San Gerardo'),(1369,109,27,'San José'),(1370,109,28,'San Juan Norte'),(1371,109,29,'Siberia (parte)'),(1372,109,30,'Tirrá'),(1373,109,31,'Zapotal.'),(1374,110,01,'Cruz Roja.'),(1375,110,02,'Arenilla (Junta)'),(1376,110,03,'Alto Calderón'),(1377,110,04,'Cedral (parte)'),(1378,110,05,'Fátima'),(1379,110,06,'Fortuna'),(1380,110,07,'Guaria'),(1381,110,08,'Laguna'),(1382,110,09,'Rinconada Vega'),(1383,110,10,'San Jerónimo'),(1384,110,11,'San Juan'),(1385,110,12,'San Juancito'),(1386,110,13,'San Rafael'),(1387,110,14,'Santa Ana'),(1388,110,15,'Santo Domingo'),(1389,110,16,'Tambor'),(1390,110,17,'Unión'),(1391,110,18,'Zapotal.'),(1392,111,01,'Aguas Buenas (parte)'),(1393,111,02,'Bajo Bonitas'),(1394,111,03,'Bajo Espinoza'),(1395,111,04,'Bolivia'),(1396,111,05,'Bonitas'),(1397,111,06,'Buenos Aires'),(1398,111,07,'Concepción (parte)'),(1399,111,08,'Cristo Rey'),(1400,111,09,'La Sierra'),(1401,111,10,'Lourdes'),(1402,111,11,'Mastatal'),(1403,111,12,'Mollejoncito'),(1404,111,13,'Mollejones'),(1405,111,14,'Naranjos'),(1406,111,15,'Oratorio'),(1407,111,16,'San Carlos'),(1408,111,17,'San Pablito'),(1409,111,18,'San Pablo'),(1410,111,19,'San Roque (parte)'),(1411,111,20,'Socorro'),(1412,111,21,'Surtubal (parte)'),(1413,111,22,'Villa Argentina'),(1414,111,23,'Villa Flor'),(1415,111,24,'Vista de Mar.'),(1416,112,01,'Achiotal'),(1417,112,02,'Aguila'),(1418,112,03,'Alto Trinidad (Puñal)'),(1419,112,04,'Bajo Caliente'),(1420,112,05,'Bajo Minas'),(1421,112,06,'Barrionuevo'),(1422,112,07,'Bellavista'),(1423,112,08,'Calientillo'),(1424,112,09,'Corralillo'),(1425,112,10,'China Kichá'),(1426,112,11,'Delicias'),(1427,112,12,'Desamparados'),(1428,112,13,'El Progreso'),(1429,112,14,'Gibre'),(1430,112,15,'Guadalupe'),(1431,112,16,'Las Cruces'),(1432,112,17,'Mesas'),(1433,112,18,'Minas'),(1434,112,19,'Montezuma'),(1435,112,20,'Paraiso'),(1436,112,21,'San Antonio'),(1437,112,22,'San Gabriel'),(1438,112,23,'San Marcos'),(1439,112,24,'San Martín'),(1440,112,25,'San Miguel'),(1441,112,26,'San Roque (parte)'),(1442,112,27,'Santa Cecilia'),(1443,112,28,'Santa Fe'),(1444,112,29,'Santa Luisa'),(1445,112,30,'Surtubal (parte)'),(1446,112,31,'Trinidad'),(1447,112,32,'Veracruz'),(1448,112,33,'Zapote.'),(1449,113,01,'Cedral (parte)'),(1450,113,02,'El Quemado'),(1451,113,03,'Gloria'),(1452,113,04,'Las Brisas'),(1453,113,05,'Las Vegas'),(1454,113,06,'Mercedes'),(1455,113,07,'Montecarlo'),(1456,113,08,'Navajuelar'),(1457,113,09,'Nubes'),(1458,113,10,'Paraíso'),(1459,113,11,'Pilar'),(1460,113,12,'Pueblo Nuevo'),(1461,113,13,'Quizarrá (parte)'),(1462,113,14,'Salitrales'),(1463,113,15,'San Francisco'),(1464,113,16,'San Ignacio'),(1465,113,17,'San Pedrito'),(1466,113,18,'Santa María'),(1467,113,19,'Santa Teresa.'),(1468,114,01,'Alfombra'),(1469,114,02,'Alto Perla'),(1470,114,03,'Bajos'),(1471,114,04,'Bajos de Zapotal'),(1472,114,05,'Barú'),(1473,114,06,'Barucito'),(1474,114,07,'Cacao'),(1475,114,08,'Camarones'),(1476,114,09,'Cañablanca'),(1477,114,10,'Ceiba'),(1478,114,11,'Chontales'),(1479,114,12,'Farallas'),(1480,114,13,'Florida'),(1481,114,14,'San Juan de Dios (Guabo)'),(1482,114,15,'Líbano'),(1483,114,16,'Magnolia'),(1484,114,17,'Pozos'),(1485,114,18,'Reina'),(1486,114,19,'San Marcos'),(1487,114,20,'San Salvador'),(1488,114,21,'Santa Juana'),(1489,114,22,'Santo Cristo'),(1490,114,23,'Tinamaste (San Cristobal)'),(1491,114,24,'Torito'),(1492,114,25,'Tres Piedras (parte)'),(1493,114,26,'Tumbas'),(1494,114,27,'Villabonita Vista Mar.'),(1495,115,01,'Alto Mena'),(1496,115,02,'Brujo'),(1497,115,03,'Calle Los Mora'),(1498,115,04,'Chiricano'),(1499,115,05,'Gloria'),(1500,115,06,'Loma Guacal'),(1501,115,07,'Llano'),(1502,115,08,'Paraíso'),(1503,115,09,'Providencia (Parte)'),(1504,115,10,'Purruja'),(1505,115,11,'Río Nuevo'),(1506,115,12,'San Antonio'),(1507,115,13,'Santa Marta'),(1508,115,14,'Savegre Abajo'),(1509,115,15,'Viento Fresco.'),(1510,116,01,'Alto Macho Mora'),(1511,116,02,'Ángeles'),(1512,116,03,'Berlín'),(1513,116,04,'Chanchera'),(1514,116,05,'División (parte)'),(1515,116,06,'Fortuna'),(1516,116,07,'Hortensia'),(1517,116,08,'La Ese'),(1518,116,09,'La Piedra'),(1519,116,10,'Lira'),(1520,116,11,'Matasanos'),(1521,116,12,'Palma'),(1522,116,13,'Pedregosito'),(1523,116,14,'Providencia (Parte)'),(1524,116,15,'San Ramón Norte'),(1525,116,16,'Santa Eduvigis'),(1526,116,17,'Santo Tomás'),(1527,116,18,'Siberia (parte)'),(1528,116,19,'Valencia.'),(1529,117,01,'Estadio'),(1530,117,02,'La Clara'),(1531,117,03,'La Virgen'),(1532,117,04,'Los Ángeles'),(1533,117,05,'Sagrada Familia.'),(1534,117,06,'Abejonal'),(1535,117,07,'Carrizales'),(1536,117,08,'Los Navarro'),(1537,117,09,'Montes de Oro'),(1538,117,10,'Rosario.'),(1539,118,01,'Angostura (parte)'),(1540,118,02,'Bajo Gamboa'),(1541,118,03,'Higuerón'),(1542,118,04,'Llano Grande'),(1543,118,05,'Ojo de Agua (parte)'),(1544,118,06,'Rastrojales.'),(1545,119,01,'Bajo Mora'),(1546,119,02,'Bajo Venegas (parte)'),(1547,119,03,'Concepción'),(1548,119,04,'San Francisco'),(1549,119,05,'San Luis'),(1550,119,06,'San Rafael Abajo'),(1551,119,07,'Santa Juana'),(1552,119,08,'Santa Rosa (parte).'),(1553,120,01,'Alto Carrizal'),(1554,120,02,'Loma de la Altura'),(1555,120,03,'Santa Rosa (parte)'),(1556,120,04,'Trinidad.'),(1557,121,01,'Cedral (parte)'),(1558,121,02,'Lucha (parte)'),(1559,121,03,'San Martín'),(1560,121,04,'Rincón Gamboa.'),(1561,122,01,'Angostura (parte)'),(1562,122,02,'Cuesta.'),(1563,123,01,'Acequia Grande (parte)'),(1564,123,02,'Agonía'),(1565,123,03,'Arroyo'),(1566,123,04,'Bajo Cornizal'),(1567,123,05,'Brasil (parte)'),(1568,123,06,'Cafetal'),(1569,123,07,'Canoas'),(1570,123,08,'Carmen'),(1571,123,09,'Cementerio'),(1572,123,10,'Concepción'),(1573,123,11,'Ciruelas'),(1574,123,12,'Corazón de Jesús'),(1575,123,13,'Cristo Rey'),(1576,123,14,'Gregorio José Ramírez'),(1577,123,15,'Guadalupe'),(1578,123,16,'Higuerones'),(1579,123,17,'Hospital'),(1580,123,18,'Llano'),(1581,123,19,'Llobet'),(1582,123,20,'Molinos'),(1583,123,21,'Montecillos (parte)'),(1584,123,22,'Montenegro'),(1585,123,23,'Monserrat (parte)'),(1586,123,24,'Paso Flores'),(1587,123,25,'Providencia'),(1588,123,26,'Retiro'),(1589,123,27,'San Luis'),(1590,123,28,'Tomás Guardia'),(1591,123,29,'Tropicana'),(1592,123,30,'Villabonita (parte)'),(1593,123,31,'Villahermosa.'),(1594,124,01,'Amistad'),(1595,124,02,'Botánica'),(1596,124,03,'Copablanca'),(1597,124,04,'Flores'),(1598,124,05,'Jardines'),(1599,124,06,'Jocote'),(1600,124,07,'Juan Santamaría'),(1601,124,08,'Lagunilla'),(1602,124,09,'Mandarina (parte)'),(1603,124,10,'Maravilla (parte)'),(1604,124,11,'Montesol (parte)'),(1605,124,12,'Pueblo Nuevo'),(1606,124,13,'San Rafael'),(1607,124,14,'Santa Rita'),(1608,124,15,'Tigra'),(1609,124,16,'Torre'),(1610,124,17,'Trinidad'),(1611,124,18,'Tuetal Sur.'),(1612,124,19,'Coyol'),(1613,124,20,'Flores.'),(1614,125,01,'Alto Pavas'),(1615,125,02,'Bambú'),(1616,125,03,'Cinco Esquinas'),(1617,125,04,'Concordia'),(1618,125,05,'Domingas'),(1619,125,06,'El Plan.'),(1620,126,01,'Acequia Grande (parte)'),(1621,126,02,'Bajo Monge'),(1622,126,03,'Cañada'),(1623,126,04,'Montecillos (parte)'),(1624,126,05,'Monserrat (parte)'),(1625,126,06,'Puente Arena (parte)'),(1626,126,07,'Tejar'),(1627,126,08,'Vegas'),(1628,126,09,'Villabonita (parte).'),(1629,126,10,'Ciruelas'),(1630,126,11,'Roble'),(1631,126,12,'Sánchez.'),(1632,127,01,'Bajo Tejar'),(1633,127,02,'Cacao'),(1634,127,03,'Cañada'),(1635,127,04,'Coco'),(1636,127,05,'El Bajo'),(1637,127,06,'Hacienda Los Reyes'),(1638,127,07,'Nuestro Amo'),(1639,127,08,'Rincón Chiquito'),(1640,127,09,'Rincón de Herrera'),(1641,127,10,'Rincón de Monge'),(1642,127,11,'Ventanas'),(1643,127,12,'Vueltas.'),(1644,128,01,'Barrios (Alajuela): Aguilar'),(1645,128,02,'Ceiba'),(1646,128,03,'San Martín.'),(1647,128,04,'Alto Pilas'),(1648,128,05,'Buríos'),(1649,128,06,'Carbonal'),(1650,128,07,'Cerrillal'),(1651,128,08,'Dulce Nombre'),(1652,128,09,'Espino (parte)'),(1653,128,10,'Itiquís'),(1654,128,11,'Laguna'),(1655,128,12,'Loría'),(1656,128,13,'Maravilla (parte)'),(1657,128,14,'Montaña'),(1658,128,15,'Pilas'),(1659,128,16,'Potrerillos'),(1660,128,17,'San Jerónimo'),(1661,128,18,'San Rafael'),(1662,128,19,'Tacacorí'),(1663,128,20,'Tuetal Norte (parte)'),(1664,128,21,'Villas de la Ceiba.'),(1665,129,01,'Alto del Desengaño'),(1666,129,02,'Ángeles'),(1667,129,03,'Bajo Santa Bárbara'),(1668,129,04,'Cerro'),(1669,129,05,'Doka'),(1670,129,06,'Espino (parte)'),(1671,129,07,'Fraijanes'),(1672,129,08,'Lajas'),(1673,129,09,'Poasito'),(1674,129,10,'San Luis'),(1675,129,11,'San Rafael'),(1676,129,12,'Vargas (parte).'),(1677,130,01,'La Paz'),(1678,130,02,'Perla.'),(1679,130,03,'Cañada'),(1680,130,04,'Ojo de Agua'),(1681,130,05,'Paires'),(1682,130,06,'Potrerillos'),(1683,130,07,'Rincón Venegas.'),(1684,131,01,'Ángeles'),(1685,131,02,'Bajo Cañas (parte)'),(1686,131,03,'Bajo La Sorda'),(1687,131,04,'Cacique'),(1688,131,05,'California'),(1689,131,06,'Cañas (parte)'),(1690,131,07,'Guayabo'),(1691,131,08,'Monserrat (parte)'),(1692,131,09,'Puente Arena (parte)'),(1693,131,10,'Villalobos'),(1694,131,11,'Víquez.'),(1695,132,01,'Bajo Cañas (parte)'),(1696,132,02,'Bellavista'),(1697,132,03,'Brasil (parte)'),(1698,132,04,'Calicanto'),(1699,132,05,'Cañas (parte)'),(1700,132,06,'Erizo'),(1701,132,07,'Mojón'),(1702,132,08,'Pasito'),(1703,132,09,'Rincón'),(1704,132,10,'Rosales (parte)'),(1705,132,11,'Targuases'),(1706,132,12,'Tres Piedras.'),(1707,133,01,'Bajo Pita'),(1708,133,02,'Granja'),(1709,133,03,'Morera'),(1710,133,04,'San Martín'),(1711,133,05,'Santa Rita'),(1712,133,06,'Turrucareña'),(1713,133,07,'Villacares.'),(1714,133,08,'Bajo San Miguel'),(1715,133,09,'Candelaria'),(1716,133,10,'Carrera Buena'),(1717,133,11,'Cebadilla'),(1718,133,12,'Cerrillos (San Miguel)'),(1719,133,13,'Conejo'),(1720,133,14,'Juntas'),(1721,133,15,'Siquiares'),(1722,133,16,'Tamarindo.'),(1723,134,01,'Cacao'),(1724,134,02,'Calle Liles'),(1725,134,03,'González'),(1726,134,04,'Quebradas'),(1727,134,05,'Rincón Cacao'),(1728,134,06,'Tuetal Norte (parte)'),(1729,134,07,'Vargas (parte).'),(1730,135,01,'Animas'),(1731,135,02,'Cuesta Colorada'),(1732,135,03,'Copeyal'),(1733,135,04,'Horcones'),(1734,135,05,'Lagos del Coyol'),(1735,135,06,'Llanos'),(1736,135,07,'Mandarina (parte)'),(1737,135,08,'Manolos'),(1738,135,09,'Mina'),(1739,135,10,'Montesol (parte)'),(1740,135,11,'Monticel'),(1741,135,12,'Saltillo.'),(1742,136,01,'Bajo Latas'),(1743,136,02,'Cariblanco'),(1744,136,03,'Corazón de Jesús'),(1745,136,04,'Isla Bonita'),(1746,136,05,'Nueva Cinchona'),(1747,136,06,'San Antonio'),(1748,136,07,'Paraíso'),(1749,136,08,'Punta Mala'),(1750,136,09,'Ujarrás'),(1751,136,10,'Virgen del Socorro (parte).'),(1752,137,01,'Bajo Ladrillera'),(1753,137,02,'Cachera'),(1754,137,03,'Lisímaco Chavarría'),(1755,137,04,'Sabana (parte)'),(1756,137,05,'San José'),(1757,137,06,'Tremedal (parte).'),(1758,138,01,'Arias'),(1759,138,02,'Montserrat.'),(1760,138,03,'Alto Santiago'),(1761,138,04,'Alto Salas'),(1762,138,05,'Angostura'),(1763,138,06,'Balboa'),(1764,138,07,'Cambronero'),(1765,138,08,'Constancia'),(1766,138,09,'Cuesta del Toro'),(1767,138,10,'Empalme'),(1768,138,11,'La Ese'),(1769,138,12,'León'),(1770,138,13,'Magallanes'),(1771,138,14,'Moncada'),(1772,138,15,'Río Jesús.'),(1773,139,01,'Americana'),(1774,139,02,'Bajo Tajos'),(1775,139,03,'Belén'),(1776,139,04,'Cipreses'),(1777,139,05,'Lirios'),(1778,139,06,'Llamarón'),(1779,139,07,'Pueblo Nuevo'),(1780,139,08,'Tanque'),(1781,139,09,'Tejar'),(1782,139,10,'Vicente Badilla.'),(1783,139,11,'Juntas (parte).'),(1784,140,01,'Copán.'),(1785,140,02,'Araya'),(1786,140,03,'Bajo Matamoros (parte)'),(1787,140,04,'Bolívar'),(1788,140,05,'Campos'),(1789,140,06,'Esperanza'),(1790,140,07,'La Paz'),(1791,140,08,'Lomas'),(1792,140,09,'Piedades Noroeste.'),(1793,141,01,'Bajo Barranca'),(1794,141,02,'Barranca'),(1795,141,03,'Bureal'),(1796,141,04,'Carmen'),(1797,141,05,'Chassoul'),(1798,141,06,'Guaria'),(1799,141,07,'Nagatac'),(1800,141,08,'Palma'),(1801,141,09,'Potrerillos'),(1802,141,10,'Quebradillas'),(1803,141,11,'Salvador'),(1804,141,12,'San Bosco'),(1805,141,13,'San Francisco'),(1806,141,14,'San Miguel'),(1807,141,15,'Sardinal'),(1808,141,16,'Socorro.'),(1809,142,01,'Tres Marías'),(1810,142,02,'Unión.'),(1811,142,03,'Alto Llano'),(1812,142,04,'Berlín'),(1813,142,05,'Calera'),(1814,142,06,'Chavarría'),(1815,142,07,'Llano Brenes'),(1816,142,08,'Orlich'),(1817,142,09,'Orozco'),(1818,142,10,'Pata de Gallo'),(1819,142,11,'Rincón de Mora'),(1820,142,12,'Rincón  Orozco'),(1821,142,13,'San Joaquín'),(1822,142,14,'Zamora.'),(1823,143,01,'Progreso'),(1824,143,02,'Bajo Ramírez'),(1825,143,03,'Fernández'),(1826,143,04,'Guaria'),(1827,143,05,'Varela.'),(1828,144,01,'Los Jardines'),(1829,144,02,'Ranchera.'),(1830,144,03,'Ángeles Norte'),(1831,144,04,'Bajo Córdoba'),(1832,144,05,'Bajo Rodríguez'),(1833,144,06,'Balsa'),(1834,144,07,'Cataratas'),(1835,144,08,'Colonia Palmareña'),(1836,144,09,'Coopezamora'),(1837,144,10,'Criques'),(1838,144,11,'Juntas (parte)'),(1839,144,12,'Kooper'),(1840,144,13,'Lagos'),(1841,144,14,'Rocas'),(1842,144,15,'San Jorge'),(1843,144,16,'Silencio'),(1844,144,17,'Valle Azul'),(1845,144,18,'Zuñiga.'),(1846,145,01,'Badilla Alpizar'),(1847,145,02,'Sabana (parte)'),(1848,145,03,'Tremedal (parte).'),(1849,145,04,'Bajo Matamoros (parte)'),(1850,145,05,'Catarata'),(1851,145,06,'San Pedro'),(1852,145,07,'Valverde.'),(1853,146,01,'Alto Villegas'),(1854,146,02,'Bajo Tejares'),(1855,146,03,'Dulce Nombre'),(1856,146,04,'Sifón.'),(1857,147,01,'Cañuela'),(1858,147,02,'Concepción Arriba'),(1859,147,03,'Chaparral'),(1860,147,04,'Pérez.'),(1861,148,01,'Bajo Castillo'),(1862,148,02,'Bajos'),(1863,148,03,'Barranquilla'),(1864,148,04,'Carrera Buena'),(1865,148,05,'Jabonal'),(1866,148,06,'Jabonalito'),(1867,148,07,'Rincón Chaves'),(1868,148,08,'Victoria'),(1869,148,09,'Zapotal (parte).'),(1870,149,01,'Abanico'),(1871,149,02,'Altura'),(1872,149,03,'Bosque'),(1873,149,04,'Burrito'),(1874,149,05,'Cairo'),(1875,149,06,'Castillo (parte)'),(1876,149,07,'Castillo Nuevo'),(1877,149,08,'Colonia Trinidad'),(1878,149,09,'Chachagua'),(1879,149,10,'La Cruz'),(1880,149,11,'Pocosol'),(1881,149,12,'San Carlos'),(1882,149,13,'San Rafael'),(1883,149,14,'Sector Ángeles.'),(1884,150,01,'Carmona'),(1885,150,02,'Chavarría'),(1886,150,03,'Colón'),(1887,150,04,'Jiménez'),(1888,150,05,'Pinos'),(1889,150,06,'Rincón de Arias'),(1890,150,07,'San Antonio'),(1891,150,08,'San Vicente.'),(1892,150,09,'Celina.'),(1893,151,01,'Barrio (Grecia): Primavera.'),(1894,151,02,'Alfaro'),(1895,151,03,'Bajo Achiote'),(1896,151,04,'Camejo'),(1897,151,05,'Coopevictoria'),(1898,151,06,'Corinto'),(1899,151,07,'Higuerones'),(1900,151,08,'Mesón'),(1901,151,09,'Mojón'),(1902,151,10,'Quizarrazal.'),(1903,152,01,'Arena'),(1904,152,02,'Cedro'),(1905,152,03,'Delicias (parte)'),(1906,152,04,'Guayabal (parte)'),(1907,152,05,'Loma'),(1908,152,06,'Rodríguez'),(1909,152,07,'Santa Gertrudis Norte'),(1910,152,08,'Santa Gertrudis Sur.'),(1911,153,01,'Agualote'),(1912,153,02,'Bajo Sapera'),(1913,153,03,'Casillas'),(1914,153,04,'Latino'),(1915,153,05,'San Miguel Arriba.'),(1916,153,06,'Cabuyal'),(1917,153,07,'Carbonal'),(1918,153,08,'Coyotera'),(1919,153,09,'San Miguel.'),(1920,154,01,'Pinto.'),(1921,154,02,'Bodegas'),(1922,154,03,'Cataluña'),(1923,154,04,'Cerdas'),(1924,154,05,'Delicias (parte)'),(1925,154,06,'Flores'),(1926,154,07,'Guayabal (parte)'),(1927,154,08,'Pilas'),(1928,154,09,'Planta'),(1929,154,10,'Porvenir'),(1930,154,11,'Yoses.'),(1931,155,01,'Ángeles Norte'),(1932,155,02,'Bolaños'),(1933,155,03,'Bosque Alegre'),(1934,155,04,'Caño Negro'),(1935,155,05,'Carmen'),(1936,155,06,'Carrizal'),(1937,155,07,'Colonia del Toro'),(1938,155,08,'Crucero'),(1939,155,09,'Flor'),(1940,155,10,'Hule'),(1941,155,11,'La Trinidad'),(1942,155,12,'Laguna'),(1943,155,13,'Lagos'),(1944,155,14,'Merced'),(1945,155,15,'Montelirio'),(1946,155,16,'Naranjales'),(1947,155,17,'Palmar'),(1948,155,18,'Palmera'),(1949,155,19,'Pata de Gallo'),(1950,155,20,'Peoresnada'),(1951,155,21,'Pinar'),(1952,155,22,'Pueblo Nuevo'),(1953,155,23,'San Fernando'),(1954,155,24,'San Gerardo (parte)'),(1955,155,25,'San Jorge'),(1956,155,26,'San José'),(1957,155,27,'San Rafael'),(1958,155,28,'San Vicente'),(1959,155,29,'Santa Isabel'),(1960,155,30,'Santa Rita'),(1961,155,31,'Tabla.'),(1962,156,01,'(Grecia): Poró'),(1963,156,02,'Sevilla.'),(1964,156,03,'Altos de Peralta'),(1965,156,04,'Argentina'),(1966,156,05,'Bajo Cedros'),(1967,156,06,'Lomas'),(1968,156,07,'Montezuma'),(1969,156,08,'Puerto Escondido'),(1970,156,09,'Raiceros'),(1971,156,10,'Rincón de Salas'),(1972,156,11,'Rosales.'),(1973,157,01,'Cajón'),(1974,157,02,'Cocobolo'),(1975,157,03,'Murillo'),(1976,157,04,'San Juan'),(1977,157,05,'San Luis'),(1978,157,06,'Virgencita.'),(1979,158,01,'Agua Agria'),(1980,158,02,'Calera'),(1981,158,03,'Cenízaro'),(1982,158,04,'Centeno'),(1983,158,05,'Desamparados'),(1984,158,06,'Dulce Nombre'),(1985,158,07,'Higuito'),(1986,158,08,'Izarco'),(1987,158,09,'Maderal'),(1988,158,10,'Ramadas'),(1989,158,11,'San Juan de Dios.'),(1990,159,01,'Cuesta Colorada'),(1991,159,02,'Libertad'),(1992,159,03,'Quebrada Honda'),(1993,159,04,'Limón'),(1994,159,05,'Patio de Agua Norte'),(1995,159,06,'Sacra Familia'),(1996,159,07,'San Juan Uno'),(1997,159,08,'Zapote.'),(1998,160,01,'Garabito'),(1999,160,02,'Quebrada Grande (parte)'),(2000,160,03,'Quinta.'),(2001,161,01,'Altamira'),(2002,161,02,'Oricuajo'),(2003,161,03,'Poza Redonda'),(2004,161,04,'Quebrada Grande (parte).'),(2005,162,01,'Ángeles'),(2006,162,02,'Atenea'),(2007,162,03,'Boquerón'),(2008,162,04,'Escorpio'),(2009,162,05,'Güizaro'),(2010,162,06,'Oásis'),(2011,162,07,'Olivo.'),(2012,162,08,'Matías.'),(2013,163,01,'Guacalillo'),(2014,163,02,'Sabanalarga'),(2015,163,03,'San Vicente.'),(2016,163,04,'Barroeta'),(2017,163,05,'Boca del Monte'),(2018,163,06,'Cuajiniquil'),(2019,163,07,'Estanquillo'),(2020,163,08,'Pato de Agua (parte).'),(2021,164,01,'Cajón.'),(2022,164,02,'Callao'),(2023,164,03,'Plancillo'),(2024,164,04,'Plazoleta.'),(2025,165,01,'Alto Naranjo'),(2026,165,02,'Bajo Cacao'),(2027,165,03,'Morazán'),(2028,165,04,'Pato de Agua (parte)'),(2029,165,05,'Pavas'),(2030,165,06,'Rincón.'),(2031,166,01,'Río Grande'),(2032,166,02,'Balsa'),(2033,166,03,'Calle Garita'),(2034,166,04,'Coyoles'),(2035,166,05,'Pan de Azúcar'),(2036,166,06,'Tornos.'),(2037,167,01,'Alto Cima'),(2038,167,02,'Alto López'),(2039,167,03,'Legua'),(2040,167,04,'San José Norte'),(2041,167,05,'Torunes'),(2042,167,06,'Vainilla.'),(2043,168,01,'Rincón Rodríguez.'),(2044,169,01,'Cerrillo'),(2045,169,02,'Guácimos'),(2046,169,03,'Kilómetro 51'),(2047,169,04,'Lapas'),(2048,169,05,'Mangos'),(2049,169,06,'Quebradas'),(2050,169,07,'Vuelta Herrera.'),(2051,170,01,'Bajo Pilas'),(2052,170,02,'Belén'),(2053,170,03,'Caña Dura'),(2054,170,04,'Gradas'),(2055,170,05,'María Auxiliadora'),(2056,170,06,'Muro'),(2057,170,07,'Pueblo Nuevo'),(2058,170,08,'Sacramento'),(2059,170,09,'San Lucas (Carmen)'),(2060,170,10,'San Rafael.'),(2061,170,11,'Candelaria'),(2062,170,12,'Cantarrana (parte)'),(2063,170,13,'Cinco Esquinas (parte)'),(2064,170,14,'Ciprés'),(2065,170,15,'Común'),(2066,170,16,'Dulce Nombre.'),(2067,171,01,'Planes.'),(2068,171,02,'Bajo Seevers'),(2069,171,03,'Bajos'),(2070,171,04,'Palmas'),(2071,171,05,'Quesera'),(2072,171,06,'San Francisco'),(2073,171,07,'San Miguel Oeste.'),(2074,172,01,'Barranca'),(2075,172,02,'Cañuela Arriba'),(2076,172,03,'Cuesta Venada'),(2077,172,04,'Desamparados'),(2078,172,05,'Isla'),(2079,172,06,'San Antonio de Barranca'),(2080,172,07,'San Pedro'),(2081,172,08,'Solís (parte)'),(2082,172,09,'Vuelta San Gerardo.'),(2083,173,01,'Bajo Arrieta'),(2084,173,02,'Bajo Valverde'),(2085,173,03,'Bajo Zúñiga'),(2086,173,04,'Cruce'),(2087,173,05,'Isla Cocora'),(2088,173,06,'Lourdes'),(2089,173,07,'Llano Bonito'),(2090,173,08,'Llano Bonito Sur'),(2091,173,09,'Palmita'),(2092,173,10,'Quebrada Honda'),(2093,173,11,'Rincón'),(2094,173,12,'Solís (parte)'),(2095,173,13,'Zapote.'),(2096,174,01,'Puebla'),(2097,174,02,'Robles'),(2098,174,03,'Tacacal.'),(2099,175,01,'Bajo Murciélago'),(2100,175,02,'Cueva'),(2101,175,03,'Guarumal'),(2102,175,04,'Rincón Elizondo'),(2103,175,05,'San Antonio'),(2104,175,06,'Yoses.'),(2105,176,01,'Pérez'),(2106,176,02,'Hornos'),(2107,176,03,'Llano'),(2108,176,04,'Santa Margarita'),(2109,176,05,'Vistas del Valle.'),(2110,177,01,'Alto Murillo'),(2111,177,02,'Alto Palmas'),(2112,177,03,'Cantarrana (parte)'),(2113,177,04,'Cinco Esquinas (parte)'),(2114,177,05,'Concepción'),(2115,177,06,'Roquillo'),(2116,177,07,'San Roque.'),(2117,178,01,'Santa Fe'),(2118,178,02,'San Vicente.'),(2119,179,01,'Cocaleca (parte)'),(2120,179,02,'Quebrada'),(2121,179,03,'Rincón (Quebrada)'),(2122,179,04,'Rincón de Zaragoza'),(2123,179,05,'Vargas'),(2124,179,06,'Vásquez.'),(2125,180,01,'Bajo Cabra'),(2126,180,02,'Barreal'),(2127,180,03,'Tres Marías'),(2128,180,04,'Valle'),(2129,180,05,'Victoria.'),(2130,180,06,'Calle Ramírez.'),(2131,181,01,'Pinos (parte).'),(2132,182,01,'Pinos (parte).'),(2133,183,01,'Calle Roble'),(2134,183,02,'Cocaleca (parte)'),(2135,183,03,'Peraza'),(2136,183,04,'Rincón de Salas.'),(2137,184,01,'Amistad.'),(2138,185,01,'Santa Cecilia (Bajo Piedras)'),(2139,185,02,'Rastro.'),(2140,185,03,'Cerro'),(2141,185,04,'Chilamate'),(2142,185,05,'Hilda'),(2143,185,06,'Sitio (parte)'),(2144,185,07,'Zamora.'),(2145,186,01,'Altura (parte)'),(2146,186,02,'Corazón de Jesús'),(2147,186,03,'Guapinol'),(2148,186,04,'Mastate'),(2149,186,05,'San Juan Norte'),(2150,186,06,'Tablones (parte).'),(2151,187,01,'Bajo Zamora'),(2152,187,02,'Churuca'),(2153,187,03,'Guatuza'),(2154,187,04,'Monte'),(2155,187,05,'Potrero Chiquito'),(2156,187,06,'Santa Rosa'),(2157,187,07,'Sitio (parte)'),(2158,187,08,'Solís'),(2159,187,09,'Tablones (parte)'),(2160,187,10,'Volcán.'),(2161,188,01,'Bajo Barahona'),(2162,188,02,'Cuatro Esquinas'),(2163,188,03,'Santísima Trinidad.'),(2164,188,04,'Carrillos Alto'),(2165,188,05,'Senda'),(2166,188,06,'Sonora.'),(2167,189,01,'Altura (parte)'),(2168,189,02,'Bajos del Tigre.'),(2169,190,01,'Aguacate'),(2170,190,02,'Arboleda'),(2171,190,03,'Carmen'),(2172,190,04,'Cortezal'),(2173,190,05,'Cuatro Esquinas Norte'),(2174,190,06,'Jesús'),(2175,190,07,'Kilómetro'),(2176,190,08,'López'),(2177,190,09,'Miraflores'),(2178,190,10,'Rastro Viejo'),(2179,190,11,'San Rafael'),(2180,190,12,'San Vicente'),(2181,190,13,'Tres Marías'),(2182,190,14,'Villa los Reyes.'),(2183,190,15,'Alto Vindas'),(2184,190,16,'Esperanza'),(2185,190,17,'Tigre.'),(2186,191,01,'Cuatro Esquinas Este'),(2187,191,02,'Piedra Azul.'),(2188,191,03,'Guayabal.'),(2189,192,01,'Marichal'),(2190,192,02,'Concepción'),(2191,192,03,'Dantas.'),(2192,193,01,'Corazón de María.'),(2193,193,02,'Bajos del Coyote'),(2194,193,03,'Cebadilla'),(2195,193,04,'Guápiles'),(2196,193,05,'Limonal'),(2197,193,06,'Mangos'),(2198,193,07,'Mollejones'),(2199,193,08,'Piedras de Fuego'),(2200,193,09,'Pozón'),(2201,193,10,'San Jerónimo'),(2202,193,11,'Santa Rita.'),(2203,194,01,'Angostura Matamoros'),(2204,194,02,'Cascajal'),(2205,194,03,'Cuesta Pitahaya'),(2206,194,04,'Guácimo'),(2207,194,05,'Hidalgo'),(2208,194,06,'Kilómetro 81'),(2209,194,07,'Machuca'),(2210,194,08,'Matamoros'),(2211,194,09,'Túnel'),(2212,194,10,'Uvita'),(2213,194,11,'Zapote.'),(2214,195,01,'Alto Cruz'),(2215,195,02,'Ana Mercedes'),(2216,195,03,'Ángeles'),(2217,195,04,'Arco Iris'),(2218,195,05,'Bajo Los Arce'),(2219,195,06,'Bajo Lourdes'),(2220,195,07,'Baltazar Quesada'),(2221,195,08,'Bellavista'),(2222,195,09,'Carmen'),(2223,195,10,'Casilda Matamoros'),(2224,195,11,'Cementerio'),(2225,195,12,'Coocique'),(2226,195,13,'Colina 1'),(2227,195,14,'Colina 2'),(2228,195,15,'Corazón de Jesús'),(2229,195,16,'Corobicí'),(2230,195,17,'Don Victorino'),(2231,195,18,'El Campo'),(2232,195,19,'Gamonales'),(2233,195,20,'Guadalupe'),(2234,195,21,'La Cruz'),(2235,195,22,'La Leila'),(2236,195,23,'La Margarita'),(2237,195,24,'La Roca'),(2238,195,25,'La Torre'),(2239,195,26,'Los Abuelos'),(2240,195,27,'Lomas del Norte'),(2241,195,28,'Lutz'),(2242,195,29,'Meco'),(2243,195,30,'Mercedes'),(2244,195,31,'Peje'),(2245,195,32,'San Antonio'),(2246,195,33,'San Gerardo'),(2247,195,34,'San Martín'),(2248,195,35,'San Pablo'),(2249,195,36,'San Roque'),(2250,195,37,'Santa Fe'),(2251,195,38,'Selva Verde'),(2252,195,39,'Unión'),(2253,195,40,'Villarreal.'),(2254,195,41,'Abundancia'),(2255,195,42,'Brumas'),(2256,195,43,'Calle Guerrero'),(2257,195,44,'San Ramón (Cariblanca)'),(2258,195,45,'Cedral Norte'),(2259,195,46,'Cedral Sur'),(2260,195,47,'Colón'),(2261,195,48,'Dulce Nombre'),(2262,195,49,'Leones'),(2263,195,50,'Lindavista'),(2264,195,51,'Manzanos'),(2265,195,52,'Montañitas'),(2266,195,53,'Palmas'),(2267,195,54,'Porvenir'),(2268,195,55,'San Juan (Quebrada Palo)'),(2269,195,56,'Ronrón Abajo'),(2270,195,57,'Ronrón Arriba'),(2271,195,58,'San Isidro'),(2272,195,59,'San José de la Montaña'),(2273,195,60,'San Luis'),(2274,195,61,'San Rafael'),(2275,195,62,'San Vicente'),(2276,195,63,'Sucre'),(2277,195,64,'Tesalia.'),(2278,196,01,'Alto Gloria'),(2279,196,02,'Aquilea (San Francisco)'),(2280,196,03,'Bonanza'),(2281,196,04,'Caimitos'),(2282,196,05,'Chaparral'),(2283,196,06,'Cuestillas'),(2284,196,07,'Jabillos (parte)'),(2285,196,08,'Molino'),(2286,196,09,'Muelle de San Carlos'),(2287,196,10,'Pejeviejo'),(2288,196,11,'Pénjamo'),(2289,196,12,'Platanar'),(2290,196,13,'Puente Casa'),(2291,196,14,'Puerto Escondido'),(2292,196,15,'Quebrada Azul'),(2293,196,16,'San Juan'),(2294,196,17,'San Luis'),(2295,196,18,'San Rafael'),(2296,196,19,'Santa Clara'),(2297,196,20,'Santa María'),(2298,196,21,'Santa Rita'),(2299,196,22,'Sapera'),(2300,196,23,'Ulima'),(2301,196,24,'Vega'),(2302,196,25,'Vieja.'),(2303,197,01,'Culebra'),(2304,197,02,'Quina (parte)'),(2305,197,03,'San Antonio'),(2306,197,04,'San Bosco.'),(2307,198,01,'Latino'),(2308,198,02,'Manantial'),(2309,198,03,'Montecristo'),(2310,198,04,'Nazareth'),(2311,198,05,'San Bosco'),(2312,198,06,'San Gerardo Viento Fresco'),(2313,198,07,'Vistas de la Llanura.'),(2314,198,08,'Altamira'),(2315,198,09,'Alto Jiménez (Montecristo)'),(2316,198,10,'Bijagual'),(2317,198,11,'Boca los Chiles'),(2318,198,12,'Cantarrana (Santa Fe)'),(2319,198,13,'Coopesanjuan'),(2320,198,14,'Caño Negro'),(2321,198,15,'Cerrito'),(2322,198,16,'Cerro Cortés'),(2323,198,17,'Concepción'),(2324,198,18,'Chiles'),(2325,198,19,'Danta'),(2326,198,20,'Delicias'),(2327,198,21,'Faroles'),(2328,198,22,'Gloria'),(2329,198,23,'Guabo'),(2330,198,24,'Llanos de Altamirita'),(2331,198,25,'Pitalito Norte (Esquipulas)'),(2332,198,26,'Pitalito'),(2333,198,27,'San José'),(2334,198,28,'Valle Hermoso'),(2335,198,29,'Vasconia'),(2336,198,30,'Vuelta de Kooper.'),(2337,199,01,'Carmen'),(2338,199,02,'Corazón de Jesús'),(2339,199,03,'El Ceibo'),(2340,199,04,'Jardín'),(2341,199,05,'La Gloria.'),(2342,199,06,'Alpes'),(2343,199,07,'Brisas'),(2344,199,08,'Buenos Aires'),(2345,199,09,'Guayabo'),(2346,199,10,'Latas'),(2347,199,11,'Marsella'),(2348,199,12,'Mesén'),(2349,199,13,'Nazareth'),(2350,199,14,'Negritos'),(2351,199,15,'Paraíso'),(2352,199,16,'Pueblo Viejo'),(2353,199,17,'San Cayetano'),(2354,199,18,'San Martín'),(2355,199,19,'Unión.'),(2356,200,01,'Bosque'),(2357,200,02,'Comarca'),(2358,200,03,'San Cristóbal.'),(2359,200,04,'Ángeles'),(2360,200,05,'Boca Sahíno'),(2361,200,06,'Boca Tapada'),(2362,200,07,'Boca Tres Amigos'),(2363,200,08,'Cabra'),(2364,200,09,'Canacas'),(2365,200,10,'Caño Chu'),(2366,200,11,'Cerro Blanco (San Marcos)'),(2367,200,12,'Cuatro Esquinas'),(2368,200,13,'Chaparrón'),(2369,200,14,'Chirivico (Coopeisabel)'),(2370,200,15,'Encanto'),(2371,200,16,'Fama (Carmen)'),(2372,200,17,'Flor'),(2373,200,18,'I Griega'),(2374,200,19,'Josefina'),(2375,200,20,'Legua'),(2376,200,21,'Ojoche'),(2377,200,22,'Ojochito'),(2378,200,23,'Palmar'),(2379,200,24,'Pegón'),(2380,200,25,'Piedra Alegre'),(2381,200,26,'Puerto Escondido'),(2382,200,27,'Quebrada Grande'),(2383,200,28,'Sahíno'),(2384,200,29,'San Luis'),(2385,200,30,'Santa Elena'),(2386,200,31,'Tigre'),(2387,200,32,'Trinchera'),(2388,200,33,'Vegas'),(2389,200,34,'Veracrúz'),(2390,200,35,'Vuelta Bolsón (parte)'),(2391,200,36,'Vuelta Tablón'),(2392,200,37,'Yucatán.'),(2393,201,01,'Agua Azul'),(2394,201,02,'Alamo'),(2395,201,03,'Ángeles'),(2396,201,04,'Burío'),(2397,201,05,'Castillo (parte)'),(2398,201,06,'Guaria'),(2399,201,07,'El Campo (Guayabal)'),(2400,201,08,'Jilguero'),(2401,201,09,'Llano Verde'),(2402,201,10,'Orquídeas'),(2403,201,11,'Palma'),(2404,201,12,'Perla'),(2405,201,13,'San Isidro'),(2406,201,14,'San Jorge'),(2407,201,15,'Santa Eduviges'),(2408,201,16,'Sonafluca'),(2409,201,17,'Tanque'),(2410,201,18,'Tres Esquinas'),(2411,201,19,'Zeta Trece.'),(2412,202,01,'Ángeles'),(2413,202,02,'Palmas.'),(2414,202,03,'Cerritos'),(2415,202,04,'Esperanza'),(2416,202,05,'Futuro'),(2417,202,06,'Jabillos (parte)'),(2418,202,07,'Lucha'),(2419,202,08,'San Gerardo'),(2420,202,09,'San Isidro'),(2421,202,10,'San José'),(2422,202,11,'San Miguel'),(2423,202,12,'San Pedro'),(2424,202,13,'San Rafael.'),(2425,203,01,'Altura'),(2426,203,02,'Calle Damas'),(2427,203,03,'Corea (Concepción)'),(2428,203,04,'Corte'),(2429,203,05,'Loma'),(2430,203,06,'Lourdes'),(2431,203,07,'Marina'),(2432,203,08,'Marinita'),(2433,203,09,'San Rafael'),(2434,203,10,'San Rafael Sur'),(2435,203,11,'Santa Rosa'),(2436,203,12,'Surtubal'),(2437,203,13,'Unión'),(2438,203,14,'Vacablanca (San Francisco)'),(2439,203,15,'Villa María.'),(2440,204,01,'Altamirita'),(2441,204,02,'Alto Blanca Lucía'),(2442,204,03,'Burío'),(2443,204,04,'Cacao'),(2444,204,05,'Delicias'),(2445,204,06,'Esperanza'),(2446,204,07,'Jicarito'),(2447,204,08,'Lindavista'),(2448,204,09,'Poma (parte)'),(2449,204,10,'Puerto Seco'),(2450,204,11,'San Isidro'),(2451,204,12,'Santa Eulalia (parte)'),(2452,204,13,'Santa Lucía'),(2453,204,14,'Tigra.'),(2454,205,01,'Almendros'),(2455,205,02,'Bellavista'),(2456,205,03,'Betania'),(2457,205,04,'Boca de San Carlos'),(2458,205,05,'Boca Providencia (parte)'),(2459,205,06,'Cabeceras de Aguas Zarquitas'),(2460,205,07,'Carmen'),(2461,205,08,'Cascada'),(2462,205,09,'Castelmare'),(2463,205,10,'Cocobolo'),(2464,205,11,'Coopevega'),(2465,205,12,'Corazón de Jesús'),(2466,205,13,'Crucitas'),(2467,205,14,'Chamorrito'),(2468,205,15,'Chamorro'),(2469,205,16,'Chorreras'),(2470,205,17,'Hebrón'),(2471,205,18,'Isla del Cura'),(2472,205,19,'Isla Pobres'),(2473,205,20,'Isla Sábalo'),(2474,205,21,'Jardín'),(2475,205,22,'Kopper'),(2476,205,23,'La Cajeta'),(2477,205,24,'Laurel Galán'),(2478,205,25,'Limoncito'),(2479,205,26,'Moravia'),(2480,205,27,'Patastillo'),(2481,205,28,'Pueblo Nuevo'),(2482,205,29,'Recreo'),(2483,205,30,'Río Tico'),(2484,205,31,'Roble'),(2485,205,32,'San Antonio'),(2486,205,33,'San Fernando'),(2487,205,34,'San Francisco'),(2488,205,35,'San Joaquín'),(2489,205,36,'San Jorge'),(2490,205,37,'San José'),(2491,205,38,'San Marcos'),(2492,205,39,'Santa Rita'),(2493,205,40,'Santa Teresa'),(2494,205,41,'San Vito'),(2495,205,42,'Tabla Grande (San Pedro)'),(2496,205,43,'Terrón Colorado (parte)'),(2497,205,44,'Ventanas'),(2498,205,45,'Vuelta Bolsón (parte)'),(2499,205,46,'Vuelta Millonarios'),(2500,205,47,'Vuelta Ruedas.'),(2501,206,01,'Pericos.'),(2502,206,02,'Bajillo'),(2503,206,03,'Caño Ciego'),(2504,206,04,'Cedros'),(2505,206,05,'Chambacú'),(2506,206,06,'Delicias'),(2507,206,07,'La Unión'),(2508,206,08,'Maquencal'),(2509,206,09,'Mirador'),(2510,206,10,'Montelimar'),(2511,206,11,'Monterrey'),(2512,206,12,'Orquídea'),(2513,206,13,'Pataste Arriba'),(2514,206,14,'Sabalito'),(2515,206,15,'San Andrés'),(2516,206,16,'San Antonio'),(2517,206,17,'San Cristóbal'),(2518,206,18,'San Miguel'),(2519,206,19,'Santa Eulalia (parte)'),(2520,206,20,'Santa Marta.'),(2521,207,01,'Fátima'),(2522,207,02,'Parajeles'),(2523,207,03,'Tres Perlas'),(2524,207,04,'Valle Hermoso.'),(2525,207,05,'Acapulco'),(2526,207,06,'Aldea'),(2527,207,07,'Ángeles'),(2528,207,08,'Azucena'),(2529,207,09,'Banderas'),(2530,207,10,'Boca Providencia (parte)'),(2531,207,11,'Brisas'),(2532,207,12,'Buenavista'),(2533,207,13,'Buenos Aires'),(2534,207,14,'Carrizal'),(2535,207,15,'Ceiba'),(2536,207,16,'Conchito'),(2537,207,17,'Concho'),(2538,207,18,'Cuatro Esquinas'),(2539,207,19,'Esterito'),(2540,207,20,'Estero'),(2541,207,21,'Estrella'),(2542,207,22,'Guaria'),(2543,207,23,'Jazmín'),(2544,207,24,'Jocote'),(2545,207,25,'Juanilama'),(2546,207,26,'Luisa'),(2547,207,27,'Llano Verde'),(2548,207,28,'Morazán'),(2549,207,29,'Nieves'),(2550,207,30,'Paraíso'),(2551,207,31,'Paso Real'),(2552,207,32,'Plomo'),(2553,207,33,'Pocosol'),(2554,207,34,'Providencia (San Luis)'),(2555,207,35,'Pueblo Nuevo'),(2556,207,36,'Pueblo Santo'),(2557,207,37,'Rancho Quemado'),(2558,207,38,'Rubí'),(2559,207,39,'San Alejo'),(2560,207,40,'San Bosco'),(2561,207,41,'San Cristobal'),(2562,207,42,'San Diego'),(2563,207,43,'San Gerardo'),(2564,207,44,'San Isidro'),(2565,207,45,'San Martín'),(2566,207,46,'San Rafael'),(2567,207,47,'Santa Cecilia'),(2568,207,48,'Santa Esperanza'),(2569,207,49,'Santa María'),(2570,207,50,'Terrón Colorado (parte)'),(2571,207,51,'Tiricias'),(2572,207,52,'Tres y Tres.'),(2573,208,01,'Cantarranas'),(2574,208,02,'Santa Teresita.'),(2575,209,01,'Peña.'),(2576,210,01,'Anateri'),(2577,210,02,'Bellavista'),(2578,210,03,'Morelos.'),(2579,211,01,'Picada.'),(2580,212,01,'Quina (parte)'),(2581,212,02,'San Juan de Lajas'),(2582,212,03,'Santa Elena.'),(2583,213,01,'Ángeles'),(2584,213,02,'Brisa'),(2585,213,03,'Legua.'),(2586,214,01,'Ángeles'),(2587,214,02,'Bajo Raimundo'),(2588,214,03,'Canto'),(2589,214,04,'Eva'),(2590,214,05,'Luisa'),(2591,214,06,'San Rafael (Rincón Colorado)'),(2592,214,07,'Sahinal.'),(2593,215,01,'Alto Castro'),(2594,215,00,'Bajo Trapiche'),(2595,215,02,'Coopeoctava'),(2596,215,00,'Ranera.'),(2597,215,03,'Ratoncillal'),(2598,215,04,'Rincón de Alpízar'),(2599,215,05,'Rincón de Ulate'),(2600,215,06,'San Miguel.'),(2601,216,01,'Alto Palomo.'),(2602,217,01,'Castro'),(2603,217,02,'Concha'),(2604,217,03,'Pueblo Seco'),(2605,217,04,'Talolinga'),(2606,217,05,'Trojas.'),(2607,218,01,'Bambú'),(2608,218,02,'Sabanilla.'),(2609,219,01,'Don Chu'),(2610,219,02,'La Unión'),(2611,219,03,'Las Palmas'),(2612,219,04,'Venecia.'),(2613,219,05,'Ángeles (parte)'),(2614,219,06,'Carmen'),(2615,219,07,'Colonia Puntarenas'),(2616,219,08,'Corteza'),(2617,219,09,'Fósforo'),(2618,219,10,'Jazmines'),(2619,219,11,'Llano Azul'),(2620,219,12,'Maravilla'),(2621,219,13,'Miravalles'),(2622,219,14,'Moreno Cañas'),(2623,219,15,'Recreo'),(2624,219,16,'San Fernando'),(2625,219,17,'San Luis'),(2626,219,18,'San Martín'),(2627,219,19,'Santa Cecilia'),(2628,219,20,'Santa Rosa'),(2629,219,21,'Verbena (parte).'),(2630,220,01,'Ceiba'),(2631,220,02,'Golfo'),(2632,220,03,'Porras.'),(2633,220,04,'Aguas Claras'),(2634,220,05,'Buenos Aires'),(2635,220,06,'Colonia Blanca'),(2636,220,07,'Colonia Libertad'),(2637,220,08,'Cuatro Bocas'),(2638,220,09,'Chepa (Ángeles)'),(2639,220,10,'Guayabal'),(2640,220,11,'Guinea'),(2641,220,12,'La Gloria'),(2642,220,13,'Porvenir'),(2643,220,14,'Río Negro'),(2644,220,15,'Tigra'),(2645,220,16,'Torre'),(2646,220,17,'Vuelta San Pedro.'),(2647,221,01,'Camelias'),(2648,221,02,'Líbano (Finanzas)'),(2649,221,03,'Nazareno.'),(2650,221,04,'Ángeles (parte)'),(2651,221,05,'Betania'),(2652,221,06,'Caño Blanco'),(2653,221,07,'Cartagos Norte'),(2654,221,08,'Cartagos Sur'),(2655,221,09,'Copey (Santa Lucía)'),(2656,221,10,'Delirio'),(2657,221,11,'Fátima'),(2658,221,12,'Jesús María'),(2659,221,13,'Linda Vista'),(2660,221,14,'Mango'),(2661,221,15,'Papagayo'),(2662,221,16,'Pinol'),(2663,221,17,'Pizotillo'),(2664,221,18,'Popoyuapa'),(2665,221,19,'Progreso'),(2666,221,20,'Pueblo Nuevo'),(2667,221,21,'San Bosco'),(2668,221,22,'San Pedro'),(2669,221,23,'San Ramón'),(2670,221,24,'Santa Clara Norte (parte)'),(2671,221,25,'Unión'),(2672,221,26,'Valle'),(2673,221,27,'Valle Bonito'),(2674,221,28,'Victoria (parte)'),(2675,221,29,'Villahermosa'),(2676,221,30,'Villanueva.'),(2677,222,01,'Altamira'),(2678,222,02,'Carlos Vargas.'),(2679,222,03,'Ángeles'),(2680,222,04,'Achiote'),(2681,222,05,'Cuesta Pichardo'),(2682,222,06,'Chorros'),(2683,222,07,'Florecitas'),(2684,222,08,'Flores'),(2685,222,09,'Higuerón'),(2686,222,10,'Jardín'),(2687,222,11,'Macho'),(2688,222,12,'Pata de Gallo (San Cristobal) (parte)'),(2689,222,13,'Pueblo Nuevo'),(2690,222,14,'Reserva'),(2691,222,15,'San Miguel'),(2692,222,16,'Santo Domingo'),(2693,222,17,'Zapote.'),(2694,223,01,'Camelias'),(2695,223,02,'La Cruz'),(2696,223,03,'México'),(2697,223,04,'Mocorón'),(2698,223,05,'Pavas'),(2699,223,06,'Perla'),(2700,223,07,'Quebradón'),(2701,223,08,'Santa Clara Norte (parte)'),(2702,223,09,'Santa Clara Sur'),(2703,223,10,'Trapiche'),(2704,223,11,'Victoria (parte).'),(2705,224,01,'Birmania'),(2706,224,02,'Brasilia'),(2707,224,03,'Colonia'),(2708,224,04,'Gavilán'),(2709,224,05,'Jabalina'),(2710,224,06,'Progreso'),(2711,224,07,'San Luis.'),(2712,225,01,'Cabanga'),(2713,225,02,'Campo Verde'),(2714,225,03,'Carmen'),(2715,225,04,'Cinco Esquinas'),(2716,225,05,'Chimurria Abajo'),(2717,225,06,'Flores'),(2718,225,07,'Jobo'),(2719,225,08,'Montecristo'),(2720,225,09,'Nazareth'),(2721,225,10,'Quebrada Grande'),(2722,225,11,'San Gabriel'),(2723,225,12,'San Jorge'),(2724,225,13,'Socorro'),(2725,225,14,'Virgen'),(2726,225,15,'Yolillal (San Antonio).'),(2727,226,01,'Armenias'),(2728,226,02,'Las Brisas'),(2729,226,03,'Buenavista'),(2730,226,04,'Cuatro Cruces'),(2731,226,05,'Guacalito'),(2732,226,06,'Milpas'),(2733,226,07,'Miramar'),(2734,226,08,'Pata de Gallo (San Cristóbal) (parte)'),(2735,226,09,'Rosario'),(2736,226,10,'Verbena (parte).'),(2737,227,01,'Loma'),(2738,227,02,'Portón.'),(2739,227,03,'Arco Iris'),(2740,227,04,'Berlín'),(2741,227,05,'Brisas'),(2742,227,06,'Buenos Aires'),(2743,227,07,'Cabro'),(2744,227,08,'Cachito'),(2745,227,09,'Caña Castilla'),(2746,227,10,'Combate'),(2747,227,11,'Coquital'),(2748,227,12,'Cristo Rey'),(2749,227,13,'Cuacas'),(2750,227,14,'Cuatro Esquinas'),(2751,227,15,'Delicias'),(2752,227,16,'El Cruce'),(2753,227,17,'Escaleras'),(2754,227,18,'Esperanza'),(2755,227,19,'Estrella'),(2756,227,20,'Hernández'),(2757,227,21,'Isla Chica'),(2758,227,22,'Las Nubes'),(2759,227,23,'Maramba'),(2760,227,24,'Masaya'),(2761,227,25,'Medio Queso'),(2762,227,26,'Parque'),(2763,227,27,'Playuelitas'),(2764,227,28,'Primavera'),(2765,227,29,'Pueblo Nuevo'),(2766,227,30,'Punta Cortés'),(2767,227,31,'Rampla'),(2768,227,32,'Refugio'),(2769,227,33,'Roble'),(2770,227,34,'San Alejandro'),(2771,227,35,'San Gerardo'),(2772,227,36,'San Jerónimo'),(2773,227,37,'San Pablo'),(2774,227,38,'Santa Elena'),(2775,227,39,'Santa Fe'),(2776,227,40,'Santa Rita'),(2777,227,41,'Santa Rosa'),(2778,227,42,'Solanos'),(2779,227,43,'Trocha'),(2780,227,44,'Virgen.'),(2781,228,01,'Aguas Negras'),(2782,228,02,'Islas Cubas'),(2783,228,03,'Nueva Esperanza'),(2784,228,04,'Pilones'),(2785,228,05,'Playuelas'),(2786,228,06,'Porvenir'),(2787,228,07,'San Antonio'),(2788,228,08,'San Emilio'),(2789,228,09,'Veracruz.'),(2790,229,01,'Alto los Reyes'),(2791,229,02,'Caño Ciego'),(2792,229,03,'Cóbano'),(2793,229,04,'Corozo'),(2794,229,05,'Corrales'),(2795,229,06,'Coyol'),(2796,229,07,'Dos Aguas'),(2797,229,08,'Gallito'),(2798,229,09,'Gallo Pinto (parte)'),(2799,229,10,'Montealegre'),(2800,229,11,'Nueva Lucha'),(2801,229,12,'Pavón'),(2802,229,13,'Quebrada Grande'),(2803,229,14,'Sabogal'),(2804,229,15,'San Antonio'),(2805,229,16,'San Francisco'),(2806,229,17,'San Isidro'),(2807,229,18,'San José del Amparo'),(2808,229,19,'San Macario'),(2809,229,20,'Santa Cecilia'),(2810,229,21,'Trinidad'),(2811,229,22,'Vasconia.'),(2812,230,01,'Botijo'),(2813,230,02,'Chimurria'),(2814,230,03,'Colonia París'),(2815,230,04,'Coquitales'),(2816,230,05,'Gallo Pinto (Parte)'),(2817,230,06,'Lirios'),(2818,230,07,'Lucha'),(2819,230,08,'Montealegre (Parte)'),(2820,230,09,'Pueblo Nuevo'),(2821,230,10,'San Humberto'),(2822,230,11,'San Isidro'),(2823,230,12,'San Jorge'),(2824,230,13,'San Rafael'),(2825,230,14,'Terranova'),(2826,230,15,'Tigra'),(2827,230,16,'Zamba.'),(2828,231,01,'Cabaña (parte)'),(2829,231,02,'Costa Ana'),(2830,231,03,'El Cruce'),(2831,231,04,'Guayabito'),(2832,231,05,'Mónico'),(2833,231,06,'Samén Abajo'),(2834,231,07,'San José'),(2835,231,08,'Thiales'),(2836,231,09,'Valle del Río.'),(2837,232,01,'Altagracia'),(2838,232,02,'Alto Sahíno'),(2839,232,03,'Bajo Cartagos'),(2840,232,04,'Pato'),(2841,232,05,'Pejibaye'),(2842,232,06,'Pimiento'),(2843,232,07,'Quebradón.'),(2844,233,01,'Cabaña (parte)'),(2845,233,02,'Colonia Naranjeña'),(2846,233,03,'El Valle'),(2847,233,04,'Florida'),(2848,233,05,'Las Letras'),(2849,233,06,'La Paz'),(2850,233,07,'La Unión'),(2851,233,08,'Llano Bonito 1'),(2852,233,09,'Llano Bonito 2'),(2853,233,10,'Palmera'),(2854,233,11,'Río Celeste'),(2855,233,12,'Tujankir 1'),(2856,233,13,'Tujankir 2.'),(2857,234,01,'Ángeles'),(2858,234,02,'Asís'),(2859,234,03,'Brisas'),(2860,234,04,'Calvario'),(2861,234,05,'Cerrillos'),(2862,234,06,'Corazón de Jesús'),(2863,234,07,'Cortinas'),(2864,234,08,'Cruz de Caravaca (parte)'),(2865,234,09,'Estadio'),(2866,234,10,'Galera'),(2867,234,11,'Hospital (parte)'),(2868,234,12,'Istarú'),(2869,234,13,'Jesús Jiménez (parte)'),(2870,234,14,'Matamoros'),(2871,234,15,'Montelimar'),(2872,234,16,'Puebla'),(2873,234,17,'Soledad'),(2874,234,18,'Telles.'),(2875,235,01,'Cinco Esquinas'),(2876,235,02,'Fátima'),(2877,235,03,'Hospital (parte)'),(2878,235,04,'Jesús Jiménez (parte)'),(2879,235,05,'Laborio'),(2880,235,06,'Molino'),(2881,235,07,'Murillo'),(2882,235,08,'Palmas'),(2883,235,09,'San Cayetano.'),(2884,236,01,'Alpes'),(2885,236,02,'Asilo'),(2886,236,03,'Cruz de Caravaca (parte)'),(2887,236,04,'Diques'),(2888,236,05,'Fontana'),(2889,236,06,'Jora'),(2890,236,07,'López'),(2891,236,08,'San Blas'),(2892,236,09,'Santa Eduvigis'),(2893,236,10,'Santa Fe'),(2894,236,11,'Solano'),(2895,236,12,'Turbina.'),(2896,237,01,'Alto de Ochomogo'),(2897,237,02,'Angelina'),(2898,237,00,'Caracol'),(2899,237,03,'Banderilla'),(2900,237,00,'Cooperrosales'),(2901,237,04,'Cruz'),(2902,237,00,'Kerkua'),(2903,237,05,'Espinal'),(2904,237,00,'Molina'),(2905,237,06,'Johnson'),(2906,237,00,'Poroses.'),(2907,237,07,'Lima'),(2908,237,08,'Loyola'),(2909,237,09,'Nazareth'),(2910,237,10,'Ochomogo'),(2911,237,11,'Orontes'),(2912,237,12,'Pedregal'),(2913,237,13,'Quircot'),(2914,237,14,'Ronda'),(2915,237,15,'Rosas'),(2916,237,16,'San Nicolás'),(2917,237,17,'Violín.'),(2918,238,01,'Cocorí'),(2919,238,02,'Coronado'),(2920,238,03,'Guayabal (parte)'),(2921,238,04,'Hervidero'),(2922,238,05,'López'),(2923,238,06,'Lourdes'),(2924,238,07,'Padua'),(2925,238,08,'Pitahaya.'),(2926,238,09,'Barro Morado'),(2927,238,10,'Cenicero'),(2928,238,11,'Muñeco'),(2929,238,12,'Navarrito.'),(2930,239,01,'Américas'),(2931,239,02,'Higuerón'),(2932,239,03,'Joya'),(2933,239,04,'Marías'),(2934,239,05,'Las Palmas.'),(2935,240,01,'Alumbre'),(2936,240,02,'Bajo Amador'),(2937,240,03,'Calle Valverdes'),(2938,240,04,'Guaria'),(2939,240,05,'Hortensia'),(2940,240,06,'Loma Larga'),(2941,240,07,'Llano Ángeles'),(2942,240,08,'Palangana'),(2943,240,09,'Rincón de Abarca'),(2944,240,10,'Río Conejo'),(2945,240,11,'Salitrillo'),(2946,240,12,'San Antonio'),(2947,240,13,'San Joaquín'),(2948,240,14,'San Juan Norte'),(2949,240,15,'San Juan Sur'),(2950,240,16,'Santa Elena (parte)'),(2951,240,17,'Santa Elena Arriba.'),(2952,241,01,'Cuesta de Piedra'),(2953,241,02,'Misión Norte'),(2954,241,03,'Misión Sur'),(2955,241,04,'Ortiga'),(2956,241,05,'Rodeo'),(2957,241,06,'Sabanilla'),(2958,241,07,'Sabanillas'),(2959,241,08,'Santísima Trinidad.'),(2960,242,01,'Caballo Blanco (parte)'),(2961,242,02,'San José.'),(2962,242,03,'Cóncavas'),(2963,242,04,'Navarro'),(2964,242,05,'Perlas'),(2965,242,06,'Río Claro.'),(2966,243,01,'Azahar.'),(2967,243,02,'Avance'),(2968,243,03,'Barquero'),(2969,243,04,'Cañada'),(2970,243,05,'Laguna'),(2971,243,06,'Pénjamo'),(2972,243,07,'Rodeo.'),(2973,244,01,'Alto Quebradilla'),(2974,244,02,'Azahar'),(2975,244,03,'Bermejo'),(2976,244,04,'Cañada'),(2977,244,05,'Copalchí'),(2978,244,06,'Coris'),(2979,244,07,'Garita (parte)'),(2980,244,08,'Rueda'),(2981,244,09,'Valle Verde.'),(2982,245,01,'Barro Hondo'),(2983,245,02,'Cruz Roja'),(2984,245,03,'Cucaracho'),(2985,245,04,'Chiverre'),(2986,245,05,'Estación'),(2987,245,06,'Joya'),(2988,245,07,'Pandora'),(2989,245,08,'Piedra Grande'),(2990,245,09,'Solares'),(2991,245,10,'Soledad'),(2992,245,11,'Veintiocho de Diciembre.'),(2993,245,12,'Alto Birrisito'),(2994,245,13,'Birrisito'),(2995,245,14,'Chiral'),(2996,245,15,'Luisiana'),(2997,245,16,'Sanchirí'),(2998,245,17,'Ujarrás'),(2999,245,18,'Villa Isabel'),(3000,245,19,'Rincón.'),(3001,246,01,'Acevedo'),(3002,246,02,'Ajenjal'),(3003,246,03,'Arrabará'),(3004,246,04,'Birrís (este)'),(3005,246,05,'Cúscares'),(3006,246,06,'Flor'),(3007,246,07,'Lapuente'),(3008,246,08,'Mesas'),(3009,246,09,'Mesitas'),(3010,246,10,'Nueva Ujarrás'),(3011,246,11,'Pedregal'),(3012,246,12,'Piedra Azul'),(3013,246,13,'Puente Fajardo'),(3014,246,14,'Río Regado'),(3015,246,15,'Talolinga'),(3016,246,16,'Yas.'),(3017,247,01,'Alegría'),(3018,247,02,'Alto Araya'),(3019,247,03,'Calle Jucó'),(3020,247,04,'Hotel'),(3021,247,05,'Nubes'),(3022,247,06,'Palomas'),(3023,247,07,'Palomo'),(3024,247,08,'Patillos'),(3025,247,09,'Puente Negro'),(3026,247,10,'Purisil'),(3027,247,11,'Queverí'),(3028,247,12,'Río Macho'),(3029,247,13,'San Rafael'),(3030,247,14,'Sitio'),(3031,247,15,'Tapantí'),(3032,247,16,'Troya'),(3033,247,17,'Villa Mills.'),(3034,248,01,'Peñas Blancas'),(3035,248,02,'Pueblo Nuevo.'),(3036,248,03,'Bajos de Dorotea'),(3037,248,04,'Bajos de Urasca'),(3038,248,05,'Guábata'),(3039,248,06,'Guatusito'),(3040,248,07,'Hamaca (parte)'),(3041,248,08,'Joyas'),(3042,248,09,'Loaiza'),(3043,248,10,'San Jerónimo'),(3044,248,11,'Urasca'),(3045,248,12,'Volio.'),(3046,249,01,'Ayala'),(3047,249,02,'Páez (parte)'),(3048,249,03,'Salvador.'),(3049,250,01,'Antigua'),(3050,250,02,'Villas.'),(3051,251,01,'Eulalia'),(3052,251,02,'Florencio del Castillo'),(3053,251,03,'Jirales'),(3054,251,04,'Mariana'),(3055,251,05,'Tacora.'),(3056,251,06,'Rincón Mesén (parte)'),(3057,251,07,'Santiago del Monte.'),(3058,252,01,'Araucarias (parte)'),(3059,252,02,'Danza del Sol'),(3060,252,03,'Herrán'),(3061,252,04,'Loma Verde'),(3062,252,05,'Unión'),(3063,252,06,'Villas de Ayarco.'),(3064,253,01,'Carpintera'),(3065,253,02,'San Miguel'),(3066,253,03,'San Vicente'),(3067,253,04,'Pilarica.'),(3068,253,05,'Quebrada del Fierro'),(3069,253,06,'Fierro'),(3070,253,07,'Yerbabuena.'),(3071,254,01,'Cima'),(3072,254,02,'Cuadrante'),(3073,254,03,'Lirios'),(3074,254,04,'Llanos de Concepción'),(3075,254,05,'Naranjal (parte)'),(3076,254,06,'Poró'),(3077,254,07,'Salitrillo'),(3078,254,08,'San Francisco'),(3079,254,09,'San Josecito (parte).'),(3080,255,01,'Alto del Carmen'),(3081,255,02,'Tirrá.'),(3082,256,01,'Bellomonte'),(3083,256,02,'Cerrillo'),(3084,256,03,'Cumbres'),(3085,256,04,'Holandés'),(3086,256,05,'Mansiones (parte)'),(3087,256,06,'Montaña Rusa (parte)'),(3088,256,07,'Naranjal (parte)'),(3089,256,08,'San  Josecito (parte).'),(3090,257,01,'Lindavista (Loma Gobierno).'),(3091,257,02,'Quebradas'),(3092,257,03,'Rincón Mesén (parte).'),(3093,258,01,'Alpes'),(3094,258,02,'Buenos Aires'),(3095,258,03,'Maravilla'),(3096,258,04,'Naranjito'),(3097,258,05,'Naranjo'),(3098,258,06,'San Martín.'),(3099,258,07,'Durán'),(3100,258,08,'Gloria'),(3101,258,09,'Quebrada Honda'),(3102,258,10,'Santa Elena'),(3103,258,11,'Santa Marta'),(3104,258,12,'Victoria (Alto Victoria).'),(3105,259,01,'Alto Campos'),(3106,259,02,'Bajo Congo'),(3107,259,03,'Congo'),(3108,259,04,'Duan'),(3109,259,05,'Esperanza'),(3110,259,06,'Hamaca (parte)'),(3111,259,07,'Sabanilla'),(3112,259,08,'San Antonio del Monte'),(3113,259,09,'Volconda'),(3114,259,10,'Vueltas.'),(3115,260,01,'Alto Humo'),(3116,260,02,'Cacao'),(3117,260,03,'Cantarrana'),(3118,260,04,'Casa de Teja'),(3119,260,05,'Ceiba'),(3120,260,06,'Chucuyo'),(3121,260,07,'Esperanza'),(3122,260,08,'Gato'),(3123,260,09,'Humo'),(3124,260,10,'Joyas'),(3125,260,11,'Juray'),(3126,260,12,'Omega'),(3127,260,13,'Oriente'),(3128,260,14,'San Gerardo'),(3129,260,15,'Selva'),(3130,260,16,'Taus'),(3131,260,17,'Tausito'),(3132,260,18,'Yolanda'),(3133,260,19,'Zapote.'),(3134,261,01,'Américas'),(3135,261,02,'Ángeles'),(3136,261,03,'Cabiria'),(3137,261,04,'Campabadal'),(3138,261,05,'Castro Salazar'),(3139,261,06,'Cementerio'),(3140,261,07,'Clorito Picado'),(3141,261,08,'Dominica'),(3142,261,09,'El Silencio'),(3143,261,10,'Guaria'),(3144,261,11,'Haciendita'),(3145,261,12,'Margot'),(3146,261,13,'Nochebuena'),(3147,261,14,'Numa'),(3148,261,15,'Pastor'),(3149,261,16,'Poró'),(3150,261,17,'Pueblo Nuevo'),(3151,261,18,'Repasto'),(3152,261,19,'San Cayetano'),(3153,261,20,'San Rafael'),(3154,261,21,'Sictaya.'),(3155,261,22,'Bajo Barrientos'),(3156,261,23,'Cañaveral'),(3157,261,24,'Colorado'),(3158,261,25,'Chiz'),(3159,261,26,'Esmeralda'),(3160,261,27,'Florencia'),(3161,261,28,'Murcia'),(3162,261,29,'Pavas'),(3163,261,30,'Recreo'),(3164,261,31,'Roncha'),(3165,261,32,'San Juan Norte'),(3166,261,33,'San Juan Sur.'),(3167,262,01,'Leona (parte).'),(3168,262,02,'Abelardo Rojas'),(3169,262,03,'Alto Alemania'),(3170,262,04,'Atirro'),(3171,262,05,'Balalaica'),(3172,262,06,'Buenos Aires'),(3173,262,07,'Canadá'),(3174,262,08,'Carmen'),(3175,262,09,'Cruzada'),(3176,262,10,'Danta'),(3177,262,11,'Gaviotas'),(3178,262,12,'Guadalupe'),(3179,262,13,'Máquina Vieja'),(3180,262,14,'Margarita'),(3181,262,15,'Mollejones'),(3182,262,16,'Pacayitas'),(3183,262,17,'Pacuare'),(3184,262,18,'Piedra Grande'),(3185,262,19,'Porvenir de la Esperanza'),(3186,262,20,'Puente Alto'),(3187,262,21,'San Vicente'),(3188,262,22,'Selva (parte)'),(3189,262,23,'Silencio'),(3190,262,24,'Sonia.'),(3191,263,01,'El Seis.'),(3192,264,01,'Bajos de Bonilla'),(3193,264,02,'Bolsón (parte)'),(3194,264,03,'Bonilla'),(3195,264,04,'Buenos Aires'),(3196,264,05,'Calle Vargas'),(3197,264,06,'Carmen (parte)'),(3198,264,07,'Esperanza'),(3199,264,08,'Guayabo Arriba'),(3200,264,09,'La Central'),(3201,264,10,'La Fuente'),(3202,264,11,'Pastora'),(3203,264,12,'Picada'),(3204,264,13,'Raicero'),(3205,264,14,'Reunión'),(3206,264,15,'San Antonio'),(3207,264,16,'San Diego'),(3208,264,17,'Torito (parte).'),(3209,265,01,'Cooperativa.'),(3210,265,02,'Bonilla Arriba'),(3211,265,03,'Buenavista'),(3212,265,04,'Cas'),(3213,265,05,'Cimarrones'),(3214,265,06,'Colonia Guayabo'),(3215,265,07,'Colonia San Ramón'),(3216,265,08,'Corralón'),(3217,265,09,'Dulce Nombre'),(3218,265,10,'El Dos'),(3219,265,11,'Fuente'),(3220,265,12,'Guayabo (parte)'),(3221,265,13,'Líbano'),(3222,265,14,'Nueva Flor'),(3223,265,15,'Palomo'),(3224,265,16,'Pradera'),(3225,265,17,'Sandoval'),(3226,265,18,'Santa Tecla'),(3227,265,19,'Sauce'),(3228,265,20,'Torito (parte)'),(3229,265,21,'Torito (sur).'),(3230,266,01,'Angostura'),(3231,266,02,'Bóveda'),(3232,266,03,'Buenavista'),(3233,266,04,'Chitaría'),(3234,266,05,'Eslabón'),(3235,266,06,'Isla Bonita (parte)'),(3236,266,07,'Jabillos'),(3237,266,08,'San Rafael'),(3238,266,09,'Sitio Mata'),(3239,266,10,'Yama.'),(3240,267,01,'Leona (parte).'),(3241,267,02,'Alto Surtubal'),(3242,267,03,'Ángeles'),(3243,267,04,'Bajo Pacuare (norte)'),(3244,267,05,'Cabeza de Buey'),(3245,267,06,'Cien Manzanas'),(3246,267,07,'Colonia San Lucas'),(3247,267,08,'Colonia Silencio'),(3248,267,09,'Colonias'),(3249,267,10,'Mata de Guineo'),(3250,267,11,'Nubes'),(3251,267,12,'Paulina'),(3252,267,13,'Sacro'),(3253,267,14,'San Bosco'),(3254,267,15,'Selva (parte).'),(3255,268,01,'Bajo Pacuare (sur)'),(3256,268,02,'Dos Amigos'),(3257,268,03,'Dulce Nombre'),(3258,268,04,'Guineal'),(3259,268,05,'Jicotea'),(3260,268,06,'Mina'),(3261,268,07,'Morado'),(3262,268,08,'Quebradas'),(3263,268,09,'San Martín'),(3264,268,10,'San Rafael'),(3265,268,11,'Tacotal.'),(3266,269,01,'Aquiares'),(3267,269,02,'Bolsón (parte)'),(3268,269,03,'Carmen (parte)'),(3269,269,04,'Río Claro'),(3270,269,05,'San Rafael'),(3271,269,06,'Verbena Norte'),(3272,269,07,'Verbena Sur.'),(3273,270,01,'Alto June'),(3274,270,02,'Corozal'),(3275,270,03,'Flor'),(3276,270,04,'Guanacasteca'),(3277,270,05,'Isla Bonita(parte)'),(3278,270,06,'Pilón de Azúcar'),(3279,270,07,'San Pablo'),(3280,270,08,'Sol.'),(3281,271,01,'Azul'),(3282,271,02,'Ánimas'),(3283,271,03,'Alto de Varas (Alto Varal)'),(3284,271,04,'Guayabo (parte)'),(3285,271,05,'Jesús María'),(3286,271,06,'La Isabel'),(3287,271,07,'San Martín.'),(3288,272,01,'Carolina'),(3289,272,02,'Chirripó Abajo (parte)'),(3290,272,03,'Chirripó Arriba'),(3291,272,04,'Damaris'),(3292,272,05,''),(3293,272,06,'Fortuna'),(3294,272,07,'Jekui'),(3295,272,08,'Moravia'),(3296,272,09,'Namaldí'),(3297,272,10,'Pacuare arriba'),(3298,272,11,'Paso Marcos'),(3299,272,12,'Tsipiri (Platanillo)'),(3300,272,13,'Playa Hermosa'),(3301,272,14,'Porvenir'),(3302,272,15,'Raíz de Hule'),(3303,272,16,'Río Blanco'),(3304,272,17,'Santubal'),(3305,272,18,'Surí'),(3306,272,19,'Vereh'),(3307,272,20,'Quetzal.'),(3308,273,01,'Lourdes'),(3309,273,02,'Patalillo.'),(3310,273,03,'Buenavista'),(3311,273,04,'Buenos Aires'),(3312,273,05,'Charcalillos'),(3313,273,06,'Encierrillo'),(3314,273,07,'Los Pinos (Coliblanco)'),(3315,273,08,'Llano Grande'),(3316,273,09,'Pascón'),(3317,273,10,'Pastora'),(3318,273,11,'Plantón'),(3319,273,12,'San Martín (Irazú Sur)'),(3320,273,13,'San Rafael de Irazú.'),(3321,274,01,'Bajo Malanga'),(3322,274,02,'Aguas (parte)'),(3323,274,03,'Bajo Solano'),(3324,274,04,'Ciudad del Cielo'),(3325,274,05,'Descanso'),(3326,274,06,'El Alto'),(3327,274,07,'Mata de Guineo'),(3328,274,08,'Monticel.'),(3329,275,01,'Bajo Abarca'),(3330,275,02,'Lourdes (Callejón)'),(3331,275,03,'Coliblanco'),(3332,275,04,'Santa Teresa.'),(3333,276,01,'Alto Cerrillos (Corazón de Jesús)'),(3334,276,02,'Artavia'),(3335,276,03,'Barrial'),(3336,276,04,'Bosque'),(3337,276,05,'Breñas'),(3338,276,06,'Caballo Blanco (parte)'),(3339,276,07,'Chircagre'),(3340,276,08,'Flores'),(3341,276,09,'Gamboa'),(3342,276,10,'José Jesús Méndez'),(3343,276,11,'Juan Pablo II'),(3344,276,12,'Sagrada Familia'),(3345,276,13,'Monseñor Sanabria.'),(3346,276,14,'Cuesta Chinchilla'),(3347,276,15,'Llano.'),(3348,277,01,'Mata de Mora'),(3349,277,02,'Páez (parte)'),(3350,277,03,'Paso Ancho'),(3351,277,04,'San Cayetano.'),(3352,278,01,'Maya'),(3353,278,02,'Cruce'),(3354,278,03,'Pisco'),(3355,278,04,'Sanabria'),(3356,278,05,'San Juan de Chicuá.'),(3357,279,01,'Aguas (parte)'),(3358,279,02,'Barrionuevo'),(3359,279,03,'Boquerón'),(3360,279,04,'Capira'),(3361,279,05,'Oratorio.'),(3362,280,01,'Cuesta Quemados'),(3363,280,02,'Pasquí'),(3364,280,03,'Platanillal'),(3365,280,04,'San Gerardo'),(3366,280,05,'San Juan'),(3367,280,06,'San Martín'),(3368,280,07,'San Pablo'),(3369,280,08,'Titoral.'),(3370,281,01,'Asunción'),(3371,281,02,'Barahona'),(3372,281,03,'Barrio Nuevo'),(3373,281,04,'Colonia'),(3374,281,05,'Chavarría'),(3375,281,06,'Sabana'),(3376,281,07,'Sabana Grande'),(3377,281,08,'San Rafael'),(3378,281,09,'Santa Gertrudis'),(3379,281,10,'Sauces'),(3380,281,11,'Silo'),(3381,281,12,'Viento Fresco.'),(3382,282,01,'Guatuso'),(3383,282,02,'Higuito'),(3384,282,03,'Potrerillos.'),(3385,282,04,'Altamiradas'),(3386,282,05,'Alto San Francisco'),(3387,282,06,'Bajo Gloria'),(3388,282,07,'Bajos de León'),(3389,282,08,'Barrancas (parte)'),(3390,282,09,'Cangreja'),(3391,282,10,'Cañón (parte)'),(3392,282,11,'Casablanca'),(3393,282,12,'Casamata'),(3394,282,13,'Cascajal'),(3395,282,14,'Conventillo'),(3396,282,15,'Cruces'),(3397,282,16,'Cruz'),(3398,282,17,'Chonta (parte)'),(3399,282,18,'Damita'),(3400,282,19,'Dos Amigos'),(3401,282,20,'Empalme (parte)'),(3402,282,21,'Esperanza'),(3403,282,22,'Estrella'),(3404,282,23,'Guayabal (parte)'),(3405,282,24,'La Luchita'),(3406,282,25,'La Paz'),(3407,282,26,'Macho Gaff'),(3408,282,27,'Montserrat'),(3409,282,28,'Ojo de Agua (parte)'),(3410,282,29,'Palmital'),(3411,282,30,'Palmital Sur'),(3412,282,31,'Palo Verde'),(3413,282,32,'Paso Macho (parte)'),(3414,282,33,'Purires (parte)'),(3415,282,34,'Salsipuedes (parte)'),(3416,282,35,'San Cayetano'),(3417,282,36,'Surtubal'),(3418,282,37,'Tres de Junio'),(3419,282,38,'Vara del Roble.'),(3420,283,01,'Achiotillo'),(3421,283,02,'Barrancas (parte)'),(3422,283,03,'Bodocal'),(3423,283,04,'Garita (parte)'),(3424,283,05,'Purires (parte)'),(3425,283,06,'Tablón.'),(3426,284,01,'Bajo Zopilote'),(3427,284,02,'Caragral'),(3428,284,03,'Común.'),(3429,285,01,'Ángeles'),(3430,285,02,'Carmen'),(3431,285,03,'Corazón de Jesús'),(3432,285,04,'Chino'),(3433,285,05,'Estadio'),(3434,285,06,'Fátima'),(3435,285,07,'Guayabal'),(3436,285,08,'La India'),(3437,285,09,'Lourdes'),(3438,285,10,'Hospital'),(3439,285,11,'María Auxiliadora (parte)'),(3440,285,12,'Oriente'),(3441,285,13,'Pirro'),(3442,285,14,'Puebla (parte)'),(3443,285,15,'Rancho Chico'),(3444,285,16,'San Fernando'),(3445,285,17,'San Vicente.'),(3446,286,01,'Burío'),(3447,286,02,'Carbonal'),(3448,286,03,'Cubujuquí'),(3449,286,04,'España'),(3450,286,05,'Labrador'),(3451,286,06,'Mercedes Sur'),(3452,286,07,'Monte Bello'),(3453,286,08,'San Jorge'),(3454,286,09,'Santa Inés.'),(3455,287,01,'Aries'),(3456,287,02,'Aurora (parte)'),(3457,287,03,'Bernardo Benavides'),(3458,287,04,'Chucos'),(3459,287,05,'El Cristo (parte)'),(3460,287,06,'Esmeralda'),(3461,287,07,'Esperanza'),(3462,287,08,'Granada'),(3463,287,09,'Gran Samaria'),(3464,287,10,'Guararí'),(3465,287,11,'Lagos'),(3466,287,12,'Malinches'),(3467,287,13,'Mayorga (parte)'),(3468,287,14,'Nísperos 3'),(3469,287,15,'Palma'),(3470,287,16,'Trébol'),(3471,287,17,'Tropical.'),(3472,288,01,'Arcos'),(3473,288,02,'Aurora (parte)'),(3474,288,03,'Bajos del Virilla (San Rafael)'),(3475,288,04,'Cariari (parte)'),(3476,288,05,'Carpintera'),(3477,288,06,'El Cristo (parte)'),(3478,288,07,'Lagunilla'),(3479,288,08,'Linda del Norte'),(3480,288,09,'Mayorga (parte)'),(3481,288,10,'Monterrey'),(3482,288,11,'Pitahaya'),(3483,288,12,'Pueblo Nuevo'),(3484,288,13,'Valencia (parte)'),(3485,288,14,'Vista Nosara.'),(3486,289,01,'Jesús María'),(3487,289,02,'Legua'),(3488,289,03,'Legua de Barva'),(3489,289,04,'Montaña Azul'),(3490,289,05,'San Rafael'),(3491,289,06,'Virgen del Socorro (parte).'),(3492,290,01,'Don Abraham'),(3493,290,02,'San Bartolomé.'),(3494,291,01,'Bosque'),(3495,291,02,'Calle Amada'),(3496,291,03,'Calle Los Naranjos'),(3497,291,04,'Espinos'),(3498,291,05,'Máquina'),(3499,291,06,'Mirador'),(3500,291,07,'Morazán'),(3501,291,08,'Puente Salas'),(3502,291,09,'Segura'),(3503,291,10,'Vista Llana.'),(3504,292,01,'Barrios (Barva): Cementerio'),(3505,292,02,'Ibís.'),(3506,292,03,'Buenavista.'),(3507,293,01,'Bello Higuerón'),(3508,293,02,'Los Luises'),(3509,293,03,'Plantación'),(3510,293,04,'Pórtico.'),(3511,294,01,'Doña Iris'),(3512,294,02,'Jardines del Beneficio'),(3513,294,03,'Paso Viga (parte)'),(3514,294,04,'Pedregal.'),(3515,294,05,'Getsemaní (parte)'),(3516,294,06,'Palmar (parte).'),(3517,295,01,'Gallito'),(3518,295,02,'Monte Alto'),(3519,295,03,'Cipresal'),(3520,295,04,'Doña Blanca'),(3521,295,05,'Doña Elena'),(3522,295,06,'Higuerón'),(3523,295,07,'Huacalillo'),(3524,295,08,'El Collado'),(3525,295,09,'Meseta'),(3526,295,10,'Paso Llano'),(3527,295,11,'Plan de Birrí'),(3528,295,12,'Porrosatí'),(3529,295,13,'Roblealto'),(3530,295,14,'Sacramento'),(3531,295,15,'San Martín'),(3532,295,16,'San Miguel'),(3533,295,17,'Santa Clara'),(3534,295,18,'Zapata.'),(3535,296,01,'Barro de Olla'),(3536,296,02,'Calle Don Pedro'),(3537,296,03,'Quintana'),(3538,296,04,'Yurusti.'),(3539,297,01,'Canoa (parte)'),(3540,297,02,'Castilla'),(3541,297,03,'Cuesta Rojas'),(3542,297,04,'Montero'),(3543,297,05,'Socorro'),(3544,297,06,'Villa Rossi.'),(3545,298,01,'Represa.'),(3546,299,01,'Barquero'),(3547,299,02,'Higinia'),(3548,299,03,'Pacífica.'),(3549,300,01,'La Cooperativa'),(3550,300,02,'Pedro León'),(3551,300,03,'Primero de Mayo'),(3552,300,04,'Quisqueya'),(3553,300,05,'Rinconada'),(3554,300,06,'Valencia (parte).'),(3555,301,01,'Calle Vieja'),(3556,301,02,'Lourdes'),(3557,301,03,'Quebradas (parte).'),(3558,302,01,'Caballero.'),(3559,302,02,'Canoa (parte).'),(3560,303,01,'Trompezón.'),(3561,304,01,'Betania'),(3562,304,02,'Rosales (parte).'),(3563,305,01,'Cinco Esquinas'),(3564,305,02,'Lotes Moreira'),(3565,305,03,'San Juan Arriba'),(3566,306,01,'Altagracia'),(3567,306,02,'Birrí'),(3568,306,03,'Calle Quirós (parte)'),(3569,306,04,'Catalina'),(3570,306,05,'Común (parte)'),(3571,306,06,'Cuesta Colorada'),(3572,306,07,'Guachipelines'),(3573,306,08,'Guaracha'),(3574,306,09,'Ulises.'),(3575,307,01,'Amapola'),(3576,307,02,'Cartagos'),(3577,307,03,'Chagüite'),(3578,307,04,'Giralda'),(3579,307,05,'Guararí'),(3580,307,06,'Tranquera.'),(3581,308,01,'Marías'),(3582,308,02,'Purabá'),(3583,308,03,'San Bosco.'),(3584,308,04,'Calle Quirós (parte)'),(3585,308,05,'Común (parte)'),(3586,308,06,'Lajas.'),(3587,309,01,'Amistad'),(3588,309,02,'Matasano (parte)'),(3589,309,03,'Paso Viga (parte).'),(3590,310,01,'Bajo Molinos'),(3591,310,02,'Joya'),(3592,310,03,'Matasano (parte)'),(3593,310,04,'Peralta'),(3594,310,05,'Santísima Trinidad.'),(3595,311,01,'Jardines de Roma'),(3596,311,02,'Jardines Universitarios'),(3597,311,03,'Suiza.'),(3598,312,01,'Paso Viga (parte)'),(3599,312,02,'Saca.'),(3600,312,03,'Calle Hernández (parte)'),(3601,312,04,'Castillo'),(3602,312,05,'Cerro Redondo'),(3603,312,06,'Getsemaní (parte)'),(3604,312,07,'Joaquina'),(3605,312,08,'Lobos'),(3606,312,09,'Montecito'),(3607,312,10,'Palmar (parte)'),(3608,312,11,'Puente Piedra (parte)'),(3609,312,12,'Quintanar de la Sierra'),(3610,312,13,'Uvita.'),(3611,313,01,'Palenque'),(3612,313,02,'Anonos'),(3613,313,03,'Burial'),(3614,313,04,'Calle Chávez (parte)'),(3615,313,05,'Calle Hernández (parte)'),(3616,313,06,'Ciénagas'),(3617,313,07,'Charquillo'),(3618,313,08,'Mora'),(3619,313,09,'Pilas'),(3620,313,10,'Puente Piedra (parte)'),(3621,313,11,'Tierra Blanca (parte)'),(3622,313,12,'Turú.'),(3623,314,01,'Calle Cementerio'),(3624,314,02,'Colonia Isidreña'),(3625,314,03,'Cooperativa'),(3626,314,04,'Cristo Rey'),(3627,314,05,'El Volador'),(3628,314,06,'Villaval.'),(3629,315,01,'Santa Cruz.'),(3630,315,02,'El Arroyo'),(3631,315,03,'Huacalillos'),(3632,315,04,'Santa Cecilia (parte)'),(3633,315,05,'Santa Elena'),(3634,315,06,'Trapiche'),(3635,315,07,'Yerbabuena.'),(3636,316,01,'Alhajas'),(3637,316,02,'Calle Caricias'),(3638,316,03,'Calle Chávez (parte)'),(3639,316,04,'Santa Cecilia'),(3640,317,01,'Aguacate'),(3641,317,02,'Astillero'),(3642,317,03,'Quebradas (parte)'),(3643,317,04,'Rinconada'),(3644,317,05,'Tierra Blanca             (parte)'),(3645,317,06,'Vallevistar'),(3646,317,07,'Viento Fresco.'),(3647,318,01,'Chompipes (parte)'),(3648,318,02,'Escobal'),(3649,318,03,'Labores (parte)'),(3650,318,04,'San Vicente'),(3651,318,05,'Zaiquí.'),(3652,319,01,'Fuente'),(3653,319,02,'Labores (parte)'),(3654,319,03,'Vista Linda'),(3655,319,04,'Cristo Rey (parte).'),(3656,319,05,'Echeverría (parte).'),(3657,320,01,'Arbolito'),(3658,320,02,'Bonanza'),(3659,320,03,'Bosques de Doña Rosa'),(3660,320,04,'Cariari (parte)'),(3661,320,05,'Chompipes (parte)'),(3662,320,06,'Cristo Rey (parte).'),(3663,321,01,'Campanario'),(3664,321,02,'Joaquineños'),(3665,321,03,'Luisiana'),(3666,321,04,'Santa Marta'),(3667,321,05,'Trinidad'),(3668,321,06,'Villa Lico'),(3669,321,07,'Villa María.'),(3670,322,01,'Barrantes'),(3671,322,02,'Ugalde.'),(3672,323,01,'Ángeles'),(3673,323,02,'Año 2000'),(3674,323,03,'Cristo Rey (parte)'),(3675,323,04,'Geranios'),(3676,323,05,'Las Hadas'),(3677,323,06,'Santa Elena'),(3678,323,07,'Siglo Veintiuno.'),(3679,323,08,'Echeverría (parte).'),(3680,324,01,'Acapulco'),(3681,324,02,'Amada'),(3682,324,03,'Asovigui'),(3683,324,04,'Colonial'),(3684,324,05,'Cruces'),(3685,324,06,'Doña Nina'),(3686,324,07,'Irazú'),(3687,324,08,'Irma'),(3688,324,09,'July'),(3689,324,10,'María Auxiliadora (parte)'),(3690,324,11,'Nueva Jerusalén'),(3691,324,12,'Pastoras'),(3692,324,13,'Puebla (parte)'),(3693,324,14,'Santa Isabel'),(3694,324,15,'Villa Cortés'),(3695,324,16,'Villa Dolores'),(3696,324,17,'Villa Quintana'),(3697,324,18,'Uriche'),(3698,324,19,'Uruca.'),(3699,324,20,'Corobicí'),(3700,324,21,'Estrella'),(3701,324,22,'Rincón de Ricardo'),(3702,324,23,'Santa Fe.'),(3703,325,01,'Colina'),(3704,325,02,'Esperanza'),(3705,325,03,'Jardín'),(3706,325,04,'Loma Linda'),(3707,325,05,'Progreso.'),(3708,325,06,'Achiote'),(3709,325,07,'Ahogados'),(3710,325,08,'Arbolitos (parte)'),(3711,325,09,'Arrepentidos'),(3712,325,10,'Boca Ceiba'),(3713,325,11,'Boca Río Sucio'),(3714,325,12,'Bun'),(3715,325,13,'Cabezas'),(3716,325,14,'Canfín'),(3717,325,15,'Caño Negro'),(3718,325,16,'Cerro Negro (Parte)'),(3719,325,17,'Colonia San José'),(3720,325,18,'Coyol'),(3721,325,19,'Cristo Rey'),(3722,325,20,'Chilamate'),(3723,325,21,'El Progreso'),(3724,325,22,'Esperanza'),(3725,325,23,'Estrellales'),(3726,325,24,'Guaria'),(3727,325,25,'Jardín'),(3728,325,26,'Jormo'),(3729,325,27,'Las Marías'),(3730,325,28,'Las Orquídeas'),(3731,325,29,'Los Lirios'),(3732,325,30,'Malinche'),(3733,325,31,'Media Vuelta'),(3734,325,32,'Medias (parte)'),(3735,325,33,'Muelle'),(3736,325,34,'Naranjal'),(3737,325,35,'Nogal'),(3738,325,36,'Pavas'),(3739,325,37,'Rojomaca'),(3740,325,38,'San José'),(3741,325,39,'San Julián'),(3742,325,40,'Tres Rosales'),(3743,325,41,'Vega de Sardinal (parte)'),(3744,325,42,'Zapote.'),(3745,326,01,'Ángeles'),(3746,326,02,'Arbolitos (parte)'),(3747,326,03,'Bajos de Chilamate'),(3748,326,04,'Boca Sardinal'),(3749,326,05,'Bosque'),(3750,326,06,'Búfalo'),(3751,326,07,'Delicias'),(3752,326,08,'El Uno'),(3753,326,09,'Esquipulas'),(3754,326,10,'Las Palmitas'),(3755,326,11,'Laquí'),(3756,326,12,'Lomas'),(3757,326,13,'Llano Grande'),(3758,326,14,'Magsaysay'),(3759,326,15,'Masaya'),(3760,326,16,'Medias (parte)'),(3761,326,17,'Pangola'),(3762,326,18,'Pozo Azul'),(3763,326,19,'Quebrada Grande'),(3764,326,20,'Río Magdaleno'),(3765,326,21,'Roble'),(3766,326,22,'San Gerardo (parte)'),(3767,326,23,'San Isidro'),(3768,326,24,'San José Sur'),(3769,326,25,'San Ramón'),(3770,326,26,'La Delia'),(3771,326,27,'Sardinal'),(3772,326,28,'Tirimbina'),(3773,326,29,'Vega de Sardinal (parte)'),(3774,326,30,'Venados.'),(3775,327,01,'Bambuzal'),(3776,327,02,'Cerro Negro (parte)'),(3777,327,03,'Colonia Bambú'),(3778,327,04,'Colonia Colegio'),(3779,327,05,'Colonia Esperanza'),(3780,327,06,'Colonia Huetar'),(3781,327,07,'Colonia Nazareth'),(3782,327,08,'Colonia Victoria'),(3783,327,09,'Colonia Villalobos'),(3784,327,10,'Cubujuquí'),(3785,327,11,'Chiripa'),(3786,327,12,'Fátima'),(3787,327,13,'Flaminia'),(3788,327,14,'Finca Uno'),(3789,327,15,'Finca Dos'),(3790,327,16,'Finca Tres'),(3791,327,17,'Finca Cinco'),(3792,327,18,'Finca Agua'),(3793,327,19,'Finca Zona Siete'),(3794,327,20,'Finca Zona Ocho'),(3795,327,21,'Finca Zona Diez'),(3796,327,22,'Finca Zona Once'),(3797,327,23,'Isla'),(3798,327,24,'Isla Grande'),(3799,327,25,'Isla Israel'),(3800,327,26,'La Conquista'),(3801,327,27,'La Chávez'),(3802,327,28,'La Vuelta'),(3803,327,29,'Rambla'),(3804,327,30,'Pedernales'),(3805,327,31,'Platanera'),(3806,327,32,'Río Frío'),(3807,327,33,'San Bernardino'),(3808,327,34,'San Luis'),(3809,327,35,'Santa Clara'),(3810,327,36,'Tapa Viento'),(3811,327,37,'Ticarí'),(3812,327,38,'Tigre'),(3813,327,39,'Villa Isabel'),(3814,327,40,'Villa Nueva.'),(3815,328,01,'Caño San Luis'),(3816,328,02,'Chimurria'),(3817,328,03,'Chirriposito'),(3818,328,04,'Delta'),(3819,328,05,'Gaspar'),(3820,328,06,'Lagunilla'),(3821,328,07,'La Lucha'),(3822,328,08,'Tigra.'),(3823,329,01,'Caño Tambor'),(3824,329,02,'Copalchí'),(3825,329,03,'Cureña'),(3826,329,04,'Paloseco'),(3827,329,05,'Remolinito'),(3828,329,06,'Tambor'),(3829,329,07,'Tierrabuena'),(3830,329,08,'Trinidad'),(3831,329,09,'Unión del Toro'),(3832,329,10,'Vuelta Cabo de Hornos.'),(3833,330,01,'Alaska'),(3834,330,02,'Ángeles'),(3835,330,03,'Buenos Aires'),(3836,330,04,'Capulín'),(3837,330,05,'Cerros'),(3838,330,06,'Condega'),(3839,330,07,'Corazón de Jesús'),(3840,330,08,'Curime'),(3841,330,09,'Choricera'),(3842,330,10,'Chorotega'),(3843,330,11,'Gallera'),(3844,330,12,'Guaria'),(3845,330,13,'Jícaro'),(3846,330,14,'La Carreta'),(3847,330,15,'Llano La Cruz'),(3848,330,16,'Mocho (Santa Lucía)'),(3849,330,17,'Moracia'),(3850,330,18,'Nazareth'),(3851,330,19,'Pueblo Nuevo'),(3852,330,20,'Sabanero'),(3853,330,21,'San Miguel'),(3854,330,22,'San Roque'),(3855,330,23,'Sitio'),(3856,330,24,'Veinticinco de Julio'),(3857,330,25,'Victoria'),(3858,330,26,'Villanueva.'),(3859,330,27,'Arena'),(3860,330,28,'Caraña'),(3861,330,29,'Isleta (parte)'),(3862,330,30,'Juanilama'),(3863,330,31,'Montañita'),(3864,330,32,'Paso Tempisque (parte)'),(3865,330,33,'Pelón de la Bajura'),(3866,330,34,'Polvazales'),(3867,330,35,'Roble de Sabana'),(3868,330,36,'Rodeito'),(3869,330,37,'Salto (parte)'),(3870,330,38,'San Benito'),(3871,330,39,'San Hernán'),(3872,330,40,'San Lucas'),(3873,330,41,'Santa Ana'),(3874,330,42,'Terreros'),(3875,330,43,'Zanjita.'),(3876,331,01,'Alcántaro'),(3877,331,02,'Buenavista'),(3878,331,03,'Guayacán'),(3879,331,04,'Pochote.'),(3880,331,05,'Brisas'),(3881,331,06,'Cedro'),(3882,331,07,'Congo'),(3883,331,08,'Cueva'),(3884,331,09,'Fortuna'),(3885,331,10,'Irigaray'),(3886,331,11,'Lilas'),(3887,331,12,'Pacayales'),(3888,331,13,'Panamacito'),(3889,331,14,'Pedregal'),(3890,331,15,'Pital'),(3891,331,16,'Pueblo Nuevo.'),(3892,332,01,'Lourdes'),(3893,332,02,'San Antonio.'),(3894,332,03,'Ángeles'),(3895,332,04,'Argentina'),(3896,332,05,'Buenavista'),(3897,332,06,'Consuelo.'),(3898,333,01,'Bejuco'),(3899,333,02,'Los Lagos'),(3900,333,03,'Nacascolo'),(3901,333,04,'Oratorio'),(3902,333,05,'Puerto Culebra'),(3903,333,06,'Triunfo.'),(3904,334,01,'Gallo'),(3905,334,02,'San Rafael.'),(3906,334,03,'Colorado'),(3907,334,04,'Curubandé'),(3908,334,05,'Porvenir.'),(3909,335,01,'Los Ángeles'),(3910,335,02,'Barro Negro'),(3911,335,03,'Cananga'),(3912,335,04,'Carmen'),(3913,335,05,'Chorotega'),(3914,335,06,'Guadalupe'),(3915,335,07,'Granja'),(3916,335,08,'San Martín'),(3917,335,09,'Santa Lucía'),(3918,335,10,'Virginia.'),(3919,335,11,'Cabeceras'),(3920,335,12,'Caimital'),(3921,335,13,'Carreta'),(3922,335,14,'Casitas'),(3923,335,15,'Cerro Verde'),(3924,335,16,'Cerro Redondo'),(3925,335,17,'Cola de Gallo'),(3926,335,18,'Cuesta'),(3927,335,19,'Cuesta Buenos Aires'),(3928,335,20,'Curime'),(3929,335,21,'Chivo'),(3930,335,22,'Dulce Nombre'),(3931,335,23,'Esperanza Norte'),(3932,335,24,'Estrella'),(3933,335,25,'Gamalotal'),(3934,335,26,'Garcimuñóz'),(3935,335,27,'Guaitil'),(3936,335,28,'Guastomatal'),(3937,335,29,'Guineas'),(3938,335,30,'Hondores'),(3939,335,31,'Jobo'),(3940,335,32,'Juan Díaz'),(3941,335,33,'Lajas'),(3942,335,34,'Loma Caucela'),(3943,335,35,'Miramar (noroeste)'),(3944,335,36,'Nambí'),(3945,335,37,'Oriente'),(3946,335,38,'Los Planes'),(3947,335,39,'Pedernal'),(3948,335,40,'Picudas'),(3949,335,41,'Pilahonda'),(3950,335,42,'Pilas'),(3951,335,43,'Pilas Blancas'),(3952,335,44,'Piragua'),(3953,335,45,'Ponedero'),(3954,335,46,'Quirimán'),(3955,335,47,'Quirimancito'),(3956,335,48,'Sabana Grande'),(3957,335,49,'Santa Ana'),(3958,335,50,'Sitio Botija'),(3959,335,51,'Tierra Blanca'),(3960,335,52,'Tres Quebradas'),(3961,335,53,'Varillas (Zapotillo)'),(3962,335,54,'Virginia'),(3963,335,55,'Zompopa.'),(3964,336,01,'Acoyapa'),(3965,336,02,'Boquete'),(3966,336,03,'Camarones'),(3967,336,04,'Guastomatal'),(3968,336,05,'Iguanita'),(3969,336,06,'Lapas'),(3970,336,07,'Limonal'),(3971,336,08,'Matambuguito'),(3972,336,09,'Matina'),(3973,336,10,'Mercedes'),(3974,336,11,'Monte Alto'),(3975,336,12,'Morote Norte'),(3976,336,13,'Nacaome'),(3977,336,14,'Obispo'),(3978,336,15,'Pital'),(3979,336,16,'Polvazales'),(3980,336,17,'Pueblo Viejo'),(3981,336,18,'Puente Guillermina'),(3982,336,19,'Puerto Jesús'),(3983,336,20,'Río Vueltas'),(3984,336,21,'San Joaquín'),(3985,336,22,'San Juan (parte)'),(3986,336,23,'Uvita (parte)'),(3987,336,24,'Vigía'),(3988,336,25,'Yerbabuena (parte)'),(3989,336,26,'Zapandí.'),(3990,337,01,'Guayabal.'),(3991,337,02,'Biscoyol'),(3992,337,03,'Bolsa'),(3993,337,04,'Boquete'),(3994,337,05,'Buenos Aires'),(3995,337,06,'Cañal'),(3996,337,07,'Carao'),(3997,337,08,'Cerro Mesas'),(3998,337,09,'Conchal'),(3999,337,10,'Corral de Piedra'),(4000,337,11,'Corralillo'),(4001,337,12,'Coyolar'),(4002,337,13,'Cuba'),(4003,337,14,'Cuesta Madroño'),(4004,337,15,'Chira'),(4005,337,16,'Flor'),(4006,337,17,'Florida'),(4007,337,18,'Guayabo'),(4008,337,19,'Loma Ayote'),(4009,337,20,'Matamba'),(4010,337,21,'México'),(4011,337,22,'Montañita'),(4012,337,23,'Monte Galán'),(4013,337,24,'Moracia'),(4014,337,25,'Ojo de Agua'),(4015,337,26,'Palos Negros'),(4016,337,27,'Piave'),(4017,337,28,'Piedras Blancas'),(4018,337,29,'Pozas'),(4019,337,30,'Pozo de Agua'),(4020,337,31,'Pueblo Nuevo'),(4021,337,32,'Puerto Humo'),(4022,337,33,'Rosario'),(4023,337,34,'San Lázaro'),(4024,337,35,'San Vicente'),(4025,337,36,'Silencio'),(4026,337,37,'Talolinga'),(4027,337,38,'Tamarindo'),(4028,337,39,'Zapote.'),(4029,338,01,'Tortuguero.'),(4030,338,02,'Botija'),(4031,338,03,'Caballito'),(4032,338,04,'Embarcadero'),(4033,338,05,'Copal'),(4034,338,06,'Loma Bonita'),(4035,338,07,'Millal'),(4036,338,08,'Paraíso'),(4037,338,09,'Paso Guabo'),(4038,338,10,'Pochote'),(4039,338,11,'Puerto Moreno'),(4040,338,12,'Roblar'),(4041,338,13,'San Juan (parte)'),(4042,338,14,'Sombrero'),(4043,338,15,'Sonzapote'),(4044,338,16,'Tres Esquinas.'),(4045,339,01,'Matapalo'),(4046,339,02,'Mala Noche.'),(4047,339,03,'Bajo Escondido'),(4048,339,04,'Barco Quebrado'),(4049,339,05,'Buenavista'),(4050,339,06,'Buenos Aires'),(4051,339,07,'Cambutes'),(4052,339,08,'Cangrejal'),(4053,339,09,'Cantarrana'),(4054,339,10,'Chinampas'),(4055,339,11,'Esterones'),(4056,339,12,'Galilea'),(4057,339,13,'Palmar'),(4058,339,14,'Panamá'),(4059,339,15,'Pavones'),(4060,339,16,'Playa Buenavista'),(4061,339,17,'Primavera'),(4062,339,18,'Pueblo Nuevo'),(4063,339,19,'Samaria'),(4064,339,20,'San Fernando'),(4065,339,21,'Santo Domingo'),(4066,339,22,'Taranta'),(4067,339,23,'Terciopelo'),(4068,339,24,'Torito.'),(4069,340,01,'Ángeles de Garza'),(4070,340,02,'Bijagua'),(4071,340,03,'Cabeceras de Garza'),(4072,340,04,'Coyoles'),(4073,340,05,'Cuesta Winch'),(4074,340,06,'Delicias'),(4075,340,07,'Esperanza Sur'),(4076,340,08,'Flores'),(4077,340,09,'Garza'),(4078,340,10,'Guiones'),(4079,340,11,'Ligia'),(4080,340,12,'Nosara'),(4081,340,13,'Playa Nosara'),(4082,340,14,'Playa Pelada'),(4083,340,15,'Portal'),(4084,340,16,'Río Montaña'),(4085,340,17,'San Juan'),(4086,340,18,'Santa Marta'),(4087,340,19,'Santa Teresa.'),(4088,341,01,'Arcos'),(4089,341,02,'Balsal'),(4090,341,03,'Caimitalito'),(4091,341,04,'Cuajiniquil'),(4092,341,05,'Cuesta Grande'),(4093,341,06,'Chumburán'),(4094,341,07,'Juntas'),(4095,341,08,'Maquenco'),(4096,341,09,'Minas'),(4097,341,10,'Miramar Sureste'),(4098,341,11,'Naranjal'),(4099,341,12,'Naranjalito'),(4100,341,13,'Nosarita'),(4101,341,14,'Platanillo'),(4102,341,15,'Quebrada Bonita'),(4103,341,16,'Santa Elena (parte)'),(4104,341,17,'Zaragoza.'),(4105,342,01,'Buenos Aires'),(4106,342,02,'Camarenos'),(4107,342,03,'Cátalo Rojas'),(4108,342,04,'Corobicí'),(4109,342,05,'Chorotega'),(4110,342,06,'Esquipulas'),(4111,342,07,'Estocolmo'),(4112,342,08,'Flores'),(4113,342,09,'Garúa'),(4114,342,10,'Guabo'),(4115,342,11,'Lajas'),(4116,342,12,'Los Amigos'),(4117,342,13,'Malinches'),(4118,342,14,'Manchón'),(4119,342,15,'Panamá'),(4120,342,16,'Pepe Lujan'),(4121,342,17,'Sagamat'),(4122,342,18,'San Martín'),(4123,342,19,'Santa Cecilia'),(4124,342,20,'Tenorio'),(4125,342,21,'Tulita Sandino.'),(4126,342,22,'Ángeles'),(4127,342,23,'Arado'),(4128,342,24,'Bernabela'),(4129,342,25,'Cacao'),(4130,342,26,'Caimito'),(4131,342,27,'Congal'),(4132,342,28,'Cuatro  Esquinas'),(4133,342,29,'Chibola'),(4134,342,30,'Chircó'),(4135,342,31,'Chumico (parte)'),(4136,342,32,'Guayabal'),(4137,342,33,'Hato Viejo'),(4138,342,34,'Lagunilla'),(4139,342,35,'Lechuza'),(4140,342,36,'Limón'),(4141,342,37,'Moya'),(4142,342,38,'Puente Negro'),(4143,342,39,'Retallano (parte)'),(4144,342,40,'Rincón'),(4145,342,41,'Río Cañas Viejo'),(4146,342,42,'San Juan'),(4147,342,43,'San Pedro'),(4148,342,44,'San Pedro Viejo'),(4149,342,45,'Vista al Mar.'),(4150,343,01,'Ortega.'),(4151,343,02,'Ballena (parte)'),(4152,343,03,'Lagartero'),(4153,343,04,'Pochotada.'),(4154,344,01,'Jobos.'),(4155,344,02,'Aguacate'),(4156,344,03,'Avellana'),(4157,344,04,'Barrosa'),(4158,344,05,'Brisas'),(4159,344,06,'Bruno'),(4160,344,07,'Cacaovano'),(4161,344,08,'Camones'),(4162,344,09,'Cañas Gordas'),(4163,344,10,'Ceiba Mocha'),(4164,344,11,'Cerro Brujo'),(4165,344,12,'Congo'),(4166,344,13,'Delicias'),(4167,344,14,'Espavelar'),(4168,344,15,'Florida'),(4169,344,16,'Gongolona'),(4170,344,17,'Guachipelín'),(4171,344,18,'Guapote'),(4172,344,19,'Hatillo'),(4173,344,20,'Isla  Verde'),(4174,344,21,'Junquillal'),(4175,344,22,'Junta de Río Verde'),(4176,344,23,'Mesas'),(4177,344,24,'Montaña'),(4178,344,25,'Monteverde'),(4179,344,26,'Níspero'),(4180,344,27,'Paraíso'),(4181,344,28,'Pargos'),(4182,344,29,'Paso Hondo'),(4183,344,30,'Pilas'),(4184,344,31,'Playa Lagartillo'),(4185,344,32,'Playa Negra'),(4186,344,33,'Pochotes'),(4187,344,34,'Ranchos'),(4188,344,35,'Retallano (parte)'),(4189,344,36,'Río Seco'),(4190,344,37,'Río Tabaco'),(4191,344,38,'San Francisco'),(4192,344,39,'San Jerónimo'),(4193,344,40,'Soncoyo'),(4194,344,41,'Tieso (San Rafael)'),(4195,344,42,'Trapiche'),(4196,344,43,'Venado'),(4197,344,44,'Vergel'),(4198,344,45,'.'),(4199,345,01,'Paraíso.'),(4200,345,02,'Bejuco'),(4201,345,03,'Chiles'),(4202,345,04,'El Llano'),(4203,345,05,'Huacas'),(4204,345,06,'Portegolpe'),(4205,345,07,'Potrero'),(4206,345,08,'Rincón.'),(4207,346,01,'Edén'),(4208,346,02,'Toyosa.'),(4209,346,03,'Cañafístula'),(4210,346,04,'Corocitos'),(4211,346,05,'Higuerón'),(4212,346,06,'Jobo'),(4213,346,07,'Lorena'),(4214,346,08,'Oratorio'),(4215,346,09,'sacatipe'),(4216,347,01,'Alemania'),(4217,347,02,'Bolillos'),(4218,347,03,'Cuajiniquil'),(4219,347,04,'Chiquero'),(4220,347,05,'Fortuna'),(4221,347,06,'Frijolar'),(4222,347,07,'Jazminal'),(4223,347,08,'Lagarto'),(4224,347,09,'Libertad'),(4225,347,10,'Limonal'),(4226,347,11,'Manzanillo'),(4227,347,12,'Marbella'),(4228,347,13,'Ostional'),(4229,347,14,'Palmares'),(4230,347,15,'Piedras Amarillas'),(4231,347,16,'Progreso'),(4232,347,17,'Punta Caliente'),(4233,347,18,'Quebrada Seca'),(4234,347,19,'Quebrada Zapote'),(4235,347,20,'Rayo'),(4236,347,21,'Roble'),(4237,347,22,'Rosario'),(4238,347,23,'Santa Cecilia'),(4239,347,24,'Santa Elena'),(4240,347,25,'Socorro'),(4241,347,26,'Unión'),(4242,347,27,'Veracrúz.'),(4243,348,01,'Ángeles'),(4244,348,02,'Duendes'),(4245,348,03,'Lomitas'),(4246,348,04,'Oriente.'),(4247,348,05,'Calle Vieja'),(4248,348,06,'Coyolar'),(4249,348,07,'Chumico (parte)'),(4250,348,08,'Diría'),(4251,348,09,'Guaitil'),(4252,348,10,'Polvazal'),(4253,348,11,'Sequeira'),(4254,348,12,'Talolinguita'),(4255,348,13,'Trompillal.'),(4256,349,01,'Brasilito'),(4257,349,02,'Buen Pastor'),(4258,349,03,'Conchal'),(4259,349,04,'Flamenco'),(4260,349,05,'Garita Vieja'),(4261,349,06,'Jesús María'),(4262,349,07,'Lajas'),(4263,349,08,'Lomas'),(4264,349,09,'Playa Cabuya'),(4265,349,10,'Playa Grande'),(4266,349,11,'Playa Mina'),(4267,349,12,'Playa Real'),(4268,349,13,'Puerto Viejo'),(4269,349,14,'Salinas'),(4270,349,15,'Salinitas'),(4271,349,16,'Tacasolapa'),(4272,349,17,'Zapotillal.'),(4273,350,01,'Cañafístula'),(4274,350,02,'Cebadilla'),(4275,350,03,'El Llano'),(4276,350,04,'Garita'),(4277,350,05,'Guatemala'),(4278,350,06,'Hernández'),(4279,350,07,'Icacal'),(4280,350,08,'La Loma'),(4281,350,09,'Linderos'),(4282,350,10,'Mangos'),(4283,350,11,'Palmar'),(4284,350,12,'San Andrés'),(4285,350,13,'San José Pinilla'),(4286,350,14,'Santa Rosa'),(4287,350,15,'Tamarindo.'),(4288,351,01,'Lima'),(4289,351,02,'Pedro Nolasco'),(4290,351,03,'Redondel.'),(4291,351,04,'Aguacaliente'),(4292,351,05,'Arbolito'),(4293,351,06,'Bagatzi'),(4294,351,07,'Brisas'),(4295,351,08,'Bebedero (parte)'),(4296,351,09,'Casavieja (parte)'),(4297,351,10,'Cofradía'),(4298,351,11,'Colmenar'),(4299,351,12,'Llanos de Cortés'),(4300,351,13,'Mojica'),(4301,351,14,'Montano'),(4302,351,15,'Montenegro'),(4303,351,16,'Piedras'),(4304,351,17,'Pijije'),(4305,351,18,'Plazuela'),(4306,351,19,'Salitral'),(4307,351,20,'Salto (parte)'),(4308,351,21,'Santa Rosa.'),(4309,352,01,'Miravalles.'),(4310,352,02,'Casavieja (parte)'),(4311,352,03,'Cuipilapa'),(4312,352,04,'Giganta'),(4313,352,05,'Hornillas'),(4314,352,06,'Macuá'),(4315,352,07,'Martillete'),(4316,352,08,'Mozotal'),(4317,352,09,'Pozo Azul'),(4318,352,10,'Sagrada Familia'),(4319,352,11,'San Bernardo'),(4320,352,12,'San Joaquín'),(4321,352,13,'Santa Cecilia'),(4322,352,14,'Santa Fe'),(4323,352,15,'Santa Rosa'),(4324,352,16,'Unión Ferrer.'),(4325,353,01,'Los Ángeles'),(4326,353,02,'Oses.'),(4327,353,03,'Barro de Olla'),(4328,353,04,'Horcones'),(4329,353,05,'La Ese'),(4330,353,06,'Limonal'),(4331,353,07,'Manglar'),(4332,353,08,'Mochadero'),(4333,353,09,'Pueblo Nuevo'),(4334,353,10,'Rincón de La Cruz'),(4335,353,11,'San Isidro de Limonal'),(4336,353,12,'San Jorge'),(4337,353,13,'San Pedro'),(4338,353,14,'Torno.'),(4339,354,01,'Naranjito.'),(4340,354,02,'Río Chiquito.'),(4341,355,01,'Bambú'),(4342,355,02,'Cinco Esquinas'),(4343,355,03,'Hollywood'),(4344,355,04,'La Cruz'),(4345,355,05,'Santa Lucía'),(4346,355,06,'Ballena (parte)'),(4347,355,07,'Corralillo'),(4348,355,08,'Guinea'),(4349,355,09,'Isleta (parte)'),(4350,355,10,'Jocote'),(4351,355,11,'Juanilama'),(4352,355,12,'Moralito'),(4353,355,13,'Ojoche'),(4354,355,14,'San Francisco.'),(4355,356,01,'Coyolera'),(4356,356,02,'María Auxiliadora.'),(4357,356,03,'Ángeles'),(4358,356,04,'Comunidad'),(4359,356,05,'Paso Tempisque (parte)'),(4360,356,06,'San Rafael.'),(4361,357,01,'Carpintera'),(4362,357,02,'Colegios'),(4363,357,03,'Verdún.'),(4364,357,04,'Artola'),(4365,357,05,'Cacique'),(4366,357,06,'Coco'),(4367,357,07,'Chorrera'),(4368,357,08,'Guacamaya'),(4369,357,09,'Huaquitas'),(4370,357,10,'Libertad'),(4371,357,11,'Los Canales'),(4372,357,12,'Matapalo'),(4373,357,13,'Nancital'),(4374,357,14,'Nuevo Colón'),(4375,357,15,'Obandito'),(4376,357,16,'Ocotal'),(4377,357,17,'Pilas'),(4378,357,18,'Playa Hermosa'),(4379,357,19,'Playones'),(4380,357,20,'San Blas'),(4381,357,21,'San Martín'),(4382,357,22,'Santa Rita'),(4383,357,23,'Segovia'),(4384,357,24,'Tabores'),(4385,357,25,'Zapotal.'),(4386,358,01,'Villita'),(4387,358,02,'Alto San Antonio'),(4388,358,03,'Cachimbo'),(4389,358,04,'Castilla de Oro'),(4390,358,05,'Coyolito'),(4391,358,06,'Gallina'),(4392,358,07,'Juanilama'),(4393,358,08,'Loma Bonita'),(4394,358,09,'LLano'),(4395,358,10,'Ojochal'),(4396,358,11,'Palestina'),(4397,358,12,'Palmas'),(4398,358,13,'Paraíso'),(4399,358,14,'Penca'),(4400,358,15,'Planes'),(4401,358,16,'Poroporo'),(4402,358,17,'Río Cañas Nuevo'),(4403,358,18,'Santa Ana'),(4404,358,19,'Santo Domingo.'),(4405,359,01,'Albania'),(4406,359,02,'Ángeles'),(4407,359,03,'Bello Horizonte'),(4408,359,04,'Cantarrana'),(4409,359,05,'Castillo'),(4410,359,06,'Cueva'),(4411,359,07,'Chorotega'),(4412,359,08,'Las Cañas'),(4413,359,09,'Malinches'),(4414,359,10,'Miravalles'),(4415,359,11,'Palmas'),(4416,359,12,'San Cristóbal'),(4417,359,13,'San Martín'),(4418,359,14,'San Pedro'),(4419,359,15,'Santa Isabel Abajo'),(4420,359,16,'Santa Isabel Arriba'),(4421,359,17,'Tenorio'),(4422,359,18,'Tres Marías'),(4423,359,19,'Unión.'),(4424,359,20,'Cedros'),(4425,359,21,'Cepo'),(4426,359,22,'Concepción'),(4427,359,23,'Corobicí'),(4428,359,24,'Correntadas'),(4429,359,25,'Cuesta el Diablo'),(4430,359,26,'Cuesta el Mico'),(4431,359,27,'Hotel'),(4432,359,28,'Jabilla Abajo'),(4433,359,29,'Jabilla Arriba'),(4434,359,30,'Libertad'),(4435,359,31,'Montes de Oro'),(4436,359,32,'Paso Lajas'),(4437,359,33,'Pedregal'),(4438,359,34,'Pochota'),(4439,359,35,'Pueblo Nuevo'),(4440,359,36,'Sandial (Sandillal)'),(4441,359,37,'San Isidro (parte)'),(4442,359,38,'Santa Lucía (parte)'),(4443,359,39,'Vergel.'),(4444,360,01,'Aguacaliente'),(4445,360,02,'Aguas Gatas (parte)'),(4446,360,03,'Coyota'),(4447,360,04,'Huacal'),(4448,360,05,'Las Flores'),(4449,360,06,'Martirio'),(4450,360,07,'Panales'),(4451,360,08,'Paraíso (parte)'),(4452,360,09,'San Isidro (parte)'),(4453,360,10,'Santa Lucía (parte)'),(4454,360,11,'Tenorio'),(4455,360,12,'Vueltas.'),(4456,361,01,'El Coco'),(4457,361,02,'El Güis'),(4458,361,03,'Eskameca (parte)'),(4459,361,04,'Gotera'),(4460,361,05,'Higuerón'),(4461,361,06,'Higuerón Viejo'),(4462,361,07,'San Juan.'),(4463,362,01,'Loma.'),(4464,362,02,'Coopetaboga'),(4465,362,03,'Taboga (parte).'),(4466,363,01,'Brisas'),(4467,363,02,'Eskameca (parte)'),(4468,363,03,'Guapinol'),(4469,363,04,'Pozas'),(4470,363,05,'Puerto Alegre'),(4471,363,06,'Quesera'),(4472,363,07,'Santa Lucía'),(4473,363,08,'Taboga (parte)'),(4474,363,09,'Tiquirusas.'),(4475,364,01,'Bellavista'),(4476,364,02,'Cinco Esquinas'),(4477,364,03,'La Gloria'),(4478,364,04,'Paso Ancho'),(4479,364,05,'San Antonio'),(4480,364,06,'San Jorge'),(4481,364,07,'San Pablo.'),(4482,364,08,'Blanco'),(4483,364,09,'Cecilia'),(4484,364,10,'Codornices'),(4485,364,11,'Concepción'),(4486,364,12,'Coyolito (parte)'),(4487,364,13,'Chiqueros'),(4488,364,14,'Desjarretado'),(4489,364,15,'Irma'),(4490,364,16,'Jarquín (parte)'),(4491,364,17,'Jesús'),(4492,364,18,'Lajas'),(4493,364,19,'Las Huacas (Parte)'),(4494,364,20,'Limonal'),(4495,364,21,'Limonal Viejo'),(4496,364,22,'Matapalo'),(4497,364,23,'Naranjos Agrios'),(4498,364,24,'Palma'),(4499,364,25,'Peña'),(4500,364,26,'Puente de Tierra'),(4501,364,27,'Rancho Alegre (parte)'),(4502,364,28,'Lourdes (Rancho Ania) (parte)'),(4503,364,29,'San Cristóbal'),(4504,364,30,'San Francisco'),(4505,364,31,'San Juan Chiquito'),(4506,364,32,'Santa Lucía'),(4507,364,33,'Tortugal'),(4508,364,34,'Zapote.'),(4509,365,01,'Aguas Claras'),(4510,365,02,'Alto Cebadilla'),(4511,365,03,'Campos de Oro'),(4512,365,04,'Candelaria'),(4513,365,05,'Cañitas'),(4514,365,06,'Cruz'),(4515,365,07,'Cuesta Yugo'),(4516,365,08,'Dos de Abangares'),(4517,365,09,'Marsellesa'),(4518,365,10,'San Antonio'),(4519,365,11,'San Rafael'),(4520,365,12,'Tornos'),(4521,365,13,'Tres Amigos'),(4522,365,14,'Turín (parte).'),(4523,366,01,'Arizona'),(4524,366,02,'Congo'),(4525,366,03,'Nancital'),(4526,366,04,'Portones'),(4527,366,05,'Pozo Azul'),(4528,366,06,'Rancho Alegre (parte)'),(4529,366,07,'Lourdes (Rancho Ania) (parte)'),(4530,366,08,'Tierra Colorada'),(4531,366,09,'Vainilla.'),(4532,367,01,'Almendros'),(4533,367,02,'Barbudal'),(4534,367,03,'Gavilanes'),(4535,367,04,'Higuerillas'),(4536,367,05,'Las Huacas (parte)'),(4537,367,06,'Monte Potrero'),(4538,367,07,'Quebracho'),(4539,367,08,'Peñablanca'),(4540,367,09,'San Buenaventura'),(4541,367,10,'San Joaquín'),(4542,367,11,'Solimar'),(4543,367,12,'Villafuerte.'),(4544,368,01,'Cabra'),(4545,368,02,'Carmen'),(4546,368,03,'Juan XXIII'),(4547,368,04,'Lomalinda.'),(4548,368,05,'Cuatro Esquinas'),(4549,368,06,'Chiripa'),(4550,368,07,'Piamonte'),(4551,368,08,'Río Chiquito'),(4552,368,09,'San Luis'),(4553,368,10,'Tejona'),(4554,368,11,'Tres Esquinas.'),(4555,369,01,'Barrionuevo'),(4556,369,02,'Cabeceras de Cañas'),(4557,369,03,'Campos de Oro'),(4558,369,04,'Dos de Tilarán'),(4559,369,05,'Esperanza'),(4560,369,06,'Florida'),(4561,369,07,'Monte Olivos'),(4562,369,08,'Nubes'),(4563,369,09,'San Miguel'),(4564,369,10,'Turín (parte)'),(4565,369,11,'Vueltas.'),(4566,370,01,'Arenal Viejo'),(4567,370,02,'Colonia Menonita'),(4568,370,03,'Río Chiquito Abajo'),(4569,370,04,'Silencio.'),(4570,371,01,'Aguilares'),(4571,371,02,'Campos Azules'),(4572,371,03,'Montes de Oro (parte)'),(4573,371,04,'Naranjos Agrios'),(4574,371,05,'Palma'),(4575,371,06,'Quebrada Azul'),(4576,371,07,'Ranchitos'),(4577,371,08,'Santa Rosa.'),(4578,372,01,'Alto Cartago'),(4579,372,02,'Maravilla'),(4580,372,03,'San José'),(4581,372,04,'Solania.'),(4582,373,01,'Aguacate'),(4583,373,02,'Aguas Gatas (parte)'),(4584,373,03,'Bajo Paires'),(4585,373,04,'Guadalajara'),(4586,373,05,'Montes de Oro (parte)'),(4587,373,06,'Paraíso (parte)'),(4588,373,07,'Río Piedras'),(4589,373,08,'Sabalito.'),(4590,374,01,'Mata de Caña'),(4591,374,02,'Sangregado'),(4592,374,03,'San Antonio'),(4593,374,04,'Unión.'),(4594,375,01,'Camas'),(4595,375,02,'Limones'),(4596,375,03,'Maquenco'),(4597,375,04,'San Rafael'),(4598,375,05,'Vista de Mar.'),(4599,376,01,'Angostura'),(4600,376,02,'Cacao'),(4601,376,03,'Chumico'),(4602,376,04,'Guaria'),(4603,376,05,'Guastomatal'),(4604,376,06,'Morote'),(4605,376,07,'Tacanis'),(4606,376,08,'Uvita (parte)'),(4607,376,09,'Yerbabuena (parte).'),(4608,377,01,'Altos de Mora'),(4609,377,02,'Cabeceras de Río Ora'),(4610,377,03,'Camaronal'),(4611,377,04,'Carmen'),(4612,377,05,'Cuesta Bijagua'),(4613,377,06,'Leona'),(4614,377,07,'Manzanales'),(4615,377,08,'Río Blanco Este'),(4616,377,09,'Río de Oro'),(4617,377,10,'Río Ora'),(4618,377,11,'San Martín'),(4619,377,12,'San Pedro'),(4620,377,13,'Soledad.'),(4621,378,01,'Canjel'),(4622,378,02,'Canjelito'),(4623,378,03,'Corozal Oeste'),(4624,378,04,'Chamarro'),(4625,378,05,'Isla Berrugate'),(4626,378,06,'Pavones'),(4627,378,07,'Puerto Thiel'),(4628,378,08,'San Pablo Viejo.'),(4629,379,01,'Ángeles'),(4630,379,02,'Bellavista'),(4631,379,03,'Cabeceras de Río Bejuco'),(4632,379,04,'Chompipe (parte)'),(4633,379,05,'Delicias'),(4634,379,06,'Quebrada Grande'),(4635,379,07,'San Josecito.'),(4636,380,01,'Caletas'),(4637,380,02,'Candelillo'),(4638,380,03,'Corozalito'),(4639,380,04,'Chiruta'),(4640,380,05,'Chompipe (parte)'),(4641,380,06,'I Griega'),(4642,380,07,'Islita'),(4643,380,08,'Jabilla'),(4644,380,09,'Jabillos'),(4645,380,10,'Maicillal'),(4646,380,11,'Maquencal'),(4647,380,12,'Milagro'),(4648,380,13,'Millal'),(4649,380,14,'Mono'),(4650,380,15,'Pampas'),(4651,380,16,'Paso Vigas'),(4652,380,17,'Pencal'),(4653,380,18,'Playa Coyote'),(4654,380,19,'Playa San Miguel'),(4655,380,20,'Pueblo Nuevo'),(4656,380,21,'Punta Bejuco'),(4657,380,22,'Puerto Coyote'),(4658,380,23,'Quebrada Nando'),(4659,380,24,'Quebrada Seca'),(4660,380,25,'Rancho Floriana'),(4661,380,26,'San Francisco de Coyote'),(4662,380,27,'San Gabriel'),(4663,380,28,'San Miguel'),(4664,380,29,'Triunfo'),(4665,380,30,'Zapote.'),(4666,381,01,'Corazón de Jesús'),(4667,381,02,'Fátima'),(4668,381,03,'Irving'),(4669,381,04,'Orosí'),(4670,381,05,'Pinos'),(4671,381,06,'Santa Rosa.'),(4672,381,07,'Bellavista'),(4673,381,08,'Bello Horizonte'),(4674,381,09,'Brisas'),(4675,381,10,'Cacao'),(4676,381,11,'Carrizal'),(4677,381,12,'Carrizales'),(4678,381,13,'Colonia Bolaños'),(4679,381,14,'Copalchí'),(4680,381,15,'Infierno'),(4681,381,16,'Jobo'),(4682,381,17,'Libertad'),(4683,381,18,'Monte Plata'),(4684,381,19,'Montes de Oro'),(4685,381,20,'Pampa'),(4686,381,21,'Pegón'),(4687,381,22,'Peñas Blancas'),(4688,381,23,'Piedra Pómez'),(4689,381,24,'Puerto Soley'),(4690,381,25,'Recreo'),(4691,381,26,'San Buenaventura'),(4692,381,27,'San  Dimas'),(4693,381,28,'San Paco'),(4694,381,29,'San Roque'),(4695,381,30,'Santa Rogelia'),(4696,381,31,'Santa Rosa'),(4697,381,32,'Soley'),(4698,381,33,'Sonzapote'),(4699,381,34,'Tempatal'),(4700,381,35,'Vueltas.'),(4701,382,01,'Ángeles'),(4702,382,02,'Corrales Negros'),(4703,382,03,'Pueblo Nuevo'),(4704,382,04,''),(4705,382,05,'Argendora'),(4706,382,06,'Armenia'),(4707,382,07,'Belice'),(4708,382,08,'Bellavista'),(4709,382,09,'Brisas'),(4710,382,10,'Caoba'),(4711,382,11,'Esperanza'),(4712,382,12,'Flor del Norte'),(4713,382,13,'Lajosa'),(4714,382,14,'Marías'),(4715,382,15,'Palmares'),(4716,382,16,'San Antonio'),(4717,382,17,'San Cristóbal'),(4718,382,18,'San Rafael'),(4719,382,19,'San Vicente'),(4720,382,20,'Santa Elena'),(4721,382,21,'Sardina'),(4722,382,22,'Virgen.'),(4723,383,01,'Paraíso.'),(4724,383,02,'Agua Muerta'),(4725,383,03,'Andes'),(4726,383,04,'Asilo'),(4727,383,05,'Cañita'),(4728,383,06,'Carmen'),(4729,383,07,'Fortuna'),(4730,383,08,'Gloria'),(4731,383,09,'Guapinol'),(4732,383,10,'Inocentes'),(4733,383,11,'Lavaderos'),(4734,383,12,'Pochote'),(4735,383,13,'San Antonio'),(4736,383,14,'Tapesco.'),(4737,384,01,'Cedros'),(4738,384,02,'Guaria'),(4739,384,03,'Puerto Castilla'),(4740,384,04,'Rabo de Mico (Aguacaliente).'),(4741,385,01,'Ángeles'),(4742,385,02,'Arena'),(4743,385,03,'Ceiba'),(4744,385,04,'Cuesta Blanca'),(4745,385,05,'Libertad'),(4746,385,06,'Maravilla'),(4747,385,07,'Matambú'),(4748,385,08,'Palo de Jabón'),(4749,385,09,'Pilangosta'),(4750,385,10,'San Juan Bosco'),(4751,385,11,'San Rafael'),(4752,385,12,'Santa Elena (parte)'),(4753,385,13,'Varillal.'),(4754,386,01,'Altos del Socorro'),(4755,386,02,'Bajo Saltos'),(4756,386,03,'Cabrera'),(4757,386,04,'Cuesta Roja'),(4758,386,05,'Delicias'),(4759,386,06,'Guapinol'),(4760,386,07,'Loros'),(4761,386,08,'Mercedes'),(4762,386,09,'Palmares'),(4763,386,10,'Río Zapotal'),(4764,386,11,'San Isidro'),(4765,386,12,'Trinidad.'),(4766,387,01,'Angostura'),(4767,387,02,'Arbolito'),(4768,387,03,'Cuesta Malanoche'),(4769,387,04,'Estrada'),(4770,387,05,'Jobo'),(4771,387,06,'Lajas'),(4772,387,07,'Quebrada Bonita (parte)'),(4773,387,08,'San Miguel'),(4774,387,09,'Santa María.'),(4775,388,01,'Avellana'),(4776,388,02,'Pita Rayada'),(4777,388,03,'Río Blanco Oeste'),(4778,388,04,'Tres Quebradas.'),(4779,389,01,'Angostura'),(4780,389,02,'Carmen'),(4781,389,03,'Cocal'),(4782,389,04,'Playitas'),(4783,389,05,'Pochote'),(4784,389,06,'Pueblo Nuevo.'),(4785,389,07,'Isla Bejuco'),(4786,389,08,'Isla Caballo'),(4787,389,09,'Palmar.'),(4788,390,01,'Aranjuéz'),(4789,390,02,'Brillante (parte)'),(4790,390,03,'Cebadilla'),(4791,390,04,'Chapernal'),(4792,390,05,'Palermo'),(4793,390,06,'Pitahaya Vieja'),(4794,390,07,'Rancho Grande'),(4795,390,08,'San Marcos (parte)'),(4796,390,09,'Zapotal.'),(4797,391,01,'Alto Pie de Paloma'),(4798,391,02,'Cambalache'),(4799,391,03,'Cocoroca'),(4800,391,04,'Coyoles Motos'),(4801,391,05,'Don Jaime'),(4802,391,06,'Jarquín (parte)'),(4803,391,07,'Judas'),(4804,391,08,'Laberinto'),(4805,391,09,'Lagarto'),(4806,391,10,'Malinche'),(4807,391,11,'Morales'),(4808,391,12,'Pita'),(4809,391,13,'Playa Coco'),(4810,391,14,'Pocitos'),(4811,391,15,'Punta Morales'),(4812,391,16,'San Agustín'),(4813,391,17,'San Gerardo'),(4814,391,18,'Santa Juana'),(4815,391,19,'Sarmiento'),(4816,391,20,'Terrero'),(4817,391,21,'Vanegas'),(4818,391,22,'Yomalé.'),(4819,392,01,'Alto Fresca'),(4820,392,02,'Bajo Mora'),(4821,392,03,'Balsa'),(4822,392,04,'Balso'),(4823,392,05,'Bijagua'),(4824,392,06,'Brisas'),(4825,392,07,'Cabo Blanco'),(4826,392,08,'Camaronal'),(4827,392,09,'Cantil'),(4828,392,10,'Cañablancal'),(4829,392,11,'Cerro Frío'),(4830,392,12,'Cerro Indio'),(4831,392,13,'Cerro Pando'),(4832,392,14,'Corozal'),(4833,392,15,'Coto'),(4834,392,16,'Cuajiniquil'),(4835,392,17,'Chanchos'),(4836,392,18,'Chiqueros'),(4837,392,19,'Dominica'),(4838,392,20,'El Mora'),(4839,392,21,'Encanto'),(4840,392,22,'Fresca'),(4841,392,23,'Gloria'),(4842,392,24,'Golfo'),(4843,392,25,'Guabo'),(4844,392,26,'Guadalupe'),(4845,392,27,'Ilusión'),(4846,392,28,'Isla Venado'),(4847,392,29,'Jicaral'),(4848,392,30,'Juan de León'),(4849,392,31,'Milpa'),(4850,392,32,'Montaña Grande'),(4851,392,33,'Níspero'),(4852,392,34,'Nubes'),(4853,392,35,'Once Estrellas'),(4854,392,36,'Piedades'),(4855,392,37,'Pilas de Canjel'),(4856,392,38,'Punta de Cera'),(4857,392,39,'Río Seco'),(4858,392,40,'Sahíno'),(4859,392,41,'San Blas'),(4860,392,42,'San Miguel'),(4861,392,43,'San Miguel de Río Blanco'),(4862,392,44,'San Pedro'),(4863,392,45,'San Rafael'),(4864,392,46,'San Ramón de Río Blanco'),(4865,392,47,'Santa Rosa'),(4866,392,48,'Tigra'),(4867,392,49,'Tres Ríos'),(4868,392,50,'Tronconal'),(4869,392,51,'Unión'),(4870,392,52,'Vainilla.'),(4871,393,01,'Angeles'),(4872,393,02,'Astro Blanco'),(4873,393,03,'Bajo Negro'),(4874,393,04,'Cabeceras de Río Seco'),(4875,393,05,'Campiñas'),(4876,393,06,'Cerro Brujo'),(4877,393,07,'Concepción'),(4878,393,08,'Curú'),(4879,393,09,'Dulce Nombre'),(4880,393,10,'Espaveles'),(4881,393,11,'Esperanza'),(4882,393,12,'Flor'),(4883,393,13,'Gigante'),(4884,393,14,'Guaria'),(4885,393,15,'Higueronal'),(4886,393,16,'Isla Cedros'),(4887,393,17,'Isla Jesucita'),(4888,393,18,'Isla Tortuga'),(4889,393,19,'Leona'),(4890,393,20,'Mango'),(4891,393,21,'Naranjo'),(4892,393,22,'Pánica'),(4893,393,23,'Paraíso'),(4894,393,24,'Playa Blanca'),(4895,393,25,'Playa Cuchillo'),(4896,393,26,'Pochote'),(4897,393,27,'Punta del Río'),(4898,393,28,'Quebrada Bonita'),(4899,393,29,'Río Grande'),(4900,393,30,'Río Guarial'),(4901,393,31,'Río Seco'),(4902,393,32,'Rivas'),(4903,393,33,'San Fernando'),(4904,393,34,'San Luis'),(4905,393,35,'San Pedro'),(4906,393,36,'San Rafael'),(4907,393,37,'San Vicente'),(4908,393,38,'Santa Cecilia'),(4909,393,39,'Santa Lucía'),(4910,393,40,'Santa Rosa'),(4911,393,41,'Sonzapote'),(4912,393,42,'Tronco Negro'),(4913,393,43,'Valle Azul'),(4914,393,44,'Vueltas.'),(4915,394,01,'Abangaritos'),(4916,394,02,'Camarita'),(4917,394,03,'Costa de Pájaros'),(4918,394,04,'Coyolito (parte)'),(4919,394,05,'Cuesta Portillo.'),(4920,395,01,'Alto Méndez'),(4921,395,02,'Altos Fernández'),(4922,395,03,'Ángeles'),(4923,395,04,'Guaria'),(4924,395,05,'Lajón'),(4925,395,06,'San Antonio'),(4926,395,07,'Santa Rosa'),(4927,395,08,'Surtubal'),(4928,395,09,'Veracruz.'),(4929,396,01,'Rioja.'),(4930,396,02,'Obregón'),(4931,396,03,'San Joaquín'),(4932,396,04,'San Miguel'),(4933,396,05,'San Miguelito'),(4934,396,06,'Santa Ana.'),(4935,397,01,'Cerro Plano'),(4936,397,02,'Cuesta Blanca'),(4937,397,03,'Lindora'),(4938,397,04,'Llanos'),(4939,397,05,'Monte Verde'),(4940,397,06,'San Luis.'),(4941,398,01,'Abuela'),(4942,398,02,'Arío'),(4943,398,03,'Bajos de Arío'),(4944,398,04,'Bajos de Fernández'),(4945,398,05,'Bello Horizonte'),(4946,398,06,'Betel'),(4947,398,07,'Cabuya'),(4948,398,08,'Canaán'),(4949,398,09,'Cañada'),(4950,398,10,'Caño Seco Abajo'),(4951,398,11,'Caño Seco Arriba'),(4952,398,12,'Caño Seco Enmedio'),(4953,398,13,'Carmen'),(4954,398,14,'Cedro'),(4955,398,15,'Cerital'),(4956,398,16,'Cerro Buenavista'),(4957,398,17,'Cocal'),(4958,398,18,'Cocalito'),(4959,398,19,'Delicias'),(4960,398,20,'Malpaís'),(4961,398,21,'Montezuma'),(4962,398,22,'Muelle'),(4963,398,23,'Pachanga'),(4964,398,24,'Pavón'),(4965,398,25,'Pénjamo'),(4966,398,26,'Piedra Amarilla'),(4967,398,27,'Pita'),(4968,398,28,'Río Enmedio'),(4969,398,29,'Río Frío'),(4970,398,30,'Río Negro'),(4971,398,31,'San Antonio'),(4972,398,32,'San Isidro'),(4973,398,33,'San Jorge'),(4974,398,34,'San Ramón'),(4975,398,35,'Santa Clemencia'),(4976,398,36,'Santa Fe'),(4977,398,37,'Santa Teresa'),(4978,398,38,'Santiago'),(4979,398,39,'Tacotales'),(4980,398,40,'Tambor'),(4981,398,41,'Villalta.'),(4982,399,01,'Camboya'),(4983,399,02,'Carrizal'),(4984,399,03,'Chacarita'),(4985,399,04,'Chacarita Norte'),(4986,399,05,'Fertica'),(4987,399,06,'Fray Casiano'),(4988,399,07,'Huerto'),(4989,399,08,'Lindavista'),(4990,399,09,'Pueblo Redondo'),(4991,399,10,'Reyes'),(4992,399,11,'San Isidro'),(4993,399,12,'Santa Eduvigis'),(4994,399,13,'Tanque'),(4995,399,14,'Veinte de Noviembre.'),(4996,400,01,'Bocana'),(4997,400,02,'Lagartero'),(4998,400,03,'Montero'),(4999,400,04,'Pilas'),(5000,400,05,'Pochote'),(5001,400,06,'Puerto Coloradito'),(5002,400,07,'Puerto Mauricio'),(5003,400,08,'Puerto Palito.'),(5004,401,01,'Acapulco'),(5005,401,02,'Aranjuecito'),(5006,401,03,'Chapernalito'),(5007,401,04,'Claraboya'),(5008,401,05,'Coyolar'),(5009,401,06,'Quebrada Honda'),(5010,401,07,'San Marcos (parte).'),(5011,402,01,'Boca de Barranca'),(5012,402,02,'Chagüite'),(5013,402,03,'El Roble.'),(5014,403,01,'Poblados. Arancibia Norte'),(5015,403,02,'Arancibia Sur'),(5016,403,03,'Lagunas'),(5017,403,04,'Ojo de Agua'),(5018,403,05,'Rincón'),(5019,403,06,'San Martín Norte'),(5020,403,07,'San Martín Sur.'),(5021,404,01,'Marañonal (parte)'),(5022,404,02,'Mojón'),(5023,404,03,'Tejar.'),(5024,404,04,'Gregg'),(5025,404,05,'Humo'),(5026,404,06,'Mojoncito'),(5027,404,07,'Pan de Azúcar.'),(5028,405,01,'Jocote'),(5029,405,02,'Juanilama'),(5030,405,03,'San Juan Chiquito.'),(5031,406,01,'Marañonal (parte).'),(5032,406,02,'Bruselas'),(5033,406,03,'Guapinol'),(5034,406,04,'Nances'),(5035,406,05,'San Roque.'),(5036,407,01,'Alto Corteza'),(5037,407,02,'Barón'),(5038,407,03,'Facio'),(5039,407,04,'Llanada del Cacao'),(5040,407,05,'Maratón.'),(5041,408,01,'Cerrillos'),(5042,408,02,'Mesetas Abajo'),(5043,408,03,'Mesetas Arriba'),(5044,408,04,'Peña Blanca'),(5045,408,05,'Pretiles'),(5046,408,06,'Quebradas'),(5047,408,07,'Sabana Bonita.'),(5048,409,01,'Alto de Las Mesas'),(5049,409,02,'Artieda'),(5050,409,03,'Caldera'),(5051,409,04,'Cabezas'),(5052,409,05,'Cambalache'),(5053,409,06,'Cascabel'),(5054,409,07,'Corralillo'),(5055,409,08,'Cuesta Jocote'),(5056,409,09,'Figueroa'),(5057,409,10,'Finca Brazo Seco'),(5058,409,11,'Finca Cortijo'),(5059,409,12,'Guardianes de La Piedra'),(5060,409,13,'Hacienda La Moncha'),(5061,409,14,'Hacienda Mata de Guinea'),(5062,409,15,'Hacienda Playa Linda'),(5063,409,16,'Hacienda Salinas'),(5064,409,17,'Jesús María'),(5065,409,18,'Quebrada Honda'),(5066,409,19,'Salinas'),(5067,409,20,'San Antonio'),(5068,409,21,'Silencio'),(5069,409,22,'Tivives'),(5070,409,23,'Villanueva.'),(5071,410,01,'Alto Buenos Aires'),(5072,410,02,'Lomas.'),(5073,410,03,'Alto Alejo'),(5074,410,04,'Alto Brisas'),(5075,410,05,'Alto Calderón'),(5076,410,06,'Bajo Brisas'),(5077,410,07,'Bolas'),(5078,410,08,'Brujo'),(5079,410,09,'Cabagra (parte)'),(5080,410,10,'Caracol'),(5081,410,11,'Ceibo'),(5082,410,12,'Colepato'),(5083,410,13,'El Carmen'),(5084,410,14,'Guanacaste'),(5085,410,15,'Guadalupe'),(5086,410,16,'López'),(5087,410,17,'Los Altos'),(5088,410,18,'Llano Verde'),(5089,410,19,'Machomontes'),(5090,410,20,'Palmital'),(5091,410,21,'Paraíso (Ánimas)'),(5092,410,22,'Paso Verbá'),(5093,410,23,'Piñera'),(5094,410,24,'Platanares'),(5095,410,25,'Potrero Cerrado'),(5096,410,26,'Puente de Salitre'),(5097,410,27,'Río Azul'),(5098,410,28,'Salitre'),(5099,410,29,'San Carlos'),(5100,410,30,'San Luis (Florida)'),(5101,410,31,'San Miguel Este'),(5102,410,32,'San Miguel Oeste'),(5103,410,33,'San Vicente'),(5104,410,34,'Santa Cruz'),(5105,410,35,'Santa Eduvigis'),(5106,410,36,'Santa Marta'),(5107,410,37,'Sipar'),(5108,410,38,'Ujarrás'),(5109,410,39,'Villahermosa'),(5110,410,40,'Yheri.'),(5111,411,01,'Altamira'),(5112,411,02,'Ángel Arriba'),(5113,411,03,'Bajos del Río Grande'),(5114,411,04,'Cacao'),(5115,411,05,'Convento'),(5116,411,06,'Cordoncillo'),(5117,411,07,'Los Ángeles'),(5118,411,08,'Longo Mai'),(5119,411,09,'Peje'),(5120,411,10,'Quebradas'),(5121,411,11,'Río Grande'),(5122,411,12,'Sabanilla'),(5123,411,13,'Sonador'),(5124,411,14,'Tarise'),(5125,411,15,'Tres Ríos'),(5126,411,16,'Ultrapez.'),(5127,412,01,'Alto La Cruz.'),(5128,412,02,'Alto Tigre'),(5129,412,03,'Ángeles'),(5130,412,04,'Boca Limón'),(5131,412,05,'Brazos de Oro'),(5132,412,06,'Cabagra (parte)'),(5133,412,07,'Campo Alegre'),(5134,412,08,'Capri'),(5135,412,09,'Caracol'),(5136,412,10,'Caracucho'),(5137,412,11,'Clavera'),(5138,412,12,'Colegallo'),(5139,412,13,'Copal'),(5140,412,14,'Coto Brus (parte)'),(5141,412,15,'Cuesta Marañones'),(5142,412,16,'Delicias'),(5143,412,17,'Garrote'),(5144,412,18,'Guácimo'),(5145,412,19,'Guaria'),(5146,412,20,'Helechales'),(5147,412,21,'Jabillo'),(5148,412,22,'Jorón'),(5149,412,23,'Juntas'),(5150,412,24,'Lucha'),(5151,412,25,'Maravilla'),(5152,412,26,'Mesas'),(5153,412,27,'Mirador'),(5154,412,28,'Montelimar'),(5155,412,29,'Mosca'),(5156,412,30,'Palmira'),(5157,412,31,'Paso Real'),(5158,412,32,'Peje'),(5159,412,33,'Pita'),(5160,412,34,'Platanillal'),(5161,412,35,'Quijada'),(5162,412,36,'Río Coto'),(5163,412,37,'San Antonio'),(5164,412,38,'San Carlos'),(5165,412,39,'San Rafael de Cabagra'),(5166,412,40,'Santa Cecilia'),(5167,412,41,'Singri'),(5168,412,42,'Tablas'),(5169,412,43,'Tamarindo'),(5170,412,44,'Térraba'),(5171,412,45,'Tres Colinas'),(5172,412,46,'Tierras Negras'),(5173,412,47,'Volcancito'),(5174,412,48,'Vueltas.'),(5175,413,01,'Alto del Mojón'),(5176,413,02,'Bellavista'),(5177,413,03,'Cajón'),(5178,413,04,'Curré'),(5179,413,05,'Chamba'),(5180,413,06,'Changuenita'),(5181,413,07,'Doboncragua'),(5182,413,08,'Iguana'),(5183,413,09,'Kuibín'),(5184,413,10,'Lagarto'),(5185,413,11,'Mano de Tigre'),(5186,413,12,'Miravalles'),(5187,413,13,'Ojo de Agua (parte)'),(5188,413,14,'Presa'),(5189,413,15,'Puerto Nuevo'),(5190,413,16,'Sabanas (Barranco) (parte)'),(5191,413,17,'San Joaquín'),(5192,413,18,'Santa Cruz'),(5193,413,19,'Tigre'),(5194,413,20,'Tres Ríos.'),(5195,414,01,'Alto Pilas'),(5196,414,02,'Bajo Pilas'),(5197,414,03,'Bijagual'),(5198,414,04,'Ceibón'),(5199,414,05,'Concepción (La Danta)'),(5200,414,06,'Dibujada'),(5201,414,07,'Fortuna'),(5202,414,08,'La Gloria (Los Mangos)'),(5203,414,09,'Laguna'),(5204,414,10,'Ojo de Agua'),(5205,414,11,'Paso La Tinta'),(5206,414,12,'Pueblo Nuevo'),(5207,414,13,'Sabanas (Barranco parte)'),(5208,414,14,'Silencio'),(5209,414,15,'Tumbas.'),(5210,415,01,'Aguas Frescas'),(5211,415,02,'Alto Esmeralda'),(5212,415,03,'Ángeles'),(5213,415,04,'Bajo Dioses'),(5214,415,05,'Bajo Maíz'),(5215,415,06,'Bolsa'),(5216,415,07,'Cedral (Boquete)'),(5217,415,08,'Escuadra'),(5218,415,09,'Filadelfia (Aguabuena)'),(5219,415,10,'Guagaral'),(5220,415,11,'Jabillo'),(5221,415,12,'Jalisco'),(5222,415,13,'Laguna'),(5223,415,14,'Lajas'),(5224,415,15,'Maíz de Boruca'),(5225,415,16,'Mallal'),(5226,415,17,'Nubes'),(5227,415,18,'Ojo de Agua (parte)'),(5228,415,19,'San Luis'),(5229,415,20,'Virgen.'),(5230,416,01,'Alto Cacao'),(5231,416,02,'Bajo Mamey'),(5232,416,03,'Bonga'),(5233,416,04,'Cacique'),(5234,416,05,'Cantú'),(5235,416,06,'Cruces'),(5236,416,07,'Limón'),(5237,416,08,'Paraíso'),(5238,416,09,'Pataste'),(5239,416,10,'Pilón'),(5240,416,11,'Quebrada Bonita'),(5241,416,12,'San Luis'),(5242,416,13,'Santa Lucía'),(5243,416,14,'Santa María'),(5244,416,15,'Tres Ríos'),(5245,416,16,'Vegas de Chánguena'),(5246,416,17,'Vuelta Campana'),(5247,416,18,'Zapotal.'),(5248,417,01,'Almácigo'),(5249,417,02,'Altamira'),(5250,417,03,'Alto Sábalo'),(5251,417,04,'Bajo Sábalo'),(5252,417,05,'Bajos de Coto'),(5253,417,06,'Biolley'),(5254,417,07,'Carmen'),(5255,417,08,'Hamacas'),(5256,417,09,'Guayacán'),(5257,417,10,'Manzano'),(5258,417,11,'Naranjos'),(5259,417,12,'Puna.'),(5260,418,01,'Achiote'),(5261,418,02,'Alto Achiote'),(5262,418,03,'Cañas'),(5263,418,04,'Guadalajara'),(5264,418,05,'Llano Bonito'),(5265,418,06,'Oasis'),(5266,418,07,'San Rafael'),(5267,418,08,'Santa Cecilia'),(5268,418,09,'Santa María'),(5269,418,10,'Santa Rosa'),(5270,418,11,'Socorro.'),(5271,419,01,'Alto Pavones'),(5272,419,02,'Bajo Zamora'),(5273,419,03,'Barbudal'),(5274,419,04,'Bellavista'),(5275,419,05,'Brillante (parte)'),(5276,419,06,'Cabuyal'),(5277,419,07,'Delicias'),(5278,419,08,'Fraijanes'),(5279,419,09,'Lagunilla'),(5280,419,10,'Río Seco'),(5281,419,11,'Tajo Alto'),(5282,419,12,'Trinidad'),(5283,419,13,'Zagala Vieja'),(5284,419,14,'Zamora'),(5285,419,15,'Zapotal (parte).'),(5286,420,01,'Bajo Caliente (parte)'),(5287,420,02,'Cedral'),(5288,420,03,'Laguna'),(5289,420,04,'Micas'),(5290,420,05,'Palmital'),(5291,420,06,'San Buenaventura'),(5292,420,07,'Velásquez'),(5293,420,08,'Ventanas'),(5294,420,09,'Zagala Nueva.'),(5295,421,01,'Aguabuena'),(5296,421,02,'Ciruelas'),(5297,421,03,'Cuatro Cruces'),(5298,421,04,'Isla'),(5299,421,05,'Santa Rosa'),(5300,421,06,'Tiocinto.'),(5301,422,01,'Canadá'),(5302,422,02,'Cementerio'),(5303,422,03,'Cinco Esquinas'),(5304,422,04,'Precario'),(5305,422,05,'Pueblo Nuevo'),(5306,422,06,'Renacimiento'),(5307,422,07,'Yuca.'),(5308,422,08,'Balsar'),(5309,422,09,'Bocabrava'),(5310,422,10,'Bocachica'),(5311,422,11,'Cerrón'),(5312,422,12,'Coronado'),(5313,422,13,'Chontales'),(5314,422,14,'Delicias'),(5315,422,15,'Embarcadero'),(5316,422,16,'Fuente'),(5317,422,17,'Isla Sorpresa'),(5318,422,18,'Lindavista'),(5319,422,19,'Lourdes'),(5320,422,20,'Ojochal'),(5321,422,21,'Ojo de Agua'),(5322,422,22,'Parcelas'),(5323,422,23,'Pozo'),(5324,422,24,'Punta Mala'),(5325,422,25,'Punta Mala Arriba'),(5326,422,26,'San Buenaventura'),(5327,422,27,'San Juan'),(5328,422,28,'San Marcos'),(5329,422,29,'Tagual'),(5330,422,30,'Tortuga Abajo'),(5331,422,31,'Tres Ríos'),(5332,422,32,'Vista de Térraba.'),(5333,423,01,'Betania'),(5334,423,02,'Once de Abril'),(5335,423,03,'Palmar Sur.'),(5336,423,04,'Alemania'),(5337,423,05,'Alto Ángeles'),(5338,423,06,'Alto Encanto'),(5339,423,07,'Alto Montura'),(5340,423,08,'Bellavista'),(5341,423,09,'Calavera'),(5342,423,10,'Cansot'),(5343,423,11,'Cañablancal (Este)'),(5344,423,12,'Cañablancal (Oeste) Coobó (Progreso)'),(5345,423,13,'Coquito'),(5346,423,14,'Gorrión'),(5347,423,15,'Jalaca (parte)'),(5348,423,16,'Olla Cero'),(5349,423,17,'Palma'),(5350,423,18,'Paraíso'),(5351,423,19,'Primero de Marzo'),(5352,423,20,'Puerta del Sol'),(5353,423,21,'San Cristóbal'),(5354,423,22,'San Francisco (Tinoco)'),(5355,423,23,'San Gabriel'),(5356,423,24,'San Isidro'),(5357,423,25,'San Rafael'),(5358,423,26,'Santa Elena'),(5359,423,27,'Silencio'),(5360,423,28,'Trocha'),(5361,423,29,'Vergel'),(5362,423,30,'Victoria'),(5363,423,31,'Zapote.'),(5364,424,01,'Ajuntaderas'),(5365,424,02,'Alto Los Mogos'),(5366,424,03,'Alto San Juan'),(5367,424,04,'Bahía Chal'),(5368,424,05,'Bajos Matías'),(5369,424,06,'Barco'),(5370,424,07,'Bejuco'),(5371,424,08,'Boca Chocuaco'),(5372,424,09,'Gallega'),(5373,424,10,'Camíbar'),(5374,424,11,'Campo de Aguabuena'),(5375,424,12,'Cantarrana'),(5376,424,13,'Charcos'),(5377,424,14,'Chocuaco'),(5378,424,15,'Garrobo'),(5379,424,16,'Guabos'),(5380,424,17,'Isidora'),(5381,424,18,'Islotes'),(5382,424,19,'Jalaca (parte)'),(5383,424,20,'Julia'),(5384,424,21,'Miramar'),(5385,424,22,'Mogos'),(5386,424,23,'Monterrey'),(5387,424,24,'Playa Palma'),(5388,424,25,'Playitas'),(5389,424,26,'Potrero'),(5390,424,27,'Puerto Escondido'),(5391,424,28,'Rincón'),(5392,424,29,'Sábalo'),(5393,424,30,'San Gerardo'),(5394,424,31,'San Juan'),(5395,424,32,'Taboga'),(5396,424,33,'Taboguita'),(5397,424,34,'Tigre'),(5398,424,35,'Varillal.'),(5399,425,01,'Bahía'),(5400,425,02,'Ballena'),(5401,425,03,'Brisas'),(5402,425,04,'Cambutal'),(5403,425,05,'Dominical'),(5404,425,06,'Dominicalito'),(5405,425,07,'Escaleras'),(5406,425,08,'Piedra Achiote'),(5407,425,09,'Piñuela'),(5408,425,10,'Playa Hermosa'),(5409,425,11,'Poza Azul'),(5410,425,12,'Puerto Nuevo'),(5411,425,13,'Quebrada Grande'),(5412,425,14,'Rocas Amancio'),(5413,425,15,'San Josecito'),(5414,425,16,'San Martín'),(5415,425,17,'Tortuga Arriba'),(5416,425,18,'Ventanas.'),(5417,426,01,'Ángeles'),(5418,426,02,'Bellavista'),(5419,426,03,'Calera'),(5420,426,04,'Cerro Oscuro'),(5421,426,05,'Chacarita'),(5422,426,06,'Fila'),(5423,426,07,'Finca Alajuela'),(5424,426,08,'Finca Guanacaste'),(5425,426,09,'Finca Puntarenas'),(5426,426,10,'Florida'),(5427,426,11,'Guaria'),(5428,426,12,'Kilómetro 40'),(5429,426,13,'Navidad'),(5430,426,14,'Nubes'),(5431,426,15,'Porvenir'),(5432,426,16,'Rincón Caliente'),(5433,426,17,'Salamá'),(5434,426,18,'San Martín'),(5435,426,19,'Santa Cecilia'),(5436,426,20,'Santa Rosa'),(5437,426,21,'Sinaí'),(5438,426,22,'Venecia'),(5439,426,23,'Villa Bonita'),(5440,426,24,'Villa Colón.'),(5441,427,01,'Ángeles'),(5442,427,02,'Banegas'),(5443,427,03,'Boca Ganado'),(5444,427,04,'Campanario'),(5445,427,05,'Caletas'),(5446,427,06,'Guerra'),(5447,427,07,'Planes'),(5448,427,08,'Progreso'),(5449,427,09,'Quebrada Ganado'),(5450,427,10,'Rancho Quemado'),(5451,427,11,'Riyito'),(5452,427,12,'San                   Josecito (Rincón)'),(5453,427,13,'San Pedrillo.'),(5454,428,01,'Boca Vieja'),(5455,428,02,'Cocal'),(5456,428,03,'Colinas del Este'),(5457,428,04,'Inmaculada'),(5458,428,05,'Junta Naranjo'),(5459,428,06,'La Zona'),(5460,428,07,'Rancho Grande.'),(5461,428,08,'Anita'),(5462,428,09,'Bartolo'),(5463,428,10,'Boca Naranjo'),(5464,428,11,'Cañas'),(5465,428,12,'Cañitas'),(5466,428,13,'Cerritos'),(5467,428,14,'Cerros'),(5468,428,15,'Damas'),(5469,428,16,'Delicias'),(5470,428,17,'Espadilla'),(5471,428,18,'Estero Damas'),(5472,428,19,'Estero Garita'),(5473,428,20,'Gallega'),(5474,428,21,'Llamarón'),(5475,428,22,'Llorona'),(5476,428,23,'Managua'),(5477,428,24,'Manuel Antonio'),(5478,428,25,'Marítima'),(5479,428,26,'Mona'),(5480,428,27,'Papaturro'),(5481,428,28,'Paquita'),(5482,428,29,'Pastora'),(5483,428,30,'Quebrada Azul'),(5484,428,31,'Rey'),(5485,428,32,'Ríos'),(5486,428,33,'Roncador'),(5487,428,34,'San Rafael.'),(5488,429,01,'Dos Bocas'),(5489,429,02,'Guabas'),(5490,429,03,'Guápil'),(5491,429,04,'Hatillo Nuevo'),(5492,429,05,'Hatillo Viejo'),(5493,429,06,'Laguna'),(5494,429,07,'Nubes'),(5495,429,08,'Palma Quemada'),(5496,429,09,'Pasito'),(5497,429,10,'Paso'),(5498,429,11,'Paso Guanacaste'),(5499,429,12,'Platanillo'),(5500,429,13,'Playa Matapalo'),(5501,429,14,'Portalón'),(5502,429,15,'Punto de Mira'),(5503,429,16,'Salitral'),(5504,429,17,'Salsipuedes'),(5505,429,18,'San Andrés'),(5506,429,19,'Santo Domingo'),(5507,429,20,'Silencio'),(5508,429,21,'Tierras Morenas'),(5509,429,22,'Tres Piedras (parte).'),(5510,430,01,'Bijagual'),(5511,430,02,'Buenos Aires'),(5512,430,03,'Capital'),(5513,430,04,'Concepción'),(5514,430,05,'Cotos'),(5515,430,06,'Londres'),(5516,430,07,'Negro'),(5517,430,08,'Pascua'),(5518,430,09,'Paso Indios'),(5519,430,10,'Paso Real'),(5520,430,11,'Sábalo'),(5521,430,12,'Santa Juana'),(5522,430,13,'Tocorí'),(5523,430,14,'Villanueva.'),(5524,431,01,'Alamedas'),(5525,431,02,'Bellavista'),(5526,431,03,'Bolsa'),(5527,431,04,'Disco'),(5528,431,05,'Kilómetro 1'),(5529,431,06,'Kilómetro 2'),(5530,431,07,'Kilómetro 3'),(5531,431,08,'Laguna'),(5532,431,09,'Llano Bonito'),(5533,431,10,'Minerva'),(5534,431,11,'Naranjal'),(5535,431,12,'Oasis de Esperanza'),(5536,431,13,'Parroquial'),(5537,431,14,'Pueblo Civil'),(5538,431,15,'Rotonda'),(5539,431,16,'San Andrés'),(5540,431,17,'San Martín'),(5541,431,18,'Zona Gris.'),(5542,431,19,'Aguada'),(5543,431,20,'Ánimas'),(5544,431,21,'Atrocho'),(5545,431,22,'Bajo Chontales'),(5546,431,23,'Bajo de Coto'),(5547,431,24,'Bajo Grapa'),(5548,431,25,'Bajo Mansito'),(5549,431,26,'Bajo Sucio'),(5550,431,27,'Bajos de Cañablanca'),(5551,431,28,'Cuarenta y Cinco'),(5552,431,29,'Dos Ríos'),(5553,431,30,'Esperanza de Coto'),(5554,431,31,'Gallardo'),(5555,431,32,'Huacas'),(5556,431,33,'Jorge Brenes Durán'),(5557,431,34,'Kilómetro 5'),(5558,431,35,'Kilómetro 7'),(5559,431,36,'Kilómetro 9'),(5560,431,37,'Kilómetro 16'),(5561,431,38,'Kilómetro 20'),(5562,431,39,'Kilómetro 24'),(5563,431,40,'Manuel Tucker Martínez'),(5564,431,41,'Mona'),(5565,431,42,'Nazaret'),(5566,431,43,'Paso Higuerón'),(5567,431,44,'Playa Cacao'),(5568,431,45,'Puerto Escondido'),(5569,431,46,'Puntarenitas'),(5570,431,47,'Purruja'),(5571,431,48,'Rancho Relámpago'),(5572,431,49,'Riyito'),(5573,431,50,'Saladero'),(5574,431,51,'Saladerito'),(5575,431,52,'San Francisco'),(5576,431,53,'San Josecito'),(5577,431,54,'Torres'),(5578,431,55,'Trenzas'),(5579,431,56,'Unión de Coto'),(5580,431,57,'Ureña'),(5581,431,58,'Valle Bonito'),(5582,431,59,'Viquilla Dos.'),(5583,432,01,'Pueblo Nuevo.'),(5584,432,02,'Aguabuena'),(5585,432,03,'Agujas'),(5586,432,04,'Miramar (Altos Corozal)'),(5587,432,05,'Amapola'),(5588,432,06,'Balsa'),(5589,432,07,'Bambú'),(5590,432,08,'Barrigones'),(5591,432,09,'Barrio Bonito'),(5592,432,10,'Boca Gallardo'),(5593,432,11,'Cañaza'),(5594,432,12,'Carate'),(5595,432,13,'Carbonera'),(5596,432,14,'Cerro de Oro'),(5597,432,15,'Dos Brazos'),(5598,432,16,'Guadalupe'),(5599,432,17,'Independencia'),(5600,432,18,'Lajitas'),(5601,432,19,'Ñeque'),(5602,432,20,'Palma'),(5603,432,21,'Paloseco'),(5604,432,22,'Playa Blanca'),(5605,432,23,'Playa Tigre'),(5606,432,24,'Puerto Escondido'),(5607,432,25,'Quebrada Latarde'),(5608,432,26,'Río Nuevo'),(5609,432,27,'Río Oro'),(5610,432,28,'Río Piro (Coyunda)'),(5611,432,29,'Sándalo'),(5612,432,30,'San Miguel'),(5613,432,31,'Sombrero'),(5614,432,32,'Terrones'),(5615,432,33,'Tigre.'),(5616,433,01,'Santiago.'),(5617,433,02,'Bajo Bonita'),(5618,433,03,'Bajo Cedros'),(5619,433,04,'Buenavista'),(5620,433,05,'Cerro Café'),(5621,433,06,'Chiqueros'),(5622,433,07,'Delicias'),(5623,433,08,'El Alto'),(5624,433,09,'Esperanza'),(5625,433,10,'Gamba'),(5626,433,11,'Kilómetro 29'),(5627,433,12,'Kilómetro 33'),(5628,433,13,'La Julieta'),(5629,433,14,'Santiago de Caracol'),(5630,433,15,'Tigre (Caracol Norte)'),(5631,433,16,'Valle Cedros'),(5632,433,17,'Vegas de Río Claro'),(5633,433,18,'Villa Briceño'),(5634,433,19,'Viquilla Uno.'),(5635,434,01,'Altos de Conte'),(5636,434,02,'Banco'),(5637,434,03,'Burica'),(5638,434,04,'Clarita'),(5639,434,05,'Cocal Amarillo'),(5640,434,06,'Cuervito'),(5641,434,07,'Escuadra'),(5642,434,08,'Esperanza de Sábalos'),(5643,434,09,'Estero Colorado'),(5644,434,10,'Estrella'),(5645,434,11,'Flor de Coto'),(5646,434,12,'Fortuna de Coto'),(5647,434,13,'Guaymí'),(5648,434,14,'Higo'),(5649,434,15,'Jardín'),(5650,434,16,'La Virgen'),(5651,434,17,'Lindamar'),(5652,434,18,'Manzanillo'),(5653,434,19,'Pavones'),(5654,434,20,'Peñas'),(5655,434,21,'Peñita'),(5656,434,22,'Puerto Pilón'),(5657,434,23,'Puesto La Playa'),(5658,434,24,'Punta Banco'),(5659,434,25,'Quebrada Honda'),(5660,434,26,'Riviera'),(5661,434,27,'Sábalos'),(5662,434,28,'Tigrito'),(5663,434,29,'Unión del Sur'),(5664,434,30,'Vanegas'),(5665,434,31,'Yerba'),(5666,434,32,'Zancudo.'),(5667,435,01,'Canadá'),(5668,435,02,'María Auxiliadora'),(5669,435,03,'Tres Ríos.'),(5670,435,04,'Aguas Claras'),(5671,435,05,'Bajo Reyes'),(5672,435,06,'Bajo Venado'),(5673,435,07,'Barrantes'),(5674,435,08,'Ceibo'),(5675,435,09,'Cruces'),(5676,435,10,'Cuenca de Oro'),(5677,435,11,'Danto'),(5678,435,12,'Fila Guinea'),(5679,435,13,'Isla'),(5680,435,14,'Lindavista'),(5681,435,15,'Lourdes'),(5682,435,16,'Maravilla'),(5683,435,17,'Piedra Pintada'),(5684,435,18,'San Joaquín'),(5685,435,19,'Santa Clara'),(5686,435,20,'Torre Alta.'),(5687,436,01,'Ángeles'),(5688,436,02,'Brasilia'),(5689,436,03,'Casablanca'),(5690,436,04,'Chanchera'),(5691,436,05,'El Gallo'),(5692,436,06,'Juntas'),(5693,436,07,'La Esmeralda'),(5694,436,08,'Lucha'),(5695,436,09,'Mellizas'),(5696,436,10,'Miraflores'),(5697,436,11,'Piedra de Candela'),(5698,436,12,'Plantel'),(5699,436,13,'Porto Llano'),(5700,436,14,'Primavera'),(5701,436,15,'Progreso'),(5702,436,16,'Providencia'),(5703,436,17,'Pueblo Nuevo'),(5704,436,18,'Río Negro'),(5705,436,19,'Río Sereno'),(5706,436,20,'San Antonio'),(5707,436,21,'San Bosco'),(5708,436,22,'San Francisco'),(5709,436,23,'San Luis'),(5710,436,24,'San Marcos'),(5711,436,25,'San Miguel'),(5712,436,26,'San Rafael'),(5713,436,27,'San Ramón'),(5714,436,28,'Santa Rosa'),(5715,436,29,'Santa Teresa'),(5716,436,30,'Tigra'),(5717,436,31,'Trinidad'),(5718,436,32,'Unión'),(5719,436,33,'Valle Hermoso.'),(5720,437,01,'Bello Oriente'),(5721,437,02,'Campo Tres'),(5722,437,03,'Cañas Gordas'),(5723,437,04,'Concepción'),(5724,437,05,'Copabuena'),(5725,437,06,'Copal'),(5726,437,07,'Fila Zapote'),(5727,437,08,'Metaponto'),(5728,437,09,'Pilares'),(5729,437,10,'Pueblo Nuevo'),(5730,437,11,'Quebrada Bonita'),(5731,437,12,'Río Salto'),(5732,437,13,'San Francisco'),(5733,437,14,'San Gabriel'),(5734,437,15,'San Pedro'),(5735,437,16,'Santa Cecilia'),(5736,437,17,'Santa Marta'),(5737,437,18,'Santo Domingo'),(5738,437,19,'Valle Azul.'),(5739,438,01,'Aguacate'),(5740,438,02,'Alto Limoncito'),(5741,438,03,'Ángeles'),(5742,438,04,'Bonanza'),(5743,438,05,'Brusmalis'),(5744,438,06,'Chiva'),(5745,438,07,'Desamparados'),(5746,438,08,'Esperanza'),(5747,438,09,'Fila'),(5748,438,10,'Manchuria'),(5749,438,11,'Sabanilla'),(5750,438,12,'San Gerardo'),(5751,438,13,'San Juan'),(5752,438,14,'San Miguel'),(5753,438,15,'San Rafael'),(5754,438,16,'Santa Marta'),(5755,438,17,'Santa Rita'),(5756,438,18,'Unión'),(5757,438,19,'Valle'),(5758,438,20,'Villapalacios'),(5759,438,21,'Zumbona.'),(5760,439,01,'Aguacaliente'),(5761,439,02,'Camaquiri'),(5762,439,03,'Cocorí'),(5763,439,04,'Coto Brus (parte)'),(5764,439,05,'Fila Méndez'),(5765,439,06,'Fila Naranjo'),(5766,439,07,'Fila Tigre'),(5767,439,08,'Marías'),(5768,439,09,'Monterrey'),(5769,439,10,'Palmira'),(5770,439,11,'Santa Fe.'),(5771,440,01,'Alpha'),(5772,440,02,'Alturas de Cotón'),(5773,440,03,'Brisas'),(5774,440,04,'Fila Pinar'),(5775,440,05,'Fila San Rafael'),(5776,440,06,'Flor del Roble'),(5777,440,07,'Guinea Arriba'),(5778,440,08,'La Administración'),(5779,440,09,'Libertad'),(5780,440,10,'Poma'),(5781,440,11,'Río Marzo'),(5782,440,12,'Roble'),(5783,440,13,'Roble Arriba'),(5784,440,14,'Siete Colinas.'),(5785,441,01,'Julieta'),(5786,441,02,'Pueblo Nuevo.'),(5787,441,03,'Alto Camacho'),(5788,441,04,'Ángeles'),(5789,441,05,'Bajos Jicote'),(5790,441,06,'Bambú'),(5791,441,07,'Bandera'),(5792,441,08,'Barbudal'),(5793,441,09,'Bejuco'),(5794,441,10,'Boca del Parrita'),(5795,441,11,'Carmen (parte)'),(5796,441,12,'Chires'),(5797,441,13,'Chires Arriba'),(5798,441,14,'Chirraca Abajo'),(5799,441,15,'Chirraca Arriba'),(5800,441,16,'Esterillos Centro'),(5801,441,17,'Esterillos Este'),(5802,441,18,'Esterillos Oeste'),(5803,441,19,'Fila Surubres'),(5804,441,20,'Guapinol'),(5805,441,21,'Higuito'),(5806,441,22,'I Griega'),(5807,441,23,'Isla Damas'),(5808,441,24,'Isla Palo Seco'),(5809,441,25,'Jicote'),(5810,441,26,'Loma'),(5811,441,27,'Mesas'),(5812,441,28,'Palmas'),(5813,441,29,'Palo Seco'),(5814,441,30,'Pirrís'),(5815,441,31,'Playa Palma'),(5816,441,32,'Playón'),(5817,441,33,'Playón Sur'),(5818,441,34,'Pirrís (Las Parcelas)'),(5819,441,35,'Pocares'),(5820,441,36,'Pocarito'),(5821,441,37,'Porvenir'),(5822,441,38,'Punta Judas'),(5823,441,39,'Rincón Morales'),(5824,441,40,'Río Negro (parte)'),(5825,441,41,'Río Seco'),(5826,441,42,'San Antonio'),(5827,441,43,'San Bosco'),(5828,441,44,'San Gerardo'),(5829,441,45,'San Isidro'),(5830,441,46,'San Juan'),(5831,441,47,'San Julián'),(5832,441,48,'San Rafael Norte'),(5833,441,49,'Sardinal'),(5834,441,50,'Sardinal Sur'),(5835,441,51,'Surubres'),(5836,441,52,'Teca'),(5837,441,53,'Tigre'),(5838,441,54,'Turbio'),(5839,441,55,'Valle Vasconia'),(5840,441,56,'Vueltas.'),(5841,442,01,'Bosque'),(5842,442,02,'Caño Seco'),(5843,442,03,'Capri'),(5844,442,04,'Carmen'),(5845,442,05,'Corredor'),(5846,442,06,'Progreso'),(5847,442,07,'San Juan'),(5848,442,08,'Valle del Sur.'),(5849,442,09,'Abrojo'),(5850,442,10,'Aguilares'),(5851,442,11,'Alto Limoncito'),(5852,442,12,'Bajo Indios'),(5853,442,13,'Betel'),(5854,442,14,'Cacoragua'),(5855,442,15,'Campiña'),(5856,442,16,'Campo Dos'),(5857,442,17,'Campo Dos y Medio'),(5858,442,18,'Cañada'),(5859,442,19,'Caracol Sur'),(5860,442,20,'Castaños'),(5861,442,21,'Coloradito'),(5862,442,22,'Concordia'),(5863,442,23,'Coto 42'),(5864,442,24,'Coto 44'),(5865,442,25,'Coto 45'),(5866,442,26,'Coto 47'),(5867,442,27,'Coto 49'),(5868,442,28,'Coto 50-51'),(5869,442,29,'Coto 52-53'),(5870,442,30,'Cuesta Fila de Cal'),(5871,442,31,'Estrella del Sur'),(5872,442,32,'Florida'),(5873,442,33,'Fortuna'),(5874,442,34,'Kilómetro 10'),(5875,442,35,'Miramar'),(5876,442,36,'Montezuma'),(5877,442,37,'Nubes'),(5878,442,38,'Pangas'),(5879,442,39,'Planes'),(5880,442,40,'Pueblo Nuevo'),(5881,442,41,'Río Bonito'),(5882,442,42,'Río Nuevo (Norte)'),(5883,442,43,'Río Nuevo (Sur)'),(5884,442,44,'San Antonio Abajo'),(5885,442,45,'San Francisco'),(5886,442,46,'San Josecito'),(5887,442,47,'San Rafael'),(5888,442,48,'Santa Cecilia'),(5889,442,49,'Santa Marta (parte)'),(5890,442,50,'Santa Rita'),(5891,442,51,'Tropezón'),(5892,442,52,'Unión'),(5893,442,53,'Vegas de Abrojo'),(5894,442,54,'Villa Roma.'),(5895,443,01,'Canoas Abajo (parte)'),(5896,443,02,'Control'),(5897,443,03,'Cuervito'),(5898,443,04,'Chorro.'),(5899,444,01,'Lotes (San Jorge).'),(5900,444,02,'Altos del Brujo'),(5901,444,03,'Bajo Brujo'),(5902,444,04,'Bajo'),(5903,444,05,'Barrionuevo'),(5904,444,06,'Canoas Abajo (parte)'),(5905,444,07,'Canoas Arriba'),(5906,444,08,'Cañaza'),(5907,444,09,'Cerro Brujo'),(5908,444,10,'Colorado'),(5909,444,11,'Chiva'),(5910,444,12,'Darizara'),(5911,444,13,'Gloria'),(5912,444,14,'Guay'),(5913,444,15,'Guayabal'),(5914,444,16,'Mariposa'),(5915,444,17,'Níspero'),(5916,444,18,'Palma'),(5917,444,19,'Paso Canoas'),(5918,444,20,'San Antonio'),(5919,444,21,'San Isidro'),(5920,444,22,'San Martín'),(5921,444,23,'San Miguel'),(5922,444,24,'Santa Marta (parte)'),(5923,444,25,'Veguitas de Colorado'),(5924,444,26,'Veracruz'),(5925,444,27,'Villas de Darizara.'),(5926,445,01,'Alto Vaquita'),(5927,445,02,'Bambito'),(5928,445,03,'Bella Luz'),(5929,445,04,'Bijagual'),(5930,445,05,'Caimito'),(5931,445,06,'Cangrejo Verde'),(5932,445,07,'Caracol de la Vaca'),(5933,445,08,'Cariari'),(5934,445,09,'Caucho'),(5935,445,10,'Cenizo'),(5936,445,11,'Colonia Libertad'),(5937,445,12,'Coyoche'),(5938,445,13,'Jobo Civil'),(5939,445,14,'Kilómetro 22'),(5940,445,15,'Kilómetro 25'),(5941,445,16,'Kilómetro 27'),(5942,445,17,'Kilómetro 29'),(5943,445,18,'Mango'),(5944,445,19,'Pueblo de Dios'),(5945,445,20,'Puerto González Víquez'),(5946,445,21,'Río Incendio'),(5947,445,22,'Roble'),(5948,445,23,'San Juan'),(5949,445,24,'Santa Lucía'),(5950,445,25,'Tamarindo'),(5951,445,26,'Vaca (Santa Rosa)'),(5952,445,27,'Vereh'),(5953,445,28,'Zaragoza.'),(5954,446,01,'Agujitas'),(5955,446,02,'Buenos Aires'),(5956,446,03,'Cañablancal'),(5957,446,04,'Cerro Fresco'),(5958,446,05,'Herradura'),(5959,446,06,'Mona'),(5960,446,07,'Playa Hermosa'),(5961,446,08,'Playa Herradura'),(5962,446,09,'Pochotal'),(5963,446,10,'Puerto Escondido'),(5964,446,11,'Quebrada Amarilla'),(5965,446,12,'San Antonio'),(5966,446,13,'Turrubaritos'),(5967,446,14,'Tusubres.'),(5968,447,01,'Agujas'),(5969,447,02,'Bajamar'),(5970,447,03,'Bellavista'),(5971,447,04,'Caletas'),(5972,447,05,'Camaronal'),(5973,447,06,'Camaronal Arriba'),(5974,447,07,'Capulín'),(5975,447,08,'Carrizal de Bajamar'),(5976,447,09,'Guacalillo'),(5977,447,10,'Mantas'),(5978,447,11,'Nambí'),(5979,447,12,'Peñón de Tivives'),(5980,447,13,'Pigres'),(5981,447,14,'Pita'),(5982,447,15,'Playa Azul'),(5983,447,16,'Pógeres'),(5984,447,17,'Puerto Peje'),(5985,447,18,'Punta Leona'),(5986,447,19,'Tárcoles'),(5987,447,20,'Tarcolitos.'),(5988,448,01,'Bellavista'),(5989,448,02,'Bohío'),(5990,448,03,'Bosque'),(5991,448,04,'Buenos Aires'),(5992,448,05,'Cangrejos'),(5993,448,06,'Cariari'),(5994,448,07,'Cerro Mocho'),(5995,448,08,'Cielo Amarillo'),(5996,448,09,'Cieneguita'),(5997,448,10,'Colina'),(5998,448,11,'Corales'),(5999,448,12,'Cruce'),(6000,448,13,'Fortín'),(6001,448,14,'Garrón'),(6002,448,15,'Hospital'),(6003,448,16,'Jamaica Town'),(6004,448,17,'Japdeva'),(6005,448,18,'Laureles'),(6006,448,19,'Limoncito'),(6007,448,20,'Lirios'),(6008,448,21,'Moín'),(6009,448,22,'Piuta'),(6010,448,23,'Portete'),(6011,448,24,'Pueblo Nuevo'),(6012,448,25,'San Juan'),(6013,448,26,'Santa Eduvigis'),(6014,448,27,'Trinidad'),(6015,448,28,'Veracruz.'),(6016,448,29,'Buenos Aires'),(6017,448,30,'Cocal'),(6018,448,31,'Dos Bocas'),(6019,448,32,'Empalme Moín'),(6020,448,33,'Milla Nueve'),(6021,448,34,'Santa Rosa'),(6022,448,35,'Valle La Aurora'),(6023,448,36,'Villas del Mar Uno'),(6024,448,37,'Villas del Mar Dos'),(6025,448,38,'Villa Hermosa.'),(6026,449,01,'Colonia'),(6027,449,02,'Finca Ocho'),(6028,449,03,'Guaria'),(6029,449,04,'Loras'),(6030,449,05,'Pandora Oeste'),(6031,449,06,'Río Ley.'),(6032,449,07,'Alsacia'),(6033,449,08,'Armenia'),(6034,449,09,'Atalanta'),(6035,449,10,'Bananito Sur'),(6036,449,11,'Boca Cuen'),(6037,449,12,'Boca Río Estrella'),(6038,449,13,'Bocuare'),(6039,449,14,'Bonifacio'),(6040,449,15,'Brisas'),(6041,449,16,'Buenavista'),(6042,449,17,'Burrico'),(6043,449,18,'Calveri'),(6044,449,19,'Caño Negro'),(6045,449,20,'Cartagena'),(6046,449,21,'Casa Amarilla'),(6047,449,22,'Cerere'),(6048,449,23,'Concepción'),(6049,449,24,'Cuen'),(6050,449,25,'Chirripó Abajo (parte)'),(6051,449,26,'Durfuy (San Miguel)'),(6052,449,27,'Duruy'),(6053,449,28,'Fortuna'),(6054,449,29,'Gavilán'),(6055,449,30,'Hueco'),(6056,449,31,'I Griega'),(6057,449,32,'Jabuy'),(6058,449,33,'Llano Grande'),(6059,449,34,'Manú'),(6060,449,35,'Miramar'),(6061,449,36,'Moi (San Vicente)'),(6062,449,37,'Nanabre'),(6063,449,38,'Nubes'),(6064,449,39,'Penshurt'),(6065,449,40,'Pléyades'),(6066,449,41,'Porvenir'),(6067,449,42,'Progreso'),(6068,449,43,'Río Seco'),(6069,449,44,'San Andrés'),(6070,449,45,'San Carlos'),(6071,449,46,'San Clemente'),(6072,449,47,'San Rafael'),(6073,449,48,'Suruy'),(6074,449,49,'Talía'),(6075,449,50,'Tobruk'),(6076,449,51,'Tuba Creek (parte)'),(6077,449,52,'Valle de las Rosas'),(6078,449,53,'Vegas de Cerere'),(6079,449,54,'Vesta.'),(6080,449,55,'Brisas'),(6081,449,56,'Brisas de Veragua'),(6082,449,57,'Búfalo'),(6083,449,58,'Limón 2000'),(6084,449,59,'Loma Linda'),(6085,449,60,'México'),(6086,449,61,'Milla 9'),(6087,449,62,'Miravalles'),(6088,449,63,'Río Blanco'),(6089,449,64,'Río Cedro'),(6090,449,65,'Río Madre'),(6091,449,66,'Río Quito'),(6092,449,67,'Río Victoria'),(6093,449,68,'Sandoval'),(6094,449,69,'Santa Rita'),(6095,449,70,'Victoria.'),(6096,450,01,'Aguas Zarcas'),(6097,450,02,'Asunción'),(6098,450,03,'Bananito Norte'),(6099,450,04,'Bearesem'),(6100,450,05,'Beverley'),(6101,450,06,'Calle Tranvía'),(6102,450,07,'Castillo Nuevo'),(6103,450,08,'Dondonia'),(6104,450,09,'Filadelfia Norte'),(6105,450,10,'Filadelfia Sur'),(6106,450,11,'Kent'),(6107,450,12,'María Luisa'),(6108,450,13,'Mountain Cow'),(6109,450,14,'Paraíso'),(6110,450,15,'Polonia'),(6111,450,16,'Quitaría'),(6112,450,17,'Río Banano'),(6113,450,18,'San Cecilio'),(6114,450,19,'Tigre'),(6115,450,20,'Trébol'),(6116,450,21,'Westfalia.'),(6117,451,01,'Ángeles'),(6118,451,02,'Calle Vargas'),(6119,451,03,'Cacique'),(6120,451,04,'Cecilia'),(6121,451,05,'Coopevigua'),(6122,451,06,'Diamantes'),(6123,451,07,'Emilia'),(6124,451,08,'Floresta'),(6125,451,09,'Garabito'),(6126,451,10,'Jesús'),(6127,451,11,'Palma Dorada'),(6128,451,12,'Palmera'),(6129,451,13,'San Miguel'),(6130,451,14,'Sauces'),(6131,451,15,'Toro Amarillo.'),(6132,451,16,'Blanco'),(6133,451,17,'Calle Ángeles'),(6134,451,18,'Calle Gobierno'),(6135,451,19,'Corinto'),(6136,451,20,'Flores'),(6137,451,21,'La Guaria'),(6138,451,22,'Marina'),(6139,451,23,'Rancho Redondo.'),(6140,452,01,'Granja'),(6141,452,02,'Molino'),(6142,452,03,'Numancia'),(6143,452,04,'Santa Clara.'),(6144,452,05,'Anita Grande'),(6145,452,06,'Calle Diez'),(6146,452,07,'Calle Emilia'),(6147,452,08,'Calle Seis'),(6148,452,09,'Calle Uno'),(6149,452,10,'Condado del Río'),(6150,452,11,'Floritas'),(6151,452,12,'Parasal'),(6152,452,13,'San Luis'),(6153,452,14,'San Martín'),(6154,452,15,'San Valentín'),(6155,452,16,'Suerre.'),(6156,453,01,'Cruce de Jordán'),(6157,453,02,'Peligro'),(6158,453,03,'Pueblo Nuevo.'),(6159,453,04,'Balastre'),(6160,453,05,'Cantagallo'),(6161,453,06,'Cartagena'),(6162,453,07,'Cayuga'),(6163,453,08,'Cocorí'),(6164,453,09,'Chirvalo'),(6165,453,10,'Encina'),(6166,453,11,'Gallopinto'),(6167,453,12,'Hamburgo'),(6168,453,13,'I Griega'),(6169,453,14,'Indio'),(6170,453,15,'Jardín'),(6171,453,16,'Mercedes'),(6172,453,17,'Palmitas'),(6173,453,18,'Porvenir'),(6174,453,19,'Primavera'),(6175,453,20,'Rótulo'),(6176,453,21,'San Carlos'),(6177,453,22,'San Cristóbal'),(6178,453,23,'San Gerardo'),(6179,453,24,'San Pedro'),(6180,453,25,'Santa Elena'),(6181,453,26,'Santa Rosa'),(6182,453,27,'Sirena'),(6183,453,28,'Suárez'),(6184,453,29,'Suerte'),(6185,453,30,'Tarire'),(6186,453,31,'Teresa'),(6187,453,32,'Ticabán'),(6188,453,33,'Triángulo'),(6189,453,34,'Victoria.'),(6190,454,01,'La Cruz'),(6191,454,02,'Lesville'),(6192,454,03,'Punta de Riel.'),(6193,454,04,'Aguas Frías'),(6194,454,05,'Anabán'),(6195,454,06,'Boca Guápiles (parte)'),(6196,454,07,'Castañal'),(6197,454,08,'Cruce'),(6198,454,09,'Curia'),(6199,454,10,'Curva'),(6200,454,11,'Curva del Humo'),(6201,454,12,'Esperanza'),(6202,454,13,'Fortuna'),(6203,454,14,'Humo'),(6204,454,15,'La Lidia'),(6205,454,16,'Lomas Azules'),(6206,454,17,'Londres'),(6207,454,18,'Llano Bonito'),(6208,454,19,'Maravilla'),(6209,454,20,'Mata de Limón'),(6210,454,21,'Millón'),(6211,454,22,'Milloncito'),(6212,454,23,'Oeste'),(6213,454,24,'Prado (parte)'),(6214,454,25,'Roxana Tres'),(6215,454,26,'San Francisco'),(6216,454,27,'San Jorge'),(6217,454,28,'Vegas de Tortuguero.'),(6218,455,01,'Astúa-Pirie'),(6219,455,02,'Campo de Aterrizaje (Pueblo Triste)'),(6220,455,03,'Formosa'),(6221,455,04,'Palermo.'),(6222,455,05,'Ángeles'),(6223,455,06,'Banamola'),(6224,455,07,'Boca Guápiles (parte)'),(6225,455,08,'Campo Cuatro'),(6226,455,09,'Campo Dos'),(6227,455,10,'Campo Tres'),(6228,455,11,'Campo Tres Este'),(6229,455,12,'Campo Tres Oeste'),(6230,455,13,'Esperanza (Cantarrana)'),(6231,455,14,'Caño Chiquero'),(6232,455,15,'Carolina'),(6233,455,16,'Ceibo'),(6234,455,17,'Coopecariari'),(6235,455,18,'Cuatro Esquinas'),(6236,455,19,'Encanto'),(6237,455,20,'Frutera'),(6238,455,21,'Gaviotas'),(6239,455,22,'Hojancha'),(6240,455,23,'Maná'),(6241,455,24,'Monterrey'),(6242,455,25,'Nazaret'),(6243,455,26,'Progreso'),(6244,455,27,'Pueblo Nuevo'),(6245,455,28,'Sagrada Familia'),(6246,455,29,'San Miguel'),(6247,455,30,'Semillero'),(6248,455,31,'Vega de Río Palacios'),(6249,455,32,'Zacatales.'),(6250,456,01,'Barra del Colorado Este.'),(6251,456,02,'Aragón'),(6252,456,03,'Buenavista'),(6253,456,04,'Malanga'),(6254,456,05,'Puerto Lindo'),(6255,456,06,'San Gerardo'),(6256,456,07,'Tortuguero'),(6257,456,08,'Verdades.'),(6258,457,01,'Santa Elena.'),(6259,457,02,'Brisas del Toro Amarillo'),(6260,457,03,'Cascadas'),(6261,457,04,'La Victoria'),(6262,457,05,'Losilla'),(6263,457,06,'San Bosco'),(6264,457,07,'Prado (parte).'),(6265,458,01,'Betania'),(6266,458,02,'Brooklin'),(6267,458,03,'Indiana Uno'),(6268,458,04,'INVU'),(6269,458,05,'María Auxiliadora'),(6270,458,06,'Palmiras'),(6271,458,07,'Quebrador'),(6272,458,08,'San Rafael'),(6273,458,09,'San Martín'),(6274,458,10,'Triunfo.'),(6275,458,11,'Amelia'),(6276,458,12,'Amistad'),(6277,458,13,'Ángeles'),(6278,458,14,'Bajo Tigre'),(6279,458,15,'Barnstorf'),(6280,458,16,'Boca Pacuare'),(6281,458,17,'Boca Parismina'),(6282,458,18,'Calvario'),(6283,458,19,'Calle Tajo'),(6284,458,20,'Canadá'),(6285,458,21,'Caño Blanco'),(6286,458,22,'Carmen'),(6287,458,23,'Celina'),(6288,458,24,'Ciudadela Flores'),(6289,458,25,'Cocal'),(6290,458,26,'Coco'),(6291,458,27,'Dos Bocas (Suerre)'),(6292,458,28,'Encanto (norte)'),(6293,458,29,'Encanto (sur)'),(6294,458,30,'Ganga'),(6295,458,31,'Guayacán'),(6296,458,32,'Imperio'),(6297,458,33,'Indiana Dos'),(6298,458,34,'Indiana Tres'),(6299,458,35,'Islona'),(6300,458,36,'Lindavista'),(6301,458,37,'Livingston'),(6302,458,38,'Lucha'),(6303,458,39,'Maryland'),(6304,458,40,'Milla 52'),(6305,458,41,'Moravia'),(6306,458,42,'Morazán'),(6307,458,43,'Nueva Esperanza'),(6308,458,44,'Nueva Virginia'),(6309,458,45,'Pueblo Civil'),(6310,458,46,'San Alberto Nuevo'),(6311,458,47,'San Alberto Viejo'),(6312,458,48,'San Alejo'),(6313,458,49,'San Joaquín'),(6314,458,50,'Santo Domingo'),(6315,458,51,'Vegas de Imperio.'),(6316,459,01,'Alto Mirador'),(6317,459,02,'Altos de Pacuarito'),(6318,459,03,'Buenos Aires'),(6319,459,04,'Cimarrones'),(6320,459,05,'Culpeper'),(6321,459,06,'Cultivez'),(6322,459,07,'Freehold'),(6323,459,08,'Freeman (San Rafael)'),(6324,459,09,'Galicia'),(6325,459,10,'Isla Nueva'),(6326,459,11,'Leona'),(6327,459,12,'Madre de Dios'),(6328,459,13,'Manila'),(6329,459,14,'Monteverde'),(6330,459,15,'Pacuare'),(6331,459,16,'Perla'),(6332,459,17,'Perlita'),(6333,459,18,'Río Hondo'),(6334,459,19,'San Luis'),(6335,459,20,'San Carlos'),(6336,459,21,'San Isidro'),(6337,459,22,'San Pablo'),(6338,459,23,'Santa Rosa'),(6339,459,24,'Ten Switch'),(6340,459,25,'Trinidad'),(6341,459,26,'Unión Campesina'),(6342,459,27,'Waldeck.'),(6343,460,01,'El Alto.'),(6344,460,02,'Alto Gracias a Dios'),(6345,460,03,'Alto Laurelar'),(6346,460,04,'Altos de Pascua'),(6347,460,05,'Bonilla Abajo'),(6348,460,06,'Casorla'),(6349,460,07,'Chonta'),(6350,460,08,'Destierro'),(6351,460,09,'Fourth Cliff'),(6352,460,10,'Huecos'),(6353,460,11,'Lomas'),(6354,460,12,'Llano'),(6355,460,13,'Pascua'),(6356,460,14,'Roca'),(6357,460,15,'Rubí'),(6358,460,16,'San Antonio'),(6359,460,17,'Tunel Camp.'),(6360,461,01,'América'),(6361,461,02,'Babilonia.'),(6362,461,03,'Cacao'),(6363,461,04,'Colombiana'),(6364,461,05,'Herediana'),(6365,461,06,'Milano'),(6366,461,07,'Trinidad'),(6367,461,08,'Williamsburg.'),(6368,462,01,'Francia'),(6369,462,02,'Ana'),(6370,462,03,'Bellavista'),(6371,462,04,'Boca Río Jiménez'),(6372,462,05,'Catalinas'),(6373,462,06,'Castilla'),(6374,462,07,'Cocal'),(6375,462,08,'Golden  Grove'),(6376,462,09,'Josefina'),(6377,462,10,'Junta'),(6378,462,11,'Laureles'),(6379,462,12,'Luisiana'),(6380,462,13,'Milla 3'),(6381,462,14,'Milla 4'),(6382,462,15,'Milla 5'),(6383,462,16,'Milla 6'),(6384,462,17,'Ontario'),(6385,462,18,'Peje'),(6386,462,19,'Seis Amigos'),(6387,462,20,'Silencio.'),(6388,463,01,'Alto Herediana'),(6389,463,02,'Cruce'),(6390,463,03,'Portón Iberia'),(6391,463,04,'Río Peje'),(6392,463,05,'Vueltas.'),(6393,464,01,'Fields'),(6394,464,02,'Sand Box.'),(6395,464,03,'Altamira'),(6396,464,04,'Akberie (Piedra Grande)'),(6397,464,05,'Bambú'),(6398,464,06,'Chase'),(6399,464,07,'Cuabre'),(6400,464,08,'Gavilán Canta'),(6401,464,09,'Mleyuk 1'),(6402,464,10,'Mleyuk 2'),(6403,464,11,'Monte Sión'),(6404,464,12,'Olivia'),(6405,464,13,'Hu-Berie (Rancho Grande)'),(6406,464,14,'Shiroles'),(6407,464,15,'Sibujú'),(6408,464,16,'Suretka'),(6409,464,17,'Uatsi.'),(6410,465,01,'Ania'),(6411,465,02,'Boca Sixaola'),(6412,465,03,'Catarina'),(6413,465,04,'Celia'),(6414,465,05,'Daytonia'),(6415,465,06,'Gandoca'),(6416,465,07,'Margarita'),(6417,465,08,'Mata de Limón'),(6418,465,09,'Noventa y Seis'),(6419,465,10,'Palma'),(6420,465,11,'Paraíso'),(6421,465,12,'Parque'),(6422,465,13,'San Miguel'),(6423,465,14,'San Miguelito'),(6424,465,15,'San Rafael'),(6425,465,16,'Virginia'),(6426,465,17,'Zavala.'),(6427,466,01,'Buenavista (Katuir)'),(6428,466,02,'Bordón'),(6429,466,03,'Carbón'),(6430,466,04,'Carbón 1'),(6431,466,05,'Carbón 2'),(6432,466,06,'Catarata'),(6433,466,07,'Cocles'),(6434,466,08,'Comadre'),(6435,466,09,'Dindirí'),(6436,466,10,'Gibraltar'),(6437,466,11,'Hone Creek'),(6438,466,12,'Hotel Creek'),(6439,466,13,'Kekoldi'),(6440,466,14,'Limonal'),(6441,466,15,'Manzanillo'),(6442,466,16,'Mile Creek'),(6443,466,17,'Patiño'),(6444,466,18,'Playa Chiquita'),(6445,466,19,'Puerto Viejo'),(6446,466,20,'Punta Caliente'),(6447,466,21,'Punta Cocles'),(6448,466,22,'Punta Mona'),(6449,466,23,'Punta Uva'),(6450,466,24,'Tuba Creek (parte).'),(6451,467,01,'Alto Cuen (Kjacka Bata)'),(6452,467,02,'Alto Lari (Duriñak)'),(6453,467,03,'Alto Urén'),(6454,467,04,'Arenal'),(6455,467,05,'Bajo Blei'),(6456,467,06,'Bajo Cuen'),(6457,467,07,'Boca Urén'),(6458,467,08,'Bris'),(6459,467,09,'Cachabli'),(6460,467,10,'Coroma'),(6461,467,11,'Croriña'),(6462,467,12,'China Kichá'),(6463,467,13,'Dururpe'),(6464,467,14,'Guachalaba'),(6465,467,15,'Katsi'),(6466,467,16,'Kichuguecha'),(6467,467,17,'Kivut'),(6468,467,18,'Mojoncito'),(6469,467,19,'Namuwakir'),(6470,467,20,'Orochico'),(6471,467,21,'Ourut'),(6472,467,22,'Purisquí'),(6473,467,23,'Purita'),(6474,467,24,'Rangalle'),(6475,467,25,'San José Cabecar'),(6476,467,26,'Sepeque'),(6477,467,27,'Shewab'),(6478,467,28,'Sipurio'),(6479,467,29,'Soky'),(6480,467,30,'Sorókicha'),(6481,467,31,'Sukut'),(6482,467,32,'Surayo'),(6483,467,33,'Suiri'),(6484,467,34,'Telire'),(6485,467,35,'Turubokicha'),(6486,467,36,'Urén.'),(6487,468,01,'Goli'),(6488,468,02,'Luisa Oeste'),(6489,468,03,'Milla 23.'),(6490,468,04,'Baltimore'),(6491,468,05,'Barra de Matina Norte'),(6492,468,06,'Bristol'),(6493,468,07,'Colonia Puriscaleña'),(6494,468,08,'Corina'),(6495,468,09,'Chirripó'),(6496,468,10,'Chumico'),(6497,468,11,'Esperanza'),(6498,468,12,'Helvetia'),(6499,468,13,'Hilda'),(6500,468,14,'Línea B'),(6501,468,15,'Milla 4'),(6502,468,16,'Palmeras'),(6503,468,17,'Pozo Azul'),(6504,468,18,'Punta de Lanza'),(6505,468,19,'San Miguel'),(6506,468,20,'Victoria'),(6507,468,21,'Xirinachs.'),(6508,469,01,'Almendros'),(6509,469,02,'Margarita'),(6510,469,03,'Milla 24'),(6511,469,04,'Milla 25'),(6512,469,05,'Parcelas'),(6513,469,06,'Ramal Siete.'),(6514,469,07,'Barbilla'),(6515,469,08,'Berta'),(6516,469,09,'Damasco'),(6517,469,10,'Davao'),(6518,469,11,'Dos Ramas'),(6519,469,12,'Espavel'),(6520,469,13,'Goshen'),(6521,469,14,'Leyte'),(6522,469,15,'Lola'),(6523,469,16,'Luzón'),(6524,469,17,'Milla 27'),(6525,469,18,'Milla 28'),(6526,469,19,'Oracabesa'),(6527,469,20,'Sahara'),(6528,469,21,'Santa Marta'),(6529,469,22,'Titán'),(6530,469,23,'Vegas.'),(6531,470,01,'San José.'),(6532,470,02,'Bananita'),(6533,470,03,'Barra de Matina Sur'),(6534,470,04,'Boca del Pantano'),(6535,470,05,'Boca Río Matina'),(6536,470,06,'Boston'),(6537,470,07,'Brisas'),(6538,470,08,'California'),(6539,470,09,'Indio'),(6540,470,10,'Larga Distancia'),(6541,470,11,'Lomas del Toro'),(6542,470,12,'Luisa Este'),(6543,470,13,'Maravilla'),(6544,470,14,'Milla 14'),(6545,470,15,'Nueva York'),(6546,470,16,'Palacios'),(6547,470,17,'Palestina'),(6548,470,18,'Peje'),(6549,470,19,'Punta de Riel'),(6550,470,20,'Río Cuba'),(6551,470,21,'Río Peje'),(6552,470,22,'Saborío'),(6553,470,23,'San Edmundo'),(6554,470,24,'Santa María'),(6555,470,25,'Sterling'),(6556,470,26,'Strafford'),(6557,470,27,'Toro'),(6558,470,28,'Trinidad'),(6559,470,29,'Venecia'),(6560,470,30,'Zent.'),(6561,471,01,'Africa'),(6562,471,02,'Cantarrana'),(6563,471,03,'Estación Rudín'),(6564,471,04,'Guayacán.'),(6565,471,05,'Aguacate'),(6566,471,06,'Angelina'),(6567,471,07,'Bosque'),(6568,471,08,'Cabaña'),(6569,471,09,'Edén'),(6570,471,10,'El Tres'),(6571,471,11,'Fox Hall'),(6572,471,12,'Guaira'),(6573,471,13,'Hogar'),(6574,471,14,'Parismina'),(6575,471,15,'San Luis'),(6576,471,16,'Selva.'),(6577,472,01,'Bremen'),(6578,472,02,'Argentina'),(6579,472,03,'Confianza'),(6580,472,04,'Iroquois.'),(6581,473,01,'Pocora Sur.'),(6582,473,02,'Ojo de Agua.'),(6583,474,01,'Ángeles'),(6584,474,02,'Bocas del Río Silencio'),(6585,474,03,'Camarón'),(6586,474,04,'Cartagena'),(6587,474,05,'Dulce Nombre'),(6588,474,06,'Escocia'),(6589,474,07,'Irlanda'),(6590,474,08,'Jardín'),(6591,474,09,'Ligia'),(6592,474,10,'Lucha'),(6593,474,11,'Santa María'),(6594,474,12,'Santa Rosa'),(6595,474,13,'Socorro.'),(6596,475,01,'Aguas Gatas'),(6597,475,02,'Carambola'),(6598,475,03,'Castaño'),(6599,475,04,'Esperanza'),(6600,475,05,'Fruta de Pan'),(6601,475,06,'Limbo'),(6602,475,07,'San Cristóbal'),(6603,475,08,'Zancudo.');
/*!40000 ALTER TABLE `barrio` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `bodega` VALUES ('63363882-a840-4517-9786-67f148f6a587','22a80c9e-5639-11e8-8242-54ee75873a11','MALL SAN PEDRO','Tropical Sno Mall San Pedro','Mall San Pedro, 2do nivel','Viviana Ramírez','88255767',NULL),('715da8ec-e431-43e3-9dfc-f77e5c64c296','22a80c9e-5639-11e8-8242-54ee75873a11','TRES RÍOS','Tropical Sno Tres Ríos','San Juan, La Unión','Viviana Ramírez','88255767',NULL),('72a5afa7-dcba-4539-8257-ed1e18b1ce94','22a80c9e-5639-11e8-8242-54ee75873a11','Tropical Sno Central','Oficinas Centrales Tropical Sno','Montelimar','Viviana Ramírez','88255767',NULL),('8f5e581d-206e-4fa1-8f85-9e0a28e77eab','22a80c9e-5639-11e8-8242-54ee75873a12','Agencia Plaza Lincoln','Plaza Lincoln','Moravia','Esteban Carballo','56445252',NULL);
/*!40000 ALTER TABLE `bodega` ENABLE KEYS */;
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
  `idUsuarioSupervisor` char(36) DEFAULT NULL,
  `idUsuarioCajero` char(36) DEFAULT NULL,
  `estado` varchar(45) DEFAULT NULL,
  `montoApertura` varchar(45) DEFAULT NULL,
  `montoCierre` varchar(45) DEFAULT NULL,
  `totalVentasEfectivo` decimal(18,5) DEFAULT NULL,
  `totalVentasTarjeta` decimal(18,5) DEFAULT NULL,
  `fechaApertura` timestamp NULL DEFAULT NULL,
  `fechaCierre` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cajasXBodega`
--

LOCK TABLES `cajasXBodega` WRITE;
/*!40000 ALTER TABLE `cajasXBodega` DISABLE KEYS */;
/*!40000 ALTER TABLE `cajasXBodega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canton`
--

DROP TABLE IF EXISTS `canton`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canton` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idProvincia` int(1) unsigned zerofill NOT NULL,
  `codigo` int(2) unsigned zerofill NOT NULL,
  `canton` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canton`
--

LOCK TABLES `canton` WRITE;
/*!40000 ALTER TABLE `canton` DISABLE KEYS */;
INSERT INTO `canton` VALUES (1,1,01,'San José'),(2,1,02,'Escazú'),(3,1,03,'Desamparados'),(4,1,04,'Puriscal'),(5,1,05,'Tarrazú'),(6,1,06,'Aserrí'),(7,1,07,'Mora'),(8,1,08,'Goicoechea'),(9,1,09,'Santa Ana'),(10,1,10,'Alajuelita'),(11,1,11,'Vásquez de Coronado'),(12,1,12,'Acosta'),(13,1,13,'Tibás'),(14,1,14,'Moravia'),(15,1,15,'Montes de Oca'),(16,1,16,'Turrubares'),(17,1,17,'Dota'),(18,1,18,'Curridabat'),(19,1,19,'Pérez Zeledón'),(20,1,20,'León Cortéz Castro'),(21,2,01,'Alajuela'),(22,2,02,'San Ramón'),(23,2,03,'Grecia'),(24,2,04,'San Mateo'),(25,2,05,'Atenas'),(26,2,06,'Naranjo'),(27,2,07,'Palmares'),(28,2,08,'Poás'),(29,2,09,'Orotina'),(30,2,10,'San Carlos'),(31,2,11,'Zarcero'),(32,2,12,'Valverde Vega'),(33,2,13,'Upala'),(34,2,14,'Los Chiles'),(35,2,15,'Guatuso'),(36,3,01,'Cartago'),(37,3,02,'Paraíso'),(38,3,03,'La Unión'),(39,3,04,'Jiménez'),(40,3,05,'Turrialba'),(41,3,06,'Alvarado'),(42,3,07,'Oreamuno'),(43,3,08,'El Guarco'),(44,4,01,'Heredia'),(45,4,02,'Barva'),(46,4,03,'Santo Domingo'),(47,4,04,'Santa Bárbara'),(48,4,05,'San Rafaél'),(49,4,06,'San Isidro'),(50,4,07,'Belén'),(51,4,08,'Flores'),(52,4,09,'San Pablo'),(53,4,10,'Sarapiquí'),(54,5,01,'Liberia'),(55,5,02,'Nicoya'),(56,5,03,'Santa Cruz'),(57,5,04,'Bagaces'),(58,5,05,'Carrillo'),(59,5,06,'Cañas'),(60,5,07,'Abangáres'),(61,5,08,'Tilarán'),(62,5,09,'Nandayure'),(63,5,10,'La Cruz'),(64,5,11,'Hojancha'),(65,6,01,'Puntarenas'),(66,6,02,'Esparza'),(67,6,03,'Buenos Aires'),(68,6,04,'Montes de Oro'),(69,6,05,'Osa'),(70,6,06,'Aguirre'),(71,6,07,'Golfito'),(72,6,08,'Coto Brus'),(73,6,09,'Parrita'),(74,6,10,'Corredores'),(75,6,11,'Garabito'),(76,7,01,'Limón'),(77,7,02,'Pococí'),(78,7,03,'Siquirres'),(79,7,04,'Talamanca'),(80,7,05,'Matina'),(81,7,06,'Guácimo');
/*!40000 ALTER TABLE `canton` ENABLE KEYS */;
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
INSERT INTO `clienteFE` VALUES ('1f85f425-1c4b-4212-9d97-72e413cffb3c','91239911',506,'Gustavo Reyes',1,'000','Tropical Sno',1,1,1,1,'Guadalupe',1,'',NULL,NULL,'','','','','','0000-00-00 00:00:00',NULL,NULL,NULL,'');
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
INSERT INTO `distribucion` VALUES ('e05f99fc-646e-4893-90fc-c14c2da8690a','2018-09-10 19:30:43',1,'1ed3a48c-3e44-11e8-9ddb-54ee75873a60','715da8ec-e431-43e3-9dfc-f77e5c64c296',0.00,13.00,'1','2018-09-10 19:30:43');
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
-- Table structure for table `distrito`
--

DROP TABLE IF EXISTS `distrito`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `distrito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idCanton` int(11) unsigned zerofill DEFAULT NULL,
  `codigo` int(2) unsigned zerofill DEFAULT NULL,
  `distrito` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=476 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `distrito`
--

LOCK TABLES `distrito` WRITE;
/*!40000 ALTER TABLE `distrito` DISABLE KEYS */;
INSERT INTO `distrito` VALUES (1,00000000001,01,'CARMEN'),(2,00000000001,02,'MERCED'),(3,00000000001,03,'HOSPITAL'),(4,00000000001,04,'CATEDRAL'),(5,00000000001,05,'ZAPOTE'),(6,00000000001,06,'SAN FRANCISCO DE DOS RÍOS'),(7,00000000001,07,'URUCA'),(8,00000000001,08,'MATA REDONDA'),(9,00000000001,09,'PAVAS'),(10,00000000001,10,'HATILLO'),(11,00000000001,11,'SAN SEBASTIÁN'),(12,00000000002,01,'ESCAZÚ'),(13,00000000002,02,'SAN ANTONIO'),(14,00000000002,03,'SAN RAFAEL'),(15,00000000003,01,'DESAMPARADOS'),(16,00000000003,02,'SAN MIGUEL'),(17,00000000003,03,'SAN JUAN DE DIOS'),(18,00000000003,04,'SAN RAFAEL ARRIBA'),(19,00000000003,05,'SAN ANTONIO'),(20,00000000003,06,'FRAILES'),(21,00000000003,07,'PATARRÁ'),(22,00000000003,08,'SAN CRISTÓBAL'),(23,00000000003,09,'ROSARIO'),(24,00000000003,10,'DAMAS'),(25,00000000003,11,'SAN RAFAEL ABAJO'),(26,00000000003,12,'GRAVILIAS'),(27,00000000003,13,'LOS GUIDO'),(28,00000000004,01,'SANTIAGO'),(29,00000000004,02,'MERCEDES SUR'),(30,00000000004,03,'BARBACOAS'),(31,00000000004,04,'GRIFO ALTO'),(32,00000000004,05,'SAN RAFAEL'),(33,00000000004,06,'CANDELARITA'),(34,00000000004,07,'DESAMPARADITOS'),(35,00000000004,08,'SAN ANTONIO'),(36,00000000004,09,'CHIRES'),(37,00000000005,01,'SAN MARCOS'),(38,00000000005,02,'SAN LORENZO'),(39,00000000005,03,'SAN CARLOS'),(40,00000000006,01,'ASERRI'),(41,00000000006,02,'TARBACA'),(42,00000000006,03,'VUELTA DE JORCO'),(43,00000000006,04,'SAN GABRIEL'),(44,00000000006,05,'LEGUA'),(45,00000000006,06,'MONTERREY'),(46,00000000006,07,'SALITRILLOS'),(47,00000000007,01,'COLÓN'),(48,00000000007,02,'GUAYABO'),(49,00000000007,03,'TABARCIA'),(50,00000000007,04,'PIEDRAS NEGRAS'),(51,00000000007,05,'PICAGRES'),(52,00000000007,06,'JARIS'),(53,00000000007,07,'QUITIRRISI'),(54,00000000008,01,'GUADALUPE'),(55,00000000008,02,'SAN FRANCISCO'),(56,00000000008,03,'CALLE BLANCOS'),(57,00000000008,04,'MATA DE PLÁTANO'),(58,00000000008,05,'IPÍS'),(59,00000000008,06,'RANCHO REDONDO'),(60,00000000008,07,'PURRAL'),(61,00000000009,01,'SANTA ANA'),(62,00000000009,02,'SALITRAL'),(63,00000000009,03,'POZOS'),(64,00000000009,04,'URUCA'),(65,00000000009,05,'PIEDADES'),(66,00000000009,06,'BRASIL'),(67,00000000010,01,'ALAJUELITA'),(68,00000000010,02,'SAN JOSECITO'),(69,00000000010,03,'SAN ANTONIO'),(70,00000000010,04,'CONCEPCIÓN'),(71,00000000010,05,'SAN FELIPE'),(72,00000000011,01,'SAN ISIDRO'),(73,00000000011,02,'SAN RAFAEL'),(74,00000000011,03,'DULCE NOMBRE DE JESÚS'),(75,00000000011,04,'PATALILLO'),(76,00000000011,05,'CASCAJAL'),(77,00000000012,01,'SAN IGNACIO'),(78,00000000012,02,'GUAITIL Villa'),(79,00000000012,03,'PALMICHAL'),(80,00000000012,04,'CANGREJAL'),(81,00000000012,05,'SABANILLAS'),(82,00000000013,01,'SAN JUAN'),(83,00000000013,02,'CINCO ESQUINAS'),(84,00000000013,03,'ANSELMO LLORENTE'),(85,00000000013,04,'LEON XIII'),(86,00000000013,05,'COLIMA'),(87,00000000014,01,'SAN VICENTE'),(88,00000000014,02,'SAN JERÓNIMO'),(89,00000000014,03,'LA TRINIDAD'),(90,00000000015,01,'SAN PEDRO'),(91,00000000015,02,'SABANILLA'),(92,00000000015,03,'MERCEDES'),(93,00000000015,04,'SAN RAFAEL'),(94,00000000016,01,'SAN PABLO'),(95,00000000016,02,'SAN PEDRO'),(96,00000000016,03,'SAN JUAN DE MATA'),(97,00000000016,04,'SAN LUIS'),(98,00000000016,05,'CARARA'),(99,00000000017,01,'SANTA MARÍA'),(100,00000000017,02,'JARDÍN'),(101,00000000017,03,'COPEY'),(102,00000000018,01,'CURRIDABAT'),(103,00000000018,02,'GRANADILLA'),(104,00000000018,03,'SÁNCHEZ'),(105,00000000018,04,'TIRRASES'),(106,00000000019,01,'SAN ISIDRO DE EL GENERAL'),(107,00000000019,02,'EL GENERAL'),(108,00000000019,03,'DANIEL FLORES'),(109,00000000019,04,'RIVAS'),(110,00000000019,05,'SAN PEDRO'),(111,00000000019,06,'PLATANARES'),(112,00000000019,07,'PEJIBAYE'),(113,00000000019,08,'CAJÓN'),(114,00000000019,09,'BARÚ'),(115,00000000019,10,'RÍO NUEVO'),(116,00000000019,11,'PÁRAMO'),(117,00000000020,01,'SAN PABLO'),(118,00000000020,02,'SAN ANDRÉS'),(119,00000000020,03,'LLANO BONITO'),(120,00000000020,04,'SAN ISIDRO'),(121,00000000020,05,'SANTA CRUZ'),(122,00000000020,06,'SAN ANTONIO'),(123,00000000021,01,'ALAJUELA'),(124,00000000021,02,'SAN JOSÉ'),(125,00000000021,03,'CARRIZAL'),(126,00000000021,04,'SAN ANTONIO'),(127,00000000021,05,'GUÁCIMA'),(128,00000000021,06,'SAN ISIDRO'),(129,00000000021,07,'SABANILLA'),(130,00000000021,08,'SAN RAFAEL'),(131,00000000021,09,'RÍO SEGUNDO'),(132,00000000021,10,'DESAMPARADOS'),(133,00000000021,11,'TURRÚCARES'),(134,00000000021,12,'TAMBOR'),(135,00000000021,13,'GARITA'),(136,00000000021,14,'SARAPIQUÍ'),(137,00000000022,01,'SAN RAMÓN'),(138,00000000022,02,'SANTIAGO'),(139,00000000022,03,'SAN JUAN'),(140,00000000022,04,'PIEDADES NORTE'),(141,00000000022,05,'PIEDADES SUR'),(142,00000000022,06,'SAN RAFAEL'),(143,00000000022,07,'SAN ISIDRO'),(144,00000000022,08,'ÁNGELES'),(145,00000000022,09,'ALFARO'),(146,00000000022,10,'VOLIO'),(147,00000000022,11,'CONCEPCIÓN'),(148,00000000022,12,'ZAPOTAL'),(149,00000000022,13,'PEÑAS BLANCAS'),(150,00000000023,01,'GRECIA'),(151,00000000023,02,'SAN ISIDRO'),(152,00000000023,03,'SAN JOSÉ'),(153,00000000023,04,'SAN ROQUE'),(154,00000000023,05,'TACARES'),(155,00000000023,06,'RÍO CUARTO'),(156,00000000023,07,'PUENTE DE PIEDRA'),(157,00000000023,08,'BOLÍVAR'),(158,00000000024,01,'SAN MATEO'),(159,00000000024,02,'DESMONTE'),(160,00000000024,03,'JESÚS MARÍA'),(161,00000000024,04,'LABRADOR'),(162,00000000025,01,'ATENAS'),(163,00000000025,02,'JESÚS'),(164,00000000025,03,'MERCEDES'),(165,00000000025,04,'SAN ISIDRO'),(166,00000000025,05,'CONCEPCIÓN'),(167,00000000025,06,'SAN JOSE'),(168,00000000025,07,'SANTA EULALIA'),(169,00000000025,08,'ESCOBAL'),(170,00000000026,01,'NARANJO'),(171,00000000026,02,'SAN MIGUEL'),(172,00000000026,03,'SAN JOSÉ'),(173,00000000026,04,'CIRRÍ SUR'),(174,00000000026,05,'SAN JERÓNIMO'),(175,00000000026,06,'SAN JUAN'),(176,00000000026,07,'EL ROSARIO'),(177,00000000026,08,'PALMITOS'),(178,00000000027,01,'PALMARES'),(179,00000000027,02,'ZARAGOZA'),(180,00000000027,03,'BUENOS AIRES'),(181,00000000027,04,'SANTIAGO'),(182,00000000027,05,'CANDELARIA'),(183,00000000027,06,'ESQUÍPULAS'),(184,00000000027,07,'LA GRANJA'),(185,00000000028,01,'SAN PEDRO'),(186,00000000028,02,'SAN JUAN'),(187,00000000028,03,'SAN RAFAEL'),(188,00000000028,04,'CARRILLOS'),(189,00000000028,05,'SABANA REDONDA'),(190,00000000029,01,'OROTINA'),(191,00000000029,02,'EL MASTATE'),(192,00000000029,03,'HACIENDA VIEJA'),(193,00000000029,04,'COYOLAR'),(194,00000000029,05,'LA CEIBA'),(195,00000000030,01,'QUESADA'),(196,00000000030,02,'FLORENCIA'),(197,00000000030,03,'BUENAVISTA'),(198,00000000030,04,'AGUAS ZARCAS'),(199,00000000030,05,'VENECIA'),(200,00000000030,06,'PITAL'),(201,00000000030,07,'LA FORTUNA'),(202,00000000030,08,'LA TIGRA'),(203,00000000030,09,'LA PALMERA'),(204,00000000030,10,'VENADO'),(205,00000000030,11,'CUTRIS'),(206,00000000030,12,'MONTERREY'),(207,00000000030,13,'POCOSOL'),(208,00000000031,01,'ZARCERO'),(209,00000000031,02,'LAGUNA'),(210,00000000031,04,'GUADALUPE'),(211,00000000031,05,'PALMIRA'),(212,00000000031,06,'ZAPOTE'),(213,00000000031,07,'BRISAS'),(214,00000000032,01,'SARCHÍ NORTE'),(215,00000000032,02,'SARCHÍ SUR'),(216,00000000032,03,'TORO AMARILLO'),(217,00000000032,04,'SAN PEDRO'),(218,00000000032,05,'RODRÍGUEZ'),(219,00000000033,01,'UPALA'),(220,00000000033,02,'AGUAS CLARAS'),(221,00000000033,03,'SAN JOSÉ o PIZOTE'),(222,00000000033,04,'BIJAGUA'),(223,00000000033,05,'DELICIAS'),(224,00000000033,06,'DOS RÍOS'),(225,00000000033,07,'YOLILLAL'),(226,00000000033,08,'CANALETE'),(227,00000000034,01,'LOS CHILES'),(228,00000000034,02,'CAÑO NEGRO'),(229,00000000034,03,'EL AMPARO'),(230,00000000034,04,'SAN JORGE'),(231,00000000035,02,'BUENAVISTA'),(232,00000000035,03,'COTE'),(233,00000000035,04,'KATIRA'),(234,00000000036,01,'ORIENTAL'),(235,00000000036,02,'OCCIDENTAL'),(236,00000000036,03,'CARMEN'),(237,00000000036,04,'SAN NICOLÁS'),(238,00000000036,05,'AGUACALIENTE o SAN FRANCISCO'),(239,00000000036,06,'GUADALUPE o ARENILLA'),(240,00000000036,07,'CORRALILLO'),(241,00000000036,08,'TIERRA BLANCA'),(242,00000000036,09,'DULCE NOMBRE'),(243,00000000036,10,'LLANO GRANDE'),(244,00000000036,11,'QUEBRADILLA'),(245,00000000037,01,'PARAÍSO'),(246,00000000037,02,'SANTIAGO'),(247,00000000037,03,'OROSI'),(248,00000000037,04,'CACHÍ'),(249,00000000037,05,'LLANOS DE SANTA LUCÍA'),(250,00000000038,01,'TRES RÍOS'),(251,00000000038,02,'SAN DIEGO'),(252,00000000038,03,'SAN JUAN'),(253,00000000038,04,'SAN RAFAEL'),(254,00000000038,05,'CONCEPCIÓN'),(255,00000000038,06,'DULCE NOMBRE'),(256,00000000038,07,'SAN RAMÓN'),(257,00000000038,08,'RÍO AZUL'),(258,00000000039,01,'JUAN VIÑAS'),(259,00000000039,02,'TUCURRIQUE'),(260,00000000039,03,'PEJIBAYE'),(261,00000000040,01,'TURRIALBA'),(262,00000000040,02,'LA SUIZA'),(263,00000000040,03,'PERALTA'),(264,00000000040,04,'SANTA CRUZ'),(265,00000000040,05,'SANTA TERESITA'),(266,00000000040,06,'PAVONES'),(267,00000000040,07,'TUIS'),(268,00000000040,08,'TAYUTIC'),(269,00000000040,09,'SANTA ROSA'),(270,00000000040,10,'TRES EQUIS'),(271,00000000040,11,'LA ISABEL'),(272,00000000040,12,'CHIRRIPÓ'),(273,00000000041,01,'PACAYAS'),(274,00000000041,02,'CERVANTES'),(275,00000000041,03,'CAPELLADES'),(276,00000000042,01,'SAN RAFAEL'),(277,00000000042,02,'COT'),(278,00000000042,03,'POTRERO CERRADO'),(279,00000000042,04,'CIPRESES'),(280,00000000042,05,'SANTA ROSA'),(281,00000000043,01,'EL TEJAR'),(282,00000000043,02,'SAN ISIDRO'),(283,00000000043,03,'TOBOSI'),(284,00000000043,04,'PATIO DE AGUA'),(285,00000000044,01,'HEREDIA'),(286,00000000044,02,'MERCEDES'),(287,00000000044,03,'SAN FRANCISCO'),(288,00000000044,04,'ULLOA'),(289,00000000044,05,'VARABLANCA'),(290,00000000045,01,'BARVA'),(291,00000000045,02,'SAN PEDRO'),(292,00000000045,03,'SAN PABLO'),(293,00000000045,04,'SAN ROQUE'),(294,00000000045,05,'SANTA LUCÍA'),(295,00000000045,06,'SAN JOSÉ DE LA MONTAÑA'),(296,00000000046,02,'SAN VICENTE'),(297,00000000046,03,'SAN MIGUEL'),(298,00000000046,04,'PARACITO'),(299,00000000046,05,'SANTO TOMÁS'),(300,00000000046,06,'SANTA ROSA'),(301,00000000046,07,'TURES'),(302,00000000046,08,'PARÁ'),(303,00000000047,01,'SANTA BÁRBARA'),(304,00000000047,02,'SAN PEDRO'),(305,00000000047,03,'SAN JUAN'),(306,00000000047,04,'JESÚS'),(307,00000000047,05,'SANTO DOMINGO'),(308,00000000047,06,'PURABÁ'),(309,00000000048,01,'SAN RAFAEL'),(310,00000000048,02,'SAN JOSECITO'),(311,00000000048,03,'SANTIAGO'),(312,00000000048,04,'ÁNGELES'),(313,00000000048,05,'CONCEPCIÓN'),(314,00000000049,01,'SAN ISIDRO'),(315,00000000049,02,'SAN JOSÉ'),(316,00000000049,03,'CONCEPCIÓN'),(317,00000000049,04,'SAN FRANCISCO'),(318,00000000050,01,'SAN ANTONIO'),(319,00000000050,02,'LA RIBERA'),(320,00000000050,03,'LA ASUNCIÓN'),(321,00000000051,01,'SAN JOAQUÍN'),(322,00000000051,02,'BARRANTES'),(323,00000000051,03,'LLORENTE'),(324,00000000052,01,'SAN PABLO'),(325,00000000053,01,'PUERTO VIEJO'),(326,00000000053,02,'LA VIRGEN'),(327,00000000053,03,'LAS HORQUETAS'),(328,00000000053,04,'LLANURAS DEL GASPAR'),(329,00000000053,05,'CUREÑA'),(330,00000000054,01,'LIBERIA'),(331,00000000054,02,'CAÑAS DULCES'),(332,00000000054,03,'MAYORGA'),(333,00000000054,04,'NACASCOLO'),(334,00000000054,05,'CURUBANDÉ'),(335,00000000055,01,'NICOYA'),(336,00000000055,02,'MANSIÓN'),(337,00000000055,03,'SAN ANTONIO'),(338,00000000055,04,'QUEBRADA HONDA'),(339,00000000055,05,'SÁMARA'),(340,00000000055,06,'NOSARA'),(341,00000000055,07,'BELÉN DE NOSARITA'),(342,00000000056,01,'SANTA CRUZ'),(343,00000000056,02,'BOLSÓN'),(344,00000000056,03,'VEINTISIETE DE ABRIL'),(345,00000000056,04,'TEMPATE'),(346,00000000056,05,'CARTAGENA'),(347,00000000056,06,'CUAJINIQUIL'),(348,00000000056,07,'DIRIÁ'),(349,00000000056,08,'CABO VELAS'),(350,00000000056,09,'TAMARINDO'),(351,00000000057,01,'BAGACES'),(352,00000000057,02,'LA FORTUNA'),(353,00000000057,03,'MOGOTE'),(354,00000000057,04,'RÍO NARANJO'),(355,00000000058,01,'FILADELFIA'),(356,00000000058,02,'PALMIRA'),(357,00000000058,03,'SARDINAL'),(358,00000000058,04,'BELÉN'),(359,00000000059,01,'CAÑAS'),(360,00000000059,02,'PALMIRA'),(361,00000000059,03,'SAN MIGUEL'),(362,00000000059,04,'BEBEDERO'),(363,00000000059,05,'POROZAL'),(364,00000000060,01,'LAS JUNTAS'),(365,00000000060,02,'SIERRA'),(366,00000000060,03,'SAN JUAN'),(367,00000000060,04,'COLORADO'),(368,00000000061,01,'TILARÁN'),(369,00000000061,02,'QUEBRADA GRANDE'),(370,00000000061,03,'TRONADORA'),(371,00000000061,04,'SANTA ROSA'),(372,00000000061,05,'LÍBANO'),(373,00000000061,06,'TIERRAS MORENAS'),(374,00000000061,07,'ARENAL'),(375,00000000062,01,'CARMONA'),(376,00000000062,02,'SANTA RITA'),(377,00000000062,03,'ZAPOTAL'),(378,00000000062,04,'SAN PABLO'),(379,00000000062,05,'PORVENIR'),(380,00000000062,06,'BEJUCO'),(381,00000000063,01,'LA CRUZ'),(382,00000000063,02,'SANTA CECILIA'),(383,00000000063,03,'LA GARITA'),(384,00000000063,04,'SANTA ELENA'),(385,00000000064,01,'HOJANCHA'),(386,00000000064,02,'MONTE ROMO'),(387,00000000064,03,'PUERTO CARRILLO'),(388,00000000064,04,'HUACAS'),(389,00000000065,01,'PUNTARENAS'),(390,00000000065,02,'PITAHAYA'),(391,00000000065,03,'CHOMES'),(392,00000000065,04,'LEPANTO'),(393,00000000065,05,'PAQUERA'),(394,00000000065,06,'MANZANILLO'),(395,00000000065,07,'GUACIMAL'),(396,00000000065,08,'BARRANCA'),(397,00000000065,09,'MONTE VERDE'),(398,00000000065,11,'CÓBANO'),(399,00000000065,12,'CHACARITA'),(400,00000000065,13,'CHIRA'),(401,00000000065,14,'ACAPULCO'),(402,00000000065,15,'EL ROBLE'),(403,00000000065,16,'ARANCIBIA'),(404,00000000066,01,'ESPÍRITU SANTO'),(405,00000000066,02,'SAN JUAN GRANDE'),(406,00000000066,03,'MACACONA'),(407,00000000066,04,'SAN RAFAEL'),(408,00000000066,05,'SAN JERÓNIMO'),(409,00000000066,06,'CALDERA'),(410,00000000067,01,'BUENOS AIRES'),(411,00000000067,02,'VOLCÁN'),(412,00000000067,03,'POTRERO GRANDE'),(413,00000000067,04,'BORUCA'),(414,00000000067,05,'PILAS'),(415,00000000067,06,'COLINAS'),(416,00000000067,07,'CHÁNGUENA'),(417,00000000067,08,'BIOLLEY'),(418,00000000067,09,'BRUNKA'),(419,00000000068,01,'MIRAMAR'),(420,00000000068,02,'LA UNIÓN'),(421,00000000068,03,'SAN ISIDRO'),(422,00000000069,01,'PUERTO CORTÉS'),(423,00000000069,02,'PALMAR'),(424,00000000069,03,'SIERPE'),(425,00000000069,04,'BAHÍA BALLENA'),(426,00000000069,05,'PIEDRAS BLANCAS'),(427,00000000069,06,'BAHÍA DRAKE'),(428,00000000070,01,'QUEPOS'),(429,00000000070,02,'SAVEGRE'),(430,00000000070,03,'NARANJITO'),(431,00000000071,01,'GOLFITO'),(432,00000000071,02,'PUERTO JIMÉNEZ'),(433,00000000071,03,'GUAYCARÁ'),(434,00000000071,04,'PAVÓN'),(435,00000000072,01,'SAN VITO'),(436,00000000072,02,'SABALITO'),(437,00000000072,03,'AGUABUENA'),(438,00000000072,04,'LIMONCITO'),(439,00000000072,05,'PITTIER'),(440,00000000072,06,'GUTIERREZ BRAUN'),(441,00000000073,01,'PARRITA'),(442,00000000074,01,'CORREDOR'),(443,00000000074,02,'LA CUESTA'),(444,00000000074,03,'CANOAS'),(445,00000000074,04,'LAUREL'),(446,00000000075,01,'JACÓ'),(447,00000000075,02,'TÁRCOLES'),(448,00000000076,01,'LIMÓN'),(449,00000000076,02,'VALLE LA ESTRELLA'),(450,00000000076,04,'MATAMA'),(451,00000000077,01,'GUÁPILES'),(452,00000000077,02,'JIMÉNEZ'),(453,00000000077,03,'RITA'),(454,00000000077,04,'ROXANA'),(455,00000000077,05,'CARIARI'),(456,00000000077,06,'COLORADO'),(457,00000000077,07,'LA COLONIA'),(458,00000000078,01,'SIQUIRRES'),(459,00000000078,02,'PACUARITO'),(460,00000000078,03,'FLORIDA'),(461,00000000078,04,'GERMANIA'),(462,00000000078,05,'EL CAIRO'),(463,00000000078,06,'ALEGRÍA'),(464,00000000079,01,'BRATSI'),(465,00000000079,02,'SIXAOLA'),(466,00000000079,03,'CAHUITA'),(467,00000000079,04,'TELIRE'),(468,00000000080,01,'MATINA'),(469,00000000080,02,'BATÁN'),(470,00000000080,03,'CARRANDI'),(471,00000000081,01,'GUÁCIMO'),(472,00000000081,02,'MERCEDES'),(473,00000000081,03,'POCORA'),(474,00000000081,04,'RÍO JIMÉNEZ'),(475,00000000081,05,'DUACARÍ');
/*!40000 ALTER TABLE `distrito` ENABLE KEYS */;
UNLOCK TABLES;

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
INSERT INTO `evento` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','Dashboard','Dashboard.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','Nuevo Producto Terminado','Producto.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','Inventario de Producto Terminado','InventarioProducto.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','Facturacion Agencia','FacturaCli.html','Facturacion',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','Lista de Facturas','InventarioFactura.html','Facturacion',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','Nuevo Usuario','Usuario.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','Lista de Usuarios','InventarioUsuario.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','Nuevo Rol','Rol.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','Lista de Roles','InventarioRol.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','Nueva Materia Prima','Insumo.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','Inventario de Materia Prima','InventarioInsumo.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','Elaborar Producto Terminado','ElaborarProducto.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','Nueva Agencia','Bodega.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','Lista de Agencias','InventarioBodega.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','Traslados y Facturacion','Distribucion.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','Entradas de Insumos','OrdenCompra.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','Orden de Produccion','OrdenSalida.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','Inventario Orden de Produccion','InventarioOrdenSalida.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','Ingreso Bodega de Agencia','AceptarDistribucion.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','Agregar Ip','ip.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','Lista de IP','InventarioIp.html','Sistema',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','Determinacion de Precios Tropical Sno','DeterminacionPrecio.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','Determinacion de Precios Agencia','DeterminacionPrecioVenta.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','Inventario por Agencia','InsumosBodega.html','Inventario',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','Despacho','Fabricar.html','Facturacion',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a96','Ver Traslados y Facturación','InventarioDistribucion.html','Agencia',NULL,NULL),('1ed3a48c-3e44-11e8-9ddb-54ee75873a97','Facturacion Electrónica','clienteFE.html','Sistema',NULL,'fa fa-cog'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a98','Gestion de Cajas','Caja.html','Facturacion',NULL,'fa fa-money');
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
INSERT INTO `eventosXRol` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a69','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a70','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a71','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','5f9bd173-9369-47d5-a1b8-fe5ab8234c61'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a72','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','5f9bd173-9369-47d5-a1b8-fe5ab8234c61'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a73','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a74','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a75','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a76','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a77','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a78','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a79','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a82','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a83','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a85','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a86','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a87','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a88','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a89','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a90','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','0f8aef81-7400-4a36-93f9-b929d4889d0e'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a91','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a92','7f9f8011-f9db-4330-b931-552141a089a4'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a93','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a94','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','31221f87-1b60-48d1-a0ce-68457d1298c1'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a95','e8d2f620-dd38-4e21-8b7f-7949412f65d6'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a96','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a97','1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a98','1ed3a48c-3e44-11e8-9ddb-54ee75873a80');
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
INSERT INTO `insumosXBodega` VALUES ('0225cf3e-b530-11e8-8061-0800279cc012','7b1ead74-a64d-11e8-b258-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296',20,0.00000,0.00000),('022acc55-b530-11e8-8061-0800279cc012','a4b0b267-a64c-11e8-b258-0800279cc012','715da8ec-e431-43e3-9dfc-f77e5c64c296',20,0.00000,0.00000);
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
INSERT INTO `ipAutorizada` VALUES ('10.129.29.185','2018-07-27 14:05:48'),('10.129.29.198','2018-07-28 05:20:58'),('10.129.29.217','2018-07-07 16:13:54'),('10.129.29.48','2018-07-16 04:25:49'),('10.129.29.64','2018-07-17 05:47:45'),('10.129.29.85','2018-07-12 20:45:58'),('10.129.6.21','2018-07-25 01:56:20'),('10.129.6.30','2018-09-06 16:01:16'),('10.129.6.48','2018-07-16 04:26:21'),('10.129.6.59','2018-07-12 20:47:01'),('10.129.6.73','2018-07-08 01:10:49'),('10.129.6.85','2018-08-01 22:33:37'),('10.3.164.16','2018-09-10 18:18:34'),('10.3.164.216','2018-09-10 18:24:25'),('10.34.164.23','2018-08-16 16:30:00'),('10.34.164.24','2018-07-05 19:50:17'),('10.34.165.15','2018-07-05 20:08:03'),('10.34.165.20','2018-09-04 00:45:36'),('10.42.0.23','2018-08-30 22:41:27'),('168.81.162.245','2018-08-14 15:00:52'),('172.20.10.5','2018-08-04 00:16:02'),('192.168.0.100','2018-07-17 17:18:00'),('192.168.0.101','2018-08-03 23:04:10'),('192.168.0.102','2018-08-15 18:37:12'),('192.168.0.120','2018-08-14 15:02:07'),('192.168.0.121','2018-07-07 00:27:25'),('192.168.0.13','2018-08-21 01:25:47'),('192.168.0.14','2018-07-14 01:50:22'),('192.168.0.20','2018-07-20 16:22:22'),('192.168.0.21','2018-08-03 07:46:05'),('192.168.0.25','2018-08-03 09:37:39'),('192.168.1.100','2018-08-21 16:44:39'),('192.168.1.105','2018-08-16 16:30:00'),('192.168.1.11','2018-08-11 00:15:44'),('192.168.1.123','2018-07-07 00:36:27'),('192.168.1.155','2018-07-07 00:37:20'),('192.168.1.18','2018-07-07 23:28:50'),('192.168.1.5','2018-07-30 02:58:54'),('192.168.1.7','2018-07-07 00:27:25'),('192.168.1.8','2018-07-07 23:28:50'),('192.168.1.81','2018-07-14 18:22:32'),('192.168.10.101','2018-08-16 18:38:17'),('192.168.10.102','2018-08-16 18:38:24'),('192.168.10.20','2018-08-14 15:00:03'),('192.168.10.21','2018-08-14 15:00:13'),('192.168.43.235','2018-07-08 01:10:49'),('192.168.43.4','2018-07-20 21:35:54');
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
INSERT INTO `producto` VALUES ('002c4bf1-a64d-11e8-b258-0800279cc012','SIR-REDRA','SIROPE DE FRAMBUESA ROJA','#080708','#e36c9e','RERA','BOTELLA DE SIROPE DE FRAMBUESA ROJA 750 ML',0,0.00000,0.00000,0.00000,1),('03156aa0-a64c-11e8-b258-0800279cc012','SIR-BLUER','SIROPE DE FRAMBUESA AZUL','#fff9f9','#1325c7','BLUR','BOTELLA DE SIROPE DE FRAMBUESA AZUL 750 ML',0,0.00000,0.00000,0.00000,1),('07903351-a62e-11e8-b258-0800279cc012','MS-SI100E','RASPADORA DE HIELO','#000000','#ffffff','RASP','SWAN SI-100 RASPADORA DE HIELO EN BLOQUE (115 VOLT)',3,3054420.03000,1018140.01000,0.00000,0),('0a7ce055-a58d-11e8-b258-0800279cc012','CP-FHGLOVES-L','GUANTES TALLA L','','','GUAL','GUANTES PLÁSTICOS MANIPULADORES DE ALIMENTOS TALLA L',2000,14000.00000,7.00000,0.00000,0),('0cdf88ba-a62f-11e8-b258-0800279cc012','CP-NAPKINS','SERVILLETAS','','','SERV','SERVILLETAS CON LOGO IMPRESO',24000,221520.00000,9.23000,0.00000,0),('0d36c8db-a58e-11e8-b258-0800279cc012','AP-P-CPO-21','LÁMINA TRANSLÚCIDA PEQUEÑA','','','LAMP','LÁMINA PLÁSTICA TRANSLÚCIDA PROTECTORA PARA PÓSTER PEQUEÑA (21X33 PULGADAS)',2,15747.82000,7873.91000,0.00000,0),('0da5e444-a62a-11e8-b258-0800279cc012','AC-ICEPAIL','CUBOS PARA HIELO','#000000','#ffffff','CUBS','CUBOS PLASTICOS PARA FABRICAR HIELO',144,214345.44000,1488.51000,0.00000,0),('103cd805-a64d-11e8-b258-0800279cc012','SIR-ROOTB','SIROPE DE ZARZA','#faf4f4','#804821','ROOT','BOTELLA DE SIROPE DE ZARZA 750 ML',0,0.00000,0.00000,0.00000,1),('130612f5-a64c-11e8-b258-0800279cc012','SIR-BUBBL','SIROPE DE CHICLE','#59c4db','#2348c9','BUBB','BOTELLA DE SIROPE DE CHICLE 750 ML',0,0.00000,0.00000,0.00000,1),('1c01164d-a62f-11e8-b258-0800279cc012','CP-SPOONS-C1','CUCHARAS','','','CUCR','CUCHARAS PLÁSTICAS',23848,629587.20000,26.40000,0.00000,0),('1ffe07bf-a58e-11e8-b258-0800279cc012','CL-APRON-FBL','DELANTAL PLÁSTICO','','','DELA','DELANTAL PLÁSTICO COMPLETO',8,58791.84000,7348.98000,0.00000,0),('205d81ff-a64d-11e8-b258-0800279cc012','SIR-STRAW','SIROPE DE FRESA','#0a0a0a','#d94065','STRW','BOTELLA DE SIROPE DE FRESA 750 ML',0,0.00000,0.00000,0.00000,1),('20d7dfd1-a64c-11e8-b258-0800279cc012','SIR-COCON','SIROPE DE COCO','#0d0c0c','#f6f7cc','COCO','BOTELLA DE SIROPE DE COCO 750 ML',0,0.00000,0.00000,0.00000,1),('22ce212a-a62e-11e8-b258-0800279cc012','P-100-12','CUCHILLAS','','','CUCH','CUCHILLAS (SI-100E, SI-150E, SI-200E, SI-38)',10,178621.10000,17862.11000,0.00000,0),('2a2a3a5f-a58a-11e8-b258-0800279cc012','P-FOOT-LA','CONTROL DE PIE','','','PIE','CAJA DE CONTROLADOR DE PIE, PEDAL Y MANGUERA',3,68895.00000,22965.00000,0.00000,0),('3150ac55-a62f-11e8-b258-0800279cc012','AP-P-WCS-28','MOLDURA PARA PÓSTER 4 PATAS','','','MOL4','MOLDURA PARA PÓSTER (WINDMASTER) CON PATAS (28X44 PULGADAS)',1,113734.22000,113734.22000,0.00000,0),('318d41d8-a64c-11e8-b258-0800279cc012','SIR-COLA','SIROPE DE COLA','#f7efef','#f74e29','COLA','BOTELLA DE SIROPE DE COLA 750 ML',0,0.00000,0.00000,0.00000,1),('318efd1b-a58e-11e8-b258-0800279cc012','CL-HAT-OTTO','GORRA MESH','','','MESH','GORRA MESH CON LOGO',8,46660.16000,5832.52000,0.00000,0),('3ab03f8d-a64d-11e8-b258-0800279cc012','SIR-VANIL','SIROPE DE VAINILLA','#0f0e0e','#dec9c9','VANI','BOTELLA DE SIROPE DE VAINILLA 750 ML',0,0.00000,0.00000,0.00000,1),('409bd3ad-a58b-11e8-b258-0800279cc012','AC-QBTREE','ÁRBOL SECADOR PARA BOTELLAS','','','TREE','ÁRBOL SECADOR PARA BOTELLAS',1,22965.56000,22965.56000,0.00000,0),('417029a9-a58d-11e8-b258-0800279cc012','AP-P-OPF-21','MOLDURA PARA PÓSTER PEQUEÑA','','','MOLP','MOLDURA PARA PÓSTER EXTERIORES PEQUEÑA (21X33 PULGADAS)',2,93320.38000,46660.19000,0.00000,0),('4393476b-a62e-11e8-b258-0800279cc012','AC-QB-TS-17','BOTELLAS MARCA TROPICAL SNO','','','BOTL','BOTELLAS PLÁSTICAS  CON LA MARCA TROPICAL SNO (INCLUYE ETIQUETAS Y TAPAS)',168,171475.92000,1020.69000,0.00000,0),('467a2aa7-a62f-11e8-b258-0800279cc012','AP-P-OPF-28','MOLDURA PARA PÓSTER GRANDE','','','MOLG','MOLDURA PARA PÓSTER EXTERIORES GRANDE (28 X 44 PULGADAS)',2,110817.96000,55408.98000,0.00000,0),('49acc603-a64d-11e8-b258-0800279cc012','SIR-VERCH','SIROPE DE MUY CEREZA','#faf1f1','#8a1c23','VECH','BOTELLA DE SIROPE DE MUY CEREZA 750 ML',0,0.00000,0.00000,0.00000,1),('4bbe7eff-a64c-11e8-b258-0800279cc012','SIR-COTTO','SIROPE DE ALGODÓN DE AZÚCAR','#0d0c0c','#ca91d4','COTT','BOTELLA DE SIROPE DE ALGODÓN DE AZÚCAR 750 ML',0,0.00000,0.00000,0.00000,1),('4c65ebb3-a58e-11e8-b258-0800279cc012','CL-TM-BL-LG','CAMISETA CUELLO AZUL L','','','CAZL','CAMISETA PARA HOMBRE, CUELLO AZUL, TALLA L',2,13414.80000,6707.40000,0.00000,0),('4eea04f4-a58b-11e8-b258-0800279cc012','AC-ICECHIP','CARGADOR DE HIELO','','','CARG','CARGADOR DE HIELO',2,12248.30000,6124.15000,0.00000,0),('58a4d4af-a64d-11e8-b258-0800279cc012','SIR-WATER','SIROPE DE SANDÍA','#fff4f4','#b3617a','WMEL','BOTELLA DE SIROPE DE SANDÍA 750 ML',0,0.00000,0.00000,0.00000,1),('5dd13d02-a64c-11e8-b258-0800279cc012','SIR-FRESH','SIROPE DE LIMA FRESCA','#0d0c0c','#17ed46','FRSH','BOTELLA DE SIROPE DE LIMA FRESCA 750 ML',0,0.00000,0.00000,0.00000,1),('5e7d3cd0-a62e-11e8-b258-0800279cc012','AC-RACK-DLX','EXHIBIDOR PARA BOTELLAS','','','RACK','RACK PLÁSTICO EXHIBIDOR DE LUJO PARA BOTELLAS (PARA 12 UNIDADES)',4,244966.00000,61241.50000,0.00000,0),('62b8fea9-a58e-11e8-b258-0800279cc012','CL-TM-BL-ME','CAMISETA CUELLO AZUL M','','','CAZM','CAMISETA PARA HOMBRE, CUELLO AZUL, TALLA M',2,13414.80000,6707.40000,0.00000,0),('67b239ae-a58b-11e8-b258-0800279cc012','AC-QTSQUEEZE','BOTELLA MEZCLADORA','','','B-ME','BOTELLA MEZCLADORA PARA TOPPINGS',0,0.00000,1275.86000,0.00000,0),('6c395541-a64c-11e8-b258-0800279cc012','SIR-GRAPE','SIROPE DE UVA','#f7eaea','#6d2d94','GRAP','BOTELLA DE SIROPE DE UVA 750 ML',0,0.00000,0.00000,0.00000,1),('6d4eaa4e-a64d-11e8-b258-0800279cc012','SIR-GUAVA','SIROPE DE GUAYABA','#0a0a0a','#f79955','GUAV','BOTELLA DE SIROPE DE GUAYABA 750 ML',0,0.00000,0.00000,0.00000,1),('76638b19-a58d-11e8-b258-0800279cc012','AP-BANNER17-TS','BANDERA TROPICAL SNO','','','FLAG','BANDERA TROPICAL SNO 2017',2,69990.30000,34995.15000,2500.00000,0),('779381ea-a58a-11e8-b258-0800279cc012','AC-QSPOUTS','TAPAS VERTEDORAS (AZULES)','','','T-AZU','TAPAS VERTEDORAS DE LIQUIDO (AZULES)',60,15310.20000,255.17000,0.00000,0),('79605c96-a58e-11e8-b258-0800279cc012','CL-TM-BL-SM','CAMISETA CUELLO AZUL S','','','CAZS','CAMISETA PARA HOMBRE, CUELLO AZUL, TALLA S',2,13414.80000,6707.40000,0.00000,0),('7b1ead74-a64d-11e8-b258-0800279cc012','SIR-PASSI','SIROPE DE MARACUYÁ','#0a0a0a','#e0d8ac','PASS','BOTELLA DE SIROPE DE MARACUYÁ 750 ML',-2,0.00000,0.00000,0.00000,1),('7b6a94ac-a64c-11e8-b258-0800279cc012','SIR-GREEN','SIROPE DE MANZANA VERDE','#0a0a0a','#77fa74','GREE','BOTELLA DE SIROPE DE MANZANA VERDE 750 ML',0,0.00000,0.00000,0.00000,1),('89cd9b84-a64c-11e8-b258-0800279cc012','SIR-LEMON','SIROPE DE LIMÓN','#080707','#21a61f','LEMO','BOTELLA DE SIROPE DE LIMÓN 750 ML',0,0.00000,0.00000,0.00000,1),('8fc42890-a62e-11e8-b258-0800279cc012','AC-QTCRATE','CAJAS TRASNPORTADORAS','','','CTRA','CAJAS PLÁSTICAS TRANSPORTADORAS DE BOTELLAS (PARA 12 UNIDADES)',10,122483.00000,12248.30000,0.00000,0),('945818b4-a58e-11e8-b258-0800279cc012','CL-TM-HG-LG','CAMISETA GRIS L','','','CGRL','CAMISETA DE HOMBRE, CUELLO GRIS, TALLA L',2,13414.80000,6707.40000,0.00000,0),('97a7dcda-a64c-11e8-b258-0800279cc012','SIR-MANGO','SIROPE DE MANGO','#0d0d0d','#eb9f45','MANG','BOTELLA DE SIROPE DE MANGO 750 ML',0,0.00000,0.00000,0.00000,1),('9bc3c191-a58a-11e8-b258-0800279cc012','AC-QSPOUTCAPS','TAPAS VERTEDORAS (NARANJA)','','','T-NAR','TAPAS  DE PLÁSTICO PARA TAPAR LAS VERTEDORAS DE LIQUIDO (NARANJA)',60,7655.40000,127.59000,0.00000,0),('9c6e039f-a638-11e8-b258-0800279cc012','CP-SPILLS-12','VASO ANTI-DERRAME 12OZ','#000000','#ffffff','AT12','VASOS ANTI-DERRAME, PLÁSTICO AZUL, 12 ONZAS',5990,664470.70000,110.93000,0.00000,0),('a040d8d4-a58d-11e8-b258-0800279cc012','AP-P15-SET-28','PÓSTER GRANDE','','','POSG','PÓSTER GRANDE (28X44 PULGADAS) ',10,29162.60000,2916.26000,0.00000,0),('a17c90c5-a58e-11e8-b258-0800279cc012','CL-TM-HG-ME','CAMISETA GRIS M','','','CGRM','CAMISETA DE HOMBRE, CUELLO GRIS, TALLA M',2,13414.80000,6707.40000,0.00000,0),('a4b0b267-a64c-11e8-b258-0800279cc012','SIR-ORANGE','SIROPE DE NARANJA','#0a0a0a','#fa9601','ORAN','BOTELLA DE SIROPE DE NARANJA 750 ML',-2,0.00000,0.00000,0.00000,1),('a7cc750c-a62e-11e8-b258-0800279cc012','CP-CUPTS-08','VASOS DE 8OZ','','','V8OZ','VASOS DE ESTEREOFÓN CON LOGO TROPICAL SNO 8OZ',13997,326410.04000,23.32000,0.00000,0),('b298fd5c-a64b-11e8-b258-0800279cc012','SIR-BANAN','SIROPE DE BANANO','#000000','#eaf5a5','BANA','BOTELLA DE SIROPE DE BANANO 750 ML',0,0.00000,1458.13000,2500.00000,1),('b58ecc55-a58e-11e8-b258-0800279cc012','CL-TM-HG-SM','CAMISETA GRIS S','','','CGRS','CAMISETA DE HOMBRE, CUELLO GRIS, TALLA S ',2,13414.80000,6707.40000,0.00000,0),('b8d5372b-a62e-11e8-b258-0800279cc012','CP-CUPTS-16','VASOS DE 12OZ','','','V12O','VASOS DE ESTEREOFÓN CON LOGO TROPICAL SNO 12OZ',6000,174960.00000,29.16000,0.00000,0),('b948f654-a636-11e8-b258-0800279cc012','CP-SPILLS-08','VASO ANTI-DERRAME 8OZ','#000000','#ffffff','ANT8','VASOS ANTI-DERRAME, PLÁSTICO VERDE, 8 ONZAS',14032,1551518.24000,110.57000,0.00000,0),('be639949-a58d-11e8-b258-0800279cc012','AP-P15-SET-21','PÓSTER PEQUEÑO','','','POSP','PÓSTER PEQUEÑO (21X33 PULGADAS) ',10,29162.60000,2916.26000,0.00000,0),('c585ac10-a64b-11e8-b258-0800279cc012','SIR-BLACK','SIROPE DE CEREZA NEGRA','#f7f4f4','#661111','blak','BOTELLA DE SIROPE DE CEREZA NEGRA 750 ML',10,14581.30000,1458.13000,0.00000,1),('cb2f62a6-a64c-11e8-b258-0800279cc012','SIR-PEACH','SIROPE DE MELOCOTÓN','#0a0a0a','#ebc285','PECH','BOTELLA DE SIROPE DE MELOCOTÓN 750 ML',0,0.00000,0.00000,0.00000,1),('d8ddbbf4-a64b-11e8-b258-0800279cc012','SIR-BLUEB','SIROPE DE ARÁNDANO','#fffbfb','#23128f','BLUB','BOTELLA DE SIROPE DE ARÁNDANO 750 ML',0,0.00000,0.00000,0.00000,1),('ded11f42-a64c-11e8-b258-0800279cc012','SIR-PINAC','SIROPE DE PIÑA COLADA','#0f0f0f','#e3db90','PINC','BOTELLA DE SIROPE DE PIÑA COLADA 750 ML',0,0.00000,0.00000,0.00000,1),('e4833657-a58e-11e8-b258-0800279cc012','CL-TM-RR-TS-LG','CAMISETA ROYAL L','','','ROYL','CAMISETA PARA HOMBRE, ROYAL RINGER, TROPICAL SNO, TALLA L',2,13414.80000,6707.40000,0.00000,0),('e6539ab5-a58d-11e8-b258-0800279cc012','AP-P-CPO-28','LÁMINA TRANSLÚCIDA GRANDE','','','LAMG','LÁMINA PLÁSTICA TRANSLÚCIDA PROTECTORA PARA PÓSTER GRANDE (28*44 PULGADAS)',4,40827.68000,10206.92000,0.00000,0),('e6a2c172-b2b5-11e8-8061-0800279cc012','CC-COCO','COCO','#f8fcfc','#7a2e2e','coco','Topping de COCO',50,0.00000,0.00000,0.00000,2),('eca0acc2-a64b-11e8-b258-0800279cc012','SIR-BLUEH','SIROPE DE HAWAIANO AZUL','#74f5f5','#3b6ca6','BLUH','BOTELLA DE SIROPE DE HAWAIANO AZUL 750 ML',0,0.00000,0.00000,0.00000,1),('ecd762a7-a58c-11e8-b258-0800279cc012','CP-FHGLOVES-M','GUANTES TALLA M','','','GUAM','GUANTES PLÁSTICOS MANIPULADORES DE ALIMENTOS TALLA M',2000,14000.00000,7.00000,0.00000,0),('ef3fcb6a-a64c-11e8-b258-0800279cc012','SIR-PINEA','SIROPE DE PIÑA','#0f0f0f','#e6f074','PINE','BOTELLA DE SIROPE DE PIÑA 750 ML',0,0.00000,0.00000,0.00000,1),('f1aeee28-a58e-11e8-b258-0800279cc012','CL-TM-RR-TS-ME','CAMISETA ROYAL M','','','ROYM','CAMISETA PARA HOMBRE, ROYAL RINGER, TROPICAL SNO, TALLA M',2,13414.80000,6707.40000,0.00000,0),('fc0acd5f-a58a-11e8-b258-0800279cc012','AC-MIXJUGS','GALONES MEZCLADORES','','','MEZC','GALONES PLÁSTICOS MEZCLADORES CON SUS TAPAS',40,76552.00000,1913.80000,0.00000,0),('fe1e806b-a58e-11e8-b258-0800279cc012','CL-TM-RR-TS-SM','CAMISETA ROYAL S','','','ROYS','CAMISETA PARA HOMBRE, ROYAL RINGER, TROPICAL SNO, TALLA S',2,13414.80000,6707.40000,0.00000,0);
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
INSERT INTO `productosXDistribucion` VALUES ('0206051b-b530-11e8-8061-0800279cc012','e05f99fc-646e-4893-90fc-c14c2da8690a','7b1ead74-a64d-11e8-b258-0800279cc012',2,0.00000),('020fe40d-b530-11e8-8061-0800279cc012','e05f99fc-646e-4893-90fc-c14c2da8690a','a4b0b267-a64c-11e8-b258-0800279cc012',2,0.00000);
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
INSERT INTO `rolesXUsuario` VALUES ('1ed3a48c-3e44-11e8-9ddb-54ee75873a80','1ed3a48c-3e44-11e8-9ddb-54ee75873a60'),('31221f87-1b60-48d1-a0ce-68457d1298c1','9d27aedd-992d-475a-a01b-09b1c2aa2714'),('5f9bd173-9369-47d5-a1b8-fe5ab8234c61','756f31d0-fdbb-40c5-8fe9-0e1dfbef7db3'),('e8d2f620-dd38-4e21-8b7f-7949412f65d6','1e03b970-2778-43fb-aff6-444043d2bf51'),('e8d2f620-dd38-4e21-8b7f-7949412f65d6','291a7a1c-17a4-4062-8a70-3b9db409113a'),('e8d2f620-dd38-4e21-8b7f-7949412f65d6','f874513a-3fc2-4fc7-b48e-46cb96af4901'),('e8d2f620-dd38-4e21-8b7f-7949412f65d6','fd9d2be6-6999-40ce-9954-1462c9ca0ffb');
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
INSERT INTO `usuario` VALUES ('1e03b970-2778-43fb-aff6-444043d2bf51','Olga Arias','Vendedor 1','$2y$10$sKLZBY4EO5BzBrWeUm0sQOEADIzuviIUwY17LAP8x3KqDMgm9py/a','',1),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','administrador de sistema','admin','$2y$10$CwVlbwIWdHbxlQqo3yJHj.zo7BRekPGM.NCIjn02fIc0f7uz9gpua','',1),('291a7a1c-17a4-4062-8a70-3b9db409113a','Viviana Ramirez','Viviana','$2y$10$T97UtIZFneCNUS9VkosBr.RvKHhOb/C2LomBHnPBZODQig3JC3Xj.','',1),('756f31d0-fdbb-40c5-8fe9-0e1dfbef7db3','Wayne Rooney','Rooney','$2y$10$gskJ/mg9gMZgHu2GPczufO0K01y9YgxRL3i3JgCil1axynETYgo2e','',1),('9d27aedd-992d-475a-a01b-09b1c2aa2714','Despacho San Pedro','DespachoSP','$2y$10$eOzcp6F611LXGf4a2YcNBu5MiY3lUSda1yqxpS5A2kcPfzu4moTF2','',1),('f874513a-3fc2-4fc7-b48e-46cb96af4901','Prueba Despacho','Despacho1','$2y$10$7jCKUBwL7XPSrnXBR1B6oeZJEjfVGshXXGj/IuuiYNarGjIVqFd42','',1),('fd9d2be6-6999-40ce-9954-1462c9ca0ffb','Margarita Gutierrez','Bodeguero','$2y$10$WmGBZz2UEYPOYIWefTW4N.Y7M0E2S9zvvN0pbDMvBm6FKv4gn/LqS','',1);
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
INSERT INTO `usuariosXBodega` VALUES ('1e03b970-2778-43fb-aff6-444043d2bf51','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','63363882-a840-4517-9786-67f148f6a587'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','72a5afa7-dcba-4539-8257-ed1e18b1ce94'),('1ed3a48c-3e44-11e8-9ddb-54ee75873a60','8f5e581d-206e-4fa1-8f85-9e0a28e77eab'),('291a7a1c-17a4-4062-8a70-3b9db409113a','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('756f31d0-fdbb-40c5-8fe9-0e1dfbef7db3','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('9d27aedd-992d-475a-a01b-09b1c2aa2714','63363882-a840-4517-9786-67f148f6a587'),('f874513a-3fc2-4fc7-b48e-46cb96af4901','715da8ec-e431-43e3-9dfc-f77e5c64c296'),('fd9d2be6-6999-40ce-9954-1462c9ca0ffb','72a5afa7-dcba-4539-8257-ed1e18b1ce94');
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

-- Dump completed on 2018-09-10 14:34:01

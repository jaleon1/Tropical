#
# TABLE STRUCTURE FOR: tipo_identificacion
#

DROP TABLE IF EXISTS `tipo_identificacion`;

CREATE TABLE `tipo_identificacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `tipo` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

INSERT INTO `tipo_identificacion` (`id`, `codigo`, `tipo`) VALUES ('1', '01', 'Cédula física');
INSERT INTO `tipo_identificacion` (`id`, `codigo`, `tipo`) VALUES ('2', '02', 'Cédula jurídica');
INSERT INTO `tipo_identificacion` (`id`, `codigo`, `tipo`) VALUES ('3', '03', 'DIMEX');
INSERT INTO `tipo_identificacion` (`id`, `codigo`, `tipo`) VALUES ('4', '04', 'NITE');



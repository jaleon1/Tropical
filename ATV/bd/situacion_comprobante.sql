#
# TABLE STRUCTURE FOR: situacion comprobante
#

DROP TABLE IF EXISTS `situacion_comprobante`;

CREATE TABLE `situacion_comprobante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `situacion_comprobante` (`id`, `codigo`, `descripcion`) VALUES ('1', '1', 'Normal');
INSERT INTO `situacion_comprobante` (`id`, `codigo`, `descripcion`) VALUES ('2', '2', 'Contingencia');
INSERT INTO `situacion_comprobante` (`id`, `codigo`, `descripcion`) VALUES ('3', '3', 'Sin Internet');
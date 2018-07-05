#
# TABLE STRUCTURE FOR: estado comprobante
#

DROP TABLE IF EXISTS `estado_comprobante`;

CREATE TABLE `estado_comprobante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `estado_comprobante` (`id`, `codigo`, `descripcion`) VALUES ('1', '01', 'Sin enviar');
INSERT INTO `estado_comprobante` (`id`, `codigo`, `descripcion`) VALUES ('2', '02', 'Enviado');
INSERT INTO `estado_comprobante` (`id`, `codigo`, `descripcion`) VALUES ('3', '03', 'Aceptado');
INSERT INTO `estado_comprobante` (`id`, `codigo`, `descripcion`) VALUES ('4', '04', 'Rechazado');
INSERT INTO `estado_comprobante` (`id`, `codigo`, `descripcion`) VALUES ('5', '99', 'Otros');
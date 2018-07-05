#
# TABLE STRUCTURE FOR: condicion_venta
#

DROP TABLE IF EXISTS `condicion_venta`;

CREATE TABLE `condicion_venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `condicionVenta` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

INSERT INTO `condicion_venta` (`id`, `codigo`, `condicionVenta`) VALUES ('1', '01', 'Contado');
INSERT INTO `condicion_venta` (`id`, `codigo`, `condicionVenta`) VALUES ('2', '02', 'Crédito');
INSERT INTO `condicion_venta` (`id`, `codigo`, `condicionVenta`) VALUES ('3', '03', 'Consignación');
INSERT INTO `condicion_venta` (`id`, `codigo`, `condicionVenta`) VALUES ('4', '04', 'Apartado');
INSERT INTO `condicion_venta` (`id`, `codigo`, `condicionVenta`) VALUES ('5', '05', 'Arrendamiento con opción de compra');
INSERT INTO `condicion_venta` (`id`, `codigo`, `condicionVenta`) VALUES ('6', '06', 'Arrendamiento en función financiera');
INSERT INTO `condicion_venta` (`id`, `codigo`, `condicionVenta`) VALUES ('7', '99', 'Otro');



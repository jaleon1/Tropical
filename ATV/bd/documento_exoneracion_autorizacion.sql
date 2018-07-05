#
# TABLE STRUCTURE FOR: documento_exoneracion_autorizacion
#

DROP TABLE IF EXISTS `documento_exoneracion_autorizacion`;

CREATE TABLE `documento_exoneracion_autorizacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `documento` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

INSERT INTO `documento_exoneracion_autorizacion` (`id`, `codigo`, `documento`) VALUES ('1', '01', 'Compras autorizadas');
INSERT INTO `documento_exoneracion_autorizacion` (`id`, `codigo`, `documento`) VALUES ('2', '02', 'Ventas exentas a diplomáticos');
INSERT INTO `documento_exoneracion_autorizacion` (`id`, `codigo`, `documento`) VALUES ('3', '03', 'Orden de compra (Instituciones públicas y otros organismos)');
INSERT INTO `documento_exoneracion_autorizacion` (`id`, `codigo`, `documento`) VALUES ('4', '04', 'Exenciones Dirección General de Hacienda');
INSERT INTO `documento_exoneracion_autorizacion` (`id`, `codigo`, `documento`) VALUES ('5', '05', 'Zonas Francas');
INSERT INTO `documento_exoneracion_autorizacion` (`id`, `codigo`, `documento`) VALUES ('6', '99', 'Otro');



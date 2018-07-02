#
# TABLE STRUCTURE FOR: codigo
#

DROP TABLE IF EXISTS `tipo_codigo`;

CREATE TABLE `tipo_codigo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

INSERT INTO `tipo_codigo` (`id`, `codigo`, `descripcion`) VALUES ('1', '01', 'Código del producto del vendedor');
INSERT INTO `tipo_codigo` (`id`, `codigo`, `descripcion`) VALUES ('2', '02', 'Código del producto del comprador ');
INSERT INTO `tipo_codigo` (`id`, `codigo`, `descripcion`) VALUES ('3', '03', 'código del producto asignado por la industria ');
INSERT INTO `tipo_codigo` (`id`, `codigo`, `descripcion`) VALUES ('4', '04', 'código de uso interno ');
INSERT INTO `tipo_codigo` (`id`, `codigo`, `descripcion`) VALUES ('5', '99', 'Otros');
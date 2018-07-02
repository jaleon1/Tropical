#
# TABLE STRUCTURE FOR: impuesto
#

DROP TABLE IF EXISTS `impuesto`;

CREATE TABLE `impuesto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `tipo` int(1) DEFAULT NULL COMMENT '1: Impuesto 2: Excepciones',
  `valor` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('1', '01', 'Impuesto General sobre las Ventas', '1', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('2', '02', 'Impuesto Selectivo de Consumo', '1', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('3', '03', 'Impuesto Único a los combustibles', '1', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('4', '04', 'Impuesto específico de Bebidas Alcohólicas', '1', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('5', '05', 'Impuesto Específico sobre las bebidas envasadas sin contenido alcohólico y jabones de tocador', '1', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('6', '06', 'Impuesto a los Productos de Tabaco', '1', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('7', '07', 'Servicio', '1', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('8', '12', 'Impuesto Específico al Cemento', '1', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('9', '98', 'Otros', '1', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('10', '08', 'Impuesto General sobre las Ventas Diplomáticas', '2', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('11', '09', 'Impuesto General sobre las Ventas Compras Autorizadas', '2', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('12', '10', 'Impuesto General sobre las Ventas Instituciones Públicas y otros Organismos', '2', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('13', '11', 'Impuesto Selectivo de Consumo Compras Autorizadas', '2', NULL);
INSERT INTO `impuesto` (`id`, `codigo`, `descripcion`, `tipo`, `valor`) VALUES ('14', '99', 'Otros', '2', NULL);



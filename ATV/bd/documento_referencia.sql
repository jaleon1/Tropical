#
# TABLE STRUCTURE FOR: documento_referencia
#

DROP TABLE IF EXISTS `documento_referencia`;

CREATE TABLE `documento_referencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `documento` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

INSERT INTO `documento_referencia` (`id`, `codigo`, `documento`) VALUES ('1', '01', 'Factura Electrónica');
INSERT INTO `documento_referencia` (`id`, `codigo`, `documento`) VALUES ('2', '02', 'Nota de débito electrónica');
INSERT INTO `documento_referencia` (`id`, `codigo`, `documento`) VALUES ('3', '03', 'Nota de crédito electrónica');
INSERT INTO `documento_referencia` (`id`, `codigo`, `documento`) VALUES ('4', '04', 'Tiquete electrónico');
INSERT INTO `documento_referencia` (`id`, `codigo`, `documento`) VALUES ('5', '05', 'Nota de despacho');
INSERT INTO `documento_referencia` (`id`, `codigo`, `documento`) VALUES ('6', '06', 'Contrato');
INSERT INTO `documento_referencia` (`id`, `codigo`, `documento`) VALUES ('7', '07', 'Procedimiento');
INSERT INTO `documento_referencia` (`id`, `codigo`, `documento`) VALUES ('8', '08', 'Comprobante emitido en contingencia');
INSERT INTO `documento_referencia` (`id`, `codigo`, `documento`) VALUES ('9', '99', 'Otro');



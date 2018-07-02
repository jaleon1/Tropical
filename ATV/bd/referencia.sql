#
# TABLE STRUCTURE FOR: referencia
#

DROP TABLE IF EXISTS `referencia`;

CREATE TABLE `referencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `referencia` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

INSERT INTO `referencia` (`id`, `codigo`, `referencia`) VALUES ('1', '01', 'Anula Documento de Referencia');
INSERT INTO `referencia` (`id`, `codigo`, `referencia`) VALUES ('2', '02', 'Corrige texto documento de referencia');
INSERT INTO `referencia` (`id`, `codigo`, `referencia`) VALUES ('3', '03', 'Corrige monto');
INSERT INTO `referencia` (`id`, `codigo`, `referencia`) VALUES ('4', '04', 'Referencia a otro documento');
INSERT INTO `referencia` (`id`, `codigo`, `referencia`) VALUES ('5', '05', 'Sustituye comprobante provisional por contingencia');
INSERT INTO `referencia` (`id`, `codigo`, `referencia`) VALUES ('6', '99', 'Otros');



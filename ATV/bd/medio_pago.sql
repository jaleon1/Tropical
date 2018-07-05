#
# TABLE STRUCTURE FOR: medio_pago
#

DROP TABLE IF EXISTS `medio_pago`;

CREATE TABLE `medio_pago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(2) DEFAULT NULL,
  `medioPago` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

INSERT INTO `medio_pago` (`id`, `codigo`, `medioPago`) VALUES ('1', '01', 'Efectivo');
INSERT INTO `medio_pago` (`id`, `codigo`, `medioPago`) VALUES ('2', '02', 'Tarjeta');
INSERT INTO `medio_pago` (`id`, `codigo`, `medioPago`) VALUES ('3', '03', 'Cheque');
INSERT INTO `medio_pago` (`id`, `codigo`, `medioPago`) VALUES ('4', '04', 'Transferencia - depósito bancario');
INSERT INTO `medio_pago` (`id`, `codigo`, `medioPago`) VALUES ('5', '05', 'Recaudo por terceros');
INSERT INTO `medio_pago` (`id`, `codigo`, `medioPago`) VALUES ('6', '99', 'Otro');



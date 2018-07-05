#
# TABLE STRUCTURE FOR: unidad_medida
#

DROP TABLE IF EXISTS `unidad_medida`;

CREATE TABLE `unidad_medida` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `simbolo` varchar(10) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=88 DEFAULT CHARSET=latin1;

INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('1', 'Sp', 'Servicios Profesionales');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('2', 'm', 'Metro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('3', 'kg', 'Kilogramo');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('4', 's', 'Segundo');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('5', 'A', 'Ampere');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('6', 'K', 'Kelvin');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('7', 'mol', 'Mol');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('8', 'cd', 'Candela');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('9', 'm²', 'metro cuadrado');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('10', 'm³', 'metro cúbico');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('11', 'm/s', 'metro por segundo');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('12', 'm/s²', 'metro por segundo cuadrado');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('13', '1/m', '1 por metro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('14', 'kg/m³', 'kilogramo por metro cúbico');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('15', 'A/m²', 'ampere por metro cuadrado');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('16', 'A/m', 'ampere por metro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('17', 'mol/m³', 'mol por metro cúbico');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('18', 'cd/m²', 'candela por metro cuadrado');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('19', '1', 'uno (indice de refracción)');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('20', 'rad', 'radián');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('21', 'sr', 'estereorradián');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('22', 'Hz', 'hertz');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('23', 'N', 'newton');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('24', 'Pa', 'pascal');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('25', 'J', 'Joule');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('26', 'W', 'Watt');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('27', 'C', 'coulomb');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('28', 'V', 'volt');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('29', 'F', 'farad');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('30', 'Ohm', 'ohm');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('31', 'S', 'siemens');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('32', 'Wb', 'weber');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('33', 'T', 'tesla');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('34', 'H', 'henry');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('35', '°C', 'grado Celsius');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('36', 'lm', 'lumen');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('37', 'lx', 'lux');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('38', 'Bq', 'Becquerel');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('39', 'Gy', 'gray');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('40', 'Sv', 'sievert');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('41', 'kat', 'katal');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('42', 'Pa·s', 'pascal segundo');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('43', 'N·m', 'newton metro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('44', 'N/m', 'newton por metro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('45', 'rad/s', 'radián por segundo');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('46', 'rad/s²', 'radián por segundo cuadrado');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('47', 'W/m²', 'watt por metro cuadrado');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('48', 'J/K', 'joule por kelvin');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('49', 'J/(kg·K)', 'joule por kilogramo kelvin');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('50', 'J/kg', 'joule por kilogramo');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('51', 'W/(m·K)', 'watt por metro kevin');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('52', 'J/m³', 'joule por metro cúbico');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('53', 'V/m', 'volt por metro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('54', 'C/m³', 'coulomb por metro cúbico');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('55', 'C/m²', 'coulomb por metro cuadrado');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('56', 'F/m', 'farad por metro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('57', 'H/m', 'henry por metro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('58', 'J/mol', 'joule por mol');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('59', 'J/(mol·K)', 'joule por mol kelvin');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('60', 'C/kg', 'coulomb por kilogramo');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('61', 'Gy/s', 'gray por segundo');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('62', 'W/sr', 'watt por estereorradián');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('63', 'W/(m²·sr)', 'watt por metro cuadrado estereorradián');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('64', 'kat/m³', 'katal por metro cúbico');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('65', 'min', 'minuto');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('66', 'h', 'hora');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('67', 'd', 'día');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('68', 'º', 'grado');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('69', '´', 'minuto');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('70', '´´', 'segundo');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('71', 'L', 'litro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('72', 't', 'tonelada');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('73', 'Np', 'neper');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('74', 'B', 'bel');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('75', 'eV', 'electronvolt');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('76', 'u', 'unidad de masa atómica unificada');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('77', 'ua', 'unidad astronómica');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('78', 'Unid', 'Unidad');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('79', 'Gal', 'Galón');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('80', 'g', 'Gramo');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('81', 'Km', 'Kilometro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('82', 'ln', 'pulgada');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('83', 'cm', 'centímetro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('84', 'mL', 'mililitro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('85', 'mm', 'Milímetro');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('86', 'Oz', 'Onzas');
INSERT INTO `unidad_medida` (`id`, `simbolo`, `descripcion`) VALUES ('87', 'Otros', 'Se debe indicar la descripción de la medida a utilizar');



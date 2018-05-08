-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-05-2018 a las 09:39:17
-- Versión del servidor: 10.1.31-MariaDB
-- Versión de PHP: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tropical`
--
CREATE DATABASE IF NOT EXISTS `tropical` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `tropical`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bodega`
--

CREATE TABLE `bodega` (
  `id` char(36) NOT NULL,
  `idtipobodega` char(36) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `condicion`
--

CREATE TABLE `condicion` (
  `id` char(36) NOT NULL,
  `nombre` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `condicionxinsumo`
--

CREATE TABLE `condicionxinsumo` (
  `idcondicion` char(36) NOT NULL,
  `idinsumo` char(36) NOT NULL,
  `cantidad` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `id` char(36) NOT NULL,
  `nombre` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evento`
--

CREATE TABLE `evento` (
  `id` char(36) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `url` varchar(400) NOT NULL,
  `menupadre` varchar(100) DEFAULT 'home',
  `submenupare` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `evento`
--

INSERT INTO `evento` (`id`, `nombre`, `url`, `menupadre`, `submenupare`) VALUES
('1ed3a48c-3e44-11e8-9ddb-54ee75873a69', 'Dashboard', 'Dashboard.html', 'home', NULL),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a70', 'Producto', 'Producto.html', 'home', NULL),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a71', 'Inventario', 'Inventario.html', 'home', NULL),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a72', 'Factura', 'Facturacion.html', 'home', NULL),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a73', 'xx', 'xx.html', 'home', NULL),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a74', 'Nuevo Usuario', 'Usuario.html', 'home', NULL),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a75', 'Inventario de Usuarios', 'InventarioUsuario.html', 'home', NULL),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a76', 'Nuevo Rol', 'Rol.html', 'home', NULL),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a77', 'Inventario de Roles', 'InventarioRol.html', 'home', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventosxrol`
--

CREATE TABLE `eventosxrol` (
  `idevento` char(36) NOT NULL,
  `idrol` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `eventosxrol`
--

INSERT INTO `eventosxrol` (`idevento`, `idrol`) VALUES
('1ed3a48c-3e44-11e8-9ddb-54ee75873a69', '1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a70', '1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a71', '1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a72', '1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a73', '1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a74', '1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a75', '1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a76', '1ed3a48c-3e44-11e8-9ddb-54ee75873a80'),
('1ed3a48c-3e44-11e8-9ddb-54ee75873a77', '1ed3a48c-3e44-11e8-9ddb-54ee75873a80');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumo`
--

CREATE TABLE `insumo` (
  `id` char(36) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `bueno` int(6) NOT NULL,
  `danado` int(6) NOT NULL,
  `costo` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `insumo`
--

INSERT INTO `insumo` (`id`, `codigo`, `nombre`, `bueno`, `danado`, `costo`) VALUES
('b71d4294-50da-11e8-94cb-2c768add56de', 'hhh01', 'HHH', 410, 10, '120.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `insumoxproducto`
--

CREATE TABLE `insumoxproducto` (
  `id` char(36) NOT NULL,
  `idinsumo` char(36) NOT NULL,
  `idproductotemporal` char(36) NOT NULL,
  `cantidad` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id` char(36) NOT NULL,
  `codigo` varchar(20) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `cantidad` int(6) NOT NULL,
  `precio` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id`, `codigo`, `nombre`, `cantidad`, `precio`) VALUES
('21f9a794-50dd-11e8-94cb-2c768add56de', 'huhuhuhu', 'huhuhuhu', 1000, '200.00'),
('454206c3-5017-11e8-82f0-2c768add56de', 'iiii0111', 'JLKLJL001', 100, '10.00'),
('63c40f8d-5017-11e8-82f0-2c768add56de', 'xxxx0001', 'xxxxxxx', 120, '12.00'),
('9283b1dc-5017-11e8-82f0-2c768add56de', '11000', 'oiio001', 100, '10.00'),
('96cd7ec5-5017-11e8-82f0-2c768add56de', 'jklkl', 'jkj', 1221, '12.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productotemporal`
--

CREATE TABLE `productotemporal` (
  `id` char(36) NOT NULL,
  `idproducto` char(36) NOT NULL,
  `idusuario` char(36) NOT NULL,
  `cantidad` int(6) NOT NULL,
  `estado` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productoxbodega`
--

CREATE TABLE `productoxbodega` (
  `id` char(36) NOT NULL,
  `idbodega` char(36) NOT NULL,
  `idproducto` char(36) NOT NULL,
  `cantidad` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productoxestado`
--

CREATE TABLE `productoxestado` (
  `idproducto` char(36) NOT NULL,
  `idestado` char(36) NOT NULL,
  `cantidad` int(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id` char(36) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id`, `nombre`, `descripcion`) VALUES
('1ed3a48c-3e44-11e8-9ddb-54ee75873a80', 'Admin', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rolesxusuario`
--

CREATE TABLE `rolesxusuario` (
  `idrol` char(36) NOT NULL,
  `idusuario` char(36) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `rolesxusuario`
--

INSERT INTO `rolesxusuario` (`idrol`, `idusuario`) VALUES
('1ed3a48c-3e44-11e8-9ddb-54ee75873a80', '1ed3a48c-3e44-11e8-9ddb-54ee75873a60');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipobodega`
--

CREATE TABLE `tipobodega` (
  `id` char(36) NOT NULL,
  `nombre` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` char(36) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `username`, `password`, `email`, `activo`) VALUES
('1ed3a48c-3e44-11e8-9ddb-54ee75873a60', 'administrador de sistema', 'admin', '$2y$10$CwVlbwIWdHbxlQqo3yJHj.zo7BRekPGM.NCIjn02fIc0f7uz9gpua', NULL, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bodega`
--
ALTER TABLE `bodega`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idtipobodega` (`idtipobodega`);

--
-- Indices de la tabla `condicion`
--
ALTER TABLE `condicion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `evento`
--
ALTER TABLE `evento`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `eventosxrol`
--
ALTER TABLE `eventosxrol`
  ADD PRIMARY KEY (`idevento`,`idrol`),
  ADD KEY `rol_idx` (`idrol`);

--
-- Indices de la tabla `insumo`
--
ALTER TABLE `insumo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `insumoxproducto`
--
ALTER TABLE `insumoxproducto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idinsumo` (`idinsumo`),
  ADD KEY `fk_idproducto` (`idproductotemporal`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productotemporal`
--
ALTER TABLE `productotemporal`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idinsumoxproducto` (`idproducto`);

--
-- Indices de la tabla `productoxbodega`
--
ALTER TABLE `productoxbodega`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_idbodega` (`idbodega`) USING BTREE,
  ADD KEY `fk_idproducto` (`idproducto`) USING BTREE;

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `rolesxusuario`
--
ALTER TABLE `rolesxusuario`
  ADD PRIMARY KEY (`idrol`,`idusuario`),
  ADD KEY `usuario_idx` (`idusuario`);

--
-- Indices de la tabla `tipobodega`
--
ALTER TABLE `tipobodega`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `bodega`
--
ALTER TABLE `bodega`
  ADD CONSTRAINT `bodega_ibfk_1` FOREIGN KEY (`idtipobodega`) REFERENCES `tipobodega` (`id`);

--
-- Filtros para la tabla `eventosxrol`
--
ALTER TABLE `eventosxrol`
  ADD CONSTRAINT `evento` FOREIGN KEY (`idevento`) REFERENCES `evento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `rol` FOREIGN KEY (`idrol`) REFERENCES `rol` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `insumoxproducto`
--
ALTER TABLE `insumoxproducto`
  ADD CONSTRAINT `insumoxproducto_ibfk_1` FOREIGN KEY (`idinsumo`) REFERENCES `insumo` (`id`),
  ADD CONSTRAINT `insumoxproducto_ibfk_2` FOREIGN KEY (`idproductotemporal`) REFERENCES `productotemporal` (`id`);

--
-- Filtros para la tabla `productotemporal`
--
ALTER TABLE `productotemporal`
  ADD CONSTRAINT `productotemporal_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`id`);

--
-- Filtros para la tabla `productoxbodega`
--
ALTER TABLE `productoxbodega`
  ADD CONSTRAINT `productoxbodega_ibfk_1` FOREIGN KEY (`idproducto`) REFERENCES `producto` (`id`),
  ADD CONSTRAINT `productoxbodega_ibfk_2` FOREIGN KEY (`idbodega`) REFERENCES `bodega` (`id`);

--
-- Filtros para la tabla `rolesxusuario`
--
ALTER TABLE `rolesxusuario`
  ADD CONSTRAINT `rol_usuario` FOREIGN KEY (`idrol`) REFERENCES `rol` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usuario_usuario` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

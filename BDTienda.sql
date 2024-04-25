-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.28-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para dbtienda
DROP DATABASE IF EXISTS `dbtienda`;
CREATE DATABASE IF NOT EXISTS `dbtienda` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `dbtienda`;

-- Volcando estructura para tabla dbtienda.tbcliente
DROP TABLE IF EXISTS `tbcliente`;
CREATE TABLE IF NOT EXISTS `tbcliente` (
  `dni` varchar(8) NOT NULL,
  `nombres` varchar(50) DEFAULT NULL,
  `apellidos` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`dni`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla dbtienda.tbcliente: ~2 rows (aproximadamente)
INSERT INTO `tbcliente` (`dni`, `nombres`, `apellidos`) VALUES
	('1241124', 'Carlos Miguel', 'Torres Lopez'),
	('44444444', 'Santiago Jesus', 'Caceres Contreras');

-- Volcando estructura para tabla dbtienda.tbcompra
DROP TABLE IF EXISTS `tbcompra`;
CREATE TABLE IF NOT EXISTS `tbcompra` (
  `idcompra` int(11) NOT NULL AUTO_INCREMENT,
  `idproveedor` varchar(6) NOT NULL,
  `dniempleado` varchar(8) NOT NULL,
  `fechacompra` date DEFAULT NULL,
  `horacompra` time DEFAULT NULL,
  `totalcomnpra` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idcompra`),
  KEY `FK_tbcompra_tbproveedor` (`idproveedor`),
  KEY `FK_tbcompra_tbempleado` (`dniempleado`),
  CONSTRAINT `FK_tbcompra_tbempleado` FOREIGN KEY (`dniempleado`) REFERENCES `tbempleado` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_tbcompra_tbproveedor` FOREIGN KEY (`idproveedor`) REFERENCES `tbproveedor` (`idproveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla dbtienda.tbcompra: ~2 rows (aproximadamente)
INSERT INTO `tbcompra` (`idcompra`, `idproveedor`, `dniempleado`, `fechacompra`, `horacompra`, `totalcomnpra`) VALUES
	(1, 'PVE001', '11111111', '2023-10-11', '00:25:58', 49999.00),
	(2, 'PVE002', '11111111', '2023-10-11', '00:32:02', 34000.00);

-- Volcando estructura para tabla dbtienda.tbdetallecompra
DROP TABLE IF EXISTS `tbdetallecompra`;
CREATE TABLE IF NOT EXISTS `tbdetallecompra` (
  `iddetallecompra` int(11) NOT NULL,
  `idcompra` int(11) NOT NULL,
  `idproducto` varchar(6) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `preciounitario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`iddetallecompra`),
  KEY `FK_tbdetallecompra_tbcompra` (`idcompra`),
  KEY `FK_tbdetallecompra_tbproducto` (`idproducto`),
  CONSTRAINT `FK_tbdetallecompra_tbcompra` FOREIGN KEY (`idcompra`) REFERENCES `tbcompra` (`idcompra`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_tbdetallecompra_tbproducto` FOREIGN KEY (`idproducto`) REFERENCES `tbproducto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla dbtienda.tbdetallecompra: ~2 rows (aproximadamente)
INSERT INTO `tbdetallecompra` (`iddetallecompra`, `idcompra`, `idproducto`, `cantidad`, `preciounitario`) VALUES
	(1, 1, 'PRO001', 20, 2499.95),
	(2, 2, 'PRO002', 20, 1700.00);

-- Volcando estructura para tabla dbtienda.tbdetalleventa
DROP TABLE IF EXISTS `tbdetalleventa`;
CREATE TABLE IF NOT EXISTS `tbdetalleventa` (
  `iddetalle` int(11) NOT NULL AUTO_INCREMENT,
  `idventa` int(11) DEFAULT NULL,
  `idproducto` varchar(6) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `preciounitario` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`iddetalle`),
  KEY `FK_tbdetalleventa_tbventa` (`idventa`),
  KEY `FK_tbdetalleventa_tbproducto` (`idproducto`),
  CONSTRAINT `FK_tbdetalleventa_tbproducto` FOREIGN KEY (`idproducto`) REFERENCES `tbproducto` (`idproducto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_tbdetalleventa_tbventa` FOREIGN KEY (`idventa`) REFERENCES `tbventa` (`IdVenta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla dbtienda.tbdetalleventa: ~1 rows (aproximadamente)
INSERT INTO `tbdetalleventa` (`iddetalle`, `idventa`, `idproducto`, `cantidad`, `preciounitario`) VALUES
	(1, 1, 'PRO001', 2, 3500.00);

-- Volcando estructura para tabla dbtienda.tbempleado
DROP TABLE IF EXISTS `tbempleado`;
CREATE TABLE IF NOT EXISTS `tbempleado` (
  `dni` varchar(8) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(80) DEFAULT NULL,
  `direccion` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `clave` varchar(10) DEFAULT NULL,
  `imagen` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`dni`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla dbtienda.tbempleado: ~2 rows (aproximadamente)
INSERT INTO `tbempleado` (`dni`, `nombre`, `apellido`, `direccion`, `telefono`, `email`, `clave`, `imagen`) VALUES
	('11111111', 'Pedro', 'Garcia', 'Calle Tacna S/N', '900858470', 'PGarcia@tienda.com', '123456', 'https://i.ibb.co/rGtPBCg/actor.jpg');

-- Volcando estructura para tabla dbtienda.tbproducto
DROP TABLE IF EXISTS `tbproducto`;
CREATE TABLE IF NOT EXISTS `tbproducto` (
  `idproducto` varchar(6) NOT NULL,
  `nombreproducto` varchar(50) DEFAULT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `descripcion` varchar(150) DEFAULT NULL,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `imagen` varchar(250) DEFAULT NULL,
  `estado` bit(1) DEFAULT NULL,
  PRIMARY KEY (`idproducto`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla dbtienda.tbproducto: ~2 rows (aproximadamente)
INSERT INTO `tbproducto` (`idproducto`, `nombreproducto`, `categoria`, `descripcion`, `precio`, `stock`, `imagen`, `estado`) VALUES
	('PRO001', 'Laptop Asus TUF GAMING', 'Laptop', 'Laptop con Procesador i5 12va Generacion, 12 GB RAM, 512GB SSD', 3500.00, 18, 'https://i.ibb.co/R7T9Bpr/razer.jpg', b'1'),
	('PRO002', 'Laptop HP Profesional', 'Laptop', 'Laptop con Procesador i5 12va Generacion, 12 GB RAM, 512GB SSD', 2600.00, 20, NULL, b'1'),
	('PRO003', 'Razer Pro', 'Laptop', 'Laptop portatil Razer', 2199.00, NULL, 'https://i.ibb.co/7zN26by/coraje.jpg', b'0');

-- Volcando estructura para tabla dbtienda.tbproveedor
DROP TABLE IF EXISTS `tbproveedor`;
CREATE TABLE IF NOT EXISTS `tbproveedor` (
  `idproveedor` varchar(6) NOT NULL,
  `nombreproveedor` varchar(50) DEFAULT NULL,
  `direccionproveedor` varchar(150) DEFAULT NULL,
  `telefonoproveedor` varchar(9) DEFAULT NULL,
  PRIMARY KEY (`idproveedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla dbtienda.tbproveedor: ~2 rows (aproximadamente)
INSERT INTO `tbproveedor` (`idproveedor`, `nombreproveedor`, `direccionproveedor`, `telefonoproveedor`) VALUES
	('PVE001', 'ASUS', 'Calle Larcomar 310 - Lima', '018459236'),
	('PVE002', 'HP', 'Calle Prado 760 - Lima', '019658327');

-- Volcando estructura para tabla dbtienda.tbusuario
DROP TABLE IF EXISTS `tbusuario`;
CREATE TABLE IF NOT EXISTS `tbusuario` (
  `idusuario` int(11) NOT NULL,
  `usuario` varchar(5) NOT NULL,
  `clave` varchar(10) NOT NULL,
  PRIMARY KEY (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla dbtienda.tbusuario: ~1 rows (aproximadamente)
INSERT INTO `tbusuario` (`idusuario`, `usuario`, `clave`) VALUES
	(1, 'admin', '1234');

-- Volcando estructura para tabla dbtienda.tbventa
DROP TABLE IF EXISTS `tbventa`;
CREATE TABLE IF NOT EXISTS `tbventa` (
  `IdVenta` int(11) NOT NULL AUTO_INCREMENT,
  `dnicliente` varchar(8) DEFAULT NULL,
  `dniempleado` varchar(8) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `totalventa` decimal(20,6) DEFAULT NULL,
  PRIMARY KEY (`IdVenta`),
  KEY `FK_tbventa_tbcliente` (`dnicliente`),
  KEY `FK_tbventa_tbempleado` (`dniempleado`),
  CONSTRAINT `FK_tbventa_tbcliente` FOREIGN KEY (`dnicliente`) REFERENCES `tbcliente` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_tbventa_tbempleado` FOREIGN KEY (`dniempleado`) REFERENCES `tbempleado` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla dbtienda.tbventa: ~1 rows (aproximadamente)
INSERT INTO `tbventa` (`IdVenta`, `dnicliente`, `dniempleado`, `fecha`, `hora`, `totalventa`) VALUES
	(1, '44444444', '11111111', '2023-10-09', '01:43:34', 7000.000000);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bd_kratos_publicidad
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bd_kratos_publicidad` DEFAULT CHARACTER SET utf8 ;
USE `bd_kratos_publicidad` ;

-- -----------------------------------------------------
-- Table `bd_kratos_publicidad`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_kratos_publicidad`.`Clientes` (
  `id_Clientes` INT NOT NULL AUTO_INCREMENT,
  `Nombre_completo` VARCHAR(100) NOT NULL,
  `Tipo_documento` VARCHAR(20) NOT NULL,
  `Numero_documento` VARCHAR(20) NOT NULL,
  `Telefono` VARCHAR(15) NULL,
  `Email` VARCHAR(100) NULL,
  PRIMARY KEY (`id_Clientes`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_kratos_publicidad`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_kratos_publicidad`.`Usuarios` (
  `id_Usuarios` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Contrasena` VARCHAR(255) NOT NULL,
  `Rol` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_Usuarios`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_kratos_publicidad`.`Productos_servicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_kratos_publicidad`.`Productos_servicios` (
  `idProductos_servicios` INT NOT NULL AUTO_INCREMENT,
  `Nombre_producto` VARCHAR(100) NOT NULL,
  `Descripcion` TEXT NULL,
  `Precio_base` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idProductos_servicios`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_kratos_publicidad`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_kratos_publicidad`.`Pedidos` (
  `id_Pedidos` INT NOT NULL AUTO_INCREMENT,
  `Fecha` DATETIME NOT NULL,
  `Estado` VARCHAR(50) NOT NULL,
  `Total` DECIMAL(10,2) NOT NULL,
  `Clientes_id_Clientes` INT NOT NULL,
  `Usuarios_id_Usuarios` INT NOT NULL,
  PRIMARY KEY (`id_Pedidos`),
  INDEX `fk_Pedidos_Clientes_idx` (`Clientes_id_Clientes` ASC),
  INDEX `fk_Pedidos_Usuarios1_idx` (`Usuarios_id_Usuarios` ASC),
  CONSTRAINT `fk_Pedidos_Clientes`
    FOREIGN KEY (`Clientes_id_Clientes`)
    REFERENCES `bd_kratos_publicidad`.`Clientes` (`id_Clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedidos_Usuarios1`
    FOREIGN KEY (`Usuarios_id_Usuarios`)
    REFERENCES `bd_kratos_publicidad`.`Usuarios` (`id_Usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_kratos_publicidad`.`Detalle_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_kratos_publicidad`.`Detalle_pedido` (
  `idDetalle_pedido` INT NOT NULL AUTO_INCREMENT,
  `Cantidad` INT NOT NULL,
  `Precio_unitario` DECIMAL(10,2) NOT NULL,
  `Pedidos_id_Pedidos` INT NOT NULL,
  `Productos_servicios_idProductos_servicios` INT NOT NULL,
  PRIMARY KEY (`idDetalle_pedido`),
  INDEX `fk_Detalle_pedido_Pedidos1_idx` (`Pedidos_id_Pedidos` ASC),
  INDEX `fk_Detalle_pedido_Productos_servicios1_idx` (`Productos_servicios_idProductos_servicios` ASC),
  CONSTRAINT `fk_Detalle_pedido_Pedidos1`
    FOREIGN KEY (`Pedidos_id_Pedidos`)
    REFERENCES `bd_kratos_publicidad`.`Pedidos` (`id_Pedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Detalle_pedido_Productos_servicios1`
    FOREIGN KEY (`Productos_servicios_idProductos_servicios`)
    REFERENCES `bd_kratos_publicidad`.`Productos_servicios` (`idProductos_servicios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `bd_kratos_publicidad`.`Pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bd_kratos_publicidad`.`Pagos` (
  `id_pagos` INT NOT NULL AUTO_INCREMENT,
  `Fecha_pago` DATETIME NOT NULL,
  `Monto` DECIMAL(10,2) NOT NULL,
  `Metodo_pago` VARCHAR(50) NOT NULL,
  `Estado_pago` VARCHAR(50) NOT NULL,
  `Pedidos_id_Pedidos` INT NOT NULL,
  PRIMARY KEY (`id_pagos`),
  INDEX `fk_Pagos_Pedidos1_idx` (`Pedidos_id_Pedidos` ASC),
  CONSTRAINT `fk_Pagos_Pedidos1`
    FOREIGN KEY (`Pedidos_id_Pedidos`)
    REFERENCES `bd_kratos_publicidad`.`Pedidos` (`id_Pedidos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
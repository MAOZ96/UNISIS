-- MySQL Script generated by MySQL Workbench
-- Mon Jul  6 13:38:39 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema upgbd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema upgbd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `upgbd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `upgbd` ;

-- -----------------------------------------------------
-- Table `upgbd`.`alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`alumnos` (
  `ci_alumno` INT NOT NULL,
  `cod_alumno` INT NULL AUTO_INCREMENT,
  `nombres` TEXT(50) NOT NULL,
  `apellidos` TEXT(50) NOT NULL,
  `dirección` VARCHAR(50) NULL DEFAULT NULL,
  `fecha_Nacimiento` DATE NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `Correo` VARCHAR(45) NULL DEFAULT NULL,
  `Curso` VARCHAR(45) NULL DEFAULT NULL,
  `Id_Asignatura_Completada` INT(11) NULL DEFAULT NULL,
  `alumnoscol` VARCHAR(45) NULL,
  `nacionalidad` VARCHAR(45) NULL,
  PRIMARY KEY USING BTREE (`ci_alumno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `upgbd`.`asignaturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`asignaturas` (
  `id_asignatura` INT(20) NOT NULL,
  `nombre_asignatura` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_asignatura`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `upgbd`.`profesores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`profesores` (
  `idprofe` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `fk_asignatura` VARCHAR(45) NULL,
  `fecha` VARCHAR(45) NULL,
  `fk_turno` INT NULL,
  `fk_curso` INT NULL,
  PRIMARY KEY (`idprofe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upgbd`.`calificaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`calificaciones` (
  `idcalificaciones` INT(11) NOT NULL,
  `fk_alumnos` INT(11) NOT NULL,
  `fk_materia` INT(11) NOT NULL,
  `profe` INT NULL DEFAULT NULL,
  `calificacion` INT(11) NOT NULL,
  `examen_parcial` DECIMAL(2,2) NULL DEFAULT NULL,
  `examen_final` DECIMAL(2,2) NULL DEFAULT NULL,
  `trabajos` DECIMAL(2,2) NULL DEFAULT NULL,
  `puntaje_final` DECIMAL(3,3) NULL DEFAULT NULL,
  PRIMARY KEY (`idcalificaciones`),
  INDEX `fk_ci_idx` (`fk_alumnos` ASC) VISIBLE,
  INDEX `fk_materia_idx` (`fk_materia` ASC) VISIBLE,
  INDEX `fk_profe_idx` (`profe` ASC) VISIBLE,
  CONSTRAINT `fk_ci`
    FOREIGN KEY (`fk_alumnos`)
    REFERENCES `upgbd`.`alumnos` (`ci_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_materia`
    FOREIGN KEY (`fk_materia`)
    REFERENCES `upgbd`.`asignaturas` (`id_asignatura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_profe`
    FOREIGN KEY (`profe`)
    REFERENCES `upgbd`.`profesores` (`idprofe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `upgbd`.`tipo_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`tipo_pago` (
  `idtipo` INT NOT NULL,
  `descripcion` VARCHAR(150) NULL,
  PRIMARY KEY (`idtipo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upgbd`.`saldos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`saldos` (
  `idsaldo` INT NOT NULL,
  `fk_ci` INT NULL,
  `fecha` DATETIME NULL,
  `saldo` INT NULL,
  PRIMARY KEY (`idsaldo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upgbd`.`permisos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`permisos` (
  `idpermiso` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idpermiso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upgbd`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`usuario` (
  `id_usuario` INT NOT NULL,
  `usuario` VARCHAR(20) NULL DEFAULT NULL,
  `pass` VARCHAR(30) NULL DEFAULT NULL,
  `permiso` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  INDEX `fk_permiso_idx` (`permiso` ASC) VISIBLE,
  CONSTRAINT `fk_permiso`
    FOREIGN KEY (`permiso`)
    REFERENCES `upgbd`.`permisos` (`idpermiso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `upgbd`.`pagos_ingresos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`pagos_ingresos` (
  `idpago` INT NOT NULL AUTO_INCREMENT,
  `fecha_pago` DATE NULL,
  `abono` INT NULL,
  `numero_boleta` INT NULL,
  `fk_id_tipo_pago` INT NULL,
  `fk_ci_alumno` INT NULL,
  `fk_idsaldo` INT NOT NULL,
  `usuario_id_usuario` INT NOT NULL,
  PRIMARY KEY (`idpago`),
  INDEX `fk_tipopago_idx` (`fk_id_tipo_pago` ASC) VISIBLE,
  INDEX `fk_alumno_idx` (`fk_ci_alumno` ASC) VISIBLE,
  INDEX `fk_pagos_ingresos_saldos1_idx` (`fk_idsaldo` ASC) VISIBLE,
  INDEX `fk_pagos_ingresos_usuario1_idx` (`usuario_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_tipopago`
    FOREIGN KEY (`fk_id_tipo_pago`)
    REFERENCES `upgbd`.`tipo_pago` (`idtipo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno`
    FOREIGN KEY (`fk_ci_alumno`)
    REFERENCES `upgbd`.`alumnos` (`ci_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_ingresos_saldos1`
    FOREIGN KEY (`fk_idsaldo`)
    REFERENCES `upgbd`.`saldos` (`idsaldo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_ingresos_usuario1`
    FOREIGN KEY (`usuario_id_usuario`)
    REFERENCES `upgbd`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `upgbd`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`curso` (
  `idcurso` INT NOT NULL,
  `numero_curso` INT NULL,
  PRIMARY KEY (`idcurso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upgbd`.`carrera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`carrera` (
  `id_carrera` INT NOT NULL,
  `nombre_carrera` VARCHAR(45) NULL,
  `fecha_finalizacion` DATE NULL,
  PRIMARY KEY (`id_carrera`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upgbd`.`turno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`turno` (
  `idturno` INT NOT NULL,
  `nombre_turno` VARCHAR(45) NULL,
  PRIMARY KEY (`idturno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upgbd`.`matricula`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`matricula` (
  `id_matricula` INT NOT NULL,
  `fecha` DATE NULL,
  `observacion` VARCHAR(45) NULL,
  `fk_curso_id` INT NULL,
  `fk_ci_alumno` INT NOT NULL,
  `fk_carrera_id` INT NOT NULL,
  `fk_idturno` INT NOT NULL,
  PRIMARY KEY (`id_matricula`),
  INDEX `fk_matricula_alumnos_idx` (`fk_ci_alumno` ASC) VISIBLE,
  INDEX `fk_matricula_carrera1_idx` (`fk_carrera_id` ASC) VISIBLE,
  INDEX `fk_curso_idx` (`fk_curso_id` ASC) VISIBLE,
  INDEX `fk_matricula_turno1_idx` (`fk_idturno` ASC) VISIBLE,
  CONSTRAINT `fk_matricula_alumnos`
    FOREIGN KEY (`fk_ci_alumno`)
    REFERENCES `upgbd`.`alumnos` (`ci_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matricula_carrera1`
    FOREIGN KEY (`fk_carrera_id`)
    REFERENCES `upgbd`.`carrera` (`id_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso`
    FOREIGN KEY (`fk_curso_id`)
    REFERENCES `upgbd`.`curso` (`idcurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_matricula_turno1`
    FOREIGN KEY (`fk_idturno`)
    REFERENCES `upgbd`.`turno` (`idturno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `upgbd`.`numero_cuota`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `upgbd`.`numero_cuota` (
  `idcuota` INT NOT NULL,
  `numero_cuota` INT NULL,
  `monto` INT(10) NULL,
  `pagos_ingresos_idpago` INT NOT NULL,
  PRIMARY KEY (`idcuota`),
  INDEX `fk_numero_cuota_pagos_ingresos1_idx` (`pagos_ingresos_idpago` ASC) VISIBLE,
  CONSTRAINT `fk_numero_cuota_pagos_ingresos1`
    FOREIGN KEY (`pagos_ingresos_idpago`)
    REFERENCES `upgbd`.`pagos_ingresos` (`idpago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- MySQL Script generated by MySQL Workbench
-- Tue Sep  6 01:10:31 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema FLF
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema FLF
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `FLF` DEFAULT CHARACTER SET utf8 ;
USE `FLF` ;

-- -----------------------------------------------------
-- Table `FLF`.`Time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FLF`.`Time` (
  `idTime` INT(11) NOT NULL,
  `nome` VARCHAR(80) NULL,
  `image` TINYTEXT NULL,
  PRIMARY KEY (`idTime`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FLF`.`Campeonato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FLF`.`Campeonato` (
  `idCampeonato` INT(11) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `idTimeVencedor` INT(11) NULL,
  `image` TINYTEXT NULL,
  PRIMARY KEY (`idCampeonato`),
  INDEX `idTimeVencedor_idx` (`idTimeVencedor` ASC) VISIBLE,
  CONSTRAINT `idTimeVencedor`
    FOREIGN KEY (`idTimeVencedor`)
    REFERENCES `FLF`.`Time` (`idTime`)
    ON DELETE SET NULL
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FLF`.`Partida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FLF`.`Partida` (
  `idPartida` INT(11) NOT NULL AUTO_INCREMENT,
  `data` DATETIME NOT NULL,
  `idCampeonato` INT(11) NOT NULL,
  `tipo` VARCHAR(45) NULL,
  PRIMARY KEY (`idPartida`),
  INDEX `idCampeonato_idx` (`idCampeonato` ASC) VISIBLE,
  UNIQUE INDEX `idPartida_UNIQUE` (`idPartida` ASC) VISIBLE,
  CONSTRAINT `PartidaidCampeonato`
    FOREIGN KEY (`idCampeonato`)
    REFERENCES `FLF`.`Campeonato` (`idCampeonato`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FLF`.`PartidaTime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FLF`.`PartidaTime` (
  `idPartida` INT(11) NOT NULL,
  `idTime` INT(11) NOT NULL,
  PRIMARY KEY (`idPartida`, `idTime`),
  INDEX `idTime_idx` (`idTime` ASC) VISIBLE,
  CONSTRAINT `PartidaTimeidTime`
    FOREIGN KEY (`idTime`)
    REFERENCES `FLF`.`Time` (`idTime`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `PartidaTimeidPartida`
    FOREIGN KEY (`idPartida`)
    REFERENCES `FLF`.`Partida` (`idPartida`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FLF`.`CampeonatoTime`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FLF`.`CampeonatoTime` (
  `idCampeonato` INT(11) NOT NULL,
  `idTime` INT(11) NOT NULL,
  PRIMARY KEY (`idCampeonato`, `idTime`),
  INDEX `idTime_idx` (`idTime` ASC) VISIBLE,
  CONSTRAINT `CampeonatoTimeidCampeonato`
    FOREIGN KEY (`idCampeonato`)
    REFERENCES `FLF`.`Campeonato` (`idCampeonato`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `CampeonatoTimeidTime`
    FOREIGN KEY (`idTime`)
    REFERENCES `FLF`.`Time` (`idTime`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `FLF`.`Gol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FLF`.`Gol` (
  `idGol` INT(11) NOT NULL AUTO_INCREMENT,
  `idTime` INT(11) NOT NULL,
  `idPartida` INT(11) NOT NULL,
  PRIMARY KEY (`idGol`),
  UNIQUE INDEX `idGol_UNIQUE` (`idGol` ASC) VISIBLE,
  INDEX `idTime_idx` (`idTime` ASC) VISIBLE,
  INDEX `idPartida_idx` (`idPartida` ASC) VISIBLE,
  CONSTRAINT `GolidTime`
    FOREIGN KEY (`idTime`)
    REFERENCES `FLF`.`Time` (`idTime`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT `GolidPartida`
    FOREIGN KEY (`idPartida`)
    REFERENCES `FLF`.`Partida` (`idPartida`)
    ON DELETE CASCADE
    ON UPDATE RESTRICT)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mydb`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FLF`.`Usuario` (
  `email` VARCHAR(60) NOT NULL,
  `password` LONGTEXT NOT NULL,
  `token` LONGTEXT NULL,
  `expiration` VARCHAR(24) NULL,
  `codigo` INT(6) NULL,
  PRIMARY KEY (`email`),
  INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`AtividadeDoUsuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FLF`.`AtividadeDoUsuario` (
  `idAtividadeDoUsuario` VARCHAR(32) NOT NULL,
  `body` JSON NULL,
  `query` JSON NULL,
  `parameters` JSON NULL,
  `path` VARCHAR(60) NOT NULL,
  `IP` VARCHAR(16) NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  `timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`idAtividadeDoUsuario`),
  UNIQUE INDEX `idAtividadeDoUsuario_UNIQUE` (`idAtividadeDoUsuario` ASC) VISIBLE,
  INDEX `UsuarioEmail_idx` (`email` ASC) VISIBLE,
  CONSTRAINT `UsuarioEmail`
    FOREIGN KEY (`email`)
    REFERENCES `FLF`.`Usuario` (`email`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

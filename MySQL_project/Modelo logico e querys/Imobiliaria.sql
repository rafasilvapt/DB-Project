-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Imobiliaria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Imobiliaria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Imobiliaria` DEFAULT CHARACTER SET utf8 ;
USE `Imobiliaria` ;

-- -----------------------------------------------------
-- Table `Imobiliaria`.`ContactoFuncionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Imobiliaria`.`ContactoFuncionario` (
  `idContactoFuncionario` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(45) NULL,
  `Telemovel` INT NOT NULL,
  PRIMARY KEY (`idContactoFuncionario`),
  UNIQUE INDEX `Telemovel_UNIQUE` (`Telemovel` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Imobiliaria`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Imobiliaria`.`Funcionario` (
  `idFuncionario` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Data_Nasc` DATE NOT NULL,
  `idContactoFuncionario` INT NOT NULL,
  PRIMARY KEY (`idFuncionario`),
  INDEX `fk_Funcionario_ContactoFuncionario1_idx` (`idContactoFuncionario` ASC),
  CONSTRAINT `fk_Funcionario_ContactoFuncionario1`
    FOREIGN KEY (`idContactoFuncionario`)
    REFERENCES `Imobiliaria`.`ContactoFuncionario` (`idContactoFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Imobiliaria`.`ContactoCliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Imobiliaria`.`ContactoCliente` (
  `idContactoCliente` INT NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(45) NULL,
  `Telemovel` INT NOT NULL,
  PRIMARY KEY (`idContactoCliente`),
  UNIQUE INDEX `Telemovel_UNIQUE` (`Telemovel` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Imobiliaria`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Imobiliaria`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Contribuinte` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Data_Nasc` DATE NOT NULL,
  `idContactoCliente` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_ContactoCliente1_idx` (`idContactoCliente` ASC),
  UNIQUE INDEX `Contribuinte_UNIQUE` (`Contribuinte` ASC),
  CONSTRAINT `fk_Cliente_ContactoCliente1`
    FOREIGN KEY (`idContactoCliente`)
    REFERENCES `Imobiliaria`.`ContactoCliente` (`idContactoCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Imobiliaria`.`Imovel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Imobiliaria`.`Imovel` (
  `idImovel` INT NOT NULL AUTO_INCREMENT,
  `Tipo` VARCHAR(12) NOT NULL,
  `Area` INT NOT NULL,
  `Condicao` VARCHAR(8) NOT NULL,
  `Valor` INT NOT NULL,
  `Morada` VARCHAR(50) NOT NULL,
  `idCliente` INT NOT NULL,
  `idFuncionario` INT NOT NULL,
  PRIMARY KEY (`idImovel`),
  INDEX `fk_Imovel_Cliente1_idx` (`idCliente` ASC),
  INDEX `fk_Imovel_Funcionario1_idx` (`idFuncionario` ASC),
  CONSTRAINT `fk_Imovel_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Imobiliaria`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Imovel_Funcionario1`
    FOREIGN KEY (`idFuncionario`)
    REFERENCES `Imobiliaria`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Imobiliaria`.`Transacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Imobiliaria`.`Transacao` (
  `idTransacao` INT NOT NULL AUTO_INCREMENT,
  `Data_Inicial` DATE NOT NULL,
  `Data_Final` DATE NULL,
  `valor` INT NOT NULL,
  `Tipo` VARCHAR(12) NOT NULL,
  `idImovel` INT NOT NULL,
  `idCliente` INT NOT NULL,
  `idFuncionario` INT NOT NULL,
  PRIMARY KEY (`idTransacao`),
  INDEX `fk_Transacao_Imovel1_idx` (`idImovel` ASC),
  INDEX `fk_Transacao_Cliente1_idx` (`idCliente` ASC),
  INDEX `fk_Transacao_Funcionario1_idx` (`idFuncionario` ASC),
  CONSTRAINT `fk_Transacao_Imovel1`
    FOREIGN KEY (`idImovel`)
    REFERENCES `Imobiliaria`.`Imovel` (`idImovel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transacao_Cliente1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `Imobiliaria`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Transacao_Funcionario1`
    FOREIGN KEY (`idFuncionario`)
    REFERENCES `Imobiliaria`.`Funcionario` (`idFuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

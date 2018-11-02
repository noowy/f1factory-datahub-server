-- MySQL Script generated by MySQL Workbench
-- Sun 14 Oct 2018 12:26:39 AM MSK
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Detail` (
  `ID` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(70) NOT NULL,
  `description` TEXT(300) NULL DEFAULT '',
  `units` VARCHAR(20) NOT NULL,
  `for_sale` TINYINT(1) NOT NULL,
  `lifespan` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 10000;


-- -----------------------------------------------------
-- Table `mydb`.`Route`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Route` (
  `ID` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `route_id_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 30000;


-- -----------------------------------------------------
-- Table `mydb`.`Process`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Process` (
  `ID` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `completion_time` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `process_id_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 40000;


-- -----------------------------------------------------
-- Table `mydb`.`Specification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Specification` (
  `component_id` MEDIUMINT UNSIGNED NOT NULL,
  `product_id` MEDIUMINT UNSIGNED NOT NULL,
  `route_id` MEDIUMINT UNSIGNED NOT NULL,
  `component_quantity` INT UNSIGNED NOT NULL
  PRIMARY KEY (`component_id`, `product_id`, `route_id`),
  INDEX `fk_Specification_Detail_idx` (`component_id` ASC),
  INDEX `fk_Specification_Detail1_idx` (`product_id` ASC),
  INDEX `fk_Specification_Route1_idx` (`route_id` ASC),
  CONSTRAINT `fk_Specification_Detail`
    FOREIGN KEY (`component_id`)
    REFERENCES `mydb`.`Detail` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Specification_Detail1`
    FOREIGN KEY (`product_id`)
    REFERENCES `mydb`.`Detail` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Specification_Route1`
    FOREIGN KEY (`route_id`)
    REFERENCES `mydb`.`Route` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
ENGINE = InnoDB
AUTO_INCREMENT = 20000;


-- -----------------------------------------------------
-- Table `mydb`.`Route_Process`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Route_Process` (
  `route_id` MEDIUMINT UNSIGNED NOT NULL,
  `process_id` MEDIUMINT UNSIGNED NOT NULL,
  `transportation_time` INT NOT NULL,
  INDEX `fk_Route_Process_Process1_idx` (`process_id` ASC),
  INDEX `fk_Route_Process_Route1_idx` (`route_id` ASC),
  PRIMARY KEY (`route_id`, `process_id`),
  CONSTRAINT `fk_Route_Process_Process1`
    FOREIGN KEY (`process_id`)
    REFERENCES `mydb`.`Process` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Route_Process_Route1`
    FOREIGN KEY (`route_id`)
    REFERENCES `mydb`.`Route` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Workstation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Workstation` (
  `ID` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` TEXT(300) NULL,
  `process_id` MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `workstation_id_UNIQUE` (`ID` ASC),
  INDEX `fk_Workstation_Process1_idx` (`process_id` ASC),
  CONSTRAINT `fk_Workstation_Process1`
    FOREIGN KEY (`process_id`)
    REFERENCES `mydb`.`Process` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 50000;


-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `ID` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `current_client` TINYINT(1) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `client_id_UNIQUE` (`ID` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 90000;


-- -----------------------------------------------------
-- Table `mydb`.`MarketOrder`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`MarketOrder` ( -- changed the name to MarketOrder
  `ID` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NOT NULL,
  `client_id` MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `order_id_UNIQUE` (`ID` ASC),
  INDEX `fk_MarketOrder_Client1_idx` (`client_id` ASC),
  CONSTRAINT `fk_MarketOrder_Client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `mydb`.`Client` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 60000;


-- -----------------------------------------------------
-- Table `mydb`.`Product_Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_Order` (
  `component_id` MEDIUMINT UNSIGNED NOT NULL,
  `order_id` MEDIUMINT UNSIGNED NOT NULL,
  `quantity` MEDIUMINT(5) UNSIGNED NOT NULL,
  `is_packed` TINYINT(1) NOT NULL,
  `is_shipped` TINYINT(1) NOT NULL,
  PRIMARY KEY (`component_id`, `order_id`),
  INDEX `fk_Product_Order_Detail1_idx` (`component_id` ASC),
  INDEX `fk_Product_Order_Order1_idx` (`order_id` ASC),
  CONSTRAINT `fk_Product_Order_Order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`MarketOrder` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Product_Order_Detail1`
    FOREIGN KEY (`component_id`)
    REFERENCES `mydb`.`Detail` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Factory_Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Factory_Orders` (
  `ID` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `component_id` MEDIUMINT UNSIGNED NOT NULL,
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  `route_id` MEDIUMINT UNSIGNED NOT NULL,
  `market_order` MEDIUMINT UNSIGNED,
  PRIMARY KEY (`ID`),
  INDEX `fk_Factory_Orders_Detail1_idx` (`component_id` ASC),
  INDEX `fk_Factory_Orders_Route1_idx` (`route_id` ASC),
  INDEX `fk_MarketOrder_ID` (`market_order` ASC)
  CONSTRAINT `fk_Factory_Orders_Detail1`
    FOREIGN KEY (`component_id`)
    REFERENCES `mydb`.`Detail` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Factory_Orders_Route1`
    FOREIGN KEY (`route_id`)
    REFERENCES `mydb`.`Route` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION),
  CONSTRAINT `fk_MarketOrder_ID`
    FOREIGN KEY (`market_order`)
    REFERENCES `mydb`.`MarketOrder` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 20000;


-- -----------------------------------------------------
-- Table `mydb`.`Stock`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Stock` (
  `component_id` MEDIUMINT UNSIGNED NOT NULL,
  `quantity` INT UNSIGNED NOT NULL DEFAULT 0,
  `manufacture_date` DATETIME NOT NULL,
  `expiration_date` DATETIME NOT NULL,
  INDEX `fk_Stock_Detail1_idx` (`component_id` ASC),
  PRIMARY KEY (`component_id`, `manufacture_date`),
  CONSTRAINT `fk_Stock_Detail1`
    FOREIGN KEY (`component_id`)
    REFERENCES `mydb`.`Detail` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb`;

DELIMITER $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`Factory_Orders_BEFORE_DELETE` BEFORE DELETE ON `Factory_Orders` FOR EACH ROW
BEGIN
    DECLARE _lifespan INT;
    DECLARE _expiration_date DATETIME;
    IF OLD.market_order IS NOT NULL
    THEN 
      UPDATE Product_Order SET is_packed=true WHERE Product_Order.component_id=OLD.component_id AND Product_Order.order_id=OLD.market_order;  
    ELSE  
      SELECT lifespan INTO _lifespan FROM Detail WHERE ID=OLD.component_id;
      SELECT DATE_ADD(CAST(NOW() AS DATETIME), INTERVAL CAST(_lifespan AS UNSIGNED) DAY) INTO _expiration_date;
      INSERT INTO Stock (component_id, quantity, manufacture_date, expiration_date) VALUES(OLD.component_id, OLD.quantity, NOW(), _expiration_date);
    END IF;
END$$

CREATE PROCEDURE add_factory_order(in componentid INT, in routeid INT, in quantity INT)
BEGIN
    DECLARE _transportation_time INT;
    DECLARE _completion_time INT;
    DECLARE order_end_time DATETIME;
    SELECT SUM(transportation_time) INTO _transportation_time FROM Route_Process WHERE Route_Process.route_id=routeid;
    SELECT SUM(completion_time) INTO _completion_time FROM Process WHERE Process.ID IN (SELECT process_id FROM Route_Process WHERE Route_Process.route_id=routeid);
    SELECT DATE_ADD(CAST(NOW() AS DATETIME), INTERVAL CAST((_transportation_time + _completion_time) * quantity AS UNSIGNED) MINUTE) INTO order_end_time;
    INSERT INTO Factory_Orders (component_id, quantity, route_id, start_time, end_time) VALUES(componentid, quantity, routeid, NOW(), order_end_time);
END$$

CREATE PROCEDURE add_to_stock (in componentid INT, in quantity INT)
BEGIN
    DECLARE _lifespan INT;
    DECLARE _expiration_date DATETIME;
    SELECT lifespan INTO _lifespan FROM Detail WHERE Detail.ID=componentid;
    SELECT DATE_ADD(CAST(NOW() AS DATETIME), INTERVAL CAST(_lifespan AS UNSIGNED) DAY) INTO _expiration_date;
    INSERT INTO Stock (component_id, quantity, manufacture_date, expiration_date) VALUES (componentid, quantity, NOW(), _expiration_date);
END$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
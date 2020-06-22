-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema interline_workreport
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema interline_workreport
-- -----------------------------------------------------



USE `interline_workreport` ;

-- -----------------------------------------------------
-- Table `interline_workreport`.`user_inform`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interline_workreport`.`user_inform` (
  `UserNum` INT(11) NOT NULL,
  `UserMail` VARCHAR(100) NOT NULL,
  `UserName` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `Team` VARCHAR(100),
  `Position` VARCHAR(100) DEFAULT '社員',
  `StartDate` DateTime DEFAULT CURRENT_TIMESTAMP,
  `LastReportDate` DateTime,
  `Retirement` VARCHAR(20) DEFAULT '在職', 
  `Authority` VARCHAR(1) NOT NULL DEFAULT 'u',
  PRIMARY KEY (`UserNum`),
  UNIQUE INDEX `UserMail_UNIQUE` (`UserMail` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `interline_workreport`.`workReport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interline_workreport`.`work_Report` (
  `ReportNum` INT(11) NOT NULL,
  `UserNum` INT(11) NOT NULL,
  `UserName` VARCHAR(50) NOT NULL,
  `Year` INT(4),
  `Month` INT(2),
  `UpdateDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `State` INT(1) NOT NULL,
  `SalesDay` INT(2),
  `WorkingDay` INT(2),
  `HolidayWorkingDay` INT(2),
  `AbsentDay` INT(2),
  `dateCondition1` VARCHAR(4),
  `attendHour1` INT(2),
  `attendMinute1` INT(2),
  `offHour1` INT(2),
  `offMinute1` INT(2),
  `restHour1` INT(2),
  `restMinute1` INT(2),
  `netWorkingTime1` VARCHAR(6),
  `workContent1` VARCHAR(300), `onoff1` VARCHAR(6),
  `dateCondition2` VARCHAR(4),
  `attendHour2` INT(2),
  `attendMinute2` INT(2),
  `offHour2` INT(2),
  `offMinute2` INT(2),
  `restHour2` INT(2),
  `restMinute2` INT(2),
  `netWorkingTime2` VARCHAR(6),
  `workContent2` VARCHAR(300), `onoff2` VARCHAR(6),
  `dateCondition3` VARCHAR(4),
  `attendHour3` INT(2),
  `attendMinute3` INT(2),
  `offHour3` INT(2),
  `offMinute3` INT(2),
  `restHour3` INT(2),
  `restMinute3` INT(2),
  `netWorkingTime3` VARCHAR(6),
  `workContent3` VARCHAR(300), `onoff3` VARCHAR(6),
  `dateCondition4` VARCHAR(4),
  `attendHour4` INT(2),
  `attendMinute4` INT(2),
  `offHour4` INT(2),
  `offMinute4` INT(2),
  `restHour4` INT(2),
  `restMinute4` INT(2),
  `netWorkingTime4` VARCHAR(6),
  `workContent4` VARCHAR(300), `onoff4` VARCHAR(6),
  `dateCondition5` VARCHAR(4),
  `attendHour5` INT(2),
  `attendMinute5` INT(2),
  `offHour5` INT(2),
  `offMinute5` INT(2),
  `restHour5` INT(2),
  `restMinute5` INT(2),
  `netWorkingTime5` VARCHAR(6),
  `workContent5` VARCHAR(300), `onoff5` VARCHAR(6),
  `dateCondition6` VARCHAR(4),
  `attendHour6` INT(2),
  `attendMinute6` INT(2),
  `offHour6` INT(2),
  `offMinute6` INT(2),
  `restHour6` INT(2),
  `restMinute6` INT(2),
  `netWorkingTime6` VARCHAR(6),
  `workContent6` VARCHAR(300), `onoff6` VARCHAR(6),
  `dateCondition7` VARCHAR(4),
  `attendHour7` INT(2),
  `attendMinute7` INT(2),
  `offHour7` INT(2),
  `offMinute7` INT(2),
  `restHour7` INT(2),
  `restMinute7` INT(2),
  `netWorkingTime7` VARCHAR(6),
  `workContent7` VARCHAR(300), `onoff7` VARCHAR(6),
  `dateCondition8` VARCHAR(4),
  `attendHour8` INT(2),
  `attendMinute8` INT(2),
  `offHour8` INT(2),
  `offMinute8` INT(2),
  `restHour8` INT(2),
  `restMinute8` INT(2),
  `netWorkingTime8` VARCHAR(6),
  `workContent8` VARCHAR(300), `onoff8` VARCHAR(6),
  `dateCondition9` VARCHAR(4),
  `attendHour9` INT(2),
  `attendMinute9` INT(2),
  `offHour9` INT(2),
  `offMinute9` INT(2),
  `restHour9` INT(2),
  `restMinute9` INT(2),
  `netWorkingTime9` VARCHAR(6),
  `workContent9` VARCHAR(300), `onoff9` VARCHAR(6),
  `dateCondition10` VARCHAR(4),
  `attendHour10` INT(2),
  `attendMinute10` INT(2),
  `offHour10` INT(2),
  `offMinute10` INT(2),
  `restHour10` INT(2),
  `restMinute10` INT(2),
  `netWorkingTime10` VARCHAR(6),
  `workContent10` VARCHAR(300), `onoff10` VARCHAR(6),
  `dateCondition11` VARCHAR(4),
  `attendHour11` INT(2),
  `attendMinute11` INT(2),
  `offHour11` INT(2),
  `offMinute11` INT(2),
  `restHour11` INT(2),
  `restMinute11` INT(2),
  `netWorkingTime11` VARCHAR(6),
  `workContent11` VARCHAR(300), `onoff11` VARCHAR(6),
  `dateCondition12` VARCHAR(4),
  `attendHour12` INT(2),
  `attendMinute12` INT(2),
  `offHour12` INT(2),
  `offMinute12` INT(2),
  `restHour12` INT(2),
  `restMinute12` INT(2),
  `netWorkingTime12` VARCHAR(6),
  `workContent12` VARCHAR(300), `onoff12` VARCHAR(6),
  `dateCondition13` VARCHAR(4),
  `attendHour13` INT(2),
  `attendMinute13` INT(2),
  `offHour13` INT(2),
  `offMinute13` INT(2),
  `restHour13` INT(2),
  `restMinute13` INT(2),
  `netWorkingTime13` VARCHAR(6),
  `workContent13` VARCHAR(300), `onoff13` VARCHAR(6),
  `dateCondition14` VARCHAR(4),
  `attendHour14` INT(2),
  `attendMinute14` INT(2),
  `offHour14` INT(2),
  `offMinute14` INT(2),
  `restHour14` INT(2),
  `restMinute14` INT(2),
  `netWorkingTime14` VARCHAR(6),
  `workContent14` VARCHAR(300), `onoff14` VARCHAR(6),
  `dateCondition15` VARCHAR(4),
  `attendHour15` INT(2),
  `attendMinute15` INT(2),
  `offHour15` INT(2),
  `offMinute15` INT(2),
  `restHour15` INT(2),
  `restMinute15` INT(2),
  `netWorkingTime15` VARCHAR(6),
  `workContent15` VARCHAR(300), `onoff15` VARCHAR(6),
  `dateCondition16` VARCHAR(4),
  `attendHour16` INT(2),
  `attendMinute16` INT(2),
  `offHour16` INT(2),
  `offMinute16` INT(2),
  `restHour16` INT(2),
  `restMinute16` INT(2),
  `netWorkingTime16` VARCHAR(6),
  `workContent16` VARCHAR(300), `onoff16` VARCHAR(6),
  `dateCondition17` VARCHAR(4),
  `attendHour17` INT(2),
  `attendMinute17` INT(2),
  `offHour17` INT(2),
  `offMinute17` INT(2),
  `restHour17` INT(2),
  `restMinute17` INT(2),
  `netWorkingTime17` VARCHAR(6),
  `workContent17` VARCHAR(300), `onoff17` VARCHAR(6),
  `dateCondition18` VARCHAR(4),
  `attendHour18` INT(2),
  `attendMinute18` INT(2),
  `offHour18` INT(2),
  `offMinute18` INT(2),
  `restHour18` INT(2),
  `restMinute18` INT(2),
  `netWorkingTime18` VARCHAR(6),
  `workContent18` VARCHAR(300), `onoff18` VARCHAR(6),
  `dateCondition19` VARCHAR(4),
  `attendHour19` INT(2),
  `attendMinute19` INT(2),
  `offHour19` INT(2),
  `offMinute19` INT(2),
  `restHour19` INT(2),
  `restMinute19` INT(2),
  `netWorkingTime19` VARCHAR(6),
  `workContent19` VARCHAR(300), `onoff19` VARCHAR(6),
  `dateCondition20` VARCHAR(4),
  `attendHour20` INT(2),
  `attendMinute20` INT(2),
  `offHour20` INT(2),
  `offMinute20` INT(2),
  `restHour20` INT(2),
  `restMinute20` INT(2),
  `netWorkingTime20` VARCHAR(6),
  `workContent20` VARCHAR(300), `onoff20` VARCHAR(6),
  `dateCondition21` VARCHAR(4),
  `attendHour21` INT(2),
  `attendMinute21` INT(2),
  `offHour21` INT(2),
  `offMinute21` INT(2),
  `restHour21` INT(2),
  `restMinute21` INT(2),
  `netWorkingTime21` VARCHAR(6),
  `workContent21` VARCHAR(300), `onoff21` VARCHAR(6),
  `dateCondition22` VARCHAR(4),
  `attendHour22` INT(2),
  `attendMinute22` INT(2),
  `offHour22` INT(2),
  `offMinute22` INT(2),
  `restHour22` INT(2),
  `restMinute22` INT(2),
  `netWorkingTime22` VARCHAR(6),
  `workContent22` VARCHAR(300), `onoff22` VARCHAR(6),
  `dateCondition23` VARCHAR(4),
  `attendHour23` INT(2),
  `attendMinute23` INT(2),
  `offHour23` INT(2),
  `offMinute23` INT(2),
  `restHour23` INT(2),
  `restMinute23` INT(2),
  `netWorkingTime23` VARCHAR(6),
  `workContent23` VARCHAR(300), `onoff23` VARCHAR(6),
  `dateCondition24` VARCHAR(4),
  `attendHour24` INT(2),
  `attendMinute24` INT(2),
  `offHour24` INT(2),
  `offMinute24` INT(2),
  `restHour24` INT(2),
  `restMinute24` INT(2),
  `netWorkingTime24` VARCHAR(6),
  `workContent24` VARCHAR(300), `onoff24` VARCHAR(6),
  `dateCondition25` VARCHAR(4), 
  `attendHour25` INT(2),
  `attendMinute25` INT(2),
  `offHour25` INT(2),
  `offMinute25` INT(2),
  `restHour25` INT(2),
  `restMinute25` VARCHAR(6),
  `netWorkingTime25` VARCHAR(6),
  `workContent25` VARCHAR(300), `onoff25` VARCHAR(6),
  `dateCondition26` VARCHAR(4),
  `attendHour26` INT(2),
  `attendMinute26` INT(2),
  `offHour26` INT(2),
  `offMinute26` INT(2),
  `restHour26` INT(2),
  `restMinute26` INT(2),
  `netWorkingTime26` VARCHAR(6),
  `workContent26` VARCHAR(300), `onoff26` VARCHAR(6),
  `dateCondition27` VARCHAR(4),  
  `attendHour27` INT(2),
  `attendMinute27` INT(2),
  `offHour27` INT(2),
  `offMinute27` INT(2),
  `restHour27` INT(2),
  `restMinute27` INT(2),
  `netWorkingTime27` VARCHAR(6),
  `workContent27` VARCHAR(300), `onoff27` VARCHAR(6),
  `dateCondition28` VARCHAR(4),
  `attendHour28` INT(2),
  `attendMinute28` INT(2),
  `offHour28` INT(2),
  `offMinute28` INT(2),
  `restHour28` INT(2),
  `restMinute28` INT(2),
  `netWorkingTime28` VARCHAR(6),
  `workContent28` VARCHAR(300), `onoff28` VARCHAR(6),
  `dateCondition29` VARCHAR(4), 
  `attendHour29` INT(2),
  `attendMinute29` INT(2),
  `offHour29` INT(2),
  `offMinute29` INT(2),
  `restHour29` INT(2),
  `restMinute29` INT(2),
  `netWorkingTime29` VARCHAR(6),
  `workContent29` VARCHAR(300), `onoff29` VARCHAR(6),
  `dateCondition30` VARCHAR(4),
  `attendHour30` INT(2),
  `attendMinute30` INT(2),
  `offHour30` INT(2),
  `offMinute30` INT(2),
  `restHour30` INT(2),
  `restMinute30` INT(2),
  `netWorkingTime30` VARCHAR(6),
  `workContent30` VARCHAR(300), `onoff30` VARCHAR(6),
  `dateCondition31` VARCHAR(4),
  `attendHour31` INT(2),
  `attendMinute31` INT(2),
  `offHour31` INT(2),
  `offMinute31` INT(2),
  `restHour31` INT(2),
  `restMinute31` INT(2),
  `netWorkingTime31` VARCHAR(6),
  `workContent31` VARCHAR(300), `onoff31` VARCHAR(6),
  `sumWorkingTime` VARCHAR(6),
   PRIMARY KEY (`ReportNum`),
   UNIQUE INDEX `UserNumYearMonth_UNIQUE` (`UserNum`,`Year`,`Month` ASC) VISIBLE,
   INDEX `fk_WORK_REPORT_USER_INFORM_idx` (`userNum` ASC) VISIBLE,
   CONSTRAINT `fk_WORK_REPORT_USER_INFORM`
   FOREIGN KEY (`UserNum`)
   REFERENCES `interline_workreport`.`user_inform` (`UserNum`)
   ON DELETE CASCADE
   ON UPDATE CASCADE)
   ENGINE = InnoDB
   DEFAULT CHARACTER SET = utf8;



-- -----------------------------------------------------
-- Table `interline_workreport`.`seq_report`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `interline_workreport`.`seq_report` (
  `val` INT(11) NOT NULL,
  `seq_name` VARCHAR(50) NOT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `interline_workreport` ;

-- -----------------------------------------------------
-- function get_seq
-- -----------------------------------------------------

DELIMITER $$
USE `interline_workreport`$$
CREATE DEFINER=`hrhr2`@`%` FUNCTION `get_seq`(p_seq_name varchar(45)) RETURNS int(11)
    READS SQL DATA
begin
declare result_id int;
update seq_report set val = last_insert_id(val+1)
where seq_name = p_seq_name;
set result_id = (select last_insert_id());
return result_id;
end$$




DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


insert into seq_report values(0,'seq_work_report');

commit;

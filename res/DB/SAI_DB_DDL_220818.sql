-- MySQL Script generated by MySQL Workbench
-- Wed Aug 17 22:04:44 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sai
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sai` ;

-- -----------------------------------------------------
-- Schema sai
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sai` DEFAULT CHARACTER SET utf8mb4 ;
USE `sai` ;

-- -----------------------------------------------------
-- Table `sai`.`family`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`family` ;

CREATE TABLE IF NOT EXISTS `sai`.`family` (
  `family_id` VARCHAR(10) NOT NULL,
  `family_name` VARCHAR(20) NULL DEFAULT NULL,
  `family_image_path` VARCHAR(255) NULL DEFAULT NULL,
  `family_image_path_server` VARCHAR(255) NULL DEFAULT NULL,
  `family_image_name` VARCHAR(255) NULL DEFAULT NULL,
  `family_image_type` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`family_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`album`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`album` ;

CREATE TABLE IF NOT EXISTS `sai`.`album` (
  `album_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `family_id` VARCHAR(10) NOT NULL,
  `album_name` VARCHAR(30) NOT NULL,
  `album_start_date` DATE NULL DEFAULT NULL,
  `album_end_date` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`album_id`),
  INDEX `FK_FAMILY_TO_ALBUM_1` (`family_id` ASC),
  CONSTRAINT `FK_FAMILY_TO_ALBUM_1`
    FOREIGN KEY (`family_id`)
    REFERENCES `sai`.`family` (`family_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`album_media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`album_media` ;

CREATE TABLE IF NOT EXISTS `sai`.`album_media` (
  `album_media_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `album_id` BIGINT(20) NOT NULL,
  `album_media_thumbnail` VARCHAR(255) NULL DEFAULT NULL,
  `album_media_thumb_server` VARCHAR(255) NULL DEFAULT NULL,
  `album_media_path` VARCHAR(255) NULL DEFAULT NULL,
  `album_media_path_server` VARCHAR(255) NULL DEFAULT NULL,
  `album_media_original_name` VARCHAR(255) NULL DEFAULT NULL,
  `album_media_type` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`album_media_id`),
  INDEX `FK_ALBUM_TO_MEDIA_1` (`album_id` ASC),
  CONSTRAINT `FK_ALBUM_TO_MEDIA_1`
    FOREIGN KEY (`album_id`)
    REFERENCES `sai`.`album` (`album_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`user` ;

CREATE TABLE IF NOT EXISTS `sai`.`user` (
  `user_id` VARCHAR(20) NOT NULL,
  `family_id` VARCHAR(10) NULL DEFAULT NULL,
  `user_name` VARCHAR(10) NULL DEFAULT NULL,
  `email` VARCHAR(30) NULL DEFAULT NULL unique,
  `password` VARCHAR(100) NULL DEFAULT NULL,
  `user_type` VARCHAR(30) NULL DEFAULT NULL,
  `birthday` DATE NULL DEFAULT NULL,
  `lunar` TINYINT(1) NULL DEFAULT NULL,
  `user_image_path` VARCHAR(255) NULL DEFAULT NULL,
  `user_image_path_server` VARCHAR(255) NULL DEFAULT NULL,
  `user_image_name` VARCHAR(255) NULL DEFAULT NULL,
  `user_image_type` VARCHAR(10) NULL DEFAULT NULL,
  `user_message` VARCHAR(255) NULL DEFAULT NULL,
  `role` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  INDEX `FK_FAMILY_TO_USER_1` (`family_id` ASC),
  CONSTRAINT `FK_FAMILY_TO_USER_1`
    FOREIGN KEY (`family_id`)
    REFERENCES `sai`.`family` (`family_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`board`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`board` ;

CREATE TABLE IF NOT EXISTS `sai`.`board` (
  `board_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `family_id` VARCHAR(10) NOT NULL,
  `user_id` VARCHAR(20) NOT NULL,
  `board_reg_datetime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  `board_content` VARCHAR(1000) NULL DEFAULT NULL,
  `board_like_cnt` INT(11) NULL DEFAULT 0,
  `board_reply_cnt` INT(11) NULL DEFAULT 0,
  `board_date` DATE NULL DEFAULT NULL,
  `board_location` VARCHAR(40) NULL DEFAULT NULL,
  `board_tagged_yn` TINYINT(1) NULL DEFAULT NULL,
  `board_media_yn` TINYINT(1) NULL DEFAULT NULL,
  `poll_yn` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`board_id`),
  INDEX `FK_FAMILY_TO_BOARD_1` (`family_id` ASC),
  INDEX `FK_USER_TO_BOARD_1` (`user_id` ASC),
  CONSTRAINT `FK_FAMILY_TO_BOARD_1`
    FOREIGN KEY (`family_id`)
    REFERENCES `sai`.`family` (`family_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_USER_TO_BOARD_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`board_like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`board_like` ;

CREATE TABLE IF NOT EXISTS `sai`.`board_like` (
  `board_like_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `board_id` BIGINT(20) NOT NULL,
  `user_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`board_like_id`),
  INDEX `FK_BOARD_TO_REACTION_1` (`board_id` ASC),
  INDEX `fk_board_like_user1_idx` (`user_id` ASC),
  CONSTRAINT `unique_boardId_userId`
    unique (board_id, user_id),
  CONSTRAINT `FK_BOARD_TO_REACTION_1`
    FOREIGN KEY (`board_id`)
    REFERENCES `sai`.`board` (`board_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_board_like_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`board_media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`board_media` ;

CREATE TABLE IF NOT EXISTS `sai`.`board_media` (
  `board_media_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `board_id` BIGINT(20) NOT NULL,
  `board_media_thumbnail` VARCHAR(255) NULL DEFAULT NULL,
  `board_media_thumb_server` VARCHAR(255) NULL DEFAULT NULL,
  `board_media_path` VARCHAR(255) NULL DEFAULT NULL,
  `board_media_path_server` VARCHAR(255) NULL DEFAULT NULL,
  `board_media_original_name` VARCHAR(255) NULL DEFAULT NULL,
  `board_media_type` VARCHAR(10) NULL DEFAULT NULL,
  PRIMARY KEY (`board_media_id`),
  INDEX `FK_BOARD_TO_BOARD_MEDIA_1` (`board_id` ASC),
  CONSTRAINT `FK_BOARD_TO_BOARD_MEDIA_1`
    FOREIGN KEY (`board_id`)
    REFERENCES `sai`.`board` (`board_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`board_tagged`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`board_tagged` ;

CREATE TABLE IF NOT EXISTS `sai`.`board_tagged` (
  `board_tagged_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `board_id` BIGINT(20) NOT NULL,
  `user_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`board_tagged_id`),
  INDEX `FK_BOARD_TO_BOARD_TAGGED_1` (`board_id` ASC),
  INDEX `fk_board_tagged_user1_idx` (`user_id` ASC),
  CONSTRAINT `FK_BOARD_TO_BOARD_TAGGED_1`
    FOREIGN KEY (`board_id`)
    REFERENCES `sai`.`board` (`board_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_board_tagged_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`poll`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`poll` ;

CREATE TABLE IF NOT EXISTS `sai`.`poll` (
  `poll_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME(6) NOT NULL,
  `updated_at` DATETIME(6) NOT NULL,
  `created_by` VARCHAR(255) NULL DEFAULT NULL,
  `updated_by` VARCHAR(255) NULL DEFAULT NULL,
  `poll_end_datetime` DATETIME(6) NULL DEFAULT NULL,
  `poll_title` VARCHAR(255) NULL DEFAULT NULL,
  `board_id` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`poll_id`),
  INDEX `FK_BOARD_TO_POLL_1` (`board_id` ASC),
  CONSTRAINT `FK_BOARD_TO_POLL_1`
    FOREIGN KEY (`board_id`)
    REFERENCES `sai`.`board` (`board_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`choice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`choice` ;

CREATE TABLE IF NOT EXISTS `sai`.`choice` (
  `choice_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(40) NULL DEFAULT NULL,
  `poll_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`choice_id`),
  INDEX `fk_choices_poll1_idx` (`poll_id` ASC),
  CONSTRAINT `fk_choices_poll1`
    FOREIGN KEY (`poll_id`)
    REFERENCES `sai`.`poll` (`poll_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`family_callsign`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`family_callsign` ;

CREATE TABLE IF NOT EXISTS `sai`.`family_callsign` (
  `family_callsign_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `from_user_id` VARCHAR(20) NOT NULL,
  `to_user_id` VARCHAR(20) NOT NULL,
  `callsign` VARCHAR(30) NULL DEFAULT NULL,
  PRIMARY KEY (`family_callsign_id`),
  INDEX `fk_family_callsign_user1_idx` (`from_user_id` ASC),
  INDEX `fk_family_callsign_user2_idx` (`to_user_id` ASC),
  CONSTRAINT `fk_family_callsign_user1`
    FOREIGN KEY (`from_user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_family_callsign_user2`
    FOREIGN KEY (`to_user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`family_register`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`family_register` ;

CREATE TABLE IF NOT EXISTS `sai`.`family_register` (
  `family_register_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `family_id` VARCHAR(10) NOT NULL,
  `user_id` VARCHAR(20) NOT NULL unique,
  `approve_yn` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`family_register_id`),
  INDEX `FK_FAMILY_TO_FAMILY_REGISTER_1` (`family_id` ASC),
  INDEX `FK_USER_TO_FAMILY_REGISTER_1` (`user_id` ASC),
  CONSTRAINT `FK_FAMILY_TO_FAMILY_REGISTER_1`
    FOREIGN KEY (`family_id`)
    REFERENCES `sai`.`family` (`family_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_USER_TO_FAMILY_REGISTER_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`main_plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`main_plan` ;

CREATE TABLE IF NOT EXISTS `sai`.`main_plan` (
  `main_plan_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `family_id` VARCHAR(10) NOT NULL,
  `user_id` VARCHAR(20) NOT NULL,
  `plan_title` VARCHAR(255) NULL DEFAULT NULL,
  `plan_type` VARCHAR(255) NULL DEFAULT NULL,
  `all_day_yn` TINYINT(1) NULL DEFAULT NULL,
  `main_plan_start_datetime` DATETIME NULL DEFAULT NULL,
  `main_plan_end_datetime` DATETIME NULL DEFAULT NULL,
  `plan_place` VARCHAR(255) NULL DEFAULT NULL,
  `plan_noti_yn` TINYINT(1) NULL DEFAULT NULL,
  `plan_routine_day` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`main_plan_id`),
  INDEX `fk_main_plan_family1_idx` (`family_id` ASC),
  INDEX `fk_main_plan_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_main_plan_family1`
    FOREIGN KEY (`family_id`)
    REFERENCES `sai`.`family` (`family_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_main_plan_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`memo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`memo` ;

CREATE TABLE IF NOT EXISTS `sai`.`memo` (
  `memo_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `family_id` VARCHAR(10) NOT NULL,
  `user_id` VARCHAR(20) NULL DEFAULT NULL,
  `memo_reg_datetime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  `color` VARCHAR(100) NULL DEFAULT NULL,
  `memo_content` VARCHAR(255) NOT NULL,
  `read_list` VARCHAR(255) NULL,
  PRIMARY KEY (`memo_id`),
  INDEX `FK_USER_TO_MEMO_1` (`user_id` ASC),
  INDEX `FK_FAMILY_TO_MEMO_1` (`family_id` ASC),
  CONSTRAINT `FK_FAMILY_TO_MEMO_1`
    FOREIGN KEY (`family_id`)
    REFERENCES `sai`.`family` (`family_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_USER_TO_MEMO_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`notification`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`notification` ;

CREATE TABLE IF NOT EXISTS `sai`.`notification` (
  `noti_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `noti_to_user_id` VARCHAR(20) NOT NULL,
  `noti_from_user_id` VARCHAR(20) NULL DEFAULT NULL,
  `noti_content` VARCHAR(255) NULL DEFAULT NULL,
  `noti_type` VARCHAR(20) NULL DEFAULT NULL,
  `noti_datetime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  `noti_read_yn` TINYINT(1) NULL DEFAULT NULL,
  `noti_content_id` BIGINT(20) NULL DEFAULT NULL,
  PRIMARY KEY (`noti_id`),
  INDEX `FK_USER_TO_Notification_1` (`noti_to_user_id` ASC),
  INDEX `fk_notification_user1_idx` (`noti_from_user_id` ASC),
  CONSTRAINT `FK_USER_TO_Notification_1`
    FOREIGN KEY (`noti_to_user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_notification_user1`
    FOREIGN KEY (`noti_from_user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`reply`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`reply` ;

CREATE TABLE IF NOT EXISTS `sai`.`reply` (
  `reply_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `board_id` BIGINT(20) NOT NULL,
  `reply_user_id` VARCHAR(20) NOT NULL,
  `reply_content` VARCHAR(200) NOT NULL,
  `reply_reg_datetime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`reply_id`),
  INDEX `FK_BOARD_TO_REPLY_1` (`board_id` ASC),
  INDEX `fk_reply_user1_idx` (`reply_user_id` ASC),
  CONSTRAINT `FK_BOARD_TO_REPLY_1`
    FOREIGN KEY (`board_id`)
    REFERENCES `sai`.`board` (`board_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reply_user1`
    FOREIGN KEY (`reply_user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `sai`.`vote`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sai`.`vote` ;

CREATE TABLE IF NOT EXISTS `sai`.`vote` (
  `vote_id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `choice_id` BIGINT(20) NOT NULL,
  `poll_id` BIGINT(20) NOT NULL,
  `user_id` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`vote_id`),
--   UNIQUE INDEX `unique_pollId_userId` (`poll_id` ASC, `user_id` ASC),
  CONSTRAINT `unique_pollId_userId`
    unique (poll_id, user_id),
  INDEX `fk_votes_choices1_idx` (`choice_id` ASC),
  INDEX `fk_votes_poll1_idx` (`poll_id` ASC),
  INDEX `fk_votes_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_votes_choices1`
    FOREIGN KEY (`choice_id`)
    REFERENCES `sai`.`choice` (`choice_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_votes_poll1`
    FOREIGN KEY (`poll_id`)
    REFERENCES `sai`.`poll` (`poll_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_votes_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `sai`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

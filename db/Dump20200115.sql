CREATE DATABASE  IF NOT EXISTS `UNO` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `UNO`;
-- MySQL dump 10.13  Distrib 5.7.28, for Linux (x86_64)
--
-- Host: localhost    Database: UNO
-- ------------------------------------------------------
-- Server version	5.7.28-0ubuntu0.16.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BOARDS`
--

DROP TABLE IF EXISTS `BOARDS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BOARDS` (
  `BOARD_ID` int(10) NOT NULL DEFAULT '0',
  `LAST_CHANGE` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ACTIVE_COLOR` char(1) DEFAULT 'R',
  `CURRENT_PLAYERS` tinyint(1) DEFAULT '0',
  `MAX_PLAYERS` tinyint(1) NOT NULL DEFAULT '4',
  `ACTIVE_PLAYER_TOKEN` varchar(32) NOT NULL DEFAULT 'NA',
  `BOARD_STATE` enum('WAITING FOR PLAYERS','STARTED','ENDED') NOT NULL DEFAULT 'WAITING FOR PLAYERS',
  `ROTATION` enum('C','CC') NOT NULL DEFAULT 'C',
  PRIMARY KEY (`BOARD_ID`),
  UNIQUE KEY `BOARD_ID_UNIQUE` (`BOARD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `BOARDS`
--

LOCK TABLES `BOARDS` WRITE;
/*!40000 ALTER TABLE `BOARDS` DISABLE KEYS */;
INSERT INTO `BOARDS` VALUES (0,'2020-01-15 21:05:48','R',0,4,'NA','WAITING FOR PLAYERS','C');
/*!40000 ALTER TABLE `BOARDS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `DECK`
--

DROP TABLE IF EXISTS `DECK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DECK` (
  `COLOR` char(1) NOT NULL,
  `NUMBER` tinyint(1) NOT NULL,
  `DECK_NUM` tinyint(1) NOT NULL,
  PRIMARY KEY (`COLOR`,`NUMBER`,`DECK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DECK`
--

LOCK TABLES `DECK` WRITE;
/*!40000 ALTER TABLE `DECK` DISABLE KEYS */;
INSERT INTO `DECK` VALUES ('+',1,1),('+',2,2),('+',3,1),('+',4,2),('B',0,1),('B',1,1),('B',1,2),('B',2,1),('B',2,2),('B',3,1),('B',3,2),('B',4,1),('B',4,2),('B',5,1),('B',5,2),('B',6,1),('B',6,2),('B',7,1),('B',7,2),('B',8,1),('B',8,2),('B',9,1),('B',9,2),('B',10,1),('B',10,2),('B',11,1),('B',11,2),('B',12,1),('B',12,2),('C',1,1),('C',2,2),('C',3,1),('C',4,2),('G',0,1),('G',1,1),('G',1,2),('G',2,1),('G',2,2),('G',3,1),('G',3,2),('G',4,1),('G',4,2),('G',5,1),('G',5,2),('G',6,1),('G',6,2),('G',7,1),('G',7,2),('G',8,1),('G',8,2),('G',9,1),('G',9,2),('G',10,1),('G',10,2),('G',11,1),('G',11,2),('G',12,1),('G',12,2),('P',0,1),('P',1,1),('P',1,2),('P',2,1),('P',2,2),('P',3,1),('P',3,2),('P',4,1),('P',4,2),('P',5,1),('P',5,2),('P',6,1),('P',6,2),('P',7,1),('P',7,2),('P',8,1),('P',8,2),('P',9,1),('P',9,2),('P',10,1),('P',10,2),('P',11,1),('P',11,2),('P',12,1),('P',12,2),('R',0,1),('R',1,1),('R',1,2),('R',2,1),('R',2,2),('R',3,1),('R',3,2),('R',4,1),('R',4,2),('R',5,1),('R',5,2),('R',6,1),('R',6,2),('R',7,1),('R',7,2),('R',8,1),('R',8,2),('R',9,1),('R',9,2),('R',10,1),('R',10,2),('R',11,1),('R',11,2),('R',12,1),('R',12,2);
/*!40000 ALTER TABLE `DECK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `HANDS`
--

DROP TABLE IF EXISTS `HANDS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HANDS` (
  `BOARD_ID` int(10) NOT NULL,
  `USER_TOKEN` varchar(32) NOT NULL DEFAULT 'NA',
  `COLOR` char(1) NOT NULL DEFAULT 'N',
  `NUMBER` tinyint(1) NOT NULL DEFAULT '0',
  `DECK_NUM` tinyint(1) NOT NULL DEFAULT '0',
  `VALID` enum('YES','NO') NOT NULL DEFAULT 'NO',
  PRIMARY KEY (`BOARD_ID`,`USER_TOKEN`,`COLOR`,`NUMBER`,`DECK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HANDS`
--

LOCK TABLES `HANDS` WRITE;
/*!40000 ALTER TABLE `HANDS` DISABLE KEYS */;
INSERT INTO `HANDS` VALUES (0,'NA','+',1,1,'NO'),(0,'NA','+',2,2,'NO'),(0,'NA','+',3,1,'NO'),(0,'NA','+',4,2,'NO'),(0,'NA','B',0,1,'NO'),(0,'NA','B',1,1,'NO'),(0,'NA','B',1,2,'NO'),(0,'NA','B',2,1,'NO'),(0,'NA','B',2,2,'NO'),(0,'NA','B',3,1,'NO'),(0,'NA','B',3,2,'NO'),(0,'NA','B',4,1,'NO'),(0,'NA','B',4,2,'NO'),(0,'NA','B',5,1,'NO'),(0,'NA','B',5,2,'NO'),(0,'NA','B',6,1,'NO'),(0,'NA','B',6,2,'NO'),(0,'NA','B',7,1,'NO'),(0,'NA','B',7,2,'NO'),(0,'NA','B',8,1,'NO'),(0,'NA','B',8,2,'NO'),(0,'NA','B',9,1,'NO'),(0,'NA','B',9,2,'NO'),(0,'NA','B',10,1,'NO'),(0,'NA','B',10,2,'NO'),(0,'NA','B',11,1,'NO'),(0,'NA','B',11,2,'NO'),(0,'NA','B',12,1,'NO'),(0,'NA','B',12,2,'NO'),(0,'NA','C',1,1,'NO'),(0,'NA','C',2,2,'NO'),(0,'NA','C',3,1,'NO'),(0,'NA','C',4,2,'NO'),(0,'NA','G',0,1,'NO'),(0,'NA','G',1,1,'NO'),(0,'NA','G',1,2,'NO'),(0,'NA','G',2,1,'NO'),(0,'NA','G',2,2,'NO'),(0,'NA','G',3,1,'NO'),(0,'NA','G',3,2,'NO'),(0,'NA','G',4,1,'NO'),(0,'NA','G',4,2,'NO'),(0,'NA','G',5,1,'NO'),(0,'NA','G',5,2,'NO'),(0,'NA','G',6,1,'NO'),(0,'NA','G',6,2,'NO'),(0,'NA','G',7,1,'NO'),(0,'NA','G',7,2,'NO'),(0,'NA','G',8,1,'NO'),(0,'NA','G',8,2,'NO'),(0,'NA','G',9,1,'NO'),(0,'NA','G',9,2,'NO'),(0,'NA','G',10,1,'NO'),(0,'NA','G',10,2,'NO'),(0,'NA','G',11,1,'NO'),(0,'NA','G',11,2,'NO'),(0,'NA','G',12,1,'NO'),(0,'NA','G',12,2,'NO'),(0,'NA','P',0,1,'NO'),(0,'NA','P',1,1,'NO'),(0,'NA','P',1,2,'NO'),(0,'NA','P',2,1,'NO'),(0,'NA','P',2,2,'NO'),(0,'NA','P',3,1,'NO'),(0,'NA','P',3,2,'NO'),(0,'NA','P',4,1,'NO'),(0,'NA','P',4,2,'NO'),(0,'NA','P',5,1,'NO'),(0,'NA','P',5,2,'NO'),(0,'NA','P',6,1,'NO'),(0,'NA','P',6,2,'NO'),(0,'NA','P',7,1,'NO'),(0,'NA','P',7,2,'NO'),(0,'NA','P',8,1,'NO'),(0,'NA','P',8,2,'NO'),(0,'NA','P',9,1,'NO'),(0,'NA','P',9,2,'NO'),(0,'NA','P',10,1,'NO'),(0,'NA','P',10,2,'NO'),(0,'NA','P',11,1,'NO'),(0,'NA','P',11,2,'NO'),(0,'NA','P',12,1,'NO'),(0,'NA','P',12,2,'NO'),(0,'NA','R',0,1,'NO'),(0,'NA','R',1,1,'NO'),(0,'NA','R',1,2,'NO'),(0,'NA','R',2,1,'NO'),(0,'NA','R',2,2,'NO'),(0,'NA','R',3,1,'NO'),(0,'NA','R',3,2,'NO'),(0,'NA','R',4,1,'NO'),(0,'NA','R',4,2,'NO'),(0,'NA','R',5,1,'NO'),(0,'NA','R',5,2,'NO'),(0,'NA','R',6,1,'NO'),(0,'NA','R',6,2,'NO'),(0,'NA','R',7,1,'NO'),(0,'NA','R',7,2,'NO'),(0,'NA','R',8,1,'NO'),(0,'NA','R',8,2,'NO'),(0,'NA','R',9,1,'NO'),(0,'NA','R',9,2,'NO'),(0,'NA','R',10,1,'NO'),(0,'NA','R',10,2,'NO'),(0,'NA','R',11,1,'NO'),(0,'NA','R',11,2,'NO'),(0,'NA','R',12,1,'NO'),(0,'NA','R',12,2,'NO');
/*!40000 ALTER TABLE `HANDS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TURNS`
--

DROP TABLE IF EXISTS `TURNS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TURNS` (
  `BOARD_ID` int(10) NOT NULL DEFAULT '0',
  `USER_TOKEN` varchar(32) NOT NULL,
  `ALLOWED` enum('YES','NO') NOT NULL DEFAULT 'NO',
  `TURN_NUMBER` tinyint(1) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`TURN_NUMBER`,`BOARD_ID`,`USER_TOKEN`),
  KEY `USER_TOKEN` (`USER_TOKEN`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TURNS`
--

LOCK TABLES `TURNS` WRITE;
/*!40000 ALTER TABLE `TURNS` DISABLE KEYS */;
INSERT INTO `TURNS` VALUES (0,'30b1efcee97e5ad4f1b6ddf9668307cb','NO',16);
/*!40000 ALTER TABLE `TURNS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS`
--

DROP TABLE IF EXISTS `USERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USERS` (
  `USER_TOKEN` varchar(32) NOT NULL,
  `USER_NAME` varchar(45) NOT NULL,
  `USER_TIME_STAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`USER_NAME`),
  UNIQUE KEY `USER_TOKEN_UNIQUE` (`USER_TOKEN`),
  UNIQUE KEY `USER_NAME_UNIQUE` (`USER_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
INSERT INTO `USERS` VALUES ('c10464678d72cf3c51d2657fe4fcc172','dimitris','2020-01-15 20:09:17'),('a4bd381166fd4dad331a39721d78695f','george','2020-01-15 20:11:12'),('5df2495bed110321d940c4d776d7de10','Jim','2020-01-15 18:51:14'),('d3a6841d2d9e9762952519a9bed9a6a0','jojo','2020-01-15 20:09:08'),('30b1efcee97e5ad4f1b6ddf9668307cb','mike','2020-01-15 19:59:44'),('NA','NA','2020-01-15 14:34:04'),('d291c2a0b9075c1bd01a576692b30b01','Sarantis','2020-01-15 14:12:38'),('e3974a22a5fbf5f2d34b680f68438734','test','2020-01-15 18:42:30'),('632ab316da8254bd1b672bce8c70574e','Tim','2020-01-15 14:07:30'),('36957abd1125613f4bbcbc859ab3c2a3','tomy','2020-01-15 15:54:43'),('TOP_CARD','TOP_CARD','2019-12-28 06:56:48');
/*!40000 ALTER TABLE `USERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'UNO'
--

--
-- Dumping routines for database 'UNO'
--
/*!50003 DROP PROCEDURE IF EXISTS `GET_FROM_BOARD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_FROM_BOARD`(
	IN 	column_var VARCHAR(20)
)
BEGIN
	CASE column_var 
		WHEN 'ACTIVE_COLOR' THEN SELECT ACTIVE_COLOR FROM BOARDS;
        WHEN 'ROTATION' THEN SELECT ROTATION FROM BOARDS;
        WHEN 'BOARD_STATE' THEN SELECT BOARD_STATE FROM BOARDS;
        WHEN 'CURRENT_PLAYERS' THEN SELECT CURRENT_PLAYERS FROM BOARDS;
        ELSE SELECT 'NO MATCHING COLUMN FOUND';
        END CASE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GET_HAND` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_HAND`(
	IN userToken VARCHAR(32)
)
BEGIN
	SELECT * FROM HANDS WHERE USER_TOKEN = userToken;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GET_PLAYERS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_PLAYERS`(
	IN rotation VARCHAR(2)
)
BEGIN
	IF rotation = 'C' THEN
		SELECT TURN_NUMBER,ALLOWED,USER_NAME,USER_TIME_STAMP,TURNS.USER_TOKEN 
		FROM TURNS INNER JOIN USERS ON TURNS.USER_TOKEN = USERS.USER_TOKEN 
		ORDER BY TURN_NUMBER ASC;
    ELSEIF rotation = 'CC' THEN
		SELECT TURN_NUMBER,ALLOWED,USER_NAME,USER_TIME_STAMP,TURNS.USER_TOKEN 
		FROM TURNS INNER JOIN USERS ON TURNS.USER_TOKEN = USERS.USER_TOKEN 
		ORDER BY TURN_NUMBER DESC;
	ELSE
		SELECT COUNT(TURNS.USER_TOKEN) AS NUM_OF_CARDS,ALLOWED,USER_NAME,USER_TIME_STAMP,TURNS.USER_TOKEN 
		FROM ((TURNS INNER JOIN USERS ON TURNS.USER_TOKEN = USERS.USER_TOKEN) 
		INNER JOIN HANDS ON HANDS.USER_TOKEN = TURNS.USER_TOKEN)
		GROUP BY ALLOWED,USER_NAME,USER_TIME_STAMP,TURNS.USER_TOKEN ;
		END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GET_RANDOM_CARD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GET_RANDOM_CARD`()
BEGIN
	SELECT COLOR, NUMBER, DECK_NUM FROM HANDS 
    WHERE USER_TOKEN = 'NA' ORDER BY RAND() LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `INVALIDATE_ALL` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `INVALIDATE_ALL`(
	IN table_var VARCHAR(20)
)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    CASE table_var 
		WHEN 'HANDS' THEN UPDATE HANDS SET VALID = 2;
        WHEN 'TURNS' THEN UPDATE TURNS SET ALLOWED = 2;
		ELSE SELECT 'NO MATCHING COLUMN FOUND';
        END CASE;
		SET SQL_SAFE_UPDATES = 1;
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RESET_BOARDS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RESET_BOARDS`()
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    DELETE FROM BOARDS;
    SET SQL_SAFE_UPDATES = 1;
	INSERT INTO BOARDS(BOARD_STATE) VALUES('WAITING FOR PLAYERS');
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RESET_HANDS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RESET_HANDS`()
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	DELETE FROM HANDS;
	INSERT INTO HANDS(BOARD_ID,COLOR,NUMBER,DECK_NUM) 
    SELECT 0,COLOR,NUMBER,DECK_NUM FROM DECK;
	SET SQL_SAFE_UPDATES = 1;
	COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `RESET_TURNS` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `RESET_TURNS`()
BEGIN
	SET SQL_SAFE_UPDATES = 0;
    DELETE FROM TURNS;
    SET SQL_SAFE_UPDATES = 1;
    
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SET_BOARD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SET_BOARD`(
	IN table_var VARCHAR(20),
    IN value_var VARCHAR(20)
)
BEGIN
	DECLARE rotation_var VARCHAR(2);
	SET SQL_SAFE_UPDATES = 0;
	
    CASE table_var
		WHEN 'ROTATION' THEN 
			IF value_var = 'C' 	THEN
					UPDATE BOARDS SET ROTATION = 'C';
				ELSEIF value_var = 'CC' THEN 
					UPDATE BOARDS SET ROTATION = 'CC';
				ELSE 
			SELECT ROTATION INTO rotation_var FROM BOARDS;
			IF rotation_var = 'C' THEN
			UPDATE BOARDS SET ROTATION = 'CC';
			ELSE
			UPDATE BOARDS SET ROTATION = 'C';
			END IF;
            END IF;
		WHEN 'ACTIVE_COLOR' THEN
			UPDATE BOARDS 
			SET ACTIVE_COLOR = CAST(value_var AS CHAR);
		WHEN 'CURRENT_PLAYERS' THEN
			UPDATE BOARDS
            SET CURRENT_PLAYERS = CAST(value_var AS SIGNED);
		WHEN 'BOARD_STATE' THEN
			UPDATE BOARDS
            SET BOARD_STATE = CAST(value_var AS CHAR);
        ELSE SELECT 'NO MATCHING COLUMN FOUND';
        END CASE;
        SET SQL_SAFE_UPDATES = 1;
        COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SET_CARD` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SET_CARD`(
	IN userToken VARCHAR(32),
    IN color_var CHAR(1),
    IN number_var TINYINT(1),
    IN deckNum TINYINT(1)
)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
	UPDATE HANDS SET USER_TOKEN = userToken 
    WHERE COLOR = color_var 
    AND NUMBER = number_var 
    AND DECK_NUM = deckNum;
    SET SQL_SAFE_UPDATES = 1;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SET_CARD_VALID` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SET_CARD_VALID`(
	IN userToken VARCHAR(32),
    IN color_var CHAR(1),
    IN number_var TINYINT(1),
    IN deckNum TINYINT(1),
    IN valid VARCHAR(3)
)
BEGIN
SET SQL_SAFE_UPDATES = 0;
	UPDATE HANDS 
    SET VALID = valid
    WHERE USER_TOKEN = userToken 
    AND COLOR = color_var 
    AND NUMBER = number_var 
    AND DECK_NUM = deckNum;
SET SQL_SAFE_UPDATES = 1;
COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SET_PLAYER_ALLOWED` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SET_PLAYER_ALLOWED`(
	IN userToken VARCHAR(45),
    IN allowed_param ENUM('YES','NO')
)
BEGIN
	SET SQL_SAFE_UPDATES = 0;
		UPDATE TURNS SET 
		ALLOWED = allowed_param 
		WHERE USER_TOKEN =userToken;
		SET SQL_SAFE_UPDATES = 1;
    COMMIT;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SIGN_IN` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SIGN_IN`(
	IN userName VARCHAR(45)
)
BEGIN
DECLARE userToken VARCHAR(32);
	
	SELECT USER_TOKEN
	INTO userToken FROM
    USERS WHERE
    USER_NAME = userName;

	INSERT INTO TURNS (BOARD_ID, USER_TOKEN, ALLOWED)
	SELECT 0,USER_TOKEN,'NO' FROM USERS 
    WHERE USER_TOKEN = userToken
	AND NOT EXISTS
    (SELECT 0,USER_TOKEN,'NO' FROM TURNS 
    WHERE USER_TOKEN = userToken);
    
    SELECT 0,USER_TOKEN,'NO' FROM TURNS 
    WHERE USER_TOKEN = userToken;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SIGN_UP` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SIGN_UP`(
	IN userName VARCHAR(45)
)
BEGIN
	INSERT INTO USERS 
    (USER_TOKEN,USER_NAME,USER_TIME_STAMP) 
    VALUES (MD5(CONCAT(userName,NOW())),userName,CURRENT_TIMESTAMP);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UPDATE_USER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `UPDATE_USER`(
	IN userToken VARCHAR(45)
)
BEGIN
	UPDATE USERS SET USER_TIME_STAMP = CURRENT_TIMESTAMP() WHERE USER_TOKEN = userToken ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-01-15 23:09:31

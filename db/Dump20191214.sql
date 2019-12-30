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
-- Table structure for table `MASTER_DECK`
--

DROP TABLE IF EXISTS `MASTER_DECK`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MASTER_DECK` (
  `COLOR` char(1) NOT NULL,
  `NUMBER` tinyint(1) NOT NULL,
  `DECK_NUM` tinyint(1) NOT NULL,
  PRIMARY KEY (`COLOR`,`NUMBER`,`DECK_NUM`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MASTER_DECK`
--

LOCK TABLES `MASTER_DECK` WRITE;
/*!40000 ALTER TABLE `MASTER_DECK` DISABLE KEYS */;
INSERT INTO `MASTER_DECK` VALUES ('+',1,1),('+',2,2),('+',3,1),('+',4,2),('B',0,1),('B',1,1),('B',1,2),('B',2,1),('B',2,2),('B',3,1),('B',3,2),('B',4,1),('B',4,2),('B',5,1),('B',5,2),('B',6,1),('B',6,2),('B',7,1),('B',7,2),('B',8,1),('B',8,2),('B',9,1),('B',9,2),('B',10,1),('B',10,2),('B',11,1),('B',11,2),('B',12,1),('B',12,2),('C',1,1),('C',2,2),('C',3,1),('C',4,2),('G',0,1),('G',1,1),('G',1,2),('G',2,1),('G',2,2),('G',3,1),('G',3,2),('G',4,1),('G',4,2),('G',5,1),('G',5,2),('G',6,1),('G',6,2),('G',7,1),('G',7,2),('G',8,1),('G',8,2),('G',9,1),('G',9,2),('G',10,1),('G',10,2),('G',11,1),('G',11,2),('G',12,1),('G',12,2),('R',0,1),('R',1,1),('R',1,2),('R',2,1),('R',2,2),('R',3,1),('R',3,2),('R',4,1),('R',4,2),('R',5,1),('R',5,2),('R',6,1),('R',6,2),('R',7,1),('R',7,2),('R',8,1),('R',8,2),('R',9,1),('R',9,2),('R',10,1),('R',10,2),('R',11,1),('R',11,2),('R',12,1),('R',12,2),('Y',0,1),('Y',1,1),('Y',1,2),('Y',2,1),('Y',2,2),('Y',3,1),('Y',3,2),('Y',4,1),('Y',4,2),('Y',5,1),('Y',5,2),('Y',6,1),('Y',6,2),('Y',7,1),('Y',7,2),('Y',8,1),('Y',8,2),('Y',9,1),('Y',9,2),('Y',10,1),('Y',10,2),('Y',11,1),('Y',11,2),('Y',12,1),('Y',12,2);
/*!40000 ALTER TABLE `MASTER_DECK` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `USERS`
--

DROP TABLE IF EXISTS `USERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `USERS` (
  `USER_TOKEN` varchar(100) NOT NULL,
  `USER_NAME` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`USER_TOKEN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `USERS`
--

LOCK TABLES `USERS` WRITE;
/*!40000 ALTER TABLE `USERS` DISABLE KEYS */;
INSERT INTO `USERS` VALUES ('06a1ec57fafd89c0828f7223b0691c82','dfs'),('200c456fd6bc45a3e6be9184f685ea58','jack'),('29e2e4084652f64e708ef4bccf583f7b','jack'),('5d15ba0e02a6d2c6aea61b2084659c00','dfs'),('638529a8e02b41f2db7876f49983cea1','jack'),('6d4c04aa40801bb7a4160b7a68d74282','dfs'),('6e0bfee968736abe4ab0b6802864b45c','this is a test '),('818df7b44c3890e42447c9a18a3eff4d','jack'),('a4c1cdceb02b8fe402a150fb827d49ea','TESWQF'),('dd516d4d228f1ecbd2b8e63fee6aac70','jack'),('de4b7571d3a9bd5589704e05802fcaca','dfs'),('e297c54b84f60b125e0af8ea2e273c44','TESWQF'),('f5a10aa160ba1a2be21a837fa1a199f8','sarantis');
/*!40000 ALTER TABLE `USERS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'UNO'
--

--
-- Dumping routines for database 'UNO'
--
/*!50003 DROP PROCEDURE IF EXISTS `ADD_USER` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ADD_USER`(
	IN userName VARCHAR(45)
)
BEGIN
	INSERT INTO `UNO`.`USERS` (`USER_TOKEN`,`USER_NAME`) VALUES (MD5(CONCAT(userName,NOW())),userName);
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

-- Dump completed on 2019-12-14 21:38:19

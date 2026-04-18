/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-12.2.2-MariaDB, for osx10.19 (x86_64)
--
-- Host: 127.0.0.1    Database: mockOS
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB-1:11.3.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `MockProcesses`
--

DROP TABLE IF EXISTS `MockProcesses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `MockProcesses` (
  `Pid` int(11) NOT NULL AUTO_INCREMENT,
  `Image` longtext DEFAULT NULL,
  `Status` int(11) NOT NULL,
  `Args` longtext DEFAULT NULL,
  `ExitCode` int(11) NOT NULL,
  `Priority` int(11) DEFAULT NULL,
  `Handle` int(11) NOT NULL,
  `FileDescriptors` longtext DEFAULT NULL,
  `ErrorMessage` longtext DEFAULT NULL,
  `IsService` tinyint(1) NOT NULL DEFAULT 0,
  `CreationTime` datetime(6) DEFAULT NULL,
  `ExecutionTime` time(6) NOT NULL DEFAULT '00:00:00.000000',
  `UserUid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Pid`),
  KEY `IX_MockProcesses_UserUid` (`UserUid`),
  CONSTRAINT `FK_MockProcesses_User_UserUid` FOREIGN KEY (`UserUid`) REFERENCES `User` (`Uid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MockProcesses`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
/*!40000 ALTER TABLE `MockProcesses` DISABLE KEYS */;
INSERT INTO `MockProcesses` VALUES
(1,'/bin/bash',1,'[]',0,60,0,'[0,1,2]',NULL,0,'2024-06-04 15:46:28.590237','00:00:00.000000',1);
/*!40000 ALTER TABLE `MockProcesses` ENABLE KEYS */;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `MockThreadStacks`
--

DROP TABLE IF EXISTS `MockThreadStacks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `MockThreadStacks` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Stack` longtext NOT NULL,
  `Handle` int(11) NOT NULL,
  `CreationTime` datetime(6) DEFAULT NULL,
  `ErrorMessage` longtext DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MockThreadStacks`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
/*!40000 ALTER TABLE `MockThreadStacks` DISABLE KEYS */;
INSERT INTO `MockThreadStacks` VALUES
(1,'[]',0,NULL,NULL),
(2,'[]',0,NULL,NULL),
(5,'[]',0,NULL,NULL),
(6,'[]',0,NULL,NULL),
(13,'[]',0,NULL,NULL),
(14,'[]',0,NULL,NULL),
(15,'[]',0,NULL,NULL),
(17,'[]',0,NULL,NULL),
(20,'[]',0,NULL,NULL),
(24,'[]',0,NULL,NULL),
(29,'[]',0,NULL,NULL),
(30,'[]',0,NULL,NULL),
(31,'[]',0,NULL,NULL),
(32,'[]',0,NULL,NULL),
(41,'[]',0,NULL,NULL),
(51,'[]',0,NULL,NULL),
(52,'[]',0,NULL,NULL);
/*!40000 ALTER TABLE `MockThreadStacks` ENABLE KEYS */;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `MockThreads`
--

DROP TABLE IF EXISTS `MockThreads`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `MockThreads` (
  `Tid` int(11) NOT NULL AUTO_INCREMENT,
  `StartFunction` longtext DEFAULT NULL,
  `Status` int(11) NOT NULL,
  `Name` longtext DEFAULT NULL,
  `ExitCode` int(11) NOT NULL,
  `MockProcessId` int(11) NOT NULL,
  `Handle` int(11) NOT NULL,
  `CreationTime` datetime(6) DEFAULT NULL,
  `ErrorMessage` longtext DEFAULT NULL,
  `StackId` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`Tid`),
  KEY `IX_MockThreads_MockProcessId` (`MockProcessId`),
  KEY `IX_MockThreads_StackId` (`StackId`),
  CONSTRAINT `FK_MockThreads_MockProcesses_MockProcessId` FOREIGN KEY (`MockProcessId`) REFERENCES `MockProcesses` (`Pid`) ON DELETE CASCADE,
  CONSTRAINT `FK_MockThreads_MockThreadStacks_StackId` FOREIGN KEY (`StackId`) REFERENCES `MockThreadStacks` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MockThreads`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
/*!40000 ALTER TABLE `MockThreads` DISABLE KEYS */;
INSERT INTO `MockThreads` VALUES
(1,'testing',1,NULL,0,1,0,'2024-06-10 14:09:31.000061',NULL,15),
(2,'testing',1,NULL,0,1,0,'2024-06-10 14:11:05.756585',NULL,17),
(3,'testing',1,NULL,0,1,0,'2024-06-10 14:14:07.457805',NULL,20),
(4,'testing',1,NULL,0,1,0,'2024-06-10 14:24:53.943297',NULL,24),
(5,'testing',1,NULL,0,1,0,'2024-06-10 23:05:37.751994',NULL,29),
(6,'testing',1,NULL,0,1,0,'2024-06-10 23:05:38.243545',NULL,30),
(7,'testing',1,NULL,0,1,0,'2024-06-10 23:06:03.485570',NULL,31),
(8,'testing',1,NULL,0,1,0,'2024-06-10 23:06:05.069156',NULL,32),
(9,'testing',1,NULL,0,1,0,'2024-06-10 23:08:57.916584',NULL,41),
(10,'testing',1,NULL,0,1,0,'2024-06-10 23:10:07.682624',NULL,51),
(11,'testing',1,NULL,0,1,0,'2024-06-10 23:10:08.251020',NULL,52);
/*!40000 ALTER TABLE `MockThreads` ENABLE KEYS */;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `Uid` int(11) NOT NULL AUTO_INCREMENT,
  `Username` longtext DEFAULT NULL,
  `Password` longtext DEFAULT NULL,
  `Roles` longtext DEFAULT NULL,
  `CreatedAt` datetime(3) DEFAULT NULL,
  `UpdatedAt` datetime(3) DEFAULT NULL,
  `DeletedAt` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`Uid`),
  KEY `idx_User_deleted_at` (`DeletedAt`),
  KEY `idx_User_DeletedAt` (`DeletedAt`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES
(1,'admin','newPassword','[0]','0000-00-00 00:00:00.000','2026-04-17 12:56:36.286','2026-04-17 12:56:36.289'),
(2,'j0rdan0','newPassword','admin','0000-00-00 00:00:00.000','2026-04-17 12:58:02.651','2026-04-17 12:58:02.654'),
(3,'backup','newPassword','admin','2026-04-14 21:49:15.442','2026-04-17 12:55:43.711','2026-04-17 12:55:43.718'),
(4,'noservice','newPassword','guest','2026-04-14 21:52:18.996','2026-04-18 12:54:20.449','2026-04-18 12:58:58.529'),
(5,'guest','oldPass','guest','2026-04-14 22:06:02.038','2026-04-18 16:38:36.526',NULL),
(6,'rescue','password','guest','2026-04-15 13:12:03.475','2026-04-15 13:12:03.475','2026-04-18 16:47:51.004'),
(7,'cat','password','guest','2026-04-15 13:17:01.462','2026-04-15 13:17:01.462','2026-04-18 16:27:49.401'),
(17,'cat','password','guest','2026-04-17 12:55:43.715','2026-04-17 12:55:43.715','2026-04-18 16:27:52.394'),
(22,'j0rdan0','pass','','2026-04-18 13:46:44.771','2026-04-18 13:46:44.771',NULL),
(23,'admin','admin','Guest','2026-04-18 16:43:06.467','2026-04-18 16:43:06.467',NULL),
(24,'gigi','password','Guest','2026-04-18 16:43:26.464','2026-04-18 16:43:26.464',NULL),
(25,'constantin','testing','Administrator','2026-04-18 16:44:56.432','2026-04-18 16:45:03.495',NULL),
(26,'superman','super','Superadmin','2026-04-18 16:47:42.569','2026-04-18 16:47:42.569',NULL),
(27,'service','pass','','2026-04-18 19:14:51.292','2026-04-18 19:14:51.292','2026-04-18 19:15:17.580'),
(28,'noservice','passs','Guest','2026-04-18 19:15:27.609','2026-04-18 19:15:27.609',NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `__EFMigrationsHistory`
--

DROP TABLE IF EXISTS `__EFMigrationsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `__EFMigrationsHistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL,
  PRIMARY KEY (`MigrationId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `__EFMigrationsHistory`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
/*!40000 ALTER TABLE `__EFMigrationsHistory` DISABLE KEYS */;
INSERT INTO `__EFMigrationsHistory` VALUES
('20240409152229_ProcessEntity','8.0.3'),
('20240423130600_FixShit','8.0.3'),
('20240423131046_ProcessAddedId','8.0.3'),
('20240423153801_ProcessAddedFds','8.0.3'),
('20240423181820_ProcessAddedStuff','8.0.3'),
('20240604093154_MockThreadAdded2','8.0.3'),
('20240604134634_AddedMockThreadStack','8.0.3'),
('20240610114208_addedThreadsToProcess','8.0.3'),
('20240610114924_AddMockThreadConfiguration','8.0.3');
/*!40000 ALTER TABLE `__EFMigrationsHistory` ENABLE KEYS */;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime(3) DEFAULT NULL,
  `updated_at` datetime(3) DEFAULT NULL,
  `deleted_at` datetime(3) DEFAULT NULL,
  `username` longtext DEFAULT NULL,
  `password` longtext DEFAULT NULL,
  `roles` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_users_deleted_at` (`deleted_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

SET @OLD_AUTOCOMMIT=@@AUTOCOMMIT, @@AUTOCOMMIT=0;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
COMMIT;
SET AUTOCOMMIT=@OLD_AUTOCOMMIT;

--
-- Dumping routines for database 'mockOS'
--
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `POMELO_AFTER_ADD_PRIMARY_KEY` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `POMELO_AFTER_ADD_PRIMARY_KEY`(IN `SCHEMA_NAME_ARGUMENT` VARCHAR(255), IN `TABLE_NAME_ARGUMENT` VARCHAR(255), IN `COLUMN_NAME_ARGUMENT` VARCHAR(255))
BEGIN
	DECLARE HAS_AUTO_INCREMENT_ID INT(11);
	DECLARE PRIMARY_KEY_COLUMN_NAME VARCHAR(255);
	DECLARE PRIMARY_KEY_TYPE VARCHAR(255);
	DECLARE SQL_EXP VARCHAR(1000);
	SELECT COUNT(*)
		INTO HAS_AUTO_INCREMENT_ID
		FROM `information_schema`.`COLUMNS`
		WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
			AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
			AND `COLUMN_NAME` = COLUMN_NAME_ARGUMENT
			AND `COLUMN_TYPE` LIKE '%int%'
			AND `COLUMN_KEY` = 'PRI';
	IF HAS_AUTO_INCREMENT_ID THEN
		SELECT `COLUMN_TYPE`
			INTO PRIMARY_KEY_TYPE
			FROM `information_schema`.`COLUMNS`
			WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
				AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
				AND `COLUMN_NAME` = COLUMN_NAME_ARGUMENT
				AND `COLUMN_TYPE` LIKE '%int%'
				AND `COLUMN_KEY` = 'PRI';
		SELECT `COLUMN_NAME`
			INTO PRIMARY_KEY_COLUMN_NAME
			FROM `information_schema`.`COLUMNS`
			WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
				AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
				AND `COLUMN_NAME` = COLUMN_NAME_ARGUMENT
				AND `COLUMN_TYPE` LIKE '%int%'
				AND `COLUMN_KEY` = 'PRI';
		SET SQL_EXP = CONCAT('ALTER TABLE `', (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA())), '`.`', TABLE_NAME_ARGUMENT, '` MODIFY COLUMN `', PRIMARY_KEY_COLUMN_NAME, '` ', PRIMARY_KEY_TYPE, ' NOT NULL AUTO_INCREMENT;');
		SET @SQL_EXP = SQL_EXP;
		PREPARE SQL_EXP_EXECUTE FROM @SQL_EXP;
		EXECUTE SQL_EXP_EXECUTE;
		DEALLOCATE PREPARE SQL_EXP_EXECUTE;
	END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
/*!50003 DROP PROCEDURE IF EXISTS `POMELO_BEFORE_DROP_PRIMARY_KEY` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`%` PROCEDURE `POMELO_BEFORE_DROP_PRIMARY_KEY`(IN `SCHEMA_NAME_ARGUMENT` VARCHAR(255), IN `TABLE_NAME_ARGUMENT` VARCHAR(255))
BEGIN
	DECLARE HAS_AUTO_INCREMENT_ID TINYINT(1);
	DECLARE PRIMARY_KEY_COLUMN_NAME VARCHAR(255);
	DECLARE PRIMARY_KEY_TYPE VARCHAR(255);
	DECLARE SQL_EXP VARCHAR(1000);
	SELECT COUNT(*)
		INTO HAS_AUTO_INCREMENT_ID
		FROM `information_schema`.`COLUMNS`
		WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
			AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
			AND `Extra` = 'auto_increment'
			AND `COLUMN_KEY` = 'PRI'
			LIMIT 1;
	IF HAS_AUTO_INCREMENT_ID THEN
		SELECT `COLUMN_TYPE`
			INTO PRIMARY_KEY_TYPE
			FROM `information_schema`.`COLUMNS`
			WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
				AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
				AND `COLUMN_KEY` = 'PRI'
			LIMIT 1;
		SELECT `COLUMN_NAME`
			INTO PRIMARY_KEY_COLUMN_NAME
			FROM `information_schema`.`COLUMNS`
			WHERE `TABLE_SCHEMA` = (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA()))
				AND `TABLE_NAME` = TABLE_NAME_ARGUMENT
				AND `COLUMN_KEY` = 'PRI'
			LIMIT 1;
		SET SQL_EXP = CONCAT('ALTER TABLE `', (SELECT IFNULL(SCHEMA_NAME_ARGUMENT, SCHEMA())), '`.`', TABLE_NAME_ARGUMENT, '` MODIFY COLUMN `', PRIMARY_KEY_COLUMN_NAME, '` ', PRIMARY_KEY_TYPE, ' NOT NULL;');
		SET @SQL_EXP = SQL_EXP;
		PREPARE SQL_EXP_EXECUTE FROM @SQL_EXP;
		EXECUTE SQL_EXP_EXECUTE;
		DEALLOCATE PREPARE SQL_EXP_EXECUTE;
	END IF;
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
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-04-18 22:44:57

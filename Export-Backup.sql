-- TABLAS EXPORTADAS: bkpincidentes, bkpusers, incidentes, usuarios

-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: incidentes
-- ------------------------------------------------------
-- Server version	8.0.27

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `bkpincidentes`
--

LOCK TABLES `bkpincidentes` WRITE;
/*!40000 ALTER TABLE `bkpincidentes` DISABLE KEYS */;
INSERT INTO `bkpincidentes` VALUES (0,'2022-01-12','2022-01-20','Nuevo',1,2);
/*!40000 ALTER TABLE `bkpincidentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bkpusers`
--

LOCK TABLES `bkpusers` WRITE;
/*!40000 ALTER TABLE `bkpusers` DISABLE KEYS */;
INSERT INTO `bkpusers` VALUES (5,'testinguser','qpwoejq',3,4),(6,'testinguser','qpwoejq',3,4);
/*!40000 ALTER TABLE `bkpusers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `incidentes`
--

LOCK TABLES `incidentes` WRITE;
/*!40000 ALTER TABLE `incidentes` DISABLE KEYS */;
INSERT INTO `incidentes` VALUES (9,'Linux VM falla','La VM no responde',4,3,1,2,'2022-01-09','2022-01-10','Validacion'),(10,'Windows VM falla','Servicios fallando',4,2,2,1,'2021-12-21','2021-12-27','Solved'),(11,'Replicar DB a PROD','Pase a PROD de BD',1,1,3,3,'2022-01-05','2022-01-05','Solved'),(12,'probando trigger','probando si se copia a tabla de bkp',1,2,3,1,'2022-01-12','2022-01-20','Nuevo');
/*!40000 ALTER TABLE `incidentes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'gjejer','864315','gjjejer@gmail.com',0,2),(2,'ndiem','357519','ndiem@gmail.com',1,3),(3,'dhermann','568152','dhermann@gmail.com',1,1),(4,'normaluser','123456','normaluser@gmail.com',2,4);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-02-05 19:31:25

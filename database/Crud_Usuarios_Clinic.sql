-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: Crud_Usuarios_Clinic
-- ------------------------------------------------------
-- Server version	9.0.1

-- 1. CREAR LA BASE DE DATOS (si no existe)
CREATE DATABASE IF NOT EXISTS Crud_Usuarios_Clinic;

-- 2. USAR LA BASE DE DATOS
USE Crud_Usuarios_Clinic;

-- 3. CONTINUAR CON EL SCRIPT ORIGINAL
DROP TABLE IF EXISTS `tratamiento_producto`;

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

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
-- Table structure for table `cita`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `cita`;
CREATE TABLE `cita` (
  `ID_Cita` int NOT NULL AUTO_INCREMENT,
  `Fecha_Cita` date NOT NULL,
  `Hora_Cita` time NOT NULL,
  `Duracion_Minutos` int DEFAULT '30',
  `Motivo` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Estado_Cita` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Observaciones` text COLLATE utf8mb4_unicode_ci,
  `Motivo_Cancelacion` text COLLATE utf8mb4_unicode_ci,
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ID_Mascota` int NOT NULL,
  `ID_Veterinario` int NOT NULL,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_Cita`),
  UNIQUE KEY `unique_vet_datetime` (`ID_Veterinario`,`Fecha_Cita`,`Hora_Cita`),
  KEY `idx_cita_fecha` (`Fecha_Cita`),
  KEY `idx_cita_veterinario` (`ID_Veterinario`),
  KEY `idx_cita_fecha_veterinario` (`Fecha_Cita`,`ID_Veterinario`),
  KEY `idx_cita_mascota` (`ID_Mascota`),
  KEY `idx_cita_estado` (`Estado_Cita`),
  CONSTRAINT `cita_ibfk_1` FOREIGN KEY (`ID_Mascota`) REFERENCES `mascota` (`ID_Mascota`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `cita_ibfk_2` FOREIGN KEY (`ID_Veterinario`) REFERENCES `veterinario` (`ID_Veterinario`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_duracion` CHECK (((`Duracion_Minutos` > 0) and (`Duracion_Minutos` <= 480))),
  CONSTRAINT `chk_estado_cita` CHECK ((`Estado_Cita` in (_utf8mb4'Programada',_utf8mb4'En curso',_utf8mb4'Completada',_utf8mb4'Cancelada'))),
  CONSTRAINT `chk_hora_cita` CHECK ((`Hora_Cita` between '08:00:00' and '18:00:00'))
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cita`
--

INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (1,'2025-08-15','10:30:00',30,'Vacunación','Programada','Paciente nervioso',NULL,'2025-08-24 22:40:56',1,2,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (2,'2023-10-15','10:30:00',30,'Consulta general','Programada','Traer historial médico',NULL,'2025-08-24 23:40:21',1,2,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (3,'2025-10-10','14:00:00',30,'Consulta general','Programada',NULL,NULL,'2025-10-03 19:33:44',8,2,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (4,'2025-10-04','09:00:00',30,'Control de vacunas','Completada',NULL,NULL,'2025-10-04 22:31:53',1,3,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (5,'2025-10-04','10:30:00',30,'Consulta general','Programada',NULL,NULL,'2025-10-04 22:31:53',3,3,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (6,'2025-10-04','14:00:00',45,'Revisión post-operatoria','Programada',NULL,NULL,'2025-10-04 22:31:53',5,3,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (11,'2025-10-01','09:00:00',30,'Control de salud anual','Completada',NULL,NULL,'2025-10-05 23:27:23',3,1,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (12,'2025-10-02','10:30:00',30,'Vacunación múltiple','Completada',NULL,NULL,'2025-10-05 23:27:23',10,1,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (13,'2025-10-03','11:00:00',30,'Desparasitación','Completada',NULL,NULL,'2025-10-05 23:27:23',7,1,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (14,'2025-10-10','14:00:00',30,'Control de peso','Programada',NULL,NULL,'2025-10-05 23:27:23',12,1,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (15,'2025-09-25','08:30:00',120,'Esterilización','Completada',NULL,NULL,'2025-10-05 23:27:23',2,2,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (16,'2025-09-28','09:00:00',90,'Extracción dental','Completada',NULL,NULL,'2025-10-05 23:27:23',5,2,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (17,'2025-10-01','10:00:00',60,'Sutura de herida','Completada',NULL,NULL,'2025-10-05 23:27:23',8,2,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (18,'2025-10-12','08:00:00',180,'Fractura de pata','Programada',NULL,NULL,'2025-10-05 23:27:23',1,2,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (19,'2025-09-30','15:30:00',30,'Problemas digestivos','Completada',NULL,NULL,'2025-10-05 23:27:23',4,3,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (20,'2025-10-02','16:00:00',30,'Infección ocular','Completada',NULL,NULL,'2025-10-05 23:27:23',6,3,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (21,'2025-10-03','09:30:00',45,'Control post-operatorio','Completada',NULL,NULL,'2025-10-05 23:27:23',2,3,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (22,'2025-10-11','11:30:00',30,'Revisión de vacunas','Programada',NULL,NULL,'2025-10-05 23:27:23',11,3,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (26,'2025-10-05','16:30:00',30,'Control de vacunas anual','Programada','Firulais necesita refuerzo de vacuna múltiple',NULL,'2025-10-06 23:05:24',1,1,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (27,'2025-10-06','16:30:00',30,'Control de vacunas anual','Completada','Firulais necesita refuerzo de vacuna múltiple',NULL,'2025-10-06 23:21:58',1,1,'2025-10-20 23:30:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (28,'2025-10-20','09:00:00',30,'Control de rutina','Programada',NULL,NULL,'2025-10-20 23:41:32',1,1,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (29,'2025-10-20','10:30:00',30,'Vacunación antirrábica','Programada',NULL,NULL,'2025-10-20 23:41:32',3,1,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (30,'2025-10-20','14:00:00',45,'Revisión post-operatoria','Completada',NULL,NULL,'2025-10-20 23:41:32',10,1,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (31,'2025-10-20','08:30:00',60,'Cirugía menor','En curso',NULL,NULL,'2025-10-20 23:41:32',5,2,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (32,'2025-10-20','11:00:00',30,'Consulta general','Programada',NULL,NULL,'2025-10-20 23:41:32',12,2,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (33,'2025-10-20','09:30:00',30,'Control de peso','Completada',NULL,NULL,'2025-10-20 23:41:32',7,3,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (34,'2025-10-20','15:00:00',30,'Desparasitación','Programada',NULL,NULL,'2025-10-20 23:41:32',13,3,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (35,'2025-10-21','10:00:00',30,'Control dental','Programada',NULL,NULL,'2025-10-20 23:41:32',2,1,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (36,'2025-10-21','14:00:00',30,'Revisión dermatológica','Programada',NULL,NULL,'2025-10-20 23:41:32',6,2,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (37,'2025-10-22','09:00:00',30,'Vacunación','Completada',NULL,NULL,'2025-10-20 23:41:32',8,3,'2025-10-22 13:39:42');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (38,'2025-10-23','11:00:00',45,'Consulta por alergia','Programada',NULL,NULL,'2025-10-20 23:41:32',4,1,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (39,'2025-10-25','15:30:00',30,'Control de diabetes','Programada',NULL,NULL,'2025-10-20 23:41:32',11,2,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (40,'2025-10-27','08:00:00',30,'Chequeo general','Programada',NULL,NULL,'2025-10-20 23:41:32',9,3,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (41,'2025-10-22','16:00:00',30,'Control dental','Cancelada',NULL,'Cliente no puede asistir por viaje','2025-10-20 23:41:32',1,1,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (42,'2025-10-24','10:30:00',30,'Vacunación','Cancelada',NULL,'Mascota enferma, reprogramar cuando mejore','2025-10-20 23:41:32',8,2,'2025-10-20 23:41:32');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (43,'2025-10-25','14:30:00',30,'Vacunación anual','Programada','Traer cartilla de vacunación',NULL,'2025-10-21 18:31:04',1,3,'2025-10-21 18:31:04');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (44,'2025-10-25','10:00:00',30,'Control de rutina','Programada',NULL,NULL,'2025-10-21 19:59:16',1,1,'2025-10-21 19:59:16');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (46,'2025-10-28','09:30:00',30,'Vacunación antirrábica','Programada',NULL,NULL,'2025-10-22 13:32:30',1,3,'2025-10-22 13:32:30');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (47,'2025-10-29','14:00:00',30,'Control de peso','Programada',NULL,NULL,'2025-10-22 13:32:52',1,3,'2025-10-22 13:32:52');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (48,'2025-10-30','11:00:00',30,'Revisión post-operatoria','Programada',NULL,NULL,'2025-10-22 13:36:09',2,3,'2025-10-22 13:36:09');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (49,'2025-10-31','16:00:00',30,'Revisión administrativa','Programada',NULL,NULL,'2025-10-22 13:49:38',2,3,'2025-10-22 13:49:38');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (50,'2025-10-24','09:30:00',30,'vacunacion','Programada','PERRITO NERVIOSO',NULL,'2025-10-22 15:43:21',1,1,'2025-10-22 15:43:21');
INSERT INTO `cita` (`ID_Cita`, `Fecha_Cita`, `Hora_Cita`, `Duracion_Minutos`, `Motivo`, `Estado_Cita`, `Observaciones`, `Motivo_Cancelacion`, `Fecha_Registro`, `ID_Mascota`, `ID_Veterinario`, `Fecha_Actualizacion`) VALUES (57,'2025-10-22','16:30:00',28,'control general','Completada','',NULL,'2025-10-22 16:39:39',3,3,'2025-10-22 16:40:28');

--
-- Table structure for table `cliente`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `ID_Cliente` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Apellidos` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Identificacion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Direccion` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Telefono` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Correo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Estado` enum('Activo','Inactivo') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo',
  PRIMARY KEY (`ID_Cliente`),
  UNIQUE KEY `Identificacion` (`Identificacion`),
  UNIQUE KEY `Correo` (`Correo`),
  KEY `idx_cliente_identificacion` (`Identificacion`),
  KEY `idx_cliente_nombre` (`Nombre`,`Apellidos`),
  CONSTRAINT `chk_correo` CHECK ((`Correo` like _utf8mb4'%@%.%')),
  CONSTRAINT `chk_telefono` CHECK ((length(`Telefono`) >= 7))
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

INSERT INTO `cliente` (`ID_Cliente`, `Nombre`, `Apellidos`, `Identificacion`, `Direccion`, `Telefono`, `Correo`, `Fecha_Registro`, `Estado`) VALUES (1,'Ana María','García Silva','1020304050','Calle 123 #45-67','3101234567','ana.garcia@email.com','2025-06-22 00:46:17','Activo');
INSERT INTO `cliente` (`ID_Cliente`, `Nombre`, `Apellidos`, `Identificacion`, `Direccion`, `Telefono`, `Correo`, `Fecha_Registro`, `Estado`) VALUES (2,'Carlos Eduardo','Martínez Ruiz','2030405060','Carrera 45 #12-34','3207654321','carlos.martinez@email.com','2025-06-22 00:46:17','Activo');
INSERT INTO `cliente` (`ID_Cliente`, `Nombre`, `Apellidos`, `Identificacion`, `Direccion`, `Telefono`, `Correo`, `Fecha_Registro`, `Estado`) VALUES (3,'Pedro','Ramírez Torres','3040506070','Calle 50 #20-30','3151234567','pedro.ramirez@email.com','2025-10-01 21:26:23','Activo');
INSERT INTO `cliente` (`ID_Cliente`, `Nombre`, `Apellidos`, `Identificacion`, `Direccion`, `Telefono`, `Correo`, `Fecha_Registro`, `Estado`) VALUES (4,'Laura','González Méndez','4050607080','Carrera 80 #40-50','3162345678','laura.gonzalez@email.com','2025-10-01 21:26:23','Activo');
INSERT INTO `cliente` (`ID_Cliente`, `Nombre`, `Apellidos`, `Identificacion`, `Direccion`, `Telefono`, `Correo`, `Fecha_Registro`, `Estado`) VALUES (5,'Miguel','Sánchez Ortiz','5060708090','Diagonal 60 #30-40','3173456789','miguel.sanchez@email.com','2025-10-01 21:26:23','Activo');

--
-- Table structure for table `entradahistoria`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `entradahistoria`;
CREATE TABLE `entradahistoria` (
  `ID_Entrada` int NOT NULL AUTO_INCREMENT,
  `Fecha_Entrada` date NOT NULL,
  `Descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `Observaciones` text COLLATE utf8mb4_unicode_ci,
  `Peso_Actual` decimal(5,2) DEFAULT NULL,
  `Temperatura` decimal(4,2) DEFAULT NULL,
  `Frecuencia_Cardiaca` int DEFAULT NULL,
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ID_Historia` int NOT NULL,
  `ID_Veterinario` int DEFAULT NULL,
  `ID_Tratamiento` int DEFAULT NULL,
  PRIMARY KEY (`ID_Entrada`),
  KEY `ID_Tratamiento` (`ID_Tratamiento`),
  KEY `idx_veterinario` (`ID_Veterinario`),
  KEY `idx_entrada_historia` (`ID_Historia`,`Fecha_Entrada` DESC),
  CONSTRAINT `entradahistoria_ibfk_1` FOREIGN KEY (`ID_Historia`) REFERENCES `historiaclinica` (`ID_Historia`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `entradahistoria_ibfk_2` FOREIGN KEY (`ID_Tratamiento`) REFERENCES `tratamiento` (`ID_Tratamiento`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_entrada_veterinario` FOREIGN KEY (`ID_Veterinario`) REFERENCES `veterinario` (`ID_Veterinario`),
  CONSTRAINT `chk_frecuencia_cardiaca` CHECK (((`Frecuencia_Cardiaca` is null) or ((`Frecuencia_Cardiaca` >= 60) and (`Frecuencia_Cardiaca` <= 300)))),
  CONSTRAINT `chk_peso_actual` CHECK (((`Peso_Actual` is null) or (`Peso_Actual` > 0))),
  CONSTRAINT `chk_temperatura` CHECK (((`Temperatura` is null) or ((`Temperatura` >= 35.0) and (`Temperatura` <= 45.0))))
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entradahistoria`
--

INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (1,'2025-10-05','Control de rutina. Mascota en buen estado general. Vacunación al día.','Recomendar desparasitación en 3 meses. Dieta balanceada.',25.50,38.30,120,'2025-10-05 22:43:26',1,1,NULL);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (8,'2025-09-30','Consulta por problemas digestivos.','Mejoría notable con dieta blanda',3.20,38.60,130,'2025-10-05 23:27:23',4,3,7);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (9,'2025-10-02','Tratamiento para infección ocular.','Ojo izquierdo con secreción reducida',4.00,38.20,125,'2025-10-05 23:27:23',6,3,8);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (10,'2025-10-03','Control post-operatorio de esterilización.','Herida quirúrgica limpia, sin complicaciones',4.50,38.10,115,'2025-10-05 23:27:23',2,3,9);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (11,'2025-09-20','Cirugía de fractura en pata delantera derecha. Fractura limpia en radio.','Paciente estabilizado pre-quirúrgicamente. Procedimiento bajo anestesia general.',28.50,37.50,90,'2025-10-05 23:49:56',12,2,10);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (12,'2025-09-25','Extracción de tumor benigno en región abdominal. Masa de 3cm de diámetro.','Biopsia enviada a laboratorio. Sutura intradérmica para mejor cicatrización.',22.30,38.20,110,'2025-10-05 23:49:56',5,2,11);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (13,'2025-10-01','Cirugía reconstructiva por herida profunda en lomo. Injerto de piel autólogo.','Zona donante: región lateral. Control estricto de signos vitales post-operatorios.',6.20,37.80,125,'2025-10-05 23:49:56',8,2,12);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (14,'2025-10-13','Control de rutina. Estado general excelente.','Continuar con dieta balanceada y ejercicio regular.',25.80,38.40,118,'2025-10-20 23:41:32',3,1,NULL);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (15,'2025-10-05','Vacunación triple felina aplicada.','Sin reacciones adversas. Próxima vacuna en 1 año.',3.30,38.10,125,'2025-10-20 23:41:32',4,3,NULL);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (16,'2025-10-17','Control post-quirúrgico. Herida cicatrizando correctamente.','Retirar puntos en 7 días. Mantener antibiótico.',22.50,38.00,95,'2025-10-20 23:41:32',5,2,NULL);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (17,'2025-10-22','Control rutinario. Mascota presenta buen estado general.','Recomendar refuerzo de vacuna en 6 meses',26.50,38.30,118,'2025-10-22 13:37:59',1,3,NULL);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (18,'2025-10-22','vacunacion exitosa',NULL,25.00,37.98,120,'2025-10-22 15:57:20',1,3,NULL);
INSERT INTO `entradahistoria` (`ID_Entrada`, `Fecha_Entrada`, `Descripcion`, `Observaciones`, `Peso_Actual`, `Temperatura`, `Frecuencia_Cardiaca`, `Fecha_Registro`, `ID_Historia`, `ID_Veterinario`, `ID_Tratamiento`) VALUES (19,'2025-10-22','Control rutinario. Mascota en buen estado','Recomendar refuerzo de vacuna en 6 meses',26.50,38.30,118,'2025-10-22 15:58:55',1,3,NULL);

--
-- Table structure for table `factura`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `factura`;
CREATE TABLE `factura` (
  `ID_Factura` int NOT NULL AUTO_INCREMENT,
  `Numero_Factura` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Fecha_Factura` date NOT NULL,
  `Subtotal` decimal(10,2) NOT NULL,
  `IVA` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Descuento` decimal(10,2) DEFAULT '0.00',
  `Total` decimal(10,2) NOT NULL,
  `Estado_Factura` enum('Pendiente','Pagada','Cancelada','Vencida') COLLATE utf8mb4_unicode_ci DEFAULT 'Pendiente',
  `Fecha_Vencimiento` date DEFAULT NULL,
  `Notas` text COLLATE utf8mb4_unicode_ci,
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ID_Cliente` int NOT NULL,
  `ID_Tratamiento` int NOT NULL,
  PRIMARY KEY (`ID_Factura`),
  UNIQUE KEY `Numero_Factura` (`Numero_Factura`),
  KEY `ID_Cliente` (`ID_Cliente`),
  KEY `ID_Tratamiento` (`ID_Tratamiento`),
  KEY `idx_factura_fecha` (`Fecha_Factura`),
  KEY `idx_factura_estado` (`Estado_Factura`),
  CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`ID_Cliente`) REFERENCES `cliente` (`ID_Cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `factura_ibfk_2` FOREIGN KEY (`ID_Tratamiento`) REFERENCES `tratamiento` (`ID_Tratamiento`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_descuento` CHECK ((`Descuento` >= 0)),
  CONSTRAINT `chk_fecha_vencimiento` CHECK (((`Fecha_Vencimiento` is null) or (`Fecha_Vencimiento` >= `Fecha_Factura`))),
  CONSTRAINT `chk_iva` CHECK ((`IVA` >= 0)),
  CONSTRAINT `chk_subtotal` CHECK ((`Subtotal` >= 0)),
  CONSTRAINT `chk_total` CHECK ((`Total` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `historiaclinica`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `historiaclinica`;
CREATE TABLE `historiaclinica` (
  `ID_Historia` int NOT NULL AUTO_INCREMENT,
  `Fecha_Creacion` date NOT NULL,
  `ID_Mascota` int NOT NULL,
  PRIMARY KEY (`ID_Historia`),
  UNIQUE KEY `ID_Mascota` (`ID_Mascota`),
  CONSTRAINT `historiaclinica_ibfk_1` FOREIGN KEY (`ID_Mascota`) REFERENCES `mascota` (`ID_Mascota`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `historiaclinica`
--

INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (1,'2025-08-24',1);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (2,'2025-08-24',2);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (3,'2025-10-01',3);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (4,'2025-10-01',4);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (5,'2025-10-01',5);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (6,'2025-10-01',6);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (7,'2025-10-01',7);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (8,'2025-10-01',8);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (9,'2025-10-01',9);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (10,'2025-10-01',10);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (11,'2025-10-01',11);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (12,'2025-10-01',12);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (13,'2025-10-01',13);
INSERT INTO `historiaclinica` (`ID_Historia`, `Fecha_Creacion`, `ID_Mascota`) VALUES (14,'2025-10-21',16);

--
-- Table structure for table `mascota`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `mascota`;
CREATE TABLE `mascota` (
  `ID_Mascota` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Especie` enum('Perro','Gato','Ave','Conejo','Hamster','Reptil','Otro') COLLATE utf8mb4_unicode_ci NOT NULL,
  `Raza` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Edad` int DEFAULT NULL,
  `Peso` decimal(5,2) DEFAULT NULL,
  `Color` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Sexo` enum('Macho','Hembra') COLLATE utf8mb4_unicode_ci NOT NULL,
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `Estado` enum('Activo','Inactivo','Fallecido') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo',
  `ID_Cliente` int NOT NULL,
  PRIMARY KEY (`ID_Mascota`),
  KEY `idx_mascota_nombre` (`Nombre`),
  KEY `idx_mascota_cliente` (`ID_Cliente`),
  CONSTRAINT `mascota_ibfk_1` FOREIGN KEY (`ID_Cliente`) REFERENCES `cliente` (`ID_Cliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_edad` CHECK (((`Edad` >= 0) and (`Edad` <= 50))),
  CONSTRAINT `chk_edad_positiva` CHECK (((`edad` is null) or (`edad` >= 0))),
  CONSTRAINT `chk_peso` CHECK ((`Peso` > 0)),
  CONSTRAINT `chk_peso_positivo` CHECK (((`Peso` is null) or (`Peso` > 0)))
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mascota`
--

INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (1,'Firulais','Perro','Labrador',3,5.80,'Marrón','Macho','2025-08-24 22:32:18','Activo',1);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (2,'Mimi','Gato','Siames',2,4.50,'Gris','Hembra','2025-08-25 10:00:00','Activo',2);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (3,'Luna','Perro','Golden Retriever',2,25.50,'Dorado','Hembra','2025-10-01 21:26:23','Activo',1);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (4,'Max','Gato','Persa',1,3.20,'Blanco','Macho','2025-10-01 21:26:23','Activo',1);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (5,'Rocky','Perro','Bulldog',4,22.00,'Café','Macho','2025-10-01 21:26:23','Activo',2);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (6,'Nala','Gato','Angora',3,4.00,'Negro','Hembra','2025-10-01 21:26:23','Activo',2);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (7,'Toby','Perro','Beagle',5,12.50,'Tricolor','Macho','2025-10-01 21:26:23','Activo',3);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (8,'Simba','Gato','Maine Coon',2,6.80,'Atigrado','Macho','2025-10-01 21:26:23','Activo',3);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (9,'Coco','Ave','Loro',1,0.30,'Verde','Macho','2025-10-01 21:26:23','Activo',3);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (10,'Bella','Perro','Poodle',3,8.00,'Blanco','Hembra','2025-10-01 21:26:23','Activo',4);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (11,'Misha','Gato','Bengala',1,4.50,'Moteado','Hembra','2025-10-01 21:26:23','Activo',4);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (12,'Thor','Perro','Husky Siberiano',4,28.00,'Blanco y Gris','Macho','2025-10-01 21:26:23','Activo',5);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (13,'Pelusa','Conejo','Angora',1,1.50,'Gris','Hembra','2025-10-01 21:26:23','Activo',5);
INSERT INTO `mascota` (`ID_Mascota`, `Nombre`, `Especie`, `Raza`, `Edad`, `Peso`, `Color`, `Sexo`, `Fecha_Registro`, `Estado`, `ID_Cliente`) VALUES (16,'Rex','Perro','Pastor Alemán',2,30.50,'Negro y Marrón','Macho','2025-10-21 17:34:21','Activo',1);

--
-- Table structure for table `pago`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `pago`;
CREATE TABLE `pago` (
  `ID_Pago` int NOT NULL AUTO_INCREMENT,
  `Numero_Pago` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Fecha_Pago` date NOT NULL,
  `Monto` decimal(10,2) NOT NULL,
  `Metodo_Pago` enum('Efectivo','Tarjeta_Credito','Tarjeta_Debito','Transferencia','Cheque') COLLATE utf8mb4_unicode_ci NOT NULL,
  `Referencia_Pago` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Notas` text COLLATE utf8mb4_unicode_ci,
  `Estado_Pago` enum('Procesado','Pendiente','Rechazado') COLLATE utf8mb4_unicode_ci DEFAULT 'Procesado',
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ID_Factura` int NOT NULL,
  PRIMARY KEY (`ID_Pago`),
  UNIQUE KEY `Numero_Pago` (`Numero_Pago`),
  KEY `ID_Factura` (`ID_Factura`),
  CONSTRAINT `pago_ibfk_1` FOREIGN KEY (`ID_Factura`) REFERENCES `factura` (`ID_Factura`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_monto` CHECK ((`Monto` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `producto`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `producto` (
  `ID_Producto` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Descripcion` text COLLATE utf8mb4_unicode_ci,
  `Categoria` enum('Medicamento','Vacuna','Suplemento','Material_Medico','Alimento') COLLATE utf8mb4_unicode_ci NOT NULL,
  `Cantidad_Stock` int NOT NULL DEFAULT '0',
  `Stock_Minimo` int NOT NULL DEFAULT '5',
  `Precio_Compra` decimal(10,2) NOT NULL,
  `Precio_Venta` decimal(10,2) NOT NULL,
  `Fecha_Vencimiento` date DEFAULT NULL,
  `Proveedor` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Estado` enum('Activo','Inactivo','Vencido') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo',
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Producto`),
  KEY `idx_producto_nombre` (`Nombre`),
  CONSTRAINT `chk_cantidad_stock` CHECK ((`Cantidad_Stock` >= 0)),
  CONSTRAINT `chk_precio_compra` CHECK ((`Precio_Compra` > 0)),
  CONSTRAINT `chk_precio_venta` CHECK ((`Precio_Venta` > 0)),
  CONSTRAINT `chk_precios` CHECK ((`Precio_Venta` >= `Precio_Compra`)),
  CONSTRAINT `chk_stock_minimo` CHECK ((`Stock_Minimo` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tratamiento`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `tratamiento`;
CREATE TABLE `tratamiento` (
  `ID_Tratamiento` int NOT NULL AUTO_INCREMENT,
  `Fecha_Tratamiento` date NOT NULL,
  `Diagnostico` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `Tratamiento_Aplicado` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `Notas` text COLLATE utf8mb4_unicode_ci,
  `Estado_Tratamiento` enum('En_Curso','Completado','Suspendido') COLLATE utf8mb4_unicode_ci DEFAULT 'En_Curso',
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ID_Cita` int NOT NULL,
  `ID_Veterinario` int NOT NULL,
  PRIMARY KEY (`ID_Tratamiento`),
  KEY `ID_Cita` (`ID_Cita`),
  KEY `ID_Veterinario` (`ID_Veterinario`),
  CONSTRAINT `tratamiento_ibfk_1` FOREIGN KEY (`ID_Cita`) REFERENCES `cita` (`ID_Cita`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `tratamiento_ibfk_2` FOREIGN KEY (`ID_Veterinario`) REFERENCES `veterinario` (`ID_Veterinario`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tratamiento`
--

INSERT INTO `tratamiento` (`ID_Tratamiento`, `Fecha_Tratamiento`, `Diagnostico`, `Tratamiento_Aplicado`, `Notas`, `Estado_Tratamiento`, `Fecha_Registro`, `ID_Cita`, `ID_Veterinario`) VALUES (7,'2025-09-30','Gastritis leve por cambio de alimento','Dieta blanda por 3 días y protector gástrico','Mejorar progresivamente a alimento regular','Completado','2025-10-05 23:27:23',13,3);
INSERT INTO `tratamiento` (`ID_Tratamiento`, `Fecha_Tratamiento`, `Diagnostico`, `Tratamiento_Aplicado`, `Notas`, `Estado_Tratamiento`, `Fecha_Registro`, `ID_Cita`, `ID_Veterinario`) VALUES (8,'2025-10-02','Conjuntivitis bacteriana','Aplicación de colirio antibiótico cada 8 horas','Revisión en 5 días para evaluar evolución','En_Curso','2025-10-05 23:27:23',14,3);
INSERT INTO `tratamiento` (`ID_Tratamiento`, `Fecha_Tratamiento`, `Diagnostico`, `Tratamiento_Aplicado`, `Notas`, `Estado_Tratamiento`, `Fecha_Registro`, `ID_Cita`, `ID_Veterinario`) VALUES (9,'2025-10-03','Recuperación post-quirúrgica satisfactoria','Control de herida y retiro de puntos','Herida cicatrizando adecuadamente','Completado','2025-10-05 23:27:23',15,3);
INSERT INTO `tratamiento` (`ID_Tratamiento`, `Fecha_Tratamiento`, `Diagnostico`, `Tratamiento_Aplicado`, `Notas`, `Estado_Tratamiento`, `Fecha_Registro`, `ID_Cita`, `ID_Veterinario`) VALUES (10,'2025-09-20','Fractura completa de radio derecho por trauma','Osteosíntesis con placa y tornillos. Radiografía post-operatoria satisfactoria.','Control radiográfico en 4 semanas. Restricción de ejercicio.','En_Curso','2025-10-05 23:49:56',16,2);
INSERT INTO `tratamiento` (`ID_Tratamiento`, `Fecha_Tratamiento`, `Diagnostico`, `Tratamiento_Aplicado`, `Notas`, `Estado_Tratamiento`, `Fecha_Registro`, `ID_Cita`, `ID_Veterinario`) VALUES (11,'2025-09-25','Tumoración subcutánea benigna en hipogastrio','Escisión completa de masa con márgenes de seguridad. Hemostasia cuidadosa.','Retiro de puntos en 12 días. Monitorear zona quirúrgica.','Completado','2025-10-05 23:49:56',17,2);
INSERT INTO `tratamiento` (`ID_Tratamiento`, `Fecha_Tratamiento`, `Diagnostico`, `Tratamiento_Aplicado`, `Notas`, `Estado_Tratamiento`, `Fecha_Registro`, `ID_Cita`, `ID_Veterinario`) VALUES (12,'2025-10-01','Herida traumática extensa con pérdida de tejido','Desbridamiento e injerto de piel de espesor parcial. Terapia de vacío aplicada.','Cambios de curación cada 48h. Antibioticoterapia profiláctica.','En_Curso','2025-10-05 23:49:56',18,2);

--
-- Table structure for table `tratamiento_producto`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `producto`;
CREATE TABLE `tratamiento_producto` (
  `ID_Tratamiento_Producto` int NOT NULL AUTO_INCREMENT,
  `ID_Tratamiento` int NOT NULL,
  `ID_Producto` int NOT NULL,
  `Cantidad_Utilizada` int NOT NULL DEFAULT '1',
  `Dosis` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Frecuencia` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Duracion_Dias` int DEFAULT NULL,
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Tratamiento_Producto`),
UNIQUE KEY `unique_tratamiento_producto` (`ID_Tratamiento`,`ID_Producto`),
KEY `ID_Producto` (`ID_Producto`),
CONSTRAINT `tratamiento_producto_ibfk_1` FOREIGN KEY (`ID_Tratamiento`) REFERENCES `tratamiento` (`ID_Tratamiento`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `tratamiento_producto_ibfk_2` FOREIGN KEY (`ID_Producto`) REFERENCES `producto` (`ID_Producto`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usuario`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `rol` enum('ADMIN','VETERINARIO','RECEPCIONISTA','CLIENTE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `Intentos_Fallidos` int DEFAULT '0',
  `Fecha_Bloqueo` datetime DEFAULT NULL,
  `id_cliente` int DEFAULT NULL,
  `id_veterinario` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_veterinario` (`id_veterinario`),
  CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`ID_Cliente`),
  CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`id_veterinario`) REFERENCES `veterinario` (`ID_Veterinario`),
  CONSTRAINT `chk_rol_usuario` CHECK ((`rol` in (_utf8mb4'ADMIN',_utf8mb4'VETERINARIO',_utf8mb4'RECEPCIONISTA',_utf8mb4'CLIENTE')))
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `Intentos_Fallidos`, `Fecha_Bloqueo`, `id_cliente`, `id_veterinario`) VALUES (1,'Juan Pérez','juan.perez@email.com','123456','CLIENTE',1,0,NULL,1,NULL);
INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `Intentos_Fallidos`, `Fecha_Bloqueo`, `id_cliente`, `id_veterinario`) VALUES (2,'Administrador General','admin@clinicaveterinaria.com','admin123','ADMIN',1,0,NULL,NULL,NULL);
INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `Intentos_Fallidos`, `Fecha_Bloqueo`, `id_cliente`, `id_veterinario`) VALUES (3,'Dra. Ana Veterinaria','ana.vet@clinicaveterinaria.com','vet123','VETERINARIO',1,0,NULL,NULL,3);
INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `Intentos_Fallidos`, `Fecha_Bloqueo`, `id_cliente`, `id_veterinario`) VALUES (5,'Lucía Dueña','lucia.cliente@clinicaveterinaria.com','cliente123','CLIENTE',1,0,NULL,1,NULL);
INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `Intentos_Fallidos`, `Fecha_Bloqueo`, `id_cliente`, `id_veterinario`) VALUES (6,'Pedro Ramírez','pedro.ramirez@email.com','123456','CLIENTE',1,0,NULL,3,NULL);
INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `Intentos_Fallidos`, `Fecha_Bloqueo`, `id_cliente`, `id_veterinario`) VALUES (7,'Laura González','laura.gonzalez@email.com','123456','CLIENTE',1,0,NULL,4,NULL);
INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `Intentos_Fallidos`, `Fecha_Bloqueo`, `id_cliente`, `id_veterinario`) VALUES (8,'Miguel Sánchez','miguel.sanchez@email.com','123456','CLIENTE',1,0,NULL,5,NULL);
INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `Intentos_Fallidos`, `Fecha_Bloqueo`, `id_cliente`, `id_veterinario`) VALUES (9,'Carlos Martínez','carlos.martinez@email.com','123456','CLIENTE',1,0,NULL,2,NULL);
INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `Intentos_Fallidos`, `Fecha_Bloqueo`, `id_cliente`, `id_veterinario`) VALUES (10,'Dr. Juan Carlos Pérez','juan.perez@veterinaria.com','vet123','VETERINARIO',1,0,NULL,NULL,1);
INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `Intentos_Fallidos`, `Fecha_Bloqueo`, `id_cliente`, `id_veterinario`) VALUES (11,'Dra. María Elena Rodríguez','maria.rodriguez@veterinaria.com','vet123','VETERINARIO',1,0,NULL,NULL,2);
INSERT INTO `usuario` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `Intentos_Fallidos`, `Fecha_Bloqueo`, `id_cliente`, `id_veterinario`) VALUES (14,'Super Administrador','superadmin@clinicaveterinaria.com','admin123','ADMIN',1,0,NULL,NULL,NULL);

--
-- Table structure for table `veterinario`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
DROP TABLE IF EXISTS `veterinario`;
CREATE TABLE `veterinario` (
  `ID_Veterinario` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Apellidos` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Identificacion` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Titulacion` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Fecha_Titulacion` date NOT NULL,
  `Telefono` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Correo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Especialidad` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `Estado` enum('Activo','Inactivo') COLLATE utf8mb4_unicode_ci DEFAULT 'Activo',
  `Fecha_Registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Veterinario`),
  UNIQUE KEY `Identificacion` (`Identificacion`),
  UNIQUE KEY `Correo` (`Correo`),
  CONSTRAINT `chk_vet_correo` CHECK ((`Correo` like _utf8mb4'%@%.%')),
  CONSTRAINT `chk_vet_telefono` CHECK ((length(`Telefono`) >= 7))
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `veterinario`
--

INSERT INTO `veterinario` (`ID_Veterinario`, `Nombre`, `Apellidos`, `Identificacion`, `Titulacion`, `Fecha_Titulacion`, `Telefono`, `Correo`, `Especialidad`, `Estado`, `Fecha_Registro`) VALUES (1,'Juan Carlos','Pérez González','12345678','Médico Veterinario','2020-12-15','3001234567','juan.perez@veterinaria.com','Medicina General','Activo','2025-06-22 00:46:17');
INSERT INTO `veterinario` (`ID_Veterinario`, `Nombre`, `Apellidos`, `Identificacion`, `Titulacion`, `Fecha_Titulacion`, `Telefono`, `Correo`, `Especialidad`, `Estado`, `Fecha_Registro`) VALUES (2,'María Elena','Rodríguez López','87654321','Médico Veterinario Zootecnista','2019-06-20','3007654321','maria.rodriguez@veterinaria.com','Cirugía','Activo','2025-06-22 00:46:17');
INSERT INTO `veterinario` (`ID_Veterinario`, `Nombre`, `Apellidos`, `Identificacion`, `Titulacion`, `Fecha_Titulacion`, `Telefono`, `Correo`, `Especialidad`, `Estado`, `Fecha_Registro`) VALUES (3,'Ana','Veterinaria López','11223344','Médico Veterinario','2021-03-10','3001112233','ana.vet@clinicaveterinaria.com','Medicina General','Activo','2025-10-04 22:31:53');
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-10-26 18:08:35
SET FOREIGN_KEY_CHECKS=1;
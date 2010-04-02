-- MySQL dump 10.13  Distrib 5.1.45, for apple-darwin9.8.0 (i386)
--
-- Host: localhost    Database: pmjs3
-- ------------------------------------------------------
-- Server version	5.1.45

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
-- Table structure for table `cosubjectships`
--

DROP TABLE IF EXISTS `cosubjectships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cosubjectships` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_id` int(11) DEFAULT NULL,
  `cosubject_id` int(11) DEFAULT NULL,
  `year` smallint(6) DEFAULT '0',
  `articles_count` mediumint(9) DEFAULT NULL,
  `start_year` smallint(6) DEFAULT '0',
  `end_year` smallint(6) DEFAULT '0',
  `articles_counts` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `index_cosubjectships_on_subject_id_and_year_and_articles_count` (`subject_id`,`year`,`articles_count`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cosubjectships`
--

LOCK TABLES `cosubjectships` WRITE;
/*!40000 ALTER TABLE `cosubjectships` DISABLE KEYS */;
LOAD DATA LOCAL INFILE 'cosubjectships.dat' INTO TABLE `cosubjectships`;
/*!40000 ALTER TABLE `cosubjectships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_subjects`
--

DROP TABLE IF EXISTS `journal_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journal_subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `journal_id` int(11) DEFAULT NULL,
  `year` smallint(6) DEFAULT '0',
  `subject_id` int(11) DEFAULT NULL,
  `direct_articles_count` smallint(6) DEFAULT '0',
  `descendant_articles_count` mediumint(9) DEFAULT '0',
  `articles_count` mediumint(9) DEFAULT '0',
  `start_year` smallint(6) DEFAULT '0',
  `end_year` smallint(6) DEFAULT '0',
  `direct_articles_counts` text COLLATE utf8_unicode_ci,
  `descendant_articles_counts` text COLLATE utf8_unicode_ci,
  `articles_counts` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `index_journal_subjects_on_journal_id_year_direct_articles_count` (`journal_id`,`year`,`direct_articles_count`,`articles_count`),
  KEY `index_journal_subjects_on_subject_id_year_direct_articles_count` (`subject_id`,`year`,`direct_articles_count`,`articles_count`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_subjects`
--

LOCK TABLES `journal_subjects` WRITE;
/*!40000 ALTER TABLE `journal_subjects` DISABLE KEYS */;
LOAD DATA LOCAL INFILE 'journal_subjects.dat' INTO TABLE `journal_subjects` (`journal_id`,`year`,`subject_id`,`direct_articles_count`,`descendant_articles_count`,`articles_count`);
/*!40000 ALTER TABLE `journal_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journals`
--

DROP TABLE IF EXISTS `journals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `journals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `abbr` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `articles_count` mediumint(9) DEFAULT '0',
  `start_year` smallint(6) DEFAULT '0',
  `end_year` smallint(6) DEFAULT '0',
  `articles_counts` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `index_journals_on_abbr` (`abbr`),
  KEY `index_journals_on_articles_count` (`articles_count`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journals`
--

LOCK TABLES `journals` WRITE;
/*!40000 ALTER TABLE `journals` DISABLE KEYS */;
LOAD DATA LOCAL INFILE 'journals.dat' INTO TABLE `journals`;
/*!40000 ALTER TABLE `journals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mesh_trees`
--

DROP TABLE IF EXISTS `mesh_trees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mesh_trees` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tree_number` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_mesh_trees_on_parent_id` (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mesh_trees`
--

LOCK TABLES `mesh_trees` WRITE;
/*!40000 ALTER TABLE `mesh_trees` DISABLE KEYS */;
LOAD DATA LOCAL INFILE 'mesh_trees.dat' INTO TABLE `mesh_trees`;
/*!40000 ALTER TABLE `mesh_trees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schema_migrations`
--

LOCK TABLES `schema_migrations` WRITE;
/*!40000 ALTER TABLE `schema_migrations` DISABLE KEYS */;
INSERT INTO `schema_migrations` VALUES ('20100313160250'),('20100313160646'),('20100313161137'),('20100317132221'),('20100319134124');
INSERT INTO `schema_migrations` VALUES ('20100313160250'),('20100313160646'),('20100313161137'),('20100317132221'),('20100319134124');
/*!40000 ALTER TABLE `schema_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subjects`
--

DROP TABLE IF EXISTS `subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `term` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `direct_articles_count` mediumint(9) DEFAULT '0',
  `descendant_articles_count` int(11) DEFAULT '0',
  `articles_count` int(11) DEFAULT '0',
  `start_year` smallint(6) DEFAULT '0',
  `end_year` smallint(6) DEFAULT '0',
  `direct_articles_counts` text COLLATE utf8_unicode_ci,
  `descendant_articles_counts` text COLLATE utf8_unicode_ci,
  `articles_counts` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `index_subjects_on_term` (`term`),
  KEY `index_subjects_on_articles_count` (`articles_count`),
  KEY `index_subjects_on_direct_articles_count` (`direct_articles_count`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subjects`
--

LOCK TABLES `subjects` WRITE;
/*!40000 ALTER TABLE `subjects` DISABLE KEYS */;
LOAD DATA LOCAL INFILE 'subjects.dat' INTO TABLE `subjects`;
/*!40000 ALTER TABLE `subjects` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-04-02  7:06:41

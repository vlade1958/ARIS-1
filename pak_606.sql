/*
SQLyog Ultimate v13.3.0 (64 bit)
MySQL - 5.1.73-1-log : Database - pak_606
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`pak_606` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `pak_606`;

/*Table structure for table `akc_vez_fondi` */

DROP TABLE IF EXISTS `akc_vez_fondi`;

CREATE TABLE `akc_vez_fondi` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDAKCESIJE` int(11) unsigned DEFAULT '0' COMMENT 'POVEZAVA NA AKCESIJO',
  `IDFONDA` int(11) unsigned DEFAULT '0' COMMENT 'POVEZAVA NA FOND',
  `CXAS_OD` date DEFAULT NULL COMMENT 'ZAÈETNI DATUM GRADIVA',
  `CXAS_DO` date DEFAULT NULL COMMENT 'ZADNJI DATUM GRADIVA',
  `VSEBINA` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OPOMBE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OBSEG` decimal(11,2) unsigned DEFAULT NULL COMMENT 'OBSEG V TEKOCIH METRIH',
  `TE` char(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ŠTEVILO IN VRSTA TEHNICNIH ENOT',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `IDAKCESIJE` (`IDAKCESIJE`),
  KEY `IDFONDA` (`IDFONDA`),
  CONSTRAINT `akc_vez_fondi_fk` FOREIGN KEY (`IDFONDA`) REFERENCES `fondi` (`IDFONDA`) ON UPDATE CASCADE,
  CONSTRAINT `FK1` FOREIGN KEY (`IDAKCESIJE`) REFERENCES `akcesije` (`IDAKCESIJE`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=683 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `akcesije` */

DROP TABLE IF EXISTS `akcesije`;

CREATE TABLE `akcesije` (
  `IDAKCESIJE` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Akc_sxt` smallint(4) unsigned DEFAULT NULL COMMENT 'zaporedna številka v letu',
  `AKC_LETO` smallint(5) unsigned DEFAULT NULL COMMENT 'leto akcesije',
  `DatumAkc` date DEFAULT NULL COMMENT 'datum prevzema',
  `SXT_PAK` char(16) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'delovodna številka PAK',
  `VsebinaAkc` text CHARACTER SET utf8,
  `OPOMBE` text CHARACTER SET utf8,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `IDPREVZEMNIKA` int(11) unsigned DEFAULT NULL COMMENT 'kazalec na prevzemnika gradiva iz tabele liferay_osebnevloge. Trenutna vrednost za ID vloge Prevzemnik gradiva je 20172 (tabela liferay.role_)',
  `IDIZROCITELJA` int(11) unsigned DEFAULT NULL COMMENT 'kazalec na ID osebne vloge (imetnik, lastnik)',
  `IDVRSTEAKC` int(10) unsigned DEFAULT NULL COMMENT 'kazalec na ID vrste akcesije',
  PRIMARY KEY (`IDAKCESIJE`),
  UNIQUE KEY `SXT_PAK` (`SXT_PAK`),
  UNIQUE KEY `AkcSxt` (`Akc_sxt`,`AKC_LETO`),
  KEY `IDPREVZEMNIKA_index` (`IDPREVZEMNIKA`),
  KEY `IDIZROCITELJA` (`IDIZROCITELJA`),
  KEY `fk_VrsteAkcesije` (`IDVRSTEAKC`),
  CONSTRAINT `fk_LiferayOsebnevloge` FOREIGN KEY (`IDPREVZEMNIKA`) REFERENCES `liferay_osebnevloge` (`IDOSEBNEVLOGE`) ON UPDATE CASCADE,
  CONSTRAINT `fk_OsebneVloge` FOREIGN KEY (`IDIZROCITELJA`) REFERENCES `osebnevloge` (`IDOSEBNEVLOGE`) ON UPDATE CASCADE,
  CONSTRAINT `fk_VrsteAkcesije` FOREIGN KEY (`IDVRSTEAKC`) REFERENCES `vrsteakcesije` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=388 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `drzxavljanstvo` */

DROP TABLE IF EXISTS `drzxavljanstvo`;

CREATE TABLE `drzxavljanstvo` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDOSEBE` int(11) unsigned DEFAULT NULL,
  `MaticxnaSxtevilka` int(11) unsigned DEFAULT NULL,
  `MaticxnaDrzxava` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `IDOSEBE` (`IDOSEBE`),
  CONSTRAINT `drzxavljanstvo_fk` FOREIGN KEY (`IDOSEBE`) REFERENCES `osebe` (`IDOSEBE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `fizicneenote` */

DROP TABLE IF EXISTS `fizicneenote`;

CREATE TABLE `fizicneenote` (
  `idFE` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nadFE` int(11) unsigned DEFAULT NULL COMMENT 'kazalec na nadrejeno fizično enoto popisa',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `NASLOVFE` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `OPIS` text COLLATE utf8_unicode_ci,
  `VRSTAFE` int(11) unsigned DEFAULT NULL COMMENT 'kazalec na klasifikacije_arh/vrstafe',
  PRIMARY KEY (`idFE`),
  KEY `FK_fizicneenote` (`VRSTAFE`),
  CONSTRAINT `FK_fizicneenote` FOREIGN KEY (`VRSTAFE`) REFERENCES `klasifikacije_arh` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `fondi` */

DROP TABLE IF EXISTS `fondi`;

CREATE TABLE `fondi` (
  `IDFONDA` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NADFOND` int(11) unsigned NOT NULL DEFAULT '0',
  `DRZXAVA` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `ARHIV` varchar(9) COLLATE utf8_unicode_ci NOT NULL,
  `ORG_ENOTA` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `ST_F` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `STATUS` enum('1','2','3','4','5') COLLATE utf8_unicode_ci NOT NULL COMMENT '1 = v urejanju;2 = objavljen;3 = ukinjen;4 = pred prevzemom;5 = prosta številka',
  `PREJSIGN` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IME_F` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CXASGR_OD` smallint(5) DEFAULT NULL,
  `CXASPRIB` char(1) CHARACTER SET utf8 DEFAULT '-',
  `CXASGR_DO` smallint(5) DEFAULT NULL,
  `OPOMBE_CXAS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KLAS_F` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kl_1` char(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `kl_2` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IDKLASFSIRA` int(10) unsigned DEFAULT NULL COMMENT 'kazalec na tabelo klasf_sira',
  `KLAS_UTE` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KLAS_DOB_1` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'začetno obdobje gradiva',
  `KLAS_DOB_2` char(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'zadnje obdobje gradiva',
  `popisi` varchar(12) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'N = ni popisa; P = prevzemni seznam (nestandarden); A = star arhivski popis; R = računalniški popis; RA = popis v ARIS-u; Vr = več različnih popisov;',
  `sxt_polic` smallint(5) DEFAULT NULL,
  `TM` decimal(18,3) DEFAULT NULL,
  `TE` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `arh_Skatle` smallint(5) DEFAULT '0',
  `arh_Zaboji` smallint(5) DEFAULT '0',
  `fascikli` smallint(5) DEFAULT '0',
  `registratorji` smallint(5) DEFAULT '0',
  `mape` smallint(5) DEFAULT '0',
  `listi` smallint(5) DEFAULT '0',
  `namenLista` char(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `knjige` smallint(5) DEFAULT '0',
  `fotografije` smallint(5) DEFAULT '0',
  `razglednice` smallint(5) DEFAULT '0',
  `diasi` smallint(5) DEFAULT '0',
  `filmskiKoluti` smallint(5) DEFAULT '0',
  `mikrofilmi` smallint(5) DEFAULT '0',
  `videoKasete` smallint(5) DEFAULT '0',
  `magfon_koluti` smallint(5) DEFAULT '0',
  `magfon_kasete` smallint(5) DEFAULT '0',
  `gramofonP` smallint(5) DEFAULT '0',
  `CD` smallint(5) DEFAULT '0',
  `pecxatniki` smallint(5) DEFAULT '0',
  `znacxke` smallint(5) DEFAULT '0',
  `medalje` smallint(5) DEFAULT '0',
  `zastave` smallint(5) DEFAULT '0',
  `lokacija` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nivoPE` int(11) unsigned NOT NULL COMMENT 'kazalec na tabelo nivope',
  `vrstaPE` int(11) unsigned DEFAULT '0' COMMENT 'kazalec na tabelo klasifikacije_arh za vrsto popisne enote',
  `oznaka` int(11) unsigned DEFAULT NULL,
  `resor_f` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opombe` longtext COLLATE utf8_unicode_ci,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IDFONDA`),
  UNIQUE KEY `ST_F` (`ST_F`),
  UNIQUE KEY `IDFONDA-NADFOND` (`IDFONDA`,`NADFOND`),
  KEY `nivoPE` (`nivoPE`,`vrstaPE`),
  KEY `vrstaPE` (`vrstaPE`),
  KEY `KLAS_F` (`KLAS_F`),
  CONSTRAINT `fondi_ibfk_1` FOREIGN KEY (`nivoPE`) REFERENCES `nivope` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1250 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `fondi_vez_klasnacrti_prov` */

DROP TABLE IF EXISTS `fondi_vez_klasnacrti_prov`;

CREATE TABLE `fondi_vez_klasnacrti_prov` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDFONDA` int(11) unsigned NOT NULL COMMENT 'kazalec na fond',
  `IDKLASNACRTA` int(11) unsigned NOT NULL COMMENT 'kazalec na klasifikacijski naèrt',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `IDFONDA` (`IDFONDA`),
  KEY `IDKLASNACRTA` (`IDKLASNACRTA`),
  CONSTRAINT `fondi_vez_klasnacrti_prov_fk` FOREIGN KEY (`IDFONDA`) REFERENCES `fondi` (`IDFONDA`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fondi_vez_klasnacrti_prov_fk1` FOREIGN KEY (`IDKLASNACRTA`) REFERENCES `klas_nacrti_prov` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `historiati_ae` */

DROP TABLE IF EXISTS `historiati_ae`;

CREATE TABLE `historiati_ae` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDFONDA` int(11) unsigned DEFAULT '0',
  `HISTORIAT` text COLLATE utf8_unicode_ci,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDFONDA` (`IDFONDA`),
  CONSTRAINT `historiati_ae_fk` FOREIGN KEY (`IDFONDA`) REFERENCES `fondi` (`IDFONDA`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=613 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `historiati_oseb` */

DROP TABLE IF EXISTS `historiati_oseb`;

CREATE TABLE `historiati_oseb` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDOSEBE` int(10) unsigned NOT NULL DEFAULT '0',
  `HISTORIAT` mediumtext COLLATE utf8_unicode_ci,
  `KHIST` text COLLATE utf8_unicode_ci,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDOSEBE` (`IDOSEBE`),
  CONSTRAINT `historiati_oseb_fk` FOREIGN KEY (`IDOSEBE`) REFERENCES `osebe` (`IDOSEBE`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=791 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `historiati_skupin` */

DROP TABLE IF EXISTS `historiati_skupin`;

CREATE TABLE `historiati_skupin` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDSKUPINE` int(11) unsigned DEFAULT '0',
  `HISTORIAT` mediumtext COLLATE utf8_unicode_ci,
  `KHIST` text COLLATE utf8_unicode_ci,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDSKUPINE` (`IDSKUPINE`),
  CONSTRAINT `historiati_skupin_fk` FOREIGN KEY (`IDSKUPINE`) REFERENCES `skupineoseb` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `klas_dob` */

DROP TABLE IF EXISTS `klas_dob`;

CREATE TABLE `klas_dob` (
  `SXIFRADOBE` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `NAZIV_DOBE` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OPIS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ID` tinyint(4) DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SXIFRADOBE`),
  UNIQUE KEY `ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `klas_doo` */

DROP TABLE IF EXISTS `klas_doo`;

CREATE TABLE `klas_doo` (
  `SXIFRADOO` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `NADDOO` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SKUPINA` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OPIS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SXIFRADOO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `klas_f` */

DROP TABLE IF EXISTS `klas_f`;

CREATE TABLE `klas_f` (
  `SXIFRASKUPINE` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `NADSKUPINA` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SKUPINA` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OPIS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SXIFRASKUPINE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `klas_nacrti_arh` */

DROP TABLE IF EXISTS `klas_nacrti_arh`;

CREATE TABLE `klas_nacrti_arh` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `OZNAKA` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `NAZIV` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `CXAS_OD` date DEFAULT NULL,
  `CXAS_DO` date DEFAULT NULL,
  `OPOMBE` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ID_OSEBNE_VLOGE` int(10) unsigned DEFAULT NULL COMMENT 'KAZALEC NA USTVARJALCA',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `OZNAKA` (`OZNAKA`),
  KEY `ID_OSEBNE_VLOGE` (`ID_OSEBNE_VLOGE`),
  CONSTRAINT `klas_nacrti_arh_fk1` FOREIGN KEY (`ID_OSEBNE_VLOGE`) REFERENCES `liferay_osebnevloge` (`IDOSEBNEVLOGE`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `klas_nacrti_prov` */

DROP TABLE IF EXISTS `klas_nacrti_prov`;

CREATE TABLE `klas_nacrti_prov` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `PODROCJE` int(11) unsigned DEFAULT NULL,
  `OZNAKA` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `NAZIV` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `ID_OSEBNE_VLOGE` int(11) unsigned DEFAULT NULL COMMENT 'KAZALEC NA USTVARJALCA',
  `CXAS_OD` date DEFAULT NULL,
  `CXAS_DO` date DEFAULT NULL,
  `OPOMBE` varchar(300) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `OZNAKA` (`OZNAKA`),
  KEY `PODROCJE` (`PODROCJE`),
  KEY `ID_OSEBNE_VLOGE` (`ID_OSEBNE_VLOGE`),
  CONSTRAINT `klas_nacrti_prov_fk1` FOREIGN KEY (`ID_OSEBNE_VLOGE`) REFERENCES `osebnevloge` (`IDOSEBNEVLOGE`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `klas_ute` */

DROP TABLE IF EXISTS `klas_ute`;

CREATE TABLE `klas_ute` (
  `SXIFRADTE` char(3) COLLATE utf8_unicode_ci NOT NULL,
  `NADDTE` varchar(3) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SKUPINA` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OPIS` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SXIFRADTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `klas_zi` */

DROP TABLE IF EXISTS `klas_zi`;

CREATE TABLE `klas_zi` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NADZI` char(4) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SXIFRAZI` char(4) COLLATE utf8_unicode_ci NOT NULL,
  `TipZI` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opisZI` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `klasf_sira` */

DROP TABLE IF EXISTS `klasf_sira`;

CREATE TABLE `klasf_sira` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OZNAKA` char(4) CHARACTER SET utf8 DEFAULT NULL,
  `KLASIFIKACIJA` varchar(200) CHARACTER SET utf8 DEFAULT NULL,
  `OPIS` text CHARACTER SET utf8,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `klasfaris_klasfsira` */

DROP TABLE IF EXISTS `klasfaris_klasfsira`;

CREATE TABLE `klasfaris_klasfsira` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDKLASFARIS` int(10) unsigned NOT NULL,
  `IDKLASFSIRA` int(10) unsigned NOT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `klasfaris_klasfsira_1` (`IDKLASFARIS`),
  KEY `klasfaris_klasfsira_2` (`IDKLASFSIRA`),
  CONSTRAINT `klasfaris_klasfsira_1` FOREIGN KEY (`IDKLASFARIS`) REFERENCES `klasifikacije_arh` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `klasfaris_klasfsira_2` FOREIGN KEY (`IDKLASFSIRA`) REFERENCES `klasf_sira` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `klasifikacije_arh` */

DROP TABLE IF EXISTS `klasifikacije_arh`;

CREATE TABLE `klasifikacije_arh` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NADID` int(11) unsigned DEFAULT '0',
  `IDKLASNACRTA` int(11) unsigned NOT NULL DEFAULT '0',
  `OZNAKA` char(20) COLLATE utf8_unicode_ci NOT NULL,
  `KLASIFIKACIJA` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `OPIS` text COLLATE utf8_unicode_ci,
  `REFOZN` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UX_KLASIFIKACIJA` (`IDKLASNACRTA`,`OZNAKA`),
  KEY `IDKLASNACRTA` (`IDKLASNACRTA`),
  KEY `NADID` (`NADID`),
  CONSTRAINT `FK_klasifikacije_arh_1` FOREIGN KEY (`IDKLASNACRTA`) REFERENCES `klas_nacrti_arh` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `klasifikacije_prov` */

DROP TABLE IF EXISTS `klasifikacije_prov`;

CREATE TABLE `klasifikacije_prov` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NADID` int(10) unsigned DEFAULT NULL,
  `IDKLASNACRTA` int(11) unsigned NOT NULL,
  `OZNAKA` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KLASIFIKACIJA` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OPIS` text COLLATE utf8_unicode_ci,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UX_KLASIFIKACIJA` (`IDKLASNACRTA`,`OZNAKA`),
  KEY `IDKLASNACRTA` (`IDKLASNACRTA`),
  KEY `FK_klasifikacije_prov_2` (`NADID`),
  CONSTRAINT `FK_klasifikacije_prov_1` FOREIGN KEY (`IDKLASNACRTA`) REFERENCES `klas_nacrti_prov` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `FK_klasifikacije_prov_2` FOREIGN KEY (`NADID`) REFERENCES `klasifikacije_prov` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1507 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `kontakt` */

DROP TABLE IF EXISTS `kontakt`;

CREATE TABLE `kontakt` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDOSEBE` int(11) unsigned DEFAULT NULL,
  `telefon1` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefon2` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fax` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email1` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'naslov elektronske pošte',
  `email2` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `www` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'spletna stran osebe',
  `drugo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'druge oblike kontaktiranja',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `IDOSEBE` (`IDOSEBE`),
  CONSTRAINT `kontakt_fk` FOREIGN KEY (`IDOSEBE`) REFERENCES `osebe` (`IDOSEBE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `liferay_osebnevloge` */

DROP TABLE IF EXISTS `liferay_osebnevloge`;

CREATE TABLE `liferay_osebnevloge` (
  `IDOSEBNEVLOGE` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDOSEBE` bigint(20) unsigned DEFAULT NULL COMMENT 'kazalec na liferay uporabnika',
  `IDVLOGE` bigint(20) unsigned DEFAULT NULL,
  `pridobitev` datetime DEFAULT NULL,
  `ukinitev` datetime DEFAULT NULL,
  `tip_id_osebe` int(11) unsigned DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`IDOSEBNEVLOGE`),
  KEY `IDOSEBE` (`IDOSEBE`),
  KEY `IDOSEBE_2` (`IDOSEBE`,`IDVLOGE`)
) ENGINE=InnoDB AUTO_INCREMENT=1719 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `liferay_osebnevloge_vez_fondi` */

DROP TABLE IF EXISTS `liferay_osebnevloge_vez_fondi`;

CREATE TABLE `liferay_osebnevloge_vez_fondi` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDFONDA` int(11) unsigned DEFAULT NULL,
  `IDOSEBNEVLOGE` int(11) unsigned DEFAULT NULL COMMENT 'kazalec na liferay_osebnevloge',
  `CAS_OD` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `CAS_DO` timestamp NULL DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `IDFONDA` (`IDFONDA`),
  KEY `IDOSEBNEVLOGE` (`IDOSEBNEVLOGE`),
  CONSTRAINT `lif_osebnevloge_vez_fondi_fk1` FOREIGN KEY (`IDFONDA`) REFERENCES `fondi` (`IDFONDA`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `lif_osebnevloge_vez_fondi_fk2` FOREIGN KEY (`IDOSEBNEVLOGE`) REFERENCES `liferay_osebnevloge` (`IDOSEBNEVLOGE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2404 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `maticnilist_raziskovalca` */

DROP TABLE IF EXISTS `maticnilist_raziskovalca`;

CREATE TABLE `maticnilist_raziskovalca` (
  `IDMATLISTA` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MATICNASTEV` int(10) unsigned NOT NULL,
  `DATUMODPRTJA` date NOT NULL,
  `DATUMZAPRTJA` date DEFAULT NULL,
  `IDOSEBNEVLOGE` int(10) unsigned NOT NULL COMMENT 'KAZALEC NA TEBELO liferay_osebnevloge',
  `TIMESTAMP` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`IDMATLISTA`),
  KEY `maticnilist_fk1` (`IDOSEBNEVLOGE`),
  CONSTRAINT `maticnilist_fk1` FOREIGN KEY (`IDOSEBNEVLOGE`) REFERENCES `liferay_osebnevloge` (`IDOSEBNEVLOGE`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `medosebno` */

DROP TABLE IF EXISTS `medosebno`;

CREATE TABLE `medosebno` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDOSEBE1` int(11) unsigned DEFAULT NULL COMMENT 'oseba, ki odnos vzpostavlja',
  `razmerje_do` int(11) unsigned DEFAULT NULL COMMENT 'vrsta razmerja osebe1 do osebe2',
  `IDOSEBE2` int(11) unsigned DEFAULT NULL COMMENT 'oseba na katero se odnos nanaša',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `IDOSEBE1` (`IDOSEBE1`),
  KEY `IDOSEBE2` (`IDOSEBE2`),
  CONSTRAINT `medosebno_fk1` FOREIGN KEY (`IDOSEBE1`) REFERENCES `osebe` (`IDOSEBE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `medosebno_fk2` FOREIGN KEY (`IDOSEBE2`) REFERENCES `osebe` (`IDOSEBE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `namen_rabe_ag` */

DROP TABLE IF EXISTS `namen_rabe_ag`;

CREATE TABLE `namen_rabe_ag` (
  `ID` tinyint(2) unsigned NOT NULL,
  `namen_rabe` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `namenlista` */

DROP TABLE IF EXISTS `namenlista`;

CREATE TABLE `namenlista` (
  `Znak` varchar(2) CHARACTER SET utf8 NOT NULL,
  `Opis` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`Znak`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `narocilaag` */

DROP TABLE IF EXISTS `narocilaag`;

CREATE TABLE `narocilaag` (
  `IDNAROCILA` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `STNAROCILA` int(10) unsigned NOT NULL,
  `DATUMNAROCILA` date NOT NULL,
  `VSEBINA` text COLLATE utf8_unicode_ci COMMENT 'VSEBINSKI OPIS NAROČILA',
  `IDRAZISKAVE` int(10) unsigned NOT NULL COMMENT 'KAZALEC NA PRIJAVO RAZISKAVE',
  `IDFONDA` int(10) unsigned NOT NULL,
  `ODGOVORNAOSEBA` int(10) unsigned NOT NULL COMMENT 'KAZALEC NA ČITALNIČARJA',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`IDNAROCILA`),
  KEY `narocilaag_fk1` (`IDRAZISKAVE`),
  KEY `narocilaag_fk3` (`IDFONDA`),
  CONSTRAINT `narocilaag_fk1` FOREIGN KEY (`IDRAZISKAVE`) REFERENCES `prijaveraziskav` (`IDPRIJAVE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `narocilaag_fk3` FOREIGN KEY (`IDFONDA`) REFERENCES `fondi` (`IDFONDA`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='naročilo s strani raziskovalca';

/*Table structure for table `narocilape` */

DROP TABLE IF EXISTS `narocilape`;

CREATE TABLE `narocilape` (
  `IDNAROCILAPE` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDNAROCILAAG` int(10) unsigned DEFAULT NULL,
  `IDPE` int(10) unsigned NOT NULL COMMENT 'kazalec na izbrano popisno enoto',
  `DATUMNAROCILA` date DEFAULT NULL,
  `DATUMIZDAJE` date DEFAULT NULL,
  `DATUMVRNITVE` date DEFAULT NULL,
  `ODGOVORNAOSEBA` int(10) unsigned NOT NULL COMMENT 'kazalec na odgovorno osebo v čitalnici',
  `NAROCNIK` int(10) unsigned NOT NULL COMMENT 'kazalec na raziskovalca - naročnika',
  `TS` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`IDNAROCILAPE`),
  KEY `narocilape_fk2` (`IDPE`),
  KEY `narocilape_fk1` (`IDNAROCILAAG`),
  CONSTRAINT `narocilape_fk1` FOREIGN KEY (`IDNAROCILAAG`) REFERENCES `narocilaag` (`IDNAROCILA`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `naslovi` */

DROP TABLE IF EXISTS `naslovi`;

CREATE TABLE `naslovi` (
  `idNaslova` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `DRZXAVA` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `Posxta` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Posxtna_sxt` mediumint(5) DEFAULT NULL,
  `Naselje` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `Ulica` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Hisxna_sxt` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`idNaslova`),
  KEY `idNaslova` (`idNaslova`)
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `nivope` */

DROP TABLE IF EXISTS `nivope`;

CREATE TABLE `nivope` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NADID` int(11) unsigned DEFAULT NULL,
  `OZNAKA` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `NIVOPE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OPIS` text COLLATE utf8_unicode_ci COMMENT 'DEFINICIJA VRSTE POPISNE ENOTE',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `oblikape` */

DROP TABLE IF EXISTS `oblikape`;

CREATE TABLE `oblikape` (
  `OblikaPE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `NADID` smallint(5) DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `obstoj_popisa` */

DROP TABLE IF EXISTS `obstoj_popisa`;

CREATE TABLE `obstoj_popisa` (
  `OZNAKA` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `OPIS` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`OZNAKA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `organi` */

DROP TABLE IF EXISTS `organi`;

CREATE TABLE `organi` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NADID` int(11) unsigned DEFAULT NULL,
  `OZNAKA` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NAZIV` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OPOMBE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ORGANIGRAM` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'kazalec na organigram',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `NADID` (`NADID`),
  KEY `ORGANIGRAM` (`ORGANIGRAM`),
  CONSTRAINT `organi_fk1` FOREIGN KEY (`NADID`) REFERENCES `organi` (`ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `organi_fk2` FOREIGN KEY (`ORGANIGRAM`) REFERENCES `organigrami` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `organigrami` */

DROP TABLE IF EXISTS `organigrami`;

CREATE TABLE `organigrami` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `OZNAKA` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NAZIV` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CXAS_OD` date DEFAULT NULL,
  `CXAS_DO` datetime DEFAULT NULL,
  `OPOMBE` tinytext COLLATE utf8_unicode_ci,
  `IDOSEBE` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'kazalec na pravno osebo',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `OZNAKA` (`OZNAKA`),
  KEY `IDOSEBE` (`IDOSEBE`),
  CONSTRAINT `organigrami_fk1` FOREIGN KEY (`IDOSEBE`) REFERENCES `osebe` (`IDOSEBE`) ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `osebe` */

DROP TABLE IF EXISTS `osebe`;

CREATE TABLE `osebe` (
  `IDOSEBE` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TipOsebe` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `Priimek` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Ime` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DatumRojstva` date DEFAULT NULL,
  `LetoRojstva` smallint(4) DEFAULT '0' COMMENT '0 = neznano',
  `KrajRojstva` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `DrzxavaRojstva` char(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DatumSmrti` date DEFAULT NULL,
  `LetoSmrti` smallint(4) DEFAULT '0' COMMENT '0 = neznano',
  `KrajSmrti` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DrzxavaSmrti` char(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STATUS` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0="v urejanju", 1="objavljena", 2="izbrisana"',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` tinyint(1) DEFAULT NULL COMMENT 'ali je oseba še aktivna: 0="ne", 1="da"',
  PRIMARY KEY (`IDOSEBE`),
  UNIQUE KEY `edina_oseba` (`Priimek`,`Ime`,`LetoRojstva`,`KrajRojstva`)
) ENGINE=InnoDB AUTO_INCREMENT=1252 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `osebe1` */

DROP TABLE IF EXISTS `osebe1`;

CREATE TABLE `osebe1` (
  `IDOSEBE` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TipOsebe` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `Priimek` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `Ime` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DatumRojstva` date DEFAULT NULL,
  `LetoRojstva` smallint(4) DEFAULT '0' COMMENT '0 = neznano',
  `KrajRojstva` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `DrzxavaRojstva` char(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DatumSmrti` date DEFAULT NULL,
  `LetoSmrti` smallint(4) DEFAULT '0' COMMENT '0 = neznano',
  `KrajSmrti` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `DrzxavaSmrti` char(60) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STATUS` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0="v urejanju", 1="objavljena", 2="izbrisana"',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` tinyint(1) DEFAULT NULL COMMENT 'ali je oseba še aktivna: 0="ne", 1="da"',
  PRIMARY KEY (`IDOSEBE`)
) ENGINE=InnoDB AUTO_INCREMENT=1249 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `osebe_vez_naslovi` */

DROP TABLE IF EXISTS `osebe_vez_naslovi`;

CREATE TABLE `osebe_vez_naslovi` (
  `idOsebnegaNaslova` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idOsebe` int(11) unsigned DEFAULT '0',
  `idNaslova` int(11) unsigned DEFAULT '0',
  `ODNOS` tinyint(1) unsigned DEFAULT '0' COMMENT '0 = STALNI NASLOV; 1 = ZAÈASNI NASLOV',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idOsebnegaNaslova`),
  KEY `idOsebe` (`idOsebe`),
  KEY `idNaslova` (`idNaslova`),
  CONSTRAINT `osebe_vez_naslovi_fk` FOREIGN KEY (`idNaslova`) REFERENCES `naslovi` (`idNaslova`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `osebe_vez_naslovi_fk1` FOREIGN KEY (`idOsebe`) REFERENCES `osebe` (`IDOSEBE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `osebe_vez_naslovi_1` */

DROP TABLE IF EXISTS `osebe_vez_naslovi_1`;

CREATE TABLE `osebe_vez_naslovi_1` (
  `idOsebnegaNaslova` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idOsebe` int(11) unsigned DEFAULT '0',
  `idNaslova` int(11) unsigned DEFAULT '0',
  `ODNOS` tinyint(1) unsigned DEFAULT '0' COMMENT '0 = STALNI NASLOV; 1 = ZAÈASNI NASLOV',
  `LETO_OD` decimal(4,0) unsigned DEFAULT NULL,
  `LETO_DO` decimal(4,0) unsigned DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`idOsebnegaNaslova`),
  KEY `idOsebe` (`idOsebe`),
  KEY `idNaslova` (`idNaslova`),
  KEY `Leto_od_do` (`LETO_OD`,`LETO_DO`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `osebe_vez_skupineoseb` */

DROP TABLE IF EXISTS `osebe_vez_skupineoseb`;

CREATE TABLE `osebe_vez_skupineoseb` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDOSEBE` int(11) unsigned DEFAULT '0',
  `IDSKUPINE` int(11) unsigned DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `IDOSEBE` (`IDOSEBE`),
  KEY `IDSKUPINE` (`IDSKUPINE`),
  CONSTRAINT `osebe_vez_skupineoseb_fk` FOREIGN KEY (`IDOSEBE`) REFERENCES `osebe` (`IDOSEBE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `osebe_vez_skupineoseb_fk1` FOREIGN KEY (`IDSKUPINE`) REFERENCES `skupineoseb` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=467 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `osebnevloge` */

DROP TABLE IF EXISTS `osebnevloge`;

CREATE TABLE `osebnevloge` (
  `IDOSEBNEVLOGE` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDOSEBE` int(10) unsigned NOT NULL,
  `IDVLOGE` smallint(5) unsigned NOT NULL,
  `pridobitev` datetime DEFAULT NULL,
  `ukinitev` datetime DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IDOSEBNEVLOGE`),
  KEY `IDOSEBE` (`IDOSEBE`),
  KEY `IDVLOGE` (`IDVLOGE`),
  CONSTRAINT `osebnevloge_fk` FOREIGN KEY (`IDOSEBE`) REFERENCES `osebe` (`IDOSEBE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `osebnevloge_fk1` FOREIGN KEY (`IDVLOGE`) REFERENCES `vloge` (`idVloge`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1398 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `osebnevloge_fondi_akcesije` */

DROP TABLE IF EXISTS `osebnevloge_fondi_akcesije`;

CREATE TABLE `osebnevloge_fondi_akcesije` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDOSEBE_F` int(11) unsigned NOT NULL COMMENT 'KAZALEC NA TABELO OSEBNEVLOGE_VEZ_FONDI',
  `IDAKCESIJE_F` int(11) unsigned NOT NULL COMMENT 'KAZALEC NA TABELO AKC_VEZ_FONDI',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `osebnevloge_fondi_akcesije_unique` (`IDOSEBE_F`,`IDAKCESIJE_F`),
  KEY `osebnevloge_fondi_akcesije_fk1` (`IDOSEBE_F`),
  KEY `osebnevloge_fondi_akcesije_fk2` (`IDAKCESIJE_F`),
  CONSTRAINT `osebnevloge_fondi_akcesije_fk1` FOREIGN KEY (`IDOSEBE_F`) REFERENCES `osebnevloge_vez_fondi` (`IDOSEBE_F`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `osebnevloge_fondi_akcesije_fk2` FOREIGN KEY (`IDAKCESIJE_F`) REFERENCES `akc_vez_fondi` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=238 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `osebnevloge_vez_fondi` */

DROP TABLE IF EXISTS `osebnevloge_vez_fondi`;

CREATE TABLE `osebnevloge_vez_fondi` (
  `IDOSEBE_F` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDFONDA` int(11) unsigned NOT NULL,
  `IDOSEBNEVLOGE` int(11) unsigned NOT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CXAS_OD` date DEFAULT NULL COMMENT 'čas pridobitve osebne vloge v fondu',
  `CXAS_DO` date DEFAULT NULL COMMENT 'čas zaključka osebne vloge v fondu',
  PRIMARY KEY (`IDOSEBE_F`),
  UNIQUE KEY `AKTER-FOND` (`IDFONDA`,`IDOSEBNEVLOGE`),
  KEY `IDFONDA` (`IDFONDA`),
  KEY `IDOSEBNEVLOGE` (`IDOSEBNEVLOGE`),
  CONSTRAINT `osebnevloge_vez_fondi_fk` FOREIGN KEY (`IDFONDA`) REFERENCES `fondi` (`IDFONDA`) ON UPDATE CASCADE,
  CONSTRAINT `osebnevloge_vez_fondi_fk2` FOREIGN KEY (`IDOSEBNEVLOGE`) REFERENCES `osebnevloge` (`IDOSEBNEVLOGE`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1354 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `osebnevloge_vez_pe` */

DROP TABLE IF EXISTS `osebnevloge_vez_pe`;

CREATE TABLE `osebnevloge_vez_pe` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDPE` int(11) unsigned DEFAULT NULL,
  `IDOSEBNEVLOGE` int(11) unsigned DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `AKTER-PE` (`IDPE`,`IDOSEBNEVLOGE`),
  KEY `IDPE` (`IDPE`),
  KEY `IDOSEBNEVLOGE` (`IDOSEBNEVLOGE`),
  CONSTRAINT `osebnevloge_vez_pe_fk1` FOREIGN KEY (`IDPE`) REFERENCES `popisneenote` (`IDPE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `osebnevloge_vez_pe_fk2` FOREIGN KEY (`IDOSEBNEVLOGE`) REFERENCES `osebnevloge` (`IDOSEBNEVLOGE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `pe_vez_fe` */

DROP TABLE IF EXISTS `pe_vez_fe`;

CREATE TABLE `pe_vez_fe` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idFE` int(10) unsigned DEFAULT NULL COMMENT 'kazalec na fizično enoto',
  `idPE` int(10) unsigned DEFAULT NULL COMMENT 'kazalec na popisno enoto',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `idFE` (`idFE`),
  KEY `idPE` (`idPE`),
  CONSTRAINT `pe_vez_fe_fk1` FOREIGN KEY (`idFE`) REFERENCES `fizicneenote` (`idFE`) ON UPDATE CASCADE,
  CONSTRAINT `pe_vez_fe_fk2` FOREIGN KEY (`idPE`) REFERENCES `popisneenote` (`IDPE`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Povezovalna tabela med vsebinskimi in fizičnimi enotami popi';

/*Table structure for table `pe_vez_zi` */

DROP TABLE IF EXISTS `pe_vez_zi`;

CREATE TABLE `pe_vez_zi` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_PE` int(11) unsigned DEFAULT NULL,
  `ID_ZI` int(11) unsigned DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_PE` (`ID_PE`),
  KEY `ID_ZI` (`ID_ZI`),
  CONSTRAINT `pe_vez_zi_fk` FOREIGN KEY (`ID_ZI`) REFERENCES `zemljepisna_imena` (`idZI`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pe_vez_zi_fk-1` FOREIGN KEY (`ID_PE`) REFERENCES `popisneenote` (`IDPE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `pete` */

DROP TABLE IF EXISTS `pete`;

CREATE TABLE `pete` (
  `IDPETE` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idPE` int(11) unsigned DEFAULT NULL,
  `idTE` int(11) unsigned DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IDPETE`),
  UNIQUE KEY `idx_pete_idPE_idTE` (`idPE`,`idTE`),
  KEY `idPE` (`idPE`),
  KEY `idTE` (`idTE`),
  CONSTRAINT `Fk_1` FOREIGN KEY (`idPE`) REFERENCES `popisneenote` (`IDPE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pete_ibfk_1` FOREIGN KEY (`idTE`) REFERENCES `tehnicneenote` (`IDTE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=199609 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `podrocxja` */

DROP TABLE IF EXISTS `podrocxja`;

CREATE TABLE `podrocxja` (
  `ID` int(10) unsigned NOT NULL,
  `NADID` int(10) unsigned DEFAULT NULL COMMENT 'KAZALEC NA ŠIRŠE PODROČJE DELA',
  `PODROCJE` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT 'NAZIV PODROČJA DELA',
  `SKD` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'ŠIFRA IZ STANDARDNE KLASIFIKACIJE DEJAVNOSTI',
  `OPOMBE` text COLLATE utf8_unicode_ci,
  `TS` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `ixNADID` (`NADID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

/*Table structure for table `popisneenote` */

DROP TABLE IF EXISTS `popisneenote`;

CREATE TABLE `popisneenote` (
  `IDPE` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NADPE` int(11) unsigned DEFAULT '0',
  `IDFONDA` int(11) unsigned NOT NULL,
  `ST_PE` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `PREJSIGN` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NIVOPE` int(10) unsigned NOT NULL DEFAULT '0',
  `DELSXTEV1` smallint(5) unsigned DEFAULT NULL,
  `DELSXTEV2` smallint(5) unsigned DEFAULT NULL,
  `LETO_ODPRTJA` smallint(5) unsigned NOT NULL,
  `LETO_ZAPRTJA` smallint(5) unsigned DEFAULT NULL,
  `NASLOVPE` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `VSEBINA` text COLLATE utf8_unicode_ci,
  `CXASGR_OD` date DEFAULT NULL,
  `CXASPRIB` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'vrsta časovnega približka',
  `CXASGR_DO` date DEFAULT NULL,
  `OPOMBE_CXAS` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `KL_1` int(11) unsigned DEFAULT NULL COMMENT 'kazalec na provenienčno klasifikacijo zadeve',
  `LINK` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bris` tinyint(1) NOT NULL DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `DOSTOPNO_OD` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'PRAVNA DOSTOPNOST',
  `OPOMBE` text COLLATE utf8_unicode_ci,
  `ROKHRAMBE` varchar(2) COLLATE utf8_unicode_ci DEFAULT NULL,
  `VRSTAPE` int(10) unsigned DEFAULT NULL COMMENT 'KAZALEC NA VRSTO PE',
  PRIMARY KEY (`IDPE`),
  UNIQUE KEY `uniq_PE` (`IDFONDA`,`ST_PE`),
  KEY `fk_FOND` (`IDFONDA`),
  KEY `KL_1` (`KL_1`),
  KEY `popisneenote_fk1` (`NADPE`),
  KEY `nivope` (`NIVOPE`),
  KEY `vrstape` (`VRSTAPE`),
  CONSTRAINT `popisneenote_fk` FOREIGN KEY (`IDFONDA`) REFERENCES `fondi` (`IDFONDA`) ON UPDATE CASCADE,
  CONSTRAINT `popisneenote_fk1` FOREIGN KEY (`NADPE`) REFERENCES `popisneenote` (`IDPE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `popisneenote_fk2` FOREIGN KEY (`KL_1`) REFERENCES `klasifikacije_prov` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `popisneenote_fk3` FOREIGN KEY (`NIVOPE`) REFERENCES `nivope` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `popisneenote_fk4` FOREIGN KEY (`VRSTAPE`) REFERENCES `klasifikacije_arh` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=199570 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `prijaveraziskav` */

DROP TABLE IF EXISTS `prijaveraziskav`;

CREATE TABLE `prijaveraziskav` (
  `IDPRIJAVE` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDMATLISTA` int(10) unsigned NOT NULL COMMENT 'KAZALEC NA MATIČNI LIST RAZISKOVALCA',
  `STPRIJAVE` int(10) unsigned NOT NULL,
  `NAMENRABE` tinyint(2) unsigned NOT NULL,
  `TEMA` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'prijavljena tema raziskave',
  `OBJAVA` tinyint(1) NOT NULL COMMENT 'ali bodo rezultati javno objavljeni? DA/NE',
  `DATUMPRIJAVE` date NOT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`IDPRIJAVE`),
  KEY `rabagradiva_fk1` (`IDMATLISTA`),
  KEY `rabagradiva_fk2` (`NAMENRABE`),
  CONSTRAINT `rabagradiva_fk1` FOREIGN KEY (`IDMATLISTA`) REFERENCES `maticnilist_raziskovalca` (`IDMATLISTA`) ON UPDATE CASCADE,
  CONSTRAINT `rabagradiva_fk2` FOREIGN KEY (`NAMENRABE`) REFERENCES `namen_rabe_ag` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `reprodukcije` */

DROP TABLE IF EXISTS `reprodukcije`;

CREATE TABLE `reprodukcije` (
  `IDREPRO` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDNAROCILAPE` int(10) unsigned NOT NULL COMMENT 'KAZALEC NA NAROČILA POPISNIH ENOT',
  `IDVRSTEREPRO` smallint(5) unsigned NOT NULL COMMENT 'KAZALEC NA VRSTO REPRODUKCIJE',
  `STEVREPRO` smallint(5) unsigned NOT NULL,
  `VSEBINA` text COLLATE utf8_unicode_ci COMMENT 'navedba reprodukciranega gradiva',
  `DATUMNAROCILA` date NOT NULL,
  `DATUMIZVEDBE` date NOT NULL,
  `ODGOVORNAOSEBA` int(10) unsigned NOT NULL COMMENT 'KAZALEC NA liferay_osebnevloge',
  `RAZISKOVALEC` int(10) unsigned NOT NULL COMMENT 'KAZALEC NA  liferay_osebnevloge',
  `TIMESTAMP` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`IDREPRO`),
  KEY `reprodukcije_fk2` (`IDVRSTEREPRO`),
  KEY `reprodukcije_fk3` (`ODGOVORNAOSEBA`),
  KEY `reprodukcije_fk1` (`IDNAROCILAPE`),
  CONSTRAINT `reprodukcije_fk1` FOREIGN KEY (`IDNAROCILAPE`) REFERENCES `narocilape` (`IDNAROCILAPE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reprodukcije_fk2` FOREIGN KEY (`IDVRSTEREPRO`) REFERENCES `vrstereprodukcij` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `reprodukcije_fk3` FOREIGN KEY (`ODGOVORNAOSEBA`) REFERENCES `liferay_osebnevloge` (`IDOSEBNEVLOGE`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `rod` */

DROP TABLE IF EXISTS `rod`;

CREATE TABLE `rod` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDPREDNIKA` int(11) unsigned NOT NULL,
  `IDNASLEDNIKA` int(11) unsigned NOT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IDX_ROD` (`IDNASLEDNIKA`,`IDPREDNIKA`),
  KEY `IDPREDNIKA` (`IDPREDNIKA`),
  KEY `IDNASLEDNIKA` (`IDNASLEDNIKA`),
  CONSTRAINT `rod_fk1` FOREIGN KEY (`IDPREDNIKA`) REFERENCES `osebe` (`IDOSEBE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rod_fk2` FOREIGN KEY (`IDNASLEDNIKA`) REFERENCES `osebe` (`IDOSEBE`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Tabela za dolocanje dedne linije oziroma pravnega nasledstva';

/*Table structure for table `skupineoseb` */

DROP TABLE IF EXISTS `skupineoseb`;

CREATE TABLE `skupineoseb` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `skupina` varchar(60) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'naziv skupine',
  `opis` text COLLATE utf8_unicode_ci,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(2) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `staresignature` */

DROP TABLE IF EXISTS `staresignature`;

CREATE TABLE `staresignature` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `IDFONDA` int(11) unsigned NOT NULL COMMENT 'kazalec na fond',
  `IDPE` int(11) unsigned DEFAULT NULL COMMENT 'kazalec na PE',
  `IDTE` int(11) unsigned DEFAULT NULL COMMENT 'kazalec na TE',
  `DRZXAVA` char(3) COLLATE utf8_unicode_ci NOT NULL COMMENT 'oznaka drzave',
  `ARHIV` char(4) COLLATE utf8_unicode_ci NOT NULL COMMENT 'oznaka arhiva',
  `ORG_ENOTA` char(3) COLLATE utf8_unicode_ci NOT NULL COMMENT 'oznaka organizacijske enote arhiva',
  `ST_F` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'stara sxtevilka fonda\r\n',
  `ST_PE` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT 'stara sxtevilka popisne enote',
  `ST_TE` varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT 'stara številka tehnične enote',
  `OSEBNAVLOGA` int(11) unsigned NOT NULL COMMENT 'kazalec na osebno vlogo odgovorne osebe - tabela liferay_osebnevloge',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UniqueSignatura` (`DRZXAVA`,`ARHIV`,`ORG_ENOTA`,`ST_F`,`ST_PE`,`ST_TE`),
  KEY `IDFONDA` (`IDFONDA`),
  KEY `IDPE` (`IDPE`),
  KEY `staresignature_fk2` (`IDTE`),
  KEY `OSEBNAVLOGA` (`OSEBNAVLOGA`),
  CONSTRAINT `staresignature_fk` FOREIGN KEY (`IDPE`) REFERENCES `popisneenote` (`IDPE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `staresignature_fk1` FOREIGN KEY (`IDFONDA`) REFERENCES `fondi` (`IDFONDA`) ON UPDATE CASCADE,
  CONSTRAINT `staresignature_fk2` FOREIGN KEY (`IDTE`) REFERENCES `tehnicneenote` (`IDTE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `staresignature_fk3` FOREIGN KEY (`OSEBNAVLOGA`) REFERENCES `liferay_osebnevloge` (`IDOSEBNEVLOGE`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=67244 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `status` */

DROP TABLE IF EXISTS `status`;

CREATE TABLE `status` (
  `ID` tinyint(1) NOT NULL,
  `STATUS` char(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `tehnicneenote` */

DROP TABLE IF EXISTS `tehnicneenote`;

CREATE TABLE `tehnicneenote` (
  `IDTE` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NADTE` int(11) unsigned DEFAULT NULL,
  `IDFONDA` int(11) unsigned NOT NULL DEFAULT '0',
  `TE` smallint(5) unsigned NOT NULL,
  `TE_TEXT` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT 'tekstovni zapis stevilke TE',
  `TIPTE` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'kazalec na vrsto tehnične enote',
  `Bris` tinyint(1) DEFAULT '0',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `U` int(11) DEFAULT NULL,
  `X` char(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`IDTE`),
  UNIQUE KEY `uniqueTE` (`IDFONDA`,`TE_TEXT`),
  KEY `IDFONDA` (`IDFONDA`),
  KEY `tehnicneenote_fk1` (`NADTE`),
  KEY `tehnicneenote_fk3` (`TIPTE`),
  CONSTRAINT `tehnicneenote_fk3` FOREIGN KEY (`TIPTE`) REFERENCES `vrstate` (`ID`) ON UPDATE CASCADE,
  CONSTRAINT `tehnicneenote_ibfk_1` FOREIGN KEY (`NADTE`) REFERENCES `tehnicneenote` (`IDTE`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tehnicneenote_ibfk_2` FOREIGN KEY (`IDFONDA`) REFERENCES `fondi` (`IDFONDA`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=216655 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `vloge` */

DROP TABLE IF EXISTS `vloge`;

CREATE TABLE `vloge` (
  `idVloge` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `vloga` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `opis` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`idVloge`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `vrstafe` */

DROP TABLE IF EXISTS `vrstafe`;

CREATE TABLE `vrstafe` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NADID` int(10) unsigned NOT NULL DEFAULT '0',
  `OZNAKA` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `VRSTAFE` varchar(120) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OPIS` text COLLATE utf8_unicode_ci,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `vrstanaslova` */

DROP TABLE IF EXISTS `vrstanaslova`;

CREATE TABLE `vrstanaslova` (
  `ID` tinyint(1) unsigned NOT NULL,
  `OPIS` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `vrstaoseb` */

DROP TABLE IF EXISTS `vrstaoseb`;

CREATE TABLE `vrstaoseb` (
  `ID` char(1) CHARACTER SET utf8 NOT NULL,
  `vrstaosebe` char(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `X` char(1) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `vrstate` */

DROP TABLE IF EXISTS `vrstate`;

CREATE TABLE `vrstate` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `NADID` int(11) unsigned DEFAULT NULL,
  `OZNAKA` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `NAZIV` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `NIVORABE` char(3) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `vrsteakcesije` */

DROP TABLE IF EXISTS `vrsteakcesije`;

CREATE TABLE `vrsteakcesije` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `OZNAKA` char(2) COLLATE utf8_unicode_ci DEFAULT '?',
  `DEJANJE` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `OPIS` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `vrstereprodukcij` */

DROP TABLE IF EXISTS `vrstereprodukcij`;

CREATE TABLE `vrstereprodukcij` (
  `ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `OZNAKA` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `OPIS` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `vsebine_ae` */

DROP TABLE IF EXISTS `vsebine_ae`;

CREATE TABLE `vsebine_ae` (
  `IDVSEBINE_AE` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDFONDA` int(11) unsigned DEFAULT '0',
  `IDPE` int(11) unsigned DEFAULT '0',
  `VSEBINA` longtext COLLATE utf8_unicode_ci,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `X` char(2) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`IDVSEBINE_AE`),
  KEY `IDFONDA` (`IDFONDA`),
  CONSTRAINT `vsebine_ae_fk` FOREIGN KEY (`IDFONDA`) REFERENCES `fondi` (`IDFONDA`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=948 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `zadeve` */

DROP TABLE IF EXISTS `zadeve`;

CREATE TABLE `zadeve` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `NADID` int(10) unsigned NOT NULL,
  `ZADEVA` text COLLATE utf8_unicode_ci NOT NULL,
  `IDPODROCJA` int(10) unsigned NOT NULL COMMENT 'kazalec na delovno področje',
  `IDOSEBE` int(10) unsigned DEFAULT NULL COMMENT 'kazalec na osebo, naaktero se zadeva nanaša',
  `IDDELAVCA` int(10) unsigned NOT NULL COMMENT 'kazalec na delavca, ki rešuje zadevo',
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `zbirfe` */

DROP TABLE IF EXISTS `zbirfe`;

CREATE TABLE `zbirfe` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `IDPE` int(11) DEFAULT NULL,
  `VRSTAFE` varchar(7) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SXTEVFE` smallint(6) unsigned DEFAULT NULL,
  `OPOMBE` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BRIS` bit(1) DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`),
  KEY `IDPE` (`IDPE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `zemljepisna_imena` */

DROP TABLE IF EXISTS `zemljepisna_imena`;

CREATE TABLE `zemljepisna_imena` (
  `idZI` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nadZI` int(11) unsigned DEFAULT NULL,
  `ZemljepisIme` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ID_KLAS_ZI` int(11) unsigned DEFAULT NULL COMMENT 'kazalec na klasifikacijo zemljepisnih imen',
  `Obstoj_od` datetime DEFAULT NULL,
  `Obstoj_do` datetime DEFAULT NULL,
  `Pogojenost` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`idZI`),
  KEY `ID_KLAS_ZI` (`ID_KLAS_ZI`),
  CONSTRAINT `fk_klas_zi` FOREIGN KEY (`ID_KLAS_ZI`) REFERENCES `klasifikacije_arh` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `zi2` */

DROP TABLE IF EXISTS `zi2`;

CREATE TABLE `zi2` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_zi1` int(11) unsigned DEFAULT NULL COMMENT 'kazalec na zemljepisno ime',
  `id_zi2` int(11) unsigned DEFAULT NULL,
  `id_zi3` int(11) unsigned DEFAULT NULL,
  `id_zi4` int(11) unsigned DEFAULT NULL,
  `id_zi5` int(11) unsigned DEFAULT NULL,
  `id_zi6` int(11) unsigned DEFAULT NULL,
  `id_zi7` int(11) unsigned DEFAULT NULL,
  `id_zi8` int(11) unsigned DEFAULT NULL,
  `id_zi9` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_zi` (`id_zi1`,`id_zi2`,`id_zi3`,`id_zi4`,`id_zi5`,`id_zi6`,`id_zi7`,`id_zi8`,`id_zi9`),
  KEY `id_zi2` (`id_zi2`),
  KEY `id_zi3` (`id_zi3`),
  KEY `id_zi4` (`id_zi4`),
  KEY `id_zi5` (`id_zi5`),
  KEY `id_zi6` (`id_zi6`),
  KEY `id_zi7` (`id_zi7`),
  KEY `id_zi8` (`id_zi8`),
  KEY `id_zi9` (`id_zi9`),
  KEY `id_zi1` (`id_zi1`),
  CONSTRAINT `drugo_zi_fk` FOREIGN KEY (`id_zi1`) REFERENCES `zemljepisna_imena` (`idZI`) ON UPDATE CASCADE,
  CONSTRAINT `drugo_zi_fk1` FOREIGN KEY (`id_zi2`) REFERENCES `zemljepisna_imena` (`idZI`) ON UPDATE CASCADE,
  CONSTRAINT `drugo_zi_fk2` FOREIGN KEY (`id_zi3`) REFERENCES `zemljepisna_imena` (`idZI`) ON UPDATE CASCADE,
  CONSTRAINT `drugo_zi_fk3` FOREIGN KEY (`id_zi4`) REFERENCES `zemljepisna_imena` (`idZI`) ON UPDATE CASCADE,
  CONSTRAINT `drugo_zi_fk4` FOREIGN KEY (`id_zi5`) REFERENCES `zemljepisna_imena` (`idZI`) ON UPDATE CASCADE,
  CONSTRAINT `drugo_zi_fk5` FOREIGN KEY (`id_zi6`) REFERENCES `zemljepisna_imena` (`idZI`) ON UPDATE CASCADE,
  CONSTRAINT `drugo_zi_fk6` FOREIGN KEY (`id_zi7`) REFERENCES `zemljepisna_imena` (`idZI`) ON UPDATE CASCADE,
  CONSTRAINT `drugo_zi_fk7` FOREIGN KEY (`id_zi8`) REFERENCES `zemljepisna_imena` (`idZI`) ON UPDATE CASCADE,
  CONSTRAINT `drugo_zi_fk8` FOREIGN KEY (`id_zi9`) REFERENCES `zemljepisna_imena` (`idZI`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Zemljepisno drugo ime / sinonimi zemljepisnih imen';

/*Table structure for table `zi_pripadnost` */

DROP TABLE IF EXISTS `zi_pripadnost`;

CREATE TABLE `zi_pripadnost` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `idZI1` int(11) unsigned DEFAULT NULL COMMENT 'obravnavana enota',
  `idZI2` int(11) unsigned DEFAULT NULL COMMENT 'nadrejena enota',
  `pripadnost` enum('3','2','1','0') COLLATE utf8_unicode_ci NOT NULL COMMENT '0 - ni znano\r\n1 - prostorska pripadnost\r\n2 - upravna pripadnost\r\n3 - prostorska in upravna pripadnost',
  `cas_od` date DEFAULT NULL COMMENT 'od kdaj pripadnost obstaja',
  `cas_do` date DEFAULT NULL COMMENT 'do kdaj pripadnost obstaja',
  `opis` text COLLATE utf8_unicode_ci,
  `TS` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idZI1` (`idZI1`),
  KEY `idZI2` (`idZI2`),
  CONSTRAINT `geopripadnost_fk` FOREIGN KEY (`idZI1`) REFERENCES `zemljepisna_imena` (`idZI`) ON UPDATE CASCADE,
  CONSTRAINT `geopripadnost_fk1` FOREIGN KEY (`idZI2`) REFERENCES `zemljepisna_imena` (`idZI`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='hierarhi?na pripadnost zemljepisnih imen';

/*Table structure for table `statistika_TE` */

DROP TABLE IF EXISTS `statistika_TE`;

/*!50001 DROP VIEW IF EXISTS `statistika_TE` */;
/*!50001 DROP TABLE IF EXISTS `statistika_TE` */;

/*!50001 CREATE TABLE  `statistika_TE`(
 `CountOfST_F` bigint(21) ,
 `SumOfarh_Skatle` decimal(27,0) ,
 `SumOffascikli` decimal(27,0) ,
 `SumOfregistratorji` decimal(27,0) ,
 `SumOfmape` decimal(27,0) ,
 `SumOflisti` decimal(27,0) ,
 `SumOfknjige` decimal(27,0) ,
 `SumOffotografije` decimal(27,0) ,
 `SumOfrazglednice` decimal(27,0) ,
 `SumOfdiasi` decimal(27,0) ,
 `SumOffilmskiKoluti` decimal(27,0) ,
 `SumOfvideoKasete` decimal(27,0) ,
 `SumOfmagfon_koluti` decimal(27,0) ,
 `SumOfmagfon_kasete` decimal(27,0) ,
 `SumOfmikrofilmi` decimal(27,0) ,
 `SumOfCD` decimal(27,0) ,
 `SumOfgramofonP` decimal(27,0) ,
 `SumOfpecxatniki` decimal(27,0) ,
 `SumOfznacxke` decimal(27,0) ,
 `SumOfmedalje` decimal(27,0) ,
 `SumOfzastave` decimal(27,0) 
)*/;

/*Table structure for table `statistika_TE_knjige` */

DROP TABLE IF EXISTS `statistika_TE_knjige`;

/*!50001 DROP VIEW IF EXISTS `statistika_TE_knjige` */;
/*!50001 DROP TABLE IF EXISTS `statistika_TE_knjige` */;

/*!50001 CREATE TABLE  `statistika_TE_knjige`(
 `NAZIV` varchar(50) ,
 `ŠtetjeodTE` bigint(21) 
)*/;

/*Table structure for table `statistika_TE_knjige_po_fondih` */

DROP TABLE IF EXISTS `statistika_TE_knjige_po_fondih`;

/*!50001 DROP VIEW IF EXISTS `statistika_TE_knjige_po_fondih` */;
/*!50001 DROP TABLE IF EXISTS `statistika_TE_knjige_po_fondih` */;

/*!50001 CREATE TABLE  `statistika_TE_knjige_po_fondih`(
 `Št. fonda` varchar(20) ,
 `Vrsta knjige` varchar(50) ,
 `Štetje_TE` bigint(21) ,
 `IDFONDA` int(11) unsigned 
)*/;

/*Table structure for table `statistika_akcesije_javno` */

DROP TABLE IF EXISTS `statistika_akcesije_javno`;

/*!50001 DROP VIEW IF EXISTS `statistika_akcesije_javno` */;
/*!50001 DROP TABLE IF EXISTS `statistika_akcesije_javno` */;

/*!50001 CREATE TABLE  `statistika_akcesije_javno`(
 `LETO` smallint(5) unsigned ,
 `ŠT_FONDOV` bigint(21) ,
 `OBSEG` decimal(33,2) 
)*/;

/*Table structure for table `statistika_akcesije_letni_obseg` */

DROP TABLE IF EXISTS `statistika_akcesije_letni_obseg`;

/*!50001 DROP VIEW IF EXISTS `statistika_akcesije_letni_obseg` */;
/*!50001 DROP TABLE IF EXISTS `statistika_akcesije_letni_obseg` */;

/*!50001 CREATE TABLE  `statistika_akcesije_letni_obseg`(
 `LETO` smallint(5) unsigned ,
 `ŠT_FONDOV` bigint(21) ,
 `OBSEG` decimal(33,2) 
)*/;

/*Table structure for table `statistika_akcesije_zasebno` */

DROP TABLE IF EXISTS `statistika_akcesije_zasebno`;

/*!50001 DROP VIEW IF EXISTS `statistika_akcesije_zasebno` */;
/*!50001 DROP TABLE IF EXISTS `statistika_akcesije_zasebno` */;

/*!50001 CREATE TABLE  `statistika_akcesije_zasebno`(
 `AKC_LETO` smallint(5) unsigned ,
 `ŠT. FONDOV` bigint(21) ,
 `VsotaodOBSEG` decimal(33,2) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_A` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_A`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_A` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_A` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_A`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_B` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_B`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_B` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_B` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_B`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_C` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_C`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_C` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_C` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_C`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_D` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_D`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_D` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_D` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_D`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_E` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_E`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_E` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_E` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_E`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_F` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_F`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_F` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_F` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_F`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_G` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_G`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_G` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_G` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_G`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_H` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_H`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_H` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_H` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_H`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_I` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_I`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_I` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_I` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_I`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_J` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_J`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_J` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_J` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_J`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_K` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_K`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_K` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_K` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_K`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_L` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_L`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_L` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_L` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_L`(
 `KLASIFIKACIJA` varchar(1) ,
 `ŠT. FONDOV` bigint(21) ,
 `OBSEG V tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_obseg_po_klasf_podrobno_vse` */

DROP TABLE IF EXISTS `statistika_obseg_po_klasf_podrobno_vse`;

/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_podrobno_vse` */;
/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_podrobno_vse` */;

/*!50001 CREATE TABLE  `statistika_obseg_po_klasf_podrobno_vse`(
 `KLAS_FONDA` char(3) ,
 `COUNT_IDFONDA` bigint(21) ,
 `SUM_TM` decimal(40,3) 
)*/;

/*Table structure for table `statistika_popisi` */

DROP TABLE IF EXISTS `statistika_popisi`;

/*!50001 DROP VIEW IF EXISTS `statistika_popisi` */;
/*!50001 DROP TABLE IF EXISTS `statistika_popisi` */;

/*!50001 CREATE TABLE  `statistika_popisi`(
 `popisi` varchar(12) ,
 `COUNT_IDFONDA` bigint(21) ,
 `SUM_TM` decimal(40,3) 
)*/;

/*Table structure for table `statistika_tm` */

DROP TABLE IF EXISTS `statistika_tm`;

/*!50001 DROP VIEW IF EXISTS `statistika_tm` */;
/*!50001 DROP TABLE IF EXISTS `statistika_tm` */;

/*!50001 CREATE TABLE  `statistika_tm`(
 `ST_FONDOV` bigint(21) ,
 `OBSEG_tm` decimal(40,3) 
)*/;

/*Table structure for table `statistika_tm_pred_prevzemom` */

DROP TABLE IF EXISTS `statistika_tm_pred_prevzemom`;

/*!50001 DROP VIEW IF EXISTS `statistika_tm_pred_prevzemom` */;
/*!50001 DROP TABLE IF EXISTS `statistika_tm_pred_prevzemom` */;

/*!50001 CREATE TABLE  `statistika_tm_pred_prevzemom`(
 `KLAS_F` char(3) ,
 `CountOfst_f` bigint(21) ,
 `SumOftm` decimal(40,3) ,
 `STATUS` enum('1','2','3','4','5') 
)*/;

/*Table structure for table `statistika_tm_status` */

DROP TABLE IF EXISTS `statistika_tm_status`;

/*!50001 DROP VIEW IF EXISTS `statistika_tm_status` */;
/*!50001 DROP TABLE IF EXISTS `statistika_tm_status` */;

/*!50001 CREATE TABLE  `statistika_tm_status`(
 `CountOfst_f` bigint(21) ,
 `SumOftm` decimal(40,3) ,
 `AvgOftm` decimal(22,7) ,
 `MaxOftm` decimal(18,3) ,
 `MinOftm` decimal(18,3) ,
 `STATUS` enum('1','2','3','4','5') 
)*/;

/*Table structure for table `vw_1popisovalec_popisi` */

DROP TABLE IF EXISTS `vw_1popisovalec_popisi`;

/*!50001 DROP VIEW IF EXISTS `vw_1popisovalec_popisi` */;
/*!50001 DROP TABLE IF EXISTS `vw_1popisovalec_popisi` */;

/*!50001 CREATE TABLE  `vw_1popisovalec_popisi`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `POPISOVALEC` varchar(151) ,
 `IDFONDA` int(11) unsigned ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `TE_TEXT` varchar(20) ,
 `NIVOPE` int(10) unsigned ,
 `KL_1` int(11) unsigned ,
 `DELSXTEV1` smallint(5) unsigned ,
 `DELSXTEV2` smallint(5) unsigned ,
 `LETO_ODPRTJA` smallint(5) unsigned ,
 `LETO_ZAPRTJA` smallint(5) unsigned ,
 `NASLOVPE` varchar(255) ,
 `VSEBINA` text ,
 `DOSTOPNO_OD` varchar(255) ,
 `OPOMBE` text ,
 `IDPE` int(11) unsigned 
)*/;

/*Table structure for table `vw_PE_pete` */

DROP TABLE IF EXISTS `vw_PE_pete`;

/*!50001 DROP VIEW IF EXISTS `vw_PE_pete` */;
/*!50001 DROP TABLE IF EXISTS `vw_PE_pete` */;

/*!50001 CREATE TABLE  `vw_PE_pete`(
 `IDPE` int(11) unsigned ,
 `NADPE` int(11) unsigned ,
 `IDFONDA` int(11) unsigned ,
 `ST_PE` varchar(20) ,
 `PREJSIGN` varchar(50) ,
 `NIVOPE` int(10) unsigned ,
 `DELSXTEV1` smallint(5) unsigned ,
 `DELSXTEV2` smallint(5) unsigned ,
 `LETO_ODPRTJA` smallint(5) unsigned ,
 `LETO_ZAPRTJA` smallint(5) unsigned ,
 `NASLOVPE` varchar(255) ,
 `VSEBINA` text ,
 `CXASGR_OD` date ,
 `CXASPRIB` varchar(1) ,
 `CXASGR_DO` date ,
 `OPOMBE_CXAS` varchar(250) ,
 `KL_1` int(11) unsigned ,
 `LINK` varchar(255) ,
 `bris` tinyint(1) ,
 `TS` timestamp ,
 `DOSTOPNO_OD` varchar(255) ,
 `OPOMBE` text ,
 `ROKHRAMBE` varchar(2) ,
 `VRSTAPE` int(10) unsigned ,
 `idTE_pete` int(11) unsigned ,
 `IDPE_pete` int(11) unsigned 
)*/;

/*Table structure for table `vw_TE` */

DROP TABLE IF EXISTS `vw_TE`;

/*!50001 DROP VIEW IF EXISTS `vw_TE` */;
/*!50001 DROP TABLE IF EXISTS `vw_TE` */;

/*!50001 CREATE TABLE  `vw_TE`(
 `IDTE` int(11) unsigned ,
 `IDFONDA` int(11) unsigned ,
 `TE` smallint(5) unsigned ,
 `TE_TEXT` varchar(20) ,
 `TIPTE` int(11) unsigned ,
 `TS` timestamp ,
 `IDTE_1` int(11) unsigned ,
 `NADTE` int(11) unsigned ,
 `IDFONDA_1` int(11) unsigned ,
 `TE_1` smallint(5) unsigned ,
 `TE_TEXT_1` varchar(20) ,
 `TIPTE_1` int(11) unsigned ,
 `TS_1` timestamp 
)*/;

/*Table structure for table `vw_TE_0` */

DROP TABLE IF EXISTS `vw_TE_0`;

/*!50001 DROP VIEW IF EXISTS `vw_TE_0` */;
/*!50001 DROP TABLE IF EXISTS `vw_TE_0` */;

/*!50001 CREATE TABLE  `vw_TE_0`(
 `IDTE` int(11) unsigned ,
 `IDFONDA` int(11) unsigned ,
 `NADTE` int(11) unsigned ,
 `TE` smallint(5) unsigned ,
 `TE_TEXT` varchar(20) ,
 `TIPTE` int(11) unsigned ,
 `TS` timestamp 
)*/;

/*Table structure for table `vw_TE_1` */

DROP TABLE IF EXISTS `vw_TE_1`;

/*!50001 DROP VIEW IF EXISTS `vw_TE_1` */;
/*!50001 DROP TABLE IF EXISTS `vw_TE_1` */;

/*!50001 CREATE TABLE  `vw_TE_1`(
 `IDTE` int(11) unsigned ,
 `IDFONDA` int(11) unsigned ,
 `NADTE` int(11) unsigned ,
 `TE` smallint(5) unsigned ,
 `TE_TEXT` varchar(20) ,
 `TIPTE` int(11) unsigned ,
 `TS` timestamp 
)*/;

/*Table structure for table `vw_TE_pete` */

DROP TABLE IF EXISTS `vw_TE_pete`;

/*!50001 DROP VIEW IF EXISTS `vw_TE_pete` */;
/*!50001 DROP TABLE IF EXISTS `vw_TE_pete` */;

/*!50001 CREATE TABLE  `vw_TE_pete`(
 `IDTE` int(11) unsigned ,
 `NADTE` int(11) unsigned ,
 `IDFONDA` int(11) unsigned ,
 `TE` smallint(5) unsigned ,
 `TE_TEXT` varchar(20) ,
 `TIPTE` int(11) unsigned ,
 `idPE_pete` int(11) unsigned ,
 `idTE_pete` int(11) unsigned 
)*/;

/*Table structure for table `vw_akc_fondov_po_letih` */

DROP TABLE IF EXISTS `vw_akc_fondov_po_letih`;

/*!50001 DROP VIEW IF EXISTS `vw_akc_fondov_po_letih` */;
/*!50001 DROP TABLE IF EXISTS `vw_akc_fondov_po_letih` */;

/*!50001 CREATE TABLE  `vw_akc_fondov_po_letih`(
 `ID` int(11) unsigned ,
 `AKC_LETO` smallint(5) unsigned ,
 `DatumAkc` date ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `OBSEG` decimal(11,2) unsigned ,
 `TE` char(20) ,
 `KLAS_F` char(3) 
)*/;

/*Table structure for table `vw_akcesije_akcvezfondi_pred2021` */

DROP TABLE IF EXISTS `vw_akcesije_akcvezfondi_pred2021`;

/*!50001 DROP VIEW IF EXISTS `vw_akcesije_akcvezfondi_pred2021` */;
/*!50001 DROP TABLE IF EXISTS `vw_akcesije_akcvezfondi_pred2021` */;

/*!50001 CREATE TABLE  `vw_akcesije_akcvezfondi_pred2021`(
 `AKC_LETO` smallint(5) unsigned ,
 `Akc_sxt` smallint(4) unsigned ,
 `VsebinaAkc` text ,
 `OBSEG` decimal(11,2) unsigned ,
 `IDFONDA` int(11) unsigned 
)*/;

/*Table structure for table `vw_akcesije_po_fondih` */

DROP TABLE IF EXISTS `vw_akcesije_po_fondih`;

/*!50001 DROP VIEW IF EXISTS `vw_akcesije_po_fondih` */;
/*!50001 DROP TABLE IF EXISTS `vw_akcesije_po_fondih` */;

/*!50001 CREATE TABLE  `vw_akcesije_po_fondih`(
 `IDFONDA2` int(11) unsigned ,
 `ORG_ENOTA` char(3) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXAS_OD` date ,
 `CXAS_DO` date ,
 `VSEBINA` varchar(500) ,
 `OPOMBE` varchar(255) ,
 `OBSEG` decimal(11,2) unsigned ,
 `TE` char(20) ,
 `TS` timestamp ,
 `ID` int(11) unsigned ,
 `IDAKCESIJE` int(11) unsigned ,
 `IDFONDA1` int(11) unsigned 
)*/;

/*Table structure for table `vw_akcesije_po_izrociteljih` */

DROP TABLE IF EXISTS `vw_akcesije_po_izrociteljih`;

/*!50001 DROP VIEW IF EXISTS `vw_akcesije_po_izrociteljih` */;
/*!50001 DROP TABLE IF EXISTS `vw_akcesije_po_izrociteljih` */;

/*!50001 CREATE TABLE  `vw_akcesije_po_izrociteljih`(
 `Priimek` varchar(255) ,
 `Ime` varchar(50) ,
 `Akc_sxt` smallint(4) unsigned ,
 `AKC_LETO` smallint(5) unsigned ,
 `DatumAkc` date ,
 `SXT_PAK` char(16) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `VSEBINA` varchar(500) ,
 `CXAS_OD` date ,
 `CXAS_DO` date ,
 `OPOMBE` varchar(255) 
)*/;

/*Table structure for table `vw_citalnicar` */

DROP TABLE IF EXISTS `vw_citalnicar`;

/*!50001 DROP VIEW IF EXISTS `vw_citalnicar` */;
/*!50001 DROP TABLE IF EXISTS `vw_citalnicar` */;

/*!50001 CREATE TABLE  `vw_citalnicar`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `IDOSEBE` bigint(20) unsigned ,
 `ÌDVLOGE` bigint(20) unsigned ,
 `lastName` varchar(75) ,
 `firstName` varchar(75) 
)*/;

/*Table structure for table `vw_fondi` */

DROP TABLE IF EXISTS `vw_fondi`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi` */;

/*!50001 CREATE TABLE  `vw_fondi`(
 `IDFONDA` int(11) unsigned ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `KLAS_F` char(3) ,
 `STATUS` enum('1','2','3','4','5') 
)*/;

/*Table structure for table `vw_fondi_osebe` */

DROP TABLE IF EXISTS `vw_fondi_osebe`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_osebe` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_osebe` */;

/*!50001 CREATE TABLE  `vw_fondi_osebe`(
 `IDOSEBE_F` int(11) unsigned ,
 `IDFONDA` int(11) unsigned ,
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `Priimek` varchar(255) ,
 `Ime` varchar(50) ,
 `LetoRojstva` smallint(4) ,
 `KrajRojstva` varchar(255) ,
 `vloga` varchar(20) 
)*/;

/*Table structure for table `vw_fondi_osebni` */

DROP TABLE IF EXISTS `vw_fondi_osebni`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_osebni` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_osebni` */;

/*!50001 CREATE TABLE  `vw_fondi_osebni`(
 `IDFONDA` int(11) unsigned ,
 `ARHIV` varchar(9) ,
 `ORG_ENOTA` char(3) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `popisi` varchar(12) ,
 `STATUS` enum('1','2','3','4','5') ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `KLAS_F` char(3) 
)*/;

/*Table structure for table `vw_fondi_popis_neznan` */

DROP TABLE IF EXISTS `vw_fondi_popis_neznan`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_popis_neznan` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_popis_neznan` */;

/*!50001 CREATE TABLE  `vw_fondi_popis_neznan`(
 `IDFONDA` int(11) unsigned ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `popisi` varchar(12) ,
 `STATUS` enum('1','2','3','4','5') 
)*/;

/*Table structure for table `vw_fondi_popisovalci` */

DROP TABLE IF EXISTS `vw_fondi_popisovalci`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_popisovalci` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_popisovalci` */;

/*!50001 CREATE TABLE  `vw_fondi_popisovalci`(
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `STATUS` enum('1','2','3','4','5') ,
 `POPISOVALEC` varchar(151) ,
 `pridobitev` timestamp ,
 `ukinitev` timestamp ,
 `active_` tinyint(4) ,
 `orgname` varchar(100) ,
 `ID` int(11) unsigned ,
 `IDFONDA` int(11) unsigned ,
 `IDOSEBNEVLOGE` int(11) unsigned 
)*/;

/*Table structure for table `vw_fondi_pred_prevzemom` */

DROP TABLE IF EXISTS `vw_fondi_pred_prevzemom`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_pred_prevzemom` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_pred_prevzemom` */;

/*!50001 CREATE TABLE  `vw_fondi_pred_prevzemom`(
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `popisi` varchar(12) ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `lokacija` varchar(50) ,
 `opombe` longtext ,
 `STATUS` enum('1','2','3','4','5') ,
 `NADFOND` int(11) unsigned ,
 `IDFONDA` int(11) unsigned 
)*/;

/*Table structure for table `vw_fondi_skrbniki` */

DROP TABLE IF EXISTS `vw_fondi_skrbniki`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_skrbniki` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_skrbniki` */;

/*!50001 CREATE TABLE  `vw_fondi_skrbniki`(
 `ID` int(11) unsigned ,
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `IDFONDA` int(11) unsigned ,
 `STATUS` enum('1','2','3','4','5') ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `popisi` varchar(12) 
)*/;

/*Table structure for table `vw_fondi_spremembe_2017` */

DROP TABLE IF EXISTS `vw_fondi_spremembe_2017`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2017` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2017` */;

/*!50001 CREATE TABLE  `vw_fondi_spremembe_2017`(
 `IDFONDA` int(11) unsigned ,
 `KLAS_F` char(3) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `opombe` longtext ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `STATUS` enum('1','2','3','4','5') 
)*/;

/*Table structure for table `vw_fondi_spremembe_2018` */

DROP TABLE IF EXISTS `vw_fondi_spremembe_2018`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2018` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2018` */;

/*!50001 CREATE TABLE  `vw_fondi_spremembe_2018`(
 `IDFONDA` int(11) unsigned ,
 `KLAS_F` char(3) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `opombe` longtext ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `STATUS` enum('1','2','3','4','5') 
)*/;

/*Table structure for table `vw_fondi_spremembe_2019` */

DROP TABLE IF EXISTS `vw_fondi_spremembe_2019`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2019` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2019` */;

/*!50001 CREATE TABLE  `vw_fondi_spremembe_2019`(
 `IDFONDA` int(11) unsigned ,
 `KLAS_F` char(3) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `opombe` longtext ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `STATUS` enum('1','2','3','4','5') 
)*/;

/*Table structure for table `vw_fondi_spremembe_2020` */

DROP TABLE IF EXISTS `vw_fondi_spremembe_2020`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2020` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2020` */;

/*!50001 CREATE TABLE  `vw_fondi_spremembe_2020`(
 `IDFONDA` int(11) unsigned ,
 `KLAS_F` char(3) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `opombe` longtext ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `STATUS` enum('1','2','3','4','5') 
)*/;

/*Table structure for table `vw_fondi_spremembe_2021` */

DROP TABLE IF EXISTS `vw_fondi_spremembe_2021`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2021` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2021` */;

/*!50001 CREATE TABLE  `vw_fondi_spremembe_2021`(
 `IDFONDA` int(11) unsigned ,
 `KLAS_F` char(3) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `opombe` longtext ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `STATUS` enum('1','2','3','4','5') 
)*/;

/*Table structure for table `vw_fondi_spremembe_2022` */

DROP TABLE IF EXISTS `vw_fondi_spremembe_2022`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2022` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2022` */;

/*!50001 CREATE TABLE  `vw_fondi_spremembe_2022`(
 `IDFONDA` int(11) unsigned ,
 `KLAS_F` char(3) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `opombe` longtext ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `STATUS` enum('1','2','3','4','5') 
)*/;

/*Table structure for table `vw_fondi_spremembe_2023` */

DROP TABLE IF EXISTS `vw_fondi_spremembe_2023`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2023` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2023` */;

/*!50001 CREATE TABLE  `vw_fondi_spremembe_2023`(
 `IDFONDA` int(11) unsigned ,
 `KLAS_F` char(3) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `opombe` longtext ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `STATUS` enum('1','2','3','4','5') 
)*/;

/*Table structure for table `vw_fondi_ukinjeni` */

DROP TABLE IF EXISTS `vw_fondi_ukinjeni`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_ukinjeni` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_ukinjeni` */;

/*!50001 CREATE TABLE  `vw_fondi_ukinjeni`(
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `popisi` varchar(12) ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `lokacija` varchar(50) ,
 `opombe` longtext ,
 `STATUS` enum('1','2','3','4','5') ,
 `NADFOND` int(11) unsigned ,
 `IDFONDA` int(11) unsigned 
)*/;

/*Table structure for table `vw_fondi_zadnje_spremembe` */

DROP TABLE IF EXISTS `vw_fondi_zadnje_spremembe`;

/*!50001 DROP VIEW IF EXISTS `vw_fondi_zadnje_spremembe` */;
/*!50001 DROP TABLE IF EXISTS `vw_fondi_zadnje_spremembe` */;

/*!50001 CREATE TABLE  `vw_fondi_zadnje_spremembe`(
 `TS` timestamp ,
 `IDFONDA` int(11) unsigned ,
 `KLAS_F` char(3) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `OPOMBE` longtext ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `TS_histor` timestamp ,
 `HISTORIAT` text 
)*/;

/*Table structure for table `vw_izpisPE` */

DROP TABLE IF EXISTS `vw_izpisPE`;

/*!50001 DROP VIEW IF EXISTS `vw_izpisPE` */;
/*!50001 DROP TABLE IF EXISTS `vw_izpisPE` */;

/*!50001 CREATE TABLE  `vw_izpisPE`(
 `TE0` smallint(5) unsigned ,
 `TE1` smallint(5) unsigned ,
 `TIP_TE` varchar(50) ,
 `ST_PE` varchar(20) ,
 `NIVOPE` varchar(50) ,
 `NASLOVPE` varchar(255) ,
 `VSEBINA` text ,
 `KL_1` int(11) unsigned ,
 `DELSXTEV1` smallint(5) unsigned ,
 `DELSXTEV2` smallint(5) unsigned ,
 `LETO_ODPRTJA` smallint(5) unsigned ,
 `LETO_ZAPRTJA` smallint(5) unsigned ,
 `DOSTOPNO_OD` varchar(255) ,
 `OPOMBE` text ,
 `IDFONDA` int(11) unsigned 
)*/;

/*Table structure for table `vw_izrocitelj_ag` */

DROP TABLE IF EXISTS `vw_izrocitelj_ag`;

/*!50001 DROP VIEW IF EXISTS `vw_izrocitelj_ag` */;
/*!50001 DROP TABLE IF EXISTS `vw_izrocitelj_ag` */;

/*!50001 CREATE TABLE  `vw_izrocitelj_ag`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `Priimek` varchar(255) ,
 `Ime` varchar(50) ,
 `KrajRojstva` varchar(255) ,
 `LetoRojstva` smallint(4) ,
 `vloga` varchar(20) ,
 `IDOSEBE` int(11) unsigned ,
 `idVloge` smallint(5) unsigned ,
 `AKTIVNA` tinyint(1) 
)*/;

/*Table structure for table `vw_klas_nacrti_prov` */

DROP TABLE IF EXISTS `vw_klas_nacrti_prov`;

/*!50001 DROP VIEW IF EXISTS `vw_klas_nacrti_prov` */;
/*!50001 DROP TABLE IF EXISTS `vw_klas_nacrti_prov` */;

/*!50001 CREATE TABLE  `vw_klas_nacrti_prov`(
 `IDFONDA` int(11) unsigned ,
 `ID` int(11) unsigned ,
 `PODROCJE` int(11) unsigned ,
 `OZNAKA` varchar(20) ,
 `NAZIV` varchar(200) ,
 `CXAS_OD` date ,
 `CXAS_DO` date ,
 `OPOMBE` varchar(300) ,
 `ID_OSEBNE_VLOGE` int(11) unsigned 
)*/;

/*Table structure for table `vw_klasfaris` */

DROP TABLE IF EXISTS `vw_klasfaris`;

/*!50001 DROP VIEW IF EXISTS `vw_klasfaris` */;
/*!50001 DROP TABLE IF EXISTS `vw_klasfaris` */;

/*!50001 CREATE TABLE  `vw_klasfaris`(
 `ID` int(11) unsigned ,
 `NADID` int(11) unsigned ,
 `IDKLASNACRTA` int(11) unsigned ,
 `OZNAKA` char(20) ,
 `KLASIFIKACIJA` varchar(200) ,
 `OPIS` text ,
 `REFOZN` char(20) ,
 `TS` timestamp 
)*/;

/*Table structure for table `vw_klasfaris_0` */

DROP TABLE IF EXISTS `vw_klasfaris_0`;

/*!50001 DROP VIEW IF EXISTS `vw_klasfaris_0` */;
/*!50001 DROP TABLE IF EXISTS `vw_klasfaris_0` */;

/*!50001 CREATE TABLE  `vw_klasfaris_0`(
 `ID` int(11) unsigned ,
 `NADID` int(11) unsigned ,
 `IDKLASNACRTA` int(11) unsigned ,
 `OZNAKA` char(20) ,
 `KLASIFIKACIJA` varchar(200) ,
 `OPIS` text ,
 `REFOZN` char(20) ,
 `TS` timestamp 
)*/;

/*Table structure for table `vw_klasfaris_1` */

DROP TABLE IF EXISTS `vw_klasfaris_1`;

/*!50001 DROP VIEW IF EXISTS `vw_klasfaris_1` */;
/*!50001 DROP TABLE IF EXISTS `vw_klasfaris_1` */;

/*!50001 CREATE TABLE  `vw_klasfaris_1`(
 `ID` int(11) unsigned ,
 `NADID` int(11) unsigned ,
 `IDKLASNACRTA` int(11) unsigned ,
 `OZNAKA` char(20) ,
 `KLASIFIKACIJA` varchar(200) ,
 `OPIS` text ,
 `REFOZN` char(20) ,
 `TS` timestamp 
)*/;

/*Table structure for table `vw_klasfsira_klasfaris` */

DROP TABLE IF EXISTS `vw_klasfsira_klasfaris`;

/*!50001 DROP VIEW IF EXISTS `vw_klasfsira_klasfaris` */;
/*!50001 DROP TABLE IF EXISTS `vw_klasfsira_klasfaris` */;

/*!50001 CREATE TABLE  `vw_klasfsira_klasfaris`(
 `IDKLASFSIRA` int(10) unsigned ,
 `ID` int(10) unsigned ,
 `OZNAKA` char(4) ,
 `KLASIFIKACIJA` varchar(200) 
)*/;

/*Table structure for table `vw_liferay_popisovalci` */

DROP TABLE IF EXISTS `vw_liferay_popisovalci`;

/*!50001 DROP VIEW IF EXISTS `vw_liferay_popisovalci` */;
/*!50001 DROP TABLE IF EXISTS `vw_liferay_popisovalci` */;

/*!50001 CREATE TABLE  `vw_liferay_popisovalci`(
 `userId` bigint(20) ,
 `firstName` varchar(75) ,
 `lastName` varchar(75) ,
 `active_` tinyint(4) ,
 `roleId` bigint(20) ,
 `rolname` varchar(75) ,
 `organizationId` bigint(20) ,
 `orgname` varchar(100) 
)*/;

/*Table structure for table `vw_liferay_users` */

DROP TABLE IF EXISTS `vw_liferay_users`;

/*!50001 DROP VIEW IF EXISTS `vw_liferay_users` */;
/*!50001 DROP TABLE IF EXISTS `vw_liferay_users` */;

/*!50001 CREATE TABLE  `vw_liferay_users`(
 `userId` bigint(20) ,
 `firstName` varchar(75) ,
 `lastName` varchar(75) ,
 `emailAddress` varchar(75) ,
 `jobTitle` varchar(100) ,
 `active_` tinyint(4) 
)*/;

/*Table structure for table `vw_nasledniki` */

DROP TABLE IF EXISTS `vw_nasledniki`;

/*!50001 DROP VIEW IF EXISTS `vw_nasledniki` */;
/*!50001 DROP TABLE IF EXISTS `vw_nasledniki` */;

/*!50001 CREATE TABLE  `vw_nasledniki`(
 `ID` int(11) unsigned ,
 `IDPREDNIKA` int(11) unsigned ,
 `IDNASLEDNIKA` int(11) unsigned ,
 `TS` timestamp 
)*/;

/*Table structure for table `vw_naslovi_oseb` */

DROP TABLE IF EXISTS `vw_naslovi_oseb`;

/*!50001 DROP VIEW IF EXISTS `vw_naslovi_oseb` */;
/*!50001 DROP TABLE IF EXISTS `vw_naslovi_oseb` */;

/*!50001 CREATE TABLE  `vw_naslovi_oseb`(
 `idNaslova` int(11) unsigned ,
 `DRZXAVA` varchar(50) ,
 `Posxta` varchar(30) ,
 `Posxtna_sxt` mediumint(5) ,
 `Naselje` varchar(30) ,
 `Ulica` varchar(30) ,
 `Hisxna_sxt` varchar(6) ,
 `TS` timestamp ,
 `idOsebe` int(11) unsigned ,
 `VrstaNaslova` tinyint(1) unsigned 
)*/;

/*Table structure for table `vw_nedostopne_PE` */

DROP TABLE IF EXISTS `vw_nedostopne_PE`;

/*!50001 DROP VIEW IF EXISTS `vw_nedostopne_PE` */;
/*!50001 DROP TABLE IF EXISTS `vw_nedostopne_PE` */;

/*!50001 CREATE TABLE  `vw_nedostopne_PE`(
 `TE_TEXT` varchar(20) ,
 `ST_PE` varchar(20) ,
 `NIVOPE` int(10) unsigned ,
 `DELSXTEV1` smallint(5) unsigned ,
 `DELSXTEV2` smallint(5) unsigned ,
 `LETO_ODPRTJA` smallint(5) unsigned ,
 `LETO_ZAPRTJA` smallint(5) unsigned ,
 `NASLOVPE` varchar(255) ,
 `VSEBINA` text ,
 `CXASGR_OD` date ,
 `CXASGR_DO` date ,
 `KL_1` int(11) unsigned ,
 `OPOMBE_CXAS` varchar(250) ,
 `DOSTOPNO_OD` varchar(255) ,
 `OPOMBE` text ,
 `IDPE` int(11) unsigned ,
 `IDFONDA` int(11) unsigned 
)*/;

/*Table structure for table `vw_osebnevloge` */

DROP TABLE IF EXISTS `vw_osebnevloge`;

/*!50001 DROP VIEW IF EXISTS `vw_osebnevloge` */;
/*!50001 DROP TABLE IF EXISTS `vw_osebnevloge` */;

/*!50001 CREATE TABLE  `vw_osebnevloge`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `IDOSEBE` int(10) unsigned ,
 `vloga` varchar(20) ,
 `pridobitev` datetime ,
 `ukinitev` datetime 
)*/;

/*Table structure for table `vw_osebnevloge_fondi` */

DROP TABLE IF EXISTS `vw_osebnevloge_fondi`;

/*!50001 DROP VIEW IF EXISTS `vw_osebnevloge_fondi` */;
/*!50001 DROP TABLE IF EXISTS `vw_osebnevloge_fondi` */;

/*!50001 CREATE TABLE  `vw_osebnevloge_fondi`(
 `IDOSEBE_F` int(11) unsigned ,
 `IDOSEBE` int(10) unsigned ,
 `vloga` varchar(20) ,
 `CXAS_OD` date ,
 `CXAS_DO` date ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) 
)*/;

/*Table structure for table `vw_osebnevloge_osebe` */

DROP TABLE IF EXISTS `vw_osebnevloge_osebe`;

/*!50001 DROP VIEW IF EXISTS `vw_osebnevloge_osebe` */;
/*!50001 DROP TABLE IF EXISTS `vw_osebnevloge_osebe` */;

/*!50001 CREATE TABLE  `vw_osebnevloge_osebe`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `IDOSEBE` int(10) unsigned ,
 `IDVLOGE` smallint(5) unsigned ,
 `Priimek` varchar(255) ,
 `Ime` varchar(50) ,
 `LetoRojstva` smallint(4) ,
 `KrajRojstva` varchar(255) ,
 `vloga` varchar(20) 
)*/;

/*Table structure for table `vw_podfondi` */

DROP TABLE IF EXISTS `vw_podfondi`;

/*!50001 DROP VIEW IF EXISTS `vw_podfondi` */;
/*!50001 DROP TABLE IF EXISTS `vw_podfondi` */;

/*!50001 CREATE TABLE  `vw_podfondi`(
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `popisi` varchar(12) ,
 `TM` decimal(18,3) ,
 `TE` varchar(20) ,
 `lokacija` varchar(50) ,
 `opombe` longtext ,
 `STATUS` enum('1','2','3','4','5') ,
 `NADFOND` int(11) unsigned ,
 `IDFONDA` int(11) unsigned 
)*/;

/*Table structure for table `vw_popisi_po_TE` */

DROP TABLE IF EXISTS `vw_popisi_po_TE`;

/*!50001 DROP VIEW IF EXISTS `vw_popisi_po_TE` */;
/*!50001 DROP TABLE IF EXISTS `vw_popisi_po_TE` */;

/*!50001 CREATE TABLE  `vw_popisi_po_TE`(
 `IDFONDA_TE` int(11) unsigned ,
 `IDTE` int(11) unsigned ,
 `NADTE` int(11) unsigned ,
 `TE` smallint(5) unsigned ,
 `TE_TEXT` varchar(20) ,
 `TIPTE` int(11) unsigned ,
 `IDPE` int(11) unsigned ,
 `NADPE` int(11) unsigned ,
 `IDFONDA_PE` int(11) unsigned ,
 `ST_PE` varchar(20) ,
 `PREJSIGN` varchar(50) ,
 `NIVOPE` int(10) unsigned ,
 `KL_1` int(11) unsigned ,
 `DELSXTEV1` smallint(5) unsigned ,
 `DELSXTEV2` smallint(5) unsigned ,
 `LETO_ODPRTJA` smallint(5) unsigned ,
 `LETO_ZAPRTJA` smallint(5) unsigned ,
 `NASLOVPE` varchar(255) ,
 `VSEBINA` text ,
 `CXASGR_OD` date ,
 `CXASPRIB` varchar(1) ,
 `CXASGR_DO` date ,
 `OPOMBE_CXAS` varchar(250) ,
 `OPOMBE` text ,
 `DOSTOPNO_OD` varchar(255) ,
 `PE_TS` timestamp 
)*/;

/*Table structure for table `vw_popisneenote` */

DROP TABLE IF EXISTS `vw_popisneenote`;

/*!50001 DROP VIEW IF EXISTS `vw_popisneenote` */;
/*!50001 DROP TABLE IF EXISTS `vw_popisneenote` */;

/*!50001 CREATE TABLE  `vw_popisneenote`(
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `TE_TEXT` varchar(20) ,
 `ST_PE` varchar(20) ,
 `DELSXTEV1` smallint(5) unsigned ,
 `DELSXTEV2` smallint(5) unsigned ,
 `LETO_ODPRTJA` smallint(5) unsigned ,
 `LETO_ZAPRTJA` smallint(5) unsigned ,
 `NASLOVPE` varchar(255) ,
 `VSEBINA` text ,
 `DOSTOPNO_OD` varchar(255) ,
 `IDPE` int(11) unsigned ,
 `IDFONDA` int(11) unsigned 
)*/;

/*Table structure for table `vw_popisovalci_fondi` */

DROP TABLE IF EXISTS `vw_popisovalci_fondi`;

/*!50001 DROP VIEW IF EXISTS `vw_popisovalci_fondi` */;
/*!50001 DROP TABLE IF EXISTS `vw_popisovalci_fondi` */;

/*!50001 CREATE TABLE  `vw_popisovalci_fondi`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `POPISOVALEC` varchar(151) ,
 `pridobitev` timestamp ,
 `ukinitev` timestamp ,
 `active_` tinyint(4) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `ID` int(11) unsigned ,
 `IDFONDA` int(11) unsigned 
)*/;

/*Table structure for table `vw_popisovalci_fondi_duplikati` */

DROP TABLE IF EXISTS `vw_popisovalci_fondi_duplikati`;

/*!50001 DROP VIEW IF EXISTS `vw_popisovalci_fondi_duplikati` */;
/*!50001 DROP TABLE IF EXISTS `vw_popisovalci_fondi_duplikati` */;

/*!50001 CREATE TABLE  `vw_popisovalci_fondi_duplikati`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `POPISOVALEC` varchar(151) ,
 `pridobitev` timestamp ,
 `ukinitev` timestamp ,
 `active_` tinyint(4) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `ID` int(11) unsigned ,
 `COUNT(``IDFONDA``)` bigint(21) 
)*/;

/*Table structure for table `vw_popisovalci_pak` */

DROP TABLE IF EXISTS `vw_popisovalci_pak`;

/*!50001 DROP VIEW IF EXISTS `vw_popisovalci_pak` */;
/*!50001 DROP TABLE IF EXISTS `vw_popisovalci_pak` */;

/*!50001 CREATE TABLE  `vw_popisovalci_pak`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `userId` bigint(20) ,
 `POPISOVALEC` varchar(151) ,
 `pridobitev` datetime ,
 `ukinitev` datetime ,
 `active_` tinyint(4) ,
 `testUser` tinyint(1) ,
 `rolename` varchar(75) ,
 `roleId` bigint(20) ,
 `orgname` varchar(100) ,
 `organizationId` bigint(20) 
)*/;

/*Table structure for table `vw_popisovalci_popisi` */

DROP TABLE IF EXISTS `vw_popisovalci_popisi`;

/*!50001 DROP VIEW IF EXISTS `vw_popisovalci_popisi` */;
/*!50001 DROP TABLE IF EXISTS `vw_popisovalci_popisi` */;

/*!50001 CREATE TABLE  `vw_popisovalci_popisi`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `POPISOVALEC` varchar(151) ,
 `pridobitev` datetime ,
 `ukinitev` datetime ,
 `active_` tinyint(4) ,
 `IDFONDA` int(11) unsigned ,
 `STATUS` enum('1','2','3','4','5') ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `ID` int(11) unsigned ,
 `NIVOPE` int(10) unsigned ,
 `NASLOVPE` varchar(255) ,
 `VSEBINA` text ,
 `KL_1` int(11) unsigned ,
 `DELSXTEV1` smallint(5) unsigned ,
 `DELSXTEV2` smallint(5) unsigned ,
 `LETO_ODPRTJA` smallint(5) unsigned ,
 `LETO_ZAPRTJA` smallint(5) unsigned ,
 `TE_TEXT` varchar(20) ,
 `NADTE` int(11) unsigned ,
 `TS` timestamp 
)*/;

/*Table structure for table `vw_predniki` */

DROP TABLE IF EXISTS `vw_predniki`;

/*!50001 DROP VIEW IF EXISTS `vw_predniki` */;
/*!50001 DROP TABLE IF EXISTS `vw_predniki` */;

/*!50001 CREATE TABLE  `vw_predniki`(
 `ID` int(11) unsigned ,
 `IDNASLEDNIKA` int(11) unsigned ,
 `IDPREDNIKA` int(11) unsigned ,
 `TS` timestamp 
)*/;

/*Table structure for table `vw_raziskovalci` */

DROP TABLE IF EXISTS `vw_raziskovalci`;

/*!50001 DROP VIEW IF EXISTS `vw_raziskovalci` */;
/*!50001 DROP TABLE IF EXISTS `vw_raziskovalci` */;

/*!50001 CREATE TABLE  `vw_raziskovalci`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `IDOSEBE` bigint(20) unsigned ,
 `IDVLOGE` bigint(20) unsigned ,
 `pridobitev` datetime ,
 `ukinitev` datetime ,
 `TS` timestamp 
)*/;

/*Table structure for table `vw_raziskovalci_pak` */

DROP TABLE IF EXISTS `vw_raziskovalci_pak`;

/*!50001 DROP VIEW IF EXISTS `vw_raziskovalci_pak` */;
/*!50001 DROP TABLE IF EXISTS `vw_raziskovalci_pak` */;

/*!50001 CREATE TABLE  `vw_raziskovalci_pak`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `raziskovalec` varchar(151) ,
 `pridobitev` datetime ,
 `ukinitev` datetime ,
 `userId` bigint(20) ,
 `active_` tinyint(4) ,
 `testUser` tinyint(1) ,
 `rolename` varchar(75) ,
 `roleId` bigint(20) ,
 `orgname` varchar(100) ,
 `organizationId` bigint(20) 
)*/;

/*Table structure for table `vw_skrbniki_fondi_popisovalci` */

DROP TABLE IF EXISTS `vw_skrbniki_fondi_popisovalci`;

/*!50001 DROP VIEW IF EXISTS `vw_skrbniki_fondi_popisovalci` */;
/*!50001 DROP TABLE IF EXISTS `vw_skrbniki_fondi_popisovalci` */;

/*!50001 CREATE TABLE  `vw_skrbniki_fondi_popisovalci`(
 `arhivist` varchar(151) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `POPISOVALEC` varchar(151) ,
 `pridobitev` timestamp ,
 `ukinitev` timestamp ,
 `active_` tinyint(4) ,
 `orgname` varchar(100) ,
 `ID` int(11) unsigned 
)*/;

/*Table structure for table `vw_skrbniki_popisovalci_fondi` */

DROP TABLE IF EXISTS `vw_skrbniki_popisovalci_fondi`;

/*!50001 DROP VIEW IF EXISTS `vw_skrbniki_popisovalci_fondi` */;
/*!50001 DROP TABLE IF EXISTS `vw_skrbniki_popisovalci_fondi` */;

/*!50001 CREATE TABLE  `vw_skrbniki_popisovalci_fondi`(
 `arhivist` varchar(151) ,
 `SKRBNIK_OD` datetime ,
 `SKRBNIK_DO` datetime ,
 `SKRBNIK_AKTIVEN` tinyint(4) ,
 `POPISOVALEC` varchar(151) ,
 `pridobitev` timestamp ,
 `ukinitev` timestamp ,
 `POPISOVALEC_AKTIVEN` tinyint(4) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `ID` int(11) unsigned ,
 `IDFONDA` int(11) unsigned 
)*/;

/*Table structure for table `vw_skrbnikifondov` */

DROP TABLE IF EXISTS `vw_skrbnikifondov`;

/*!50001 DROP VIEW IF EXISTS `vw_skrbnikifondov` */;
/*!50001 DROP TABLE IF EXISTS `vw_skrbnikifondov` */;

/*!50001 CREATE TABLE  `vw_skrbnikifondov`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `arhivist` varchar(151) ,
 `pridobitev` datetime ,
 `ukinitev` datetime ,
 `active_` tinyint(4) ,
 `testUser` tinyint(1) ,
 `rolename` varchar(75) ,
 `roleId` bigint(20) ,
 `orgname` varchar(100) ,
 `organizationId` bigint(20) 
)*/;

/*Table structure for table `vw_skrbnikifondov_aktivni` */

DROP TABLE IF EXISTS `vw_skrbnikifondov_aktivni`;

/*!50001 DROP VIEW IF EXISTS `vw_skrbnikifondov_aktivni` */;
/*!50001 DROP TABLE IF EXISTS `vw_skrbnikifondov_aktivni` */;

/*!50001 CREATE TABLE  `vw_skrbnikifondov_aktivni`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `arhivist` varchar(151) ,
 `pridobitev` datetime ,
 `ukinitev` datetime ,
 `rolename` varchar(75) ,
 `roleId` bigint(20) ,
 `orgname` varchar(100) ,
 `organizationId` bigint(20) 
)*/;

/*Table structure for table `vw_skrbnikifondov_bivsi` */

DROP TABLE IF EXISTS `vw_skrbnikifondov_bivsi`;

/*!50001 DROP VIEW IF EXISTS `vw_skrbnikifondov_bivsi` */;
/*!50001 DROP TABLE IF EXISTS `vw_skrbnikifondov_bivsi` */;

/*!50001 CREATE TABLE  `vw_skrbnikifondov_bivsi`(
 `IDOSEBNEVLOGE` int(11) unsigned ,
 `arhivist` varchar(151) ,
 `pridobitev` datetime ,
 `ukinitev` datetime ,
 `rolename` varchar(75) ,
 `roleId` bigint(20) ,
 `orgname` varchar(100) ,
 `organizationId` bigint(20) 
)*/;

/*Table structure for table `vw_zbirke` */

DROP TABLE IF EXISTS `vw_zbirke`;

/*!50001 DROP VIEW IF EXISTS `vw_zbirke` */;
/*!50001 DROP TABLE IF EXISTS `vw_zbirke` */;

/*!50001 CREATE TABLE  `vw_zbirke`(
 `IDFONDA` int(11) unsigned ,
 `ARHIV` varchar(9) ,
 `ORG_ENOTA` char(3) ,
 `ST_F` varchar(20) ,
 `IME_F` varchar(255) ,
 `CXASGR_OD` smallint(5) ,
 `CXASGR_DO` smallint(5) ,
 `popisi` varchar(12) ,
 `KLAS_F` char(3) 
)*/;

/*View structure for view statistika_TE */

/*!50001 DROP TABLE IF EXISTS `statistika_TE` */;
/*!50001 DROP VIEW IF EXISTS `statistika_TE` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_TE` AS (select count(`fondi`.`ST_F`) AS `CountOfST_F`,sum(`fondi`.`arh_Skatle`) AS `SumOfarh_Skatle`,sum(`fondi`.`fascikli`) AS `SumOffascikli`,sum(`fondi`.`registratorji`) AS `SumOfregistratorji`,sum(`fondi`.`mape`) AS `SumOfmape`,sum(`fondi`.`listi`) AS `SumOflisti`,sum(`fondi`.`knjige`) AS `SumOfknjige`,sum(`fondi`.`fotografije`) AS `SumOffotografije`,sum(`fondi`.`razglednice`) AS `SumOfrazglednice`,sum(`fondi`.`diasi`) AS `SumOfdiasi`,sum(`fondi`.`filmskiKoluti`) AS `SumOffilmskiKoluti`,sum(`fondi`.`videoKasete`) AS `SumOfvideoKasete`,sum(`fondi`.`magfon_koluti`) AS `SumOfmagfon_koluti`,sum(`fondi`.`magfon_kasete`) AS `SumOfmagfon_kasete`,sum(`fondi`.`mikrofilmi`) AS `SumOfmikrofilmi`,sum(`fondi`.`CD`) AS `SumOfCD`,sum(`fondi`.`gramofonP`) AS `SumOfgramofonP`,sum(`fondi`.`pecxatniki`) AS `SumOfpecxatniki`,sum(`fondi`.`znacxke`) AS `SumOfznacxke`,sum(`fondi`.`medalje`) AS `SumOfmedalje`,sum(`fondi`.`zastave`) AS `SumOfzastave` from `fondi` where ((`fondi`.`NADFOND` = 0) and ((`fondi`.`STATUS` = '2') or (`fondi`.`STATUS` = '1')))) */;

/*View structure for view statistika_TE_knjige */

/*!50001 DROP TABLE IF EXISTS `statistika_TE_knjige` */;
/*!50001 DROP VIEW IF EXISTS `statistika_TE_knjige` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_TE_knjige` AS (select `vrstate`.`NAZIV` AS `NAZIV`,count(`tehnicneenote`.`TE`) AS `ŠtetjeodTE` from ((`fondi` join `tehnicneenote` on((`fondi`.`IDFONDA` = `tehnicneenote`.`IDFONDA`))) join `vrstate` on((`tehnicneenote`.`TIPTE` = `vrstate`.`ID`))) where ((((`fondi`.`STATUS` = '1') or (`fondi`.`STATUS` = '2')) and (`tehnicneenote`.`TIPTE` = 2)) or (`tehnicneenote`.`TIPTE` = 3) or (`tehnicneenote`.`TIPTE` = 7) or (`tehnicneenote`.`TIPTE` = 9)) group by `vrstate`.`NAZIV`) */;

/*View structure for view statistika_TE_knjige_po_fondih */

/*!50001 DROP TABLE IF EXISTS `statistika_TE_knjige_po_fondih` */;
/*!50001 DROP VIEW IF EXISTS `statistika_TE_knjige_po_fondih` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_TE_knjige_po_fondih` AS (select `fondi`.`ST_F` AS `Št. fonda`,`vrstate`.`NAZIV` AS `Vrsta knjige`,count(`tehnicneenote`.`TE`) AS `Štetje_TE`,`fondi`.`IDFONDA` AS `IDFONDA` from ((`fondi` join `tehnicneenote` on((`fondi`.`IDFONDA` = `tehnicneenote`.`IDFONDA`))) join `vrstate` on((`tehnicneenote`.`TIPTE` = `vrstate`.`ID`))) where ((((`fondi`.`STATUS` = '1') or (`fondi`.`STATUS` = '2')) and (`tehnicneenote`.`TIPTE` = 2)) or (`tehnicneenote`.`TIPTE` = 3) or (`tehnicneenote`.`TIPTE` = 7) or (`tehnicneenote`.`TIPTE` = 9)) group by (`fondi`.`ST_F` + 0),`vrstate`.`NAZIV` desc) */;

/*View structure for view statistika_akcesije_javno */

/*!50001 DROP TABLE IF EXISTS `statistika_akcesije_javno` */;
/*!50001 DROP VIEW IF EXISTS `statistika_akcesije_javno` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_akcesije_javno` AS (select `akcesije`.`AKC_LETO` AS `LETO`,count(`akc_vez_fondi`.`IDFONDA`) AS `ŠT_FONDOV`,sum(`akc_vez_fondi`.`OBSEG`) AS `OBSEG` from (`fondi` join (`akc_vez_fondi` join `akcesije` on((`akc_vez_fondi`.`IDAKCESIJE` = `akcesije`.`IDAKCESIJE`))) on((`fondi`.`IDFONDA` = `akc_vez_fondi`.`IDFONDA`))) where ((`akcesije`.`IDVRSTEAKC` = 1) or (`akcesije`.`IDVRSTEAKC` = 2) or (`akcesije`.`IDVRSTEAKC` = 5) or (`akcesije`.`IDVRSTEAKC` = 11) or (`akcesije`.`IDVRSTEAKC` = 13)) group by `akcesije`.`AKC_LETO`) */;

/*View structure for view statistika_akcesije_letni_obseg */

/*!50001 DROP TABLE IF EXISTS `statistika_akcesije_letni_obseg` */;
/*!50001 DROP VIEW IF EXISTS `statistika_akcesije_letni_obseg` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_akcesije_letni_obseg` AS (select `akcesije`.`AKC_LETO` AS `LETO`,count(distinct `akc_vez_fondi`.`IDFONDA`) AS `ŠT_FONDOV`,sum(`akc_vez_fondi`.`OBSEG`) AS `OBSEG` from (`fondi` join (`akc_vez_fondi` join `akcesije` on((`akc_vez_fondi`.`IDAKCESIJE` = `akcesije`.`IDAKCESIJE`))) on((`fondi`.`IDFONDA` = `akc_vez_fondi`.`IDFONDA`))) where ((`akcesije`.`IDVRSTEAKC` = 1) or (`akcesije`.`IDVRSTEAKC` = 2) or (`akcesije`.`IDVRSTEAKC` = 3) or (`akcesije`.`IDVRSTEAKC` = 4) or (`akcesije`.`IDVRSTEAKC` = 5) or (`akcesije`.`IDVRSTEAKC` = 10) or (`akcesije`.`IDVRSTEAKC` = 11) or (`akcesije`.`IDVRSTEAKC` = 12) or (`akcesije`.`IDVRSTEAKC` = 13)) group by `akcesije`.`AKC_LETO` order by `akcesije`.`AKC_LETO` desc) */;

/*View structure for view statistika_akcesije_zasebno */

/*!50001 DROP TABLE IF EXISTS `statistika_akcesije_zasebno` */;
/*!50001 DROP VIEW IF EXISTS `statistika_akcesije_zasebno` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_akcesije_zasebno` AS (select `akcesije`.`AKC_LETO` AS `AKC_LETO`,count(distinct `akc_vez_fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`akc_vez_fondi`.`OBSEG`) AS `VsotaodOBSEG` from (`fondi` join (`akc_vez_fondi` join `akcesije` on((`akc_vez_fondi`.`IDAKCESIJE` = `akcesije`.`IDAKCESIJE`))) on((`fondi`.`IDFONDA` = `akc_vez_fondi`.`IDFONDA`))) where ((`akcesije`.`IDVRSTEAKC` = 3) or (`akcesije`.`IDVRSTEAKC` = 4) or (`akcesije`.`IDVRSTEAKC` = 12)) group by `akcesije`.`AKC_LETO`) */;

/*View structure for view statistika_obseg_po_klasf_A */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_A` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_A` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_A` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'A%'))) */;

/*View structure for view statistika_obseg_po_klasf_B */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_B` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_B` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_B` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'B%'))) */;

/*View structure for view statistika_obseg_po_klasf_C */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_C` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_C` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_C` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'C%'))) */;

/*View structure for view statistika_obseg_po_klasf_D */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_D` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_D` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_D` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'D%'))) */;

/*View structure for view statistika_obseg_po_klasf_E */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_E` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_E` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_E` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'E%'))) */;

/*View structure for view statistika_obseg_po_klasf_F */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_F` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_F` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_F` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'F%'))) */;

/*View structure for view statistika_obseg_po_klasf_G */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_G` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_G` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_G` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'G%'))) */;

/*View structure for view statistika_obseg_po_klasf_H */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_H` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_H` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_H` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'H%'))) */;

/*View structure for view statistika_obseg_po_klasf_I */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_I` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_I` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_I` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'I%'))) */;

/*View structure for view statistika_obseg_po_klasf_J */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_J` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_J` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_J` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'J%'))) */;

/*View structure for view statistika_obseg_po_klasf_K */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_K` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_K` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_K` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'K%'))) */;

/*View structure for view statistika_obseg_po_klasf_L */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_L` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_L` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_L` AS (select substr(`fondi`.`KLAS_F`,1,1) AS `KLASIFIKACIJA`,count(`fondi`.`IDFONDA`) AS `ŠT. FONDOV`,sum(`fondi`.`TM`) AS `OBSEG V tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0) and (`fondi`.`KLAS_F` like 'L%'))) */;

/*View structure for view statistika_obseg_po_klasf_podrobno_vse */

/*!50001 DROP TABLE IF EXISTS `statistika_obseg_po_klasf_podrobno_vse` */;
/*!50001 DROP VIEW IF EXISTS `statistika_obseg_po_klasf_podrobno_vse` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_obseg_po_klasf_podrobno_vse` AS (select `fondi`.`KLAS_F` AS `KLAS_FONDA`,count(`fondi`.`IDFONDA`) AS `COUNT_IDFONDA`,sum(`fondi`.`TM`) AS `SUM_TM` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0)) group by `fondi`.`KLAS_F`) */;

/*View structure for view statistika_popisi */

/*!50001 DROP TABLE IF EXISTS `statistika_popisi` */;
/*!50001 DROP VIEW IF EXISTS `statistika_popisi` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_popisi` AS select `fondi`.`popisi` AS `popisi`,count(`fondi`.`IDFONDA`) AS `COUNT_IDFONDA`,sum(`fondi`.`TM`) AS `SUM_TM` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0)) group by `fondi`.`popisi` */;

/*View structure for view statistika_tm */

/*!50001 DROP TABLE IF EXISTS `statistika_tm` */;
/*!50001 DROP VIEW IF EXISTS `statistika_tm` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_tm` AS (select count(`fondi`.`IDFONDA`) AS `ST_FONDOV`,sum(`fondi`.`TM`) AS `OBSEG_tm` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`NADFOND` = 0))) */;

/*View structure for view statistika_tm_pred_prevzemom */

/*!50001 DROP TABLE IF EXISTS `statistika_tm_pred_prevzemom` */;
/*!50001 DROP VIEW IF EXISTS `statistika_tm_pred_prevzemom` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_tm_pred_prevzemom` AS (select `fondi`.`KLAS_F` AS `KLAS_F`,count(`fondi`.`ST_F`) AS `CountOfst_f`,sum(`fondi`.`TM`) AS `SumOftm`,`fondi`.`STATUS` AS `STATUS` from `fondi` group by `fondi`.`STATUS`,`fondi`.`NADFOND`,`fondi`.`KLAS_F` having ((`fondi`.`STATUS` = '4') and (`fondi`.`NADFOND` = 0))) */;

/*View structure for view statistika_tm_status */

/*!50001 DROP TABLE IF EXISTS `statistika_tm_status` */;
/*!50001 DROP VIEW IF EXISTS `statistika_tm_status` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `statistika_tm_status` AS (select count(`fondi`.`ST_F`) AS `CountOfst_f`,sum(`fondi`.`TM`) AS `SumOftm`,avg(`fondi`.`TM`) AS `AvgOftm`,max(`fondi`.`TM`) AS `MaxOftm`,min(`fondi`.`TM`) AS `MinOftm`,`fondi`.`STATUS` AS `STATUS` from `fondi` where (`fondi`.`NADFOND` = 0) group by `fondi`.`STATUS` having ((`fondi`.`STATUS` = '1') or (`fondi`.`STATUS` = '2'))) */;

/*View structure for view vw_1popisovalec_popisi */

/*!50001 DROP TABLE IF EXISTS `vw_1popisovalec_popisi` */;
/*!50001 DROP VIEW IF EXISTS `vw_1popisovalec_popisi` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_1popisovalec_popisi` AS (select `vw_popisovalci_fondi`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`vw_popisovalci_fondi`.`POPISOVALEC` AS `POPISOVALEC`,`vw_popisovalci_fondi`.`IDFONDA` AS `IDFONDA`,`vw_popisovalci_fondi`.`ST_F` AS `ST_F`,`vw_popisovalci_fondi`.`IME_F` AS `IME_F`,`vw_popisovalci_fondi`.`CXASGR_OD` AS `CXASGR_OD`,`vw_popisovalci_fondi`.`CXASGR_DO` AS `CXASGR_DO`,`vw_popisi_po_TE`.`TE_TEXT` AS `TE_TEXT`,`vw_popisi_po_TE`.`NIVOPE` AS `NIVOPE`,`vw_popisi_po_TE`.`KL_1` AS `KL_1`,`vw_popisi_po_TE`.`DELSXTEV1` AS `DELSXTEV1`,`vw_popisi_po_TE`.`DELSXTEV2` AS `DELSXTEV2`,`vw_popisi_po_TE`.`LETO_ODPRTJA` AS `LETO_ODPRTJA`,`vw_popisi_po_TE`.`LETO_ZAPRTJA` AS `LETO_ZAPRTJA`,`vw_popisi_po_TE`.`NASLOVPE` AS `NASLOVPE`,`vw_popisi_po_TE`.`VSEBINA` AS `VSEBINA`,`vw_popisi_po_TE`.`DOSTOPNO_OD` AS `DOSTOPNO_OD`,`vw_popisi_po_TE`.`OPOMBE` AS `OPOMBE`,`vw_popisi_po_TE`.`IDPE` AS `IDPE` from (`pak_606`.`vw_popisi_po_TE` join `pak_606`.`vw_popisovalci_fondi` on((`vw_popisi_po_TE`.`IDFONDA_PE` = `vw_popisovalci_fondi`.`IDFONDA`))) order by `vw_popisovalci_fondi`.`POPISOVALEC`,cast(`vw_popisovalci_fondi`.`ST_F` as unsigned),cast(`vw_popisi_po_TE`.`TE_TEXT` as unsigned)) */;

/*View structure for view vw_PE_pete */

/*!50001 DROP TABLE IF EXISTS `vw_PE_pete` */;
/*!50001 DROP VIEW IF EXISTS `vw_PE_pete` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_PE_pete` AS select `popisneenote`.`IDPE` AS `IDPE`,`popisneenote`.`NADPE` AS `NADPE`,`popisneenote`.`IDFONDA` AS `IDFONDA`,`popisneenote`.`ST_PE` AS `ST_PE`,`popisneenote`.`PREJSIGN` AS `PREJSIGN`,`popisneenote`.`NIVOPE` AS `NIVOPE`,`popisneenote`.`DELSXTEV1` AS `DELSXTEV1`,`popisneenote`.`DELSXTEV2` AS `DELSXTEV2`,`popisneenote`.`LETO_ODPRTJA` AS `LETO_ODPRTJA`,`popisneenote`.`LETO_ZAPRTJA` AS `LETO_ZAPRTJA`,`popisneenote`.`NASLOVPE` AS `NASLOVPE`,`popisneenote`.`VSEBINA` AS `VSEBINA`,`popisneenote`.`CXASGR_OD` AS `CXASGR_OD`,`popisneenote`.`CXASPRIB` AS `CXASPRIB`,`popisneenote`.`CXASGR_DO` AS `CXASGR_DO`,`popisneenote`.`OPOMBE_CXAS` AS `OPOMBE_CXAS`,`popisneenote`.`KL_1` AS `KL_1`,`popisneenote`.`LINK` AS `LINK`,`popisneenote`.`bris` AS `bris`,`popisneenote`.`TS` AS `TS`,`popisneenote`.`DOSTOPNO_OD` AS `DOSTOPNO_OD`,`popisneenote`.`OPOMBE` AS `OPOMBE`,`popisneenote`.`ROKHRAMBE` AS `ROKHRAMBE`,`popisneenote`.`VRSTAPE` AS `VRSTAPE`,`pete`.`idTE` AS `idTE_pete`,`pete`.`idPE` AS `IDPE_pete` from (`popisneenote` left join `pete` on((`pete`.`idPE` = `popisneenote`.`IDPE`))) */;

/*View structure for view vw_TE */

/*!50001 DROP TABLE IF EXISTS `vw_TE` */;
/*!50001 DROP VIEW IF EXISTS `vw_TE` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_TE` AS select `tehnicneenote`.`IDTE` AS `IDTE`,`tehnicneenote`.`IDFONDA` AS `IDFONDA`,`tehnicneenote`.`TE` AS `TE`,`tehnicneenote`.`TE_TEXT` AS `TE_TEXT`,`tehnicneenote`.`TIPTE` AS `TIPTE`,`tehnicneenote`.`TS` AS `TS`,`tehnicneenote_1`.`IDTE` AS `IDTE_1`,`tehnicneenote_1`.`NADTE` AS `NADTE`,`tehnicneenote_1`.`IDFONDA` AS `IDFONDA_1`,`tehnicneenote_1`.`TE` AS `TE_1`,`tehnicneenote_1`.`TE_TEXT` AS `TE_TEXT_1`,`tehnicneenote_1`.`TIPTE` AS `TIPTE_1`,`tehnicneenote_1`.`TS` AS `TS_1` from (`tehnicneenote` `tehnicneenote_1` join `tehnicneenote` on((`tehnicneenote_1`.`NADTE` = `tehnicneenote`.`IDTE`))) order by `tehnicneenote`.`IDFONDA`,`tehnicneenote`.`TE`,`tehnicneenote_1`.`TE` */;

/*View structure for view vw_TE_0 */

/*!50001 DROP TABLE IF EXISTS `vw_TE_0` */;
/*!50001 DROP VIEW IF EXISTS `vw_TE_0` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_TE_0` AS (select `tehnicneenote`.`IDTE` AS `IDTE`,`tehnicneenote`.`IDFONDA` AS `IDFONDA`,`tehnicneenote`.`NADTE` AS `NADTE`,`tehnicneenote`.`TE` AS `TE`,`tehnicneenote`.`TE_TEXT` AS `TE_TEXT`,`tehnicneenote`.`TIPTE` AS `TIPTE`,`tehnicneenote`.`TS` AS `TS` from `tehnicneenote` where isnull(`tehnicneenote`.`NADTE`) order by `tehnicneenote`.`IDFONDA`,(`tehnicneenote`.`TE_TEXT` + 0)) */;

/*View structure for view vw_TE_1 */

/*!50001 DROP TABLE IF EXISTS `vw_TE_1` */;
/*!50001 DROP VIEW IF EXISTS `vw_TE_1` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_TE_1` AS select `tehnicneenote`.`IDTE` AS `IDTE`,`tehnicneenote`.`IDFONDA` AS `IDFONDA`,`tehnicneenote`.`NADTE` AS `NADTE`,`tehnicneenote`.`TE` AS `TE`,`tehnicneenote`.`TE_TEXT` AS `TE_TEXT`,`tehnicneenote`.`TIPTE` AS `TIPTE`,`tehnicneenote`.`TS` AS `TS` from `tehnicneenote` where (`tehnicneenote`.`NADTE` is not null) order by `tehnicneenote`.`IDFONDA`,`tehnicneenote`.`TE` */;

/*View structure for view vw_TE_pete */

/*!50001 DROP TABLE IF EXISTS `vw_TE_pete` */;
/*!50001 DROP VIEW IF EXISTS `vw_TE_pete` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_TE_pete` AS select `tehnicneenote`.`IDTE` AS `IDTE`,`tehnicneenote`.`NADTE` AS `NADTE`,`tehnicneenote`.`IDFONDA` AS `IDFONDA`,`tehnicneenote`.`TE` AS `TE`,`tehnicneenote`.`TE_TEXT` AS `TE_TEXT`,`tehnicneenote`.`TIPTE` AS `TIPTE`,`pete`.`idPE` AS `idPE_pete`,`pete`.`idTE` AS `idTE_pete` from (`tehnicneenote` left join `pete` on((`pete`.`idTE` = `tehnicneenote`.`IDTE`))) where (`tehnicneenote`.`NADTE` is not null) */;

/*View structure for view vw_akc_fondov_po_letih */

/*!50001 DROP TABLE IF EXISTS `vw_akc_fondov_po_letih` */;
/*!50001 DROP VIEW IF EXISTS `vw_akc_fondov_po_letih` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_akc_fondov_po_letih` AS select `akc_vez_fondi`.`ID` AS `ID`,`akcesije`.`AKC_LETO` AS `AKC_LETO`,`akcesije`.`DatumAkc` AS `DatumAkc`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`akc_vez_fondi`.`OBSEG` AS `OBSEG`,`akc_vez_fondi`.`TE` AS `TE`,`fondi`.`KLAS_F` AS `KLAS_F` from ((`akc_vez_fondi` join `akcesije` on((`akc_vez_fondi`.`IDAKCESIJE` = `akcesije`.`IDAKCESIJE`))) join `fondi` on((`akc_vez_fondi`.`IDFONDA` = `fondi`.`IDFONDA`))) order by `akcesije`.`AKC_LETO` desc,(`fondi`.`ST_F` + 0) */;

/*View structure for view vw_akcesije_akcvezfondi_pred2021 */

/*!50001 DROP TABLE IF EXISTS `vw_akcesije_akcvezfondi_pred2021` */;
/*!50001 DROP VIEW IF EXISTS `vw_akcesije_akcvezfondi_pred2021` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_akcesije_akcvezfondi_pred2021` AS (select `akcesije`.`AKC_LETO` AS `AKC_LETO`,`akcesije`.`Akc_sxt` AS `Akc_sxt`,`akcesije`.`VsebinaAkc` AS `VsebinaAkc`,`akc_vez_fondi`.`OBSEG` AS `OBSEG`,`akc_vez_fondi`.`IDFONDA` AS `IDFONDA` from (`akc_vez_fondi` left join `akcesije` on((`akc_vez_fondi`.`IDAKCESIJE` = `akcesije`.`IDAKCESIJE`))) where (`akcesije`.`AKC_LETO` < 2021)) */;

/*View structure for view vw_akcesije_po_fondih */

/*!50001 DROP TABLE IF EXISTS `vw_akcesije_po_fondih` */;
/*!50001 DROP VIEW IF EXISTS `vw_akcesije_po_fondih` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_akcesije_po_fondih` AS (select `fondi`.`IDFONDA` AS `IDFONDA2`,`fondi`.`ORG_ENOTA` AS `ORG_ENOTA`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`akc_vez_fondi`.`CXAS_OD` AS `CXAS_OD`,`akc_vez_fondi`.`CXAS_DO` AS `CXAS_DO`,`akc_vez_fondi`.`VSEBINA` AS `VSEBINA`,`akc_vez_fondi`.`OPOMBE` AS `OPOMBE`,`akc_vez_fondi`.`OBSEG` AS `OBSEG`,`akc_vez_fondi`.`TE` AS `TE`,`akc_vez_fondi`.`TS` AS `TS`,`akc_vez_fondi`.`ID` AS `ID`,`akc_vez_fondi`.`IDAKCESIJE` AS `IDAKCESIJE`,`akc_vez_fondi`.`IDFONDA` AS `IDFONDA1` from (`akc_vez_fondi` join `fondi` on((`akc_vez_fondi`.`IDFONDA` = `fondi`.`IDFONDA`))) order by (`fondi`.`ST_F` + 0)) */;

/*View structure for view vw_akcesije_po_izrociteljih */

/*!50001 DROP TABLE IF EXISTS `vw_akcesije_po_izrociteljih` */;
/*!50001 DROP VIEW IF EXISTS `vw_akcesije_po_izrociteljih` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_akcesije_po_izrociteljih` AS select `osebe`.`Priimek` AS `Priimek`,`osebe`.`Ime` AS `Ime`,`akcesije`.`Akc_sxt` AS `Akc_sxt`,`akcesije`.`AKC_LETO` AS `AKC_LETO`,`akcesije`.`DatumAkc` AS `DatumAkc`,`akcesije`.`SXT_PAK` AS `SXT_PAK`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`akc_vez_fondi`.`VSEBINA` AS `VSEBINA`,`akc_vez_fondi`.`CXAS_OD` AS `CXAS_OD`,`akc_vez_fondi`.`CXAS_DO` AS `CXAS_DO`,`akc_vez_fondi`.`OPOMBE` AS `OPOMBE` from ((((`osebnevloge` join `osebe` on((`osebnevloge`.`IDOSEBE` = `osebe`.`IDOSEBE`))) join `akcesije` on((`akcesije`.`IDIZROCITELJA` = `osebnevloge`.`IDOSEBNEVLOGE`))) join `akc_vez_fondi` on((`akc_vez_fondi`.`IDAKCESIJE` = `akcesije`.`IDAKCESIJE`))) join `fondi` on((`akc_vez_fondi`.`IDFONDA` = `fondi`.`IDFONDA`))) where ((`osebnevloge`.`IDVLOGE` = 1) or (`osebnevloge`.`IDVLOGE` = 2) or (`osebnevloge`.`IDVLOGE` = 3)) order by `osebe`.`Priimek`,`akcesije`.`Akc_sxt`,`akcesije`.`AKC_LETO` desc */;

/*View structure for view vw_citalnicar */

/*!50001 DROP TABLE IF EXISTS `vw_citalnicar` */;
/*!50001 DROP VIEW IF EXISTS `vw_citalnicar` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_citalnicar` AS (select `pak_606`.`liferay_osebnevloge`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`pak_606`.`liferay_osebnevloge`.`IDOSEBE` AS `IDOSEBE`,`pak_606`.`liferay_osebnevloge`.`IDVLOGE` AS `ÌDVLOGE`,`lportal_606_pak`.`User_`.`lastName` AS `lastName`,`lportal_606_pak`.`User_`.`firstName` AS `firstName` from (`lportal_606_pak`.`User_` join `pak_606`.`liferay_osebnevloge` on((`lportal_606_pak`.`User_`.`userId` = `pak_606`.`liferay_osebnevloge`.`IDOSEBE`))) where ((`pak_606`.`liferay_osebnevloge`.`IDVLOGE` = '87204') and isnull(`pak_606`.`liferay_osebnevloge`.`ukinitev`)) order by `lportal_606_pak`.`User_`.`lastName`,`lportal_606_pak`.`User_`.`firstName`) */;

/*View structure for view vw_fondi */

/*!50001 DROP TABLE IF EXISTS `vw_fondi` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi` AS select `fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`KLAS_F` AS `KLAS_F`,`fondi`.`STATUS` AS `STATUS` from `fondi` where (not((`fondi`.`STATUS` like 5))) order by (`fondi`.`ST_F` + 0) */;

/*View structure for view vw_fondi_osebe */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_osebe` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_osebe` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_osebe` AS select `osebnevloge_vez_fondi`.`IDOSEBE_F` AS `IDOSEBE_F`,`osebnevloge_vez_fondi`.`IDFONDA` AS `IDFONDA`,`osebnevloge_vez_fondi`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`osebe`.`Priimek` AS `Priimek`,`osebe`.`Ime` AS `Ime`,`osebe`.`LetoRojstva` AS `LetoRojstva`,`osebe`.`KrajRojstva` AS `KrajRojstva`,`vloge`.`vloga` AS `vloga` from (((`osebnevloge_vez_fondi` join `osebnevloge` on((`osebnevloge_vez_fondi`.`IDOSEBNEVLOGE` = `osebnevloge`.`IDOSEBNEVLOGE`))) join `osebe` on((`osebnevloge`.`IDOSEBE` = `osebe`.`IDOSEBE`))) join `vloge` on((`osebnevloge`.`IDVLOGE` = `vloge`.`idVloge`))) */;

/*View structure for view vw_fondi_osebni */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_osebni` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_osebni` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_osebni` AS (select `fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`ARHIV` AS `ARHIV`,`fondi`.`ORG_ENOTA` AS `ORG_ENOTA`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`popisi` AS `popisi`,`fondi`.`STATUS` AS `STATUS`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`KLAS_F` AS `KLAS_F` from `fondi` where (`fondi`.`KLAS_F` = 'J') order by (`fondi`.`ST_F` + 0)) */;

/*View structure for view vw_fondi_popis_neznan */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_popis_neznan` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_popis_neznan` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_popis_neznan` AS select `fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`popisi` AS `popisi`,`fondi`.`STATUS` AS `STATUS` from `fondi` where (isnull(`fondi`.`popisi`) and ((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2))) */;

/*View structure for view vw_fondi_popisovalci */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_popisovalci` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_popisovalci` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_popisovalci` AS select distinct `pak_606`.`fondi`.`ST_F` AS `ST_F`,`pak_606`.`fondi`.`IME_F` AS `IME_F`,`pak_606`.`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`pak_606`.`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`pak_606`.`fondi`.`STATUS` AS `STATUS`,`vw_popisovalci_pak`.`POPISOVALEC` AS `POPISOVALEC`,`pak_606`.`liferay_osebnevloge_vez_fondi`.`CAS_OD` AS `pridobitev`,`pak_606`.`liferay_osebnevloge_vez_fondi`.`CAS_DO` AS `ukinitev`,`vw_popisovalci_pak`.`active_` AS `active_`,`vw_popisovalci_pak`.`orgname` AS `orgname`,`pak_606`.`liferay_osebnevloge_vez_fondi`.`ID` AS `ID`,`pak_606`.`fondi`.`IDFONDA` AS `IDFONDA`,`pak_606`.`liferay_osebnevloge_vez_fondi`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE` from ((`pak_606`.`liferay_osebnevloge_vez_fondi` join `pak_606`.`vw_popisovalci_pak` on((`pak_606`.`liferay_osebnevloge_vez_fondi`.`IDOSEBNEVLOGE` = `vw_popisovalci_pak`.`IDOSEBNEVLOGE`))) join `pak_606`.`fondi` on((`pak_606`.`liferay_osebnevloge_vez_fondi`.`IDFONDA` = `pak_606`.`fondi`.`IDFONDA`))) where ((`pak_606`.`fondi`.`STATUS` = 1) or (`pak_606`.`fondi`.`STATUS` = 2) or (`pak_606`.`fondi`.`STATUS` = 4)) order by (`pak_606`.`fondi`.`ST_F` + 0) */;

/*View structure for view vw_fondi_pred_prevzemom */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_pred_prevzemom` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_pred_prevzemom` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_pred_prevzemom` AS select `fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`popisi` AS `popisi`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`lokacija` AS `lokacija`,`fondi`.`opombe` AS `opombe`,`fondi`.`STATUS` AS `STATUS`,`fondi`.`NADFOND` AS `NADFOND`,`fondi`.`IDFONDA` AS `IDFONDA` from `fondi` where (`fondi`.`STATUS` = 4) order by (`fondi`.`ST_F` + 0) */;

/*View structure for view vw_fondi_skrbniki */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_skrbniki` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_skrbniki` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_skrbniki` AS select `liferay_osebnevloge_vez_fondi`.`ID` AS `ID`,`liferay_osebnevloge_vez_fondi`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`STATUS` AS `STATUS`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`popisi` AS `popisi` from (`liferay_osebnevloge_vez_fondi` join `fondi` on((`liferay_osebnevloge_vez_fondi`.`IDFONDA` = `fondi`.`IDFONDA`))) where isnull(`liferay_osebnevloge_vez_fondi`.`CAS_DO`) order by `liferay_osebnevloge_vez_fondi`.`IDOSEBNEVLOGE`,(`fondi`.`ST_F` + 0) */;

/*View structure for view vw_fondi_spremembe_2017 */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2017` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2017` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_spremembe_2017` AS (select `fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`KLAS_F` AS `KLAS_F`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`opombe` AS `opombe`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`STATUS` AS `STATUS` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`opombe` like '%2017%')) order by `fondi`.`KLAS_F`,`fondi`.`ST_F`) */;

/*View structure for view vw_fondi_spremembe_2018 */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2018` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2018` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_spremembe_2018` AS (select `fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`KLAS_F` AS `KLAS_F`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`opombe` AS `opombe`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`STATUS` AS `STATUS` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`opombe` like '%2018%')) order by `fondi`.`KLAS_F`,`fondi`.`ST_F`) */;

/*View structure for view vw_fondi_spremembe_2019 */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2019` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2019` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_spremembe_2019` AS (select `fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`KLAS_F` AS `KLAS_F`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`opombe` AS `opombe`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`STATUS` AS `STATUS` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`opombe` like '%2019%')) order by `fondi`.`KLAS_F`,`fondi`.`ST_F`) */;

/*View structure for view vw_fondi_spremembe_2020 */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2020` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2020` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_spremembe_2020` AS (select `fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`KLAS_F` AS `KLAS_F`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`opombe` AS `opombe`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`STATUS` AS `STATUS` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`opombe` like '%2020%')) order by `fondi`.`KLAS_F`,`fondi`.`ST_F`) */;

/*View structure for view vw_fondi_spremembe_2021 */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2021` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2021` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_spremembe_2021` AS (select `fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`KLAS_F` AS `KLAS_F`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`opombe` AS `opombe`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`STATUS` AS `STATUS` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`opombe` like '%2021%')) order by `fondi`.`KLAS_F`,`fondi`.`ST_F`) */;

/*View structure for view vw_fondi_spremembe_2022 */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2022` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2022` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_spremembe_2022` AS (select `fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`KLAS_F` AS `KLAS_F`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`opombe` AS `opombe`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`STATUS` AS `STATUS` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`opombe` like '%2022%')) order by `fondi`.`KLAS_F`,`fondi`.`ST_F`) */;

/*View structure for view vw_fondi_spremembe_2023 */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_spremembe_2023` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_spremembe_2023` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_spremembe_2023` AS (select `fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`KLAS_F` AS `KLAS_F`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`opombe` AS `opombe`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`STATUS` AS `STATUS` from `fondi` where (((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) and (`fondi`.`opombe` like '%2023%')) order by `fondi`.`KLAS_F`,`fondi`.`ST_F`) */;

/*View structure for view vw_fondi_ukinjeni */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_ukinjeni` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_ukinjeni` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_ukinjeni` AS select `fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`popisi` AS `popisi`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`lokacija` AS `lokacija`,`fondi`.`opombe` AS `opombe`,`fondi`.`STATUS` AS `STATUS`,`fondi`.`NADFOND` AS `NADFOND`,`fondi`.`IDFONDA` AS `IDFONDA` from `fondi` where (`fondi`.`STATUS` = 3) group by `fondi`.`NADFOND` order by (`fondi`.`ST_F` + 0) */;

/*View structure for view vw_fondi_zadnje_spremembe */

/*!50001 DROP TABLE IF EXISTS `vw_fondi_zadnje_spremembe` */;
/*!50001 DROP VIEW IF EXISTS `vw_fondi_zadnje_spremembe` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_fondi_zadnje_spremembe` AS (select `fondi`.`TS` AS `TS`,`fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`KLAS_F` AS `KLAS_F`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`opombe` AS `OPOMBE`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`historiati_ae`.`TS` AS `TS_histor`,`historiati_ae`.`HISTORIAT` AS `HISTORIAT` from (`historiati_ae` join `fondi` on((`historiati_ae`.`IDFONDA` = `fondi`.`IDFONDA`))) where ((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2)) order by `fondi`.`TS` desc,`historiati_ae`.`TS` desc) */;

/*View structure for view vw_izpisPE */

/*!50001 DROP TABLE IF EXISTS `vw_izpisPE` */;
/*!50001 DROP VIEW IF EXISTS `vw_izpisPE` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_izpisPE` AS select `tehnicneenote_1`.`TE` AS `TE0`,`tehnicneenote`.`TE` AS `TE1`,`vrstate`.`NAZIV` AS `TIP_TE`,`popisneenote`.`ST_PE` AS `ST_PE`,`nivope`.`NIVOPE` AS `NIVOPE`,`popisneenote`.`NASLOVPE` AS `NASLOVPE`,`popisneenote`.`VSEBINA` AS `VSEBINA`,`popisneenote`.`KL_1` AS `KL_1`,`popisneenote`.`DELSXTEV1` AS `DELSXTEV1`,`popisneenote`.`DELSXTEV2` AS `DELSXTEV2`,`popisneenote`.`LETO_ODPRTJA` AS `LETO_ODPRTJA`,`popisneenote`.`LETO_ZAPRTJA` AS `LETO_ZAPRTJA`,`popisneenote`.`DOSTOPNO_OD` AS `DOSTOPNO_OD`,`popisneenote`.`OPOMBE` AS `OPOMBE`,`popisneenote`.`IDFONDA` AS `IDFONDA` from (((((`pete` join `popisneenote` on((`pete`.`idPE` = `popisneenote`.`IDPE`))) join `tehnicneenote` on((`pete`.`idTE` = `tehnicneenote`.`IDTE`))) join `tehnicneenote` `tehnicneenote_1` on((`tehnicneenote`.`NADTE` = `tehnicneenote_1`.`IDTE`))) join `nivope` on((`popisneenote`.`NIVOPE` = `nivope`.`ID`))) join `vrstate` on((`tehnicneenote`.`TIPTE` = `vrstate`.`ID`))) where (`popisneenote`.`IDFONDA` = 876) */;

/*View structure for view vw_izrocitelj_ag */

/*!50001 DROP TABLE IF EXISTS `vw_izrocitelj_ag` */;
/*!50001 DROP VIEW IF EXISTS `vw_izrocitelj_ag` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_izrocitelj_ag` AS (select `osebnevloge`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`osebe`.`Priimek` AS `Priimek`,`osebe`.`Ime` AS `Ime`,`osebe`.`KrajRojstva` AS `KrajRojstva`,`osebe`.`LetoRojstva` AS `LetoRojstva`,`vloge`.`vloga` AS `vloga`,`osebe`.`IDOSEBE` AS `IDOSEBE`,`vloge`.`idVloge` AS `idVloge`,`osebe`.`X` AS `AKTIVNA` from ((`osebe` join `osebnevloge` on((`osebe`.`IDOSEBE` = `osebnevloge`.`IDOSEBE`))) join `vloge` on((`osebnevloge`.`IDVLOGE` = `vloge`.`idVloge`))) where ((`vloge`.`idVloge` = 1) or (`vloge`.`idVloge` = 2) or (`vloge`.`idVloge` = 3)) order by `osebe`.`Priimek`,`osebe`.`Ime`) */;

/*View structure for view vw_klas_nacrti_prov */

/*!50001 DROP TABLE IF EXISTS `vw_klas_nacrti_prov` */;
/*!50001 DROP VIEW IF EXISTS `vw_klas_nacrti_prov` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_klas_nacrti_prov` AS (select `fondi_vez_klasnacrti_prov`.`IDFONDA` AS `IDFONDA`,`klas_nacrti_prov`.`ID` AS `ID`,`klas_nacrti_prov`.`PODROCJE` AS `PODROCJE`,`klas_nacrti_prov`.`OZNAKA` AS `OZNAKA`,`klas_nacrti_prov`.`NAZIV` AS `NAZIV`,`klas_nacrti_prov`.`CXAS_OD` AS `CXAS_OD`,`klas_nacrti_prov`.`CXAS_DO` AS `CXAS_DO`,`klas_nacrti_prov`.`OPOMBE` AS `OPOMBE`,`klas_nacrti_prov`.`ID_OSEBNE_VLOGE` AS `ID_OSEBNE_VLOGE` from (`fondi_vez_klasnacrti_prov` join `klas_nacrti_prov` on((`fondi_vez_klasnacrti_prov`.`IDKLASNACRTA` = `klas_nacrti_prov`.`ID`)))) */;

/*View structure for view vw_klasfaris */

/*!50001 DROP TABLE IF EXISTS `vw_klasfaris` */;
/*!50001 DROP VIEW IF EXISTS `vw_klasfaris` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_klasfaris` AS select `klasifikacije_arh`.`ID` AS `ID`,`klasifikacije_arh`.`NADID` AS `NADID`,`klasifikacije_arh`.`IDKLASNACRTA` AS `IDKLASNACRTA`,`klasifikacije_arh`.`OZNAKA` AS `OZNAKA`,`klasifikacije_arh`.`KLASIFIKACIJA` AS `KLASIFIKACIJA`,`klasifikacije_arh`.`OPIS` AS `OPIS`,`klasifikacije_arh`.`REFOZN` AS `REFOZN`,`klasifikacije_arh`.`TS` AS `TS` from `klasifikacije_arh` where (`klasifikacije_arh`.`IDKLASNACRTA` = 1) order by `klasifikacije_arh`.`OZNAKA` */;

/*View structure for view vw_klasfaris_0 */

/*!50001 DROP TABLE IF EXISTS `vw_klasfaris_0` */;
/*!50001 DROP VIEW IF EXISTS `vw_klasfaris_0` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_klasfaris_0` AS (select `klasifikacije_arh`.`ID` AS `ID`,`klasifikacije_arh`.`NADID` AS `NADID`,`klasifikacije_arh`.`IDKLASNACRTA` AS `IDKLASNACRTA`,`klasifikacije_arh`.`OZNAKA` AS `OZNAKA`,`klasifikacije_arh`.`KLASIFIKACIJA` AS `KLASIFIKACIJA`,`klasifikacije_arh`.`OPIS` AS `OPIS`,`klasifikacije_arh`.`REFOZN` AS `REFOZN`,`klasifikacije_arh`.`TS` AS `TS` from `klasifikacije_arh` where ((`klasifikacije_arh`.`IDKLASNACRTA` = 1) and (`klasifikacije_arh`.`NADID` = 0)) order by `klasifikacije_arh`.`OZNAKA`) */;

/*View structure for view vw_klasfaris_1 */

/*!50001 DROP TABLE IF EXISTS `vw_klasfaris_1` */;
/*!50001 DROP VIEW IF EXISTS `vw_klasfaris_1` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_klasfaris_1` AS (select `klasifikacije_arh`.`ID` AS `ID`,`klasifikacije_arh`.`NADID` AS `NADID`,`klasifikacije_arh`.`IDKLASNACRTA` AS `IDKLASNACRTA`,`klasifikacije_arh`.`OZNAKA` AS `OZNAKA`,`klasifikacije_arh`.`KLASIFIKACIJA` AS `KLASIFIKACIJA`,`klasifikacije_arh`.`OPIS` AS `OPIS`,`klasifikacije_arh`.`REFOZN` AS `REFOZN`,`klasifikacije_arh`.`TS` AS `TS` from `klasifikacije_arh` where ((`klasifikacije_arh`.`IDKLASNACRTA` = 1) and (`klasifikacije_arh`.`NADID` > 0)) order by `klasifikacije_arh`.`OZNAKA`) */;

/*View structure for view vw_klasfsira_klasfaris */

/*!50001 DROP TABLE IF EXISTS `vw_klasfsira_klasfaris` */;
/*!50001 DROP VIEW IF EXISTS `vw_klasfsira_klasfaris` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_klasfsira_klasfaris` AS select `klasfaris_klasfsira`.`IDKLASFSIRA` AS `IDKLASFSIRA`,`klasf_sira`.`ID` AS `ID`,`klasf_sira`.`OZNAKA` AS `OZNAKA`,`klasf_sira`.`KLASIFIKACIJA` AS `KLASIFIKACIJA` from (`klasf_sira` left join `klasfaris_klasfsira` on((`klasfaris_klasfsira`.`IDKLASFSIRA` = `klasf_sira`.`ID`))) */;

/*View structure for view vw_liferay_popisovalci */

/*!50001 DROP TABLE IF EXISTS `vw_liferay_popisovalci` */;
/*!50001 DROP VIEW IF EXISTS `vw_liferay_popisovalci` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_liferay_popisovalci` AS select `lportal_606_pak`.`User_`.`userId` AS `userId`,`lportal_606_pak`.`User_`.`firstName` AS `firstName`,`lportal_606_pak`.`User_`.`lastName` AS `lastName`,`lportal_606_pak`.`User_`.`active_` AS `active_`,`lportal_606_pak`.`Role_`.`roleId` AS `roleId`,`lportal_606_pak`.`Role_`.`name` AS `rolname`,`lportal_606_pak`.`Organization_`.`organizationId` AS `organizationId`,`lportal_606_pak`.`Organization_`.`name` AS `orgname` from ((((`lportal_606_pak`.`User_` join `lportal_606_pak`.`Users_Orgs` on((`lportal_606_pak`.`User_`.`userId` = `lportal_606_pak`.`Users_Orgs`.`userId`))) join `lportal_606_pak`.`Organization_` on((`lportal_606_pak`.`Users_Orgs`.`organizationId` = `lportal_606_pak`.`Organization_`.`organizationId`))) join `lportal_606_pak`.`Users_Roles` on((`lportal_606_pak`.`Users_Roles`.`userId` = `lportal_606_pak`.`User_`.`userId`))) join `lportal_606_pak`.`Role_` on((`lportal_606_pak`.`Users_Roles`.`roleId` = `lportal_606_pak`.`Role_`.`roleId`))) where (`lportal_606_pak`.`Role_`.`roleId` = 10655) order by `lportal_606_pak`.`User_`.`firstName`,`lportal_606_pak`.`User_`.`lastName` */;

/*View structure for view vw_liferay_users */

/*!50001 DROP TABLE IF EXISTS `vw_liferay_users` */;
/*!50001 DROP VIEW IF EXISTS `vw_liferay_users` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_liferay_users` AS select `lportal_606_pak`.`User_`.`userId` AS `userId`,`lportal_606_pak`.`User_`.`firstName` AS `firstName`,`lportal_606_pak`.`User_`.`lastName` AS `lastName`,`lportal_606_pak`.`User_`.`emailAddress` AS `emailAddress`,`lportal_606_pak`.`User_`.`jobTitle` AS `jobTitle`,`lportal_606_pak`.`User_`.`active_` AS `active_` from `lportal_606_pak`.`User_` order by `lportal_606_pak`.`User_`.`firstName`,`lportal_606_pak`.`User_`.`lastName` */;

/*View structure for view vw_nasledniki */

/*!50001 DROP TABLE IF EXISTS `vw_nasledniki` */;
/*!50001 DROP VIEW IF EXISTS `vw_nasledniki` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_nasledniki` AS select `rod`.`ID` AS `ID`,`rod`.`IDPREDNIKA` AS `IDPREDNIKA`,`rod`.`IDNASLEDNIKA` AS `IDNASLEDNIKA`,`rod`.`TS` AS `TS` from `rod` order by `rod`.`IDPREDNIKA` */;

/*View structure for view vw_naslovi_oseb */

/*!50001 DROP TABLE IF EXISTS `vw_naslovi_oseb` */;
/*!50001 DROP VIEW IF EXISTS `vw_naslovi_oseb` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_naslovi_oseb` AS select `naslovi`.`idNaslova` AS `idNaslova`,`naslovi`.`DRZXAVA` AS `DRZXAVA`,`naslovi`.`Posxta` AS `Posxta`,`naslovi`.`Posxtna_sxt` AS `Posxtna_sxt`,`naslovi`.`Naselje` AS `Naselje`,`naslovi`.`Ulica` AS `Ulica`,`naslovi`.`Hisxna_sxt` AS `Hisxna_sxt`,`naslovi`.`TS` AS `TS`,`osebe_vez_naslovi`.`idOsebe` AS `idOsebe`,`osebe_vez_naslovi`.`ODNOS` AS `VrstaNaslova` from (`osebe_vez_naslovi` join `naslovi` on((`osebe_vez_naslovi`.`idNaslova` = `naslovi`.`idNaslova`))) */;

/*View structure for view vw_nedostopne_PE */

/*!50001 DROP TABLE IF EXISTS `vw_nedostopne_PE` */;
/*!50001 DROP VIEW IF EXISTS `vw_nedostopne_PE` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_nedostopne_PE` AS (select `tehnicneenote`.`TE_TEXT` AS `TE_TEXT`,`popisneenote`.`ST_PE` AS `ST_PE`,`popisneenote`.`NIVOPE` AS `NIVOPE`,`popisneenote`.`DELSXTEV1` AS `DELSXTEV1`,`popisneenote`.`DELSXTEV2` AS `DELSXTEV2`,`popisneenote`.`LETO_ODPRTJA` AS `LETO_ODPRTJA`,`popisneenote`.`LETO_ZAPRTJA` AS `LETO_ZAPRTJA`,`popisneenote`.`NASLOVPE` AS `NASLOVPE`,`popisneenote`.`VSEBINA` AS `VSEBINA`,`popisneenote`.`CXASGR_OD` AS `CXASGR_OD`,`popisneenote`.`CXASGR_DO` AS `CXASGR_DO`,`popisneenote`.`KL_1` AS `KL_1`,`popisneenote`.`OPOMBE_CXAS` AS `OPOMBE_CXAS`,`popisneenote`.`DOSTOPNO_OD` AS `DOSTOPNO_OD`,`popisneenote`.`OPOMBE` AS `OPOMBE`,`popisneenote`.`IDPE` AS `IDPE`,`popisneenote`.`IDFONDA` AS `IDFONDA` from ((`popisneenote` join `pete` on((`pete`.`idPE` = `popisneenote`.`IDPE`))) join `tehnicneenote` on((`pete`.`idTE` = `tehnicneenote`.`IDTE`))) where (`popisneenote`.`DOSTOPNO_OD` <> '') order by `popisneenote`.`IDFONDA`,(`tehnicneenote`.`TE_TEXT` + 0)) */;

/*View structure for view vw_osebnevloge */

/*!50001 DROP TABLE IF EXISTS `vw_osebnevloge` */;
/*!50001 DROP VIEW IF EXISTS `vw_osebnevloge` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_osebnevloge` AS (select `osebnevloge`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`osebnevloge`.`IDOSEBE` AS `IDOSEBE`,`vloge`.`vloga` AS `vloga`,`osebnevloge`.`pridobitev` AS `pridobitev`,`osebnevloge`.`ukinitev` AS `ukinitev` from (`osebnevloge` join `vloge` on((`osebnevloge`.`IDVLOGE` = `vloge`.`idVloge`)))) */;

/*View structure for view vw_osebnevloge_fondi */

/*!50001 DROP TABLE IF EXISTS `vw_osebnevloge_fondi` */;
/*!50001 DROP VIEW IF EXISTS `vw_osebnevloge_fondi` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_osebnevloge_fondi` AS select `osebnevloge_vez_fondi`.`IDOSEBE_F` AS `IDOSEBE_F`,`osebnevloge`.`IDOSEBE` AS `IDOSEBE`,`vloge`.`vloga` AS `vloga`,`osebnevloge_vez_fondi`.`CXAS_OD` AS `CXAS_OD`,`osebnevloge_vez_fondi`.`CXAS_DO` AS `CXAS_DO`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F` from (((`osebnevloge` join `vloge` on((`osebnevloge`.`IDVLOGE` = `vloge`.`idVloge`))) join `osebnevloge_vez_fondi` on((`osebnevloge_vez_fondi`.`IDOSEBNEVLOGE` = `osebnevloge`.`IDOSEBNEVLOGE`))) join `fondi` on((`osebnevloge_vez_fondi`.`IDFONDA` = `fondi`.`IDFONDA`))) */;

/*View structure for view vw_osebnevloge_osebe */

/*!50001 DROP TABLE IF EXISTS `vw_osebnevloge_osebe` */;
/*!50001 DROP VIEW IF EXISTS `vw_osebnevloge_osebe` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_osebnevloge_osebe` AS select `osebnevloge`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`osebnevloge`.`IDOSEBE` AS `IDOSEBE`,`osebnevloge`.`IDVLOGE` AS `IDVLOGE`,`osebe`.`Priimek` AS `Priimek`,`osebe`.`Ime` AS `Ime`,`osebe`.`LetoRojstva` AS `LetoRojstva`,`osebe`.`KrajRojstva` AS `KrajRojstva`,`vloge`.`vloga` AS `vloga` from ((`osebnevloge` join `osebe` on((`osebnevloge`.`IDOSEBE` = `osebe`.`IDOSEBE`))) join `vloge` on((`osebnevloge`.`IDVLOGE` = `vloge`.`idVloge`))) order by `osebe`.`Priimek`,`osebe`.`Ime` */;

/*View structure for view vw_podfondi */

/*!50001 DROP TABLE IF EXISTS `vw_podfondi` */;
/*!50001 DROP VIEW IF EXISTS `vw_podfondi` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_podfondi` AS (select `fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`popisi` AS `popisi`,`fondi`.`TM` AS `TM`,`fondi`.`TE` AS `TE`,`fondi`.`lokacija` AS `lokacija`,`fondi`.`opombe` AS `opombe`,`fondi`.`STATUS` AS `STATUS`,`fondi`.`NADFOND` AS `NADFOND`,`fondi`.`IDFONDA` AS `IDFONDA` from `fondi` where ((`fondi`.`NADFOND` <> 0) and ((`fondi`.`STATUS` = 1) or (`fondi`.`STATUS` = 2))) order by (`fondi`.`ST_F` + 0)) */;

/*View structure for view vw_popisi_po_TE */

/*!50001 DROP TABLE IF EXISTS `vw_popisi_po_TE` */;
/*!50001 DROP VIEW IF EXISTS `vw_popisi_po_TE` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_popisi_po_TE` AS select `tehnicneenote`.`IDFONDA` AS `IDFONDA_TE`,`tehnicneenote`.`IDTE` AS `IDTE`,`tehnicneenote`.`NADTE` AS `NADTE`,`tehnicneenote`.`TE` AS `TE`,`tehnicneenote`.`TE_TEXT` AS `TE_TEXT`,`tehnicneenote`.`TIPTE` AS `TIPTE`,`popisneenote`.`IDPE` AS `IDPE`,`popisneenote`.`NADPE` AS `NADPE`,`popisneenote`.`IDFONDA` AS `IDFONDA_PE`,`popisneenote`.`ST_PE` AS `ST_PE`,`popisneenote`.`PREJSIGN` AS `PREJSIGN`,`popisneenote`.`NIVOPE` AS `NIVOPE`,`popisneenote`.`KL_1` AS `KL_1`,`popisneenote`.`DELSXTEV1` AS `DELSXTEV1`,`popisneenote`.`DELSXTEV2` AS `DELSXTEV2`,`popisneenote`.`LETO_ODPRTJA` AS `LETO_ODPRTJA`,`popisneenote`.`LETO_ZAPRTJA` AS `LETO_ZAPRTJA`,`popisneenote`.`NASLOVPE` AS `NASLOVPE`,`popisneenote`.`VSEBINA` AS `VSEBINA`,`popisneenote`.`CXASGR_OD` AS `CXASGR_OD`,`popisneenote`.`CXASPRIB` AS `CXASPRIB`,`popisneenote`.`CXASGR_DO` AS `CXASGR_DO`,`popisneenote`.`OPOMBE_CXAS` AS `OPOMBE_CXAS`,`popisneenote`.`OPOMBE` AS `OPOMBE`,`popisneenote`.`DOSTOPNO_OD` AS `DOSTOPNO_OD`,`popisneenote`.`TS` AS `PE_TS` from ((`pete` join `tehnicneenote` on((`pete`.`idTE` = `tehnicneenote`.`IDTE`))) join `popisneenote` on((`pete`.`idPE` = `popisneenote`.`IDPE`))) where (`tehnicneenote`.`NADTE` is not null) order by `tehnicneenote`.`IDFONDA`,cast(`tehnicneenote`.`TE_TEXT` as unsigned) */;

/*View structure for view vw_popisneenote */

/*!50001 DROP TABLE IF EXISTS `vw_popisneenote` */;
/*!50001 DROP VIEW IF EXISTS `vw_popisneenote` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_popisneenote` AS select `fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`tehnicneenote`.`TE_TEXT` AS `TE_TEXT`,`popisneenote`.`ST_PE` AS `ST_PE`,`popisneenote`.`DELSXTEV1` AS `DELSXTEV1`,`popisneenote`.`DELSXTEV2` AS `DELSXTEV2`,`popisneenote`.`LETO_ODPRTJA` AS `LETO_ODPRTJA`,`popisneenote`.`LETO_ZAPRTJA` AS `LETO_ZAPRTJA`,`popisneenote`.`NASLOVPE` AS `NASLOVPE`,`popisneenote`.`VSEBINA` AS `VSEBINA`,`popisneenote`.`DOSTOPNO_OD` AS `DOSTOPNO_OD`,`popisneenote`.`IDPE` AS `IDPE`,`popisneenote`.`IDFONDA` AS `IDFONDA` from (((`popisneenote` join `pete` on((`pete`.`idPE` = `popisneenote`.`IDPE`))) join `tehnicneenote` on((`pete`.`idTE` = `tehnicneenote`.`IDTE`))) join `fondi` on((`tehnicneenote`.`IDFONDA` = `fondi`.`IDFONDA`))) order by (`fondi`.`ST_F` + 0),(`tehnicneenote`.`TE_TEXT` + 0) */;

/*View structure for view vw_popisovalci_fondi */

/*!50001 DROP TABLE IF EXISTS `vw_popisovalci_fondi` */;
/*!50001 DROP VIEW IF EXISTS `vw_popisovalci_fondi` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_popisovalci_fondi` AS select `vw_popisovalci_pak`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`vw_popisovalci_pak`.`POPISOVALEC` AS `POPISOVALEC`,`pak_606`.`liferay_osebnevloge_vez_fondi`.`CAS_OD` AS `pridobitev`,`pak_606`.`liferay_osebnevloge_vez_fondi`.`CAS_DO` AS `ukinitev`,`vw_popisovalci_pak`.`active_` AS `active_`,`pak_606`.`fondi`.`ST_F` AS `ST_F`,`pak_606`.`fondi`.`IME_F` AS `IME_F`,`pak_606`.`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`pak_606`.`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`pak_606`.`liferay_osebnevloge_vez_fondi`.`ID` AS `ID`,`pak_606`.`fondi`.`IDFONDA` AS `IDFONDA` from ((`pak_606`.`liferay_osebnevloge_vez_fondi` join `pak_606`.`vw_popisovalci_pak` on((`pak_606`.`liferay_osebnevloge_vez_fondi`.`IDOSEBNEVLOGE` = `vw_popisovalci_pak`.`IDOSEBNEVLOGE`))) join `pak_606`.`fondi` on((`pak_606`.`liferay_osebnevloge_vez_fondi`.`IDFONDA` = `pak_606`.`fondi`.`IDFONDA`))) where ((`pak_606`.`fondi`.`STATUS` = 1) or (`pak_606`.`fondi`.`STATUS` = 2) or (`pak_606`.`fondi`.`STATUS` = 4)) order by `vw_popisovalci_pak`.`POPISOVALEC` */;

/*View structure for view vw_popisovalci_fondi_duplikati */

/*!50001 DROP TABLE IF EXISTS `vw_popisovalci_fondi_duplikati` */;
/*!50001 DROP VIEW IF EXISTS `vw_popisovalci_fondi_duplikati` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_popisovalci_fondi_duplikati` AS (select `vw_popisovalci_fondi`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`vw_popisovalci_fondi`.`POPISOVALEC` AS `POPISOVALEC`,`vw_popisovalci_fondi`.`pridobitev` AS `pridobitev`,`vw_popisovalci_fondi`.`ukinitev` AS `ukinitev`,`vw_popisovalci_fondi`.`active_` AS `active_`,`vw_popisovalci_fondi`.`ST_F` AS `ST_F`,`vw_popisovalci_fondi`.`IME_F` AS `IME_F`,`vw_popisovalci_fondi`.`CXASGR_OD` AS `CXASGR_OD`,`vw_popisovalci_fondi`.`CXASGR_DO` AS `CXASGR_DO`,`vw_popisovalci_fondi`.`ID` AS `ID`,count(`vw_popisovalci_fondi`.`IDFONDA`) AS `COUNT(``IDFONDA``)` from `pak_606`.`vw_popisovalci_fondi` group by `vw_popisovalci_fondi`.`IDFONDA` having (count(`vw_popisovalci_fondi`.`IDFONDA`) > 1)) */;

/*View structure for view vw_popisovalci_pak */

/*!50001 DROP TABLE IF EXISTS `vw_popisovalci_pak` */;
/*!50001 DROP VIEW IF EXISTS `vw_popisovalci_pak` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_popisovalci_pak` AS (select `pak_606`.`liferay_osebnevloge`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`lportal_606_pak`.`User_`.`userId` AS `userId`,concat_ws(' ',`lportal_606_pak`.`User_`.`firstName`,`lportal_606_pak`.`User_`.`lastName`) AS `POPISOVALEC`,`pak_606`.`liferay_osebnevloge`.`pridobitev` AS `pridobitev`,`pak_606`.`liferay_osebnevloge`.`ukinitev` AS `ukinitev`,`lportal_606_pak`.`User_`.`active_` AS `active_`,`lportal_606_pak`.`User_`.`testUser` AS `testUser`,`lportal_606_pak`.`Role_`.`name` AS `rolename`,`lportal_606_pak`.`Role_`.`roleId` AS `roleId`,`lportal_606_pak`.`Organization_`.`name` AS `orgname`,`lportal_606_pak`.`Organization_`.`organizationId` AS `organizationId` from ((`lportal_606_pak`.`Role_` join (`lportal_606_pak`.`User_` join `pak_606`.`liferay_osebnevloge` on((`lportal_606_pak`.`User_`.`userId` = `pak_606`.`liferay_osebnevloge`.`IDOSEBE`))) on((`lportal_606_pak`.`Role_`.`roleId` = `pak_606`.`liferay_osebnevloge`.`IDVLOGE`))) join (`lportal_606_pak`.`Organization_` join `lportal_606_pak`.`Users_Orgs` on((`lportal_606_pak`.`Organization_`.`organizationId` = `lportal_606_pak`.`Users_Orgs`.`organizationId`))) on((`lportal_606_pak`.`User_`.`userId` = `lportal_606_pak`.`Users_Orgs`.`userId`))) where ((`lportal_606_pak`.`User_`.`testUser` = 0) and (`lportal_606_pak`.`Role_`.`roleId` = '10655')) order by `lportal_606_pak`.`User_`.`lastName`,`lportal_606_pak`.`User_`.`firstName`) */;

/*View structure for view vw_popisovalci_popisi */

/*!50001 DROP TABLE IF EXISTS `vw_popisovalci_popisi` */;
/*!50001 DROP VIEW IF EXISTS `vw_popisovalci_popisi` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_popisovalci_popisi` AS select `vw_popisovalci_pak`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`vw_popisovalci_pak`.`POPISOVALEC` AS `POPISOVALEC`,`vw_popisovalci_pak`.`pridobitev` AS `pridobitev`,`vw_popisovalci_pak`.`ukinitev` AS `ukinitev`,`vw_popisovalci_pak`.`active_` AS `active_`,`pak_606`.`fondi`.`IDFONDA` AS `IDFONDA`,`pak_606`.`fondi`.`STATUS` AS `STATUS`,`pak_606`.`fondi`.`ST_F` AS `ST_F`,`pak_606`.`fondi`.`IME_F` AS `IME_F`,`pak_606`.`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`pak_606`.`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`pak_606`.`liferay_osebnevloge_vez_fondi`.`ID` AS `ID`,`pak_606`.`popisneenote`.`NIVOPE` AS `NIVOPE`,`pak_606`.`popisneenote`.`NASLOVPE` AS `NASLOVPE`,`pak_606`.`popisneenote`.`VSEBINA` AS `VSEBINA`,`pak_606`.`popisneenote`.`KL_1` AS `KL_1`,`pak_606`.`popisneenote`.`DELSXTEV1` AS `DELSXTEV1`,`pak_606`.`popisneenote`.`DELSXTEV2` AS `DELSXTEV2`,`pak_606`.`popisneenote`.`LETO_ODPRTJA` AS `LETO_ODPRTJA`,`pak_606`.`popisneenote`.`LETO_ZAPRTJA` AS `LETO_ZAPRTJA`,`pak_606`.`tehnicneenote`.`TE_TEXT` AS `TE_TEXT`,`pak_606`.`tehnicneenote`.`NADTE` AS `NADTE`,`pak_606`.`popisneenote`.`TS` AS `TS` from (((((`pak_606`.`liferay_osebnevloge_vez_fondi` join `pak_606`.`vw_popisovalci_pak` on((`pak_606`.`liferay_osebnevloge_vez_fondi`.`IDOSEBNEVLOGE` = `vw_popisovalci_pak`.`IDOSEBNEVLOGE`))) join `pak_606`.`fondi` on((`pak_606`.`liferay_osebnevloge_vez_fondi`.`IDFONDA` = `pak_606`.`fondi`.`IDFONDA`))) join `pak_606`.`popisneenote` on((`pak_606`.`popisneenote`.`IDFONDA` = `pak_606`.`fondi`.`IDFONDA`))) join `pak_606`.`pete` on((`pak_606`.`pete`.`idPE` = `pak_606`.`popisneenote`.`IDPE`))) join `pak_606`.`tehnicneenote` on((`pak_606`.`pete`.`idTE` = `pak_606`.`tehnicneenote`.`IDTE`))) where ((`pak_606`.`tehnicneenote`.`NADTE` is not null) and (`pak_606`.`fondi`.`STATUS` <> 5) and (`vw_popisovalci_pak`.`active_` = 1)) order by `vw_popisovalci_pak`.`POPISOVALEC`,(`pak_606`.`fondi`.`ST_F` + 0),(`pak_606`.`tehnicneenote`.`TE_TEXT` + 0) */;

/*View structure for view vw_predniki */

/*!50001 DROP TABLE IF EXISTS `vw_predniki` */;
/*!50001 DROP VIEW IF EXISTS `vw_predniki` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_predniki` AS select `rod`.`ID` AS `ID`,`rod`.`IDNASLEDNIKA` AS `IDNASLEDNIKA`,`rod`.`IDPREDNIKA` AS `IDPREDNIKA`,`rod`.`TS` AS `TS` from `rod` order by `rod`.`IDNASLEDNIKA` */;

/*View structure for view vw_raziskovalci */

/*!50001 DROP TABLE IF EXISTS `vw_raziskovalci` */;
/*!50001 DROP VIEW IF EXISTS `vw_raziskovalci` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_raziskovalci` AS select `liferay_osebnevloge`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`liferay_osebnevloge`.`IDOSEBE` AS `IDOSEBE`,`liferay_osebnevloge`.`IDVLOGE` AS `IDVLOGE`,`liferay_osebnevloge`.`pridobitev` AS `pridobitev`,`liferay_osebnevloge`.`ukinitev` AS `ukinitev`,`liferay_osebnevloge`.`TS` AS `TS` from `liferay_osebnevloge` where (`liferay_osebnevloge`.`IDVLOGE` = 272183) */;

/*View structure for view vw_raziskovalci_pak */

/*!50001 DROP TABLE IF EXISTS `vw_raziskovalci_pak` */;
/*!50001 DROP VIEW IF EXISTS `vw_raziskovalci_pak` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_raziskovalci_pak` AS (select `pak_606`.`liferay_osebnevloge`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,concat(`lportal_606_pak`.`User_`.`lastName`,' ',`lportal_606_pak`.`User_`.`firstName`) AS `raziskovalec`,`pak_606`.`liferay_osebnevloge`.`pridobitev` AS `pridobitev`,`pak_606`.`liferay_osebnevloge`.`ukinitev` AS `ukinitev`,`lportal_606_pak`.`User_`.`userId` AS `userId`,`lportal_606_pak`.`User_`.`active_` AS `active_`,`lportal_606_pak`.`User_`.`testUser` AS `testUser`,`lportal_606_pak`.`Role_`.`name` AS `rolename`,`lportal_606_pak`.`Role_`.`roleId` AS `roleId`,`lportal_606_pak`.`Organization_`.`name` AS `orgname`,`lportal_606_pak`.`Organization_`.`organizationId` AS `organizationId` from ((`lportal_606_pak`.`Role_` join (`lportal_606_pak`.`User_` join `pak_606`.`liferay_osebnevloge` on((`lportal_606_pak`.`User_`.`userId` = `pak_606`.`liferay_osebnevloge`.`IDOSEBE`))) on((`lportal_606_pak`.`Role_`.`roleId` = `pak_606`.`liferay_osebnevloge`.`IDVLOGE`))) join (`lportal_606_pak`.`Organization_` join `lportal_606_pak`.`Users_Orgs` on((`lportal_606_pak`.`Organization_`.`organizationId` = `lportal_606_pak`.`Users_Orgs`.`organizationId`))) on((`lportal_606_pak`.`User_`.`userId` = `lportal_606_pak`.`Users_Orgs`.`userId`))) where ((`lportal_606_pak`.`User_`.`testUser` = 0) and (`lportal_606_pak`.`Role_`.`roleId` = '272183') and (`lportal_606_pak`.`Organization_`.`organizationId` = 10661)) order by `lportal_606_pak`.`User_`.`lastName`,`lportal_606_pak`.`User_`.`firstName`) */;

/*View structure for view vw_skrbniki_fondi_popisovalci */

/*!50001 DROP TABLE IF EXISTS `vw_skrbniki_fondi_popisovalci` */;
/*!50001 DROP VIEW IF EXISTS `vw_skrbniki_fondi_popisovalci` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_skrbniki_fondi_popisovalci` AS select `vw_skrbnikifondov`.`arhivist` AS `arhivist`,`vw_fondi_popisovalci`.`ST_F` AS `ST_F`,`vw_fondi_popisovalci`.`IME_F` AS `IME_F`,`vw_fondi_popisovalci`.`CXASGR_OD` AS `CXASGR_OD`,`vw_fondi_popisovalci`.`CXASGR_DO` AS `CXASGR_DO`,`vw_fondi_popisovalci`.`POPISOVALEC` AS `POPISOVALEC`,`vw_fondi_popisovalci`.`pridobitev` AS `pridobitev`,`vw_fondi_popisovalci`.`ukinitev` AS `ukinitev`,`vw_fondi_popisovalci`.`active_` AS `active_`,`vw_fondi_popisovalci`.`orgname` AS `orgname`,`pak_606`.`liferay_osebnevloge_vez_fondi`.`ID` AS `ID` from ((`pak_606`.`liferay_osebnevloge_vez_fondi` join `pak_606`.`vw_skrbnikifondov` on((`pak_606`.`liferay_osebnevloge_vez_fondi`.`IDOSEBNEVLOGE` = `vw_skrbnikifondov`.`IDOSEBNEVLOGE`))) join `pak_606`.`vw_fondi_popisovalci` on((`vw_fondi_popisovalci`.`IDFONDA` = `pak_606`.`liferay_osebnevloge_vez_fondi`.`IDFONDA`))) order by `vw_skrbnikifondov`.`arhivist`,(`vw_fondi_popisovalci`.`ST_F` + 0) */;

/*View structure for view vw_skrbniki_popisovalci_fondi */

/*!50001 DROP TABLE IF EXISTS `vw_skrbniki_popisovalci_fondi` */;
/*!50001 DROP VIEW IF EXISTS `vw_skrbniki_popisovalci_fondi` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_skrbniki_popisovalci_fondi` AS select `vw_skrbnikifondov`.`arhivist` AS `arhivist`,`vw_skrbnikifondov`.`pridobitev` AS `SKRBNIK_OD`,`vw_skrbnikifondov`.`ukinitev` AS `SKRBNIK_DO`,`vw_skrbnikifondov`.`active_` AS `SKRBNIK_AKTIVEN`,`vw_popisovalci_fondi`.`POPISOVALEC` AS `POPISOVALEC`,`vw_popisovalci_fondi`.`pridobitev` AS `pridobitev`,`vw_popisovalci_fondi`.`ukinitev` AS `ukinitev`,`vw_popisovalci_fondi`.`active_` AS `POPISOVALEC_AKTIVEN`,`vw_popisovalci_fondi`.`ST_F` AS `ST_F`,`vw_popisovalci_fondi`.`IME_F` AS `IME_F`,`vw_popisovalci_fondi`.`CXASGR_OD` AS `CXASGR_OD`,`vw_popisovalci_fondi`.`CXASGR_DO` AS `CXASGR_DO`,`vw_skrbnikifondov`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,`pak_606`.`liferay_osebnevloge_vez_fondi`.`ID` AS `ID`,`vw_popisovalci_fondi`.`IDFONDA` AS `IDFONDA` from ((`pak_606`.`liferay_osebnevloge_vez_fondi` join `pak_606`.`vw_skrbnikifondov` on((`pak_606`.`liferay_osebnevloge_vez_fondi`.`IDOSEBNEVLOGE` = `vw_skrbnikifondov`.`IDOSEBNEVLOGE`))) join `pak_606`.`vw_popisovalci_fondi` on((`vw_popisovalci_fondi`.`IDFONDA` = `pak_606`.`liferay_osebnevloge_vez_fondi`.`IDFONDA`))) order by `vw_skrbnikifondov`.`arhivist`,`vw_popisovalci_fondi`.`POPISOVALEC`,`vw_popisovalci_fondi`.`pridobitev` */;

/*View structure for view vw_skrbnikifondov */

/*!50001 DROP TABLE IF EXISTS `vw_skrbnikifondov` */;
/*!50001 DROP VIEW IF EXISTS `vw_skrbnikifondov` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_skrbnikifondov` AS (select `pak_606`.`liferay_osebnevloge`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,concat_ws(' ',`lportal_606_pak`.`User_`.`firstName`,`lportal_606_pak`.`User_`.`lastName`) AS `arhivist`,`pak_606`.`liferay_osebnevloge`.`pridobitev` AS `pridobitev`,`pak_606`.`liferay_osebnevloge`.`ukinitev` AS `ukinitev`,`lportal_606_pak`.`User_`.`active_` AS `active_`,`lportal_606_pak`.`User_`.`testUser` AS `testUser`,`lportal_606_pak`.`Role_`.`name` AS `rolename`,`lportal_606_pak`.`Role_`.`roleId` AS `roleId`,`lportal_606_pak`.`Organization_`.`name` AS `orgname`,`lportal_606_pak`.`Organization_`.`organizationId` AS `organizationId` from ((`lportal_606_pak`.`Role_` join (`lportal_606_pak`.`User_` join `pak_606`.`liferay_osebnevloge` on((`lportal_606_pak`.`User_`.`userId` = `pak_606`.`liferay_osebnevloge`.`IDOSEBE`))) on((`lportal_606_pak`.`Role_`.`roleId` = `pak_606`.`liferay_osebnevloge`.`IDVLOGE`))) join (`lportal_606_pak`.`Organization_` join `lportal_606_pak`.`Users_Orgs` on((`lportal_606_pak`.`Organization_`.`organizationId` = `lportal_606_pak`.`Users_Orgs`.`organizationId`))) on((`lportal_606_pak`.`User_`.`userId` = `lportal_606_pak`.`Users_Orgs`.`userId`))) where (`lportal_606_pak`.`Role_`.`roleId` = '10653') order by `lportal_606_pak`.`User_`.`lastName`,`lportal_606_pak`.`User_`.`firstName`) */;

/*View structure for view vw_skrbnikifondov_aktivni */

/*!50001 DROP TABLE IF EXISTS `vw_skrbnikifondov_aktivni` */;
/*!50001 DROP VIEW IF EXISTS `vw_skrbnikifondov_aktivni` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_skrbnikifondov_aktivni` AS (select `pak_606`.`liferay_osebnevloge`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,concat_ws(' ',`lportal_606_pak`.`User_`.`firstName`,`lportal_606_pak`.`User_`.`lastName`) AS `arhivist`,`pak_606`.`liferay_osebnevloge`.`pridobitev` AS `pridobitev`,`pak_606`.`liferay_osebnevloge`.`ukinitev` AS `ukinitev`,`lportal_606_pak`.`Role_`.`name` AS `rolename`,`lportal_606_pak`.`Role_`.`roleId` AS `roleId`,`lportal_606_pak`.`Organization_`.`name` AS `orgname`,`lportal_606_pak`.`Organization_`.`organizationId` AS `organizationId` from ((`lportal_606_pak`.`Role_` join (`lportal_606_pak`.`User_` join `pak_606`.`liferay_osebnevloge` on((`lportal_606_pak`.`User_`.`userId` = `pak_606`.`liferay_osebnevloge`.`IDOSEBE`))) on((`lportal_606_pak`.`Role_`.`roleId` = `pak_606`.`liferay_osebnevloge`.`IDVLOGE`))) join (`lportal_606_pak`.`Organization_` join `lportal_606_pak`.`Users_Orgs` on((`lportal_606_pak`.`Organization_`.`organizationId` = `lportal_606_pak`.`Users_Orgs`.`organizationId`))) on((`lportal_606_pak`.`User_`.`userId` = `lportal_606_pak`.`Users_Orgs`.`userId`))) where ((`lportal_606_pak`.`User_`.`testUser` = 0) and (`lportal_606_pak`.`Role_`.`roleId` = '10653') and (`lportal_606_pak`.`User_`.`active_` = 1)) order by `lportal_606_pak`.`Organization_`.`name`,concat_ws(' ',`lportal_606_pak`.`User_`.`firstName`,`lportal_606_pak`.`User_`.`lastName`)) */;

/*View structure for view vw_skrbnikifondov_bivsi */

/*!50001 DROP TABLE IF EXISTS `vw_skrbnikifondov_bivsi` */;
/*!50001 DROP VIEW IF EXISTS `vw_skrbnikifondov_bivsi` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_skrbnikifondov_bivsi` AS (select `pak_606`.`liferay_osebnevloge`.`IDOSEBNEVLOGE` AS `IDOSEBNEVLOGE`,concat_ws(' ',`lportal_606_pak`.`User_`.`firstName`,`lportal_606_pak`.`User_`.`lastName`) AS `arhivist`,`pak_606`.`liferay_osebnevloge`.`pridobitev` AS `pridobitev`,`pak_606`.`liferay_osebnevloge`.`ukinitev` AS `ukinitev`,`lportal_606_pak`.`Role_`.`name` AS `rolename`,`lportal_606_pak`.`Role_`.`roleId` AS `roleId`,`lportal_606_pak`.`Organization_`.`name` AS `orgname`,`lportal_606_pak`.`Organization_`.`organizationId` AS `organizationId` from ((`lportal_606_pak`.`Role_` join (`lportal_606_pak`.`User_` join `pak_606`.`liferay_osebnevloge` on((`lportal_606_pak`.`User_`.`userId` = `pak_606`.`liferay_osebnevloge`.`IDOSEBE`))) on((`lportal_606_pak`.`Role_`.`roleId` = `pak_606`.`liferay_osebnevloge`.`IDVLOGE`))) join (`lportal_606_pak`.`Organization_` join `lportal_606_pak`.`Users_Orgs` on((`lportal_606_pak`.`Organization_`.`organizationId` = `lportal_606_pak`.`Users_Orgs`.`organizationId`))) on((`lportal_606_pak`.`User_`.`userId` = `lportal_606_pak`.`Users_Orgs`.`userId`))) where ((`lportal_606_pak`.`User_`.`testUser` = 0) and (`lportal_606_pak`.`Role_`.`roleId` = '10653') and (`lportal_606_pak`.`User_`.`active_` = 0)) order by `lportal_606_pak`.`User_`.`lastName`,`lportal_606_pak`.`User_`.`firstName`) */;

/*View structure for view vw_zbirke */

/*!50001 DROP TABLE IF EXISTS `vw_zbirke` */;
/*!50001 DROP VIEW IF EXISTS `vw_zbirke` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`%` SQL SECURITY DEFINER VIEW `vw_zbirke` AS (select `fondi`.`IDFONDA` AS `IDFONDA`,`fondi`.`ARHIV` AS `ARHIV`,`fondi`.`ORG_ENOTA` AS `ORG_ENOTA`,`fondi`.`ST_F` AS `ST_F`,`fondi`.`IME_F` AS `IME_F`,`fondi`.`CXASGR_OD` AS `CXASGR_OD`,`fondi`.`CXASGR_DO` AS `CXASGR_DO`,`fondi`.`popisi` AS `popisi`,`fondi`.`KLAS_F` AS `KLAS_F` from `fondi` where (`fondi`.`KLAS_F` = 'K') order by (`fondi`.`ST_F` + 0)) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

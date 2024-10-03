/*
SQLyog Ultimate v13.3.0 (64 bit)
MySQL - 5.1.73-1-log : Database - lportal_606_pak_vfront
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`lportal_606_pak_vfront` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */;

USE `lportal_606_pak_vfront`;

/*Table structure for table `allegato` */

DROP TABLE IF EXISTS `allegato`;

CREATE TABLE `allegato` (
  `codiceallegato` int(11) NOT NULL AUTO_INCREMENT COMMENT 'chiave primaria identificativa del record',
  `tipoentita` varchar(100) DEFAULT NULL COMMENT 'identifica l''entitÃ  del database alla quale l''utente vuole collegare il file allegato. L''entitÃ  verrÃ  riconosciuta dall''applicazione in base alle operazioni svolte in quella fase dall''utente.',
  `codiceentita` varchar(255) DEFAULT NULL COMMENT 'identifica la particolare occorrenza (record) dell''entitÃ  del database alla quale l''utente vuole collegare il file allegato',
  `descroggall` varchar(250) DEFAULT NULL COMMENT 'descrizione dell''oggetto del file',
  `autoreall` varchar(250) DEFAULT NULL COMMENT 'autore del file da allegare',
  `versioneall` varchar(250) DEFAULT NULL COMMENT 'eventuale numero di versione del file ',
  `lastdata` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'campo automaticamente valorizzato dal DBMS al primo inserimento o quando il record viene modificato',
  `nomefileall` varchar(250) NOT NULL,
  PRIMARY KEY (`codiceallegato`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='descrive i file in upload e li collega all''entitÃ ';

/*Table structure for table `api_console` */

DROP TABLE IF EXISTS `api_console`;

CREATE TABLE `api_console` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(20) NOT NULL DEFAULT '',
  `rw` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=read only, 1=read and write',
  `api_key` varchar(100) NOT NULL DEFAULT '',
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `api_key` (`api_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `button` */

DROP TABLE IF EXISTS `button`;

CREATE TABLE `button` (
  `id_button` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_table` int(10) NOT NULL,
  `definition` text COLLATE utf8_unicode_ci NOT NULL,
  `button_type` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `background` varchar(7) COLLATE utf8_unicode_ci NOT NULL,
  `color` varchar(7) COLLATE utf8_unicode_ci NOT NULL,
  `button_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `last_data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_utente` int(11) unsigned NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id_button`),
  KEY `id_table` (`id_table`),
  KEY `id_utente` (`id_utente`),
  CONSTRAINT `button_ibfk_1` FOREIGN KEY (`id_table`) REFERENCES `registro_tab` (`id_table`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

/*Table structure for table `cache_reg` */

DROP TABLE IF EXISTS `cache_reg`;

CREATE TABLE `cache_reg` (
  `id` int(11) unsigned NOT NULL,
  `obj` blob,
  `last_update` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Table structure for table `gruppo` */

DROP TABLE IF EXISTS `gruppo`;

CREATE TABLE `gruppo` (
  `gid` int(11) NOT NULL COMMENT 'ID del gruppo',
  `nome_gruppo` varchar(50) NOT NULL COMMENT 'Nome del gruppo',
  `descrizione_gruppo` text,
  `data_gruppo` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`gid`),
  UNIQUE KEY `gid` (`gid`),
  UNIQUE KEY `nome_gruppo` (`nome_gruppo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `link` */

DROP TABLE IF EXISTS `link`;

CREATE TABLE `link` (
  `codicelink` int(11) NOT NULL AUTO_INCREMENT COMMENT 'chiave primaria identificativa del record',
  `tipoentita` varchar(100) DEFAULT NULL COMMENT 'identifica l''entitÃ  del database alla quale l''utente vuole abbinare il link ipertestuale. L''entitÃ  verrÃ  riconosciuta dall''applicazione in base alle operazioni svolte in quella fase dall''utente.',
  `codiceentita` varchar(255) DEFAULT NULL COMMENT 'identifica la particolare occorrenza (record) dell''entitÃ  del database alla quale l''utente vuole abbinare il collegamento',
  `link` varchar(250) DEFAULT NULL COMMENT 'URL del link a cui si rimanda',
  `descrizione` varchar(250) DEFAULT NULL,
  `lastdata` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'campo automaticamente valorizzato dal DBMS al primo inserimento o quando il record viene modificato',
  PRIMARY KEY (`codicelink`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='lega le entitÃ  agli eventuali link ipertestuali';

/*Table structure for table `log` */

DROP TABLE IF EXISTS `log`;

CREATE TABLE `log` (
  `id_log` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `op` enum('insert','update','delete','select','sconosciuta','ripristino','duplicazione','import') DEFAULT NULL,
  `uid` int(11) unsigned NOT NULL,
  `gid` int(11) unsigned NOT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tabella` varchar(100) NOT NULL,
  `id_record` varchar(100) DEFAULT NULL,
  `storico_pre` text,
  `storico_post` text,
  `id_istituto` int(11) DEFAULT NULL,
  `fonte` enum('m','s') NOT NULL DEFAULT 'm',
  `info_browser` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_log`),
  KEY `op` (`op`,`uid`,`data`,`tabella`,`id_record`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabella di log';

/*Table structure for table `recordlock` */

DROP TABLE IF EXISTS `recordlock`;

CREATE TABLE `recordlock` (
  `tabella` varchar(50) NOT NULL,
  `colonna` varchar(50) NOT NULL,
  `id` varchar(50) NOT NULL,
  `tempo` int(11) NOT NULL,
  PRIMARY KEY (`tabella`,`colonna`,`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `registro_col` */

DROP TABLE IF EXISTS `registro_col`;

CREATE TABLE `registro_col` (
  `id_reg` int(10) NOT NULL AUTO_INCREMENT,
  `id_table` int(11) DEFAULT NULL,
  `gid` int(10) DEFAULT NULL,
  `column_name` varchar(255) DEFAULT NULL,
  `ordinal_position` int(3) DEFAULT NULL,
  `column_default` varchar(255) DEFAULT NULL,
  `is_nullable` char(3) DEFAULT NULL,
  `column_type` varchar(255) DEFAULT NULL,
  `character_maximum_length` int(10) DEFAULT NULL,
  `data_type` varchar(255) DEFAULT NULL,
  `extra` varchar(200) DEFAULT NULL,
  `in_tipo` text,
  `in_default` text,
  `in_visibile` tinyint(1) DEFAULT '1',
  `in_richiesto` tinyint(1) DEFAULT '0',
  `in_suggest` tinyint(1) DEFAULT '0',
  `in_table` tinyint(1) DEFAULT '1',
  `in_line` tinyint(1) DEFAULT NULL,
  `in_ordine` int(3) DEFAULT '0',
  `jstest` mediumtext,
  `commento` varchar(255) DEFAULT NULL,
  `alias_frontend` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_reg`),
  KEY `i_registro_col_gid` (`gid`),
  KEY `id_table` (`id_table`),
  CONSTRAINT `FK_registro_col_1` FOREIGN KEY (`id_table`) REFERENCES `registro_tab` (`id_table`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7530 DEFAULT CHARSET=utf8 COMMENT='Registro documentazione dei campi delle tabelle dello schema';

/*Table structure for table `registro_submask` */

DROP TABLE IF EXISTS `registro_submask`;

CREATE TABLE `registro_submask` (
  `id_submask` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `id_table` int(11) NOT NULL COMMENT 'Tabella parent per la sottomaschera',
  `sub_select` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sub_insert` tinyint(1) DEFAULT '0',
  `sub_update` tinyint(1) DEFAULT '0',
  `sub_delete` tinyint(1) DEFAULT '0',
  `nome_tabella` varchar(255) DEFAULT NULL COMMENT 'Tabella fonte per la sottomaschera',
  `nome_frontend` varchar(250) DEFAULT NULL COMMENT 'Nome per la sottomaschera che apparirÃ  nella maschera utente',
  `campo_pk_parent` varchar(80) DEFAULT NULL COMMENT 'Campo che rappresenta la chiave primaria nella tabella parent',
  `campo_fk_sub` varchar(80) DEFAULT NULL COMMENT 'Campo che rappresenta la chiave esterna rispetto alla tabella parent',
  `orderby_sub` varchar(80) DEFAULT NULL COMMENT 'Campo orderby della sottomaschera',
  `orderby_sub_sort` enum('ASC','DESC') DEFAULT 'ASC',
  `data_modifica` int(11) unsigned DEFAULT NULL,
  `max_records` int(3) DEFAULT '10',
  `tipo_vista` enum('tabella','scheda','embed','schedash') NOT NULL DEFAULT 'scheda',
  PRIMARY KEY (`id_submask`),
  KEY `registro_submask_fk` (`id_table`),
  CONSTRAINT `registro_submask_fk` FOREIGN KEY (`id_table`) REFERENCES `registro_tab` (`id_table`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `registro_submask_col` */

DROP TABLE IF EXISTS `registro_submask_col`;

CREATE TABLE `registro_submask_col` (
  `id_reg_sub` int(10) NOT NULL AUTO_INCREMENT,
  `id_submask` int(11) unsigned NOT NULL,
  `column_name` varchar(255) DEFAULT NULL,
  `ordinal_position` int(3) DEFAULT NULL,
  `column_default` varchar(255) DEFAULT NULL,
  `is_nullable` char(3) DEFAULT NULL,
  `column_type` varchar(255) DEFAULT NULL,
  `character_maximum_length` int(10) DEFAULT NULL,
  `data_type` varchar(255) DEFAULT NULL,
  `extra` varchar(200) DEFAULT NULL,
  `in_tipo` text,
  `in_default` text,
  `in_visibile` tinyint(1) DEFAULT '1',
  `in_richiesto` tinyint(1) DEFAULT '0',
  `commento` varchar(255) DEFAULT NULL,
  `alias_frontend` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_reg_sub`),
  KEY `i_id_submask` (`id_submask`),
  CONSTRAINT `registro_submask_col_fk` FOREIGN KEY (`id_submask`) REFERENCES `registro_submask` (`id_submask`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Registro documentazione dei campi delle colonne delle sottom';

/*Table structure for table `registro_tab` */

DROP TABLE IF EXISTS `registro_tab`;

CREATE TABLE `registro_tab` (
  `id_table` int(10) NOT NULL AUTO_INCREMENT,
  `gid` int(10) DEFAULT NULL,
  `visibile` tinyint(1) DEFAULT '0',
  `in_insert` int(1) unsigned NOT NULL DEFAULT '0',
  `in_duplica` int(1) unsigned NOT NULL DEFAULT '0',
  `in_update` int(1) unsigned NOT NULL DEFAULT '0',
  `in_delete` int(1) unsigned NOT NULL DEFAULT '0',
  `in_export` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `in_import` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `data_modifica` int(10) DEFAULT '0',
  `orderby` varchar(255) DEFAULT NULL,
  `table_name` varchar(100) DEFAULT NULL,
  `table_type` varchar(20) DEFAULT 'BASE TABLE',
  `commento` varchar(255) DEFAULT NULL,
  `orderby_sort` varchar(255) DEFAULT 'ASC',
  `permetti_allegati` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `permetti_allegati_ins` tinyint(1) unsigned DEFAULT '0',
  `permetti_allegati_del` tinyint(1) unsigned DEFAULT '0',
  `permetti_link` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `permetti_link_ins` tinyint(1) unsigned DEFAULT '0',
  `permetti_link_del` tinyint(1) unsigned DEFAULT '0',
  `view_pk` varchar(60) DEFAULT NULL,
  `fonte_al` varchar(100) DEFAULT NULL,
  `table_alias` varchar(100) DEFAULT NULL,
  `allow_filters` tinyint(1) DEFAULT '0',
  `default_view` varchar(5) DEFAULT 'form',
  `default_filters` text,
  PRIMARY KEY (`id_table`),
  KEY `i_gid_tab` (`gid`),
  KEY `table_name` (`table_name`),
  KEY `id_table` (`id_table`),
  CONSTRAINT `registro_tab_fk` FOREIGN KEY (`gid`) REFERENCES `gruppo` (`gid`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=760 DEFAULT CHARSET=utf8;

/*Table structure for table `stat` */

DROP TABLE IF EXISTS `stat`;

CREATE TABLE `stat` (
  `id_stat` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nome_stat` varchar(250) NOT NULL COMMENT 'Nome nella statistica',
  `desc_stat` text COMMENT 'Descrizione della statistica',
  `def_stat` text COMMENT 'Definizione della query SQL per la statistica',
  `auth_stat` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Tipo autorizzazione per statistica: 1=pubblica, 2=del gruppo, 3=personale',
  `tipo_graph` enum('barre','torta') DEFAULT 'barre',
  `data_stat` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `autore` int(11) NOT NULL,
  `settings` text COMMENT 'Impostazioni avanzate del grafico',
  `published` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'published on home page',
  PRIMARY KEY (`id_stat`),
  UNIQUE KEY `id_stat` (`id_stat`),
  KEY `autore` (`autore`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Statistiche descrittive registrate dagli utenti';

/*Table structure for table `utente` */

DROP TABLE IF EXISTS `utente`;

CREATE TABLE `utente` (
  `id_utente` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nick` varchar(80) DEFAULT NULL,
  `passwd` char(32) DEFAULT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `cognome` varchar(50) DEFAULT NULL,
  `email` varchar(80) DEFAULT NULL,
  `info` text,
  `data_ins` date DEFAULT NULL,
  `gid` int(11) NOT NULL DEFAULT '0',
  `livello` int(1) NOT NULL DEFAULT '1',
  `recover_passwd` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id_utente`),
  UNIQUE KEY `id_utente` (`id_utente`),
  KEY `gid` (`gid`),
  CONSTRAINT `utente_fk` FOREIGN KEY (`gid`) REFERENCES `gruppo` (`gid`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Table structure for table `variabili` */

DROP TABLE IF EXISTS `variabili`;

CREATE TABLE `variabili` (
  `variabile` char(32) NOT NULL,
  `gid` int(11) NOT NULL DEFAULT '0',
  `valore` varchar(255) DEFAULT NULL,
  `descrizione` varchar(255) DEFAULT NULL,
  `tipo_var` varchar(20) DEFAULT NULL,
  `pubvar` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`variabile`,`gid`),
  KEY `variabile` (`variabile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `widget` */

DROP TABLE IF EXISTS `widget`;

CREATE TABLE `widget` (
  `id_widget` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_table` int(10) NOT NULL,
  `widget_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `form_position` varchar(11) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `widget_type` varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `settings` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id_widget`),
  KEY `i_widget_id_table` (`id_table`),
  CONSTRAINT `fk_widget_id_table` FOREIGN KEY (`id_table`) REFERENCES `registro_tab` (`id_table`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Widget table';

/*Table structure for table `xml_rules` */

DROP TABLE IF EXISTS `xml_rules`;

CREATE TABLE `xml_rules` (
  `id_xml_rules` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `tabella` varchar(50) NOT NULL,
  `accesso` varchar(20) NOT NULL DEFAULT 'RESTRICT' COMMENT 'RESTRICT,PUBLIC,FRONTEND,GROUP',
  `accesso_gruppo` varchar(100) DEFAULT NULL,
  `autore` int(11) DEFAULT NULL,
  `lastData` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `xsl` varchar(80) DEFAULT NULL,
  `xslfo` varchar(80) DEFAULT NULL,
  `tipo_report` char(1) DEFAULT NULL,
  `def_query` text,
  `nome_report` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_xml_rules`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Regole per la definizione dei report XML based';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

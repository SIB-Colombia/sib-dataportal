SET character_set_client = utf8;

select concat('Deleting  table: ', now()) as debug;
DROP TABLE IF EXISTS `catalogue_of_life_common_name`;

select concat('Creating table catalogue_of_life_common_name: ', now()) as debug;
CREATE TABLE `catalogue_of_life_common_name` (
`id`  bigint NOT NULL AUTO_INCREMENT ,
`canonical`  varchar(255) NOT NULL ,
`common_name`  varchar(255) NOT NULL ,
`language_iso`  char(3) NULL ,
`country_iso`  char(3) NULL ,
`country`  varchar(100) NULL ,
PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
load data 
    infile 'C://Temp//catalogue_of_life_common_name.txt'
into table
    catalogue_of_life_common_name;

select concat('Deleting  table: ', now()) as debug;
DROP TABLE IF EXISTS language;

select concat('Creating table language: ', now()) as debug;
CREATE TABLE language (
       id INT NOT NULL AUTO_INCREMENT
       , iso_language_code CHAR(3) NOT NULL
       , name VARCHAR(255) NOT NULL
	   , standard TINYINT(1) NOT NULL
       ,PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE INDEX IX_language_1 ON language (name ASC);
CREATE INDEX IX_language_2 ON language (iso_language_code ASC);
load data 
    infile "C://Temp//language.txt"
into table
    language (iso_language_code,name,standard);

select concat('Deleting  table: ', now()) as debug;
DROP TABLE IF EXISTS common_name;

select concat('Creating table common_name: ', now()) as debug;
CREATE TABLE common_name(
       id INT NOT NULL AUTO_INCREMENT
       , name VARCHAR(255) NOT NULL
       , transliteration VARCHAR(255)
	   , iso_language_code CHAR(3)
       , iso_country_code CHAR(2)
       ,PRIMARY KEY (`id`)
	   , CONSTRAINT `FK_ISO_LANGUAGE_CODE` FOREIGN KEY (`ISO_LANGUAGE_CODE`) REFERENCES `language` (`ISO_LANGUAGE_CODE`)
	   , CONSTRAINT `FK_ISO_COUNTRY_CODE` FOREIGN KEY (`ISO_COUNTRY_CODE`) REFERENCES `country` (`ISO_COUNTRY_CODE`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
CREATE INDEX IX_common_name_1 ON common_name (name ASC);
CREATE INDEX IX_common_name_2 ON common_name (iso_language_code ASC);
load data 
    infile "C://Temp//common_name.txt"
into table
    common_name (name,transliteration,iso_language_code,iso_country_code);
    
select concat('Deleting  table: ', now()) as debug;
DROP TABLE IF EXISTS common_name_taxon_concept;

select concat('Creating table common_name_taxon_concept: ', now()) as debug;
CREATE TABLE common_name_taxon_concept(
	   taxon_concept_id INT NOT NULL
     , common_name_id INT NOT NULL
     , PRIMARY KEY (taxon_concept_id,common_name_id)
     , INDEX (taxon_concept_id)
	 , INDEX (common_name_id)
	 , CONSTRAINT `FK_TAXON_CONCEPT_ID` FOREIGN KEY (`TAXON_CONCEPT_ID`) REFERENCES `taxon_concept` (`ID`)
	 , CONSTRAINT `FK_COMON_NAME_ID` FOREIGN KEY (`COMMON_NAME_ID`) REFERENCES `common_name` (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
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
-- Table department DDL definition
-- ----------------------------
--  Table structure for `department`
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `iso_department_code` char(8) DEFAULT NULL,
  `department_name` varchar(255) DEFAULT NULL,
  `concept_count` int(10) DEFAULT NULL,
  `species_count` int(10) DEFAULT NULL,
  `occurrence_count` int(10) DEFAULT NULL,
  `occurrence_coordinate_count` int(10) DEFAULT NULL,
  `min_latitude` float DEFAULT NULL,
  `max_latitude` float DEFAULT NULL,
  `min_longitude` float DEFAULT NULL,
  `max_longitude` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- Include department key in lookup_cell_density_type table
insert into lookup_cell_density_type (cd_key, cd_value) values (8,'department')

-- Include all the departments in department table
insert INTO department (department.id, department.iso_department_code, department.department_name) VALUES (1, 'CO-AMA','Amazonas'),(2,'CO-ANT','Antioquia'),(3,'CO-ARA','Arauca'),(4,'CO-ATL','Atlántico'),(5,'CO-BOL','Bolívar'),(6,'CO-BOY','Boyacá'),(7,'CO-CAL','Caldas'),(8,'CO-CAQ','Caquetá'),(9,'CO-CAS','Casanare'),(10,'CO-CAU','Cauca'),(11,'CO-CES','Cesar'),(12,'CO-CHO','Chocó'),(13,'CO-COR','Córdoba'),(14,'CO-CUN','Cundinamarca'),(15,'CO-DC','Bogotá Distrito Capital'),(16,'CO-GUA','Guainía'),(17,'CO-GUV','Guaviare'),(18,'CO-HUI','Huila'),(19,'CO-LAG','La Guajira'),(20,'CO-MAG','Magdalena'),(21,'CO-MET','Meta'),(22,'CO-NAR','Nariño'),(23,'CO-NSA','Norte de Santander'),(24,'CO-PUT','Putumayo'),(25,'CO-QUI','Quindío'),(26,'CO-RIS','Risaralda'),(27,'CO-SAP','San Andrés, Providencia y Santa Catalina'),(28,'CO-SAN','Santander'),(29,'CO-SUC','Sucre'),(30,'CO-TOL','Tolima'),(31,'CO-VAC','Valle del Cauca'),(32,'CO-VAU','Vaupés'),(33,'CO-VID','Vichada')

--Coordinates for departments
--Bogotá 
update department set max_latitude=5, min_latitude=3, max_longitude=-73, min_longitude=-75 where iso_department_code ='CO-DC';
--Amazonas 
update department set max_latitude=1, min_latitude=-5, max_longitude=-69, min_longitude=-75 where iso_department_code ='CO-AMA';
--Antioquia 
update department set max_latitude=10, min_latitude=5, max_longitude=-73, min_longitude=-78 where iso_department_code ='CO-ANT';
--Arauca 
update department set max_latitude=8, min_latitude=6, max_longitude=-69, min_longitude=-73 where iso_department_code ='CO-ARA';
--Atlántico 
update department set max_latitude=15, min_latitude=10, max_longitude=-74, min_longitude=-76 where iso_department_code ='CO-ATL';
--Bolívar 
update department set max_latitude=15, min_latitude=7, max_longitude=-73, min_longitude=-76 where iso_department_code ='CO-BOL';
--Boyacá
update department set max_latitude=8, min_latitude=4, max_longitude=-71, min_longitude=-75 where iso_department_code ='CO-BOY';
--Caldas
update department set max_latitude=6, min_latitude=4, max_longitude=-74, min_longitude=-76 where iso_department_code ='CO-CAL';
--Caquetá
update department set max_latitude=3, min_latitude=-1, max_longitude=-71, min_longitude=-77 where iso_department_code ='CO-CAQ';
--Casanare
update department set max_latitude=7, min_latitude=4, max_longitude=-69, min_longitude=-74 where iso_department_code ='CO-CAS';
--Cauca
update department set max_latitude=4, min_latitude=0, max_longitude=-75, min_longitude=-85 where iso_department_code ='CO-CAU';
--Cesar
update department set max_latitude=11, min_latitude=7, max_longitude=-72, min_longitude=-75 where iso_department_code ='CO-CES';
--Córdoba
update department set max_latitude=12, min_latitude=7, max_longitude=-74, min_longitude=-77 where iso_department_code ='CO-COR';
--Cundinamarca
update department set max_latitude=6, min_latitude=3, max_longitude=-73, min_longitude=-75 where iso_department_code ='CO-CUN';
--Chocó
update department set max_latitude=9, min_latitude=3, max_longitude=-76, min_longitude=-85 where iso_department_code ='CO-CHO';
--Guainía
update department set max_latitude=5, min_latitude=1, max_longitude=-66, min_longitude=-71 where iso_department_code ='CO-GUA';
--Guaviare
update department set max_latitude=3, min_latitude=0, max_longitude=-70, min_longitude=-74 where iso_department_code ='CO-GUV';
--Huila
update department set max_latitude=4, min_latitude=1, max_longitude=-74, min_longitude=-77 where iso_department_code ='CO-HUI';
--La Guajira
update department set max_latitude=16, min_latitude=10, max_longitude=-72, min_longitude=-74 where iso_department_code ='CO-LAG';
--Magdalena
update department set max_latitude=15, min_latitude=8, max_longitude=-73, min_longitude=-75 where iso_department_code ='CO-MAG';
--Meta
update department set max_latitude=5, min_latitude=1, max_longitude=-71, min_longitude=-75 where iso_department_code ='CO-MET';
--Nariño
update department set max_latitude=3, min_latitude=0, max_longitude=-76, min_longitude=-85 where iso_department_code ='CO-NAR';
--Norte de Santander
update department set max_latitude=10, min_latitude=6, max_longitude=-72, min_longitude=-74 where iso_department_code ='CO-NSA';
--Putumayo
update department set max_latitude=2, min_latitude=-1, max_longitude=-73, min_longitude=-78 where iso_department_code ='CO-PUT';
--Quindío
update department set max_latitude=5, min_latitude=3, max_longitude=-75, min_longitude=-76 where iso_department_code ='CO-QUI';
--Risaralda
update department set max_latitude=6, min_latitude=4, max_longitude=-75, min_longitude=-77 where iso_department_code ='CO-RIS';
--San Andrés, Providencia y Santa Catalina
update department set max_latitude=15, min_latitude=10, max_longitude=-77, min_longitude=-82 where iso_department_code ='CO-SAP';
--Santander
update department set max_latitude=9, min_latitude=5, max_longitude=-72, min_longitude=-75 where iso_department_code ='CO-SAN';
--Sucre
update department set max_latitude=11, min_latitude=8, max_longitude=-74, min_longitude=-77 where iso_department_code ='CO-SUC';
--Tolima
update department set max_latitude=6, min_latitude=2, max_longitude=-74, min_longitude=-77 where iso_department_code ='CO-TOL';
--Valle del Cauca
update department set max_latitude=6, min_latitude=3, max_longitude=-75, min_longitude=-85 where iso_department_code ='CO-VAC';
--Vaupés
update department set max_latitude=3, min_latitude=-2, max_longitude=-69, min_longitude=-73 where iso_department_code ='CO-VAU';
--Vichada
update department set max_latitude=7, min_latitude=2, max_longitude=-67, min_longitude=-72 where iso_department_code ='CO-VID';
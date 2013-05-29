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
  `lat` varchar(40) DEFAULT NULL,
  `lng` varchar(40) DEFAULT NULL,
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
-- Bogotá 
update department set lat='4.5980556', lng='-74.0758333', max_latitude=5, min_latitude=3, max_longitude=-73, min_longitude=-75 where iso_department_code ='CO-DC';
-- Amazonas 
update department set lat='-1.4429123', lng='-71.5723953', max_latitude=1, min_latitude=-5, max_longitude=-69, min_longitude=-75 where iso_department_code ='CO-AMA';
-- Antioquia 
update department set lat='7.1986064', lng='-75.3412179', max_latitude=10, min_latitude=5, max_longitude=-73, min_longitude=-78 where iso_department_code ='CO-ANT';
-- Arauca 
update department set lat='7.079371', lng='-70.758377', max_latitude=8, min_latitude=6, max_longitude=-69, min_longitude=-73 where iso_department_code ='CO-ARA';
-- Atlántico 
update department set lat='10.6966159', lng='-74.8741045', max_latitude=15, min_latitude=10, max_longitude=-74, min_longitude=-76 where iso_department_code ='CO-ATL';
-- Bolívar 
update department set lat='8.6704382', lng='-74.0300122', max_latitude=15, min_latitude=7, max_longitude=-73, min_longitude=-76 where iso_department_code ='CO-BOL';
-- Boyacá
update department set lat='5.6396331', lng='-72.8988069', max_latitude=8, min_latitude=4, max_longitude=-71, min_longitude=-75 where iso_department_code ='CO-BOY';
-- Caldas
update department set lat='5.25001', lng='-75.50003', max_latitude=6, min_latitude=4, max_longitude=-74, min_longitude=-76 where iso_department_code ='CO-CAL';
-- Caquetá
update department set lat='0.869892', lng='-73.8419063', max_latitude=3, min_latitude=-1, max_longitude=-71, min_longitude=-77 where iso_department_code ='CO-CAQ';
-- Casanare
update department set lat='5.7589269', lng='-71.5723953', max_latitude=7, min_latitude=4, max_longitude=-69, min_longitude=-74 where iso_department_code ='CO-CAS';
-- Cauca
update department set lat='2.2435893', lng='-77.010385', max_latitude=4, min_latitude=0, max_longitude=-75, min_longitude=-85 where iso_department_code ='CO-CAU';
-- Cesar
update department set lat='9.3372948', lng='-73.6536209', max_latitude=11, min_latitude=7, max_longitude=-72, min_longitude=-75 where iso_department_code ='CO-CES';
-- Córdoba
update department set lat='8.4029253', lng='-75.8998674', max_latitude=12, min_latitude=7, max_longitude=-74, min_longitude=-77 where iso_department_code ='CO-COR';
-- Cundinamarca
update department set lat='5.026003', lng='-74.0300122', max_latitude=6, min_latitude=3, max_longitude=-73, min_longitude=-75 where iso_department_code ='CO-CUN';
-- Chocó
update department set lat='5.2528033', lng='-76.8259652', max_latitude=9, min_latitude=3, max_longitude=-76, min_longitude=-85 where iso_department_code ='CO-CHO';
-- Guainía
update department set lat='2.585393', lng='-68.5247149', max_latitude=5, min_latitude=1, max_longitude=-66, min_longitude=-71 where iso_department_code ='CO-GUA';
-- Guaviare
update department set lat='2.043924', lng='-72.331113', max_latitude=3, min_latitude=0, max_longitude=-70, min_longitude=-74 where iso_department_code ='CO-GUV';
-- Huila
update department set lat='2.5359349', lng='-75.5276699', max_latitude=4, min_latitude=1, max_longitude=-74, min_longitude=-77 where iso_department_code ='CO-HUI';
-- La Guajira
update department set lat='11.3547743', lng='-72.5204827', max_latitude=16, min_latitude=10, max_longitude=-72, min_longitude=-74 where iso_department_code ='CO-LAG';
-- Magdalena
update department set lat='10.4113014', lng='-74.4056612', max_latitude=15, min_latitude=8, max_longitude=-73, min_longitude=-75 where iso_department_code ='CO-MAG';
-- Meta
update department set lat='3.2719904', lng='-73.087749', max_latitude=5, min_latitude=1, max_longitude=-71, min_longitude=-75 where iso_department_code ='CO-MET';
-- Nariño
update department set lat='1.6378981', lng='-77.7452081', max_latitude=3, min_latitude=0, max_longitude=-76, min_longitude=-85 where iso_department_code ='CO-NAR';
-- Norte de Santander
update department set lat='7.9462831', lng='-72.8988069', max_latitude=10, min_latitude=6, max_longitude=-72, min_longitude=-74 where iso_department_code ='CO-NSA';
-- Putumayo
update department set lat='0.4359506', lng='-75.5276699', max_latitude=2, min_latitude=-1, max_longitude=-73, min_longitude=-78 where iso_department_code ='CO-PUT';
-- Quindío
update department set lat='4.4610191', lng='-75.667356', max_latitude=5, min_latitude=3, max_longitude=-75, min_longitude=-76 where iso_department_code ='CO-QUI';
-- Risaralda
update department set lat='4.99243', lng='-76.01866', max_latitude=6, min_latitude=4, max_longitude=-75, min_longitude=-77 where iso_department_code ='CO-RIS';
-- San Andrés, Providencia y Santa Catalina
update department set lat='12.5567324', lng='-81.7185253', max_latitude=15, min_latitude=10, max_longitude=-77, min_longitude=-82 where iso_department_code ='CO-SAP';
-- Santander
update department set lat='6.6437076', lng='-73.6536209', max_latitude=9, min_latitude=5, max_longitude=-72, min_longitude=-75 where iso_department_code ='CO-SAN';
-- Sucre
update department set lat='9.1420384', lng='-75.0611147', max_latitude=11, min_latitude=8, max_longitude=-74, min_longitude=-77 where iso_department_code ='CO-SUC';
-- Tolima
update department set lat='4.0925168', lng='-75.1545381', max_latitude=6, min_latitude=2, max_longitude=-74, min_longitude=-77 where iso_department_code ='CO-TOL';
-- Valle del Cauca
update department set lat='3.8008893', lng='-76.6412712', max_latitude=6, min_latitude=3, max_longitude=-75, min_longitude=-85 where iso_department_code ='CO-VAC';
-- Vaupés
update department set lat='0.8553561', lng='-70.8119953', max_latitude=3, min_latitude=-2, max_longitude=-69, min_longitude=-73 where iso_department_code ='CO-VAU';
-- Vichada
update department set lat='4.4234452', lng='-69.2877535', max_latitude=7, min_latitude=2, max_longitude=-67, min_longitude=-72 where iso_department_code ='CO-VID';
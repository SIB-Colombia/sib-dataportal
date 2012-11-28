-- Addition by SiB Colombia
-- This update fills departments of Colombia data

-- populate the centi_cell_density for department
-- 8 is department lookup_cell_density_type
select concat('Building centi cells for department: ', now()) as debug;
insert into centi_cell_density 
select 8, d.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join department d on oc.iso_department_code=d.iso_department_code 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- clear the cell densities
-- Query OK, 0 rows affected (0.28 sec)
select concat('Clearing cells: ', now()) as debug;
truncate table cell_density;

-- build the cell_densities
-- Query OK, 13623180 rows affected (18 min 0.63 sec)
-- Records: 13623180  Duplicates: 0  Warnings: 0
select concat('Building cell densities: ', now()) as debug;
insert ignore into cell_density 
select type,entity_id,cell_id,sum(count)
from centi_cell_density
group by 1,2,3;

-- sets the departments count
select concat('Starting department occurrence count: ', now()) as debug;
update department d set occurrence_count =
(select count(id) from occurrence_record o where o.iso_department_code=d.iso_department_code);

-- set occurrence record coordinate count for department table
select concat('Starting department occurrence coordinate count: ', now()) as debug;
update department d set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=d.id and cd.type=8);

-- set species count per department
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting department species count: ', now()) as debug;
update department d set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.iso_department_code = d.iso_department_code);

-- End of SiB Colombia addition
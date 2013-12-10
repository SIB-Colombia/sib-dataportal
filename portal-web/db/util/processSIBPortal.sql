-- Addition by SiB Colombia

-- Here we ignore the validation of coordinates falling outside the country cells
-- since Colombian cells are not well configured in HIT so the validation aplies for 
-- coordinates that actually are in Colombia shape

-- removing logs of this marked issue
delete from gbif_log_message where event_id=1008 and occurrence_id  in 
(select id from occurrence_record where geospatial_issue=32);
-- removing geospatial_issue
update occurrence_record set geospatial_issue=0 where geospatial_issue=32;


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


-- This update fills counties of Colombia data

-- populate the centi_cell_density for county
-- 9 is county lookup_cell_density_type
select concat('Building centi cells for county: ', now()) as debug;
insert into centi_cell_density 
select 9, c.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join county c on oc.iso_county_code=c.iso_county_code 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;


-- sets the counties count
select concat('Starting county occurrence count: ', now()) as debug;
update county c set occurrence_count =
(select count(id) from occurrence_record o where o.iso_county_code=c.iso_county_code);

-- set occurrence record coordinate count for county table
select concat('Starting county occurrence coordinate count: ', now()) as debug;
update county c set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=c.id and cd.type=9);

-- set species count per department
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting county species count: ', now()) as debug;
update county c set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.iso_county_code = c.iso_county_code);


insert into centi_cell_density 
select 10, p.id, cell_id, centi_cell_id, count(oc.id)  
from occurrence_record oc 
inner join paramo p on oc.paramo=p.complex_id 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- sets the paramos count
SET SQL_SAFE_UPDATES=0;
select concat('Starting paramo occurrence count: ', now()) as debug;
update paramo p set occurrence_count =
(select count(id) from occurrence_record o where o.paramo=p.complex_id);

-- set occurrence record coordinate count for paramo table
select concat('Starting paramo occurrence coordinate count: ', now()) as debug;
update paramo p set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=p.id and cd.type=10);

-- set species count per paramo
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting paramo species count: ', now()) as debug;
update paramo p set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.paramo = p.complex_id);

-- End of SiB Colombia addition
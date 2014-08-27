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

-- populate the centi_cell_density for paramo
-- 10 is paramo lookup_cell_density_type
select concat('Building centi cells for county: ', now()) as debug;
insert into centi_cell_density 
select 10, p.id, cell_id, centi_cell_id, count(oc.id)  
from occurrence_record oc 
inner join paramo p on oc.paramo=p.complex_id 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for any paramo
-- 10 is paramo lookup_cell_density_type
select concat('Building centi cells for any paramo: ', now()) as debug;
insert into centi_cell_density 
select 10, 37 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.paramo is not null
and oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for marine zone
-- 11 is marine zone lookup_cell_density_type
select concat('Building centi cells for marine zone: ', now()) as debug;
insert into centi_cell_density 
select 11, m.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join marine_zone m on oc.marine_zone=m.mask 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for any marine zone
-- 11 is marine zone lookup_cell_density_type
select concat('Building centi cells for any marine zone: ', now()) as debug;
insert into centi_cell_density 
select 11, 8 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.marine_zone is not null
and oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for protected area
-- 12 is protected area lookup_cell_density_type
select concat('Building centi cells for protected area: ', now()) as debug;
insert into centi_cell_density 
select 11, pa.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join protected_area pa on oc.protected_area=pa.pa_id 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for ecosystem
-- 13 is ecosystem lookup_cell_density_type
select concat('Building centi cells for dry forest ecosystem: ', now()) as debug;
insert into centi_cell_density 
select 13, 1 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.dry_forest = 1
and oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

select concat('Building centi cells for paramo ecosystem: ', now()) as debug;
insert into centi_cell_density 
select 13, 2 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.paramo is not null
and oc.centi_cell_id is not null and oc.geospatial_issue=0
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


insert into centi_cell_density 
select 10, 37 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.paramo is not null
and oc.centi_cell_id is not null and oc.geospatial_issue=0
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

-- populate the centi_cell_density for dry forest ecosystem
insert into cell_density 
select 13, 1, cell_id, count(oc.id) 
from occurrence_record oc 
where oc.dry_forest = 1 
and oc.cell_id is not null 
and oc.geospatial_issue=0
group by 1,2,3;

-- populate the centi_cell_density for paramo ecosystem
insert into cell_density 
select 13, 2, cell_id, count(oc.id) 
from occurrence_record oc 
where oc.paramo is not null
and oc.cell_id is not null 
and oc.geospatial_issue=0
group by 1,2,3;

-- Addition by SiB Colombia
-- sets the dry forest ecosystem count
select concat('Starting dry forest ecosystem occurrence count: ', now()) as debug;
update ecosystem e set occurrence_count =
(select count(id) from occurrence_record o where o.dry_forest = 1)
where id = 1;

-- sets the paramo ecosystem count
select concat('Starting dry forest ecosystem occurrence count: ', now()) as debug;
update ecosystem e set occurrence_count =
(select count(id) from occurrence_record o where o.paramo is not null)
where id = 2;

-- set occurrence record coordinate count for ecosystem
select concat('Starting  ecosystem occurrence coordinate count: ', now()) as debug;
update ecosystem e set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=e.id and cd.type=13);

-- set species count per dry forest ecosystem
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting dry forest ecosystem species count: ', now()) as debug;
update ecosystem e set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.dry_forest = 1)
where id = 1;

-- set species count per paramo ecosystem
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting paramo ecosystem species count: ', now()) as debug;
update ecosystem e set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.paramo is not null)
where id = 2;


insert into centi_cell_density 
select 11, m.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join marine_zone m on oc.marine_zone=m.mask 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

insert into centi_cell_density 
select 11, 8 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.marine_zone is not null
and oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- sets the marine zones count
select concat('Starting marine zones occurrence count: ', now()) as debug;
update marine_zone m set occurrence_count =
(select count(id) from occurrence_record o where o.marine_zone=m.mask);

-- set occurrence record coordinate count for marine zones table
select concat('Starting marine zones occurrence coordinate count: ', now()) as debug;
update marine_zone m set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=m.id and cd.type=11);

-- set species count per marine zones
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting marine zones species count: ', now()) as debug;
update marine_zone m set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.marine_zone=m.mask);

-- sets the marine zones count for any
select concat('Starting marine zones occurrence count for any: ', now()) as debug;
update marine_zone m set occurrence_count =
(select count(id) from occurrence_record o where o.marine_zone is not null) where mask = 'CUA';

-- set species count per marine zones for any
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting marine zones species count for any: ', now()) as debug;
update marine_zone m set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.marine_zone is not null) where mask = 'CUA';

insert into centi_cell_density 
select 12, pa.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join protected_area pa on oc.protected_area=pa.pa_id 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- sets the protected areas count
select concat('Starting protected areas occurrence count: ', now()) as debug;
update protected_area pa set occurrence_count =
(select count(id) from occurrence_record o where o.protected_area=pa.pa_id);

-- set occurrence record coordinate count for protected areas table
select concat('Starting protected areas occurrence coordinate count: ', now()) as debug;
update protected_area pa set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=pa.id and cd.type=11);

-- set species count per protected areas
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting protected areas species count: ', now()) as debug;
update protected_area pa set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.protected_area=pa.pa_id);

-- End of SiB Colombia addition
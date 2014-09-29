-- populate the centi_cell_density for country
insert into centi_cell_density 
select 2, c.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join country c on oc.iso_country_code=c.iso_country_code 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the cell_density for home country
-- This is the data for data_providers tied to a country
insert into centi_cell_density 
select 6, c.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join data_provider dp on oc.data_provider_id=dp.id
inner join country c on dp.iso_country_code=c.iso_country_code
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for provider
insert into centi_cell_density
select 3,data_provider_id,cell_id,centi_cell_id,count(id)
from occurrence_record
where centi_cell_id is not null and geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for resource
insert into centi_cell_density
select 4,data_resource_id,cell_id,centi_cell_id,count(id)
from occurrence_record
where centi_cell_id is not null and geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for resource_network
insert into centi_cell_density
select 5,nm.resource_network_id,cell_id,centi_cell_id,count(oc.id)
from occurrence_record oc
inner join network_membership nm on oc.data_resource_id=nm.data_resource_id
where centi_cell_id is not null and oc.geospatial_issue=0
group by nm.resource_network_id, oc.cell_id, oc.centi_cell_id;

-- populate cell densities for all ORs on the denormalised nub id
insert ignore into centi_cell_density 
select 1, nc.kingdom_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore inner join taxon_concept nc on nc.id = ore.nub_concept_id
where nc.kingdom_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0
group by 1,2,3,4;

-- populate cell densities for all ORs on the denormalised nub id    
insert ignore into centi_cell_density 
select 1, nc.phylum_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
inner join taxon_concept nc on nc.id = ore.nub_concept_id
where nc.phylum_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0
group by 1,2,3,4;
    
-- populate cell densities for all ORs on the denormalised nub id
insert ignore into centi_cell_density
select 1, nc.class_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
inner join taxon_concept nc on nc.id = ore.nub_concept_id
where nc.class_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0
group by 1,2,3,4;

-- populate cell densities for all ORs on the denormalised nub id
insert ignore into centi_cell_density 
select 1, nc.order_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
inner join taxon_concept nc on nc.id = ore.nub_concept_id
where nc.order_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0
group by 1,2,3,4;
    
-- populate cell densities for all ORs on the denormalised nub id
insert ignore into centi_cell_density 
select 1, nc.family_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
inner join taxon_concept nc on nc.id = ore.nub_concept_id
where nc.family_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0
group by 1,2,3,4;
    
-- populate cell densities for all ORs on the denormalised nub id
insert ignore into centi_cell_density 
select 1, nc.genus_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
inner join taxon_concept nc on nc.id = ore.nub_concept_id
where nc.genus_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0
group by 1,2,3,4;

-- populate cell densities for all ORs on the denormalised nub id
insert ignore into centi_cell_density 
select 1, nc.species_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
inner join taxon_concept nc on nc.id = ore.nub_concept_id
where nc.species_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for taxonomy RUN THIS AFTER THE DENORMALISED!!!
insert ignore into centi_cell_density
select 1, nub_concept_id,cell_id,centi_cell_id,count(id)
from occurrence_record
where centi_cell_id is not null and geospatial_issue=0
group by 1,2,3,4;

-- populate for all things
insert ignore into centi_cell_density
select 0, 0,cell_id,centi_cell_id,count(id)
from occurrence_record
where centi_cell_id is not null and geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for department
insert into centi_cell_density 
select 8, d.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join department d on oc.iso_department_code=d.iso_department_code 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for county
insert into centi_cell_density 
select 9, c.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join county c on oc.iso_county_code=c.iso_county_code 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for paramo
insert into centi_cell_density 
select 10, p.id, cell_id, centi_cell_id, count(oc.id)  
from occurrence_record oc 
inner join paramo p on oc.paramo=p.complex_id 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for any paramo
insert into centi_cell_density 
select 10, 37, cell_id, centi_cell_id, count(oc.id)  
from occurrence_record oc 
where oc.paramo is not null
and oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for marine_zone
insert into centi_cell_density 
select 11, m.id, cell_id, centi_cell_id, count(oc.id)  
from occurrence_record oc 
inner join marine_zone m on oc.marine_zone=m.mask
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for any marine_zone
insert into centi_cell_density 
select 11, 8, cell_id, centi_cell_id, count(oc.id)  
from occurrence_record oc 
where oc.marine_zone is not null
and oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for any protected_area
insert into centi_cell_density 
select 12, pa.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join protected_area pa on oc.protected_area=pa.pa_id 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for any dry forest ecosystem
insert into centi_cell_density 
select 13, 1 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.dry_forest = 1
and oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for any paramo ecossytem
insert into centi_cell_density 
select 13, 2 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.paramo is not null
and oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;

-- populate the centi_cell_density for any zonificacion
insert into centi_cell_density 
select 14, z.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join zonificacion z on oc.zonificacion=z.szh 
where oc.centi_cell_id is not null and oc.geospatial_issue=0
group by 1,2,3,4;
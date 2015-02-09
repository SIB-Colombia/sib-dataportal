/**
 * The process script will finalise the building of a database AFTER the nub has been built and the 
 * taxonomies denormalised. 
 *
 * last updated: 03.04.2009 (ahahn): added statistical tables for country and participant contribution overview
 * -- 12.8.2008 (ahahn): regenerate network membership for country nodes 
 * -- 08/2009 (jcuadra): 
 */

-- May 6, 2008: 134,704,562 records on rancor (applies to all processing counts below)

-- Renews the network membership information for the country nodes
-- step 1: delete old records
-- !! take care: this relies on a literal value in the resource_network table which might change!
-- !! take care: this does not add new entries to resource_network!
select concat('Deleting network membership entries for country nodes: ', now()) as debug;
delete  network_membership.* 
from resource_network 
join network_membership on resource_network.id = network_membership.resource_network_id 
where resource_network.name like 'Resources hosted by%' ;

-- Renews the network membership information for the country nodes
-- step 2: generate new entries for network_membership based on providers' iso country codes
select concat('Adding new network membership entries for country nodes: ', now()) as debug;
insert into network_membership (data_resource_id, resource_network_id)
select d.id,
rn.id
from data_resource d
join data_provider p on d.data_provider_id = p.id
join resource_network rn on p.iso_country_code = rn.code
where p.iso_country_code is not null
and d.deleted is null;

-- Renews the network membership information for the country nodes
-- step 3: update the dataset counts for the resource network table
select concat('Updating the dataset counts for resource networks: ', now()) as debug;
update resource_network rn set data_resource_count =
(select count(nm.data_resource_id) from network_membership nm where nm.resource_network_id = rn.id);

-- Ties the OR to the nub and copies in the denormalised data 
-- Query OK, 14485805 rows affected (1 hour 35 min 8.55 sec)
-- Rows matched: 134704562  Changed: 14485805  Warnings: 0
select concat('Starting joining the OR to TC: ', now()) as debug;
update occurrence_record o inner join taxon_concept t on o.taxon_concept_id = t.id set o.nub_concept_id = t.partner_concept_id;

-- Copy the denormalised taxonomy to occurrence_record
-- Query OK, 16032162 rows affected (3 hours 25 min 51.67 sec)
-- Rows matched: 134476889  Changed: 16032162  Warnings: 0
select concat('Starting copying the denormalised taxonomy to OR: ', now()) as debug;
update occurrence_record o 
    inner join taxon_concept tc on o.nub_concept_id=tc.id
set 
    o.kingdom_concept_id=tc.kingdom_concept_id,
    o.phylum_concept_id=tc.phylum_concept_id,
    o.class_concept_id=tc.class_concept_id,
    o.order_concept_id=tc.order_concept_id,
    o.family_concept_id=tc.family_concept_id,
    o.genus_concept_id=tc.genus_concept_id,
    o.species_concept_id=tc.species_concept_id;

-- ***********************************
-- Addition by SiB Colombia
-- Here we ignore the validation of coordinates falling outside the country cells
-- since Colombian cells are not well configured in HIT so the validation aplies for 
-- coordinates that actually are in Colombia shape
-- ***********************************
-- Assigns all possible occurrences for basis of record ids to the corresponding DarwinCore

-- populate basis_of_record according to differents possible ids.
-- Preserved Specimen
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='7' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%preservedspecimen%');
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='7' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%especimenpreservado%');
-- Fossil Specimen
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='8' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%fossilspecimen%');
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='8' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%especimenfosilizado%');
-- Living Specimen
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='9' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%livingspecimen%');
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='9' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%especimenvivo%');
-- Human Observation
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='10' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%humanobservation%');
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='10' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%observacionhumana%');
-- Machine Observation
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='11' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%machineobservation%');
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='11' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%observacionconmaquina%');
-- Occurrence
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='16' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%occurrence%');
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='16' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%registrobiologico%');
-- Human Observation
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='17' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%materialsample%');
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='17' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%muestradematerial%');
-- Machine Observation
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='18' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%event%');
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='18' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%evento%');
-- Still Image
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='19' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%location%');
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='19' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%ubicacion%');
-- Moving Image
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='20' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%taxon%');
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='20' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%taxon%');
-- Sound Recording
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='21' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%nomenclaturalchecklist%');
update occurrence_record, raw_occurrence_record set occurrence_record.basis_of_record ='21' where raw_occurrence_record.id = occurrence_record.id and replace(lower(raw_occurrence_record.basis_of_record),' ','') like ('%listadecomprobaciondenomenclatura%');

-- Assigns all possible occurrences for department names to the corresponding ISO-CODE

-- populate iso_department_code according to differents possible names.
-- Bogotá, D.C
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('distrito capital de bogotá') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('distrito capital') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá, d.c.') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá d.c.') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá, d.c') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogota, d.c.') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogota d.c.') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogota') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá')and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('santafé de bogotá') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá, distrito capital') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá, distrito capital') and(occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-dc') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='11') and (occurrence_record.iso_country_code='CO');

-- Amazonas
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-AMA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('amazonas') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-AMA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-ama') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-AMA' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='91') and (occurrence_record.iso_country_code='CO');

-- Antioquia
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ANT' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('antioquia') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ANT' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-ant') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ANT' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='05' or raw_occurrence_record.state_province='5') and (occurrence_record.iso_country_code='CO');

-- Arauca
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ARA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('arauca') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ARA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-ara') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ARA' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='81') and (occurrence_record.iso_country_code='CO');

-- Atlántico
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ATL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('atlántico') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ATL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('atlantico') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ATL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-atl') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ATL' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='08' or raw_occurrence_record.state_province='8') and (occurrence_record.iso_country_code='CO');

-- Bolívar
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bolívar') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bolivar') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-bol') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOL' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='13') and (occurrence_record.iso_country_code='CO');

-- Boyacá
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOY' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('boyacá') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOY' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('boyaca') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOY' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-boy') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOY' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='15') and (occurrence_record.iso_country_code='CO');

-- Caldas
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('caldas') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cal') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAL' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='17') and (occurrence_record.iso_country_code='CO');

-- Caquetá
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAQ' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('caquetá') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAQ' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('caqueta')and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAQ' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-caq')and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAQ' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='18') and (occurrence_record.iso_country_code='CO');

-- Casanare
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAS' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('casanare') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAS' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cas') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAS' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='85') and (occurrence_record.iso_country_code='CO');

-- Cauca
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cauca') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cau') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAU' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='19') and (occurrence_record.iso_country_code='CO');

-- Cesar
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CES' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cesar') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CES' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-ces') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CES' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='20') and (occurrence_record.iso_country_code='CO');

-- Córdoba
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-COR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('córdoba') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-COR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cordoba') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-COR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cor') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-COR' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='23') and (occurrence_record.iso_country_code='CO');

-- Cundinamarca
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CUN' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cundinamarca') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CUN' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cun') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CUN' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='25') and (occurrence_record.iso_country_code='CO');

-- Chocó
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CHO' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('chocó') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CHO' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('choco') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CHO' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cho') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CHO' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='27') and (occurrence_record.iso_country_code='CO');

-- Guainía
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('guainía') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('guainia') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-gua') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUA' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='94') and (occurrence_record.iso_country_code='CO');

-- Guaviare
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUV' where raw_occurrence_record.id = occurrence_record.id and lower(raw_occurrence_record.state_province)=('guaviare') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUV' where raw_occurrence_record.id = occurrence_record.id and lower(raw_occurrence_record.state_province)=('co-guv') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUV' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='95') and (occurrence_record.iso_country_code='CO');

-- Huila
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-HUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('huila') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-HUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-hui') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-HUI' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='41') and (occurrence_record.iso_country_code='CO');

-- La Guajira
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-LAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('la guajira') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-LAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('guajira') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-LAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-lag') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-LAG' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='44') and (occurrence_record.iso_country_code='CO');

-- Magdalena
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('magdalena') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-mag') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MAG' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='47') and (occurrence_record.iso_country_code='CO');

-- Meta
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MET' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('meta') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MET' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-met') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MET' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='50') and (occurrence_record.iso_country_code='CO');

-- Nariño
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NAR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('nariño') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NAR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('narino') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NAR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-nar') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NAR' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='52') and (occurrence_record.iso_country_code='CO');

-- Norte de Santander
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NSA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('norte de santander') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NSA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-nsa') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NSA' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='54') and (occurrence_record.iso_country_code='CO');

-- Putumayo
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-PUT' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('putumayo') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-PUT' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-put') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-PUT' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='86') and (occurrence_record.iso_country_code='CO');

-- Quindío
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-QUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('quindío') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-QUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('quindio') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-QUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-qui') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-QUI' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='63') and (occurrence_record.iso_country_code='CO');

-- Risaralda
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-RIS' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('risaralda') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-RIS' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-ris') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-RIS' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='66') and (occurrence_record.iso_country_code='CO');

-- Archipiélago de San Andrés, Providencia y Santa Catalina
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andrés y providencia') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andres y providencia') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('archipiélago de san andrés, providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('archipiélago de san andrés providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('archipielago de san andres, providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('archipielago de san andres providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andrés') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andres') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andrés, providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andres, providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-sap') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='88') and (occurrence_record.iso_country_code='CO');

-- Santander
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAN' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('santander') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAN' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-san') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAN' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='68') and (occurrence_record.iso_country_code='CO');

-- Sucre
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SUC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('sucre') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SUC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-suc') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SUC' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='70') and (occurrence_record.iso_country_code='CO');

-- Tolima
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-TOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('tolima') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-TOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-tol') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-TOL' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='73') and (occurrence_record.iso_country_code='CO');

-- Valle del Cauca
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('valle del cauca') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('valle') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-vac') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAC' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='76') and (occurrence_record.iso_country_code='CO');

-- Vaupés
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('vaupés') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('vaupes') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-vau') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAU' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='97') and (occurrence_record.iso_country_code='CO');

-- Vichada
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VID' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('vichada') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VID' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-vid') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VID' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='99') and (occurrence_record.iso_country_code='CO');


-- Assigns all possible occurrences for county codes to the corresponding ISO-CODE

-- populate iso_county_code according to differents possible codes.
update occurrence_record, raw_occurrence_record set iso_county_code = '05001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('medellín');
update occurrence_record, raw_occurrence_record set iso_county_code = '05002' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('abejorral');
update occurrence_record, raw_occurrence_record set iso_county_code = '05004' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('abriaquí');
update occurrence_record, raw_occurrence_record set iso_county_code = '05021' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('alejandría');
update occurrence_record, raw_occurrence_record set iso_county_code = '05030' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('amagá');
update occurrence_record, raw_occurrence_record set iso_county_code = '05031' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('amalfi');
update occurrence_record, raw_occurrence_record set iso_county_code = '05034' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('andes');
update occurrence_record, raw_occurrence_record set iso_county_code = '05036' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('angelópolis');
update occurrence_record, raw_occurrence_record set iso_county_code = '05038' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('angostura');
update occurrence_record, raw_occurrence_record set iso_county_code = '05040' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('anorí');
update occurrence_record, raw_occurrence_record set iso_county_code = '05042' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('santafé de antioquia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05044' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('anza');
update occurrence_record, raw_occurrence_record set iso_county_code = '05045' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('apartadó');
update occurrence_record, raw_occurrence_record set iso_county_code = '05051' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('arboletes');
update occurrence_record, raw_occurrence_record set iso_county_code = '05055' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('argelia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05059' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('armenia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05079' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('barbosa');
update occurrence_record, raw_occurrence_record set iso_county_code = '05086' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('belmira');
update occurrence_record, raw_occurrence_record set iso_county_code = '05088' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('bello');
update occurrence_record, raw_occurrence_record set iso_county_code = '05091' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('betania');
update occurrence_record, raw_occurrence_record set iso_county_code = '05093' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('betulia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05101' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('ciudad bolívar');
update occurrence_record, raw_occurrence_record set iso_county_code = '05107' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('briceño');
update occurrence_record, raw_occurrence_record set iso_county_code = '05113' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('buriticá');
update occurrence_record, raw_occurrence_record set iso_county_code = '05120' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('cáceres');
update occurrence_record, raw_occurrence_record set iso_county_code = '05125' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('caicedo');
update occurrence_record, raw_occurrence_record set iso_county_code = '05129' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('caldas');
update occurrence_record, raw_occurrence_record set iso_county_code = '05134' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('campamento');
update occurrence_record, raw_occurrence_record set iso_county_code = '05138' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('cañasgordas');
update occurrence_record, raw_occurrence_record set iso_county_code = '05142' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('caracolí');
update occurrence_record, raw_occurrence_record set iso_county_code = '05145' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('caramanta');
update occurrence_record, raw_occurrence_record set iso_county_code = '05147' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('carepa');
update occurrence_record, raw_occurrence_record set iso_county_code = '05148' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('el carmen de viboral');
update occurrence_record, raw_occurrence_record set iso_county_code = '05150' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('carolina');
update occurrence_record, raw_occurrence_record set iso_county_code = '05154' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('caucasia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05172' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('chigorodó');
update occurrence_record, raw_occurrence_record set iso_county_code = '05190' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('cisneros');
update occurrence_record, raw_occurrence_record set iso_county_code = '05197' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('cocorná');
update occurrence_record, raw_occurrence_record set iso_county_code = '05206' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('concepción');
update occurrence_record, raw_occurrence_record set iso_county_code = '05209' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('concordia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05212' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('copacabana');
update occurrence_record, raw_occurrence_record set iso_county_code = '05234' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('dabeiba');
update occurrence_record, raw_occurrence_record set iso_county_code = '05237' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('donmatías');
update occurrence_record, raw_occurrence_record set iso_county_code = '05240' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('ebéjico');
update occurrence_record, raw_occurrence_record set iso_county_code = '05250' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('el bagre');
update occurrence_record, raw_occurrence_record set iso_county_code = '05264' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('entrerrios');
update occurrence_record, raw_occurrence_record set iso_county_code = '05266' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('envigado');
update occurrence_record, raw_occurrence_record set iso_county_code = '05282' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('fredonia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05284' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('frontino');
update occurrence_record, raw_occurrence_record set iso_county_code = '05306' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('giraldo');
update occurrence_record, raw_occurrence_record set iso_county_code = '05308' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('girardota');
update occurrence_record, raw_occurrence_record set iso_county_code = '05310' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('gómez plata');
update occurrence_record, raw_occurrence_record set iso_county_code = '05313' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('granada');
update occurrence_record, raw_occurrence_record set iso_county_code = '05315' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('guadalupe');
update occurrence_record, raw_occurrence_record set iso_county_code = '05318' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('guarne');
update occurrence_record, raw_occurrence_record set iso_county_code = '05321' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('guatape');
update occurrence_record, raw_occurrence_record set iso_county_code = '05347' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('heliconia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05353' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('hispania');
update occurrence_record, raw_occurrence_record set iso_county_code = '05360' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('itagui');
update occurrence_record, raw_occurrence_record set iso_county_code = '05361' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('ituango');
update occurrence_record, raw_occurrence_record set iso_county_code = '05364' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('jardín');
update occurrence_record, raw_occurrence_record set iso_county_code = '05368' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('jericó');
update occurrence_record, raw_occurrence_record set iso_county_code = '05376' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('la ceja');
update occurrence_record, raw_occurrence_record set iso_county_code = '05380' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('la estrella');
update occurrence_record, raw_occurrence_record set iso_county_code = '05390' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('la pintada');
update occurrence_record, raw_occurrence_record set iso_county_code = '05400' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('la unión');
update occurrence_record, raw_occurrence_record set iso_county_code = '05411' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('liborina');
update occurrence_record, raw_occurrence_record set iso_county_code = '05425' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('maceo');
update occurrence_record, raw_occurrence_record set iso_county_code = '05440' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('marinilla');
update occurrence_record, raw_occurrence_record set iso_county_code = '05467' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('montebello');
update occurrence_record, raw_occurrence_record set iso_county_code = '05475' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('murindó');
update occurrence_record, raw_occurrence_record set iso_county_code = '05480' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('mutatá');
update occurrence_record, raw_occurrence_record set iso_county_code = '05483' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('nariño');
update occurrence_record, raw_occurrence_record set iso_county_code = '05490' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('necoclí');
update occurrence_record, raw_occurrence_record set iso_county_code = '05495' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('nechí');
update occurrence_record, raw_occurrence_record set iso_county_code = '05501' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('olaya');
update occurrence_record, raw_occurrence_record set iso_county_code = '05541' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('peñol');
update occurrence_record, raw_occurrence_record set iso_county_code = '05543' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('peque');
update occurrence_record, raw_occurrence_record set iso_county_code = '05576' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('pueblorrico');
update occurrence_record, raw_occurrence_record set iso_county_code = '05579' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('puerto berrío');
update occurrence_record, raw_occurrence_record set iso_county_code = '05585' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('puerto nare');
update occurrence_record, raw_occurrence_record set iso_county_code = '05591' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('puerto triunfo');
update occurrence_record, raw_occurrence_record set iso_county_code = '05604' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('remedios');
update occurrence_record, raw_occurrence_record set iso_county_code = '05607' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('retiro');
update occurrence_record, raw_occurrence_record set iso_county_code = '05615' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('rionegro');
update occurrence_record, raw_occurrence_record set iso_county_code = '05628' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('sabanalarga');
update occurrence_record, raw_occurrence_record set iso_county_code = '05631' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('sabaneta');
update occurrence_record, raw_occurrence_record set iso_county_code = '05642' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('salgar');
update occurrence_record, raw_occurrence_record set iso_county_code = '05647' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san andrés de cuerquia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05649' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san carlos');
update occurrence_record, raw_occurrence_record set iso_county_code = '05652' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san francisco');
update occurrence_record, raw_occurrence_record set iso_county_code = '05656' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san jerónimo');
update occurrence_record, raw_occurrence_record set iso_county_code = '05658' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san josé de la montaña');
update occurrence_record, raw_occurrence_record set iso_county_code = '05659' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san juan de urabá');
update occurrence_record, raw_occurrence_record set iso_county_code = '05660' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san luis');
update occurrence_record, raw_occurrence_record set iso_county_code = '05664' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san pedro de los milagros');
update occurrence_record, raw_occurrence_record set iso_county_code = '05665' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san pedro de uraba');
update occurrence_record, raw_occurrence_record set iso_county_code = '05667' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san rafael');
update occurrence_record, raw_occurrence_record set iso_county_code = '05670' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san roque');
update occurrence_record, raw_occurrence_record set iso_county_code = '05674' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('san vicente');
update occurrence_record, raw_occurrence_record set iso_county_code = '05679' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('santa bárbara');
update occurrence_record, raw_occurrence_record set iso_county_code = '05686' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('santa rosa de osos');
update occurrence_record, raw_occurrence_record set iso_county_code = '05690' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('santo domingo');
update occurrence_record, raw_occurrence_record set iso_county_code = '05697' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('el santuario');
update occurrence_record, raw_occurrence_record set iso_county_code = '05736' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('segovia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05756' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('sonson');
update occurrence_record, raw_occurrence_record set iso_county_code = '05761' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('sopetrán');
update occurrence_record, raw_occurrence_record set iso_county_code = '05789' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('támesis');
update occurrence_record, raw_occurrence_record set iso_county_code = '05790' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('tarazá');
update occurrence_record, raw_occurrence_record set iso_county_code = '05792' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('tarso');
update occurrence_record, raw_occurrence_record set iso_county_code = '05809' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('titiribí');
update occurrence_record, raw_occurrence_record set iso_county_code = '05819' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('toledo');
update occurrence_record, raw_occurrence_record set iso_county_code = '05837' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('turbo');
update occurrence_record, raw_occurrence_record set iso_county_code = '05842' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('uramita');
update occurrence_record, raw_occurrence_record set iso_county_code = '05847' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('urrao');
update occurrence_record, raw_occurrence_record set iso_county_code = '05854' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('valdivia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05856' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('valparaíso');
update occurrence_record, raw_occurrence_record set iso_county_code = '05858' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('vegachi');
update occurrence_record, raw_occurrence_record set iso_county_code = '05861' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('venecia');
update occurrence_record, raw_occurrence_record set iso_county_code = '05873' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('vigía del fuerte');
update occurrence_record, raw_occurrence_record set iso_county_code = '05885' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('yalí');
update occurrence_record, raw_occurrence_record set iso_county_code = '05887' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('yarumal');
update occurrence_record, raw_occurrence_record set iso_county_code = '05890' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('yolombó');
update occurrence_record, raw_occurrence_record set iso_county_code = '05893' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('yondó');
update occurrence_record, raw_occurrence_record set iso_county_code = '05895' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ANT' and lower (raw_occurrence_record.county)=('zaragoza');
update occurrence_record, raw_occurrence_record set iso_county_code = '08001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('barranquilla');
update occurrence_record, raw_occurrence_record set iso_county_code = '08078' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('baranoa');
update occurrence_record, raw_occurrence_record set iso_county_code = '08137' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('campo de la cruz');
update occurrence_record, raw_occurrence_record set iso_county_code = '08141' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('candelaria');
update occurrence_record, raw_occurrence_record set iso_county_code = '08296' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('galapa');
update occurrence_record, raw_occurrence_record set iso_county_code = '08372' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('juan de acosta');
update occurrence_record, raw_occurrence_record set iso_county_code = '08421' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('luruaco');
update occurrence_record, raw_occurrence_record set iso_county_code = '08433' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('malambo');
update occurrence_record, raw_occurrence_record set iso_county_code = '08436' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('manatí');
update occurrence_record, raw_occurrence_record set iso_county_code = '08520' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('palmar de varela');
update occurrence_record, raw_occurrence_record set iso_county_code = '08549' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('piojó');
update occurrence_record, raw_occurrence_record set iso_county_code = '08558' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('polonuevo');
update occurrence_record, raw_occurrence_record set iso_county_code = '08560' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('ponedera');
update occurrence_record, raw_occurrence_record set iso_county_code = '08573' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('puerto colombia');
update occurrence_record, raw_occurrence_record set iso_county_code = '08606' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('repelón');
update occurrence_record, raw_occurrence_record set iso_county_code = '08634' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('sabanagrande');
update occurrence_record, raw_occurrence_record set iso_county_code = '08638' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('sabanalarga');
update occurrence_record, raw_occurrence_record set iso_county_code = '08675' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('santa lucía');
update occurrence_record, raw_occurrence_record set iso_county_code = '08685' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('santo tomás');
update occurrence_record, raw_occurrence_record set iso_county_code = '08758' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('soledad');
update occurrence_record, raw_occurrence_record set iso_county_code = '08770' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('suan');
update occurrence_record, raw_occurrence_record set iso_county_code = '08832' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('tubará');
update occurrence_record, raw_occurrence_record set iso_county_code = '08849' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ATL' and lower (raw_occurrence_record.county)=('usiacurí');
update occurrence_record, raw_occurrence_record set iso_county_code = '11001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-DC' and lower (raw_occurrence_record.county)=('distrito capital de bogotá');
update occurrence_record, raw_occurrence_record set iso_county_code = '11001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-DC' and lower (raw_occurrence_record.county)=('distrito capital');
update occurrence_record, raw_occurrence_record set iso_county_code = '11001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-DC' and lower (raw_occurrence_record.county)=('bogotá, d.c.');
update occurrence_record, raw_occurrence_record set iso_county_code = '11001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-DC' and lower (raw_occurrence_record.county)=('bogotá');
update occurrence_record, raw_occurrence_record set iso_county_code = '11001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-DC' and lower (raw_occurrence_record.county)=('santafé de bogotá');
update occurrence_record, raw_occurrence_record set iso_county_code = '11001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-DC' and lower (raw_occurrence_record.county)=('bogotá, distrito capital');
update occurrence_record, raw_occurrence_record set iso_county_code = '13074' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('barranco de loba');
update occurrence_record, raw_occurrence_record set iso_county_code = '13140' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('calamar');
update occurrence_record, raw_occurrence_record set iso_county_code = '13160' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('cantagallo');
update occurrence_record, raw_occurrence_record set iso_county_code = '13188' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('cicuco');
update occurrence_record, raw_occurrence_record set iso_county_code = '13212' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('córdoba');
update occurrence_record, raw_occurrence_record set iso_county_code = '13222' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('clemencia');
update occurrence_record, raw_occurrence_record set iso_county_code = '13244' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('el carmen de bolívar');
update occurrence_record, raw_occurrence_record set iso_county_code = '13248' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('el guamo');
update occurrence_record, raw_occurrence_record set iso_county_code = '13268' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('el peñón');
update occurrence_record, raw_occurrence_record set iso_county_code = '13300' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('hatillo de loba');
update occurrence_record, raw_occurrence_record set iso_county_code = '13430' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('magangué');
update occurrence_record, raw_occurrence_record set iso_county_code = '13433' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('mahates');
update occurrence_record, raw_occurrence_record set iso_county_code = '13440' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('margarita');
update occurrence_record, raw_occurrence_record set iso_county_code = '13442' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('maría la baja');
update occurrence_record, raw_occurrence_record set iso_county_code = '13458' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('montecristo');
update occurrence_record, raw_occurrence_record set iso_county_code = '13468' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('mompós');
update occurrence_record, raw_occurrence_record set iso_county_code = '13473' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('morales');
update occurrence_record, raw_occurrence_record set iso_county_code = '13490' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('norosí');
update occurrence_record, raw_occurrence_record set iso_county_code = '13549' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('pinillos');
update occurrence_record, raw_occurrence_record set iso_county_code = '13580' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('regidor');
update occurrence_record, raw_occurrence_record set iso_county_code = '13600' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('río viejo');
update occurrence_record, raw_occurrence_record set iso_county_code = '13620' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('san cristóbal');
update occurrence_record, raw_occurrence_record set iso_county_code = '13647' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('san estanislao');
update occurrence_record, raw_occurrence_record set iso_county_code = '13650' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('san fernando');
update occurrence_record, raw_occurrence_record set iso_county_code = '13654' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('san jacinto');
update occurrence_record, raw_occurrence_record set iso_county_code = '13655' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('san jacinto del cauca');
update occurrence_record, raw_occurrence_record set iso_county_code = '13657' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('san juan nepomuceno');
update occurrence_record, raw_occurrence_record set iso_county_code = '13667' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('san martín de loba');
update occurrence_record, raw_occurrence_record set iso_county_code = '13670' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('san pablo');
update occurrence_record, raw_occurrence_record set iso_county_code = '13673' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('santa catalina');
update occurrence_record, raw_occurrence_record set iso_county_code = '13683' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('santa rosa');
update occurrence_record, raw_occurrence_record set iso_county_code = '13688' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('santa rosa del sur');
update occurrence_record, raw_occurrence_record set iso_county_code = '13744' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('simití');
update occurrence_record, raw_occurrence_record set iso_county_code = '13760' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('soplaviento');
update occurrence_record, raw_occurrence_record set iso_county_code = '13780' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('talaigua nuevo');
update occurrence_record, raw_occurrence_record set iso_county_code = '13810' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('tiquisio');
update occurrence_record, raw_occurrence_record set iso_county_code = '13836' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('turbaco');
update occurrence_record, raw_occurrence_record set iso_county_code = '13838' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('turbaná');
update occurrence_record, raw_occurrence_record set iso_county_code = '13873' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('villanueva');
update occurrence_record, raw_occurrence_record set iso_county_code = '13894' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOL' and lower (raw_occurrence_record.county)=('zambrano');
update occurrence_record, raw_occurrence_record set iso_county_code = '15001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tunja');
update occurrence_record, raw_occurrence_record set iso_county_code = '15022' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('almeida');
update occurrence_record, raw_occurrence_record set iso_county_code = '15047' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('aquitania');
update occurrence_record, raw_occurrence_record set iso_county_code = '15051' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('arcabuco');
update occurrence_record, raw_occurrence_record set iso_county_code = '15087' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('belén');
update occurrence_record, raw_occurrence_record set iso_county_code = '15090' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('berbeo');
update occurrence_record, raw_occurrence_record set iso_county_code = '15092' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('betéitiva');
update occurrence_record, raw_occurrence_record set iso_county_code = '15097' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('boavita');
update occurrence_record, raw_occurrence_record set iso_county_code = '15104' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('boyacá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15106' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('briceño');
update occurrence_record, raw_occurrence_record set iso_county_code = '15109' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('buenavista');
update occurrence_record, raw_occurrence_record set iso_county_code = '15114' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('busbanzá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15131' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('caldas');
update occurrence_record, raw_occurrence_record set iso_county_code = '15135' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('campohermoso');
update occurrence_record, raw_occurrence_record set iso_county_code = '15162' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('cerinza');
update occurrence_record, raw_occurrence_record set iso_county_code = '15172' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('chinavita');
update occurrence_record, raw_occurrence_record set iso_county_code = '15176' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('chiquinquirá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15180' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('chiscas');
update occurrence_record, raw_occurrence_record set iso_county_code = '15183' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('chita');
update occurrence_record, raw_occurrence_record set iso_county_code = '15185' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('chitaraque');
update occurrence_record, raw_occurrence_record set iso_county_code = '15187' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('chivatá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15189' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('ciénega');
update occurrence_record, raw_occurrence_record set iso_county_code = '15204' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('cómbita');
update occurrence_record, raw_occurrence_record set iso_county_code = '15212' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('coper');
update occurrence_record, raw_occurrence_record set iso_county_code = '15215' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('corrales');
update occurrence_record, raw_occurrence_record set iso_county_code = '15218' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('covarachía');
update occurrence_record, raw_occurrence_record set iso_county_code = '15223' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('cubará');
update occurrence_record, raw_occurrence_record set iso_county_code = '15224' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('cucaita');
update occurrence_record, raw_occurrence_record set iso_county_code = '15226' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('cuítiva');
update occurrence_record, raw_occurrence_record set iso_county_code = '15232' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('chíquiza');
update occurrence_record, raw_occurrence_record set iso_county_code = '15236' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('chivor');
update occurrence_record, raw_occurrence_record set iso_county_code = '15238' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('duitama');
update occurrence_record, raw_occurrence_record set iso_county_code = '15244' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('el cocuy');
update occurrence_record, raw_occurrence_record set iso_county_code = '15248' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('el espino');
update occurrence_record, raw_occurrence_record set iso_county_code = '15272' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('firavitoba');
update occurrence_record, raw_occurrence_record set iso_county_code = '15276' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('floresta');
update occurrence_record, raw_occurrence_record set iso_county_code = '15293' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('gachantivá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15296' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('gameza');
update occurrence_record, raw_occurrence_record set iso_county_code = '15299' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('garagoa');
update occurrence_record, raw_occurrence_record set iso_county_code = '15317' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('guacamayas');
update occurrence_record, raw_occurrence_record set iso_county_code = '15322' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('guateque');
update occurrence_record, raw_occurrence_record set iso_county_code = '15325' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('guayatá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15332' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('güicán');
update occurrence_record, raw_occurrence_record set iso_county_code = '15362' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('iza');
update occurrence_record, raw_occurrence_record set iso_county_code = '15367' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('jenesano');
update occurrence_record, raw_occurrence_record set iso_county_code = '15368' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('jericó');
update occurrence_record, raw_occurrence_record set iso_county_code = '15377' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('labranzagrande');
update occurrence_record, raw_occurrence_record set iso_county_code = '15380' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('la capilla');
update occurrence_record, raw_occurrence_record set iso_county_code = '15401' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('la victoria');
update occurrence_record, raw_occurrence_record set iso_county_code = '15403' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('la uvita');
update occurrence_record, raw_occurrence_record set iso_county_code = '15407' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('villa de leyva');
update occurrence_record, raw_occurrence_record set iso_county_code = '15425' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('macanal');
update occurrence_record, raw_occurrence_record set iso_county_code = '15442' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('maripí');
update occurrence_record, raw_occurrence_record set iso_county_code = '15455' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('miraflores');
update occurrence_record, raw_occurrence_record set iso_county_code = '15464' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('mongua');
update occurrence_record, raw_occurrence_record set iso_county_code = '15466' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('monguí');
update occurrence_record, raw_occurrence_record set iso_county_code = '15469' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('moniquirá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15476' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('motavita');
update occurrence_record, raw_occurrence_record set iso_county_code = '15480' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('muzo');
update occurrence_record, raw_occurrence_record set iso_county_code = '15491' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('nobsa');
update occurrence_record, raw_occurrence_record set iso_county_code = '15494' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('nuevo colón');
update occurrence_record, raw_occurrence_record set iso_county_code = '15500' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('oicatá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15507' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('otanche');
update occurrence_record, raw_occurrence_record set iso_county_code = '15511' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('pachavita');
update occurrence_record, raw_occurrence_record set iso_county_code = '15514' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('páez');
update occurrence_record, raw_occurrence_record set iso_county_code = '15516' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('paipa');
update occurrence_record, raw_occurrence_record set iso_county_code = '15518' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('pajarito');
update occurrence_record, raw_occurrence_record set iso_county_code = '15522' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('panqueba');
update occurrence_record, raw_occurrence_record set iso_county_code = '15531' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('pauna');
update occurrence_record, raw_occurrence_record set iso_county_code = '15533' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('paya');
update occurrence_record, raw_occurrence_record set iso_county_code = '15537' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('paz de río');
update occurrence_record, raw_occurrence_record set iso_county_code = '15542' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('pesca');
update occurrence_record, raw_occurrence_record set iso_county_code = '15550' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('pisba');
update occurrence_record, raw_occurrence_record set iso_county_code = '15572' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('puerto boyacá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15580' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('quípama');
update occurrence_record, raw_occurrence_record set iso_county_code = '15599' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('ramiriquí');
update occurrence_record, raw_occurrence_record set iso_county_code = '15600' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('ráquira');
update occurrence_record, raw_occurrence_record set iso_county_code = '15621' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('rondón');
update occurrence_record, raw_occurrence_record set iso_county_code = '15632' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('saboyá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15638' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('sáchica');
update occurrence_record, raw_occurrence_record set iso_county_code = '15646' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('samacá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15660' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('san eduardo');
update occurrence_record, raw_occurrence_record set iso_county_code = '15664' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('san josé de pare');
update occurrence_record, raw_occurrence_record set iso_county_code = '15667' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('san luis de gaceno');
update occurrence_record, raw_occurrence_record set iso_county_code = '15673' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('san mateo');
update occurrence_record, raw_occurrence_record set iso_county_code = '15676' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('san miguel de sema');
update occurrence_record, raw_occurrence_record set iso_county_code = '15681' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('san pablo de borbur');
update occurrence_record, raw_occurrence_record set iso_county_code = '15686' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('santana');
update occurrence_record, raw_occurrence_record set iso_county_code = '15690' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('santa maría');
update occurrence_record, raw_occurrence_record set iso_county_code = '15693' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('santa rosa de viterbo');
update occurrence_record, raw_occurrence_record set iso_county_code = '15696' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('santa sofía');
update occurrence_record, raw_occurrence_record set iso_county_code = '15720' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('sativanorte');
update occurrence_record, raw_occurrence_record set iso_county_code = '15723' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('sativasur');
update occurrence_record, raw_occurrence_record set iso_county_code = '15740' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('siachoque');
update occurrence_record, raw_occurrence_record set iso_county_code = '15753' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('soatá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15755' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('socota');
update occurrence_record, raw_occurrence_record set iso_county_code = '15757' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('socha');
update occurrence_record, raw_occurrence_record set iso_county_code = '15759' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('sogamoso');
update occurrence_record, raw_occurrence_record set iso_county_code = '15761' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('somondoco');
update occurrence_record, raw_occurrence_record set iso_county_code = '15762' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('sora');
update occurrence_record, raw_occurrence_record set iso_county_code = '15763' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('sotaquirá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15764' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('soracá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15774' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('susacón');
update occurrence_record, raw_occurrence_record set iso_county_code = '15776' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('sutamarchán');
update occurrence_record, raw_occurrence_record set iso_county_code = '15778' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('sutatenza');
update occurrence_record, raw_occurrence_record set iso_county_code = '15790' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tasco');
update occurrence_record, raw_occurrence_record set iso_county_code = '15798' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tenza');
update occurrence_record, raw_occurrence_record set iso_county_code = '15804' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tibaná');
update occurrence_record, raw_occurrence_record set iso_county_code = '15806' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tibasosa');
update occurrence_record, raw_occurrence_record set iso_county_code = '15808' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tinjacá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15810' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tipacoque');
update occurrence_record, raw_occurrence_record set iso_county_code = '15814' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('toca');
update occurrence_record, raw_occurrence_record set iso_county_code = '15816' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('togüí');
update occurrence_record, raw_occurrence_record set iso_county_code = '15820' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tópaga');
update occurrence_record, raw_occurrence_record set iso_county_code = '15822' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tota');
update occurrence_record, raw_occurrence_record set iso_county_code = '15832' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tununguá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15835' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('turmequé');
update occurrence_record, raw_occurrence_record set iso_county_code = '15837' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tuta');
update occurrence_record, raw_occurrence_record set iso_county_code = '15839' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('tutazá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15842' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('umbita');
update occurrence_record, raw_occurrence_record set iso_county_code = '15861' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('ventaquemada');
update occurrence_record, raw_occurrence_record set iso_county_code = '15879' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('viracachá');
update occurrence_record, raw_occurrence_record set iso_county_code = '15897' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-BOY' and lower (raw_occurrence_record.county)=('zetaquira');
update occurrence_record, raw_occurrence_record set iso_county_code = '17001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('manizales');
update occurrence_record, raw_occurrence_record set iso_county_code = '17013' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('aguadas');
update occurrence_record, raw_occurrence_record set iso_county_code = '17042' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('anserma');
update occurrence_record, raw_occurrence_record set iso_county_code = '17050' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('aranzazu');
update occurrence_record, raw_occurrence_record set iso_county_code = '17088' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('belalcázar');
update occurrence_record, raw_occurrence_record set iso_county_code = '17174' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('chinchiná');
update occurrence_record, raw_occurrence_record set iso_county_code = '17272' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('filadelfia');
update occurrence_record, raw_occurrence_record set iso_county_code = '17380' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('la dorada');
update occurrence_record, raw_occurrence_record set iso_county_code = '17388' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('la merced');
update occurrence_record, raw_occurrence_record set iso_county_code = '17433' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('manzanares');
update occurrence_record, raw_occurrence_record set iso_county_code = '17442' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('marmato');
update occurrence_record, raw_occurrence_record set iso_county_code = '17444' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('marquetalia');
update occurrence_record, raw_occurrence_record set iso_county_code = '17446' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('marulanda');
update occurrence_record, raw_occurrence_record set iso_county_code = '17486' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('neira');
update occurrence_record, raw_occurrence_record set iso_county_code = '17495' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('norcasia');
update occurrence_record, raw_occurrence_record set iso_county_code = '17513' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('pácora');
update occurrence_record, raw_occurrence_record set iso_county_code = '17524' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('palestina');
update occurrence_record, raw_occurrence_record set iso_county_code = '17541' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('pensilvania');
update occurrence_record, raw_occurrence_record set iso_county_code = '17614' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('riosucio');
update occurrence_record, raw_occurrence_record set iso_county_code = '17616' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('risaralda');
update occurrence_record, raw_occurrence_record set iso_county_code = '17653' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('salamina');
update occurrence_record, raw_occurrence_record set iso_county_code = '17662' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('samaná');
update occurrence_record, raw_occurrence_record set iso_county_code = '17665' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('san josé');
update occurrence_record, raw_occurrence_record set iso_county_code = '17777' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('supía');
update occurrence_record, raw_occurrence_record set iso_county_code = '17867' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('victoria');
update occurrence_record, raw_occurrence_record set iso_county_code = '17873' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('villamaría');
update occurrence_record, raw_occurrence_record set iso_county_code = '17877' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAL' and lower (raw_occurrence_record.county)=('viterbo');
update occurrence_record, raw_occurrence_record set iso_county_code = '18001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('florencia');
update occurrence_record, raw_occurrence_record set iso_county_code = '18029' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('albania');
update occurrence_record, raw_occurrence_record set iso_county_code = '18094' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('belén de los andaquies');
update occurrence_record, raw_occurrence_record set iso_county_code = '18150' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('cartagena del chairá');
update occurrence_record, raw_occurrence_record set iso_county_code = '18205' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('curillo');
update occurrence_record, raw_occurrence_record set iso_county_code = '18247' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('el doncello');
update occurrence_record, raw_occurrence_record set iso_county_code = '18256' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('el paujil');
update occurrence_record, raw_occurrence_record set iso_county_code = '18410' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('la montañita');
update occurrence_record, raw_occurrence_record set iso_county_code = '18460' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('milán');
update occurrence_record, raw_occurrence_record set iso_county_code = '18479' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('morelia');
update occurrence_record, raw_occurrence_record set iso_county_code = '18592' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('puerto rico');
update occurrence_record, raw_occurrence_record set iso_county_code = '18610' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('san josé del fragua');
update occurrence_record, raw_occurrence_record set iso_county_code = '18753' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('san vicente del caguan');
update occurrence_record, raw_occurrence_record set iso_county_code = '18756' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('solano');
update occurrence_record, raw_occurrence_record set iso_county_code = '18785' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('solita');
update occurrence_record, raw_occurrence_record set iso_county_code = '18860' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAQ' and lower (raw_occurrence_record.county)=('valparaíso');
update occurrence_record, raw_occurrence_record set iso_county_code = '19001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('popayán');
update occurrence_record, raw_occurrence_record set iso_county_code = '19022' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('almaguer');
update occurrence_record, raw_occurrence_record set iso_county_code = '19050' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('argelia');
update occurrence_record, raw_occurrence_record set iso_county_code = '19075' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('balboa');
update occurrence_record, raw_occurrence_record set iso_county_code = '19100' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('bolívar');
update occurrence_record, raw_occurrence_record set iso_county_code = '19110' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('buenos aires');
update occurrence_record, raw_occurrence_record set iso_county_code = '19130' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('cajibío');
update occurrence_record, raw_occurrence_record set iso_county_code = '19137' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('caldono');
update occurrence_record, raw_occurrence_record set iso_county_code = '19142' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('caloto');
update occurrence_record, raw_occurrence_record set iso_county_code = '19212' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('corinto');
update occurrence_record, raw_occurrence_record set iso_county_code = '19256' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('el tambo');
update occurrence_record, raw_occurrence_record set iso_county_code = '19290' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('florencia');
update occurrence_record, raw_occurrence_record set iso_county_code = '19300' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('guachené');
update occurrence_record, raw_occurrence_record set iso_county_code = '19318' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('guapi');
update occurrence_record, raw_occurrence_record set iso_county_code = '19355' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('inzá');
update occurrence_record, raw_occurrence_record set iso_county_code = '19364' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('jambaló');
update occurrence_record, raw_occurrence_record set iso_county_code = '19392' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('la sierra');
update occurrence_record, raw_occurrence_record set iso_county_code = '19397' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('la vega');
update occurrence_record, raw_occurrence_record set iso_county_code = '19418' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('lópez');
update occurrence_record, raw_occurrence_record set iso_county_code = '19450' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('mercaderes');
update occurrence_record, raw_occurrence_record set iso_county_code = '19455' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('miranda');
update occurrence_record, raw_occurrence_record set iso_county_code = '19473' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('morales');
update occurrence_record, raw_occurrence_record set iso_county_code = '19513' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('padilla');
update occurrence_record, raw_occurrence_record set iso_county_code = '19517' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('paez');
update occurrence_record, raw_occurrence_record set iso_county_code = '19532' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('patía');
update occurrence_record, raw_occurrence_record set iso_county_code = '19533' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('piamonte');
update occurrence_record, raw_occurrence_record set iso_county_code = '19548' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('piendamó');
update occurrence_record, raw_occurrence_record set iso_county_code = '19573' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('puerto tejada');
update occurrence_record, raw_occurrence_record set iso_county_code = '19585' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('puracé');
update occurrence_record, raw_occurrence_record set iso_county_code = '19622' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('rosas');
update occurrence_record, raw_occurrence_record set iso_county_code = '19693' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('san sebastián');
update occurrence_record, raw_occurrence_record set iso_county_code = '19698' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('santander de quilichao');
update occurrence_record, raw_occurrence_record set iso_county_code = '19701' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('santa rosa');
update occurrence_record, raw_occurrence_record set iso_county_code = '19743' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('silvia');
update occurrence_record, raw_occurrence_record set iso_county_code = '19760' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('sotara');
update occurrence_record, raw_occurrence_record set iso_county_code = '19780' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('suárez');
update occurrence_record, raw_occurrence_record set iso_county_code = '19785' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('sucre');
update occurrence_record, raw_occurrence_record set iso_county_code = '19807' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('timbío');
update occurrence_record, raw_occurrence_record set iso_county_code = '19809' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('timbiquí');
update occurrence_record, raw_occurrence_record set iso_county_code = '19821' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('toribio');
update occurrence_record, raw_occurrence_record set iso_county_code = '19824' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('totoró');
update occurrence_record, raw_occurrence_record set iso_county_code = '19845' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAU' and lower (raw_occurrence_record.county)=('villa rica');
update occurrence_record, raw_occurrence_record set iso_county_code = '20001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('valledupar');
update occurrence_record, raw_occurrence_record set iso_county_code = '20011' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('aguachica');
update occurrence_record, raw_occurrence_record set iso_county_code = '20013' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('agustín codazzi');
update occurrence_record, raw_occurrence_record set iso_county_code = '20032' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('astrea');
update occurrence_record, raw_occurrence_record set iso_county_code = '20045' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('becerril');
update occurrence_record, raw_occurrence_record set iso_county_code = '20060' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('bosconia');
update occurrence_record, raw_occurrence_record set iso_county_code = '20175' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('chimichagua');
update occurrence_record, raw_occurrence_record set iso_county_code = '20178' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('chiriguaná');
update occurrence_record, raw_occurrence_record set iso_county_code = '20228' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('curumaní');
update occurrence_record, raw_occurrence_record set iso_county_code = '20238' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('el copey');
update occurrence_record, raw_occurrence_record set iso_county_code = '20250' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('el paso');
update occurrence_record, raw_occurrence_record set iso_county_code = '20295' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('gamarra');
update occurrence_record, raw_occurrence_record set iso_county_code = '20310' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('gonzález');
update occurrence_record, raw_occurrence_record set iso_county_code = '20383' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('la gloria');
update occurrence_record, raw_occurrence_record set iso_county_code = '20400' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('la jagua de ibirico');
update occurrence_record, raw_occurrence_record set iso_county_code = '20443' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('manaure');
update occurrence_record, raw_occurrence_record set iso_county_code = '20517' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('pailitas');
update occurrence_record, raw_occurrence_record set iso_county_code = '20550' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('pelaya');
update occurrence_record, raw_occurrence_record set iso_county_code = '20570' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('pueblo bello');
update occurrence_record, raw_occurrence_record set iso_county_code = '20614' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('río de oro');
update occurrence_record, raw_occurrence_record set iso_county_code = '20621' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('la paz');
update occurrence_record, raw_occurrence_record set iso_county_code = '20710' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('san alberto');
update occurrence_record, raw_occurrence_record set iso_county_code = '20750' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('san diego');
update occurrence_record, raw_occurrence_record set iso_county_code = '20770' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('san martín');
update occurrence_record, raw_occurrence_record set iso_county_code = '20787' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CES' and lower (raw_occurrence_record.county)=('tamalameque');
update occurrence_record, raw_occurrence_record set iso_county_code = '23001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('montería');
update occurrence_record, raw_occurrence_record set iso_county_code = '23068' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('ayapel');
update occurrence_record, raw_occurrence_record set iso_county_code = '23079' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('buenavista');
update occurrence_record, raw_occurrence_record set iso_county_code = '23090' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('canalete');
update occurrence_record, raw_occurrence_record set iso_county_code = '23162' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('cereté');
update occurrence_record, raw_occurrence_record set iso_county_code = '23168' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('chimá');
update occurrence_record, raw_occurrence_record set iso_county_code = '23182' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('chinú');
update occurrence_record, raw_occurrence_record set iso_county_code = '23189' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('ciénaga de oro');
update occurrence_record, raw_occurrence_record set iso_county_code = '23300' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('cotorra');
update occurrence_record, raw_occurrence_record set iso_county_code = '23350' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('la apartada');
update occurrence_record, raw_occurrence_record set iso_county_code = '23417' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('lorica');
update occurrence_record, raw_occurrence_record set iso_county_code = '23419' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('los córdobas');
update occurrence_record, raw_occurrence_record set iso_county_code = '23464' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('momil');
update occurrence_record, raw_occurrence_record set iso_county_code = '23466' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('montelíbano');
update occurrence_record, raw_occurrence_record set iso_county_code = '23500' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('moñitos');
update occurrence_record, raw_occurrence_record set iso_county_code = '23555' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('planeta rica');
update occurrence_record, raw_occurrence_record set iso_county_code = '23570' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('pueblo nuevo');
update occurrence_record, raw_occurrence_record set iso_county_code = '23574' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('puerto escondido');
update occurrence_record, raw_occurrence_record set iso_county_code = '23580' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('puerto libertador');
update occurrence_record, raw_occurrence_record set iso_county_code = '23586' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('purísima');
update occurrence_record, raw_occurrence_record set iso_county_code = '23660' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('sahagún');
update occurrence_record, raw_occurrence_record set iso_county_code = '23670' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('san andrés sotavento');
update occurrence_record, raw_occurrence_record set iso_county_code = '23672' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('san antero');
update occurrence_record, raw_occurrence_record set iso_county_code = '23675' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('san bernardo del viento');
update occurrence_record, raw_occurrence_record set iso_county_code = '23678' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('san carlos');
update occurrence_record, raw_occurrence_record set iso_county_code = '23682' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('san josé de uré');
update occurrence_record, raw_occurrence_record set iso_county_code = '23686' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('san pelayo');
update occurrence_record, raw_occurrence_record set iso_county_code = '23807' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('tierralta');
update occurrence_record, raw_occurrence_record set iso_county_code = '23815' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('tuchín');
update occurrence_record, raw_occurrence_record set iso_county_code = '23855' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-COR' and lower (raw_occurrence_record.county)=('valencia');
update occurrence_record, raw_occurrence_record set iso_county_code = '25001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('agua de dios');
update occurrence_record, raw_occurrence_record set iso_county_code = '25019' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('albán');
update occurrence_record, raw_occurrence_record set iso_county_code = '25035' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('anapoima');
update occurrence_record, raw_occurrence_record set iso_county_code = '25040' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('anolaima');
update occurrence_record, raw_occurrence_record set iso_county_code = '25053' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('arbeláez');
update occurrence_record, raw_occurrence_record set iso_county_code = '25086' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('beltrán');
update occurrence_record, raw_occurrence_record set iso_county_code = '25095' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('bituima');
update occurrence_record, raw_occurrence_record set iso_county_code = '25099' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('bojacá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25120' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('cabrera');
update occurrence_record, raw_occurrence_record set iso_county_code = '25123' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('cachipay');
update occurrence_record, raw_occurrence_record set iso_county_code = '25126' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('cajicá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25148' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('caparrapí');
update occurrence_record, raw_occurrence_record set iso_county_code = '25151' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('caqueza');
update occurrence_record, raw_occurrence_record set iso_county_code = '25154' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('carmen de carupa');
update occurrence_record, raw_occurrence_record set iso_county_code = '25168' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('chaguaní');
update occurrence_record, raw_occurrence_record set iso_county_code = '25175' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('chía');
update occurrence_record, raw_occurrence_record set iso_county_code = '25178' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('chipaque');
update occurrence_record, raw_occurrence_record set iso_county_code = '25181' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('choachí');
update occurrence_record, raw_occurrence_record set iso_county_code = '25183' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('chocontá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25200' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('cogua');
update occurrence_record, raw_occurrence_record set iso_county_code = '25214' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('cota');
update occurrence_record, raw_occurrence_record set iso_county_code = '25224' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('cucunubá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25245' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('el colegio');
update occurrence_record, raw_occurrence_record set iso_county_code = '25258' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('el peñón');
update occurrence_record, raw_occurrence_record set iso_county_code = '25260' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('el rosal');
update occurrence_record, raw_occurrence_record set iso_county_code = '25269' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('facatativá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25279' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('fomeque');
update occurrence_record, raw_occurrence_record set iso_county_code = '25281' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('fosca');
update occurrence_record, raw_occurrence_record set iso_county_code = '25286' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('funza');
update occurrence_record, raw_occurrence_record set iso_county_code = '25288' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('fúquene');
update occurrence_record, raw_occurrence_record set iso_county_code = '25290' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('fusagasugá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25293' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('gachala');
update occurrence_record, raw_occurrence_record set iso_county_code = '25295' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('gachancipá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25297' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('gachetá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25299' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('gama');
update occurrence_record, raw_occurrence_record set iso_county_code = '25307' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('girardot');
update occurrence_record, raw_occurrence_record set iso_county_code = '25312' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('granada');
update occurrence_record, raw_occurrence_record set iso_county_code = '25317' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('guachetá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25320' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('guaduas');
update occurrence_record, raw_occurrence_record set iso_county_code = '25322' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('guasca');
update occurrence_record, raw_occurrence_record set iso_county_code = '25324' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('guataquí');
update occurrence_record, raw_occurrence_record set iso_county_code = '25326' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('guatavita');
update occurrence_record, raw_occurrence_record set iso_county_code = '25328' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('guayabal de siquima');
update occurrence_record, raw_occurrence_record set iso_county_code = '25335' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('guayabetal');
update occurrence_record, raw_occurrence_record set iso_county_code = '25339' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('gutiérrez');
update occurrence_record, raw_occurrence_record set iso_county_code = '25368' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('jerusalén');
update occurrence_record, raw_occurrence_record set iso_county_code = '25372' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('junín');
update occurrence_record, raw_occurrence_record set iso_county_code = '25377' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('la calera');
update occurrence_record, raw_occurrence_record set iso_county_code = '25386' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('la mesa');
update occurrence_record, raw_occurrence_record set iso_county_code = '25394' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('la palma');
update occurrence_record, raw_occurrence_record set iso_county_code = '25398' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('la peña');
update occurrence_record, raw_occurrence_record set iso_county_code = '25402' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('la vega');
update occurrence_record, raw_occurrence_record set iso_county_code = '25407' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('lenguazaque');
update occurrence_record, raw_occurrence_record set iso_county_code = '25426' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('macheta');
update occurrence_record, raw_occurrence_record set iso_county_code = '25430' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('madrid');
update occurrence_record, raw_occurrence_record set iso_county_code = '25436' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('manta');
update occurrence_record, raw_occurrence_record set iso_county_code = '25438' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('medina');
update occurrence_record, raw_occurrence_record set iso_county_code = '25473' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('mosquera');
update occurrence_record, raw_occurrence_record set iso_county_code = '25483' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('nariño');
update occurrence_record, raw_occurrence_record set iso_county_code = '25486' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('nemocón');
update occurrence_record, raw_occurrence_record set iso_county_code = '25488' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('nilo');
update occurrence_record, raw_occurrence_record set iso_county_code = '25489' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('nimaima');
update occurrence_record, raw_occurrence_record set iso_county_code = '25491' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('nocaima');
update occurrence_record, raw_occurrence_record set iso_county_code = '25506' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('venecia');
update occurrence_record, raw_occurrence_record set iso_county_code = '25513' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('pacho');
update occurrence_record, raw_occurrence_record set iso_county_code = '25518' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('paime');
update occurrence_record, raw_occurrence_record set iso_county_code = '25524' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('pandi');
update occurrence_record, raw_occurrence_record set iso_county_code = '25530' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('paratebueno');
update occurrence_record, raw_occurrence_record set iso_county_code = '25535' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('pasca');
update occurrence_record, raw_occurrence_record set iso_county_code = '25572' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('puerto salgar');
update occurrence_record, raw_occurrence_record set iso_county_code = '25580' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('pulí');
update occurrence_record, raw_occurrence_record set iso_county_code = '25592' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('quebradanegra');
update occurrence_record, raw_occurrence_record set iso_county_code = '25594' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('quetame');
update occurrence_record, raw_occurrence_record set iso_county_code = '25596' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('quipile');
update occurrence_record, raw_occurrence_record set iso_county_code = '25599' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('apulo');
update occurrence_record, raw_occurrence_record set iso_county_code = '25612' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('ricaurte');
update occurrence_record, raw_occurrence_record set iso_county_code = '25645' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('san antonio del tequendama');
update occurrence_record, raw_occurrence_record set iso_county_code = '25649' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('san bernardo');
update occurrence_record, raw_occurrence_record set iso_county_code = '25653' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('san cayetano');
update occurrence_record, raw_occurrence_record set iso_county_code = '25658' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('san francisco');
update occurrence_record, raw_occurrence_record set iso_county_code = '25662' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('san juan de río seco');
update occurrence_record, raw_occurrence_record set iso_county_code = '25718' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('sasaima');
update occurrence_record, raw_occurrence_record set iso_county_code = '25736' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('sesquilé');
update occurrence_record, raw_occurrence_record set iso_county_code = '25740' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('sibaté');
update occurrence_record, raw_occurrence_record set iso_county_code = '25743' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('silvania');
update occurrence_record, raw_occurrence_record set iso_county_code = '25745' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('simijaca');
update occurrence_record, raw_occurrence_record set iso_county_code = '25754' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('soacha');
update occurrence_record, raw_occurrence_record set iso_county_code = '25758' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('sopó');
update occurrence_record, raw_occurrence_record set iso_county_code = '25769' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('subachoque');
update occurrence_record, raw_occurrence_record set iso_county_code = '25772' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('suesca');
update occurrence_record, raw_occurrence_record set iso_county_code = '25777' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('supatá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25779' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('susa');
update occurrence_record, raw_occurrence_record set iso_county_code = '25781' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('sutatausa');
update occurrence_record, raw_occurrence_record set iso_county_code = '25785' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('tabio');
update occurrence_record, raw_occurrence_record set iso_county_code = '25793' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('tausa');
update occurrence_record, raw_occurrence_record set iso_county_code = '25797' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('tena');
update occurrence_record, raw_occurrence_record set iso_county_code = '25799' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('tenjo');
update occurrence_record, raw_occurrence_record set iso_county_code = '25805' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('tibacuy');
update occurrence_record, raw_occurrence_record set iso_county_code = '25807' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('tibirita');
update occurrence_record, raw_occurrence_record set iso_county_code = '25815' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('tocaima');
update occurrence_record, raw_occurrence_record set iso_county_code = '25817' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('tocancipá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25823' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('topaipí');
update occurrence_record, raw_occurrence_record set iso_county_code = '25839' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('ubalá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25841' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('ubaque');
update occurrence_record, raw_occurrence_record set iso_county_code = '25843' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('villa de san diego de ubate');
update occurrence_record, raw_occurrence_record set iso_county_code = '25845' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('une');
update occurrence_record, raw_occurrence_record set iso_county_code = '25851' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('útica');
update occurrence_record, raw_occurrence_record set iso_county_code = '25862' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('vergara');
update occurrence_record, raw_occurrence_record set iso_county_code = '25867' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('vianí');
update occurrence_record, raw_occurrence_record set iso_county_code = '25871' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('villagómez');
update occurrence_record, raw_occurrence_record set iso_county_code = '25873' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('villapinzón');
update occurrence_record, raw_occurrence_record set iso_county_code = '25875' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('villeta');
update occurrence_record, raw_occurrence_record set iso_county_code = '25878' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('viotá');
update occurrence_record, raw_occurrence_record set iso_county_code = '25885' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('yacopí');
update occurrence_record, raw_occurrence_record set iso_county_code = '25898' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('zipacón');
update occurrence_record, raw_occurrence_record set iso_county_code = '25899' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CUN' and lower (raw_occurrence_record.county)=('zipaquirá');
update occurrence_record, raw_occurrence_record set iso_county_code = '27001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('quibdó');
update occurrence_record, raw_occurrence_record set iso_county_code = '27006' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('acandí');
update occurrence_record, raw_occurrence_record set iso_county_code = '27025' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('alto baudó');
update occurrence_record, raw_occurrence_record set iso_county_code = '27050' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('atrato');
update occurrence_record, raw_occurrence_record set iso_county_code = '27073' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('bagadó');
update occurrence_record, raw_occurrence_record set iso_county_code = '27075' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('bahía solano');
update occurrence_record, raw_occurrence_record set iso_county_code = '27077' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('bajo baudó');
update occurrence_record, raw_occurrence_record set iso_county_code = '27099' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('bojaya');
update occurrence_record, raw_occurrence_record set iso_county_code = '27135' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('el cantón del san pablo');
update occurrence_record, raw_occurrence_record set iso_county_code = '27150' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('carmen del darien');
update occurrence_record, raw_occurrence_record set iso_county_code = '27160' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('cértegui');
update occurrence_record, raw_occurrence_record set iso_county_code = '27205' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('condoto');
update occurrence_record, raw_occurrence_record set iso_county_code = '27245' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('el carmen de atrato');
update occurrence_record, raw_occurrence_record set iso_county_code = '27250' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('el litoral del san juan');
update occurrence_record, raw_occurrence_record set iso_county_code = '27361' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('istmina');
update occurrence_record, raw_occurrence_record set iso_county_code = '27372' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('juradó');
update occurrence_record, raw_occurrence_record set iso_county_code = '27413' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('lloró');
update occurrence_record, raw_occurrence_record set iso_county_code = '27425' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('medio atrato');
update occurrence_record, raw_occurrence_record set iso_county_code = '27430' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('medio baudó');
update occurrence_record, raw_occurrence_record set iso_county_code = '27450' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('medio san juan');
update occurrence_record, raw_occurrence_record set iso_county_code = '27491' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('nóvita');
update occurrence_record, raw_occurrence_record set iso_county_code = '27495' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('nuquí');
update occurrence_record, raw_occurrence_record set iso_county_code = '27580' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('río iró');
update occurrence_record, raw_occurrence_record set iso_county_code = '27600' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('río quito');
update occurrence_record, raw_occurrence_record set iso_county_code = '27615' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('riosucio');
update occurrence_record, raw_occurrence_record set iso_county_code = '27660' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('san josé del palmar');
update occurrence_record, raw_occurrence_record set iso_county_code = '27745' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('sipí');
update occurrence_record, raw_occurrence_record set iso_county_code = '27787' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('tadó');
update occurrence_record, raw_occurrence_record set iso_county_code = '27800' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('unguía');
update occurrence_record, raw_occurrence_record set iso_county_code = '27810' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CHO' and lower (raw_occurrence_record.county)=('unión panamericana');
update occurrence_record, raw_occurrence_record set iso_county_code = '41001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('neiva');
update occurrence_record, raw_occurrence_record set iso_county_code = '41006' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('acevedo');
update occurrence_record, raw_occurrence_record set iso_county_code = '41013' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('agrado');
update occurrence_record, raw_occurrence_record set iso_county_code = '41016' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('aipe');
update occurrence_record, raw_occurrence_record set iso_county_code = '41020' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('algeciras');
update occurrence_record, raw_occurrence_record set iso_county_code = '41026' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('altamira');
update occurrence_record, raw_occurrence_record set iso_county_code = '41078' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('baraya');
update occurrence_record, raw_occurrence_record set iso_county_code = '41132' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('campoalegre');
update occurrence_record, raw_occurrence_record set iso_county_code = '41206' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('colombia');
update occurrence_record, raw_occurrence_record set iso_county_code = '41244' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('elías');
update occurrence_record, raw_occurrence_record set iso_county_code = '41298' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('garzón');
update occurrence_record, raw_occurrence_record set iso_county_code = '41306' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('gigante');
update occurrence_record, raw_occurrence_record set iso_county_code = '41319' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('guadalupe');
update occurrence_record, raw_occurrence_record set iso_county_code = '41349' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('hobo');
update occurrence_record, raw_occurrence_record set iso_county_code = '41357' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('iquira');
update occurrence_record, raw_occurrence_record set iso_county_code = '41359' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('isnos');
update occurrence_record, raw_occurrence_record set iso_county_code = '41378' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('la argentina');
update occurrence_record, raw_occurrence_record set iso_county_code = '41396' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('la plata');
update occurrence_record, raw_occurrence_record set iso_county_code = '41483' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('nátaga');
update occurrence_record, raw_occurrence_record set iso_county_code = '41503' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('oporapa');
update occurrence_record, raw_occurrence_record set iso_county_code = '41518' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('paicol');
update occurrence_record, raw_occurrence_record set iso_county_code = '41524' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('palermo');
update occurrence_record, raw_occurrence_record set iso_county_code = '41530' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('palestina');
update occurrence_record, raw_occurrence_record set iso_county_code = '41548' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('pital');
update occurrence_record, raw_occurrence_record set iso_county_code = '41551' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('pitalito');
update occurrence_record, raw_occurrence_record set iso_county_code = '41615' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('rivera');
update occurrence_record, raw_occurrence_record set iso_county_code = '41660' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('saladoblanco');
update occurrence_record, raw_occurrence_record set iso_county_code = '41668' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('san agustín');
update occurrence_record, raw_occurrence_record set iso_county_code = '41676' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('santa maría');
update occurrence_record, raw_occurrence_record set iso_county_code = '41770' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('suaza');
update occurrence_record, raw_occurrence_record set iso_county_code = '41791' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('tarqui');
update occurrence_record, raw_occurrence_record set iso_county_code = '41797' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('tesalia');
update occurrence_record, raw_occurrence_record set iso_county_code = '41799' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('tello');
update occurrence_record, raw_occurrence_record set iso_county_code = '41801' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('teruel');
update occurrence_record, raw_occurrence_record set iso_county_code = '41807' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('timaná');
update occurrence_record, raw_occurrence_record set iso_county_code = '41872' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('villavieja');
update occurrence_record, raw_occurrence_record set iso_county_code = '41885' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-HUI' and lower (raw_occurrence_record.county)=('yaguará');
update occurrence_record, raw_occurrence_record set iso_county_code = '44001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('riohacha');
update occurrence_record, raw_occurrence_record set iso_county_code = '44035' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('albania');
update occurrence_record, raw_occurrence_record set iso_county_code = '44078' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('barrancas');
update occurrence_record, raw_occurrence_record set iso_county_code = '44090' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('dibulla');
update occurrence_record, raw_occurrence_record set iso_county_code = '44098' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('distracción');
update occurrence_record, raw_occurrence_record set iso_county_code = '44110' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('el molino');
update occurrence_record, raw_occurrence_record set iso_county_code = '44279' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('fonseca');
update occurrence_record, raw_occurrence_record set iso_county_code = '44378' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('hatonuevo');
update occurrence_record, raw_occurrence_record set iso_county_code = '44420' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('la jagua del pilar');
update occurrence_record, raw_occurrence_record set iso_county_code = '44430' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('maicao');
update occurrence_record, raw_occurrence_record set iso_county_code = '44560' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('manaure');
update occurrence_record, raw_occurrence_record set iso_county_code = '44650' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('san juan del cesar');
update occurrence_record, raw_occurrence_record set iso_county_code = '44847' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('uribia');
update occurrence_record, raw_occurrence_record set iso_county_code = '44855' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('urumita');
update occurrence_record, raw_occurrence_record set iso_county_code = '44874' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-LAG' and lower (raw_occurrence_record.county)=('villanueva');
update occurrence_record, raw_occurrence_record set iso_county_code = '47001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('santa marta');
update occurrence_record, raw_occurrence_record set iso_county_code = '47030' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('algarrobo');
update occurrence_record, raw_occurrence_record set iso_county_code = '47053' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('aracataca');
update occurrence_record, raw_occurrence_record set iso_county_code = '47058' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('ariguaní');
update occurrence_record, raw_occurrence_record set iso_county_code = '47161' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('cerro san antonio');
update occurrence_record, raw_occurrence_record set iso_county_code = '47170' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('chibolo');
update occurrence_record, raw_occurrence_record set iso_county_code = '47189' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('ciénaga');
update occurrence_record, raw_occurrence_record set iso_county_code = '47205' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('concordia');
update occurrence_record, raw_occurrence_record set iso_county_code = '47245' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('el banco');
update occurrence_record, raw_occurrence_record set iso_county_code = '47258' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('el piñon');
update occurrence_record, raw_occurrence_record set iso_county_code = '47268' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('el retén');
update occurrence_record, raw_occurrence_record set iso_county_code = '47288' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('fundación');
update occurrence_record, raw_occurrence_record set iso_county_code = '47318' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('guamal');
update occurrence_record, raw_occurrence_record set iso_county_code = '47460' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('nueva granada');
update occurrence_record, raw_occurrence_record set iso_county_code = '47541' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('pedraza');
update occurrence_record, raw_occurrence_record set iso_county_code = '47545' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('pijiño del carmen');
update occurrence_record, raw_occurrence_record set iso_county_code = '47551' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('pivijay');
update occurrence_record, raw_occurrence_record set iso_county_code = '47555' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('plato');
update occurrence_record, raw_occurrence_record set iso_county_code = '47570' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('puebloviejo');
update occurrence_record, raw_occurrence_record set iso_county_code = '47605' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('remolino');
update occurrence_record, raw_occurrence_record set iso_county_code = '47660' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('sabanas de san angel');
update occurrence_record, raw_occurrence_record set iso_county_code = '47675' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('salamina');
update occurrence_record, raw_occurrence_record set iso_county_code = '47692' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('san sebastián de buenavista');
update occurrence_record, raw_occurrence_record set iso_county_code = '47703' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('san zenón');
update occurrence_record, raw_occurrence_record set iso_county_code = '47707' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('santa ana');
update occurrence_record, raw_occurrence_record set iso_county_code = '47720' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('santa bárbara de pinto');
update occurrence_record, raw_occurrence_record set iso_county_code = '47745' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('sitionuevo');
update occurrence_record, raw_occurrence_record set iso_county_code = '47798' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('tenerife');
update occurrence_record, raw_occurrence_record set iso_county_code = '47960' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('zapayán');
update occurrence_record, raw_occurrence_record set iso_county_code = '47980' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MAG' and lower (raw_occurrence_record.county)=('zona bananera');
update occurrence_record, raw_occurrence_record set iso_county_code = '50001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('villavicencio');
update occurrence_record, raw_occurrence_record set iso_county_code = '50006' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('acacías');
update occurrence_record, raw_occurrence_record set iso_county_code = '50110' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('barranca de upía');
update occurrence_record, raw_occurrence_record set iso_county_code = '50124' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('cabuyaro');
update occurrence_record, raw_occurrence_record set iso_county_code = '50150' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('castilla la nueva');
update occurrence_record, raw_occurrence_record set iso_county_code = '50223' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('cubarral');
update occurrence_record, raw_occurrence_record set iso_county_code = '50226' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('cumaral');
update occurrence_record, raw_occurrence_record set iso_county_code = '50245' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('el calvario');
update occurrence_record, raw_occurrence_record set iso_county_code = '50251' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('el castillo');
update occurrence_record, raw_occurrence_record set iso_county_code = '50270' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('el dorado');
update occurrence_record, raw_occurrence_record set iso_county_code = '50287' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('fuente de oro');
update occurrence_record, raw_occurrence_record set iso_county_code = '50313' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('granada');
update occurrence_record, raw_occurrence_record set iso_county_code = '50318' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('guamal');
update occurrence_record, raw_occurrence_record set iso_county_code = '50325' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('mapiripán');
update occurrence_record, raw_occurrence_record set iso_county_code = '50330' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('mesetas');
update occurrence_record, raw_occurrence_record set iso_county_code = '50350' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('la macarena');
update occurrence_record, raw_occurrence_record set iso_county_code = '50370' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('uribe');
update occurrence_record, raw_occurrence_record set iso_county_code = '50400' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('lejanías');
update occurrence_record, raw_occurrence_record set iso_county_code = '50450' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('puerto concordia');
update occurrence_record, raw_occurrence_record set iso_county_code = '50568' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('puerto gaitán');
update occurrence_record, raw_occurrence_record set iso_county_code = '50573' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('puerto lópez');
update occurrence_record, raw_occurrence_record set iso_county_code = '50577' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('puerto lleras');
update occurrence_record, raw_occurrence_record set iso_county_code = '50590' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('puerto rico');
update occurrence_record, raw_occurrence_record set iso_county_code = '50606' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('restrepo');
update occurrence_record, raw_occurrence_record set iso_county_code = '50680' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('san carlos de guaroa');
update occurrence_record, raw_occurrence_record set iso_county_code = '50683' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('san juan de arama');
update occurrence_record, raw_occurrence_record set iso_county_code = '50686' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('san juanito');
update occurrence_record, raw_occurrence_record set iso_county_code = '50689' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('san martín');
update occurrence_record, raw_occurrence_record set iso_county_code = '50711' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-MET' and lower (raw_occurrence_record.county)=('vistahermosa');
update occurrence_record, raw_occurrence_record set iso_county_code = '52001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('pasto');
update occurrence_record, raw_occurrence_record set iso_county_code = '52019' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('albán');
update occurrence_record, raw_occurrence_record set iso_county_code = '52022' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('aldana');
update occurrence_record, raw_occurrence_record set iso_county_code = '52036' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('ancuyá');
update occurrence_record, raw_occurrence_record set iso_county_code = '52051' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('arboleda');
update occurrence_record, raw_occurrence_record set iso_county_code = '52079' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('barbacoas');
update occurrence_record, raw_occurrence_record set iso_county_code = '52083' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('belén');
update occurrence_record, raw_occurrence_record set iso_county_code = '52110' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('buesaco');
update occurrence_record, raw_occurrence_record set iso_county_code = '52203' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('colón');
update occurrence_record, raw_occurrence_record set iso_county_code = '52207' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('consaca');
update occurrence_record, raw_occurrence_record set iso_county_code = '52210' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('contadero');
update occurrence_record, raw_occurrence_record set iso_county_code = '52215' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('córdoba');
update occurrence_record, raw_occurrence_record set iso_county_code = '52224' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('cuaspud');
update occurrence_record, raw_occurrence_record set iso_county_code = '52227' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('cumbal');
update occurrence_record, raw_occurrence_record set iso_county_code = '52233' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('cumbitara');
update occurrence_record, raw_occurrence_record set iso_county_code = '52240' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('chachagüí');
update occurrence_record, raw_occurrence_record set iso_county_code = '52250' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('el charco');
update occurrence_record, raw_occurrence_record set iso_county_code = '52254' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('el peñol');
update occurrence_record, raw_occurrence_record set iso_county_code = '52256' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('el rosario');
update occurrence_record, raw_occurrence_record set iso_county_code = '52258' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('el tablón de gómez');
update occurrence_record, raw_occurrence_record set iso_county_code = '52260' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('el tambo');
update occurrence_record, raw_occurrence_record set iso_county_code = '52287' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('funes');
update occurrence_record, raw_occurrence_record set iso_county_code = '52317' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('guachucal');
update occurrence_record, raw_occurrence_record set iso_county_code = '52320' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('guaitarilla');
update occurrence_record, raw_occurrence_record set iso_county_code = '52323' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('gualmatán');
update occurrence_record, raw_occurrence_record set iso_county_code = '52352' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('iles');
update occurrence_record, raw_occurrence_record set iso_county_code = '52354' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('imués');
update occurrence_record, raw_occurrence_record set iso_county_code = '52356' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('ipiales');
update occurrence_record, raw_occurrence_record set iso_county_code = '52378' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('la cruz');
update occurrence_record, raw_occurrence_record set iso_county_code = '52381' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('la florida');
update occurrence_record, raw_occurrence_record set iso_county_code = '52385' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('la llanada');
update occurrence_record, raw_occurrence_record set iso_county_code = '52390' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('la tola');
update occurrence_record, raw_occurrence_record set iso_county_code = '52399' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('la unión');
update occurrence_record, raw_occurrence_record set iso_county_code = '52405' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('leiva');
update occurrence_record, raw_occurrence_record set iso_county_code = '52411' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('linares');
update occurrence_record, raw_occurrence_record set iso_county_code = '52418' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('los andes');
update occurrence_record, raw_occurrence_record set iso_county_code = '52427' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('magüí');
update occurrence_record, raw_occurrence_record set iso_county_code = '52435' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('mallama');
update occurrence_record, raw_occurrence_record set iso_county_code = '52473' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('mosquera');
update occurrence_record, raw_occurrence_record set iso_county_code = '52480' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('nariño');
update occurrence_record, raw_occurrence_record set iso_county_code = '52490' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('olaya herrera');
update occurrence_record, raw_occurrence_record set iso_county_code = '52506' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('ospina');
update occurrence_record, raw_occurrence_record set iso_county_code = '52520' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('francisco pizarro');
update occurrence_record, raw_occurrence_record set iso_county_code = '52540' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('policarpa');
update occurrence_record, raw_occurrence_record set iso_county_code = '52560' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('potosí');
update occurrence_record, raw_occurrence_record set iso_county_code = '52565' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('providencia');
update occurrence_record, raw_occurrence_record set iso_county_code = '52573' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('puerres');
update occurrence_record, raw_occurrence_record set iso_county_code = '52585' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('pupiales');
update occurrence_record, raw_occurrence_record set iso_county_code = '52612' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('ricaurte');
update occurrence_record, raw_occurrence_record set iso_county_code = '52621' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('roberto payán');
update occurrence_record, raw_occurrence_record set iso_county_code = '52678' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('samaniego');
update occurrence_record, raw_occurrence_record set iso_county_code = '52683' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('sandoná');
update occurrence_record, raw_occurrence_record set iso_county_code = '52685' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('san bernardo');
update occurrence_record, raw_occurrence_record set iso_county_code = '52687' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('san lorenzo');
update occurrence_record, raw_occurrence_record set iso_county_code = '52693' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('san pablo');
update occurrence_record, raw_occurrence_record set iso_county_code = '52694' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('san pedro de cartago');
update occurrence_record, raw_occurrence_record set iso_county_code = '52696' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('santa bárbara');
update occurrence_record, raw_occurrence_record set iso_county_code = '52699' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('santacruz');
update occurrence_record, raw_occurrence_record set iso_county_code = '52720' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('sapuyes');
update occurrence_record, raw_occurrence_record set iso_county_code = '52786' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('taminango');
update occurrence_record, raw_occurrence_record set iso_county_code = '52788' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('tangua');
update occurrence_record, raw_occurrence_record set iso_county_code = '52835' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('san andres de tumaco');
update occurrence_record, raw_occurrence_record set iso_county_code = '52838' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('túquerres');
update occurrence_record, raw_occurrence_record set iso_county_code = '52885' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NAR' and lower (raw_occurrence_record.county)=('yacuanquer');
update occurrence_record, raw_occurrence_record set iso_county_code = '54001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('cúcuta');
update occurrence_record, raw_occurrence_record set iso_county_code = '54003' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('abrego');
update occurrence_record, raw_occurrence_record set iso_county_code = '54051' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('arboledas');
update occurrence_record, raw_occurrence_record set iso_county_code = '54099' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('bochalema');
update occurrence_record, raw_occurrence_record set iso_county_code = '54109' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('bucarasica');
update occurrence_record, raw_occurrence_record set iso_county_code = '54125' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('cácota');
update occurrence_record, raw_occurrence_record set iso_county_code = '54128' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('cachirá');
update occurrence_record, raw_occurrence_record set iso_county_code = '54172' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('chinácota');
update occurrence_record, raw_occurrence_record set iso_county_code = '54174' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('chitagá');
update occurrence_record, raw_occurrence_record set iso_county_code = '54206' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('convención');
update occurrence_record, raw_occurrence_record set iso_county_code = '54223' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('cucutilla');
update occurrence_record, raw_occurrence_record set iso_county_code = '54239' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('durania');
update occurrence_record, raw_occurrence_record set iso_county_code = '54245' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('el carmen');
update occurrence_record, raw_occurrence_record set iso_county_code = '54250' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('el tarra');
update occurrence_record, raw_occurrence_record set iso_county_code = '54261' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('el zulia');
update occurrence_record, raw_occurrence_record set iso_county_code = '54313' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('gramalote');
update occurrence_record, raw_occurrence_record set iso_county_code = '54344' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('hacarí');
update occurrence_record, raw_occurrence_record set iso_county_code = '54347' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('herrán');
update occurrence_record, raw_occurrence_record set iso_county_code = '54377' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('labateca');
update occurrence_record, raw_occurrence_record set iso_county_code = '54385' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('la esperanza');
update occurrence_record, raw_occurrence_record set iso_county_code = '54398' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('la playa');
update occurrence_record, raw_occurrence_record set iso_county_code = '54405' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('los patios');
update occurrence_record, raw_occurrence_record set iso_county_code = '54418' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('lourdes');
update occurrence_record, raw_occurrence_record set iso_county_code = '54480' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('mutiscua');
update occurrence_record, raw_occurrence_record set iso_county_code = '54498' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('ocaña');
update occurrence_record, raw_occurrence_record set iso_county_code = '54518' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('pamplona');
update occurrence_record, raw_occurrence_record set iso_county_code = '54520' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('pamplonita');
update occurrence_record, raw_occurrence_record set iso_county_code = '54553' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('puerto santander');
update occurrence_record, raw_occurrence_record set iso_county_code = '54599' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('ragonvalia');
update occurrence_record, raw_occurrence_record set iso_county_code = '54660' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('salazar');
update occurrence_record, raw_occurrence_record set iso_county_code = '54670' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('san calixto');
update occurrence_record, raw_occurrence_record set iso_county_code = '54673' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('san cayetano');
update occurrence_record, raw_occurrence_record set iso_county_code = '54680' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('santiago');
update occurrence_record, raw_occurrence_record set iso_county_code = '54720' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('sardinata');
update occurrence_record, raw_occurrence_record set iso_county_code = '54743' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('silos');
update occurrence_record, raw_occurrence_record set iso_county_code = '54800' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('teorama');
update occurrence_record, raw_occurrence_record set iso_county_code = '54810' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('tibú');
update occurrence_record, raw_occurrence_record set iso_county_code = '54820' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('toledo');
update occurrence_record, raw_occurrence_record set iso_county_code = '54871' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('villa caro');
update occurrence_record, raw_occurrence_record set iso_county_code = '54874' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-NSA' and lower (raw_occurrence_record.county)=('villa del rosario');
update occurrence_record, raw_occurrence_record set iso_county_code = '63001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('armenia');
update occurrence_record, raw_occurrence_record set iso_county_code = '63111' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('buenavista');
update occurrence_record, raw_occurrence_record set iso_county_code = '63130' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('calarca');
update occurrence_record, raw_occurrence_record set iso_county_code = '63190' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('circasia');
update occurrence_record, raw_occurrence_record set iso_county_code = '63212' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('córdoba');
update occurrence_record, raw_occurrence_record set iso_county_code = '63272' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('filandia');
update occurrence_record, raw_occurrence_record set iso_county_code = '63302' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('génova');
update occurrence_record, raw_occurrence_record set iso_county_code = '63401' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('la tebaida');
update occurrence_record, raw_occurrence_record set iso_county_code = '63470' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('montenegro');
update occurrence_record, raw_occurrence_record set iso_county_code = '63548' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('pijao');
update occurrence_record, raw_occurrence_record set iso_county_code = '63594' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('quimbaya');
update occurrence_record, raw_occurrence_record set iso_county_code = '63690' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-QUI' and lower (raw_occurrence_record.county)=('salento');
update occurrence_record, raw_occurrence_record set iso_county_code = '66001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('pereira');
update occurrence_record, raw_occurrence_record set iso_county_code = '66045' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('apía');
update occurrence_record, raw_occurrence_record set iso_county_code = '66075' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('balboa');
update occurrence_record, raw_occurrence_record set iso_county_code = '66088' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('belén de umbría');
update occurrence_record, raw_occurrence_record set iso_county_code = '66170' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('dosquebradas');
update occurrence_record, raw_occurrence_record set iso_county_code = '66318' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('guática');
update occurrence_record, raw_occurrence_record set iso_county_code = '66383' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('la celia');
update occurrence_record, raw_occurrence_record set iso_county_code = '66400' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('la virginia');
update occurrence_record, raw_occurrence_record set iso_county_code = '66440' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('marsella');
update occurrence_record, raw_occurrence_record set iso_county_code = '66456' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('mistrató');
update occurrence_record, raw_occurrence_record set iso_county_code = '66572' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('pueblo rico');
update occurrence_record, raw_occurrence_record set iso_county_code = '66594' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('quinchía');
update occurrence_record, raw_occurrence_record set iso_county_code = '66682' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('santa rosa de cabal');
update occurrence_record, raw_occurrence_record set iso_county_code = '66687' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-RIS' and lower (raw_occurrence_record.county)=('santuario');
update occurrence_record, raw_occurrence_record set iso_county_code = '68001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('bucaramanga');
update occurrence_record, raw_occurrence_record set iso_county_code = '68013' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('aguada');
update occurrence_record, raw_occurrence_record set iso_county_code = '68020' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('albania');
update occurrence_record, raw_occurrence_record set iso_county_code = '68051' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('aratoca');
update occurrence_record, raw_occurrence_record set iso_county_code = '68077' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('barbosa');
update occurrence_record, raw_occurrence_record set iso_county_code = '68079' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('barichara');
update occurrence_record, raw_occurrence_record set iso_county_code = '68081' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('barrancabermeja');
update occurrence_record, raw_occurrence_record set iso_county_code = '68092' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('betulia');
update occurrence_record, raw_occurrence_record set iso_county_code = '68101' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('bolívar');
update occurrence_record, raw_occurrence_record set iso_county_code = '68121' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('cabrera');
update occurrence_record, raw_occurrence_record set iso_county_code = '68132' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('california');
update occurrence_record, raw_occurrence_record set iso_county_code = '68147' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('capitanejo');
update occurrence_record, raw_occurrence_record set iso_county_code = '68152' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('carcasí');
update occurrence_record, raw_occurrence_record set iso_county_code = '68160' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('cepitá');
update occurrence_record, raw_occurrence_record set iso_county_code = '68162' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('cerrito');
update occurrence_record, raw_occurrence_record set iso_county_code = '68167' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('charalá');
update occurrence_record, raw_occurrence_record set iso_county_code = '68169' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('charta');
update occurrence_record, raw_occurrence_record set iso_county_code = '68176' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('chima');
update occurrence_record, raw_occurrence_record set iso_county_code = '68179' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('chipatá');
update occurrence_record, raw_occurrence_record set iso_county_code = '68190' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('cimitarra');
update occurrence_record, raw_occurrence_record set iso_county_code = '68207' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('concepción');
update occurrence_record, raw_occurrence_record set iso_county_code = '68209' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('confines');
update occurrence_record, raw_occurrence_record set iso_county_code = '68211' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('contratación');
update occurrence_record, raw_occurrence_record set iso_county_code = '68217' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('coromoro');
update occurrence_record, raw_occurrence_record set iso_county_code = '68229' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('curití');
update occurrence_record, raw_occurrence_record set iso_county_code = '68235' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('el carmen de chucurí');
update occurrence_record, raw_occurrence_record set iso_county_code = '68245' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('el guacamayo');
update occurrence_record, raw_occurrence_record set iso_county_code = '68250' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('el peñón');
update occurrence_record, raw_occurrence_record set iso_county_code = '68255' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('el playón');
update occurrence_record, raw_occurrence_record set iso_county_code = '68264' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('encino');
update occurrence_record, raw_occurrence_record set iso_county_code = '68266' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('enciso');
update occurrence_record, raw_occurrence_record set iso_county_code = '68271' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('florián');
update occurrence_record, raw_occurrence_record set iso_county_code = '68276' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('floridablanca');
update occurrence_record, raw_occurrence_record set iso_county_code = '68296' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('galán');
update occurrence_record, raw_occurrence_record set iso_county_code = '68298' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('gambita');
update occurrence_record, raw_occurrence_record set iso_county_code = '68307' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('girón');
update occurrence_record, raw_occurrence_record set iso_county_code = '68318' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('guaca');
update occurrence_record, raw_occurrence_record set iso_county_code = '68320' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('guadalupe');
update occurrence_record, raw_occurrence_record set iso_county_code = '68322' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('guapotá');
update occurrence_record, raw_occurrence_record set iso_county_code = '68324' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('guavatá');
update occurrence_record, raw_occurrence_record set iso_county_code = '68327' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('güepsa');
update occurrence_record, raw_occurrence_record set iso_county_code = '68344' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('hato');
update occurrence_record, raw_occurrence_record set iso_county_code = '68368' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('jesús maría');
update occurrence_record, raw_occurrence_record set iso_county_code = '68370' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('jordán');
update occurrence_record, raw_occurrence_record set iso_county_code = '68377' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('la belleza');
update occurrence_record, raw_occurrence_record set iso_county_code = '68385' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('landázuri');
update occurrence_record, raw_occurrence_record set iso_county_code = '68397' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('la paz');
update occurrence_record, raw_occurrence_record set iso_county_code = '68406' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('lebrija');
update occurrence_record, raw_occurrence_record set iso_county_code = '68418' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('los santos');
update occurrence_record, raw_occurrence_record set iso_county_code = '68425' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('macaravita');
update occurrence_record, raw_occurrence_record set iso_county_code = '68432' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('málaga');
update occurrence_record, raw_occurrence_record set iso_county_code = '68444' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('matanza');
update occurrence_record, raw_occurrence_record set iso_county_code = '68464' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('mogotes');
update occurrence_record, raw_occurrence_record set iso_county_code = '68468' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('molagavita');
update occurrence_record, raw_occurrence_record set iso_county_code = '68498' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('ocamonte');
update occurrence_record, raw_occurrence_record set iso_county_code = '68500' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('oiba');
update occurrence_record, raw_occurrence_record set iso_county_code = '68502' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('onzaga');
update occurrence_record, raw_occurrence_record set iso_county_code = '68522' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('palmar');
update occurrence_record, raw_occurrence_record set iso_county_code = '68524' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('palmas del socorro');
update occurrence_record, raw_occurrence_record set iso_county_code = '68533' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('páramo');
update occurrence_record, raw_occurrence_record set iso_county_code = '68547' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('piedecuesta');
update occurrence_record, raw_occurrence_record set iso_county_code = '68549' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('pinchote');
update occurrence_record, raw_occurrence_record set iso_county_code = '68572' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('puente nacional');
update occurrence_record, raw_occurrence_record set iso_county_code = '68573' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('puerto parra');
update occurrence_record, raw_occurrence_record set iso_county_code = '68575' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('puerto wilches');
update occurrence_record, raw_occurrence_record set iso_county_code = '68615' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('rionegro');
update occurrence_record, raw_occurrence_record set iso_county_code = '68655' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('sabana de torres');
update occurrence_record, raw_occurrence_record set iso_county_code = '68669' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('san andrés');
update occurrence_record, raw_occurrence_record set iso_county_code = '68673' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('san benito');
update occurrence_record, raw_occurrence_record set iso_county_code = '68679' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('san gil');
update occurrence_record, raw_occurrence_record set iso_county_code = '68682' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('san joaquín');
update occurrence_record, raw_occurrence_record set iso_county_code = '68684' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('san josé de miranda');
update occurrence_record, raw_occurrence_record set iso_county_code = '68686' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('san miguel');
update occurrence_record, raw_occurrence_record set iso_county_code = '68689' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('san vicente de chucuri');
update occurrence_record, raw_occurrence_record set iso_county_code = '68705' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('santa bárbara');
update occurrence_record, raw_occurrence_record set iso_county_code = '68720' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('santa helena del opon');
update occurrence_record, raw_occurrence_record set iso_county_code = '68745' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('simacota');
update occurrence_record, raw_occurrence_record set iso_county_code = '68755' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('socorro');
update occurrence_record, raw_occurrence_record set iso_county_code = '68770' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('suaita');
update occurrence_record, raw_occurrence_record set iso_county_code = '68773' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('sucre');
update occurrence_record, raw_occurrence_record set iso_county_code = '68780' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('suratá');
update occurrence_record, raw_occurrence_record set iso_county_code = '68820' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('tona');
update occurrence_record, raw_occurrence_record set iso_county_code = '68855' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('valle de san josé');
update occurrence_record, raw_occurrence_record set iso_county_code = '68861' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('vélez');
update occurrence_record, raw_occurrence_record set iso_county_code = '68867' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('vetas');
update occurrence_record, raw_occurrence_record set iso_county_code = '68872' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('villanueva');
update occurrence_record, raw_occurrence_record set iso_county_code = '68895' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAN' and lower (raw_occurrence_record.county)=('zapatoca');
update occurrence_record, raw_occurrence_record set iso_county_code = '70001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('sincelejo');
update occurrence_record, raw_occurrence_record set iso_county_code = '70110' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('buenavista');
update occurrence_record, raw_occurrence_record set iso_county_code = '70124' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('caimito');
update occurrence_record, raw_occurrence_record set iso_county_code = '70204' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('coloso');
update occurrence_record, raw_occurrence_record set iso_county_code = '70215' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('corozal');
update occurrence_record, raw_occurrence_record set iso_county_code = '70221' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('coveñas');
update occurrence_record, raw_occurrence_record set iso_county_code = '70230' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('chalán');
update occurrence_record, raw_occurrence_record set iso_county_code = '70233' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('el roble');
update occurrence_record, raw_occurrence_record set iso_county_code = '70235' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('galeras');
update occurrence_record, raw_occurrence_record set iso_county_code = '70265' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('guaranda');
update occurrence_record, raw_occurrence_record set iso_county_code = '70400' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('la unión');
update occurrence_record, raw_occurrence_record set iso_county_code = '70418' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('los palmitos');
update occurrence_record, raw_occurrence_record set iso_county_code = '70429' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('majagual');
update occurrence_record, raw_occurrence_record set iso_county_code = '70473' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('morroa');
update occurrence_record, raw_occurrence_record set iso_county_code = '70508' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('ovejas');
update occurrence_record, raw_occurrence_record set iso_county_code = '70523' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('palmito');
update occurrence_record, raw_occurrence_record set iso_county_code = '70670' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('sampúes');
update occurrence_record, raw_occurrence_record set iso_county_code = '70678' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('san benito abad');
update occurrence_record, raw_occurrence_record set iso_county_code = '70702' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('san juan de betulia');
update occurrence_record, raw_occurrence_record set iso_county_code = '70708' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('san marcos');
update occurrence_record, raw_occurrence_record set iso_county_code = '70713' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('san onofre');
update occurrence_record, raw_occurrence_record set iso_county_code = '70717' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('san pedro');
update occurrence_record, raw_occurrence_record set iso_county_code = '70742' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('san luis de sincé');
update occurrence_record, raw_occurrence_record set iso_county_code = '70771' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('sucre');
update occurrence_record, raw_occurrence_record set iso_county_code = '70820' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('santiago de tolú');
update occurrence_record, raw_occurrence_record set iso_county_code = '70823' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SUC' and lower (raw_occurrence_record.county)=('tolú viejo');
update occurrence_record, raw_occurrence_record set iso_county_code = '73001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('ibagué');
update occurrence_record, raw_occurrence_record set iso_county_code = '73024' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('alpujarra');
update occurrence_record, raw_occurrence_record set iso_county_code = '73026' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('alvarado');
update occurrence_record, raw_occurrence_record set iso_county_code = '73030' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('ambalema');
update occurrence_record, raw_occurrence_record set iso_county_code = '73043' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('anzoátegui');
update occurrence_record, raw_occurrence_record set iso_county_code = '73055' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('armero');
update occurrence_record, raw_occurrence_record set iso_county_code = '73067' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('ataco');
update occurrence_record, raw_occurrence_record set iso_county_code = '73124' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('cajamarca');
update occurrence_record, raw_occurrence_record set iso_county_code = '73148' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('carmen de apicalá');
update occurrence_record, raw_occurrence_record set iso_county_code = '73152' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('casabianca');
update occurrence_record, raw_occurrence_record set iso_county_code = '73168' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('chaparral');
update occurrence_record, raw_occurrence_record set iso_county_code = '73200' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('coello');
update occurrence_record, raw_occurrence_record set iso_county_code = '73217' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('coyaima');
update occurrence_record, raw_occurrence_record set iso_county_code = '73226' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('cunday');
update occurrence_record, raw_occurrence_record set iso_county_code = '73236' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('dolores');
update occurrence_record, raw_occurrence_record set iso_county_code = '73268' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('espinal');
update occurrence_record, raw_occurrence_record set iso_county_code = '73270' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('falan');
update occurrence_record, raw_occurrence_record set iso_county_code = '73275' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('flandes');
update occurrence_record, raw_occurrence_record set iso_county_code = '73283' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('fresno');
update occurrence_record, raw_occurrence_record set iso_county_code = '73319' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('guamo');
update occurrence_record, raw_occurrence_record set iso_county_code = '73347' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('herveo');
update occurrence_record, raw_occurrence_record set iso_county_code = '73349' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('honda');
update occurrence_record, raw_occurrence_record set iso_county_code = '73352' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('icononzo');
update occurrence_record, raw_occurrence_record set iso_county_code = '73408' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('lérida');
update occurrence_record, raw_occurrence_record set iso_county_code = '73411' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('líbano');
update occurrence_record, raw_occurrence_record set iso_county_code = '73443' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('san sebastián de mariquita');
update occurrence_record, raw_occurrence_record set iso_county_code = '73449' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('melgar');
update occurrence_record, raw_occurrence_record set iso_county_code = '73461' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('murillo');
update occurrence_record, raw_occurrence_record set iso_county_code = '73483' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('natagaima');
update occurrence_record, raw_occurrence_record set iso_county_code = '73504' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('ortega');
update occurrence_record, raw_occurrence_record set iso_county_code = '73520' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('palocabildo');
update occurrence_record, raw_occurrence_record set iso_county_code = '73547' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('piedras');
update occurrence_record, raw_occurrence_record set iso_county_code = '73555' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('planadas');
update occurrence_record, raw_occurrence_record set iso_county_code = '73563' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('prado');
update occurrence_record, raw_occurrence_record set iso_county_code = '73585' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('purificación');
update occurrence_record, raw_occurrence_record set iso_county_code = '73616' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('rioblanco');
update occurrence_record, raw_occurrence_record set iso_county_code = '73622' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('roncesvalles');
update occurrence_record, raw_occurrence_record set iso_county_code = '73624' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('rovira');
update occurrence_record, raw_occurrence_record set iso_county_code = '73671' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('saldaña');
update occurrence_record, raw_occurrence_record set iso_county_code = '73675' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('san antonio');
update occurrence_record, raw_occurrence_record set iso_county_code = '73678' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('san luis');
update occurrence_record, raw_occurrence_record set iso_county_code = '73686' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('santa isabel');
update occurrence_record, raw_occurrence_record set iso_county_code = '73770' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('suárez');
update occurrence_record, raw_occurrence_record set iso_county_code = '73854' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('valle de san juan');
update occurrence_record, raw_occurrence_record set iso_county_code = '73861' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('venadillo');
update occurrence_record, raw_occurrence_record set iso_county_code = '73870' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('villahermosa');
update occurrence_record, raw_occurrence_record set iso_county_code = '73873' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-TOL' and lower (raw_occurrence_record.county)=('villarrica');
update occurrence_record, raw_occurrence_record set iso_county_code = '76001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('cali');
update occurrence_record, raw_occurrence_record set iso_county_code = '76020' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('alcalá');
update occurrence_record, raw_occurrence_record set iso_county_code = '76036' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('andalucía');
update occurrence_record, raw_occurrence_record set iso_county_code = '76041' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('ansermanuevo');
update occurrence_record, raw_occurrence_record set iso_county_code = '76054' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('argelia');
update occurrence_record, raw_occurrence_record set iso_county_code = '76100' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('bolívar');
update occurrence_record, raw_occurrence_record set iso_county_code = '76109' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('buenaventura');
update occurrence_record, raw_occurrence_record set iso_county_code = '76111' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('guadalajara de buga');
update occurrence_record, raw_occurrence_record set iso_county_code = '76113' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('bugalagrande');
update occurrence_record, raw_occurrence_record set iso_county_code = '76122' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('caicedonia');
update occurrence_record, raw_occurrence_record set iso_county_code = '76126' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('calima');
update occurrence_record, raw_occurrence_record set iso_county_code = '76130' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('candelaria');
update occurrence_record, raw_occurrence_record set iso_county_code = '76147' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('cartago');
update occurrence_record, raw_occurrence_record set iso_county_code = '76233' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('dagua');
update occurrence_record, raw_occurrence_record set iso_county_code = '76243' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('el águila');
update occurrence_record, raw_occurrence_record set iso_county_code = '76246' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('el cairo');
update occurrence_record, raw_occurrence_record set iso_county_code = '76248' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('el cerrito');
update occurrence_record, raw_occurrence_record set iso_county_code = '76250' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('el dovio');
update occurrence_record, raw_occurrence_record set iso_county_code = '76275' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('florida');
update occurrence_record, raw_occurrence_record set iso_county_code = '76306' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('ginebra');
update occurrence_record, raw_occurrence_record set iso_county_code = '76318' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('guacarí');
update occurrence_record, raw_occurrence_record set iso_county_code = '76364' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('jamundí');
update occurrence_record, raw_occurrence_record set iso_county_code = '76377' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('la cumbre');
update occurrence_record, raw_occurrence_record set iso_county_code = '76400' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('la unión');
update occurrence_record, raw_occurrence_record set iso_county_code = '76403' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('la victoria');
update occurrence_record, raw_occurrence_record set iso_county_code = '76497' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('obando');
update occurrence_record, raw_occurrence_record set iso_county_code = '76520' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('palmira');
update occurrence_record, raw_occurrence_record set iso_county_code = '76563' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('pradera');
update occurrence_record, raw_occurrence_record set iso_county_code = '76606' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('restrepo');
update occurrence_record, raw_occurrence_record set iso_county_code = '76616' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('riofrío');
update occurrence_record, raw_occurrence_record set iso_county_code = '76622' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('roldanillo');
update occurrence_record, raw_occurrence_record set iso_county_code = '76670' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('san pedro');
update occurrence_record, raw_occurrence_record set iso_county_code = '76736' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('sevilla');
update occurrence_record, raw_occurrence_record set iso_county_code = '76823' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('toro');
update occurrence_record, raw_occurrence_record set iso_county_code = '76828' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('trujillo');
update occurrence_record, raw_occurrence_record set iso_county_code = '76834' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('tuluá');
update occurrence_record, raw_occurrence_record set iso_county_code = '76845' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('ulloa');
update occurrence_record, raw_occurrence_record set iso_county_code = '76863' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('versalles');
update occurrence_record, raw_occurrence_record set iso_county_code = '76869' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('vijes');
update occurrence_record, raw_occurrence_record set iso_county_code = '76890' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('yotoco');
update occurrence_record, raw_occurrence_record set iso_county_code = '76892' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('yumbo');
update occurrence_record, raw_occurrence_record set iso_county_code = '76895' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAC' and lower (raw_occurrence_record.county)=('zarzal');
update occurrence_record, raw_occurrence_record set iso_county_code = '81001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ARA' and lower (raw_occurrence_record.county)=('arauca');
update occurrence_record, raw_occurrence_record set iso_county_code = '81065' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ARA' and lower (raw_occurrence_record.county)=('arauquita');
update occurrence_record, raw_occurrence_record set iso_county_code = '81220' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ARA' and lower (raw_occurrence_record.county)=('cravo norte');
update occurrence_record, raw_occurrence_record set iso_county_code = '81300' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ARA' and lower (raw_occurrence_record.county)=('fortul');
update occurrence_record, raw_occurrence_record set iso_county_code = '81591' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ARA' and lower (raw_occurrence_record.county)=('puerto rondón');
update occurrence_record, raw_occurrence_record set iso_county_code = '81736' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ARA' and lower (raw_occurrence_record.county)=('saravena');
update occurrence_record, raw_occurrence_record set iso_county_code = '81794' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-ARA' and lower (raw_occurrence_record.county)=('tame');
update occurrence_record, raw_occurrence_record set iso_county_code = '85001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('yopal');
update occurrence_record, raw_occurrence_record set iso_county_code = '85010' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('aguazul');
update occurrence_record, raw_occurrence_record set iso_county_code = '85015' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('chameza');
update occurrence_record, raw_occurrence_record set iso_county_code = '85125' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('hato corozal');
update occurrence_record, raw_occurrence_record set iso_county_code = '85136' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('la salina');
update occurrence_record, raw_occurrence_record set iso_county_code = '85139' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('maní');
update occurrence_record, raw_occurrence_record set iso_county_code = '85162' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('monterrey');
update occurrence_record, raw_occurrence_record set iso_county_code = '85225' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('nunchía');
update occurrence_record, raw_occurrence_record set iso_county_code = '85230' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('orocué');
update occurrence_record, raw_occurrence_record set iso_county_code = '85250' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('paz de ariporo');
update occurrence_record, raw_occurrence_record set iso_county_code = '85263' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('pore');
update occurrence_record, raw_occurrence_record set iso_county_code = '85279' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('recetor');
update occurrence_record, raw_occurrence_record set iso_county_code = '85300' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('sabanalarga');
update occurrence_record, raw_occurrence_record set iso_county_code = '85315' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('sácama');
update occurrence_record, raw_occurrence_record set iso_county_code = '85325' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('san luis de palenque');
update occurrence_record, raw_occurrence_record set iso_county_code = '85400' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('támara');
update occurrence_record, raw_occurrence_record set iso_county_code = '85410' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('tauramena');
update occurrence_record, raw_occurrence_record set iso_county_code = '85430' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('trinidad');
update occurrence_record, raw_occurrence_record set iso_county_code = '85440' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-CAS' and lower (raw_occurrence_record.county)=('villanueva');
update occurrence_record, raw_occurrence_record set iso_county_code = '86001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('mocoa');
update occurrence_record, raw_occurrence_record set iso_county_code = '86219' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('colón');
update occurrence_record, raw_occurrence_record set iso_county_code = '86320' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('orito');
update occurrence_record, raw_occurrence_record set iso_county_code = '86568' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('puerto asís');
update occurrence_record, raw_occurrence_record set iso_county_code = '86569' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('puerto caicedo');
update occurrence_record, raw_occurrence_record set iso_county_code = '86571' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('puerto guzmán');
update occurrence_record, raw_occurrence_record set iso_county_code = '86573' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('puerto leguízamo');
update occurrence_record, raw_occurrence_record set iso_county_code = '86749' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('sibundoy');
update occurrence_record, raw_occurrence_record set iso_county_code = '86755' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('san francisco');
update occurrence_record, raw_occurrence_record set iso_county_code = '86757' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('san miguel');
update occurrence_record, raw_occurrence_record set iso_county_code = '86760' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('santiago');
update occurrence_record, raw_occurrence_record set iso_county_code = '86865' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('valle del guamuez');
update occurrence_record, raw_occurrence_record set iso_county_code = '86885' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-PUT' and lower (raw_occurrence_record.county)=('villagarzón');
update occurrence_record, raw_occurrence_record set iso_county_code = '88001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAP' and lower (raw_occurrence_record.county)=('san andrés');
update occurrence_record, raw_occurrence_record set iso_county_code = '88564' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-SAP' and lower (raw_occurrence_record.county)=('providencia');
update occurrence_record, raw_occurrence_record set iso_county_code = '91001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-AMA' and lower (raw_occurrence_record.county)=('leticia');
update occurrence_record, raw_occurrence_record set iso_county_code = '91263' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-AMA' and lower (raw_occurrence_record.county)=('el encanto');
update occurrence_record, raw_occurrence_record set iso_county_code = '91405' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-AMA' and lower (raw_occurrence_record.county)=('la chorrera');
update occurrence_record, raw_occurrence_record set iso_county_code = '91407' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-AMA' and lower (raw_occurrence_record.county)=('la pedrera');
update occurrence_record, raw_occurrence_record set iso_county_code = '91430' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-AMA' and lower (raw_occurrence_record.county)=('la victoria');
update occurrence_record, raw_occurrence_record set iso_county_code = '91460' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-AMA' and lower (raw_occurrence_record.county)=('miriti - paraná');
update occurrence_record, raw_occurrence_record set iso_county_code = '91530' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-AMA' and lower (raw_occurrence_record.county)=('puerto alegría');
update occurrence_record, raw_occurrence_record set iso_county_code = '91536' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-AMA' and lower (raw_occurrence_record.county)=('puerto arica');
update occurrence_record, raw_occurrence_record set iso_county_code = '91540' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-AMA' and lower (raw_occurrence_record.county)=('puerto nariño');
update occurrence_record, raw_occurrence_record set iso_county_code = '91669' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-AMA' and lower (raw_occurrence_record.county)=('puerto santander');
update occurrence_record, raw_occurrence_record set iso_county_code = '91798' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-AMA' and lower (raw_occurrence_record.county)=('tarapacá');
update occurrence_record, raw_occurrence_record set iso_county_code = '94001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUA' and lower (raw_occurrence_record.county)=('inírida');
update occurrence_record, raw_occurrence_record set iso_county_code = '94343' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUA' and lower (raw_occurrence_record.county)=('barranco minas');
update occurrence_record, raw_occurrence_record set iso_county_code = '94663' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUA' and lower (raw_occurrence_record.county)=('mapiripana');
update occurrence_record, raw_occurrence_record set iso_county_code = '94883' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUA' and lower (raw_occurrence_record.county)=('san felipe');
update occurrence_record, raw_occurrence_record set iso_county_code = '94884' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUA' and lower (raw_occurrence_record.county)=('puerto colombia');
update occurrence_record, raw_occurrence_record set iso_county_code = '94885' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUA' and lower (raw_occurrence_record.county)=('la guadalupe');
update occurrence_record, raw_occurrence_record set iso_county_code = '94886' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUA' and lower (raw_occurrence_record.county)=('cacahual');
update occurrence_record, raw_occurrence_record set iso_county_code = '94887' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUA' and lower (raw_occurrence_record.county)=('pana pana');
update occurrence_record, raw_occurrence_record set iso_county_code = '94888' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUA' and lower (raw_occurrence_record.county)=('morichal');
update occurrence_record, raw_occurrence_record set iso_county_code = '95001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUV' and lower (raw_occurrence_record.county)=('san josé del guaviare');
update occurrence_record, raw_occurrence_record set iso_county_code = '95015' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUV' and lower (raw_occurrence_record.county)=('calamar');
update occurrence_record, raw_occurrence_record set iso_county_code = '95025' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUV' and lower (raw_occurrence_record.county)=('el retorno');
update occurrence_record, raw_occurrence_record set iso_county_code = '95200' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-GUV' and lower (raw_occurrence_record.county)=('miraflores');
update occurrence_record, raw_occurrence_record set iso_county_code = '97001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAU' and lower (raw_occurrence_record.county)=('mitú');
update occurrence_record, raw_occurrence_record set iso_county_code = '97161' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAU' and lower (raw_occurrence_record.county)=('caruru');
update occurrence_record, raw_occurrence_record set iso_county_code = '97511' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAU' and lower (raw_occurrence_record.county)=('pacoa');
update occurrence_record, raw_occurrence_record set iso_county_code = '97666' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAU' and lower (raw_occurrence_record.county)=('taraira');
update occurrence_record, raw_occurrence_record set iso_county_code = '97777' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAU' and lower (raw_occurrence_record.county)=('papunaua');
update occurrence_record, raw_occurrence_record set iso_county_code = '97889' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VAU' and lower (raw_occurrence_record.county)=('yavaraté');
update occurrence_record, raw_occurrence_record set iso_county_code = '99001' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VID' and lower (raw_occurrence_record.county)=('puerto carreño');
update occurrence_record, raw_occurrence_record set iso_county_code = '99524' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VID' and lower (raw_occurrence_record.county)=('la primavera');
update occurrence_record, raw_occurrence_record set iso_county_code = '99624' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VID' and lower (raw_occurrence_record.county)=('santa rosalía');
update occurrence_record, raw_occurrence_record set iso_county_code = '99773' where raw_occurrence_record.id = occurrence_record.id and occurrence_record.iso_department_code = 'CO-VID' and lower (raw_occurrence_record.county)=('cumaribo');

-- End of SiB Colombia addition
-- --------------------------------------------

-- ignoring event_id = 1006 since that validation is not quite accurate
delete from gbif_log_message where event_id=1006 and occurrence_id in (select id from occurrence_record where geospatial_issue=0 and basis_of_record!=0);

-- delete warning 
update occurrence_record set other_issue = 0 where basis_of_record != '0' and other_issue = 2;

-- removing logs of this marked issue
delete from gbif_log_message where event_id=1008 and occurrence_id  in (select id from occurrence_record where geospatial_issue=32);

-- removing geospatial_issue
update occurrence_record set geospatial_issue=0 where geospatial_issue=32;

update occurrence_record set iso_country_code_calculated = 'CO' where iso_department_code_calculated is not null;

update occurrence_record set iso_country_code_calculated = 'CO' where marine_zone is not null;

update occurrence_record set iso_department_code_calculated = 'CO-DC' where iso_department_code_calculated = 'CO-CUN' and iso_department_code = 'CO-DC';

update occurrence_record set geospatial_issue= 32 where iso_country_code != iso_country_code_calculated or iso_country_code_calculated is null;

update occurrence_record set geospatial_issue= 32 where iso_department_code != iso_department_code_calculated and iso_department_code_calculated is not null;

update occurrence_record set geospatial_issue= 32 
where iso_department_code in ('CO-GUV','CO-ATL','CO-MAG','CO-BOL','CO-SUC','CO-COR','CO-ANT','CO-CHO','CO-VAC','CO-CAU','CO-NAR') 
and iso_country_code_calculated = 'CO'  
and iso_department_code_calculated is null 
and marine_zone is null;

update occurrence_record set geospatial_issue= 32 
where iso_department_code not in ('CO-GUV','CO-ATL','CO-MAG','CO-BOL','CO-SUC','CO-COR','CO-ANT','CO-CHO','CO-VAC','CO-CAU','CO-NAR','CO-SAP') 
and iso_country_code_calculated = 'CO'  
and iso_department_code_calculated is null; 

call gbif_log_message();

-- clear the centi cells
-- Query OK, 0 rows affected (54.06 sec)
select concat('Clearing centi cells: ', now()) as debug;    
-- truncate table centi_cell_density;
delete from centi_cell_density;

-- populate the centi_cell_density for country
-- Query OK, 405400 rows affected (17 min 2.61 sec)
-- Records: 405400  Duplicates: 0  Warnings: 0
select concat('Building centi cells for country: ', now()) as debug;
insert into centi_cell_density 
select 2, c.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join country c on oc.iso_country_code=c.iso_country_code 
where oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

-- populate the cell_density for home country
-- This is the data for data_providers tied to a country
-- Query OK, 486945 rows affected (8 min 44.25 sec)
-- Records: 486945  Duplicates: 0  Warnings: 0
select concat('Building centi cells for home country: ', now()) as debug;
insert into centi_cell_density 
select 6, c.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join data_provider dp on oc.data_provider_id=dp.id
inner join country c on dp.iso_country_code=c.iso_country_code
where oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

-- populate home country for international networks
-- Query OK, 262835 rows affected (56.98 sec)
-- Records: 262835  Duplicates: 0  Warnings: 0
select concat('Building centi cells for international networks: ', now()) as debug;
insert into centi_cell_density 
select 6, 0, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join data_provider dp on oc.data_provider_id=dp.id
where dp.iso_country_code is null and oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc. deleted is null
group by 3,4;

-- populate the centi_cell_density for provider
-- Query OK, 1010956 rows affected (3 min 39.17 sec)
-- Records: 1010956  Duplicates: 0  Warnings: 0
select concat('Building centi cells for provider: ', now()) as debug;
insert into centi_cell_density
select 3,data_provider_id,cell_id,centi_cell_id,count(id)
from occurrence_record
where centi_cell_id is not null and geospatial_issue=0 and deleted is null
group by 1,2,3,4;

-- populate the centi_cell_density for resource
-- Query OK, 1350386 rows affected (3 min 40.00 sec)
-- Records: 1350386  Duplicates: 0  Warnings: 0
select concat('Building centi cells for resource: ', now()) as debug;
insert into centi_cell_density
select 4,data_resource_id,cell_id,centi_cell_id,count(id)
from occurrence_record
where centi_cell_id is not null and geospatial_issue=0 and deleted is null
group by 1,2,3,4;

-- populate the centi_cell_density for resource_network
-- Query OK, 820967 rows affected (10 min 31.83 sec)
-- Records: 820967  Duplicates: 0  Warnings: 0
select concat('Building centi cells for network: ', now()) as debug;
insert into centi_cell_density
select 5,nm.resource_network_id,cell_id,centi_cell_id,count(oc.id)
from occurrence_record oc
inner join network_membership nm on oc.data_resource_id=nm.data_resource_id
where centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by nm.resource_network_id, oc.cell_id, oc.centi_cell_id;

-- populate the centi_cell_density for department
-- 8 is department lookup_cell_density_type
select concat('Building centi cells for department: ', now()) as debug;
insert into centi_cell_density 
select 8, d.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join department d on oc.iso_department_code=d.iso_department_code 
where oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

-- populate the centi_cell_density for county
-- 9 is county lookup_cell_density_type
select concat('Building centi cells for county: ', now()) as debug;
insert into centi_cell_density 
select 9, c.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join county c on oc.iso_county_code=c.iso_county_code 
where oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

-- populate the centi_cell_density for paramo
-- 10 is paramo lookup_cell_density_type
select concat('Building centi cells for paramo: ', now()) as debug;
insert into centi_cell_density 
select 10, p.id, cell_id, centi_cell_id, count(oc.id)  
from occurrence_record oc 
inner join paramo p on oc.paramo=p.complex_id 
where oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

-- populate the centi_cell_density for any paramo
-- 10 is paramo lookup_cell_density_type
select concat('Building centi cells for any paramo: ', now()) as debug;
insert into centi_cell_density 
select 10, 37 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.paramo is not null
and oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

-- populate the centi_cell_density for marine zone
-- 11 is marine zone lookup_cell_density_type
select concat('Building centi cells for marine zone: ', now()) as debug;
insert into centi_cell_density 
select 11, m.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join marine_zone m on oc.marine_zone=m.mask 
where oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

-- populate the centi_cell_density for any marine zone
-- 11 is marine zone lookup_cell_density_type
select concat('Building centi cells for any marine zone: ', now()) as debug;
insert into centi_cell_density 
select 11, 8 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.marine_zone is not null
and oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

-- populate the centi_cell_density for protected area
-- 12 is protected area lookup_cell_density_type
select concat('Building centi cells for protected area: ', now()) as debug;
insert into centi_cell_density 
select 12, pa.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join protected_area pa on oc.protected_area=pa.pa_id 
where oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

-- populate the centi_cell_density for ecosystem
-- 13 is ecosystem lookup_cell_density_type
select concat('Building centi cells for dry forest ecosystem: ', now()) as debug;
insert into centi_cell_density 
select 13, 1 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.dry_forest = 1
and oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

select concat('Building centi cells for paramo ecosystem: ', now()) as debug;
insert into centi_cell_density 
select 13, 2 , cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
where oc.paramo is not null
and oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

-- populate the centi_cell_density for zonificacion
-- 14 is zonificacion lookup_cell_density_type
select concat('Building centi cells for zonificacion: ', now()) as debug;
insert into centi_cell_density 
select 14, z.id, cell_id, centi_cell_id, count(oc.id) 
from occurrence_record oc 
inner join zonificacion z on oc.zonificacion=z.szh 
where oc.centi_cell_id is not null and oc.geospatial_issue=0 and oc.deleted is null
group by 1,2,3,4;

-- populate cell densities for all ORs on the denormalised nub id
-- Query OK, 873791 rows affected (3 min 58.67 sec)
-- Records: 873791  Duplicates: 0  Warnings: 0
select concat('Building centi cells for kingdom: ', now()) as debug;
insert ignore into centi_cell_density 
select 1, ore.kingdom_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore
where ore.kingdom_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0 and ore.deleted is null
group by 1,2,3,4;

-- populate cell densities for all ORs on the denormalised nub id    
-- Query OK, 1411770 rows affected (4 min 5.77 sec)
-- Records: 1411770  Duplicates: 0  Warnings: 0
select concat('Building centi cells for phylum: ', now()) as debug;
insert ignore into centi_cell_density 
select 1, ore.phylum_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
where ore.phylum_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0 and ore.deleted is null
group by 1,2,3,4;
    
-- populate cell densities for all ORs on the denormalised nub id
-- Query OK, 1868755 rows affected (4 min 9.33 sec)
-- Records: 1868755  Duplicates: 0  Warnings: 0
select concat('Building centi cells for class: ', now()) as debug;
insert ignore into centi_cell_density
select 1, ore.class_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
where ore.class_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0 and ore.deleted is null
group by 1,2,3,4;

-- populate cell densities for all ORs on the denormalised nub id
-- Query OK, 4427337 rows affected (4 min 42.53 sec)
-- Records: 4427337  Duplicates: 0  Warnings: 0
select concat('Building centi cells for order: ', now()) as debug;
insert ignore into centi_cell_density 
select 1, ore.order_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
where ore.order_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0 and ore.deleted is null
group by 1,2,3,4;
    
-- populate cell densities for all ORs on the denormalised nub id
-- Query OK, 7395361 rows affected (5 min 22.05 sec)
-- Records: 7395361  Duplicates: 0  Warnings: 0
select concat('Building centi cells for family: ', now()) as debug;
insert ignore into centi_cell_density 
select 1, ore.family_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
where ore.family_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0 and ore.deleted is null
group by 1,2,3,4;
    
-- populate cell densities for all ORs on the denormalised nub id
-- Query OK, 15041868 rows affected (22 min 31.16 sec)
-- Records: 15041868  Duplicates: 0  Warnings: 0
select concat('Building centi cells for genus: ', now()) as debug;
insert ignore into centi_cell_density 
select 1, ore.genus_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
where ore.genus_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0 and ore.deleted is null
group by 1,2,3,4;

-- populate cell densities for all ORs on the denormalised nub id
-- Query OK, 20795641 rows affected (46 min 45.89 sec)
-- Records: 20795641  Duplicates: 0  Warnings: 0
select concat('Building centi cells for species: ', now()) as debug;
insert ignore into centi_cell_density 
select 1, ore.species_concept_id, ore.cell_id, ore.centi_cell_id, count(ore.id)
from occurrence_record ore 
where ore.species_concept_id is not null
and ore.centi_cell_id is not null and ore.geospatial_issue=0 and ore.deleted is null
group by 1,2,3,4;

-- populate the centi_cell_density for taxonomy RUN THIS AFTER THE DENORMALISED!!!
-- Query OK, 2433039 rows affected, 5441 warnings (58 min 51.94 sec)
-- Records: 23600228  Duplicates: 21167189  Warnings: 5441
-- (warnings are expected and can be ignored: "insert ignore")
select concat('Building centi cells for nub concept: ', now()) as debug;
insert ignore into centi_cell_density
select 1, nub_concept_id,cell_id,centi_cell_id,count(id)
from occurrence_record ore
where ore.centi_cell_id is not null and ore.geospatial_issue=0 and ore.deleted is null
group by 1,2,3,4;

-- populate for all things
-- Query OK, 579411 rows affected (3 min 13.33 sec)
-- Records: 579411  Duplicates: 0  Warnings: 0
select concat('Building centi cells for all things: ', now()) as debug;
insert ignore into centi_cell_density
select 0, 0,cell_id,centi_cell_id,count(id)
from occurrence_record ore
where ore.centi_cell_id is not null and ore.geospatial_issue=0 and ore.deleted is null
group by 1,2,3,4;

-- clear the cell densities
-- Query OK, 0 rows affected (0.28 sec)
select concat('Clearing cells: ', now()) as debug;
-- truncate table cell_density;
delete from cell_density;


-- build the cell_densities
-- Query OK, 13623180 rows affected (18 min 0.63 sec)
-- Records: 13623180  Duplicates: 0  Warnings: 0
select concat('Building cell densities: ', now()) as debug;
insert ignore into cell_density 
select type,entity_id,cell_id,sum(count)
from centi_cell_density
group by 1,2,3;

-- 18.9.10: started up to here so far (8:13)

-- updates and sets the countries count
-- Query OK, 240 rows affected (5 min 17.92 sec)
-- Rows matched: 243  Changed: 240  Warnings: 0
select concat('Starting country occurrence count: ', now()) as debug;
update country c set occurrence_count =
(select count(id) from occurrence_record o where o.iso_country_code=c.iso_country_code and o.deleted is null);
    
-- set occurrence record coordinate count
-- Query OK, 235 rows affected (0.05 sec)
-- Rows matched: 243  Changed: 235  Warnings: 0
select concat('Starting country occurrence coordinate count: ', now()) as debug;
update country c set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=c.id and cd.type=2);
    
-- set species count per country
-- this used to be species and lower concepts as well - changed 12.8.08
-- Query OK, 238 rows affected (7 min 35.92 sec)
-- Rows matched: 243  Changed: 238  Warnings: 0
select concat('Starting country species count: ', now()) as debug;
update country c set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.iso_country_code = c.iso_country_code and o.deleted is null);      
/* was before update 12.8.08: (select count(distinct o.nub_concept_id) from occurrence_record o where o.iso_country_code = c.iso_country_code); */

-- set occurrence record count
-- Query OK, 662 rows affected (4 min 14.25 sec)
-- Rows matched: 2277  Changed: 662  Warnings: 0
select concat('Starting resource occurrence count: ', now()) as debug;
update data_resource dr set occurrence_count =   
(select count(o.id) from occurrence_record o where o.data_resource_id=dr.id and o.deleted is null);

-- set occurrence record coordinate count
-- Query OK, 642 rows affected (3 min 52.58 sec)
-- Rows matched: 2277  Changed: 642  Warnings: 0
select concat('Starting resource occurrence coordinate count: ', now()) as debug;
update data_resource dr set occurrence_coordinate_count =   
(select count(o.id) from occurrence_record o where o.data_resource_id=dr.id and o.cell_id is not null and o.deleted is null);

-- set occurrence record clean geospatial count
-- Query OK, 656 rows affected (0.45 sec)
-- Rows matched: 2277  Changed: 656  Warnings: 0
select concat('Starting resource occurrence coordinate count: ', now()) as debug;
update data_resource dr set occurrence_clean_geospatial_count =   
(select sum(cd.count) from cell_density cd where cd.type=4 and cd.entity_id=dr.id);

-- set species count
-- Query OK, 371 rows affected (36.66 sec)
-- Rows matched: 2277  Changed: 371  Warnings: 0
select concat('Starting resource species count: ', now()) as debug;
update data_resource dr set species_count =       
(select count(tc.id) from taxon_concept tc where tc.data_resource_id = dr.id and tc.rank>=7000 and tc.rank<8000);

-- set concept count   
-- Query OK, 401 rows affected (18.61 sec)
-- Rows matched: 2277  Changed: 401  Warnings: 0
select concat('Starting resource taxon concept count: ', now()) as debug;
update data_resource dr set concept_count =       
(select count(tc.id) from taxon_concept tc where tc.data_resource_id = dr.id);
    
-- set occurrence record count
-- Query OK, 61 rows affected (0.05 sec)
-- Rows matched: 250  Changed: 61  Warnings: 0
select concat('Starting provider occurrence count: ', now()) as debug;
update data_provider dp set occurrence_count =   
(select sum(dr.occurrence_count) from data_resource dr where dr.data_provider_id=dp.id);

-- set occurrence record coordinate count
-- Query OK, 56 rows affected (0.02 sec)
-- Rows matched: 250  Changed: 56  Warnings: 0
select concat('Starting provider occurrence coordinate count: ', now()) as debug;
update data_provider dp set occurrence_coordinate_count =   
(select sum(dr.occurrence_coordinate_count) from data_resource dr where dr.data_provider_id=dp.id);

-- set concept count  
-- Query OK, 67 rows affected (0.01 sec)
-- Rows matched: 250  Changed: 67  Warnings: 0 
select concat('Starting provider taxon concept count: ', now()) as debug; 
update data_provider dp set concept_count =       
(select sum(dr.concept_count) from data_resource dr where dr.data_provider_id=dp.id);
    
-- data resource count    
-- modified 22.1.09, ahahn: exclude deleted resources from count
-- Query OK, 25 rows affected (0.01 sec)
-- Rows matched: 250  Changed: 25  Warnings: 0
select concat('Starting provider resource count: ', now()) as debug; 
update data_provider dp set data_resource_count = 
(select count(dr.id) from data_resource dr where dr.data_provider_id=dp.id and deleted is null);     
    
-- occurrence count
-- Query OK, 21 rows affected (0.05 sec)
-- Rows matched: 44  Changed: 21  Warnings: 0
select concat('Starting network occurrence count: ', now()) as debug; 
update resource_network rn set occurrence_count =   
(select sum(dr.occurrence_count) from data_resource dr 
    inner join network_membership nm on dr.id = nm.data_resource_id where nm.resource_network_id=rn.id);    

-- occurrence record coordinate count 
-- Query OK, 19 rows affected (0.01 sec)
-- Rows matched: 44  Changed: 19  Warnings: 0
select concat('Starting network occurrence coordinate count: ', now()) as debug; 
update resource_network rn set occurrence_coordinate_count =   
(select sum(dr.occurrence_coordinate_count) from data_resource dr 
    inner join network_membership nm on dr.id = nm.data_resource_id where nm.resource_network_id=rn.id);     

	
    
-- tidy up floating taxa (14719007 = unknown kingdom)
-- Query OK, 3 rows affected (1.91 sec)
-- Rows matched: 3  Changed: 3  Warnings: 0
select concat('Tidying up floating taxa: ', now()) as debug; 
update taxon_concept set parent_concept_id=14719007
where data_resource_id=1 and rank>1000 and priority>10 and priority<10000 and parent_concept_id is null;

-- generate resource_country join table
-- Query OK, 34749 rows affected, 1257 warnings (3 min 15.73 sec)
-- Records: 34749  Duplicates: 0  Warnings: 1257
select concat('Starting resource_country generation: ', now()) as debug;
-- truncate table resource_country;
delete from resource_country;
insert into resource_country 
      select data_resource_id, iso_country_code, count(id), 0 
      from occurrence_record  
      group by data_resource_id, iso_country_code;

-- generate occurrence_coordinate_count value for resource_country join table (using temporary table)
-- tested on 119m DB - takes 8 mins to fully execute 
-- Query OK, 15070 rows affected (2 min 56.34 sec)
-- Records: 15070  Duplicates: 0  Warnings: 0
select concat('Starting resource_country occurrence_coordinate_count generation: ', now()) as debug;
create table temp_resource_country_occ 
select oc.data_resource_id, oc.iso_country_code, count(oc.id) as occurrence_coordinate_count
from occurrence_record oc 
where oc.cell_id is not null
and oc.deleted is null
group by oc.data_resource_id, oc.iso_country_code;


-- Query OK, 34749 rows affected (7 min 42.06 sec)
-- Rows matched: 34749  Changed: 34749  Warnings: 0
select concat('Update resource_country with the values calculated in previous step: ', now()) as debug;
update resource_country rc set rc.occurrence_coordinate_count =
(select temp_rc_occ.occurrence_coordinate_count 
from temp_resource_country_occ temp_rc_occ 
where rc.data_resource_id = temp_rc_occ.data_resource_id
and rc.iso_country_code = temp_rc_occ.iso_country_code);
-- drop temp table
drop table temp_resource_country_occ;


-- Query OK, 1550 rows affected (3 min 42.20 sec)
-- Records: 1550  Duplicates: 0  Warnings: 0
select concat('Starting taxon_country kingdom generation: ', now()) as debug;
-- truncate table taxon_country;
delete from taxon_country;
-- populate taxon_country
insert ignore into taxon_country 
select kingdom_concept_id, iso_country_code, count(*)
from occurrence_record 
where kingdom_concept_id is not null
and iso_country_code is not null
and deleted is null
group by 1,2;


-- populate taxon_country
-- Query OK, 9932 rows affected (3 min 43.63 sec)
-- Records: 9932  Duplicates: 0  Warnings: 0
select concat('Starting taxon_country phylum generation: ', now()) as debug;
insert ignore into taxon_country 
select phylum_concept_id, iso_country_code, count(*)
from occurrence_record 
where phylum_concept_id is not null
and iso_country_code is not null
and deleted is null
group by 1,2;

-- populate taxon_country
-- Query OK, 20544 rows affected (3 min 33.58 sec)
-- Records: 20544  Duplicates: 0  Warnings: 0
select concat('Starting taxon_country class generation: ', now()) as debug;
insert ignore into taxon_country 
select class_concept_id, iso_country_code, count(*)
from occurrence_record 
where class_concept_id is not null
and iso_country_code is not null
and deleted is null
group by 1,2;

-- populate taxon_country
-- Query OK, 74553 rows affected (3 min 36.94 sec)
-- Records: 74553  Duplicates: 0  Warnings: 0
select concat('Starting taxon_country order generation: ', now()) as debug;
insert ignore into taxon_country 
select order_concept_id, iso_country_code, count(*)
from occurrence_record 
where order_concept_id is not null
and iso_country_code is not null
and deleted is null
group by 1,2;

-- populate taxon_country
-- Query OK, 250666 rows affected (3 min 45.73 sec)
-- Records: 250666  Duplicates: 0  Warnings: 0
select concat('Starting taxon_country family generation: ', now()) as debug;
insert ignore into taxon_country 
select family_concept_id, iso_country_code, count(*)
from occurrence_record 
where family_concept_id is not null
and iso_country_code is not null
and deleted is null
group by 1,2;

-- populate taxon_country
-- Query OK, 941366 rows affected (4 min 10.50 sec)
-- Records: 941366  Duplicates: 0  Warnings: 0
select concat('Starting taxon_country genus generation: ', now()) as debug;
insert ignore into taxon_country 
select genus_concept_id, iso_country_code, count(*)
from occurrence_record 
where genus_concept_id is not null
and iso_country_code is not null
and deleted is null
group by 1,2;

-- populate taxon_country
-- Query OK, 2478276 rows affected (4 min 41.34 sec)
-- Records: 2478276  Duplicates: 0  Warnings: 0
select concat('Starting taxon_country species generation: ', now()) as debug;
insert ignore into taxon_country 
select species_concept_id, iso_country_code, count(*)
from occurrence_record 
where species_concept_id is not null
and iso_country_code is not null
and deleted is null
group by 1,2;

-- populate taxon_country
-- Query OK, 463453 rows affected, 167 warnings (5 min 49.99 sec)
-- Records: 3148580  Duplicates: 2685127  Warnings: 167
select concat('Starting taxon_country nub concept generation: ', now()) as debug;
insert ignore into taxon_country 
select nub_concept_id, iso_country_code, count(*)
from occurrence_record
where iso_country_code is not null
and deleted is null
group by 1,2;

-- ***********************************
-- Addition by SiB Colombia
-- sets the departments taxon count
-- ***********************************
-- populate taxon_department
select concat('Starting taxon_department kingdom generation: ', now()) as debug;
-- truncate table taxon_department;
delete from taxon_department;
-- populate taxon_department
insert ignore into taxon_department 
select kingdom_concept_id, iso_department_code, count(*)
from occurrence_record 
where kingdom_concept_id is not null
and iso_department_code is not null
and deleted is null
group by 1,2;

-- populate taxon_department
select concat('Starting taxon_department phylum generation: ', now()) as debug;
insert ignore into taxon_department 
select phylum_concept_id, iso_department_code, count(*)
from occurrence_record 
where phylum_concept_id is not null
and iso_department_code is not null
and deleted is null
group by 1,2;

-- populate taxon_department
select concat('Starting taxon_department class generation: ', now()) as debug;
insert ignore into taxon_department 
select class_concept_id, iso_department_code, count(*)
from occurrence_record 
where class_concept_id is not null
and iso_department_code is not null
and deleted is null
group by 1,2;

-- populate taxon_department
select concat('Starting taxon_department order generation: ', now()) as debug;
insert ignore into taxon_department 
select order_concept_id, iso_department_code, count(*)
from occurrence_record 
where order_concept_id is not null
and iso_department_code is not null
and deleted is null
group by 1,2;

-- populate taxon_department
select concat('Starting taxon_department family generation: ', now()) as debug;
insert ignore into taxon_department 
select family_concept_id, iso_department_code, count(*)
from occurrence_record 
where family_concept_id is not null
and iso_department_code is not null
and deleted is null
group by 1,2;

-- populate taxon_department
select concat('Starting taxon_department genus generation: ', now()) as debug;
insert ignore into taxon_department 
select genus_concept_id, iso_department_code, count(*)
from occurrence_record 
where genus_concept_id is not null
and iso_department_code is not null
and deleted is null
group by 1,2;

-- populate taxon_department
select concat('Starting taxon_department species generation: ', now()) as debug;
insert ignore into taxon_department
select species_concept_id, iso_department_code, count(*)
from occurrence_record 
where species_concept_id is not null
and iso_department_code is not null
and deleted is null
group by 1,2;

-- populate taxon_department
select concat('Starting taxon_department nub concept generation: ', now()) as debug;
insert ignore into taxon_department 
select nub_concept_id, iso_department_code, count(*)
from occurrence_record
where iso_department_code is not null
and deleted is null
group by 1,2;

-- ***********************************
-- Addition by SiB Colombia
-- sets the counties taxon count
-- ***********************************
-- populate taxon_county
select concat('Starting taxon_county kingdom generation: ', now()) as debug;
truncate table taxon_county;
-- populate taxon_county
insert ignore into taxon_county 
select kingdom_concept_id, iso_county_code, count(*)
from occurrence_record 
where kingdom_concept_id is not null
and iso_county_code is not null
and deleted is null
group by 1,2;

-- populate taxon_county
select concat('Starting taxon_county phylum generation: ', now()) as debug;
insert ignore into taxon_county 
select phylum_concept_id, iso_county_code, count(*)
from occurrence_record 
where phylum_concept_id is not null
and iso_county_code is not null
and deleted is null
group by 1,2;

-- populate taxon_county
select concat('Starting taxon_county class generation: ', now()) as debug;
insert ignore into taxon_county 
select class_concept_id, iso_county_code, count(*)
from occurrence_record 
where class_concept_id is not null
and iso_county_code is not null
and deleted is null
group by 1,2;

-- populate taxon_county
select concat('Starting taxon_county order generation: ', now()) as debug;
insert ignore into taxon_county 
select order_concept_id, iso_county_code, count(*)
from occurrence_record 
where order_concept_id is not null
and iso_county_code is not null
and deleted is null
group by 1,2;

-- populate taxon_county
select concat('Starting taxon_county family generation: ', now()) as debug;
insert ignore into taxon_county 
select family_concept_id, iso_county_code, count(*)
from occurrence_record 
where family_concept_id is not null
and iso_county_code is not null
and deleted is null
group by 1,2;

-- populate taxon_county
select concat('Starting taxon_county genus generation: ', now()) as debug;
insert ignore into taxon_county 
select genus_concept_id, iso_county_code, count(*)
from occurrence_record 
where genus_concept_id is not null
and iso_county_code is not null
and deleted is null
group by 1,2;

-- populate taxon_county
select concat('Starting taxon_county species generation: ', now()) as debug;
insert ignore into taxon_county
select species_concept_id, iso_county_code, count(*)
from occurrence_record 
where species_concept_id is not null
and iso_county_code is not null
and deleted is null
group by 1,2;

-- populate taxon_county
select concat('Starting taxon_county nub concept generation: ', now()) as debug;
insert ignore into taxon_county 
select nub_concept_id, iso_county_code, count(*)
from occurrence_record
where iso_county_code is not null
and deleted is null
group by 1,2;

-- ***********************************
-- Addition by SiB Colombia
-- sets the paramos taxon count
-- ***********************************
-- populate taxon_paramo
select concat('Starting taxon_paramo kingdom generation: ', now()) as debug;
truncate table taxon_paramo;
-- populate taxon_paramo
insert ignore into taxon_paramo 
select kingdom_concept_id, paramo, count(*)
from occurrence_record 
where kingdom_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_paramo
select concat('Starting taxon_paramo phylum generation: ', now()) as debug;
insert ignore into taxon_paramo 
select phylum_concept_id, paramo, count(*)
from occurrence_record 
where phylum_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_paramo
select concat('Starting taxon_paramo class generation: ', now()) as debug;
insert ignore into taxon_paramo 
select class_concept_id, paramo, count(*)
from occurrence_record 
where class_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_paramo
select concat('Starting taxon_paramo order generation: ', now()) as debug;
insert ignore into taxon_paramo 
select order_concept_id, paramo, count(*)
from occurrence_record 
where order_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_paramo
select concat('Starting taxon_paramo family generation: ', now()) as debug;
insert ignore into taxon_paramo 
select family_concept_id, paramo, count(*)
from occurrence_record 
where family_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_paramo
select concat('Starting taxon_paramo genus generation: ', now()) as debug;
insert ignore into taxon_paramo 
select genus_concept_id, paramo, count(*)
from occurrence_record 
where genus_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_paramo
select concat('Starting taxon_paramo species generation: ', now()) as debug;
insert ignore into taxon_paramo
select species_concept_id, paramo, count(*)
from occurrence_record 
where species_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_paramo
select concat('Starting taxon_paramo nub concept generation: ', now()) as debug;
insert ignore into taxon_paramo 
select nub_concept_id, paramo, count(*)
from occurrence_record
where paramo is not null
and deleted is null
group by 1,2;

-- ***********************************
-- Addition by SiB Colombia
-- sets the marine zones taxon count
-- ***********************************
-- populate taxon_marine_zone
select concat('Starting taxon_marine_zone kingdom generation: ', now()) as debug;
truncate table taxon_marine_zone;
-- populate taxon_marine_zone
insert ignore into taxon_marine_zone 
select kingdom_concept_id, marine_zone, count(*)
from occurrence_record 
where kingdom_concept_id is not null
and marine_zone is not null
and deleted is null
group by 1,2;

-- populate taxon_marine_zone
select concat('Starting taxon_marine_zone phylum generation: ', now()) as debug;
insert ignore into taxon_marine_zone 
select phylum_concept_id, marine_zone, count(*)
from occurrence_record 
where phylum_concept_id is not null
and marine_zone is not null
and deleted is null
group by 1,2;

-- populate taxon_marine_zone
select concat('Starting taxon_marine_zone class generation: ', now()) as debug;
insert ignore into taxon_marine_zone 
select class_concept_id, marine_zone, count(*)
from occurrence_record 
where class_concept_id is not null
and marine_zone is not null
and deleted is null
group by 1,2;

-- populate taxon_marine_zone
select concat('Starting taxon_marine_zone order generation: ', now()) as debug;
insert ignore into taxon_marine_zone 
select order_concept_id, marine_zone, count(*)
from occurrence_record 
where order_concept_id is not null
and marine_zone is not null
and deleted is null
group by 1,2;

-- populate taxon_marine_zone
select concat('Starting taxon_marine_zone family generation: ', now()) as debug;
insert ignore into taxon_marine_zone 
select family_concept_id, marine_zone, count(*)
from occurrence_record 
where family_concept_id is not null
and marine_zone is not null
and deleted is null
group by 1,2;

-- populate taxon_marine_zone
select concat('Starting taxon_marine_zone genus generation: ', now()) as debug;
insert ignore into taxon_marine_zone 
select genus_concept_id, marine_zone, count(*)
from occurrence_record 
where genus_concept_id is not null
and marine_zone is not null
and deleted is null
group by 1,2;

-- populate taxon_marine_zone
select concat('Starting taxon_marine_zone species generation: ', now()) as debug;
insert ignore into taxon_marine_zone
select species_concept_id, marine_zone, count(*)
from occurrence_record 
where species_concept_id is not null
and marine_zone is not null
and deleted is null
group by 1,2;

-- populate taxon_marine_zone
select concat('Starting taxon_marine_zone nub concept generation: ', now()) as debug;
insert ignore into taxon_marine_zone 
select nub_concept_id, marine_zone, count(*)
from occurrence_record
where marine_zone is not null
and deleted is null
group by 1,2;

-- ***********************************
-- Addition by SiB Colombia
-- sets the protected areas taxon count
-- ***********************************
-- populate taxon_protected_area
select concat('Starting taxon_protected_area kingdom generation: ', now()) as debug;
truncate table taxon_protected_area;
-- populate taxon_protected_area
insert ignore into taxon_protected_area 
select kingdom_concept_id, protected_area, count(*)
from occurrence_record 
where kingdom_concept_id is not null
and protected_area is not null
and deleted is null
group by 1,2;

-- populate taxon_protected_area
select concat('Starting taxon_protected_area phylum generation: ', now()) as debug;
insert ignore into taxon_protected_area 
select phylum_concept_id, protected_area, count(*)
from occurrence_record 
where phylum_concept_id is not null
and protected_area is not null
and deleted is null
group by 1,2;

-- populate taxon_protected_area
select concat('Starting taxon_protected_area class generation: ', now()) as debug;
insert ignore into taxon_protected_area 
select class_concept_id, protected_area, count(*)
from occurrence_record 
where class_concept_id is not null
and protected_area is not null
and deleted is null
group by 1,2;

-- populate taxon_protected_area
select concat('Starting taxon_protected_area order generation: ', now()) as debug;
insert ignore into taxon_protected_area 
select order_concept_id, protected_area, count(*)
from occurrence_record 
where order_concept_id is not null
and protected_area is not null
and deleted is null
group by 1,2;

-- populate taxon_protected_area
select concat('Starting taxon_protected_area family generation: ', now()) as debug;
insert ignore into taxon_protected_area 
select family_concept_id, protected_area, count(*)
from occurrence_record 
where family_concept_id is not null
and protected_area is not null
and deleted is null
group by 1,2;

-- populate taxon_protected_area
select concat('Starting taxon_protected_area genus generation: ', now()) as debug;
insert ignore into taxon_protected_area 
select genus_concept_id, protected_area, count(*)
from occurrence_record 
where genus_concept_id is not null
and protected_area is not null
and deleted is null
group by 1,2;

-- populate taxon_protected_area
select concat('Starting taxon_protected_area species generation: ', now()) as debug;
insert ignore into taxon_protected_area
select species_concept_id, protected_area, count(*)
from occurrence_record 
where species_concept_id is not null
and protected_area is not null
and deleted is null
group by 1,2;

-- populate taxon_protected_area
select concat('Starting taxon_protected_area nub concept generation: ', now()) as debug;
insert ignore into taxon_protected_area 
select nub_concept_id, protected_area, count(*)
from occurrence_record
where protected_area is not null
and deleted is null
group by 1,2;

-- ***********************************
-- Addition by SiB Colombia
-- sets the ecosystem taxon count
-- ***********************************
-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem kingdom generation: ', now()) as debug;
truncate table taxon_ecosystem;
-- populate taxon_ecosystem
insert ignore into taxon_ecosystem 
select kingdom_concept_id, dry_forest, count(*)
from occurrence_record 
where kingdom_concept_id is not null
and dry_forest = 1
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem phylum generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select phylum_concept_id, dry_forest, count(*)
from occurrence_record 
where phylum_concept_id is not null
and dry_forest = 1
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem class generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select class_concept_id, dry_forest, count(*)
from occurrence_record 
where class_concept_id is not null
and dry_forest = 1
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem order generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select order_concept_id, dry_forest, count(*)
from occurrence_record 
where order_concept_id is not null
and dry_forest = 1
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem family generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select family_concept_id, dry_forest, count(*)
from occurrence_record 
where family_concept_id is not null
and dry_forest = 1
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem genus generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select genus_concept_id, dry_forest, count(*)
from occurrence_record 
where genus_concept_id is not null
and dry_forest = 1
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem species generation: ', now()) as debug;
insert ignore into taxon_ecosystem
select species_concept_id, dry_forest, count(*)
from occurrence_record 
where species_concept_id is not null
and dry_forest = 1
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem nub concept generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select nub_concept_id, dry_forest, count(*)
from occurrence_record
where dry_forest = 1
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
insert ignore into taxon_ecosystem 
select kingdom_concept_id, paramo, count(*)
from occurrence_record 
where kingdom_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem phylum generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select phylum_concept_id, paramo, count(*)
from occurrence_record 
where phylum_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem class generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select class_concept_id, paramo, count(*)
from occurrence_record 
where class_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem order generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select order_concept_id, paramo, count(*)
from occurrence_record 
where order_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem family generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select family_concept_id, paramo, count(*)
from occurrence_record 
where family_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem genus generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select genus_concept_id, paramo, count(*)
from occurrence_record 
where genus_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem species generation: ', now()) as debug;
insert ignore into taxon_ecosystem
select species_concept_id, paramo, count(*)
from occurrence_record 
where species_concept_id is not null
and paramo is not null
and deleted is null
group by 1,2;

-- populate taxon_ecosystem
select concat('Starting taxon_ecosystem nub concept generation: ', now()) as debug;
insert ignore into taxon_ecosystem 
select nub_concept_id, paramo, count(*)
from occurrence_record
where paramo is not null
and deleted is null
group by 1,2;

-- ***********************************
-- Addition by SiB Colombia
-- sets the zonificacion taxon count
-- ***********************************
-- populate taxon_zonificacion
select concat('Starting taxon_zonificacion kingdom generation: ', now()) as debug;
truncate table taxon_zonificacion;
-- populate taxon_zonificacion
insert ignore into taxon_zonificacion 
select kingdom_concept_id, zonificacion, count(*)
from occurrence_record 
where kingdom_concept_id is not null
and zonificacion is not null
and deleted is null
group by 1,2;

-- populate taxon_zonificacion
select concat('Starting taxon_zonificacion phylum generation: ', now()) as debug;
insert ignore into taxon_zonificacion 
select phylum_concept_id, zonificacion, count(*)
from occurrence_record 
where phylum_concept_id is not null
and zonificacion is not null
and deleted is null
group by 1,2;

-- populate taxon_zonificacion
select concat('Starting taxon_zonificacion class generation: ', now()) as debug;
insert ignore into taxon_zonificacion 
select class_concept_id, zonificacion, count(*)
from occurrence_record 
where class_concept_id is not null
and zonificacion is not null
and deleted is null
group by 1,2;

-- populate taxon_zonificacion
select concat('Starting taxon_zonificacion order generation: ', now()) as debug;
insert ignore into taxon_zonificacion 
select order_concept_id, zonificacion, count(*)
from occurrence_record 
where order_concept_id is not null
and zonificacion is not null
and deleted is null
group by 1,2;

-- populate taxon_zonificacion
select concat('Starting taxon_zonificacion family generation: ', now()) as debug;
insert ignore into taxon_zonificacion 
select family_concept_id, zonificacion, count(*)
from occurrence_record 
where family_concept_id is not null
and zonificacion is not null
and deleted is null
group by 1,2;

-- populate taxon_zonificacion
select concat('Starting taxon_zonificacion genus generation: ', now()) as debug;
insert ignore into taxon_zonificacion 
select genus_concept_id, zonificacion, count(*)
from occurrence_record 
where genus_concept_id is not null
and zonificacion is not null
and deleted is null
group by 1,2;

-- populate taxon_zonificacion
select concat('Starting taxon_zonificacion species generation: ', now()) as debug;
insert ignore into taxon_zonificacion
select species_concept_id, zonificacion, count(*)
from occurrence_record 
where species_concept_id is not null
and zonificacion is not null
and deleted is null
group by 1,2;

-- populate taxon_zonificacion
select concat('Starting taxon_zonificacion nub concept generation: ', now()) as debug;
insert ignore into taxon_zonificacion 
select nub_concept_id, zonificacion, count(*)
from occurrence_record
where zonificacion is not null
and deleted is null
group by 1,2;


-- ***********************************
-- Addition by SiB Colombia
-- sets the departments count
-- ***********************************
select concat('Starting department occurrence count: ', now()) as debug;
update department d set occurrence_count =
(select count(id) from occurrence_record o where o.iso_department_code=d.iso_department_code and o.deleted is null);

-- set occurrence record coordinate count for department table
select concat('Starting department occurrence coordinate count: ', now()) as debug;
update department d set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=d.id and cd.type=8);

-- set species count per department
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting department species count: ', now()) as debug;
update department d set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.iso_department_code = d.iso_department_code and o.deleted is null);
-- End of SiB Colombia addition

-- ***********************************
-- Addition by SiB Colombia
-- sets the counties count
-- ***********************************
-- Addition by SiB Colombia
-- sets the counties count
select concat('Starting county occurrence count: ', now()) as debug;
update county c set occurrence_count =
(select count(id) from occurrence_record o where o.iso_county_code=c.iso_county_code and o.deleted is null);

-- set occurrence record coordinate count for county table
select concat('Starting county occurrence coordinate count: ', now()) as debug;
update county c set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=c.id and cd.type=9);


-- set species count per county
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting county species count: ', now()) as debug;
update county c set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.iso_county_code = c.iso_county_code and o.deleted is null);

-- sets the paramos count
select concat('Starting paramo occurrence count: ', now()) as debug;
update paramo p set occurrence_count =
(select count(id) from occurrence_record o where o.paramo=p.complex_id and o.deleted is null);

-- set occurrence record coordinate count for paramo table
select concat('Starting paramo occurrence coordinate count: ', now()) as debug;
update paramo p set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=p.id and cd.type=10);

-- set species count per paramo
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting paramo species count: ', now()) as debug;
update paramo p set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.paramo = p.complex_id and o.deleted is null);

-- sets the paramos count for any
select concat('Starting paramo occurrence count for any: ', now()) as debug;
update paramo p set occurrence_count =
(select count(id) from occurrence_record o where o.paramo is not null and o.deleted is null) where complex_id = 'CUA';

-- set species count per paramo for any
select concat('Starting paramo species count for any: ', now()) as debug;
update paramo p set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.paramo is not null and o.deleted is null) where complex_id = 'CUA';

-- sets the marine zones count
select concat('Starting marine zones occurrence count: ', now()) as debug;
update marine_zone m set occurrence_count =
(select count(id) from occurrence_record o where o.marine_zone=m.mask and o.deleted is null);

-- set occurrence record coordinate count for marine zones table
select concat('Starting marine zones occurrence coordinate count: ', now()) as debug;
update marine_zone m set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=m.id and cd.type=11);

-- set species count per marine zones
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting marine zones species count: ', now()) as debug;
update marine_zone m set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.marine_zone=m.mask and o.deleted is null);

-- sets the marine zones count for any
select concat('Starting marine zones occurrence count for any: ', now()) as debug;
update marine_zone m set occurrence_count =
(select count(id) from occurrence_record o where o.marine_zone is not null and o.deleted is null) where mask = 'CUA';

-- set species count per marine zones for any
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting marine zones species count for any: ', now()) as debug;
update marine_zone m set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.marine_zone is not null and o.deleted is null) where mask = 'CUA';

-- sets the protected areas count
select concat('Starting protected areas occurrence count: ', now()) as debug;
update protected_area pa set occurrence_count =
(select count(id) from occurrence_record o where o.protected_area=pa.pa_id and o.deleted is null);

-- set occurrence record coordinate count for protected areas table
select concat('Starting protected areas occurrence coordinate count: ', now()) as debug;
update protected_area pa set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=pa.id and cd.type=11);

-- set species count per protected areas
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting protected areas species count: ', now()) as debug;
update protected_area pa set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.protected_area=pa.pa_id and o.deleted is null);

-- sets the dry forest ecosystem count
select concat('Starting dry forest ecosystem occurrence count: ', now()) as debug;
update ecosystem e set occurrence_count =
(select count(id) from occurrence_record o where o.dry_forest = 1 and o.deleted is null)
where id = 1;

-- sets the paramo ecosystem count
select concat('Starting dry forest ecosystem occurrence count: ', now()) as debug;
update ecosystem e set occurrence_count =
(select count(id) from occurrence_record o where o.paramo is not null and o.deleted is null)
where id = 2;

-- set occurrence record coordinate count for ecosystem
select concat('Starting  ecosystem occurrence coordinate count: ', now()) as debug;
update ecosystem e set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=e.id and cd.type=13);

-- set species count per dry forest ecosystem
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting dry forest ecosystem species count: ', now()) as debug;
update ecosystem e set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.dry_forest = 1 and o.deleted is null)
where id = 1;

-- set species count per paramo ecosystem
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting paramo ecosystem species count: ', now()) as debug;
update ecosystem e set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.paramo is not null and o.deleted is null)
where id = 2;

-- sets the zonificacion count
select concat('Starting zonificacion occurrence count: ', now()) as debug;
update zonificacion z set occurrence_count =
(select count(id) from occurrence_record o where o.zonificacion=z.szh and o.deleted is null);

-- set occurrence record coordinate count for zonificacion table
select concat('Starting zonificacion occurrence coordinate count: ', now()) as debug;
update zonificacion z set occurrence_coordinate_count =   
(select sum(cd.count) from cell_density cd where cd.entity_id=z.id and cd.type=14);

-- set species count per zonificacion
-- this used to be species and lower concepts as well - changed 12.8.08
select concat('Starting zonificacion species count: ', now()) as debug;
update zonificacion z set species_count = 
(select count(distinct o.species_concept_id) from occurrence_record o where o.zonificacion = z.szh and o.deleted is null);

-- stats
select concat('Starting stats provider type species counts: ', now()) as debug;	
UPDATE stats_provider_type_species_counts st set st.count = 
(SELECT count(distinct species_concept_id) FROM occurrence_record where data_provider_id in (SELECT id FROM portal.data_provider where type like st.provider_type) and deleted is null);

select concat('Starting stats taxon concept counts for Chromista: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where kingdom_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Chromista') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Chromistas';

select concat('Starting stats taxon concept counts for Protozoa: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where kingdom_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Protozoa') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Protozoos';

select concat('Starting stats taxon concept counts for Plantae: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where kingdom_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Plantae') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Plantas';

select concat('Starting stats taxon concept counts for Fungi: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where kingdom_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Fungi') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Hongos';

select concat('Starting stats taxon concept counts for Animalia: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where kingdom_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Animalia') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Animales';

select concat('Starting stats taxon concept counts for Mollusca: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where phylum_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Mollusca') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Moluscos';

select concat('Starting stats taxon concept counts for Amphibia: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Amphibia') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Anfibios';

select concat('Starting stats taxon concept counts for Reptilia: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Reptilia') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Reptiles';

select concat('Starting stats taxon concept counts for Mammalia: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Mammalia') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Mamíferos';

select concat('Starting stats taxon concept counts for Aves: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Aves') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Aves';

select concat('Starting stats taxon concept counts for Arachnida: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Arachnida') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Arácnidos';

select concat('Starting stats taxon concept counts for Insecta: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Insecta') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) where st.taxon_name like 'Insectos';

select concat('Starting stats taxon concept counts for Actinopterygii and Sarcopterygii: ', now()) as debug;	
UPDATE stats_taxon_concept_counts st set st.count = 
(SELECT SUM(T1.total) FROM(
SELECT count(*) total FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Actinopterygii') and data_provider_id = 1 and data_resource_id = 1) and deleted is null union all
SELECT count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Sarcopterygii') and data_provider_id = 1 and data_resource_id = 1) and deleted is null) T1) where st.taxon_name like 'Peces óseos';

drop table if exists stats_month_counts;

create table stats_month_counts (year int(4), month int (2), count int(10), accumulative int(10));

insert into stats_month_counts (year, month, count) 
select 2012, 12, count(*) from raw_occurrence_record where created like '2012-12%' and deleted is null union all
select 2013, 01, count(*) from raw_occurrence_record where created like '2013-01%' and deleted is null union all
select 2013, 02, count(*) from raw_occurrence_record where created like '2013-02%' and deleted is null union all
select 2013, 03, count(*) from raw_occurrence_record where created like '2013-03%' and deleted is null union all
select 2013, 04, count(*) from raw_occurrence_record where created like '2013-04%' and deleted is null union all
select 2013, 05, count(*) from raw_occurrence_record where created like '2013-05%' and deleted is null union all
select 2013, 06, count(*) from raw_occurrence_record where created like '2013-06%' and deleted is null union all
select 2013, 07, count(*) from raw_occurrence_record where created like '2013-07%' and deleted is null union all
select 2013, 08, count(*) from raw_occurrence_record where created like '2013-08%' and deleted is null union all
select 2013, 09, count(*) from raw_occurrence_record where created like '2013-09%' and deleted is null union all
select 2013, 10, count(*) from raw_occurrence_record where created like '2013-10%' and deleted is null union all
select 2013, 11, count(*) from raw_occurrence_record where created like '2013-11%' and deleted is null union all
select 2013, 12, count(*) from raw_occurrence_record where created like '2013-12%' and deleted is null union all
select 2014, 01, count(*) from raw_occurrence_record where created like '2014-01%' and deleted is null union all
select 2014, 02, count(*) from raw_occurrence_record where created like '2014-02%' and deleted is null union all
select 2014, 03, count(*) from raw_occurrence_record where created like '2014-03%' and deleted is null union all
select 2014, 04, count(*) from raw_occurrence_record where created like '2014-04%' and deleted is null union all
select 2014, 05, count(*) from raw_occurrence_record where created like '2014-05%' and deleted is null union all
select 2014, 06, count(*) from raw_occurrence_record where created like '2014-06%' and deleted is null union all
select 2014, 07, count(*) from raw_occurrence_record where created like '2014-07%' and deleted is null union all
select 2014, 08, count(*) from raw_occurrence_record where created like '2014-08%' and deleted is null union all
select 2014, 09, count(*) from raw_occurrence_record where created like '2014-09%' and deleted is null union all
select 2014, 10, count(*) from raw_occurrence_record where created like '2014-10%' and deleted is null union all
select 2014, 11, count(*) from raw_occurrence_record where created like '2014-11%' and deleted is null union all
select 2014, 12, count(*) from raw_occurrence_record where created like '2014-12%' and deleted is null union all
select 2015, 01, count(*) from raw_occurrence_record where created like '2015-01%' and deleted is null union all
select 2015, 02, count(*) from raw_occurrence_record where created like '2015-02%' and deleted is null union all
select 2015, 03, count(*) from raw_occurrence_record where created like '2015-03%' and deleted is null union all
select 2015, 04, count(*) from raw_occurrence_record where created like '2015-04%' and deleted is null union all
select 2015, 05, count(*) from raw_occurrence_record where created like '2015-05%' and deleted is null union all
select 2015, 06, count(*) from raw_occurrence_record where created like '2015-06%' and deleted is null union all
select 2015, 07, count(*) from raw_occurrence_record where created like '2015-07%' and deleted is null union all
select 2015, 08, count(*) from raw_occurrence_record where created like '2015-08%' and deleted is null union all
select 2015, 09, count(*) from raw_occurrence_record where created like '2015-09%' and deleted is null union all
select 2015, 10, count(*) from raw_occurrence_record where created like '2015-10%' and deleted is null union all
select 2015, 11, count(*) from raw_occurrence_record where created like '2015-11%' and deleted is null union all
select 2015, 12, count(*) from raw_occurrence_record where created like '2015-12%' and deleted is null union all
select 2016, 01, count(*) from raw_occurrence_record where created like '2016-01%' and deleted is null union all
select 2016, 02, count(*) from raw_occurrence_record where created like '2016-02%' and deleted is null union all
select 2016, 03, count(*) from raw_occurrence_record where created like '2016-03%' and deleted is null union all
select 2016, 04, count(*) from raw_occurrence_record where created like '2016-04%' and deleted is null union all
select 2016, 05, count(*) from raw_occurrence_record where created like '2016-05%' and deleted is null union all
select 2016, 06, count(*) from raw_occurrence_record where created like '2016-06%' and deleted is null union all
select 2016, 07, count(*) from raw_occurrence_record where created like '2016-07%' and deleted is null union all
select 2016, 08, count(*) from raw_occurrence_record where created like '2016-08%' and deleted is null union all
select 2016, 09, count(*) from raw_occurrence_record where created like '2016-09%' and deleted is null union all
select 2016, 10, count(*) from raw_occurrence_record where created like '2016-10%' and deleted is null union all
select 2016, 11, count(*) from raw_occurrence_record where created like '2016-11%' and deleted is null union all
select 2016, 12, count(*) from raw_occurrence_record where created like '2016-12%' and deleted is null union all
select 2017, 01, count(*) from raw_occurrence_record where created like '2017-01%' and deleted is null union all
select 2017, 02, count(*) from raw_occurrence_record where created like '2017-02%' and deleted is null union all
select 2017, 03, count(*) from raw_occurrence_record where created like '2017-03%' and deleted is null union all
select 2017, 04, count(*) from raw_occurrence_record where created like '2017-04%' and deleted is null union all
select 2017, 05, count(*) from raw_occurrence_record where created like '2017-05%' and deleted is null union all
select 2017, 06, count(*) from raw_occurrence_record where created like '2017-06%' and deleted is null union all
select 2017, 07, count(*) from raw_occurrence_record where created like '2017-07%' and deleted is null union all
select 2017, 08, count(*) from raw_occurrence_record where created like '2017-08%' and deleted is null union all
select 2017, 09, count(*) from raw_occurrence_record where created like '2017-09%' and deleted is null union all
select 2017, 10, count(*) from raw_occurrence_record where created like '2017-10%' and deleted is null union all
select 2017, 11, count(*) from raw_occurrence_record where created like '2017-11%' and deleted is null union all
select 2017, 12, count(*) from raw_occurrence_record where created like '2017-12%' and deleted is null union all
select 2018, 01, count(*) from raw_occurrence_record where created like '2018-01%' and deleted is null union all
select 2018, 02, count(*) from raw_occurrence_record where created like '2018-02%' and deleted is null union all
select 2018, 03, count(*) from raw_occurrence_record where created like '2018-03%' and deleted is null union all
select 2018, 04, count(*) from raw_occurrence_record where created like '2018-04%' and deleted is null union all
select 2018, 05, count(*) from raw_occurrence_record where created like '2018-05%' and deleted is null union all
select 2018, 06, count(*) from raw_occurrence_record where created like '2018-06%' and deleted is null union all
select 2018, 07, count(*) from raw_occurrence_record where created like '2018-07%' and deleted is null union all
select 2018, 08, count(*) from raw_occurrence_record where created like '2018-08%' and deleted is null union all
select 2018, 09, count(*) from raw_occurrence_record where created like '2018-09%' and deleted is null union all
select 2018, 10, count(*) from raw_occurrence_record where created like '2018-10%' and deleted is null union all
select 2018, 11, count(*) from raw_occurrence_record where created like '2018-11%' and deleted is null union all
select 2018, 12, count(*) from raw_occurrence_record where created like '2018-12%' and deleted is null union all
select 2019, 01, count(*) from raw_occurrence_record where created like '2019-01%' and deleted is null union all
select 2019, 02, count(*) from raw_occurrence_record where created like '2019-02%' and deleted is null union all
select 2019, 03, count(*) from raw_occurrence_record where created like '2019-03%' and deleted is null union all
select 2019, 04, count(*) from raw_occurrence_record where created like '2019-04%' and deleted is null union all
select 2019, 05, count(*) from raw_occurrence_record where created like '2019-05%' and deleted is null union all
select 2019, 06, count(*) from raw_occurrence_record where created like '2019-06%' and deleted is null union all
select 2019, 07, count(*) from raw_occurrence_record where created like '2019-07%' and deleted is null union all
select 2019, 08, count(*) from raw_occurrence_record where created like '2019-08%' and deleted is null union all
select 2019, 09, count(*) from raw_occurrence_record where created like '2019-09%' and deleted is null union all
select 2019, 10, count(*) from raw_occurrence_record where created like '2019-10%' and deleted is null union all
select 2019, 11, count(*) from raw_occurrence_record where created like '2019-11%' and deleted is null union all
select 2019, 12, count(*) from raw_occurrence_record where created like '2019-12%' and deleted is null union all
select 2020, 01, count(*) from raw_occurrence_record where created like '2020-01%' and deleted is null union all
select 2020, 02, count(*) from raw_occurrence_record where created like '2020-02%' and deleted is null union all
select 2020, 03, count(*) from raw_occurrence_record where created like '2020-03%' and deleted is null union all
select 2020, 04, count(*) from raw_occurrence_record where created like '2020-04%' and deleted is null union all
select 2020, 05, count(*) from raw_occurrence_record where created like '2020-05%' and deleted is null union all
select 2020, 06, count(*) from raw_occurrence_record where created like '2020-06%' and deleted is null union all
select 2020, 07, count(*) from raw_occurrence_record where created like '2020-07%' and deleted is null union all
select 2020, 08, count(*) from raw_occurrence_record where created like '2020-08%' and deleted is null union all
select 2020, 09, count(*) from raw_occurrence_record where created like '2020-09%' and deleted is null union all
select 2020, 10, count(*) from raw_occurrence_record where created like '2020-10%' and deleted is null union all
select 2020, 11, count(*) from raw_occurrence_record where created like '2020-11%' and deleted is null union all
select 2020, 12, count(*) from raw_occurrence_record where created like '2020-12%' and deleted is null union all 
select 2021, 01, count(*) from raw_occurrence_record where created like '2021-01%' and deleted is null union all
select 2021, 02, count(*) from raw_occurrence_record where created like '2021-02%' and deleted is null union all
select 2021, 03, count(*) from raw_occurrence_record where created like '2021-03%' and deleted is null union all
select 2021, 04, count(*) from raw_occurrence_record where created like '2021-04%' and deleted is null union all
select 2021, 05, count(*) from raw_occurrence_record where created like '2021-05%' and deleted is null union all
select 2021, 06, count(*) from raw_occurrence_record where created like '2021-06%' and deleted is null union all
select 2021, 07, count(*) from raw_occurrence_record where created like '2021-07%' and deleted is null union all
select 2021, 08, count(*) from raw_occurrence_record where created like '2021-08%' and deleted is null union all
select 2021, 09, count(*) from raw_occurrence_record where created like '2021-09%' and deleted is null union all
select 2021, 10, count(*) from raw_occurrence_record where created like '2021-10%' and deleted is null union all
select 2021, 11, count(*) from raw_occurrence_record where created like '2021-11%' and deleted is null union all
select 2021, 12, count(*) from raw_occurrence_record where created like '2021-12%' and deleted is null union all
select 2022, 01, count(*) from raw_occurrence_record where created like '2022-01%' and deleted is null union all
select 2022, 02, count(*) from raw_occurrence_record where created like '2022-02%' and deleted is null union all
select 2022, 03, count(*) from raw_occurrence_record where created like '2022-03%' and deleted is null union all
select 2022, 04, count(*) from raw_occurrence_record where created like '2022-04%' and deleted is null union all
select 2022, 05, count(*) from raw_occurrence_record where created like '2022-05%' and deleted is null union all
select 2022, 06, count(*) from raw_occurrence_record where created like '2022-06%' and deleted is null union all
select 2022, 07, count(*) from raw_occurrence_record where created like '2022-07%' and deleted is null union all
select 2022, 08, count(*) from raw_occurrence_record where created like '2022-08%' and deleted is null union all
select 2022, 09, count(*) from raw_occurrence_record where created like '2022-09%' and deleted is null union all
select 2022, 10, count(*) from raw_occurrence_record where created like '2022-10%' and deleted is null union all
select 2022, 11, count(*) from raw_occurrence_record where created like '2022-11%' and deleted is null union all
select 2022, 12, count(*) from raw_occurrence_record where created like '2022-12%' and deleted is null union all
select 2023, 01, count(*) from raw_occurrence_record where created like '2023-01%' and deleted is null union all
select 2023, 02, count(*) from raw_occurrence_record where created like '2023-02%' and deleted is null union all
select 2023, 03, count(*) from raw_occurrence_record where created like '2023-03%' and deleted is null union all
select 2023, 04, count(*) from raw_occurrence_record where created like '2023-04%' and deleted is null union all
select 2023, 05, count(*) from raw_occurrence_record where created like '2023-05%' and deleted is null union all
select 2023, 06, count(*) from raw_occurrence_record where created like '2023-06%' and deleted is null union all
select 2023, 07, count(*) from raw_occurrence_record where created like '2023-07%' and deleted is null union all
select 2023, 08, count(*) from raw_occurrence_record where created like '2023-08%' and deleted is null union all
select 2023, 09, count(*) from raw_occurrence_record where created like '2023-09%' and deleted is null union all
select 2023, 10, count(*) from raw_occurrence_record where created like '2023-10%' and deleted is null union all
select 2023, 11, count(*) from raw_occurrence_record where created like '2023-11%' and deleted is null union all
select 2023, 12, count(*) from raw_occurrence_record where created like '2023-12%' and deleted is null union all
select 2024, 01, count(*) from raw_occurrence_record where created like '2024-01%' and deleted is null union all
select 2024, 02, count(*) from raw_occurrence_record where created like '2024-02%' and deleted is null union all
select 2024, 03, count(*) from raw_occurrence_record where created like '2024-03%' and deleted is null union all
select 2024, 04, count(*) from raw_occurrence_record where created like '2024-04%' and deleted is null union all
select 2024, 05, count(*) from raw_occurrence_record where created like '2024-05%' and deleted is null union all
select 2024, 06, count(*) from raw_occurrence_record where created like '2024-06%' and deleted is null union all
select 2024, 07, count(*) from raw_occurrence_record where created like '2024-07%' and deleted is null union all
select 2024, 08, count(*) from raw_occurrence_record where created like '2024-08%' and deleted is null union all
select 2024, 09, count(*) from raw_occurrence_record where created like '2024-09%' and deleted is null union all
select 2024, 10, count(*) from raw_occurrence_record where created like '2024-10%' and deleted is null union all
select 2024, 11, count(*) from raw_occurrence_record where created like '2024-11%' and deleted is null union all
select 2024, 12, count(*) from raw_occurrence_record where created like '2024-12%' and deleted is null union all
select 2025, 01, count(*) from raw_occurrence_record where created like '2025-01%' and deleted is null union all
select 2025, 02, count(*) from raw_occurrence_record where created like '2025-02%' and deleted is null union all
select 2025, 03, count(*) from raw_occurrence_record where created like '2025-03%' and deleted is null union all
select 2025, 04, count(*) from raw_occurrence_record where created like '2025-04%' and deleted is null union all
select 2025, 05, count(*) from raw_occurrence_record where created like '2025-05%' and deleted is null union all
select 2025, 06, count(*) from raw_occurrence_record where created like '2025-06%' and deleted is null union all
select 2025, 07, count(*) from raw_occurrence_record where created like '2025-07%' and deleted is null union all
select 2025, 08, count(*) from raw_occurrence_record where created like '2025-08%' and deleted is null union all
select 2025, 09, count(*) from raw_occurrence_record where created like '2025-09%' and deleted is null union all
select 2025, 10, count(*) from raw_occurrence_record where created like '2025-10%' and deleted is null union all
select 2025, 11, count(*) from raw_occurrence_record where created like '2025-11%' and deleted is null union all
select 2025, 12, count(*) from raw_occurrence_record where created like '2025-12%' and deleted is null union all
select 2026, 01, count(*) from raw_occurrence_record where created like '2026-01%' and deleted is null union all
select 2026, 02, count(*) from raw_occurrence_record where created like '2026-02%' and deleted is null union all
select 2026, 03, count(*) from raw_occurrence_record where created like '2026-03%' and deleted is null union all
select 2026, 04, count(*) from raw_occurrence_record where created like '2026-04%' and deleted is null union all
select 2026, 05, count(*) from raw_occurrence_record where created like '2026-05%' and deleted is null union all
select 2026, 06, count(*) from raw_occurrence_record where created like '2026-06%' and deleted is null union all
select 2026, 07, count(*) from raw_occurrence_record where created like '2026-07%' and deleted is null union all
select 2026, 08, count(*) from raw_occurrence_record where created like '2026-08%' and deleted is null union all
select 2026, 09, count(*) from raw_occurrence_record where created like '2026-09%' and deleted is null union all
select 2026, 10, count(*) from raw_occurrence_record where created like '2026-10%' and deleted is null union all
select 2026, 11, count(*) from raw_occurrence_record where created like '2026-11%' and deleted is null union all
select 2026, 12, count(*) from raw_occurrence_record where created like '2026-12%' and deleted is null union all
select 2027, 01, count(*) from raw_occurrence_record where created like '2027-01%' and deleted is null union all
select 2027, 02, count(*) from raw_occurrence_record where created like '2027-02%' and deleted is null union all
select 2027, 03, count(*) from raw_occurrence_record where created like '2027-03%' and deleted is null union all
select 2027, 04, count(*) from raw_occurrence_record where created like '2027-04%' and deleted is null union all
select 2027, 05, count(*) from raw_occurrence_record where created like '2027-05%' and deleted is null union all
select 2027, 06, count(*) from raw_occurrence_record where created like '2027-06%' and deleted is null union all
select 2027, 07, count(*) from raw_occurrence_record where created like '2027-07%' and deleted is null union all
select 2027, 08, count(*) from raw_occurrence_record where created like '2027-08%' and deleted is null union all
select 2027, 09, count(*) from raw_occurrence_record where created like '2027-09%' and deleted is null union all
select 2027, 10, count(*) from raw_occurrence_record where created like '2027-10%' and deleted is null union all
select 2027, 11, count(*) from raw_occurrence_record where created like '2027-11%' and deleted is null union all
select 2027, 12, count(*) from raw_occurrence_record where created like '2027-12%' and deleted is null union all
select 2028, 01, count(*) from raw_occurrence_record where created like '2028-01%' and deleted is null union all
select 2028, 02, count(*) from raw_occurrence_record where created like '2028-02%' and deleted is null union all
select 2028, 03, count(*) from raw_occurrence_record where created like '2028-03%' and deleted is null union all
select 2028, 04, count(*) from raw_occurrence_record where created like '2028-04%' and deleted is null union all
select 2028, 05, count(*) from raw_occurrence_record where created like '2028-05%' and deleted is null union all
select 2028, 06, count(*) from raw_occurrence_record where created like '2028-06%' and deleted is null union all
select 2028, 07, count(*) from raw_occurrence_record where created like '2028-07%' and deleted is null union all
select 2028, 08, count(*) from raw_occurrence_record where created like '2028-08%' and deleted is null union all
select 2028, 09, count(*) from raw_occurrence_record where created like '2028-09%' and deleted is null union all
select 2028, 10, count(*) from raw_occurrence_record where created like '2028-10%' and deleted is null union all
select 2028, 11, count(*) from raw_occurrence_record where created like '2028-11%' and deleted is null union all
select 2028, 12, count(*) from raw_occurrence_record where created like '2028-12%' and deleted is null union all
select 2029, 01, count(*) from raw_occurrence_record where created like '2029-01%' and deleted is null union all
select 2029, 02, count(*) from raw_occurrence_record where created like '2029-02%' and deleted is null union all
select 2029, 03, count(*) from raw_occurrence_record where created like '2029-03%' and deleted is null union all
select 2029, 04, count(*) from raw_occurrence_record where created like '2029-04%' and deleted is null union all
select 2029, 05, count(*) from raw_occurrence_record where created like '2029-05%' and deleted is null union all
select 2029, 06, count(*) from raw_occurrence_record where created like '2029-06%' and deleted is null union all
select 2029, 07, count(*) from raw_occurrence_record where created like '2029-07%' and deleted is null union all
select 2029, 08, count(*) from raw_occurrence_record where created like '2029-08%' and deleted is null union all
select 2029, 09, count(*) from raw_occurrence_record where created like '2029-09%' and deleted is null union all
select 2029, 10, count(*) from raw_occurrence_record where created like '2029-10%' and deleted is null union all
select 2029, 11, count(*) from raw_occurrence_record where created like '2029-11%' and deleted is null union all
select 2029, 12, count(*) from raw_occurrence_record where created like '2029-12%' and deleted is null union all
select 2030, 01, count(*) from raw_occurrence_record where created like '2030-01%' and deleted is null union all
select 2030, 02, count(*) from raw_occurrence_record where created like '2030-02%' and deleted is null union all
select 2030, 03, count(*) from raw_occurrence_record where created like '2030-03%' and deleted is null union all
select 2030, 04, count(*) from raw_occurrence_record where created like '2030-04%' and deleted is null union all
select 2030, 05, count(*) from raw_occurrence_record where created like '2030-05%' and deleted is null union all
select 2030, 06, count(*) from raw_occurrence_record where created like '2030-06%' and deleted is null union all
select 2030, 07, count(*) from raw_occurrence_record where created like '2030-07%' and deleted is null union all
select 2030, 08, count(*) from raw_occurrence_record where created like '2030-08%' and deleted is null union all
select 2030, 09, count(*) from raw_occurrence_record where created like '2030-09%' and deleted is null union all
select 2030, 10, count(*) from raw_occurrence_record where created like '2030-10%' and deleted is null union all
select 2030, 11, count(*) from raw_occurrence_record where created like '2030-11%' and deleted is null union all
select 2030, 12, count(*) from raw_occurrence_record where created like '2030-12%' and deleted is null ;

update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-01-01' and deleted is null) where year = 2012 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-02-01' and deleted is null) where year = 2013 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-03-01' and deleted is null) where year = 2013 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-04-01' and deleted is null) where year = 2013 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-05-01' and deleted is null) where year = 2013 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-06-01' and deleted is null) where year = 2013 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-07-01' and deleted is null) where year = 2013 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-08-01' and deleted is null) where year = 2013 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-09-01' and deleted is null) where year = 2013 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-10-01' and deleted is null) where year = 2013 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-11-01' and deleted is null) where year = 2013 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2013-12-01' and deleted is null) where year = 2013 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-01-01' and deleted is null) where year = 2013 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-02-01' and deleted is null) where year = 2014 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-03-01' and deleted is null) where year = 2014 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-04-01' and deleted is null) where year = 2014 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-05-01' and deleted is null) where year = 2014 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-06-01' and deleted is null) where year = 2014 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-07-01' and deleted is null) where year = 2014 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-08-01' and deleted is null) where year = 2014 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-09-01' and deleted is null) where year = 2014 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-10-01' and deleted is null) where year = 2014 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-11-01' and deleted is null) where year = 2014 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2014-12-01' and deleted is null) where year = 2014 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-01-01' and deleted is null) where year = 2014 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-02-01' and deleted is null) where year = 2015 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-03-01' and deleted is null) where year = 2015 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-04-01' and deleted is null) where year = 2015 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-05-01' and deleted is null) where year = 2015 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-06-01' and deleted is null) where year = 2015 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-07-01' and deleted is null) where year = 2015 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-08-01' and deleted is null) where year = 2015 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-09-01' and deleted is null) where year = 2015 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-10-01' and deleted is null) where year = 2015 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-11-01' and deleted is null) where year = 2015 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2015-12-01' and deleted is null) where year = 2015 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-01-01' and deleted is null) where year = 2015 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-02-01' and deleted is null) where year = 2016 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-03-01' and deleted is null) where year = 2016 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-04-01' and deleted is null) where year = 2016 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-05-01' and deleted is null) where year = 2016 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-06-01' and deleted is null) where year = 2016 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-07-01' and deleted is null) where year = 2016 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-08-01' and deleted is null) where year = 2016 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-09-01' and deleted is null) where year = 2016 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-10-01' and deleted is null) where year = 2016 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-11-01' and deleted is null) where year = 2016 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2016-12-01' and deleted is null) where year = 2016 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-01-01' and deleted is null) where year = 2016 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-02-01' and deleted is null) where year = 2017 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-03-01' and deleted is null) where year = 2017 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-04-01' and deleted is null) where year = 2017 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-05-01' and deleted is null) where year = 2017 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-06-01' and deleted is null) where year = 2017 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-07-01' and deleted is null) where year = 2017 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-08-01' and deleted is null) where year = 2017 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-09-01' and deleted is null) where year = 2017 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-10-01' and deleted is null) where year = 2017 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-11-01' and deleted is null) where year = 2017 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2017-12-01' and deleted is null) where year = 2017 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-01-01' and deleted is null) where year = 2017 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-02-01' and deleted is null) where year = 2018 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-03-01' and deleted is null) where year = 2018 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-04-01' and deleted is null) where year = 2018 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-05-01' and deleted is null) where year = 2018 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-06-01' and deleted is null) where year = 2018 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-07-01' and deleted is null) where year = 2018 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-08-01' and deleted is null) where year = 2018 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-09-01' and deleted is null) where year = 2018 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-10-01' and deleted is null) where year = 2018 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-11-01' and deleted is null) where year = 2018 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2018-12-01' and deleted is null) where year = 2018 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-01-01' and deleted is null) where year = 2018 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-02-01' and deleted is null) where year = 2019 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-03-01' and deleted is null) where year = 2019 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-04-01' and deleted is null) where year = 2019 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-05-01' and deleted is null) where year = 2019 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-06-01' and deleted is null) where year = 2019 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-07-01' and deleted is null) where year = 2019 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-08-01' and deleted is null) where year = 2019 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-09-01' and deleted is null) where year = 2019 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-10-01' and deleted is null) where year = 2019 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-11-01' and deleted is null) where year = 2019 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2019-12-01' and deleted is null) where year = 2019 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-01-01' and deleted is null) where year = 2019 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-02-01' and deleted is null) where year = 2020 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-03-01' and deleted is null) where year = 2020 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-04-01' and deleted is null) where year = 2020 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-05-01' and deleted is null) where year = 2020 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-06-01' and deleted is null) where year = 2020 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-07-01' and deleted is null) where year = 2020 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-08-01' and deleted is null) where year = 2020 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-09-01' and deleted is null) where year = 2020 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-10-01' and deleted is null) where year = 2020 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-11-01' and deleted is null) where year = 2020 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2020-12-01' and deleted is null) where year = 2020 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-01-01' and deleted is null) where year = 2020 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-02-01' and deleted is null) where year = 2021 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-03-01' and deleted is null) where year = 2021 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-04-01' and deleted is null) where year = 2021 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-05-01' and deleted is null) where year = 2021 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-06-01' and deleted is null) where year = 2021 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-07-01' and deleted is null) where year = 2021 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-08-01' and deleted is null) where year = 2021 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-09-01' and deleted is null) where year = 2021 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-10-01' and deleted is null) where year = 2021 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-11-01' and deleted is null) where year = 2021 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2021-12-01' and deleted is null) where year = 2021 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-01-01' and deleted is null) where year = 2021 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-02-01' and deleted is null) where year = 2022 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-03-01' and deleted is null) where year = 2022 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-04-01' and deleted is null) where year = 2022 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-05-01' and deleted is null) where year = 2022 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-06-01' and deleted is null) where year = 2022 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-07-01' and deleted is null) where year = 2022 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-08-01' and deleted is null) where year = 2022 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-09-01' and deleted is null) where year = 2022 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-10-01' and deleted is null) where year = 2022 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-11-01' and deleted is null) where year = 2022 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2022-12-01' and deleted is null) where year = 2022 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-01-01' and deleted is null) where year = 2022 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-02-01' and deleted is null) where year = 2023 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-03-01' and deleted is null) where year = 2023 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-04-01' and deleted is null) where year = 2023 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-05-01' and deleted is null) where year = 2023 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-06-01' and deleted is null) where year = 2023 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-07-01' and deleted is null) where year = 2023 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-08-01' and deleted is null) where year = 2023 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-09-01' and deleted is null) where year = 2023 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-10-01' and deleted is null) where year = 2023 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-11-01' and deleted is null) where year = 2023 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2023-12-01' and deleted is null) where year = 2023 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-01-01' and deleted is null) where year = 2023 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-02-01' and deleted is null) where year = 2024 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-03-01' and deleted is null) where year = 2024 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-04-01' and deleted is null) where year = 2024 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-05-01' and deleted is null) where year = 2024 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-06-01' and deleted is null) where year = 2024 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-07-01' and deleted is null) where year = 2024 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-08-01' and deleted is null) where year = 2024 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-09-01' and deleted is null) where year = 2024 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-10-01' and deleted is null) where year = 2024 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-11-01' and deleted is null) where year = 2024 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2024-12-01' and deleted is null) where year = 2024 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-01-01' and deleted is null) where year = 2024 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-02-01' and deleted is null) where year = 2025 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-03-01' and deleted is null) where year = 2025 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-04-01' and deleted is null) where year = 2025 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-05-01' and deleted is null) where year = 2025 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-06-01' and deleted is null) where year = 2025 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-07-01' and deleted is null) where year = 2025 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-08-01' and deleted is null) where year = 2025 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-09-01' and deleted is null) where year = 2025 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-10-01' and deleted is null) where year = 2025 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-11-01' and deleted is null) where year = 2025 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2025-12-01' and deleted is null) where year = 2025 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-01-01' and deleted is null) where year = 2025 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-02-01' and deleted is null) where year = 2026 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-03-01' and deleted is null) where year = 2026 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-04-01' and deleted is null) where year = 2026 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-05-01' and deleted is null) where year = 2026 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-06-01' and deleted is null) where year = 2026 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-07-01' and deleted is null) where year = 2026 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-08-01' and deleted is null) where year = 2026 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-09-01' and deleted is null) where year = 2026 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-10-01' and deleted is null) where year = 2026 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-11-01' and deleted is null) where year = 2026 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2026-12-01' and deleted is null) where year = 2026 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-01-01' and deleted is null) where year = 2026 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-02-01' and deleted is null) where year = 2027 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-03-01' and deleted is null) where year = 2027 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-04-01' and deleted is null) where year = 2027 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-05-01' and deleted is null) where year = 2027 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-06-01' and deleted is null) where year = 2027 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-07-01' and deleted is null) where year = 2027 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-08-01' and deleted is null) where year = 2027 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-09-01' and deleted is null) where year = 2027 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-10-01' and deleted is null) where year = 2027 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-11-01' and deleted is null) where year = 2027 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2027-12-01' and deleted is null) where year = 2027 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-01-01' and deleted is null) where year = 2027 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-02-01' and deleted is null) where year = 2028 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-03-01' and deleted is null) where year = 2028 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-04-01' and deleted is null) where year = 2028 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-05-01' and deleted is null) where year = 2028 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-06-01' and deleted is null) where year = 2028 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-07-01' and deleted is null) where year = 2028 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-08-01' and deleted is null) where year = 2028 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-09-01' and deleted is null) where year = 2028 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-10-01' and deleted is null) where year = 2028 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-11-01' and deleted is null) where year = 2028 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2028-12-01' and deleted is null) where year = 2028 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-01-01' and deleted is null) where year = 2028 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-02-01' and deleted is null) where year = 2029 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-03-01' and deleted is null) where year = 2029 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-04-01' and deleted is null) where year = 2029 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-05-01' and deleted is null) where year = 2029 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-06-01' and deleted is null) where year = 2029 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-07-01' and deleted is null) where year = 2029 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-08-01' and deleted is null) where year = 2029 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-09-01' and deleted is null) where year = 2029 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-10-01' and deleted is null) where year = 2029 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-11-01' and deleted is null) where year = 2029 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2029-12-01' and deleted is null) where year = 2029 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-01-01' and deleted is null) where year = 2029 and month = 12;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-02-01' and deleted is null) where year = 2030 and month = 01;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-03-01' and deleted is null) where year = 2030 and month = 02;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-04-01' and deleted is null) where year = 2030 and month = 03;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-05-01' and deleted is null) where year = 2030 and month = 04;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-06-01' and deleted is null) where year = 2030 and month = 05;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-07-01' and deleted is null) where year = 2030 and month = 06;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-08-01' and deleted is null) where year = 2030 and month = 07;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-09-01' and deleted is null) where year = 2030 and month = 08;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-10-01' and deleted is null) where year = 2030 and month = 09;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-11-01' and deleted is null) where year = 2030 and month = 10;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2030-12-01' and deleted is null) where year = 2030 and month = 11;
update stats_month_counts set accumulative = (select count(*) from raw_occurrence_record where created < '2031-01-01' and deleted is null) where year = 2030 and month = 12;

drop table if exists stats_tri_month_counts;

create table stats_tri_month_counts (tri char(100), count int(10));

insert into stats_tri_month_counts values ('dic 2012 - feb 2013', (select sum(count) from stats_month_counts where (year = 2012 and month = 12) or (year = 2013 and month = 01) or (year = 2013 and month = 02)));
insert into stats_tri_month_counts values ('mar 2013 - may 2013', (select sum(count) from stats_month_counts where (year = 2013 and month = 03) or (year = 2013 and month = 04) or (year = 2013 and month = 05)));
insert into stats_tri_month_counts values ('jun 2013 - ago 2013', (select sum(count) from stats_month_counts where (year = 2013 and month = 06) or (year = 2013 and month = 07) or (year = 2013 and month = 08)));
insert into stats_tri_month_counts values ('sep 2013 - nov 2013', (select sum(count) from stats_month_counts where (year = 2013 and month = 09) or (year = 2013 and month = 10) or (year = 2013 and month = 11)));
insert into stats_tri_month_counts values ('dic 2013 - feb 2014', (select sum(count) from stats_month_counts where (year = 2013 and month = 12) or (year = 2014 and month = 01) or (year = 2014 and month = 02)));
insert into stats_tri_month_counts values ('mar 2014 - may 2014', (select sum(count) from stats_month_counts where (year = 2014 and month = 03) or (year = 2014 and month = 04) or (year = 2014 and month = 05)));
insert into stats_tri_month_counts values ('jun 2014 - ago 2014', (select sum(count) from stats_month_counts where (year = 2014 and month = 06) or (year = 2014 and month = 07) or (year = 2014 and month = 08)));
insert into stats_tri_month_counts values ('sep 2014 - nov 2014', (select sum(count) from stats_month_counts where (year = 2014 and month = 09) or (year = 2014 and month = 10) or (year = 2014 and month = 11)));
insert into stats_tri_month_counts values ('dic 2014 - feb 2015', (select sum(count) from stats_month_counts where (year = 2014 and month = 12) or (year = 2015 and month = 01) or (year = 2015 and month = 02)));
insert into stats_tri_month_counts values ('mar 2015 - may 2015', (select sum(count) from stats_month_counts where (year = 2015 and month = 03) or (year = 2015 and month = 04) or (year = 2015 and month = 05)));
insert into stats_tri_month_counts values ('jun 2015 - ago 2015', (select sum(count) from stats_month_counts where (year = 2015 and month = 06) or (year = 2015 and month = 07) or (year = 2015 and month = 08)));
insert into stats_tri_month_counts values ('sep 2015 - nov 2015', (select sum(count) from stats_month_counts where (year = 2015 and month = 09) or (year = 2015 and month = 10) or (year = 2015 and month = 11)));
insert into stats_tri_month_counts values ('dic 2015 - feb 2016', (select sum(count) from stats_month_counts where (year = 2015 and month = 12) or (year = 2016 and month = 01) or (year = 2016 and month = 02)));
insert into stats_tri_month_counts values ('mar 2016 - may 2016', (select sum(count) from stats_month_counts where (year = 2016 and month = 03) or (year = 2016 and month = 04) or (year = 2016 and month = 05)));
insert into stats_tri_month_counts values ('jun 2016 - ago 2016', (select sum(count) from stats_month_counts where (year = 2016 and month = 06) or (year = 2016 and month = 07) or (year = 2016 and month = 08)));
insert into stats_tri_month_counts values ('sep 2016 - nov 2016', (select sum(count) from stats_month_counts where (year = 2016 and month = 09) or (year = 2016 and month = 10) or (year = 2016 and month = 11)));
insert into stats_tri_month_counts values ('dic 2016 - feb 2017', (select sum(count) from stats_month_counts where (year = 2016 and month = 12) or (year = 2017 and month = 01) or (year = 2017 and month = 02)));
insert into stats_tri_month_counts values ('mar 2017 - may 2017', (select sum(count) from stats_month_counts where (year = 2017 and month = 03) or (year = 2017 and month = 04) or (year = 2017 and month = 05)));
insert into stats_tri_month_counts values ('jun 2017 - ago 2017', (select sum(count) from stats_month_counts where (year = 2017 and month = 06) or (year = 2017 and month = 07) or (year = 2017 and month = 08)));
insert into stats_tri_month_counts values ('sep 2017 - nov 2017', (select sum(count) from stats_month_counts where (year = 2017 and month = 09) or (year = 2017 and month = 10) or (year = 2017 and month = 11)));
insert into stats_tri_month_counts values ('dic 2017 - feb 2018', (select sum(count) from stats_month_counts where (year = 2017 and month = 12) or (year = 2018 and month = 01) or (year = 2018 and month = 02)));
insert into stats_tri_month_counts values ('mar 2018 - may 2018', (select sum(count) from stats_month_counts where (year = 2018 and month = 03) or (year = 2018 and month = 04) or (year = 2018 and month = 05)));
insert into stats_tri_month_counts values ('jun 2018 - ago 2018', (select sum(count) from stats_month_counts where (year = 2018 and month = 06) or (year = 2018 and month = 07) or (year = 2018 and month = 08)));
insert into stats_tri_month_counts values ('sep 2018 - nov 2018', (select sum(count) from stats_month_counts where (year = 2018 and month = 09) or (year = 2018 and month = 10) or (year = 2018 and month = 11)));
insert into stats_tri_month_counts values ('dic 2018 - feb 2019', (select sum(count) from stats_month_counts where (year = 2018 and month = 12) or (year = 2019 and month = 01) or (year = 2019 and month = 02)));
insert into stats_tri_month_counts values ('mar 2019 - may 2019', (select sum(count) from stats_month_counts where (year = 2019 and month = 03) or (year = 2019 and month = 04) or (year = 2019 and month = 05)));
insert into stats_tri_month_counts values ('jun 2019 - ago 2019', (select sum(count) from stats_month_counts where (year = 2019 and month = 06) or (year = 2019 and month = 07) or (year = 2019 and month = 08)));
insert into stats_tri_month_counts values ('sep 2019 - nov 2019', (select sum(count) from stats_month_counts where (year = 2019 and month = 09) or (year = 2019 and month = 10) or (year = 2019 and month = 11)));
insert into stats_tri_month_counts values ('dic 2019 - feb 2020', (select sum(count) from stats_month_counts where (year = 2019 and month = 12) or (year = 2020 and month = 01) or (year = 2020 and month = 02)));
insert into stats_tri_month_counts values ('mar 2020 - may 2020', (select sum(count) from stats_month_counts where (year = 2020 and month = 03) or (year = 2020 and month = 04) or (year = 2020 and month = 05)));
insert into stats_tri_month_counts values ('jun 2020 - ago 2020', (select sum(count) from stats_month_counts where (year = 2020 and month = 06) or (year = 2020 and month = 07) or (year = 2020 and month = 08)));
insert into stats_tri_month_counts values ('sep 2020 - nov 2020', (select sum(count) from stats_month_counts where (year = 2020 and month = 09) or (year = 2020 and month = 10) or (year = 2020 and month = 11)));
insert into stats_tri_month_counts values ('dic 2020 - feb 2021', (select sum(count) from stats_month_counts where (year = 2020 and month = 12) or (year = 2021 and month = 01) or (year = 2021 and month = 02)));
insert into stats_tri_month_counts values ('mar 2021 - may 2021', (select sum(count) from stats_month_counts where (year = 2021 and month = 03) or (year = 2021 and month = 04) or (year = 2021 and month = 05)));
insert into stats_tri_month_counts values ('jun 2021 - ago 2021', (select sum(count) from stats_month_counts where (year = 2021 and month = 06) or (year = 2021 and month = 07) or (year = 2021 and month = 08)));
insert into stats_tri_month_counts values ('sep 2021 - nov 2021', (select sum(count) from stats_month_counts where (year = 2021 and month = 09) or (year = 2021 and month = 10) or (year = 2021 and month = 11)));
insert into stats_tri_month_counts values ('dic 2021 - feb 2022', (select sum(count) from stats_month_counts where (year = 2021 and month = 12) or (year = 2022 and month = 01) or (year = 2022 and month = 02)));
insert into stats_tri_month_counts values ('mar 2022 - may 2022', (select sum(count) from stats_month_counts where (year = 2022 and month = 03) or (year = 2022 and month = 04) or (year = 2022 and month = 05)));
insert into stats_tri_month_counts values ('jun 2022 - ago 2022', (select sum(count) from stats_month_counts where (year = 2022 and month = 06) or (year = 2022 and month = 07) or (year = 2022 and month = 08)));
insert into stats_tri_month_counts values ('sep 2022 - nov 2022', (select sum(count) from stats_month_counts where (year = 2022 and month = 09) or (year = 2022 and month = 10) or (year = 2022 and month = 11)));
insert into stats_tri_month_counts values ('dic 2022 - feb 2023', (select sum(count) from stats_month_counts where (year = 2022 and month = 12) or (year = 2023 and month = 01) or (year = 2023 and month = 02)));
insert into stats_tri_month_counts values ('mar 2023 - may 2023', (select sum(count) from stats_month_counts where (year = 2023 and month = 03) or (year = 2023 and month = 04) or (year = 2023 and month = 05)));
insert into stats_tri_month_counts values ('jun 2023 - ago 2023', (select sum(count) from stats_month_counts where (year = 2023 and month = 06) or (year = 2023 and month = 07) or (year = 2023 and month = 08)));
insert into stats_tri_month_counts values ('sep 2023 - nov 2023', (select sum(count) from stats_month_counts where (year = 2023 and month = 09) or (year = 2023 and month = 10) or (year = 2023 and month = 11)));
insert into stats_tri_month_counts values ('dic 2023 - feb 2024', (select sum(count) from stats_month_counts where (year = 2023 and month = 12) or (year = 2024 and month = 01) or (year = 2024 and month = 02)));
insert into stats_tri_month_counts values ('mar 2024 - may 2024', (select sum(count) from stats_month_counts where (year = 2024 and month = 03) or (year = 2024 and month = 04) or (year = 2024 and month = 05)));
insert into stats_tri_month_counts values ('jun 2024 - ago 2024', (select sum(count) from stats_month_counts where (year = 2024 and month = 06) or (year = 2024 and month = 07) or (year = 2024 and month = 08)));
insert into stats_tri_month_counts values ('sep 2024 - nov 2024', (select sum(count) from stats_month_counts where (year = 2024 and month = 09) or (year = 2024 and month = 10) or (year = 2024 and month = 11)));
insert into stats_tri_month_counts values ('dic 2024 - feb 2025', (select sum(count) from stats_month_counts where (year = 2024 and month = 12) or (year = 2025 and month = 01) or (year = 2025 and month = 02)));
insert into stats_tri_month_counts values ('mar 2025 - may 2025', (select sum(count) from stats_month_counts where (year = 2025 and month = 03) or (year = 2025 and month = 04) or (year = 2025 and month = 05)));
insert into stats_tri_month_counts values ('jun 2025 - ago 2025', (select sum(count) from stats_month_counts where (year = 2025 and month = 06) or (year = 2025 and month = 07) or (year = 2025 and month = 08)));
insert into stats_tri_month_counts values ('sep 2025 - nov 2025', (select sum(count) from stats_month_counts where (year = 2025 and month = 09) or (year = 2025 and month = 10) or (year = 2025 and month = 11)));
insert into stats_tri_month_counts values ('dic 2025 - feb 2026', (select sum(count) from stats_month_counts where (year = 2025 and month = 12) or (year = 2026 and month = 01) or (year = 2026 and month = 02)));
insert into stats_tri_month_counts values ('mar 2026 - may 2026', (select sum(count) from stats_month_counts where (year = 2026 and month = 03) or (year = 2026 and month = 04) or (year = 2026 and month = 05)));
insert into stats_tri_month_counts values ('jun 2026 - ago 2026', (select sum(count) from stats_month_counts where (year = 2026 and month = 06) or (year = 2026 and month = 07) or (year = 2026 and month = 08)));
insert into stats_tri_month_counts values ('sep 2026 - nov 2026', (select sum(count) from stats_month_counts where (year = 2026 and month = 09) or (year = 2026 and month = 10) or (year = 2026 and month = 11)));
insert into stats_tri_month_counts values ('dic 2026 - feb 2027', (select sum(count) from stats_month_counts where (year = 2026 and month = 12) or (year = 2027 and month = 01) or (year = 2027 and month = 02)));
insert into stats_tri_month_counts values ('mar 2027 - may 2027', (select sum(count) from stats_month_counts where (year = 2027 and month = 03) or (year = 2027 and month = 04) or (year = 2027 and month = 05)));
insert into stats_tri_month_counts values ('jun 2027 - ago 2027', (select sum(count) from stats_month_counts where (year = 2027 and month = 06) or (year = 2027 and month = 07) or (year = 2027 and month = 08)));
insert into stats_tri_month_counts values ('sep 2027 - nov 2027', (select sum(count) from stats_month_counts where (year = 2027 and month = 09) or (year = 2027 and month = 10) or (year = 2027 and month = 11)));
insert into stats_tri_month_counts values ('dic 2027 - feb 2028', (select sum(count) from stats_month_counts where (year = 2027 and month = 12) or (year = 2028 and month = 01) or (year = 2028 and month = 02)));
insert into stats_tri_month_counts values ('mar 2028 - may 2028', (select sum(count) from stats_month_counts where (year = 2028 and month = 03) or (year = 2028 and month = 04) or (year = 2028 and month = 05)));
insert into stats_tri_month_counts values ('jun 2028 - ago 2028', (select sum(count) from stats_month_counts where (year = 2028 and month = 06) or (year = 2028 and month = 07) or (year = 2028 and month = 08)));
insert into stats_tri_month_counts values ('sep 2028 - nov 2028', (select sum(count) from stats_month_counts where (year = 2028 and month = 09) or (year = 2028 and month = 10) or (year = 2028 and month = 11)));
insert into stats_tri_month_counts values ('dic 2028 - feb 2029', (select sum(count) from stats_month_counts where (year = 2028 and month = 12) or (year = 2029 and month = 01) or (year = 2029 and month = 02)));
insert into stats_tri_month_counts values ('mar 2029 - may 2029', (select sum(count) from stats_month_counts where (year = 2029 and month = 03) or (year = 2029 and month = 04) or (year = 2029 and month = 05)));
insert into stats_tri_month_counts values ('jun 2029 - ago 2029', (select sum(count) from stats_month_counts where (year = 2029 and month = 06) or (year = 2029 and month = 07) or (year = 2029 and month = 08)));
insert into stats_tri_month_counts values ('sep 2029 - nov 2029', (select sum(count) from stats_month_counts where (year = 2029 and month = 09) or (year = 2029 and month = 10) or (year = 2029 and month = 11)));
insert into stats_tri_month_counts values ('dic 2029 - feb 2030', (select sum(count) from stats_month_counts where (year = 2029 and month = 12) or (year = 2030 and month = 01) or (year = 2030 and month = 02)));
insert into stats_tri_month_counts values ('mar 2030 - may 2030', (select sum(count) from stats_month_counts where (year = 2030 and month = 03) or (year = 2030 and month = 04) or (year = 2030 and month = 05)));
insert into stats_tri_month_counts values ('jun 2030 - ago 2030', (select sum(count) from stats_month_counts where (year = 2030 and month = 06) or (year = 2030 and month = 07) or (year = 2030 and month = 08)));
insert into stats_tri_month_counts values ('sep 2030 - nov 2030', (select sum(count) from stats_month_counts where (year = 2030 and month = 09) or (year = 2030 and month = 10) or (year = 2030 and month = 11)));

-- set with_records in taxon_name
-- this is use in the advance search because we need to show only taxon names with occurrence record

update taxon_name set with_records = 1 where taxon_name.id in (select taxon_name_id from taxon_concept where id in(SELECT taxon_concept_id FROM portal.occurrence_record));
update taxon_name set with_records = 1 where taxon_name.id in (select taxon_name_id from taxon_concept where id in(SELECT kingdom_concept_id FROM portal.occurrence_record));
update taxon_name set with_records = 1 where taxon_name.id in (select taxon_name_id from taxon_concept where id in(SELECT phylum_concept_id FROM portal.occurrence_record));
update taxon_name set with_records = 1 where taxon_name.id in (select taxon_name_id from taxon_concept where id in(SELECT class_concept_id FROM portal.occurrence_record));
update taxon_name set with_records = 1 where taxon_name.id in (select taxon_name_id from taxon_concept where id in(SELECT order_concept_id FROM portal.occurrence_record));
update taxon_name set with_records = 1 where taxon_name.id in (select taxon_name_id from taxon_concept where id in(SELECT family_concept_id FROM portal.occurrence_record));
update taxon_name set with_records = 1 where taxon_name.id in (select taxon_name_id from taxon_concept where id in(SELECT genus_concept_id FROM portal.occurrence_record));
update taxon_name set with_records = 1 where taxon_name.id in (select taxon_name_id from taxon_concept where id in(SELECT species_concept_id FROM portal.occurrence_record));
update taxon_name set with_records = 1 where taxon_name.id in (select taxon_name_id from taxon_concept where id in(SELECT nub_concept_id FROM portal.occurrence_record));

update data_resource dr set modified= (select max(r.created)  
from raw_occurrence_record r
where dr.id=r.data_resource_id and r.deleted is null);

update data_provider dp set modified= (select max(r.created)  
from raw_occurrence_record r
where dp.id=r.data_provider_id and r.deleted is null);

-- End of SiB Colombia addition

-- temporal range - temporal range for this dataset
-- Query OK, 2083 rows affected, 1200 warnings (2 min 24.52 sec)
-- Records: 2083  Duplicates: 0  Warnings: 1200
-- (NULL values in non-null column start-date)
-- select concat('Starting temporal_coverage_tag generation: ', now()) as debug;
-- delete from temporal_coverage_tag where tag_id=4120;
-- insert into temporal_coverage_tag (tag_id, entity_id, start_date, end_date, is_system_generated)
-- select 4120, data_resource_id, min(occurrence_date), max(occurrence_date), true 
-- from occurrence_record 
-- group by data_resource_id;
-- remove null or erroneous entries
-- delete from temporal_coverage_tag where start_date = '0000-00-00';
-- delete from temporal_coverage_tag where start_date < '1700-01-01';

-- bounding box - a bounding box for this dataset
-- Query OK, 2083 rows affected (2 min 31.25 sec)
-- Records: 2083  Duplicates: 0  Warnings: 0
select concat('Starting geographical_coverage_tag (bounding box) generation: ', now()) as debug;
delete from geographical_coverage_tag where tag_id=4101;
insert into geographical_coverage_tag (tag_id, entity_id, min_longitude, min_latitude, max_longitude, max_latitude,is_system_generated)
select 4101, data_resource_id, min(longitude), min(latitude), max(longitude), max(latitude), true 
from occurrence_record 
group by data_resource_id;
-- remove null entries
delete from geographical_coverage_tag where min_longitude is null;

-- taxonomic coverage for a resource by family, genus and species
-- Query OK, 3288465 rows affected (3 min 46.58 sec)
-- Records: 3288465  Duplicates: 0  Warnings: 0
select concat('Starting bi_relation_tag - species coverage generation: ', now()) as debug;
delete from bi_relation_tag where tag_id=4140;
insert into bi_relation_tag (tag_id, from_entity_id, to_entity_id, count, is_system_generated)
select 4140, data_resource_id, species_concept_id, count(id), true
from occurrence_record oc
where species_concept_id is not null
group by data_resource_id, species_concept_id;

-- Query OK, 932714 rows affected (5 min 8.92 sec)
-- Records: 932714  Duplicates: 0  Warnings: 0
select concat('Starting bi_relation_tag - genera coverage generation: ', now()) as debug;
delete from bi_relation_tag where tag_id=4141;
insert into bi_relation_tag (tag_id, from_entity_id, to_entity_id, count, is_system_generated)
select 4141, data_resource_id, genus_concept_id, count(id), true
from occurrence_record oc
where genus_concept_id is not null
group by data_resource_id, genus_concept_id;

-- Query OK, 190419 rows affected (3 min 30.31 sec)
-- Records: 190419  Duplicates: 0  Warnings: 0
select concat('Starting bi_relation_tag - family coverage generation: ', now()) as debug;
delete from number_tag where tag_id=4142;
insert into bi_relation_tag (tag_id, from_entity_id, to_entity_id, count, is_system_generated)
select 4142, data_resource_id, family_concept_id, count(id), true
from occurrence_record oc
where family_concept_id is not null
group by data_resource_id, family_concept_id;

-- contains type status
-- Query OK, 234 rows affected (1.75 sec)
-- Records: 234  Duplicates: 0  Warnings: 0
select concat('Starting number_tag - typification_record count: ', now()) as debug;
delete from number_tag where tag_id=4160;
insert into number_tag (entity_id, tag_id, value, is_system_generated)
select data_resource_id,4160,count(data_resource_id),true from typification_record group by data_resource_id;

-- month tags
-- Query OK, 10048 rows affected (1 min 21.41 sec)
-- Records: 10048  Duplicates: 0  Warnings: 0
select concat('Starting number_tag - occurrences by month: ', now()) as debug;
delete from number_tag where tag_id=4121;
insert into number_tag (value, entity_id, tag_id, is_system_generated)
select distinct month, data_resource_id, 4121, true from occurrence_record 
where month is not null
group by month, data_resource_id 
order by month, data_resource_id;


-- ***********************************
-- quad relation table starts here...
-- in case of re-run, remove line "insert into rollover..."!
-- ***********************************

-- host country x country x kingdoms x basis of record (25 mins to generate on 6GB machine, 120m DB)
-- Query OK, 20732 rows affected (12 min 12.44 sec)
-- Records: 20732  Duplicates: 0  Warnings: 0
select concat('Starting country x country x kingdoms x basis of record tags: ', now()) as debug;
create table temp_hc_c_k_bor 
select dp.iso_country_code host, o.iso_country_code country, o.kingdom_concept_id, o.basis_of_record, count(*) as hc_count, 0 as rollover_id 
from data_provider dp left outer join occurrence_record o on o.data_provider_id=dp.id group by 4,3,2,1 order by 1,2,3,4;

-- handle erroneus UK / GB iso country codes
update temp_hc_c_k_bor set host='GB' where host='UK';

-- add the rollover date to this table
-- Query OK, 20732 rows affected (0.05 sec)
-- Rows matched: 20732  Changed: 20732  Warnings: 0
insert into rollover (rollover_date) values (now());
update temp_hc_c_k_bor t set t.rollover_id  = (select max(r.id) from rollover r);

-- delete the unknown countries, since the UI has a bug that will be fixed in a future release
delete from quad_relation_tag where entity2_id=0 and tag_id=2001;

-- insert tags in quadnomial_tag
-- Query OK, 20732 rows affected (1.34 sec)
-- Records: 20732  Duplicates: 0  Warnings: 0
insert into quad_relation_tag (tag_id, entity1_id, entity2_id, entity3_id, entity4_id, count, rollover_id)
select 2001, hc.id, co.id, kingdom_concept_id, basis_of_record, hc_count, rollover_id
from temp_hc_c_k_bor
left outer join country hc on temp_hc_c_k_bor.host = hc.iso_country_code
left outer join country co on temp_hc_c_k_bor.country = co.iso_country_code;

-- set to 0 where entity_id is null
-- Query OK, 1613 rows affected (0.05 sec)
-- Rows matched: 1613  Changed: 1613  Warnings: 0
update quad_relation_tag set entity1_id=0 where entity1_id is null and tag_id=2001; show warnings;
-- Query OK, 399 rows affected (0.02 sec)
-- Rows matched: 399  Changed: 399  Warnings: 0
update quad_relation_tag set entity2_id=0 where entity2_id is null and tag_id=2001; show warnings;
-- assign tags with null kingdom ids to unknown kingdom
-- Query OK, 3967 rows affected (0.01 sec)
-- Rows matched: 3967  Changed: 3967  Warnings: 0
update quad_relation_tag set entity3_id=14719007 where entity3_id is null; show warnings;
drop table temp_hc_c_k_bor;

-- ***********************************
-- ..... end of quad relation table
-- ***********************************

-- add statistics for counts per country
INSERT INTO stats_country_contribution (
rollover_id, iso_country_code, provider_count, dataset_count, occurrence_count, occurrence_georeferenced_count, created)
SELECT 
(select max(r.id) from rollover r), dp.iso_country_code, count(distinct dp.id), count(distinct dr.id), sum(dr.occurrence_count), sum(dr.occurrence_coordinate_count), now()
from data_provider dp
left join data_resource dr on dp.id = dr.data_provider_id
where dr.deleted is null and dp.deleted is null and dp.id > 3
group by 2;

-- add statistics for counts per participant node
INSERT INTO stats_participant_contribution (
rollover_id, gbif_approver, provider_count, dataset_count, occurrence_count, occurrence_georeferenced_count, created)
SELECT 
(select max(r.id) from rollover r), dp.gbif_approver, count(distinct dp.id), count(distinct dr.id), sum(dr.occurrence_count), sum(dr.occurrence_coordinate_count), now()
from data_provider dp
left join data_resource dr on dp.id = dr.data_provider_id
where dr.deleted is null and dp.deleted is null and dp.id > 3
group by 2;

-- ********************************************
-- generate stats for the communications portal
-- ********************************************

-- populate temporary table to assign unique keys to each of the participant nodes available
-- truncate table temp_participant_nodes;
-- insert into temp_participant_nodes(node_name)
-- select distinct(data_provider.gbif_approver) from data_provider where data_provider.gbif_approver!='NULL';

-- save stats for the communication portal. Files will be residing on the /tmp/ folder on the machine running process.sql 

-- select * from temp_participant_nodes into outfile '/tmp/comm_nodes.txt';
-- select dp.id,tpn.id,dp.name, dp.iso_country_code from data_provider dp inner join temp_participant_nodes tpn on dp.gbif_approver = tpn.node_name where dp.deleted is null into outfile '/tmp/comm_dataprovider.txt';
-- select dr.id, dp.id, dr.name, dr.occurrence_count, dr.occurrence_coordinate_count from data_resource dr inner join data_provider dp on dr.data_provider_id=dp.id where dp.deleted is null and dr.deleted is null into outfile '/tmp/comm_dataresource.txt';

-- ********************************************
-- ... end of comms portal stats
-- ********************************************

-- fix non-kingdoms - 
-- first need to  check if parent_concept_id=14719007 is the UNKNOWN kingdom in data_resource=1:
select tc.id from taxon_concept tc join taxon_name tn on tc.taxon_name_id=tn.id where tn.canonical='UNKNOWN' and tn.rank=1000 and tc.data_resource_id = 1;

--  careful: this might need id-fixing after nub rebuilding!
update taxon_concept set parent_concept_id=14719007 where 
parent_concept_id is null and 
rank>1000 and 
data_resource_id=1 and
is_accepted=1;

-- make sure all iso country codes are uppercase
update data_provider set iso_country_code=upper(iso_country_code);


select concat('Rollover complete: ', now()) as debug;

-- to eliminate possiblity of infinites loops in the taxonomy
-- ! this already needs to run before doing the taxon processing! --

-- ********************************************
-- update taxon_concept c
-- inner join taxon_concept p on c.parent_concept_id=p.id
-- set c.parent_concept_id=null
-- where p.rank>=c.rank; 
-- ********************************************


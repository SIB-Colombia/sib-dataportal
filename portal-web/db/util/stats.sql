--stats_taxon_concept_counts
drop table if exists stats_taxon_concept_counts;
create table stats_taxon_concept_counts(taxon_name varchar(255), count INT(10));
insert into stats_taxon_concept_counts
SELECT 'Chromistas', count(*) FROM occurrence_record where kingdom_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM taxon_name where canonical like 'Chromista') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Protozoos', count(*) FROM occurrence_record where kingdom_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Protozoa') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Plantas', count(*) FROM occurrence_record where kingdom_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Plantae') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Hongos', count(*) FROM occurrence_record where kingdom_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Fungi') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Animales', count(*) FROM occurrence_record where kingdom_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Animalia') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Moluscos', count(*) FROM occurrence_record where phylum_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Mollusca') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Anfibios', count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Amphibia') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Reptiles', count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Reptilia') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Mamíferos', count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Mammalia') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Aves', count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Aves') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Arácnidos', count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Arachnida') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Insectos', count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Insecta') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT 'Peces óseos', SUM(T1.total) FROM(
SELECT count(*) total FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Actinopterygii') and data_provider_id = 1 and data_resource_id = 1) union all
SELECT count(*) FROM occurrence_record where class_concept_id in (SELECT id FROM taxon_concept where taxon_name_id in (SELECT id FROM portal.taxon_name where canonical like 'Sarcopterygii') and data_provider_id = 1 and data_resource_id = 1)) T1;

--stats_provider_type_species_counts
drop table if exists stats_provider_type_species_counts;
create table stats_provider_type_species_counts(provider_type varchar(255), count INT(10));
insert into stats_provider_type_species_counts
SELECT 'Autoridad ambiental', count(distinct species_concept_id) FROM occurrence_record where data_provider_id in (SELECT id FROM portal.data_provider where type like 'Autoridad ambiental') and deleted is null union all
SELECT 'Empresa privada', count(distinct species_concept_id) FROM occurrence_record where data_provider_id in (SELECT id FROM portal.data_provider where type like 'Empresa privada') and deleted is null union all
SELECT 'Instituto de investigación', count(distinct species_concept_id) FROM occurrence_record where data_provider_id in (SELECT id FROM portal.data_provider where type like 'Instituto de investigación') and deleted is null union all
SELECT 'ONG', count(distinct species_concept_id) FROM occurrence_record where data_provider_id in (SELECT id FROM portal.data_provider where type like 'ONG') and deleted is null union all
SELECT 'Red temática/regional', count(distinct species_concept_id) FROM occurrence_record where data_provider_id in (SELECT id FROM portal.data_provider where type like 'Red temática/regional') and deleted is null union all
SELECT 'Repatriados', count(distinct species_concept_id) FROM occurrence_record where data_provider_id in (SELECT id FROM portal.data_provider where type like 'Repatriados') and deleted is null union all
SELECT 'Universidad', count(distinct species_concept_id) FROM occurrence_record where data_provider_id in (SELECT id FROM portal.data_provider where type like 'Universidad') and deleted is null;

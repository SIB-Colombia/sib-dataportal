insert into taxon_concept(rank,taxon_name_id,data_provider_id,data_resource_id,parent_concept_id,
kingdom_concept_id,phylum_concept_id,class_concept_id,order_concept_id,family_concept_id,genus_concept_id,species_concept_id,
is_accepted,is_nub_concept,partner_concept_id,priority,is_secondary,created,modified) select rank,taxon_name_id,1,1,parent_concept_id,
kingdom_concept_id,phylum_concept_id,class_concept_id,order_concept_id,family_concept_id,genus_concept_id,species_concept_id,
is_accepted,1,partner_concept_id,priority,is_secondary,curdate(),curdate() 
from portal.taxon_concept 
where partner_concept_id is null 
and taxon_name_id not in (select taxon_name_id from portal.taxon_concept where data_provider_id =1);
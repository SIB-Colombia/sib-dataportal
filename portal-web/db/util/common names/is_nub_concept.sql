update taxon_concept set is_nub_concept = 1 where data_provider_id = 1 and data_resource_id = 1 and is_nub_concept = 0;
update taxon_concept set is_nub_concept = 0 where data_provider_id != 1 and data_resource_id != 1 and is_nub_concept = 1;
delete from common_name_taxon_concept;
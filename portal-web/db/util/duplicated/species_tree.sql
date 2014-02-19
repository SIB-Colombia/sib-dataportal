DROP PROCEDURE IF EXISTS species_tree;

DELIMITER //

CREATE PROCEDURE species_tree ()
	BLOCK1: begin
		DECLARE taxonNameId INT(10);
		DECLARE taxonId INT(10);
		DECLARE no_more_rows1 BOOL;
		DECLARE cursor1 CURSOR FOR SELECT id, taxon_name_id FROM portal.taxon_concept where kingdom_concept_id is null and phylum_concept_id is null and class_concept_id is null and species_concept_id is not null and data_provider_id = 1 and data_resource_id = 1;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows1 := TRUE;

		SET no_more_rows1 := FALSE;
	
		OPEN cursor1;
		LOOP1: loop
			fetch cursor1 INTO taxonId, taxonNameId;
			if no_more_rows1 THEN
				close cursor1;
				leave LOOP1;
			end if;
			BLOCK2: begin
				DECLARE no_more_rows2 BOOL;
				DECLARE kingdom INT(10);
				DECLARE phylum INT(10);
				DECLARE class INT(10);
				DECLARE orderConcept INT(10);
				DECLARE family INT(10);
				DECLARE genus INT(10);
				DECLARE cursor2 CURSOR FOR SELECT  kingdom_concept_id,phylum_concept_id,class_concept_id,order_concept_id,family_concept_id,genus_concept_id FROM taxon_concept WHERE taxon_name_id = taxonNameId and data_provider_id != 1 and data_resource_id != 1 order by id desc;
				DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows2 := TRUE;

				SET no_more_rows2 := FALSE;
				OPEN cursor2;
				LOOP2: loop
					fetch cursor2 INTO kingdom, phylum, class, orderConcept, family, genus;
					if no_more_rows2 THEN
						close cursor2;
						leave LOOP2;
					end if;
						UPDATE taxon_concept SET kingdom_concept_id = kingdom, phylum_concept_id= phylum, class_concept_id = class, order_concept_id = orderConcept, family_concept_id = family,genus_concept_id= genus WHERE id = taxonId;
					end loop LOOP2;
			end BLOCK2;
		end loop LOOP1;
	end BLOCK1
//
DELIMITER ;
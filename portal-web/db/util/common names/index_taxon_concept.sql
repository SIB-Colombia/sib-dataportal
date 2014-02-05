DROP PROCEDURE IF EXISTS index_taxon_concept;

DELIMITER //

CREATE PROCEDURE index_taxon_concept ()
BLOCK1: BEGIN
	declare concept_id int(10);
	declare name_id int(10);
	declare no_more_rows1 BOOL;
	declare cursor1 CURSOR FOR SELECT taxon_concept.id,taxon_name_id FROM portal.taxon_concept WHERE partner_concept_id IS NULL AND taxon_name_id IN ((select taxon_name_id from portal.taxon_concept where data_provider_id =1));
	declare continue handler FOR NOT FOUND SET no_more_rows1 := TRUE;
	SET no_more_rows1 := FALSE;
	OPEN cursor1;
	LOOP1:LOOP
		FETCH cursor1 into concept_id, name_id;
		if no_more_rows1 THEN
		close cursor1;
		leave LOOP1;
		end if;
		BLOCK2: begin
			DECLARE no_more_rows2 BOOL;
			declare concept_id_partner int(10);
			declare cursor2 CURSOR FOR SELECT taxon_concept.id FROM portal.taxon_concept WHERE taxon_name_id = name_id AND data_provider_id = 1;
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows2 := TRUE;
			SET no_more_rows2 := FALSE;
			OPEN cursor2;
				LOOP2: loop
						fetch cursor2 INTO concept_id_partner;
						if no_more_rows2 THEN
							close cursor2;
							leave LOOP2;
						end if;
						UPDATE portal.taxon_concept SET partner_concept_id = concept_id_partner WHERE id = concept_id;
				end loop LOOP2;
		end BLOCK2;
	end loop LOOP1;
end BLOCK1
//
DELIMITER ;
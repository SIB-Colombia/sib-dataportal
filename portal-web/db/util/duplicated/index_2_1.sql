DROP PROCEDURE IF EXISTS index_2_1;

DELIMITER //

CREATE PROCEDURE index_2_1 ()
	BLOCK1: begin
		DECLARE taxonName INT(10);
		DECLARE idFalta INT(10);
		DECLARE no_more_rows1 BOOL;
		DECLARE cursor1 CURSOR FOR SELECT id, taxon_name FROM index_taxon;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows1 := TRUE;

		SET no_more_rows1 := FALSE;
	
		OPEN cursor1;
		LOOP1: loop
			fetch cursor1 INTO idFalta,taxonName;
			if no_more_rows1 THEN
				close cursor1;
				leave LOOP1;
			end if;
			BLOCK2: begin
				DECLARE no_more_rows2 BOOL;
				DECLARE partnerConceptId INT(10);
				DECLARE cursor2 CURSOR FOR SELECT id FROM taxon_concept WHERE taxon_name_id = taxonName and data_provider_id = 1 and data_resource_id = 1 order by id desc;
				DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows2 := TRUE;

				SET no_more_rows2 := FALSE;
				OPEN cursor2;
				LOOP2: loop
					fetch cursor2 INTO partnerConceptId;
					if no_more_rows2 THEN
						close cursor2;
						leave LOOP2;
					end if;
						UPDATE index_taxon SET partner_concept_id = partnerConceptId WHERE id = idFalta;
					end loop LOOP2;
			end BLOCK2;
		end loop LOOP1;
	end BLOCK1
//
DELIMITER ;
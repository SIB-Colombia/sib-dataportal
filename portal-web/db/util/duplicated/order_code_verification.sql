DROP PROCEDURE IF EXISTS order_code_verification;

DELIMITER //

CREATE PROCEDURE order_code_verification ()
	BLOCK1: begin
		DECLARE taxonNameId INT(10);
		DECLARE taxonId INT(10);
		DECLARE no_more_rows1 BOOL;
		DECLARE cursor1 CURSOR FOR SELECT id, taxon_name_id FROM portal.taxon_concept where order_concept_id not in (SELECT id FROM portal.taxon_concept);
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
				DECLARE orderConcept INT(10);
				DECLARE cursor2 CURSOR FOR SELECT order_concept_id FROM portal.taxon_concept where taxon_name_id  = taxonNameId and id != taxonId;
				DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows2 := TRUE;

				SET no_more_rows2 := FALSE;
				OPEN cursor2;
				fetch cursor2 INTO orderConcept;
				UPDATE taxon_concept SET order_concept_id = orderConcept WHERE id = taxonId;

			end BLOCK2;
		end loop LOOP1;
	end BLOCK1
//
DELIMITER ;
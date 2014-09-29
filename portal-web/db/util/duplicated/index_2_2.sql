DROP PROCEDURE IF EXISTS index_2_2;

DELIMITER //

CREATE PROCEDURE index_2_2 ()
	BLOCK1: begin
		DECLARE partnerConceptId INT(10);
		DECLARE idFalta INT(10);
		DECLARE no_more_rows1 BOOL;
		DECLARE cursor1 CURSOR FOR SELECT id, partner_concept_id FROM index_taxon;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows1 := TRUE;

		SET no_more_rows1 := FALSE;
	
		OPEN cursor1;
		LOOP1: loop
			fetch cursor1 INTO idFalta,partnerConceptId;
			if no_more_rows1 THEN
				close cursor1;
				leave LOOP1;
			end if;
				UPDATE taxon_concept SET partner_concept_id = partnerConceptId WHERE id = idFalta;
		end loop LOOP1;
	end BLOCK1
//
DELIMITER ;
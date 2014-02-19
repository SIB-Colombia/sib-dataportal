DROP PROCEDURE IF EXISTS index_2_1_1;

DELIMITER //

CREATE PROCEDURE index_2_1_1()
	BLOCK1: begin
		DECLARE taxonName INT(10);
		DECLARE idFalta INT(10);
		DECLARE no_more_rows1 BOOL;
		DECLARE cursor1 CURSOR FOR SELECT id, taxon_name FROM index_taxon where partner_concept_id is null;
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
				DECLARE cursor2 CURSOR FOR select partner_concept_id from taxon_concept where taxon_name_id in (select id from taxon_name where canonical in (select canonical from taxon_name where id = taxonName) and id != taxonName);
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
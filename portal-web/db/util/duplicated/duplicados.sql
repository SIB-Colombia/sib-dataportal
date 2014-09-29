DROP PROCEDURE IF EXISTS duplicados;

DELIMITER //

CREATE PROCEDURE duplicados()
	BLOCK1: begin
		DECLARE taxonName INT(10);
		DECLARE rep INT(10);
		DECLARE no_more_rows1 BOOL;
		DECLARE cursor1 CURSOR FOR SELECT t.taxon_name_id, count(*) AS count FROM taxon_concept AS t WHERE t.data_provider_id = 1 and data_resource_id = 1 and t.is_nub_concept = 1 group by t.taxon_name_id having count > 1 order by t.id;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows1 := TRUE;
		SET no_more_rows1 := FALSE;
		
		OPEN cursor1;
			LOOP1: loop
				FETCH cursor1 INTO taxonName, rep;
				if no_more_rows1 THEN
					close cursor1;
					leave LOOP1;
				end if;
				
				BLOCK2: begin
					DECLARE taxonConcept INT(10);
					DECLARE ret INT(10);
					DECLARE cursor2 CURSOR FOR SELECT t.id FROM taxon_concept AS t WHERE t.is_nub_concept = 1 and t.taxon_name_id = taxonName order by t.id desc;
					SET ret := rep;
					
					OPEN cursor2;
					LOOP2: loop
						FETCH cursor2 INTO taxonConcept;
						if ret > 2 THEN 
							SET ret := ret - 1;
							DELETE FROM taxon_concept WHERE id = taxonConcept;
						else 
							DELETE FROM taxon_concept WHERE id = taxonConcept;
							close cursor2;
							leave LOOP2;
						end if;
					end loop LOOP2;
				end BLOCK2;
			end loop LOOP1;
	end BLOCK1
//
DELIMITER ;
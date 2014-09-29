DROP PROCEDURE IF EXISTS index_2;

DELIMITER //

CREATE PROCEDURE index_2 ()
BLOCK1: BEGIN
	declare partnerConcept int(10);
	declare idFalta int(10);
	declare nameId int(10);
	declare no_more_rows1 BOOL;
	declare cursor1 CURSOR FOR SELECT id, taxon_name_id, partner_concept_id FROM taxon_concept where partner_concept_id is not null;
	declare continue handler FOR NOT FOUND SET no_more_rows1 := TRUE;
	SET no_more_rows1 := FALSE;
	OPEN cursor1;
	LOOP1:LOOP
		FETCH cursor1 into idFalta,nameId,partnerConcept;
		if no_more_rows1 THEN
		close cursor1;
		leave LOOP1;
		end if;
		BLOCK2: begin
			DECLARE no_more_rows2 BOOL;
			declare veces int(10);
			declare cursor2 CURSOR FOR SELECT count(*) FROM taxon_concept WHERE id = partnerConcept;
			DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows2 := TRUE;
			SET no_more_rows2 := FALSE;
			OPEN cursor2;
				LOOP2: loop
						fetch cursor2 INTO veces;
						if no_more_rows2 THEN
							close cursor2;
							leave LOOP2;
						end if;
						if (veces<1) then
							insert into index_taxon(id, taxon_name) values (idFalta,nameId);
						end if;
				end loop LOOP2;
		end BLOCK2;
	end loop LOOP1;
end BLOCK1
//
DELIMITER ;
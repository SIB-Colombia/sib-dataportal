DROP PROCEDURE IF EXISTS data_resource_duplicates;

DELIMITER //

CREATE PROCEDURE data_resource_duplicates()
	BLOCK1: begin
		DECLARE dataResourceName VARCHAR(255);
		DECLARE oldDataResourceId INT(10);
        DECLARE newDataResourceId INT(10);
		DECLARE rep INT(10);
        DECLARE ret INT(10);
		DECLARE no_more_rows1 BOOL;
		DECLARE cursor1 CURSOR FOR SELECT name, count(*) as count from data_resource where deleted is null group by name having count > 1;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows1 := TRUE;
		SET no_more_rows1 := FALSE;
		
		OPEN cursor1;
			LOOP1: loop
				FETCH cursor1 INTO dataResourceName, rep;
				if no_more_rows1 THEN
					close cursor1;
					leave LOOP1;
				end if;
				
				SET ret := rep;
                while ret > 1 do 
					SET ret := ret -1;
					SET oldDataResourceId := (select min(id) from data_resource where name = dataResourceName and deleted is null);
					SET newDataResourceId := (select max(id) from data_resource where name = dataResourceName and deleted is null);
					update occurrence_record set deleted = now() where data_resource_id = oldDataResourceId;
					update raw_occurrence_record set deleted=now() where data_resource_id=oldDataResourceId;
					update occurrence_record set data_resource_id=oldDataResourceId where data_resource_id=newDataResourceId;
					update raw_occurrence_record set data_resource_id=oldDataResourceId where data_resource_id=newDataResourceId;
					update data_resource set deleted=now() where id =newDataResourceId;
                    update data_resource set modified= now() where id = oldDataResourceId;
				end while;	
			end loop LOOP1;
	end BLOCK1
//
DELIMITER ;
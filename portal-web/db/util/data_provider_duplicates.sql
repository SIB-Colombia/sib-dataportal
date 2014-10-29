DROP PROCEDURE IF EXISTS data_provider_duplicates;

DELIMITER //

CREATE PROCEDURE data_provider_duplicates()
	BLOCK1: begin
		DECLARE dataProviderName VARCHAR(255);
        DECLARE correctDataProviderId INT(10);
		DECLARE wrongDataProviderId INT(10);
		DECLARE rep INT(10);
		DECLARE ret INT(10);
		DECLARE no_more_rows1 BOOL;
		DECLARE cursor1 CURSOR FOR SELECT name, count(*) as count from data_provider where deleted is null group by name having count > 1;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows1 := TRUE;
		SET no_more_rows1 := FALSE;
		
		OPEN cursor1;
			LOOP1: loop
				FETCH cursor1 INTO dataProviderName, rep;
				if no_more_rows1 THEN
					close cursor1;
					leave LOOP1;
				end if;
				
				SET ret := rep;
				while ret > 1 do 
					SET ret := ret -1;
                    SET correctDataProviderId := (select min(id) as last  from data_provider where name =  dataProviderName and deleted is null);
					SET wrongDataProviderId := (select max(id) as last  from data_provider where name =  dataProviderName and deleted is null);
					update data_resource set data_provider_id = correctDataProviderId where data_provider_id = wrongDataProviderId;
					update occurrence_record set data_provider_id=correctDataProviderId where data_provider_id = wrongDataProviderId;
					update raw_occurrence_record set data_provider_id=correctDataProviderId where data_provider_id = wrongDataProviderId;
					update data_provider set deleted = now() where id = wrongDataProviderId;
                    update data_resource set modified= now() where id = correctDataProviderId;
				end while;
			end loop LOOP1;
	end BLOCK1
//
DELIMITER ;
DROP PROCEDURE IF EXISTS gif_log_message;

DELIMITER //

CREATE PROCEDURE gif_log_message ()
BLOCK1: BEGIN
	declare logGroup int(10);
	declare no_more_rows1 BOOL;
	declare cursor1 CURSOR FOR select max(log_group_id)+1 from gbif_log_message;
	declare continue handler FOR NOT FOUND SET no_more_rows1 := TRUE;
	SET no_more_rows1 := FALSE;
	OPEN cursor1;
	LOOP1:LOOP
		FETCH cursor1 into logGroup;
		if no_more_rows1 THEN
		close cursor1;
		leave LOOP1;
		end if;
		insert into gbif_log_message(portal_instance_id, log_group_id, event_id, level, data_provider_id, data_resource_id, occurrence_id, taxon_concept_id, message, restricted, count, timestamp)
		select 1 , logGroup, 1008, 40000,  data_provider_id, data_resource_id, id, taxon_concept_id , concat(iso_country_code , " (Lat: " , latitude , ", Lon: " , longitude , " ): Geospatial issues: coordinates fall outside specified country, country calculated: " , iso_country_code_calculated ), 0, 1, NOW() from occurrence_record where iso_country_code != iso_country_code_calculated; 
	end loop LOOP1;
end BLOCK1
//
DELIMITER ;

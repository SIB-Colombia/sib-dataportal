select concat('Creating procedure generate_common_names: ', now()) as debug;
DROP PROCEDURE IF EXISTS generate_common_names;

DELIMITER //

CREATE PROCEDURE generate_common_names ()
	BLOCK1: begin
		
		DECLARE dataCanonical VARCHAR(255);
		DECLARE dataCommonName VARCHAR(255);
		DECLARE dataLanguageIso char(3);
		DECLARE dataCountryIso char(3);
		DECLARE no_more_rows1 BOOL;
		DECLARE cursor1 CURSOR FOR SELECT catalogue_of_life_common_name.common_name, catalogue_of_life_common_name.canonical, catalogue_of_life_common_name.language_iso, catalogue_of_life_common_name.country_iso FROM catalogue_of_life_common_name where language_iso = 'spa';

		DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows1 := TRUE;

		SET no_more_rows1 := FALSE;
	
		OPEN cursor1;
		LOOP1: loop
			fetch cursor1 INTO dataCommonName, dataCanonical, dataLanguageIso, dataCountryIso;
			if no_more_rows1 THEN
				close cursor1;
				leave LOOP1;
			end if;
			BLOCK2: begin
				DECLARE no_more_rows2 BOOL;
				DECLARE dataTaxonConcept INT(10);
				DECLARE dataCommonNameElement INT(10);
				DECLARE countTaxon INT;
				
				DECLARE cursor2 CURSOR FOR SELECT taxon_concept.id FROM taxon_concept INNER JOIN taxon_name ON taxon_concept.taxon_name_id = taxon_name.id where taxon_name.canonical = dataCanonical order by data_provider_id,data_resource_id;
				DECLARE cursor3 CURSOR FOR SELECT common_name.id FROM common_name where common_name.name = dataCommonName;
				
				DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_more_rows2 := TRUE;

				SET no_more_rows2 := FALSE;

				OPEN cursor2;
				OPEN cursor3;
				LOOP2: loop
					fetch cursor2 INTO dataTaxonConcept;
					fetch cursor3 INTO dataCommonNameElement;
					if no_more_rows2 THEN
						close cursor2;
						leave LOOP2;
					end if;
					SET countTaxon = 0;
					SELECT count(*) INTO countTaxon FROM common_name_taxon_concept WHERE common_name_id = dataCommonNameElement AND taxon_concept_id = dataTaxonConcept;
					if countTaxon = 0 THEN
						insert ignore into common_name_taxon_concept ( taxon_concept_id, common_name_id) VALUES (dataTaxonConcept, dataCommonNameElement);
						UPDATE taxon_concept SET is_nub_concept = 1 WHERE id = dataTaxonConcept;
					end if;
				end loop LOOP2;
			end BLOCK2;
		end loop LOOP1;
	end BLOCK1
//
DELIMITER ;
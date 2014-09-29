select concat('Extracting table data from database col2012 (catalogue of life) to table file catalogue_of_life_common_name: ', now()) as debug;

SELECT common_name.id,
CoL2012._search_all.`name`,
CoL2012.common_name_element.`name`,
"spa",
CoL2012.common_name.country_iso,
CoL2012.country.`name` AS country
FROM
CoL2012._search_all
LEFT JOIN CoL2012.common_name ON CoL2012._search_all.id = CoL2012.common_name.taxon_id
LEFT JOIN CoL2012.common_name_element ON CoL2012.common_name.common_name_element_id = CoL2012.common_name_element.id
LEFT JOIN CoL2012.country ON CoL2012.common_name.country_iso = CoL2012.country.iso
LEFT JOIN CoL2012.region_free_text ON CoL2012.common_name.region_free_text_id = CoL2012.region_free_text.id
WHERE
CoL2012.common_name.language_iso in ("spa","012","Spainsh","109","221")
and CoL2012._search_all.rank in ('species', 'not assigned') 
GROUP BY
CoL2012._search_all.id
union all
SELECT common_name.id,
CoL2012._search_all.`name`,
CoL2012.common_name_element.`name`,
"eng",
CoL2012.common_name.country_iso,
CoL2012.country.`name` AS country
INTO OUTFILE "C://Temp//catalogue_of_life_common_name.txt"
FROM CoL2012._search_all
LEFT JOIN CoL2012.common_name ON CoL2012._search_all.id = CoL2012.common_name.taxon_id
LEFT JOIN CoL2012.common_name_element ON CoL2012.common_name.common_name_element_id = CoL2012.common_name_element.id
LEFT JOIN CoL2012.country ON CoL2012.common_name.country_iso = CoL2012.country.iso
LEFT JOIN CoL2012.region_free_text ON CoL2012.common_name.region_free_text_id = CoL2012.region_free_text.id
WHERE
CoL2012.common_name.language_iso in ("eng","003","English;English","183")
and CoL2012._search_all.rank in ('species', 'not assigned') 
GROUP BY
CoL2012._search_all.id;
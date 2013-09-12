-- https://github.com/SIB-Colombia/sib-dataportal/wiki/Instructions-to-enable-common-names
-- vernacular.txt

Select tc.original_id, cne.name, l.name, rf.free_text
from CoL2012.common_name cn
inner join CoL2012.taxon tc on cn.taxon_id = tc.id
inner join CoL2012.common_name_element cne on cn.common_name_element_id = cne.id
left join CoL2012.language l on cn.language_iso = l.iso
left join Col2012.region_free_text rf on cn.region_free_text_id = rf.id
where (free_text is not null
and country_iso is null) or (free_text is not null
and country_iso is not null)
union all
select tc.original_id, cne.name, l.name, c.name
from CoL2012.common_name cn
inner join CoL2012.taxon tc on cn.taxon_id = tc.id
inner join CoL2012.common_name_element cne on cn.common_name_element_id = cne.id
left join CoL2012.language l on cn.language_iso = l.iso
left join Col2012.country c on country_iso = c.iso
where country_iso is not null
and region_free_text_id is null
union all
select tc.original_id, cne.name, l.name, c.name
INTO OUTFILE "C://Temp//vernacular.txt"
from CoL2012.common_name cn
inner join CoL2012.taxon tc on cn.taxon_id = tc.id
inner join CoL2012.common_name_element cne on cn.common_name_element_id = cne.id
left join CoL2012.language l on cn.language_iso = l.iso
left join Col2012.country c on country_iso = c.iso
left join Col2012.region_free_text rf on cn.region_free_text_id = rf.id
where country_iso is null
and free_text is null;

-- taxonomy.txt

select distinct original_id, kingdom_name, phylum_name,class_name,order_name,superfamily_name,family_name,genus_name,species_name,infraspecific_marker,author,sa.name,rank,status,"",1,source_database_short_name
into outfile "C://Temp//taxonomy.txt"
from col2012._species_details sd
inner join col2012.taxon t on sd.taxon_id = t.id
inner join col2012._search_all sa on sd.taxon_id = sa.id
group by original_id;

-- publication.txt
SELECT original_id, type, authors, year, title, text 
INTO OUTFILE "C://Temp//publication.txt"
FROM CoL2012.reference,CoL2012.taxon,CoL2012.reference_to_taxon, CoL2012.reference_type 
where reference_to_taxon.reference_id = reference.id 
and reference_to_taxon.taxon_id = taxon.id 
and reference_to_taxon.reference_type_id = reference_type.id;

-- distribution.txt

SELECT taxon.original_id, region.name 
INTO OUTFILE "C://Temp//distribution.txt"
FROM CoL2012.distribution, CoL2012.region, CoL2012.taxon
where distribution.region_id = region.id
and distribution.taxon_detail_id = taxon.id;

-- families.txt
SELECT distinct sf.kingdom, sf.phylum, sf.class, sf.order, sf.superfamily, sf.family, ss.source_database_name 
INTO OUTFILE "C://Temp//families.txt"
FROM  col2012._search_family sf, col2012._search_scientific ss  
where sf.family != ''
and sf.family = ss.family
and sf.kingdom = ss.kingdom
and sf.phylum = ss.phylum 
and sf.class = ss.class 
and sf.order = ss.order 
order by 1,2,3,4,5,6,7;

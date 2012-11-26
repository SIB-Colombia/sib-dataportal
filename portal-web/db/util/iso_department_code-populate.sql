alter table occurrence_record add iso_department_code CHAR(8) after iso_country_code;

-- populate iso_department_code
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('distrito capital de bogotá');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('distrito capital');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá, d.c.');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogota');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('santafé de bogotá');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá, distrito capital');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá, distrito capital');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-AMA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('amazonas');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ANT' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('antioquia');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ARA' where raw_occurrence_record.id = occurrence_record.id and raw_occurrence_record.state_province=('Arauca');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ARA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('arauca');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ATL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('atlántico');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ATL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('atlantico');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bolívar');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bolivar');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOY' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('boyacá');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOY' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('boyaca');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('caldas');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAQ' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('caquetá');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAQ' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('caqueta');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAS' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('casanare');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cauca');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CES' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cesar');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-COR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('córdoba');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-COR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cordoba');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CUN' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cundinamarca');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CHO' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('chocó');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CHO' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('choco');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('guainía');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('guainia');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUV' where raw_occurrence_record.id = occurrence_record.id and lower(raw_occurrence_record.state_province)=('guaviare');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-HUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('huila');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-LAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('la guajira');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-LAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('guajira');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('magdalena');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MET' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('meta');
 
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NAR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('nariño');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NAR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('narino');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NSA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('norte de santander');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-PUT' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('putumayo');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-QUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('quindío');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-QUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('quindio');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-RIS' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('risaralda');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andrés y providencia');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andres y providencia');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('archipiélago de san andrés, providencia y santa catalina');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('archipielago de san andres, providencia y santa catalina');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andrés');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andres');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andrés, providencia y santa catalina');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andres, providencia y santa catalina');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAN' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('santander');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SUC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('sucre');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-TOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('tolima');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('valle del cauca');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('valle');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('vaupés');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('vaupes');

update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VID' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('vichada');



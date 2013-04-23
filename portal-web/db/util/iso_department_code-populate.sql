--Add column iso_department_code for departments
alter table occurrence_record add iso_department_code CHAR(8) after iso_country_code;

-- populate iso_department_code according to differents possible names.
-- Bogotá, D.C
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('distrito capital de bogotá') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('distrito capital') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá, d.c.') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá d.c.') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá, d.c') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogota, d.c.') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogota d.c.') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogota') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá')and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('santafé de bogotá') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá, distrito capital') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bogotá, distrito capital') and(occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-dc') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-DC' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='11') and (occurrence_record.iso_country_code='CO');

-- Amazonas
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-AMA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('amazonas') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-AMA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-ama') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-AMA' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='91') and (occurrence_record.iso_country_code='CO');

-- Antioquia
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ANT' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('antioquia') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ANT' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-ant') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ANT' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='05' or raw_occurrence_record.state_province='5') and (occurrence_record.iso_country_code='CO');

-- Arauca
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ARA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('arauca') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ARA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-ara') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ARA' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='81') and (occurrence_record.iso_country_code='CO');

-- Atlántico
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ATL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('atlántico') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ATL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('atlantico') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ATL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-atl') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-ATL' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='08' or raw_occurrence_record.state_province='8') and (occurrence_record.iso_country_code='CO');

-- Bolívar
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bolívar') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('bolivar') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-bol') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOL' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='13') and (occurrence_record.iso_country_code='CO');

-- Boyacá
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOY' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('boyacá') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOY' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('boyaca') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOY' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-boy') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-BOY' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='15') and (occurrence_record.iso_country_code='CO');

-- Caldas
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('caldas') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cal') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAL' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='17') and (occurrence_record.iso_country_code='CO');

-- Caquetá
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAQ' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('caquetá') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAQ' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('caqueta')and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAQ' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-caq')and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAQ' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='18') and (occurrence_record.iso_country_code='CO');

-- Casanare
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAS' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('casanare') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAS' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cas') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAS' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='85') and (occurrence_record.iso_country_code='CO');

-- Cauca
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cauca') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cau') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CAU' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='19') and (occurrence_record.iso_country_code='CO');

-- Cesar
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CES' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cesar') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CES' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-ces') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CES' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='20') and (occurrence_record.iso_country_code='CO');

-- Córdoba
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-COR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('córdoba') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-COR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cordoba') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-COR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cor') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-COR' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='23') and (occurrence_record.iso_country_code='CO');

-- Cundinamarca
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CUN' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('cundinamarca') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CUN' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cun') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CUN' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='25') and (occurrence_record.iso_country_code='CO');

-- Chocó
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CHO' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('chocó') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CHO' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('choco') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CHO' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-cho') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-CHO' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='27') and (occurrence_record.iso_country_code='CO');

-- Guainía
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('guainía') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('guainia') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-gua') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUA' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='94') and (occurrence_record.iso_country_code='CO');

-- Guaviare
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUV' where raw_occurrence_record.id = occurrence_record.id and lower(raw_occurrence_record.state_province)=('guaviare') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUV' where raw_occurrence_record.id = occurrence_record.id and lower(raw_occurrence_record.state_province)=('co-guv') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-GUV' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='95') and (occurrence_record.iso_country_code='CO');

-- Huila
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-HUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('huila') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-HUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-hui') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-HUI' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='41') and (occurrence_record.iso_country_code='CO');

-- La Guajira
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-LAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('la guajira') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-LAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('guajira') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-LAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-lag') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-LAG' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='44') and (occurrence_record.iso_country_code='CO');

-- Magdalena
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('magdalena') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MAG' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-mag') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MAG' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='47') and (occurrence_record.iso_country_code='CO');

-- Meta
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MET' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('meta') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MET' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-met') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-MET' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='50') and (occurrence_record.iso_country_code='CO');

-- Nariño
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NAR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('nariño') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NAR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('narino') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NAR' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-nar') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NAR' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='52') and (occurrence_record.iso_country_code='CO');

-- Norte de Santander
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NSA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('norte de santander') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NSA' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-nsa') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-NSA' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='54') and (occurrence_record.iso_country_code='CO');

-- Putumayo
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-PUT' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('putumayo') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-PUT' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-put') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-PUT' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='86') and (occurrence_record.iso_country_code='CO');

-- Quindío
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-QUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('quindío') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-QUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('quindio') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-QUI' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-qui') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-QUI' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='63') and (occurrence_record.iso_country_code='CO');

-- Risaralda
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-RIS' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('risaralda') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-RIS' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-ris') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-RIS' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='66') and (occurrence_record.iso_country_code='CO');

-- Archipiélago de San Andrés, Providencia y Santa Catalina
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andrés y providencia') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andres y providencia') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('archipiélago de san andrés, providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('archipiélago de san andrés providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('archipielago de san andres, providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('archipielago de san andres providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andrés') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andres') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andrés, providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('san andres, providencia y santa catalina') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-sap') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAP' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='88') and (occurrence_record.iso_country_code='CO');

-- Santander
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAN' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('santander') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAN' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-san') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SAN' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='68') and (occurrence_record.iso_country_code='CO');

-- Sucre
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SUC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('sucre') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SUC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-suc') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-SUC' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='70') and (occurrence_record.iso_country_code='CO');

-- Tolima
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-TOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('tolima') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-TOL' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-tol') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-TOL' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='73') and (occurrence_record.iso_country_code='CO');

-- Valle del Cauca
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('valle del cauca') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('valle') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAC' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-vac') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAC' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='76') and (occurrence_record.iso_country_code='CO');

-- Vaupés
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('vaupés') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('vaupes') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAU' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-vau') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VAU' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='97') and (occurrence_record.iso_country_code='CO');

-- Vichada
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VID' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('vichada') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VID' where raw_occurrence_record.id = occurrence_record.id and lower (raw_occurrence_record.state_province)=('co-vid') and (occurrence_record.iso_country_code='CO');
update occurrence_record, raw_occurrence_record set iso_department_code ='CO-VID' where raw_occurrence_record.id = occurrence_record.id and (raw_occurrence_record.state_province='99') and (occurrence_record.iso_country_code='CO');



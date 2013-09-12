-- https://github.com/SIB-Colombia/sib-dataportal/wiki/Instructions-to-enable-common-names

CREATE TABLE distribution (
       id INT NOT NULL AUTO_INCREMENT
     , taxon_concept_id INT
     , text VARCHAR(255) NOT NULL
     , iso_language_code CHAR(2) NOT NULL
     , language VARCHAR(255)
     , PRIMARY KEY (id)
     , INDEX (taxon_concept_id)
);
CREATE INDEX IX_distribution_text ON distribution (text ASC);
CREATE INDEX IX_distribution_iso_language_code ON distribution (iso_language_code ASC);
CREATE INDEX IX_distribution_language ON distribution (language ASC);

ALTER TABLE data_provider ADD type varchar(255);

UPDATE data_provider SET type = "Autoridad ambiental" WHERE name in ("Corantioquia", "Corporación Autonóma Regional para la Defensa de la Meseta de Bucaramanga","Secretaría Distrital de Ambiente");
UPDATE data_provider SET type = "Empresa privada" WHERE name in ("Federación Nacional de Cafeteros de Colombia", "Isagen","Oleoducto Bicentenario");
UPDATE data_provider SET type = "Instituto de investigación" WHERE name in ("Instituto Amazónico de Investigaciones Científicas (SINCHI)", "Instituto de Investigación de Recursos Biológicos Alexander von Humboldt","Instituto de Investigaciones Ambientales del Pacifico John Von Neumann (IIAP)");
UPDATE data_provider SET type = "ONG" WHERE name in ("Asociación para el estudio y conservación de las aves acuáticas en Colombia","Asociación de Becarios del Casanare - ABC", "Asociación GAICA","Asociación Selva","Fundación Alma","Fundación Pro-Sierra Nevada de Santa Marta","Jardín Botánico del Quindío","WCS Colombia");
UPDATE data_provider SET type = "Red temática/regional" WHERE name in ("Red Nacional de Observadores de Aves (RNOA)");
UPDATE data_provider SET type = "Universidad" WHERE name in ("Universidad de Antioquia","Instituto de Ciencias Naturales","Universidad de La Salle","Universidad de los Andes","Universidad de Nariño","Universidad del Magdalena","Universidad del Valle");
UPDATE data_provider SET type = "Repatriados" WHERE name in ("SiB Colombia");
## RECUPERER_COMMUNES_A_GEOLOCALISER
SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle ORDER BY codinsee;

## CREER_TABLE_PARCELLES
CREATE SCHEMA IF NOT EXISTS {0};
DROP TABLE IF EXISTS {0}.{1};
CREATE TABLE {0}.{1}(
 dep varchar(2),
 id varchar(14),
 surface numeric,
 geompar geometry,
 source_geo text,
 vecteur text
);

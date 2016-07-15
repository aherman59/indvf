## RECUPERER_COMMUNES_A_GEOLOCALISER
SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle ORDER BY codinsee;

## CREER_TABLE_PARCELLES_SI_INEXISTANTE
CREATE SCHEMA IF NOT EXISTS {0};
CREATE TABLE IF NOT EXISTS {0}.{1}(
 dep varchar(3),
 idpar varchar(14),
 surface numeric,
 geompar geometry,
 source_geo text,
 vecteur text
);

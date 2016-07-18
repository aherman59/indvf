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

## RECUPERER_COMMUNES_A_GEOLOCALISER
SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle ORDER BY codinsee;

## CREER_EXTENSION_POSTGIS
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;

## CREER_CHAMPS_GEOMETRIQUES
ALTER TABLE dvf.local ADD COLUMN geomloc geometry;
ALTER TABLE dvf.disposition_parcelle ADD COLUMN geomloc geometry;
ALTER TABLE dvf.disposition_parcelle ADD COLUMN geompar geometry;
ALTER TABLE dvf.mutation ADD COLUMN geomlocmut geometry;
ALTER TABLE dvf.mutation ADD COLUMN geomparmut geometry;
ALTER TABLE dvf.mutation ADD COLUMN geompar geometry;

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

## MISE_A_JOUR_GEOMETRIES_LOCAL_DEPUIS
UPDATE dvf.local l
SET geomloc = t.geomloc
FROM {0}.{1} t
WHERE l.idpar = t.idpar;

## MISE_A_JOUR_GEOMETRIES_DISPOSITION_PARCELLE_DEPUIS
UPDATE dvf.disposition_parcelle d
SET geomloc = t.geomloc, geompar = t.geompar
FROM {0}.{1} t
WHERE d.idpar = t.idpar;

## MISE_A_JOUR_GEOMETRIES_MUTATION
UPDATE dvf.mutation m
SET geomlocmut = t.geomlocmut
FROM (SELECT idmutation, ST_UNION(geomloc) AS geomlocmut FROM dvf.local GROUP BY idmutation) t
WHERE m.idmutation = t.idmutation;

UPDATE dvf.mutation m
SET geomparmut = t.geomparmut
FROM (SELECT idmutation, ST_UNION(geompar) AS geomparmut FROM dvf.disposition_parcelle WHERE parcvendue IS TRUE GROUP BY idmutation) t
WHERE m.idmutation = t.idmutation;

UPDATE dvf.mutation m
SET geompar = t.geompar
FROM (SELECT idmutation, ST_UNION(geompar) AS geompar FROM dvf.disposition_parcelle GROUP BY idmutation) t
WHERE m.idmutation = t.idmutation;
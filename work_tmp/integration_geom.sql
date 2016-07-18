SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle ORDER BY codinsee;

CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;

ALTER TABLE dvf.local ADD COLUMN geomloc geometry;

ALTER TABLE dvf.disposition_parcelle ADD COLUMN geomloc geometry;
ALTER TABLE dvf.disposition_parcelle ADD COLUMN geompar geometry;

ALTER TABLE dvf.mutation ADD COLUMN geomlocmut geometry;
ALTER TABLE dvf.mutation ADD COLUMN geomparmut geometry;
ALTER TABLE dvf.mutation ADD COLUMN geompar geometry;

UPDATE dvf.local
SET geomloc = t.geomloc
FROM cadastre.dep59 t
WHERE idpar = t.id;

UPDATE dvf.disposition_parcelle
SET geomloc = t.geomloc, geompar = t.geompar
FROM cadastre.dep59 t
WHERE idpar = t.id;

UPDATE dvf.mutation
SET geomlocmut = t.geomlocmut
FROM (SELECT idmutation, ST_UNION(geomloc) AS geomlocmut FROM dvf.local GROUP BY idmutation) t
WHERE idmutation = t.idmutation;

UPDATE dvf.mutation
SET geomparmut = t.geomparmut
FROM (SELECT idmutation, ST_UNION(geompar) AS geomparmut FROM dvf.disposition_parcelle WHERE parcvendue IS TRUE GROUP BY idmutation) t
WHERE idmutation = t.idmutation;

UPDATE dvf.mutation
SET geompar = t.geompar
FROM (SELECT idmutation, ST_UNION(geompar) AS geompar FROM dvf.disposition_parcelle GROUP BY idmutation) t
WHERE idmutation = t.idmutation;

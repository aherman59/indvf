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

## MISE_A_JOUR_GEOMETRIES_LOCAL_POUR_DEPARTEMENT_DEPUIS
UPDATE {2}.local l
SET geomloc = t.geomloc
FROM {0}.{1} t
WHERE l.idpar = t.idpar;

## MISE_A_JOUR_GEOMETRIES_DISPOSITION_PARCELLE_POUR_DEPARTEMENT_DEPUIS
UPDATE {2}.disposition_parcelle d
SET geomloc = t.geomloc, geompar = ST_MULTI(t.geompar)
FROM {0}.{1} t
WHERE d.idpar = t.idpar;

## MISE_A_JOUR_GEOMETRIES_MUTATION_POUR_DEPARTEMENT
UPDATE {0}.mutation m
SET geomlocmut = t.geomlocmut
FROM (SELECT idmutation, ST_UNION(geomloc) AS geomlocmut FROM {0}.local GROUP BY idmutation) t
WHERE m.idmutation = t.idmutation;

UPDATE {0}.mutation m
SET geomparmut = ST_MULTI(t.geomparmut)
FROM (SELECT idmutation, ST_UNION(geompar) AS geomparmut FROM {0}.disposition_parcelle WHERE parcvendue IS TRUE GROUP BY idmutation) t
WHERE m.idmutation = t.idmutation;

UPDATE {0}.mutation m
SET geompar = ST_MULTI(t.geompar)
FROM (SELECT idmutation, ST_UNION(geompar) AS geompar FROM {0}.disposition_parcelle GROUP BY idmutation) t
WHERE m.idmutation = t.idmutation;

## CREER_INDEX_GEOMETRIQUES
-- Table mutation
DROP INDEX IF EXISTS geompar_mutation_gist_{0};
CREATE INDEX --IF NOT EXISTS 
geompar_mutation_gist_{0} ON {0}.mutation USING gist (geompar);
DROP INDEX IF EXISTS geomparmut_mutation_gist_{0};
CREATE INDEX --IF NOT EXISTS 
geomparmut_mutation_gist_{0} ON {0}.mutation USING gist (geomparmut);
DROP INDEX IF EXISTS geomlocmut_mutation_gist_{0};
CREATE INDEX --IF NOT EXISTS 
geomlocmut_mutation_gist_{0} ON {0}.mutation USING gist (geomlocmut);
--Table disposition_parcelle
DROP INDEX IF EXISTS geompar_parcelle_gist_{0};
CREATE INDEX --IF NOT EXISTS 
geompar_parcelle_gist_{0} ON {0}.disposition_parcelle USING gist (geompar);
DROP INDEX IF EXISTS geomloc_parcelle_gist_{0};
CREATE INDEX --IF NOT EXISTS 
geomloc_parcelle_gist_{0} ON {0}.disposition_parcelle USING gist (geomloc);
-- Table local
DROP INDEX IF EXISTS geomloc_local_gist_{0};
CREATE INDEX --IF NOT EXISTS 
geomloc_local_gist_{0} ON {0}.local USING gist (geomloc);

## CREER_CONTRAINTES_GEOMETRIQUES
-- Table mutation
ALTER TABLE {0}.mutation ADD CONSTRAINT enforce_dims_mutation_geomlocmut CHECK (st_ndims(geomlocmut) = 2);
ALTER TABLE {0}.mutation ADD CONSTRAINT enforce_dims_mutation_geompar CHECK (st_ndims(geompar) = 2);
ALTER TABLE {0}.mutation ADD CONSTRAINT enforce_dims_mutation_geomparmut CHECK (st_ndims(geomparmut) = 2);
ALTER TABLE {0}.mutation ADD CONSTRAINT enforce_geotype_mutation_geomlocmut CHECK (geometrytype(geomlocmut) = 'MULTIPOINT'::text OR geometrytype(geomlocmut) = 'POINT'::text OR geomlocmut IS NULL);
ALTER TABLE {0}.mutation ADD CONSTRAINT enforce_geotype_mutation_geompar CHECK (geometrytype(geompar) = 'MULTIPOLYGON'::text OR geompar IS NULL);
ALTER TABLE {0}.mutation ADD CONSTRAINT enforce_geotype_mutation_geomparmut CHECK (geometrytype(geomparmut) = 'MULTIPOLYGON'::text OR geomparmut IS NULL);
--ALTER TABLE {0}.mutation ADD CONSTRAINT enforce_srid_mutation_geomlocmut CHECK (st_srid(geomlocmut) = 2154);
--ALTER TABLE {0}.mutation ADD CONSTRAINT enforce_srid_mutation_geompar CHECK (st_srid(geompar) = 2154);
--ALTER TABLE {0}.mutation ADD CONSTRAINT enforce_srid_mutation_geomparmut CHECK (st_srid(geomparmut) = 2154);
-- Table disposition_parcelle
ALTER TABLE {0}.disposition_parcelle ADD CONSTRAINT enforce_dims_parcelle_geompar CHECK (st_ndims(geompar) = 2);
ALTER TABLE {0}.disposition_parcelle ADD CONSTRAINT enforce_dims_parcelle_geomloc CHECK (st_ndims(geomloc) = 2);
ALTER TABLE {0}.disposition_parcelle ADD CONSTRAINT enforce_geotype_parcelle_geompar CHECK (geometrytype(geompar) = 'MULTIPOLYGON'::text OR geompar IS NULL);
ALTER TABLE {0}.disposition_parcelle ADD CONSTRAINT enforce_geotype_parcelle_geomloc CHECK (geometrytype(geomloc) = 'POINT'::text OR geomloc IS NULL);
--ALTER TABLE {0}.disposition_parcelle ADD CONSTRAINT enforce_srid_parcelle_geompar CHECK (st_srid(geompar) = 2154);
--ALTER TABLE {0}.disposition_parcelle ADD CONSTRAINT enforce_srid_parcelle_geomloc CHECK (st_srid(geomloc) = 2154);
-- Table local
ALTER TABLE {0}.local ADD CONSTRAINT enforce_dims_local_geomloc CHECK (st_ndims(geomloc) = 2);
ALTER TABLE {0}.local ADD CONSTRAINT enforce_geotype_local_geomloc CHECK (geometrytype(geomloc) = 'POINT'::text OR geomloc IS NULL);
--ALTER TABLE {0}.local ADD CONSTRAINT enforce_srid_local_geomloc CHECK (st_srid(geomloc) = 2154);
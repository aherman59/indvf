
--
-- Début d'exécution le 24/11/2016 à 17:33:18
--

CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;

SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle ORDER BY codinsee;

CREATE SCHEMA IF NOT EXISTS cadastre;
CREATE TABLE IF NOT EXISTS cadastre.parcellaire(
 dep varchar(3),
 idpar varchar(14),
 surface numeric,
 geompar geometry,
 geomloc geometry,
 source_geo text,
 vecteur text
);

ALTER TABLE cadastre.parcellaire DROP CONSTRAINT IF EXISTS parcellaire_pkey;

ALTER TABLE cadastre.parcellaire 
ADD CONSTRAINT parcellaire_pkey PRIMARY KEY (idpar);

SELECT DISTINCT idpar FROM cadastre.parcellaire WHERE idpar LIKE '59220%';
SELECT DISTINCT idpar FROM cadastre.parcellaire WHERE idpar LIKE '59328%';
SELECT DISTINCT idpar FROM cadastre.parcellaire WHERE idpar LIKE '59346%';
SELECT DISTINCT idpar FROM cadastre.parcellaire WHERE idpar LIKE '59350%';

SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle ORDER BY codinsee;

CREATE SCHEMA IF NOT EXISTS cadastre;
DROP TABLE IF EXISTS cadastre.parcellaire;
CREATE TABLE cadastre.parcellaire(
 dep varchar(2),
 id varchar(14),
 surface numeric,
 geompar geometry,
 source_geo text,
 vecteur text
);
SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle ORDER BY codinsee;

CREATE SCHEMA IF NOT EXISTS cadastre;
DROP TABLE IF EXISTS cadastre.parcellaire;
CREATE TABLE cadastre.parcellaire(
 dep varchar(2),
 id varchar(14),
 surface numeric,
 geompar geometry,
 source_geo text,
 vecteur text
);

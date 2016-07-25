## CREER_TABLE_PARCELLES_SI_INEXISTANTE
CREATE SCHEMA IF NOT EXISTS {0};
CREATE TABLE IF NOT EXISTS {0}.{1}(
 dep varchar(3),
 idpar varchar(14),
 surface numeric,
 geompar geometry,
 geomloc geometry,
 source_geo text,
 vecteur text
);

## EFFACER_CONTRAINTE_SI_EXISTANTE
ALTER TABLE {0}.{1} DROP CONSTRAINT IF EXISTS {2};

## LISTER_IDPAR_EXISTANTS
SELECT DISTINCT idpar FROM {0}.{1} WHERE idpar LIKE '{2}%';

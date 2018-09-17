## _CODTYPBIEN
CASE 
-- BATI (1)
	WHEN nblocmut > 0 or vefa IS TRUE OR nbvolmut > 0 THEN	
		CASE 
		-- BATI - INDETERMINE (10) : ventes avec volume ou vefa sans information sur le local
			WHEN (nblocmut = 0 AND vefa IS TRUE) OR nbvolmut > 0 THEN 
				CASE 
				-- BATI - INDETERMINE : vente avec volume(s) (102)
					WHEN nbvolmut > 0 THEN '102'
				-- BATI - INDETERMINE : Vefa sans descriptif (101) 
					WHEN (nblocmut = 0 AND vefa IS TRUE) THEN '101'
				-- Ne doit pas exister
					ELSE '100'
				END
		-- MAISON (11)
			WHEN nblocmai > 0 and nblocapt = 0 AND nblocact = 0 THEN
				CASE
				-- MAISON - INDETERMINEE : la surface batie est inférieure à 9 m2 (110)
					WHEN nblocmai = 1 AND sbati < 9 THEN '110'
				-- MAISON INDIVIDUELLE (vendue seule) (111)
					WHEN nblocmai = 1 THEN '111'						
				-- MAISONS INDIVIDUELLES (112) 
					WHEN nblocmai > 1 THEN '112'
					ELSE 'PROBLEME'
				END

		-- APPARTEMENT (12)
			WHEN nblocapt > 0 and nblocmai = 0 AND nblocact = 0 THEN
				CASE
				-- 1 APPARTEMENT (121)
					WHEN nblocapt = 1 AND sbati > 9 THEN '121'					
				-- 2 APPARTEMENTS (122)
					WHEN nblocapt = 2 THEN '122'
				-- APPARTEMENTS INDETERMINES (1 appartement de - de 9 m2 / plusieurs apparts dans plusieurs bâtiments / non rapatriement des Fichiers fonciers) (120)
					ELSE '120'
				END
		-- DEPENDANCE (13)
			WHEN nblocdep > 0 AND nblocapt = 0 and nblocmai = 0 AND nblocact = 0 THEN
				CASE 
				-- UNE DEPENDANCE (131)
					WHEN nblocdep = 1 THEN '131'
				-- DEPENDANCES (132)
					WHEN nblocdep > 1 THEN '132'
					ELSE 'PROBLEME'
				END
		-- ACTIVITE (14)
			WHEN nblocact > 0 AND nblocapt = 0 and nblocmai = 0  THEN '14'
		-- MIXTE BATI (15)
			-- MIXTE - LOGEMENTS (151)
			WHEN nblocact = 0 AND nblocmai > 0 AND nblocapt > 0 THEN '151'
			-- MIXTE - LOGEMENT/ACTIVITE (152)
			WHEN nblocact >0 AND (nblocmai > 0 OR nblocapt > 0) THEN '152'
			ELSE 'PROBLEME'
		END 
-- NON BATI (2)
	ELSE 
		CASE
		-- TERRAINS DE TYPE TAB (21)
			WHEN l_dcnt[10] > 0 
				OR libnatmut = 'Vente terrain à bâtir' 
				OR l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[] 				
				THEN '21'
		-- TERRAINS ARTIFICIALISES (22)
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN
				CASE
				-- TERRAINS AGREEMENTS (221)
					WHEN  l_dcnt[9] + l_dcnt[11] = sterr THEN '221'
				-- TERRAINS D'EXTRACTION (222)
					WHEN  l_dcnt[7] = sterr THEN '222'
				-- TERRAINS DE TYPE RESEAU (223)
					WHEN  l_dcnt[12] = sterr THEN '223'
				-- TERRAINS ARTIFICIALISES MIXTES (229)
					ELSE '229'
				END 
		-- TERRAINS NATURELS (23)
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] + l_dcnt[5] + l_dcnt[6] + l_dcnt[8] = sterr THEN
			-- TERRAINS AGRICOLES (231)
				CASE
				-- TERRAINS VITICOLES (2311)
					WHEN  l_dcnt[4] >= sterr * 0.25 THEN '2311'
				-- TERRAINS VERGERS (2312)
					WHEN  l_dcnt[3] >= sterr * 0.35 THEN '2312'
				-- TERRAINS DE TYPE TERRES ET PRES (2313)
					WHEN  l_dcnt[1] + l_dcnt[2] >= sterr * 0.40 THEN '2313'
				-- TERRAINS AGRICOLES MIXTES (2319)
					WHEN l_dcnt[1] + l_dcnt[2] +  l_dcnt[3] + l_dcnt[4] >= sterr * 0.40 THEN '2319'
			-- TERRAINS FORESTIERS (232)
					WHEN  l_dcnt[5] > sterr * 0.60 THEN '232'
			-- TERRAINS LANDES ET EAUX (233)
					WHEN  l_dcnt[6] + l_dcnt[8] > sterr * 0.60 THEN '233'
			-- TERRAINS NATURELS MIXTES (239)
					ELSE '239'
				END
		-- TERRAINS NON BATIS INDETERMINES (20)
			ELSE '20' 
		END
	END as codtypbien

## _LIBTYPBIEN
CASE 
-- BATI (1)
	WHEN nblocmut > 0 or vefa IS TRUE OR nbvolmut > 0 THEN	
		CASE 
		-- BATI - INDETERMINE (10) : ventes avec volume ou vefa sans information sur le local
			WHEN (nblocmut = 0 AND vefa IS TRUE) OR nbvolmut > 0 THEN 
				CASE 
				-- BATI - INDETERMINE : vente avec volume(s) (102)
					WHEN nbvolmut > 0 THEN 'BATI - INDETERMINE : Vente avec volume(s)'
				-- BATI - INDETERMINE : Vefa sans descriptif (101) 
					WHEN (nblocmut = 0 AND vefa IS TRUE) THEN 'BATI - INDETERMINE : Vefa sans descriptif'
				-- Ne doit pas exister
					ELSE '100'
				END
		-- MAISON (11)
			WHEN nblocmai > 0 and nblocapt = 0 AND nblocact = 0 THEN
				CASE
				-- MAISON - INDETERMINEE : la surface batie est inférieure à 9 m2 (110)
					WHEN nblocmai = 1 AND sbati < 9 THEN 'MAISON - INDETERMINEE'
				-- MAISON INDIVIDUELLE (vendue seule) (111)
					WHEN nblocmai = 1 THEN 'UNE MAISON'						
				-- MAISONS INDIVIDUELLES (112) 
					WHEN nblocmai > 1 THEN 'DES MAISONS'
					ELSE 'PROBLEME'
				END

		-- APPARTEMENT (12)
			WHEN nblocapt > 0 and nblocmai = 0 AND nblocact = 0 THEN
				CASE
				-- 1 APPARTEMENT (121)
					WHEN nblocapt = 1 AND sbati > 9 THEN 'UN APPARTEMENT'					
				-- 2 APPARTEMENTS (122)
					WHEN nblocapt = 2 THEN 'DEUX APPARTEMENTS'
				-- APPARTEMENTS INDETERMINES (1 appartement de - de 9 m2 / plusieurs apparts dans plusieurs bâtiments / non rapatriement des Fichiers fonciers) (120)
					ELSE 'APPARTEMENT INDETERMINE'
				END
		-- DEPENDANCE (13)
			WHEN nblocdep > 0 AND nblocapt = 0 and nblocmai = 0 AND nblocact = 0 THEN
				CASE 
				-- UNE DEPENDANCE (131)
					WHEN nblocdep = 1 THEN 'UNE DEPENDANCE'
				-- DEPENDANCES (132)
					WHEN nblocdep > 1 THEN 'DES DEPENDANCES'
					ELSE 'PROBLEME'
				END
		-- ACTIVITE (14)
			WHEN nblocact > 0 AND nblocapt = 0 and nblocmai = 0  THEN 'ACTIVITE'
		-- MIXTE BATI (15)
			-- MIXTE - LOGEMENTS (151)
			WHEN nblocact = 0 AND nblocmai > 0 AND nblocapt > 0 THEN 'BATI MIXTE - LOGEMENTS'
			-- MIXTE - LOGEMENT/ACTIVITE (152)
			WHEN nblocact >0 AND (nblocmai > 0 OR nblocapt > 0) THEN 'BATI MIXTE - LOGEMENT/ACTIVITE'
			ELSE 'PROBLEME'
		END 
-- NON BATI (2)
	ELSE 
		CASE
		-- TERRAINS DE TYPE TAB (21)
			WHEN l_dcnt[10] > 0 
				OR libnatmut = 'Vente terrain à bâtir' 
				OR l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[] 				
				THEN 'TERRAIN DE TYPE TAB'
		-- TERRAINS ARTIFICIALISES (22)
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN
				CASE
				-- TERRAINS AGREEMENTS (221)
					WHEN  l_dcnt[9] + l_dcnt[11] = sterr THEN 'TERRAIN D''AGREMENT'
				-- TERRAINS D'EXTRACTION (222)
					WHEN  l_dcnt[7] = sterr THEN 'TERRAIN D''EXTRACTION'
				-- TERRAINS DE TYPE RESEAU (223)
					WHEN  l_dcnt[12] = sterr THEN 'TERRAIN DE TYPE RESEAU'
				-- TERRAINS ARTIFICIALISES MIXTES (229)
					ELSE 'TERRAIN ARTIFICIALISE MIXTE'
				END 
		-- TERRAINS NATURELS (23)
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] + l_dcnt[5] + l_dcnt[6] + l_dcnt[8] = sterr THEN
			-- TERRAINS AGRICOLES (231)
				CASE
				-- TERRAINS VITICOLES (2311)
					WHEN  l_dcnt[4] >= sterr * 0.25 THEN 'TERRAIN VITICOLE'
				-- TERRAINS VERGERS (2312)
					WHEN  l_dcnt[3] >= sterr * 0.35 THEN 'TERRAIN VERGER'
				-- TERRAINS DE TYPE TERRES ET PRES (2313)
					WHEN  l_dcnt[1] + l_dcnt[2] >= sterr * 0.40 THEN 'TERRAIN DE TYPE TERRE ET PRE'
				-- TERRAINS AGRICOLES MIXTES (2319)
					WHEN l_dcnt[1] + l_dcnt[2] +  l_dcnt[3] + l_dcnt[4] >= sterr * 0.40 THEN 'TERRAIN AGRICOLE MIXTE'
			-- TERRAINS FORESTIERS (232)
					WHEN  l_dcnt[5] > sterr * 0.60 THEN 'TERRAIN FORESTIER'
			-- TERRAINS LANDES ET EAUX (233)
					WHEN  l_dcnt[6] + l_dcnt[8] > sterr * 0.60 THEN 'TERRAIN LANDES ET EAUX'
			-- TERRAINS NATURELS MIXTES (239)
					ELSE 'TERRAIN NATUREL MIXTE'
				END
		-- TERRAINS NON BATIS INDETERMINES (20)
			ELSE 'TERRAIN NON BATIS INDETERMINE'
		END
	END as libtypbien

## CREER_AGGREGAT_MEDIANE_10
CREATE OR REPLACE FUNCTION dvf.centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$  
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;

CREATE OR REPLACE FUNCTION dvf.mediane_0(anyarray)
  RETURNS anyelement AS
$BODY$  
  SELECT dvf.centile($1, 50);
$BODY$
  LANGUAGE sql;
  
CREATE OR REPLACE FUNCTION dvf.premier_quartile_0(anyarray)
  RETURNS anyelement AS
$BODY$  
  SELECT dvf.centile($1, 25);
$BODY$
  LANGUAGE sql;
  
CREATE OR REPLACE FUNCTION dvf.dernier_quartile_0(anyarray)
  RETURNS anyelement AS
$BODY$  
  SELECT dvf.centile($1, 75);
$BODY$
  LANGUAGE sql;

DROP AGGREGATE IF EXISTS dvf.mediane(NUMERIC);
CREATE aggregate dvf.mediane(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = dvf.mediane_0
);

DROP AGGREGATE IF EXISTS dvf. premier_quartile(NUMERIC);
CREATE aggregate dvf.premier_quartile(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = dvf.premier_quartile_0
);

DROP AGGREGATE IF EXISTS dvf.dernier_quartile(NUMERIC);
CREATE aggregate dvf.dernier_quartile(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = dvf.dernier_quartile_0
);


## CALCULER_SOMME_PAR_ANNEE
SELECT anneemut, sum({0})
FROM (
	SELECT * {3} --codtypbien, libtypbien
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[]
	) t
{2}
GROUP BY anneemut;

## CALCULER_SOMME_MULTI_ANNEE
SELECT COALESCE(SUM({0}), 0)
FROM (
	SELECT * {5}
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] AND anneemut >= {2} AND anneemut <= {3}
	) t
{4};

## COMPTER_PAR_ANNEE
SELECT anneemut, count({0})
FROM (
	SELECT * {3} 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] 
	) t
{2}
GROUP BY anneemut;

## COMPTER_MULTI_ANNEE
SELECT COUNT({0})
FROM (
	SELECT * {5}
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] AND anneemut >= {2} AND anneemut <= {3}
	) t
{4};

## CALCULER_MEDIANE_PAR_ANNEE
SELECT anneemut, dvf.mediane({0}) 
FROM (
	SELECT * {3} 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[]
	) t
{2}
GROUP BY anneemut;

## CALCULER_MOYENNE_MULTI_ANNEE
SELECT avg({0}) 
FROM (
	SELECT * {5}
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] AND anneemut >= {2} AND anneemut <= {3}
	) t
{4};

## CALCULER_MOYENNE_PAR_ANNEE
SELECT anneemut, avg({0}) 
FROM (
	SELECT * {3} 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[]
	) t
{2}
GROUP BY anneemut;

## CALCULER_MEDIANE_MULTI_ANNEE
SELECT dvf.mediane({0}) 
FROM (
	SELECT * {5}
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] AND anneemut >= {2} AND anneemut <= {3}
	) t
{4};

## CALCULER_PQ_PAR_ANNEE
SELECT anneemut, dvf.premier_quartile({0}) 
FROM (
	SELECT * {3} 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[]
	) t
{2}
GROUP BY anneemut;

## CALCULER_PQ_MULTI_ANNEE
SELECT dvf.premier_quartile({0}) 
FROM (
	SELECT * {5}
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] AND anneemut >= {2} AND anneemut <= {3}
	) t
{4};

## CALCULER_DQ_PAR_ANNEE
SELECT anneemut, dvf.dernier_quartile({0}) 
FROM (
	SELECT * {3} 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[]
	) t
{2}
GROUP BY anneemut;

## CALCULER_DQ_MULTI_ANNEE
SELECT dvf.dernier_quartile({0}) 
FROM (
	SELECT * {5}
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] AND anneemut >= {2} AND anneemut <= {3}
	) t
{4};




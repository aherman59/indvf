## _CODTYPBIEN
CASE 
	WHEN libnatmut = 'Echange' THEN '7' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN '9' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN '8' -- ON MET UNE CATEGORIE A PART POUR LES ADJUDICATIONS
	WHEN nbvolmut > 0 THEN '4' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN '31'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '32'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '33'
			ELSE '34'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN '25'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '212'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '213'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN '25'
			WHEN l_dcnt[10] = sterr THEN '25'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN '211'                
			WHEN l_dcnt[5] = sterr THEN '212'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN '213'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN '221'                
			ELSE '231'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN '111' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '141'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '145'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN '111'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN '112' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN '142'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN '143' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN '144'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN '131'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '132'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN '121'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '122'
			ELSE '144'
		END
	ELSE '0'
	END AS codtypbien

## _LIBTYPBIEN
CASE 
		WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
		WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
		WHEN libnatmut = 'Adjudication' THEN 'ADJUDICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUDICATIONS
		WHEN nbvolmut > 0 THEN 'VOLUME' -- VOLUME
		WHEN vefa IS TRUE THEN -- VEFA
			CASE 
				WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN 'VEFA - INDUSTRIEL ET COMMERCIAL'
				WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'VEFA - APPART'
				WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'VEFA - MAISON'
				ELSE 'VEFA - NON DETERMINE'
			END
		WHEN nblocmut = 0 THEN -- NON BATI
			CASE
				WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN 'NON BATI - TERRAINS A BATIR'
				WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'NON BATI - TERRAINS FORESTIERS'
				WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'NON BATI - TERRAINS AGRICOLES'
				WHEN libnatmut = 'Vente terrain à bâtir' THEN 'NON BATI - TERRAINS A BATIR'
				WHEN l_dcnt[10] = sterr THEN 'NON BATI - TERRAINS A BATIR'                 
				WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN 'NON BATI - TERRAINS NATURELS'                
				WHEN l_dcnt[5] = sterr THEN 'NON BATI - TERRAINS FORESTIERS'                
				WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN 'NON BATI - TERRAINS AGRICOLES'                
				WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN 'NON BATI - TERRAINS ARTIFICIALISES'                
				ELSE 'NON BATI - TERRAINS MIXTES'
				-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
			END
		WHEN nblocmut > 0 THEN -- BATI
			CASE
				WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
				WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'BATI - BIEN AGRICOLE'
				WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'BATI - BIEN FORESTIER'                            
				-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
				WHEN nblocact > 0 THEN
					CASE 
						WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
						WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN 'BATI - INDUSTRIEL ET COMMERCIAL' 
					END
				WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - DEPENDANCE LOGEMENT'
				WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN 'BATI - LOGEMENT MIXTE' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
				WHEN sbati < 9 THEN 'BATI - BATI INDEFINI'
				WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISONS'
				WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISON'
				WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPARTS'
				WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPART'
				ELSE 'BATI - NON DETERMINE'
			END
		ELSE 'NON DETERMINE'
	END AS libtypbien

## CREER_AGGREGAT_MEDIANE_10
CREATE OR REPLACE FUNCTION centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$  
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;

CREATE OR REPLACE FUNCTION mediane_0(anyarray)
  RETURNS anyelement AS
$BODY$  
  SELECT centile($1, 50);
$BODY$
  LANGUAGE sql;
  
CREATE OR REPLACE FUNCTION premier_quartile_0(anyarray)
  RETURNS anyelement AS
$BODY$  
  SELECT centile($1, 25);
$BODY$
  LANGUAGE sql;
  
CREATE OR REPLACE FUNCTION dernier_quartile_0(anyarray)
  RETURNS anyelement AS
$BODY$  
  SELECT centile($1, 75);
$BODY$
  LANGUAGE sql;

DROP AGGREGATE IF EXISTS mediane(NUMERIC);
CREATE aggregate mediane(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = mediane_0
);

DROP AGGREGATE IF EXISTS premier_quartile(NUMERIC);
CREATE aggregate premier_quartile(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = premier_quartile_0
);

DROP AGGREGATE IF EXISTS dernier_quartile(NUMERIC);
CREATE aggregate dernier_quartile(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = dernier_quartile_0
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
SELECT anneemut, mediane({0}) 
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
SELECT mediane({0}) 
FROM (
	SELECT * {5}
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] AND anneemut >= {2} AND anneemut <= {3}
	) t
{4};

## CALCULER_PQ_PAR_ANNEE
SELECT anneemut, premier_quartile({0}) 
FROM (
	SELECT * {3} 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[]
	) t
{2}
GROUP BY anneemut;

## CALCULER_PQ_MULTI_ANNEE
SELECT premier_quartile({0}) 
FROM (
	SELECT * {5}
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] AND anneemut >= {2} AND anneemut <= {3}
	) t
{4};

## CALCULER_DQ_PAR_ANNEE
SELECT anneemut, dernier_quartile({0}) 
FROM (
	SELECT * {3} 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[]
	) t
{2}
GROUP BY anneemut;

## CALCULER_DQ_MULTI_ANNEE
SELECT dernier_quartile({0}) 
FROM (
	SELECT * {5}
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] AND anneemut >= {2} AND anneemut <= {3}
	) t
{4};




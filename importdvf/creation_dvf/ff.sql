## CREER_FONCTION_MILLESIME_MAX
CREATE OR REPLACE FUNCTION millesime_max()
RETURNS INTEGER AS
  $BODY$
	/*
   Retourne le millésime le plus récent des Fichiers fonciers existant
  */
  BEGIN
	RETURN {0};
  END;
  $BODY$
  LANGUAGE plpgsql;

## CREER_FONCTION_MILLESIME_MIN  
CREATE OR REPLACE FUNCTION millesime_min()
RETURNS INTEGER AS
  $BODY$
	/*
   Retourne le millésime le plus ancien des Fichiers fonciers existant
  */
  BEGIN
	RETURN {0};
  END;
  $BODY$
  LANGUAGE plpgsql
  
## CREER_FONCTION_CORRECTION_JDATAT
CREATE OR REPLACE FUNCTION correction_jdatat(text)
  RETURNS TEXT AS
  $BODY$
	/*
   Rectifie les erreurs FF pour jdatat

   exemples : 
	SELECT correction_jdatat('31122012');
	>> 31122012

	SELECT correction_jdatat('31022013');
	>> 28022013

	SELECT correction_jdatat('31027000');
	>> NULL

			  */
  
  DECLARE 
		jour VARCHAR;
		mois VARCHAR;
		annee VARCHAR;
  BEGIN
	IF $1 ~ '^[0-9]{{8}}$' THEN
		jour := substring($1,1,2);
		mois := substring($1,3,2);
		annee := SUBSTRING($1,5,4);
		IF annee::INTEGER > millesime_max() OR annee::INTEGER = 0 THEN RETURN NULL; END IF;
		IF mois IN('04','06','09','11') AND jour = '31' THEN jour := '30'; END IF;
		IF mois = '02' AND jour IN ('29','30','31') THEN jour := '28'; END IF;
		return jour || mois || annee;
	ELSE
		RETURN NULL;
	END IF;
  END;
  $BODY$
  LANGUAGE plpgsql
  
## COPIER_TABLE_AVEC_CREATION_JDATATDVF
DROP TABLE IF EXISTS {0}.tmp_{1}ff{2}_avec_jdatatdvf;
CREATE TABLE {0}.tmp_{1}ff{2}_avec_jdatatdvf AS
(
SELECT *, correction_jdatat(jdatat) as jdatatdvf FROM {0}.{1}ff{2}i
);

## _COMPLEMENT_DATES_MILLESIME_DEPUIS_AUTRE_MILLESIME
UPDATE {0}.tmp_{1}ff{2}_avec_jdatatdvf c
SET jdatatdvf=t.jdatatdvf
FROM (SELECT {3}, jdatatdvf, idprocpte FROM {0}.tmp_{1}ff{4}_avec_jdatatdvf WHERE jdatatdvf IS NOT NULL AND convertir_date(jdatatdvf) < '{2}-01-01'::DATE) t
WHERE c.jdatatdvf is NULL AND c.{3} = t.{3} AND c.idprocpte = t.idprocpte;

## _COMPLEMENT_DATES_MANQUANTES_AVEC
UPDATE {0}.tmp_{1}ff{2}_avec_jdatatdvf c
SET jdatatdvf='{3}'
WHERE c.jdatatdvf IS NULL

## _CREATION_TABLE_TMP_BIENS_A_CORRIGER
CREATE TABLE {0}.tmp_biens_a_corriger (
{1} VARCHAR(20), 
jdatatdvf VARCHAR(8), 
idprocpte VARCHAR(30), 
date_a_affecter VARCHAR(8), 
millesime INTEGER
);

## _INSERTION_BIENS_A_CORRIGER_ETAPE1
INSERT INTO {0}.tmp_biens_a_corriger({1}, jdatatdvf, idprocpte, date_a_affecter, millesime)
(
	SELECT t1.{1}, t1.jdatatdvf, t1.idprocpte, '0101{2}'::VARCHAR AS date_a_affecter, {3} AS millesime 
	FROM {0}.tmp_{4}ff{3}_avec_jdatatdvf t1    
	JOIN {0}.tmp_{4}ff{5}_avec_jdatatdvf t2
	ON t1.{1} = t2.{1} AND t1.jdatatdvf = t2.jdatatdvf
	LEFT JOIN {0}.tmp_biens_a_corriger t3
	ON t1.{1} = t3.{1} AND t1.jdatatdvf = t3.jdatatdvf AND t3.millesime = {3}                 
	WHERE t1.idprocpte != t2.idprocpte AND t3.{1} IS NULL
); 

## _INSERTION_BIENS_A_CORRIGER_ETAPE2
INSERT INTO {0}.tmp_biens_a_corriger({1}, jdatatdvf, idprocpte, date_a_affecter, millesime)
(
	SELECT t1.{1}, t1.jdatatdvf, t1.idprocpte, '0101{2}' AS date_a_affecter, {3} AS millesime 
	FROM {0}.tmp_{4}ff{3}_avec_jdatatdvf t1
	JOIN {0}.tmp_biens_a_corriger t2
	ON t1.{1} = t2.{1} AND t1.jdatatdvf = t2.jdatatdvf AND t1.idprocpte = t2.idprocpte
	WHERE t2.millesime = {5} AND t2.date_a_affecter = '0101{2}'
);

## _CORRECTION_DATES
UPDATE {0}.tmp_{1}ff{2}_avec_jdatatdvf c
SET jdatatdvf = t.date_a_affecter
FROM {0}.tmp_biens_a_corriger t
WHERE c.{3} = t.{3} AND c.jdatatdvf = t.jdatatdvf AND millesime = {2};

## _AJOUTER_CHAMP_CCTHP_ET_DCAPEC
CREATE TABLE {0}.{1} AS (
SELECT t1.*, t2.ccthp AS ccthp_recalcule,
	CASE 
		WHEN dcapec~E'^\\d.*' AND dcapec!~E'^0.*' THEN substring(dcapec FROM E'^(\\d).*')
		WHEN dcapec~'^0[1-9]' THEN substring(dcapec FROM '^0([1-9])')
		ELSE NULL 
	END AS dcapec_recalcule
FROM {0}.tmp_localff{2}_avec_jdatatdvf t1
LEFT JOIN (SELECT idlocal, ccthp, dcapec FROM {0}.pevff{2}i WHERE dnupev = '001') t2 
ON t1.idlocal = t2.idlocal
);

## _AJOUTER_CHAMPS_NB_DEPENDANCES
CREATE TABLE {0}.{1} AS (
	SELECT t1.*, dnbsam_recalcule, dnbcha_recalcule, 
		dnbcu8_recalcule, dnbcu9_recalcule, 
		dnbsea_recalcule, dnbann_recalcule,
		nbannexe_recalcule, nbgarpark_recalcule,
		nbagrement_recalcule, nbterrasse_recalcule,
		nbpiscine_recalcule
	FROM {0}.tmp_localff{2}_avec_ccthp_et_dcapec t1
	LEFT JOIN (
					SELECT
						idlocal,
						SUM(dnbsam::INTEGER) AS dnbsam_recalcule,
						SUM(dnbcha::INTEGER) AS dnbcha_recalcule,
						SUM(dnbcu8::INTEGER) AS dnbcu8_recalcule,
						SUM(dnbcu9::INTEGER) AS dnbcu9_recalcule,
						SUM(dnbsea::INTEGER) AS dnbsea_recalcule,
						SUM(dnbann::INTEGER) AS dnbann_recalcule
					FROM {0}.pevprincff{2}i  
					GROUP BY idlocal
	) t2
	ON t1.idlocal = t2.idlocal
	LEFT JOIN (
					 SELECT
						 idlocal,
						SUM(CASE WHEN cconad IN ('CV','GR','BC','BD','CD','CL','DC','GC','JH','PI','RS') THEN 1 ELSE 0 END) AS nbannexe_recalcule,
						SUM(CASE WHEN cconad IN ('GA','BX','GP','PK') THEN 1 ELSE 0 END) AS nbgarpark_recalcule,
						SUM(CASE WHEN cconad IN ('PA','SR') THEN 1 ELSE 0 END) AS nbagrement_recalcule,
						SUM(CASE WHEN cconad IN ('TR','TT') THEN 1 ELSE 0 END) AS nbterrasse_recalcule,
						SUM(CASE WHEN cconad IN ('PS') THEN 1 ELSE 0 END) AS nbpiscine_recalcule
					FROM
					(
						SELECT idlocal,cconad FROM {0}.pevdepff{2}i
						UNION ALL SELECT idlocal,cconad1 FROM {0}.pevprincff{2}i WHERE cconad1 IS NOT NULL
						UNION ALL SELECT idlocal,cconad2 FROM {0}.pevprincff{2}i WHERE cconad2 IS NOT NULL
						UNION ALL SELECT idlocal,cconad3 FROM {0}.pevprincff{2}i WHERE cconad3 IS NOT NULL
						UNION ALL SELECT idlocal,cconad4 FROM {0}.pevprincff{2}i WHERE cconad4 IS NOT NULL
					) t_dependance
					GROUP BY idlocal
	
			) t3
	ON t1.idlocal = t3.idlocal
);

## _RECUPERER_IDPROCPTES_INEXISTANTS_DANS_MILLESIME
SELECT t1.idprocpte 
FROM {0}.localff{1}i t1 
LEFT JOIN {0}.proprioff{1}i t2 
ON t1.idprocpte = t2.idprocpte 
WHERE t2.idprocpte IS NULL
GROUP BY t1.idprocpte

UNION

SELECT t1.idprocpte 
FROM {0}.parcelleff{1}i t1 
LEFT JOIN {0}.proprioff{1}i t2 
ON t1.idprocpte = t2.idprocpte 
WHERE t2.idprocpte IS NULL
GROUP BY t1.idprocpte

## _AJOUTER_UN_IDPROCPTE_INEXISTANT_DANS_TABLE_PROPRIO
INSERT INTO {0}.proprioff{1} DEFAULT VALUES;
UPDATE {0}.proprioff{1}
SET idprocpte='{2}', ccodro = 'B', ddenom='PROPRIETAIRE NON DEFINI'
WHERE idprocpte IS NULL;
               
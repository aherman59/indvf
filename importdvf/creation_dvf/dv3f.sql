## CREER_FONCTION_SELECTION_MILLESIME_PROCHE
CREATE OR REPLACE FUNCTION selection_millesime_proche(INTEGER[], DATE, BOOLEAN)
  RETURNS INTEGER AS
  $BODY$
	/*

		Si boolean = TRUE
   Recupère l'entier du tableau le plus proche et strictement supérieur à l'année de la date
   S'il n'y en a pas, il récupère l'entier le plus proche et inférieur ou égal à l'année de la date.

		Si boolean = FALSE
   Recupère l'entier du tableau le plus proche et inférieur ou égal à l'année de la date
   S'il n'y en a pas, il récupère l'entier le plus proche et superieur ou égal à l'année de la date.
  */
  
  DECLARE         
		annee INTEGER;
		ecartsup INTEGER;
		ecartinf INTEGER;
		millesimesup INTEGER;
		millesimeinf INTEGER;
  begin
	annee := EXTRACT(YEAR FROM $2);
	ecartsup := 9999;
	ecartinf := 9999;
	millesimesup := NULL;
	millesimeinf := NULL;
	FOR i IN 1..array_upper($1,1)
	LOOP
			IF $1[i] > annee AND ($1[i] - annee) < ecartsup THEN ecartsup := $1[i] - annee; millesimesup := $1[i]; END IF;
			IF $1[i] <= annee AND (annee - $1[i]) < ecartinf THEN ecartinf := annee - $1[i]; millesimeinf := $1[i]; END IF;        
	END LOOP;

	IF $3 THEN
		IF millesimesup IS NOT NULL THEN
		RETURN millesimesup;
		ELSE RETURN millesimeinf;
		END IF;
	ELSE
		IF millesimeinf IS NOT NULL THEN
		RETURN millesimeinf;
		ELSE RETURN millesimesup;
		END IF;
	END IF;     
  END;
  $BODY$
  LANGUAGE plpgsql;

## CREER_FONCTION_STRUCTURER_CODTYPPRO  
CREATE OR REPLACE FUNCTION structurer_codtyppro(VARCHAR)
RETURNS VARCHAR AS
  $BODY$
	/*
   Retourne le codtyppro sans doublon et dans l'ordre alphabétique
  */
  DECLARE 
	codes VARCHAR[];
	code_courant VARCHAR;
  BEGIN
	IF $1 = '' OR $1 IS NULL THEN RETURN NULL; EnD IF;
	codes := ARRAY[]::VARCHAR[];
	FOR i IN 1..char_length($1) By 2
		LOOP
			code_courant := SUBSTRING($1 from i for 2);
			SELECT array_append(codes, code_courant) INTO codes;                      
		END LOOP;
	RETURN array_to_string(array_sort_unique(codes), '');
  END;
  $BODY$
  LANGUAGE plpgsql;  

## CREATION_TABLE_CROISEE_FF_DVF
CREATE TABLE {0}.{1}_dvf_ff_par_date_mutation AS
(    
    SELECT {2}, datemut, max(COALESCE(dvf, 0)) As dvf, 
		array_remove(array_agg(DISTINCT ff::integer), NULL) as ff, 
		rank() OVER w AS ordre, sum(CASE WHEN max(COALESCE(dvf, 0)) > 0 THEN 1 ELSE 0 END) OVER w AS ordremutdvf, 
		array_remove(array_agg(DISTINCT idprocpte::VARCHAR), NULL) as idprocpte
    FROM
        (
            SELECT {2} AS {2}, datemut AS datemut, nbmutjour AS dvf, NULL As ff, NULL AS idprocpte
            FROM {6}.{7} {4}
            
            UNION ALL
            
			{5}
			
        ) t
    GROUP BY {2}, datemut
    WINDOW w AS (PARTITION BY {2} ORDER BY datemut)
    ORDER BY {2}, datemut    
);

## _SOUS_REQUETE_TABLE_CROISEE_FF_DVF
SELECT t{5}.{3} AS {2}, convertir_date(t{5}.jdatatdvf) AS datemut, NULL As dvf, '{5}' AS ff, idprocpte 
FROM (SELECT f.* FROM {6}.{7} d LEFT JOIN {0}.{1}ff{5} f ON d.{2} = f.{3}) t{5}

## CREATION_TABLE_SYNTHESE_FFANS
CREATE TABLE {0}.{1}_synthese_ffans AS
(
    SELECT nextval('{0}.idach_idvend_seq') AS idach, nextval('{0}.idach_idvend_seq') AS idvend, t.{2}, t.datemut, t.ffanvend, t.fiabilitev, t.idprocptev, t.ffanach, t.fiabilitea, t.idprocptea, t.ffanref, t.stabilite_av || t.stabilite_ap as stabilite
    FROM
    (
        SELECT t1.{2}, t1.datemut,
            CASE
                WHEN t2.{2} IS NOT NULL AND t2.ff != ARRAY[]::INTEGER[] THEN selection_millesime_proche(t2.ff, t1.datemut, FALSE)
                ELSE NULL        
            END AS ffanvend,
            CASE
                WHEN t2.{2} IS NOT NULL AND t2.ff != ARRAY[]::INTEGER[] AND t1.dvf > 1 THEN 1
                WHEN t2.{2} IS NOT NULL AND t2.ff != ARRAY[]::INTEGER[] AND t1.dvf = 1 AND t1.datemut >= (millesime_max()||'-01-01')::DATE THEN 2
                WHEN t2.{2} IS NOT NULL AND t2.ff != ARRAY[]::INTEGER[] AND t1.dvf = 1 AND t1.datemut < (millesime_max()||'-01-01')::DATE THEN 3
                ELSE 0
            END AS fiabilitev,
            CASE
                WHEN t2.{2} IS NOT NULL AND t2.ff != ARRAY[]::INTEGER[] THEN t2.idprocpte[1]
                ELSE NULL        
            END AS idprocptev,
            CASE 
                WHEN t1.ff != ARRAY[]::INTEGER[] THEN selection_millesime_proche(t1.ff, t1.datemut, TRUE)
                ELSE NULL 
            END AS ffanach,
            CASE
                WHEN t1.ff != ARRAY[]::INTEGER[] AND t1.dvf = 1 THEN 4
                WHEN t1.ff != ARRAY[]::INTEGER[] AND t1.dvf > 1 THEN 1
                ELSE 0
            END AS fiabilitea,
            CASE
                WHEN t1.ff != ARRAY[]::INTEGER[] THEN t1.idprocpte[1]
                ELSE NULL        
            END AS idprocptea,
            CASE 
                WHEN t1.ff != ARRAY[]::INTEGER[] THEN selection_millesime_proche(t1.ff, t1.datemut, TRUE)
                WHEN t3.{2} IS NOT NULL AND t3.millesimes != ARRAY[]::INTEGER[] THEN selection_millesime_proche(t3.millesimes, t1.datemut, TRUE)        
                ELSE NULL
            END AS ffanref,
             CASE 
                WHEN {3} t1.ordremutdvf = 1 AND t1.ordre <= 2 AND NOT (millesime_min()=ANY(t3.millesimes)) THEN 'A'
                ELSE 'N'
            END as stabilite_av,            
            CASE 
                WHEN t2bis.{2} IS NULL AND NOT (millesime_max()=ANY(t3.millesimes)) THEN 'D'
                ELSE 'N'
            END as stabilite_ap
        FROM 
            {0}.{1}_dvf_ff_par_date_mutation t1
        LEFT JOIN 
            {0}.{1}_dvf_ff_par_date_mutation t2 
        ON t1.{2} = t2.{2} AND t1.ordre = t2.ordre + 1
        LEFT JOIN 
            {0}.{1}_dvf_ff_par_date_mutation t2bis 
        ON t1.{2} = t2bis.{2} AND t1.ordre = t2bis.ordre - 1    
        LEFT JOIN (SELECT {2}, array_agg(DISTINCT ff) AS millesimes FROM (SELECT {2}, unnest(ff) AS ff FROM {0}.{1}_dvf_ff_par_date_mutation) t GROUP BY {2}) t3    
        ON t1.{2} = t3.{2}
        {4}
        WHERE t1.dvf > 0
    ) t
);

## _SOUS_REQUETE_TABLE_SYNTHESE_FFANS_JOINTURE_PARCELLE
LEFT JOIN (SELECT idsec FROM {0}.parcelleff2009 GROUP BY idsec) t4
ON SUBSTRING(t1.idpar, 1, 10) = t4.idsec

## CREATION_TABLE_TEMPORAIRE_DROITS_ACH_VEND
CREATE TABLE {0}.tmp_achvend AS
(
	SELECT nextval('public.ida_idv_seq') AS idav, ffnomprop, ffsiren, ffcatpm, ffcatjur, persmorale, 
		COALESCE(replace(ffnomprop, '_', ''),'') || '_' 
		|| COALESCE(replace(ffsiren, '_', ''),'') || '_' 
		|| COALESCE(replace(ffcatpm, '_', ''),'') || '_' 
		|| COALESCE(replace(ffcatjur, '_', ''),'') as idavinvar,
		regexp_replace(regexp_replace(ffnomprop, '[-''\.]', ' '), '\s+', ' ') AS ffnomproph,
		array_sort_unique(fusion_array(l_id)) AS l_id
	FROM 
	(
	
	{1}
	
	UNION ALL
	
	{2}
	
	) tt
	GROUP BY ffnomprop, ffsiren, ffcatpm, ffcatjur, persmorale
) ;

## _SOUS_REQUETE_TABLE_TEMPORAIRE_ACH_VEND

        SELECT 
           ddenom as ffnomprop, 
           dsiren AS ffsiren,
           codnom AS ffcatpm, 
           dforme AS ffcatjur,
           CASE 
            WHEN ddenom = '_X_' THEN 'X'
            WHEN codgrm IN('1','2','3','4','5','9') THEN 'A'
            ELSE 'B'
           END AS persmorale, 
           array_agg(DISTINCT idvend) AS l_id
        FROM {0}.{1}_synthese_ffans t
        JOIN {0}.proprioff{2} t{2}
        ON t.idprocptev = t{2}.idprocpte
        WHERE t.ffanvend = {2} AND t{2}.ccodro IN('B','C','F','N','P','V','X')
        GROUP BY ddenom, dsiren, codnom, dforme, codgrm

        UNION ALL

        SELECT 
           ddenom as ffnomprop, 
           dsiren AS ffsiren,
           codnom AS ffcatpm, 
           dforme AS ffcatjur,
           CASE 
            WHEN ddenom = '_X_' THEN 'X'
            WHEN codgrm IN('1','2','3','4','5','9') THEN 'A'
            ELSE 'B'
           END AS persmorale, 
           array_agg(DISTINCT idach) AS l_id
        FROM {0}.{1}_synthese_ffans t
        JOIN {0}.proprioff{2} t{2}
        On t.idprocptea = t{2}.idprocpte
        WHERE t.ffanach = {2} AND t{2}.ccodro IN('B','C','F','N','P','V','X')
        GROUP BY ddenom, dsiren, codnom, dforme, codgrm

		
## AJOUT_IDENTITE_GROUPES_ACH_VEND
CREATE TABLE {0}.tmp_achvend_groupe AS
(
	SELECT ta.*, identited, nbidassocd 
	FROM {0}.tmp_achvend ta
	LEFT JOIN 
	( 
		
		SELECT identited, array_length(l_idav, 1) AS nbidassocd, unnest(l_idav) AS idav
		FROM
		 (
			SELECT 'groupe' || LPAD(nextval('public.groupe_seq')::TEXT , 7, '0') AS identited, array_sort_unique(array_cat(t1.l_idav, t2.l_idav)) as l_idav 
			FROM 
				(SELECT ffsiren, array_agg(idav) As l_idav 
				FROM {0}.tmp_achvend 
				WHERE ffsiren IS NOT NULL 
				GROUP BY ffsiren 
				HAVING count(idav) > 1 
			)t1 
			FULL JOIN
				(SELECT (array_remove(array_agg(ffsiren), NULL))[1] AS ffsiren, array_agg(idav) As l_idav
				FROM {0}.tmp_achvend                
				GROUP BY ffnomproph, ffcatpm
				HAVING count(*) > 1 AND COALESCE(array_length(array_remove(array_agg(ffsiren), NULL), 1), 0) <= 1
			) t2 
			ON t1.ffsiren = t2.ffsiren
		)t
	) tb
	ON ta.idav = tb.idav
	ORDER BY identited, ffnomprop
);

## CREATION_TABLE_ACHETEUR_VENDEUR_DEPARTEMENTALE
CREATE TABLE {0}.acheteur_vendeur AS
	(
		SELECT tx.*, 
			CASE 
				WHEN ffnomprop = '_X_' THEN 'X1'        
				WHEN ty.idav IS NOT NULL AND NOT (ty.l_codtyppro = ARRAY[]::VARCHAR[]) 
					THEN array_to_string(ty.l_codtyppro, '')
				WHEN ty.idav IS NOT NULL 
					AND 'Modification Parcelle' = ANY(ty.l_autre) 
					AND (
					ffcatjur IN ('5426', '6521', '6540', '5426', '6539', '6599')
					OR
					ffcatpm IN ('SOCIETE A RESPONSABILITE LIMITEE', 'SOCIETE CIVILE DE PLACEMENT IMMOBILIER',
						'SOCIETE CIVILE FONCIERE', 'SOCIETE CIVILE IMMOBILIERE', 'SOCIETE CIVILE PARTICULIERE',
						'SOCIETE EN NOM COLLECTIF', 'SOCIETE FONCIERE', 'SOCIETE INDUSTRIELLE', 'SOCIETE CIVILE AUTRE')
					) THEN 'F5'
				WHEN ty.idav IS NOT NULL AND 'Vendeur local neuf apparu' = ANY(ty.l_autre) THEN 'F6'
				WHEN ffcatjur IN ('7172', '7179', '7171', '7113', '7150', '7160', '7120', '7111') THEN 'P1'
				WHEN ffcatjur = '7230' THEN 'P2'
				WHEN ffcatjur = '7220' THEN 'P3'
				WHEN ffcatjur IN ('7346', '7347', '7348') THEN 'P4'
				WHEN ffcatjur In ('7210', '7312') THEN 'P5'
				WHEN ffcatjur IN ('7225', '7229') THEN 'P6'
				WHEN ffcatjur IN ('7190', '7112', '4150') THEN 'P0'
				WHEN ffcatjur In ('5430', '5530') THEN 'F3'
				WHEN ffcatjur In ('6541', '6543') THEN 'F6'
				WHEN ffcatjur IN ('5546', '5547', '5646', '5647', '7371', '5560') THEN 'F1'
				WHEN ffcatjur IN ('1600', '5431', '5432', '5631', '5632', '6316', '6317', '6318', '6532', '6533', '6534', '6535', '6536', '6538') THEN 'A1'
				WHEN ffcatjur IN ('7322', '7323', 'F003') THEN 'M0'  
				WHEN ffcatpm IN ('ETAT ETRANGER', 'ETAT FRANCAIS') THEN 'P1'
				WHEN ffcatpm IN ('CONSEIL REGIONAL', 'LYCEE') THEn 'P2'
				WHEN ffcatpm IN ('CONSEIL GENERAL', 'COLLEGE') THEN 'P3'
				WHEN ffcatpm IN ('INTERCOMMUNALITE', 'SYNDICAT INTERCOMMUNAL') THEN 'P4'
				WHEN ffcatpm IN ('COMMUNE', 'CENTRE COMMUNAL D''ACTION SOCIALE') THEN 'P5'
				WHEN ffcatpm IN ('CENTRE DE GESTION') THEN 'P6'
				WHEN ffcatpm IN ('SERVICE D''INCENDIE ET DE SECOURS', 'REGIE', 'METEO FRANCE', 'LA MASSE DES DOUANES',
						'ETABLISSEMENT PUBLIC SOCIAL', 'ETABLISSEMENT D''ENSEIGNEMENT', 'ETABLISSEMENT HOSPITALIER',
						'ETABLISSEMENT PUBLIC CULTUREL', 'AUTRE ETABLISSEMENT PUBLIC', 
						'CENTRE NATIONAL DE LA RECHERCHE SCIENTIFIQUE', 'CHAMBRE CONSULAIRE', 
						'OFFICE NATIONAL D''ETUDES ET DE RECHERCHES AEROSPATIALES', 'POLE EMPLOI', 'CAISSE DES DEPOTS ET CONSIGNATIONS',
						'INSTITUT GEOGRAPHIQUE NATIONAL', 'CHARBONNAGES DE FRANCE', 'INSTITUT NATIONAL DE LA PROPRIETE INDUSTRIELLE',
						'ASSURANCE MALADIE', 'CROUS', 'ALLOCATIONS FAMILIALES', 'AGENCE FRANCAISE DE DEVELOPPEMENT', 
						'AGENCE FRANCAISE DE SECURITE SANITAIRE DES PRODUITS DE SANTE', 'AGENCE NATIONALE DE L''HABITAT',
						'BUREAU DE RECHERCHES GEOLOGIQUES ET MINIERES', 'CEMAGREF','CENTRE NATIONAL D''ETUDES SPATIALES', 'CEREMA',
						'CENTRE SCIENTIFIQUE ET TECHNIQUE DU BATIMENT', 'COMMISSARIAT A L''ENERGIE ATOMIQUE', 'COMMISSION SYNDICALE DE LA SECTION',
						'INSTITUT NATIONAL DE L''ORIGINE ET DE LA QUALITE', 'INSTITUT NATIONAL DE LA STATISTIQUE ET DES ETUDES ECONOMIQUES',
						'INSTITUT NATIONAL DE RECHERCHE EN INFORMATIQUE ET AUTOMATIQUE','INSTITUTION DE GESTION SOCIALE DES ARMEES',
						'SERVICE HYDROGRAPHIQUE ET OCEANOGRAPHIQUE DE LA MARINE', 'UNION DES GROUPEMENTS D''ACHATS PUBLICS'
						) THEN 'P0'
				WHEN ffcatpm IN ('SOCIETE D''ECONOMIE MIXTE') THEN 'F4'
				WHEN ffcatpm In ('ETABLISSEMENT PUBLIC FONCIER') THEN 'F2'
				WHEN ffcatpm In ('SOCIETE D''AMENAGEMENT FONCIER ET D''ETABLISSEMENT RURAL') THEN 'F3'
				WHEN ffcatpm IN ('SOCIETE CIVILE DE CONSTRUCTION VENTE') THEn 'F6'
				WHEN ffcatpm IN ('ASSOCIATION SOCIALE', 'OFFICE HLM', 'SOCIETE DE GESTION') THEN 'F1'
				WHEN ffcatpm IN ('GROUPEMENT FONCIER AGRICOLE', 'GROUPEMENT FONCIER RURAL', 'INSTITUT NATIONAL DE LA RECHERCHE AGRONOMIQUE',
						'SOCIETE D''INTERET COLLECTIF AGRICOLE', 'STRUCTURE AGRICOLE', 'SYNDICAT AGRICOLE') THEN 'A1'
				WHEN ffcatpm IN ('GROUPEMENT FORESTIER', 'GROUPEMENT SYNDICAL FORESTIER') THEN 'A2'
				WHEN ffcatpm IN ('AGENCE DE L''ENVIRONNEMENT ET DE LA MAITRISE DE L''ENERGIE', 'CONSERVATOIRE NATUREL',
						 'OFFICE NATIONAL DES FORETS', 'PARC NATUREL REGIONAL') THEN 'A3'
				WHEN ffcatpm IN ('CONCESSIONNAIRE AUTOROUTIER') THEN 'R1'
				WHEN ffcatpm IN ('SNCF/RFF OU AUTRE RESEAU FERRE') THEN 'R2'
				WHEN ffcatpm IN ('STRUCTURE AERIENNE') THEN 'R3'
				WHEN ffcatpm IN ('VOIES NAVIGABLES DE FRANCE', 'AGENCE DE L''EAU', 'PORT AUTONOME') THEN 'R4'
				WHEN ffcatpm IN ('EDF/GDF') THEN 'R5'
				WHEN ffcatpm IN ('FRANCE TELECOM') THEN 'R0'
				WHEN ffcatpm IN ('ASSOCIATION IMMOBILIERE', 'BANQUE OSEO', 'CAISSE DES DEPOTS ET CONSIGNATIONS',
						'CENTRE COMMERCIAL', 'CHARBONNAGES DE FRANCE','COOPERATIVE AGRICOLE',
						'ENTREPRISE UNIPERSONNELLE A RESPONSABILITE LIMITEE','LA POSTE','SOCIETE ANONYME',
						'SOCIETE AUTRE','STRUCTURE CULTUELLE','SYNDICAT AUTRE','AGENCE IMMOBILIERE',
						'ALLOCATIONS FAMILIALES','ASSOCIATION AUTRE','ASSOCIATION D''EDUCATION POPULAIRE',
						'ASSOCIATION DE CHASSE ET PECHE','ASSOCIATION DE GESTION','ASSOCIATION FAMILIALE',
						'ASSOCIATION FONCIERE','ASSOCIATION SPORTIVE', 'ASSOCIATION SYNDICALE',
						'ASSURANCE MALADIE', 'CENTRE MEDICAL', 'COPROPRIETE', 'CROUS', 'ETABLISSEMENT SCIENTIFIQUE', 
						'INSTITUT GEOGRAPHIQUE NATIONAL', 'INSTITUT NATIONAL DE LA PROPRIETE INDUSTRIELLE', 
						'MAISON DE RETRAITE PRIVEE', 'OFFICE NATIONAL D''ETUDES ET DE RECHERCHES AEROSPATIALES',
						'POLE EMPLOI', 'STRUCTURE CULTURELLE', 'SYNDICAT D''INITIATIVE', 'TELEDIFFUSION DE FRANCE', 
						'AGENCE D''URBANISME', 'PERSONNE MORALE PRIVEE', 'ASSOCIATION FONCIERE', 
						'CONSEIL D''ARCHITECTURE D''URBANISME ET DE L''ENVIRONNEMENT', 'MAISON DE RETRAITE',
						'PROPRIETAIRES EN BIENS NON DELIMITES (BND)') THEN 'M0'
				WHEN ty.idav IS NOT NULL AND 'Code1594H' = ANY(ty.l_autre) THEN 'F0'
				ELSE 'M0'
			END as codtyppro
		FROm {0}.tmp_achvend_groupe tx
		LEFT JOIN
		(
			SELECT ta.idav, array_sort_unique(array_remove(fusion_array(tb.l_codtyppro),NULL)) as l_codtyppro,
				array_sort_unique(array_remove(fusion_array(tb.l_autre), NULL)) AS l_autre
			FROM {0}.tmp_achvend_groupe ta
			JOIN
			(
				SELECT id, array_agg(codtyppro)as l_codtyppro, array_agg(autre) AS l_autre
				FROM
				( -- locaux
					SELECT idvend as id, 'F7' as codtyppro, NULL AS autre 
					FROM {0}.local_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idloc =ANY(t2.l_idlocmut) AND t1.datemut = t2.datemut
					WHERE '1594FQB' = ANY(l_artcgi)
		
					UNION ALL
		
					SELECT idvend as id, 'F6' as codtyppro, NULL AS autre 
					FROM {0}.local_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idloc =ANY(t2.l_idlocmut) AND t1.datemut = t2.datemut
					WHERE ARRAY['1594FQA*2','257-7-1*2']::VARCHAR[] && l_artcgi

					UNION ALL
		
					SELECT idvend as id, 'F1' as codtyppro, NULL AS autre 
					FROM {0}.local_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idloc =ANY(t2.l_idlocmut) AND t1.datemut = t2.datemut
					WHERE ARRAY['296-1-a-*2','296-1-b-*2']::VARCHAR[] && l_artcgi
		
					UNION ALL
		
					SELECT idach as id, 'A1' as codtyppro, NULL AS autre 
					FROM {0}.local_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idloc =ANY(t2.l_idlocmut) AND t1.datemut = t2.datemut
					WHERE ARRAY['1594FQE','1594FQE I','1594FQE II']::VARCHAR[] && l_artcgi
		
					UNION ALL
		
					SELECT idach as id, 'A2' as codtyppro, NULL AS autre 
					FROM {0}.local_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idloc =ANY(t2.l_idlocmut) AND t1.datemut = t2.datemut
					WHERE '1137'=ANY(l_artcgi)
		
					UNION ALL
		
					SELECT idach as id, NULL as codtyppro, 'Code1594H' AS autre 
					FROM {0}.local_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idloc =ANY(t2.l_idlocmut) AND t1.datemut = t2.datemut
					WHERE '1594H'=ANY(l_artcgi)
		
					UNION ALL
					
					( {2} )
					
					
					UNION ALL
					
					-- parcelles
		
					SELECT idach AS id, NULL AS codtyppro, 'Modification Parcelle' AS autre
					FROM {0}.parcelle_synthese_ffans t1
					WHERE stabilite LIKE '%D'
		
					UNION ALL 
		
					SELECT idvend AS id, NULL AS codtyppro, 'Modification Parcelle' AS autre
					FROM {0}.parcelle_synthese_ffans t1
					WHERE stabilite LIKE 'A%' 
		
					UNION ALL
		
					SELECT idvend as id, 'F7' as codtyppro, NULL AS autre 
					FROM {0}.parcelle_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idpar =ANY(t2.l_idparmut) AND t1.datemut = t2.datemut
					WHERE '1594FQB' = ANY(l_artcgi)
		
					UNION ALL 
		
					SELECT idvend as id, 'F6' as codtyppro, NULL AS autre  
					FROM {0}.parcelle_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idpar =ANY(t2.l_idparmut) AND t1.datemut = t2.datemut
					WHERE ARRAY['1594FQA*2','257-7-1*2']::VARCHAR[] && l_artcgi

					UNION ALL 
		
					SELECT idvend as id, 'F1' as codtyppro, NULL AS autre  
					FROM {0}.parcelle_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idpar =ANY(t2.l_idparmut) AND t1.datemut = t2.datemut
					WHERE ARRAY['296-1-a-*2','296-1-b-*2']::VARCHAR[] && l_artcgi
		
					UNION ALL
		
					SELECT idach as id, 'A1' as codtyppro, NULL AS autre  
					FROM {0}.parcelle_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idpar =ANY(t2.l_idparmut) AND t1.datemut = t2.datemut
					WHERE ARRAY['1594FQE','1594FQE I','1594FQE II']::VARCHAR[] && l_artcgi
		
					UNION ALL
		
					SELECT idach as id, 'A2' as codtyppro, NULL AS autre 
					FROM {0}.parcelle_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idpar =ANY(t2.l_idparmut) AND t1.datemut = t2.datemut
					WHERE '1137'=ANY(l_artcgi)
		
					UNION ALL
		
					SELECT idach as id, NULL as codtyppro, 'Code1594H' AS autre 
					FROM {0}.parcelle_synthese_ffans t1
					JOIN {1}.mutation t2
					On t1.idpar =ANY(t2.l_idparmut) AND t1.datemut = t2.datemut
					WHERE '1594H'=ANY(l_artcgi)
				) t
				GROUP BY id
			) tb
			ON tb.id = ANY(ta.l_id)
			GROUp BY idav
		) ty
		On tx.idav = ty.idav
		ORDER BY codtyppro, identited, ffnomprop
); 

## _SOUS_REQUETE_VENDEUR_LOCAL_NEUF_APPARU
SELECT idvend, NULL AS codtyppro, 'Vendeur local neuf apparu' AS autre 
FROM {0}.local_synthese_ffans t
JOIN  {0}.localff{1} t{1}
ON t.idloc = t{1}.idlocal
WHERE t.ffanref = {1} AND jannath != 0 AND (EXTRACT(YEAR FROM t.datemut) - jannath <= 1) AND stabilite LIKE 'A%'


## CREATION_TABLE_SYNTHESE_ACH_VEND
CREATE TABLE {0}.tmp_{1}_synthese_achvend AS
(
	SELECT {2}, datemut, 
		ffanvend, fiabilitev, idprocptev, 
		array_remove(array_agg(DISTINCT idv),NULL) AS l_idv, 
		array_remove(array_agg(DISTINCT nomv),NULL) AS l_nomv,
		array_to_string(array_remove(array_agg(DISTINCT codtypprov), NULL), '') AS codtypprov, 
		ffanach, fiabilitea, idprocptea, 
		array_remove(array_agg(DISTINCT ida),NULL) AS l_ida, 
		array_remove(array_agg(DISTINCT noma),NULL) AS l_noma, 
		array_to_string(array_remove(array_agg(DISTINCT codtypproa), NULL), '') AS codtypproa
	FROM(
		SELECT {2}, datemut, ffanvend, fiabilitev, idprocptev, ffanach, fiabilitea, idprocptea, 
			t2.idav as idv, t2.ffnomprop as nomv, t2.codtyppro as codtypprov, 
			t3.idav as ida, t3.ffnomprop as noma, t3.codtyppro as codtypproa    
		FROM {0}.{1}_synthese_ffans t1
		LEFT JOIN {0}.acheteur_vendeur t2 
		On idvend = ANY(t2.l_id)
		LEFT JOIN {0}.acheteur_vendeur t3 
		On idach = ANY(t3.l_id)
	)t 
	GROUP BY {2}, datemut, ffanvend, fiabilitev, idprocptev, ffanach, fiabilitea, idprocptea
); 

## _INTEGRATION_DONNEES_GESTIONNAIRE_VENDEUR
CREATE TABLE {0}.tmp_{1}_synthese_achvend_gesv AS
(
 {2}
 
 UNION ALL

SELECT t.*, 0 AS nbdroitprov, 0 AS nbdroitgesv, ARRAY[]::VARCHAR[] AS l_nomgesv{3}   
FROM {0}.tmp_{1}_synthese_achvend t
WHERE t.ffanvend IS NULL
 
);

## _INTEGRATION_DONNEES_GESTIONNAIRE_ACHETEUR
CREATE TABLE {0}.tmp_{1}_synthese_achvend_ges AS
(
 {2}
 
UNION ALL

SELECT t.*,  0 AS nbdroitproa, 0 AS nbdroitgesa, ARRAY[]::VARCHAR[] AS l_nomgesa{3}   
FROM {0}.tmp_{1}_synthese_achvend_gesv t
WHERE t.ffanach IS NULL
 
);

## _SOUS_REQUETE_RAPATRIEMENT_GESTIONNAIRE_VENDEURS

SELECT t.*, nbdroiprov, nbdroigesv, l_nomgesv{3} 
FROM {0}.tmp_{1}_synthese_achvend t 
JOIN 
(
	SELECT idprocpte,
	sum(CASE WHEN ccodro IN ('B', 'C', 'F', 'N', 'P', 'V', 'X') THEN 1 ELSE 0 END) as nbdroiprov,
	sum(CASE WHEN ccodro IN ('A', 'D', 'E', 'G', 'H', 'J', 'K', 'L', 'O', 'Q', 'R', 'S', 'T', 'U', 'W', 'Y') THEN 1 ELSE 0 END) as nbdroigesv,
	array_sort_unique(array_remove(array_agg(CASE WHEN ccodro IN ('A', 'D', 'E', 'G', 'H', 'J', 'K', 'L', 'O', 'Q', 'R', 'S', 'T', 'U', 'W', 'Y') THEN ddenom ELSE NULL END), NULL)) AS l_nomgesv
	FROM {0}.proprioff{2}
	GROUP BY idprocpte
) t{2} 
ON t.idprocptev = idprocpte
{4}        
WHERE t.ffanvend = {2}

## _SOUS_REQUETE_RAPATRIEMENT_GESTIONNAIRE_ACHETEURS

SELECT t.*, nbdroiproa, nbdroigesa, l_nomgesa{3}  
FROM {0}.tmp_{1}_synthese_achvend_gesv t 
JOIN 
(
	SELECT idprocpte,
	sum(CASE WHEN ccodro IN ('B', 'C', 'F', 'N', 'P', 'V', 'X') THEN 1 ELSE 0 END) as nbdroiproa, 
	sum(CASE WHEN ccodro IN ('A', 'D', 'E', 'G', 'H', 'J', 'K', 'L', 'O', 'Q', 'R', 'S', 'T', 'U', 'W', 'Y') THEN 1 ELSE 0 END) as nbdroigesa,
	array_sort_unique(array_remove(array_agg(CASE WHEN ccodro IN ('A', 'D', 'E', 'G', 'H', 'J', 'K', 'L', 'O', 'Q', 'R', 'S', 'T', 'U', 'W', 'Y') THEN ddenom ELSE NULL END), NULL)) AS l_nomgesa
	FROM {0}.proprioff{2}
	GROUP BY idprocpte
) t{2} 
ON t.idprocptea = idprocpte 
{4}       
WHERE t.ffanach = {2}

## CREATION_TABLE_SYNTHESE_LOCAL
CREATE TABLE {0}.tmp_local_synthese_caracteristique AS
(
 {1}
  
);

## _SOUS_REQUETE_RAPATRIEMENT_LOCAUX
SELECT 
t.idloc, t.datemut, t.ffanref,
convertir_date(correction_jdatat(jdatat)) AS ffdatemut,
CASE WHEN convertir_date(correction_jdatat(jdatat)) = t.datemut THEN TRUE ELSE FALSE END AS exactffdvf,
jannath AS ffancst,
CASE 
	WHEN jannath != 0 AND (EXTRACT(YEAR FROM t.datemut) - jannath <= 1) THEN 'neuf'
	WHEN jannath != 0 AND (EXTRACT(YEAR FROM t.datemut) - jannath < 5) THEN 'recent'
	WHEN jannath != 0 AND (EXTRACT(YEAR FROM t.datemut) - jannath > 5) THEN 'ancien'
	ELSE 'non defini'
END AS anciennete,
{1}
FROM {0}.local_synthese_ffans t
JOIN  {0}.localff{2} t{2}
On t.idloc = t{2}.idlocal
WHERE t.ffanref = {2}

## CREATION_TABLE_SYNTHESE_PARCELLE
CREATE TABLE {0}.tmp_parcelle_synthese_caracteristique AS
(
 {1}
  
);

## _SOUS_REQUETE_RAPATRIEMENT_PARCELLES
SELECT 
t.idpar, t.datemut, t.ffanref,
convertir_date(correction_jdatat(jdatat)) AS ffdatemut,
CASE WHEN convertir_date(correction_jdatat(jdatat)) = t.datemut THEN TRUE ELSE FALSE END AS exactffdvf,        
{1}
FROM {0}.parcelle_synthese_ffans t
JOIN  {0}.parcelleff{2} t{2}
On t.idpar = t{2}.idpar
WHERE t.ffanref = {2}

## INSERTION_DONNEES_LOCAL_DV3F
INSERT INTO {0}.local_dv3f
(
 {1}
)
(
	 SELECT 
		 t1.*, 
		 t2.idprocptev, t2.fiabilitev, t2.l_idv, t2.nbdroiprov, t2.l_nomv, t2.nbdroigesv, t2.l_nomgesv, t2.codtypprov,
		 t2.idprocptea, t2.fiabilitea, t2.l_ida, t2.nbdroiproa, t2.l_noma, t2.nbdroigesa, t2.l_nomgesa, t2.codtypproa,
		 t3.ffdatemut, t3.exactffdvf, t3.ffancst, t3.anciennete, t3.ffidbat, t3.ffcodinsee, t3.ffcommune, t3.ffnovoie,
		 t3.ffbtq, t3.ffvoie, t3.fftyppdl, t3.ffclascad, t3.ffvalloc, t3.ffcodeval, t3.fflibeval, t3.ffcchgeval, t3.ffdchgeval,
		 t3.stabilitel, t3.ffctyploc, t3.ffltyploc, t3.ffcnatloc, t3.fflnatloc, t3.ffcodnace, t3.fflibnace, t3.fflochab,
		 t2.ffoccv, t2.ffocca, t3.ffshab, t3.ffsdep, t3.ffspro, t3.ffsbati, t3.ffnbpsam, t3.ffnbpcha, t3.ffnbpcu8,
		 t3.ffnbpcu9, t3.ffnbpsea, t3.ffnbpann, t3.ffnbpprinc, t3.ffnbpgarag, t3.ffnbpagrem, t3.ffnbpterra, t3.ffnbppisci, t3.ffnbpcav,
		 t3.ffanref, t2.ffanvend, t2.ffanach, t4.geomloc, t4.srcgeom, t4.parcvect
	 FROM {0}.local t1
	 LEFT JOIN {2}.tmp_local_synthese_achvend_ges t2
	 ON t1.idloc = t2.idloc AND t1.datemut = t2.datemut 
	 LEFT JOIN {2}.tmp_local_synthese_caracteristique t3
	 ON t1.idloc = t3.idloc AND t1.datemut = t3.datemut
	 LEFT JOIN {2}.geometrie_parcelle t4
	 ON t1.idpar = t4.idpar
);

## INSERTION_DONNEES_PARCELLE_DV3F
INSERT INTO {0}.disposition_parcelle_dv3f
        (
         {1}
        )
        (
             SELECT 
                 t1.*, 
                 t2.idprocptev, t2.fiabilitev, t2.l_idv, t2.nbdroiprov, t2.l_nomv, t2.nbdroigesv, t2.l_nomgesv, t2.codtypprov,
                 t2.idprocptea, t2.fiabilitea, t2.l_ida, t2.nbdroiproa, t2.l_noma, t2.nbdroigesa, t2.l_nomgesa, t2.codtypproa,
                 t3.ffdatemut, t3.exactffdvf, t3.stabilitep, t3.ffcodinsee, t3.ffcommune, t3.ffnovoie,
                 t3.ffbtq, t3.ffvoie, t3.fftyppdl, t3.ffsparc, t3.ffsterr, t3.ffdcnt01, t3.ffdcnt02, t3.ffdcnt03,
                 t3.ffdcnt04, t3.ffdcnt05, t3.ffdcnt06, t3.ffdcnt07, t3.ffdcnt08, t3.ffdcnt09, t3.ffdcnt10, t3.ffdcnt11, t3.ffdcnt12, 
                 t3.ffdcnt13, t3.ffdcntsol, t3.ffdcntagri, t3.ffdcntnat, t3.ffparcbati,
                 t3.ffanref, t2.ffanvend, t2.ffanach, t4.geomloc, t4.geompar, t4.srcgeom, t4.parcvect
             FROM {0}.disposition_parcelle t1
             LEFT JOIN {2}.tmp_parcelle_synthese_achvend_ges t2
             ON t1.idpar = t2.idpar AND t1.datemut = t2.datemut 
             LEFT JOIN {2}.tmp_parcelle_synthese_caracteristique t3
             ON t1.idpar = t3.idpar AND t1.datemut = t3.datemut
			 LEFT JOIN {2}.geometrie_parcelle t4  -- géometrie pour toutes les parcelles, mêmes celles non vendues
			 ON t1.idpar = t4.idpar
        );

## CREATION_TABLE_CALCUL_PARCELLE_IDMUTATION
CREATE TABLE {0}.tmp_calcul_parcelle_idmutation AS (
SELECT idmutation,
	count(*) AS nbparrapatrie, 
	array_sort_unique(fusion_array(l_idv)) AS l_idv,
	array_sort_unique(fusion_array(l_nomv)) AS l_nomv,
	array_to_string(array_agg(codtypprov), '') AS codtypprov,
	min(fiabilitev) AS fiabilite_min_v,
	array_sort_unique(fusion_array(l_ida)) AS l_ida,
	array_sort_unique(fusion_array(l_noma)) AS l_noma,
	array_to_string(array_agg(codtypproa), '') AS codtypproa,
	min(fiabilitea) AS fiabilite_min_a,
	sum(ffsparc) as ffsparc,
	sum(ffsterr) as ffsterr,
	ARRAY[COALESCE(sum(ffdcnt01),0),
		COALESCE(sum(ffdcnt01),0),
		COALESCE(sum(ffdcnt02),0),
		COALESCE(sum(ffdcnt03),0),
		COALESCE(sum(ffdcnt04),0),
		COALESCE(sum(ffdcnt05),0),
		COALESCE(sum(ffdcnt06),0),
		COALESCE(sum(ffdcnt07),0),
		COALESCE(sum(ffdcnt08),0),
		COALESCE(sum(ffdcnt09),0),
		COALESCE(sum(ffdcnt10),0),
		COALESCE(sum(ffdcnt11),0),
		COALESCE(sum(ffdcnt12),0)]::INTEGER[] as l_ffdcnt,
		sum(CASE WHEN stabilitep LIKE '%D' THEN 1 ELSE 0 END) AS nbpardisp,
		sum(CASE WHEN stabilitep LIKE 'A%' THEN 1 ELSE 0 END) AS nbparapp, 
		-- GEOMETRIE DES PARCELLES AYANT MUTE
		ST_UNION(geompar) as geomparmut
  FROM {0}.disposition_parcelle_dv3f
  WHERE parcvendue IS TRUE
  GROUP BY idmutation
);

## CREATION_TABLE_CALCUL_LOCAL_IDMUTATION
CREATE TABLE {0}.tmp_calcul_local_idmutation AS (
SELECT idmutation,
   count(*) AS nblocrapatrie,
   array_sort_unique(fusion_array(l_idv)) AS l_idv,
   array_sort_unique(fusion_array(l_nomv)) AS l_nomv,
   array_to_string(array_agg(codtypprov), '') AS codtypprov,
   min(fiabilitev) AS fiabilite_min_v,
   array_sort_unique(fusion_array(l_ida)) AS l_ida,
   array_sort_unique(fusion_array(l_noma)) AS l_noma,
   array_to_string(array_agg(codtypproa), '') AS codtypproa,
   min(fiabilitea) AS fiabilite_min_a,
   sum(CASE WHEN ffctyploc = '1' THEN 1 ELSE 0 END) AS ffnblocmai,
   sum(CASE WHEN ffctyploc = '2' THEN 1 ELSE 0 END) AS ffnblocapt,    
   sum(CASE WHEN ffctyploc = '3' THEN 1 ELSE 0 END) AS ffnblocdep,
   sum(CASE WHEN ffctyploc = '4' THEN 1 ELSE 0 END) AS ffnblocact,
   sum(CASE WHEN ffctyploc = '4' AND ffcnatloc IN ('U', 'US', 'UN', 'UE', 'UG') THEN 1 ELSE 0 END) As ffnbactsec,
   sum(CASE WHEN ffctyploc = '4' AND ffcnatloc IN ('CA', 'CM', 'CB', 'CH', 'ME', 'SM') THEN 1 ELSE 0 END) As ffnbactter,
   sum(CASE WHEN fflochab IS TRUE THEN 1 ELSE 0 END) as ffnbloch,
   sum(CASE WHEN anciennete = 'ancien' THEN 1 ELSE 0 END) as nblocanc,
   sum(CASE WHEN anciennete = 'recent' THEN 1 ELSE 0 END) as nblocrecen,
   sum(CASE WHEN anciennete = 'neuf' THEN 1 ELSE 0 END) as nblocneuf,
   min(ffancst) AS ffancstmin,
   max(ffancst) AS ffancstmax,
   sum(CASE WHEN ffnbpprinc = 1 THEN 1 ELSE 0 END) AS ffnbloc1pp,
   sum(CASE WHEN ffnbpprinc = 2 THEN 1 ELSE 0 END) AS ffnbloc2pp,
   sum(CASE WHEN ffnbpprinc = 3 THEN 1 ELSE 0 END) AS ffnbloc3pp,
   sum(CASE WHEN ffnbpprinc = 4 THEN 1 ELSE 0 END) AS ffnbloc4pp,
   sum(CASE WHEN ffnbpprinc >= 5 THEN 1 ELSE 0 END) AS ffnbloc5pp,
   sum(COALESCE(ffnbpgarag, 0)) AS ffnbpgarag,
   sum(COALESCE(ffnbpterra, 0)) AS ffnbpterra,
   sum(COALESCE(ffnbppisci, 0)) AS ffnbppisci,
   sum(COALESCE(ffnbpcav, 0)) AS ffnbpcav,
   sum(CASE WHEN stabilitel LIKE '%D' THEN 1 ELSE 0 END) AS nblocdisp,
   sum(CASE WHEN stabilitel LIKE 'A%' THEN 1 ELSE 0 END) AS nblocapp,
   sum(COALESCE(ffsbati, 0)) AS ffsbati,
   sum(COALESCE(ffshab, 0)) AS ffshab,
   sum(COALESCE(ffsdep, 0)) AS ffsdep,
   sum(COALESCE(ffspro, 0)) AS ffspro, 
   --- GEOMETRIE DES LOCALISANTS
   ST_UNION(geomloc) AS geomlocmut
  FROM {0}.local_dv3f
  GROUP BY idmutation
);

## CREATION_TABLE_CALCUL_GEOMPAR_IDMUTATION
CREATE TABLE {0}.tmp_calcul_geompar_idmutation AS (

	SELECT idmutation, ST_UNION(geompar) AS geompar
	FROM
	(
		SELECT idmutation, geompar
		FROM 
			(SELECT idmutation, unnest(l_idpar) AS idpar FROM {0}.mutation) t1			
		LEFT JOIN
			{1}.geometrie_parcelle t2
		ON t1.idpar = t2.idpar
	) t
	GROUP BY idmutation
);

## INSERTION_DONNEES_MUTATION_DV3F
INSERT INTO {0}.mutation_dv3f
(
 {1}
)
(
	SELECT 
		-- variables DVF+
		t1.*,
		-- variables acheteur_vendeur
		array_sort_unique(array_cat(t2.l_idv, t3.l_idv)) AS l_idv,
		array_sort_unique(array_cat(t2.l_nomv, t3.l_nomv)) AS l_nomv,
		structurer_codtyppro(COALESCE(t2.codtypprov, '')::VARCHAR || COALESCE(t3.codtypprov, '')::VARCHAR) AS codtypprov,
		CASE WHEN LEAST(t2.fiabilite_min_v, t3.fiabilite_min_v) = 3 THEN True ELSE FALSE END as fiabmaxv,
		array_sort_unique(array_cat(t2.l_ida, t3.l_ida)) AS l_ida,
		array_sort_unique(array_cat(t2.l_noma, t3.l_noma)) AS l_noma,
		structurer_codtyppro(COALESCE(t2.codtypproa, '')::VARCHAR || COALESCE(t3.codtypproa,'')::VARCHAR) AS codtypproa,
		CASE WHEN LEAST(t2.fiabilite_min_a, t3.fiabilite_min_a) = 4 THEN True ELSE FALSE END as fiabmaxa,
		-- variables agrégées locaux
		ffsparc, ffsterr, l_ffdcnt, 
		nbpardisp, nbparapp, ffnblocmai, ffnblocapt, ffnblocdep, ffnblocact, 
		ffnbactsec, ffnbactter, ffnbloch, nblocanc, nblocrecen, nblocneuf, 
		ffancstmin, ffancstmax, ffnbloc1pp, ffnbloc2pp, ffnbloc3pp, ffnbloc4pp, 
		ffnbloc5pp, ffnbpgarag, ffnbpterra, ffnbppisci, ffnbpcav, nblocdisp, 
		nblocapp, ffsbati, ffshab, ffsdep, ffspro,
		-- occupation
		CASE 
			WHEN l_dcnt[12]+l_dcnt[07]>0 THEN 'TC'
			WHEN l_dcnt[10]+l_dcnt[13]>0 THEN 'UR'
			WHEN (l_dcnt[1]+l_dcnt[2]+l_dcnt[3]+l_dcnt[4]>0) AND GREATEST(l_dcnt[1]+l_dcnt[2]+l_dcnt[3]+l_dcnt[4], l_dcnt[5],l_dcnt[9]+l_dcnt[11],l_dcnt[6]+l_dcnt[8])=l_dcnt[1]+l_dcnt[2]+l_dcnt[3]+l_dcnt[4] THEN 'AG'
			WHEN (l_dcnt[5]>0) AND GREATEST(l_dcnt[1]+l_dcnt[2]+l_dcnt[3]+l_dcnt[4], l_dcnt[5],l_dcnt[9]+l_dcnt[11],l_dcnt[6]+l_dcnt[8])=l_dcnt[5] THEN 'FO'
			WHEN (l_dcnt[6]+l_dcnt[8]>0) AND GREATEST(l_dcnt[1]+l_dcnt[2]+l_dcnt[3]+l_dcnt[4], l_dcnt[5],l_dcnt[9]+l_dcnt[11],l_dcnt[6]+l_dcnt[8])=l_dcnt[6]+l_dcnt[8] THEN 'NA'
			WHEN  (l_dcnt[9]+l_dcnt[11]>0) AND GREATEST(l_dcnt[1]+l_dcnt[2]+l_dcnt[3]+l_dcnt[4], l_dcnt[5],l_dcnt[9]+l_dcnt[11],l_dcnt[6]+l_dcnt[8])=l_dcnt[9]+l_dcnt[11] THEN 'LO'
			ELSE 'NA'
		END::varchar(2) AS occupation,
		-- typologie biens GnDVF
		CASE 
			WHEN libnatmut = 'Echange' THEN '7' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
			WHEN libnatmut = 'Expropriation' THEN '9' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
			WHEN libnatmut = 'Adjudication' THEN '8' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
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
					WHEN libnatmut = 'Vente terrain à bâtir' THEN 'N25'
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
							WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN '111' 
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
		END AS codtypbien,
		
		CASE 
			WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
			WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
			WHEN libnatmut = 'Adjudication' THEN 'ADJUVICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
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
		END AS libtypbien,	
		-- rapatriements
		CASE WHEN nblocrapatrie = nblocmut THEN TRUE ELSE FALSE END AS rapatffloc,
		CASE WHEN nbparrapatrie = nbparmut THEN TRUE ELSE FALSE END AS rapatffpar,
		-- AJOUTER LES GEOMETRIES
		geomlocmut, geomparmut, geompar
	FROM {0}.mutation t1
	LEFT JOIN {0}.tmp_calcul_parcelle_idmutation t2
	ON t1.idmutation = t2.idmutation
	LEFT JOIN {0}.tmp_calcul_local_idmutation t3
	ON t1.idmutation = t3.idmutation
	LEFT JOIN {0}.tmp_calcul_geompar_idmutation t4
	On t1.idmutation = t4.idmutation 

);
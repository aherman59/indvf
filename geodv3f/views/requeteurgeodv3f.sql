## RECUPERER_POINT_CENTRAL
SELECT avg(st_x(geomloc)::numeric), avg(st_y(geomloc)::numeric)
FROM (SELECT geomloc from dvf.disposition_parcelle
WHERE geomloc IS NOT NULL
LIMIT {0}) t;

## RECUPERER_CENTROIDE
SELECT st_x(st_transform(geomloc, 4326))::numeric, st_y(st_transform(geomloc, 4326))::numeric 
FROM dvf.disposition_parcelle 
WHERE idpar = '{0}' AND geomloc IS NOT NULL;

## RECUPERER_MUTATIONS_DV3F_AVEC_GEOMETRIE
SELECT idmutation, 
		datemut, 
		anneemut, 
		valeurfonc, 
		sbati, 
		sterr, 
		nblocmut, 
		nbparmut,
		codtypbien, libtypbien,
		codservch, 
	   	refdoc,
	   	nblot, 
	   	nbvolmut,
		ST_ASGEOJSON({0}),
		l_nomv::TEXT[],
		l_noma::TEXT[],
		codtypprov,
		codtypproa
FROM dvf.mutation 
WHERE {0} IS NOT NULL 
AND {0} && ST_MAKEENVELOPE({1}, {2}, {3}, {4}, {5});

## RECUPERER_MUTATIONS_DVF_PLUS_AVEC_GEOMETRIE
SELECT idmutation, 
		datemut, 
		anneemut, 
		valeurfonc, 
		sbati, 
		sterr, 
		nblocmut, 
		nbparmut,
		{6}, {7}, --codtypbien, libtypbien
		codservch, 
	   	refdoc,
	   	nblot, 
	   	nbvolmut,
		ST_ASGEOJSON({0})
FROM dvf.mutation 
WHERE {0} IS NOT NULL 
AND {0} && ST_MAKEENVELOPE({1}, {2}, {3}, {4}, {5});

## RECUPERER_LOCAUX_DV3F
SELECT idloc,
	   idpar, 
	   sbati,
	   nbpprinc,
	   libtyploc,
	   ffancst
FROM dvf.local WHERE idmutation = {0}; 

## RECUPERER_LOCAUX_DVF_PLUS
SELECT idloc,
	   idpar, 
	   sbati,
	   nbpprinc,
	   libtyploc
FROM dvf.local WHERE idmutation = {0}; 

## RECUPERER_PARCELLES_DV3F
SELECT idpar,
	   dcnt01 + dcnt02 + dcnt03 + dcnt04 + dcnt05 + dcnt06 + dcnt07 + dcnt08 + dcnt09 + dcnt10 + dcnt11 + dcnt12 + dcnt13
FROM dvf.disposition_parcelle WHERE parcvendue IS TRUE AND idmutation = {0}; 

## RECUPERER_PARCELLES_DVF_PLUS
SELECT idpar,
	   dcnt01 + dcnt02 + dcnt03 + dcnt04 + dcnt05 + dcnt06 + dcnt07 + dcnt08 + dcnt09 + dcnt10 + dcnt11 + dcnt12 + dcnt13
FROM dvf.disposition_parcelle WHERE parcvendue IS TRUE AND idmutation = {0};

## ADRESSES_ASSOCIEES
SELECT COALESCE(novoie::VARCHAR, '') || 
		COALESCE(btq, '') || ' ' || 
		COALESCE(typvoie, '') || ' ' || 
		COALESCE(voie, '') || ' ' || 
		COALESCE(codepostal, '') || ' ' || 
		COALESCE(commune, '') 
FROM dvf.adresse a
JOIN
(
	SELECT idadresse AS idadresse FROM dvf.adresse_dispoparc WHERE idmutation = {0}
	UNION
	SELECT idadresse FROM dvf.adresse_local WHERE idmutation = {0}
) t
ON a.idadresse = t.idadresse

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

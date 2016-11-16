## RECUPERER_POINT_CENTRAL
SELECT avg(st_x(geomloc)::numeric), avg(st_y(geomloc)::numeric) 
FROM dvf.disposition_parcelle 
WHERE geomloc IS NOT NULL 
LIMIT {0}

## RECUPERER_MUTATIONS_AVEC_GEOMETRIE
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
	   libtyploc
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
END AS libtypbien
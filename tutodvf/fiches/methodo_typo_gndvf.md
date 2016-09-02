Titre: Construire la typologie de bien du GnDVF à partir de DVF+
Theme: Méthode
Numero: 2
Auteurs: Antoine Herman, Magali Journet, Bertrand Leroux - Cerema
MAJ: 19/04/2016
Contact: dv3f@cerema.fr

## Objectif

L'objectif est de classer chacune des mutations de la table _mutation_ de DVF+ 
selon la [typologie des biens proposée par le GnDVF](http://guide-dvf.fr/utiliser-dvf/typologie-biens). 

## Usage

* Identifier rapidement, pour une mutation, le type de bien ayant muté.
* Calculer des indicateurs agrégés pour chaque type de bien (ex : _prix médian des biens de type 'maison'_)

## Préalable

* Avoir accès à une base de données construite sur 
le [modèle DVF+](http://www.nord-picardie.cerema.fr/facilitez-vous-l-integration-des-donnees-demande-a972.html).   

_Nota : Le modèle DV3F intègre directement les champs liés à la typologie des biens du GnDVF dans la table mutation._

## Construction SQL

La requête suivante permet de créer un champ supplémentaire (intitulé ici _libtypbien_) à ceux de la table _mutation_ 
pour classer l'ensemble des mutations selon la typologie GnDVF :

```sql
SELECT 
	-- variables DVF+
	*,
	-- typologie biens GnDVF
	CASE 
		WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
		WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
		WHEN libnatmut = 'Adjudication' THEN 'ADJUDICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
		WHEN nbvolmut > 0 THEN 'VOLUME' -- VOLUME
		WHEN vefa IS TRUE THEN -- VEFA
			CASE 
				WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN 'VEFA - INDUSTRIEL ET COMMERCIAL'
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
				WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'BATI - BIEN FORESTIER'
				WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'BATI - BIEN AGRICOLE'						                            
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
FROM dvf.mutation;			
```

**Cette requête est utilisée lors de la création du modèle DV3F.**

## Précautions d'usage

* Pour produire une analyses des prix à partir de cette typologie, il peut être judicieux d'exclure les mutations ayant des valeurs foncières très faibles (0 ou 1 euro).

* A partir du moment où une mutation comprend un local, la mutation rentre dans la catégorie de marché des biens bâtis quelque soit la qualité du local, la surface de terrain nue, 
ou la répartition géographique des parcelles nues et bâties (contiguës, éloignées sur une autre commune, etc). Une approche plus fine cherchera à reclasser tout ou partie 
de ces mutations comportant un local qui auraient été acquises pour les terrains.

## Références

* Groupe National Demande de Valeurs Foncières - [Guide GnDVF](http://guide-dvf.fr/) - novembre 2015 
* Région PACA - Cerema DTer Méditerranée - Étude des dynamiques de marché fonciers et immobiliers en région PACA – janvier 2016 - 27 pages
* EPF Nord Pas-de-Calais - DGALN - Cerema DTer Nord Picardie - 
[Segmentation des marchés à partir de DVF et des Fichiers fonciers](http://www.nord-picardie.cerema.fr/segmentation-des-marches-a-partir-de-dvf-et-des-a1002.html) - décembre 2015 - Synthèse en 86 pages

Titre: Correspondance entre les variables DV3F et Fichiers fonciers
Theme: Base de données
Numero: 3
Auteurs: Antoine Herman, Magali Journet - Cerema
MAJ: 19/04/2016
Contact: dv3f@cerema.fr

## Préambule

Des variables issues des Fichiers fonciers sont intégrées dans le modèle DV3F au niveau des
tables _acheteur_vendeur_, _disposition_parcelle_ et _local_. Leurs noms ont été modifiés et préfixés par les caractères _ff_
de façon à pouvoir les identifier rapidement dans la structure de ces tables.

La correspondance entre les noms des variables DVF et Fichiers fonciers est décrite ci-après.

Pour mémoire, la description des variables des Fichiers fonciers est disponible 
par ce [lien](http://piece-jointe-carto.developpement-durable.gouv.fr/NAT004/DTerNP/html3/_ff_descriptif_tables_image.html)

## Correspondance pour la table acheteur_vendeur

|  Nom Variable DV3F | Nom Variable FF 				| Description 																	|
|--------------------|------------------------------|--------------------------------------------------------------------------------|
| ffnomprop          | ddenom		   				| nom de l'acheteur ou du vendeur (anonymisé pour les personnes physiques) |
| ffsiren            | dsiren		   				| code SIREN  |
| ffcatpm			 | codnom						| catégorie de personne morale |
| ffcatjur			 | dforme						| catégorie juridique |


## Correspondance pour la table disposition_parcelle

|  Nom Variable DV3F | Nom Variable FF 				| Description 																	 |
|--------------------|------------------------------|--------------------------------------------------------------------------------|
| ffcodinsee         | idcom		   				| code Insee de la commune 														 |
| ffcommune          | idcomtxt		   				| libellé de la commune 														 |
| ffnovoie			 | dnuvoi (dnvoiri avant 2014)	| numéro de la voie 															 |
| ffbtq				 | dindic						| indice de répétition 															 |
| ffvoie 			 | dvoilib (à partir de 2012)   | libellé de la voie |
| fftyppdl 			 | ctpdl (à partir de 2012) 	| type de division en lot |
| ffsparc 			 | dcntpa 						| surface de la parcelle |
| ffsterr  			 | ssuf  						| surface totale des subdivisions fiscales |
| ffdcnt01			 | dcnt01					    | surface de suf de type 01 |
| ffdcnt02 			 | dcnt02 						| surface de suf de type 02 |
| ffdcnt03			 | dcnt03 						| surface de suf de type 03 |
| ffdcnt04 			 | dcnt04 						| surface de suf de type 04 |
| ffdcnt05 			 | dcnt05 						| surface de suf de type 05 |
| ffdcnt06 			 | dcnt06 						| surface de suf de type 06 |
| ffdcnt07 			 | dcnt07 						| surface de suf de type 07 |
| ffdcnt08 			 | dcnt08 						| surface de suf de type 08 |
| ffdcnt09 			 | dcnt09 						| surface de suf de type 09 |
| ffdcnt10 			 | dcnt10 						| surface de suf de type 10 |
| ffdcnt11 			 | dcnt11 						| surface de suf de type 11 |
| ffdcnt12 			 | dcnt12 						| surface de suf de type 12 |
| ffdcnt13 			 | dcnt13 						| surface de suf de type 13 |
| ffdcntsol 		 | dcntsol 						| surface de suf de type sol |
| ffdcntagri 		 | dcntagri 					| surface de suf de type agricole |
| ffdcntnat 		 | dcntnat 						| surface de suf de type naturel |
| ffparcbati 		 | Vrai si nlocal > 0 			| Vrai si la parcelle est batie |
| geomloc 		 	 | geomloc 						| géométrie du localisant de la parcelle |
| geompar 			 | geompar 						| géométrie du contour de la parcelle |
| srcgeom 			 | source_geo 					| source de la géométrie |
| parcvect 			 | vecteur 						| Vrai si la parcelle est vectorisée |


## Correspondance pour la table local
|  Nom Variable DV3F | Nom Variable FF 				| Description 																	|
|--------------------|------------------------------|--------------------------------------------------------------------------------|
|ffdatemut | jdatath |date de signature de l'acte dans les Fichiers fonciers|
|ffancst|jannath|année de construction du local|
|ffidbat|idbat|identifiant du bâtiment (issu des Fichiers fonciers)|
|ffcodinsee|idcom|code Insee de la commune|
|ffcommune|idcomtxt|libellé de la commune|
|ffnovoie|dnvoiri|numéro de la voie|
|ffbtq|dindic|indice de répétition|
|ffvoie|dvoilib|libellé de la voie|
|fftyppdl|ctpdl (à partir de 2012) |type de division en lot|
|ffclascad| dcapec | classement cadastral du local|
|ffvalloc| dvltrt | valeur locative totale retenue pour le local|
|ffcodeval| ccoeva | code d'évaluation du local|
|fflibeval| ccoevatxt | libellé du code d'évaluation du local|
|ffcchgeval| dnatcg (à partir de 2013) | code de nature du changement d'évaluation|
|ffdchgeval| jadatcgl (à partir de 2013) | date du changement d'évaluation|
|ffctyploc| dteloc | code du type de local|
|ffltyploc| dteloctxt | libellé du type de local|
|ffcnatloc| cconlc | code de la nature du local|
|fflnatloc| cconlctxt | libellé de la nature du local|
|ffcodnace| cconac (ccoape avant 2012) | code NACE pour les locaux professionnels|
|fflibnace| cconactxt (cconactxt avant 2012) | libellé du code NACE pour les locaux professionnels|
|fflochab| Vrai si habitat = 1 (npevaffh = 1 avant 2014)| Vrai si le local est un local d'habitation au moment de la mutation|
|ffoccv| ccthp | code d'occupation du local sous le vendeur|
|ffocca| ccthp | code d'occupation du local sous l'acheteur|
|ffshab| stoth | surface totale des pièces d'habitation|
|ffsdep| stotdsueic + stotd | surface totale des pièces type dépendance intégrées ou non au local|
|ffspro| stotp | surface totale des pièces type activité (ou professionnelle)|
|ffsbati| spevtot | surface de l'ensemble des pièces du local|
|ffnbpsam| dnbsam | nombre de pièces type salle à manger|
|ffnbpcha| dnbcha | nombre de pièces type chambre|
|ffnbpcu8| dnbcu8 | nombre de pièces type cuisine de moins de 9 m2|
|ffnbpcu9| dnbcu9 | nombre de pièces type cuisine d'au moins 9 m2|
|ffnbpsea| dnbsea | nombre de pièces type salle d'eau|
|ffnbpann| dnbann | nombre de pièces type annexe|
|ffnbpprinc| dnbsam + dnbcha | nombre de pièces principales|
|ffnbpgarag| nbgarpark | nombre de pièces annexes type garage/parking|
|ffnbpagrem| nbagrement | nombre de pièces annexes type serre/agréement|
|ffnbpterra| nbterrasse | nombre de pièces annexes type terrasse|
|ffnbpcav| nbannexe | nombre de pièces annexes type cave/grenier/cellier/remise/etc.|
|geomloc| geomloc | géométrie du localisant|
|srcgeom| source_geo | source de la géométrie|
|parcvect| vecteur | Vrai si la parcelle est vectorisée|
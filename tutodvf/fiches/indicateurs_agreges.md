Titre: Constitution des indicateurs agrégés nationaux
Theme: Choix méthodologiques dans DV3F
Numero: 4
Auteurs: Antoine Herman - Cerema
MAJ: 18/09/2018
Contact: dv3f@cerema.fr

## Préambule

Depuis la version 2 de DV3F, des indicateurs de prix et de volume de transactions sont proposés pour différentes échelles géographiques
lors de la livraison des données.

La mise à disposition de ses indicateurs a pour objectif de fournir, de manière facilitée, des éléments d'appréciation des marchés fonciers et
immobiliers issus de DV3F.

La présente fiche détaille la méthodologie employée pour les constituer.

## Indicateurs proposés

### Unités d'agrégation

Les niveaux d'agrégation géographiques proposés correspondent aux contours administratifs suivants :

* France entière (hors Alsace-Moselle et Mayotte)
* Région
* Département
* EPCI
* Commune

Les niveaux d'agrégation temporels proposés sont les suivants:
* annuels
* tri-annuels (décalé de un an)

Les indicateurs proposés dans la version 2 de DV3F se basent sur les périmètres administratifs au 1er janvier 2017.

### Indicateurs retenus selon les types de biens

A ce jour, les indicateurs retenus concernent uniquement des ventes de biens immobiliers.  

Le tableau suivant détaille les indicateurs retenus :

| Code | Libellé | Nombre de mutations | Nombre de mutations pour le calcul des prix | Volume de transaction (k€) | Médiane du prix (€) | Premier quartile du prix (€) | Dernier quartile du prix (€) | Médiane du prix par m2 de surface bâtie (€/m2) | Premier quartile de prix par m2 de surface bâtie (€/m2) | Dernier quartile de prix par m2 de surface bâtie (€/m2) | Somme des surfaces bâties (m2) | Médiane des surfaces bâties (m2) |																	
|--------------|------------|:----------:|:-------------:|:-------------:|:----------:|:-------------:|:-------------:|:----------:|:-------------:|:-------------:|:-------------:|:-------------:|
| 1     | Bâti     | X | | X | | | | | | | | |
| 2     | Non Bâti | X | | X | | | | | | | | |
| 11    | Maison   | X | | X | | | | | | | | |
| 12    | Appartement   | X | | X | | | | | | | | |
| 13    | Dépendance   | X | | X | | | | | | | | |
| 14    | Activité   | X | | X | | | | | | | | |
| 15    | Bâti mixte   | X | | X | | | | | | | | |
| 111   | Une maison   | X | X | X | X | X | X | | | | X | X |
| 1111  | Une maison vefa ou neuf | X | X | X | X | X | X | | | | X | X |
| 1112  | Une maison récente| X | X | X | X | X | X | | | | X | X |
| 1113  | Une maison ancienne | X | X | X | X | X | X | | | | X | X |
| 1114  | Une maison à usage professionnel | X | | X | | | | | | | | |
| 121   | Un appartement   | X | X | X | X | X | X | X | X | X | X | X |
| 1211  | Un appartement vefa ou neuf | X | X | X | X | X | X | X | X | X | X | X |
| 1212  | Un appartement récent | X | X | X | X | X | X | X | X | X | X | X |
| 1213  | Un appartement ancien | X | X | X | X | X | X | X | X | X | X | X |
| 1214  | Un appartement à usage professionnel | X | | X | | | | | | | | |
| 121?1 | Un appartement T1 | X | X | X | X | X | X | X | X | X | X | X |
| 121?2 | Un appartement T2 | X | X | X | X | X | X | X | X | X | X | X |
| 121?3 | Un appartement T3 | X | X | X | X | X | X | X | X | X | X | X |
| 121?4 | Un appartement T4 | X | X | X | X | X | X | X | X | X | X | X |
| 121?5 | Un appartement T5+ | X | X | X | X | X | X | X | X | X | X | X |
| 1311  | Un garage   | X | | X | | | | | | | | |
| 142  | Activité secondaire   | X | | X | | | | | | | | |
| 143  | Activité tertiaire   | X | | X | | | | | | | | |
| 149  | Activité mixte   | X | | X | | | | | | | | |

### Règles de nommage des tables et des champs

#### Nommage des tables

Les tables d'indicateurs agrégés sont contenues dans le schéma _indicateur_ et sont générées pour chaque période et pour chaque type de périmètre administratif selon les règles suivantes :

|     | année NNNN | année NNN1 à NNN3 |
|-----|------------|-------------------|
| France | france_NNNN | france_NNN1_NNN3 |
| Région | region_NNNN | region_NNN1_NNN3 |
| Departement | departement_NNNN | departement_NNN1_NNN3 |
| EPCI du département DD | epci_dDD_NNNN | epci_dDD_NNN1_NNN3 |
| Communes du département DD | commune_dDD_NNNN | commune_dDD_NNN1_NNN3 |

Pour exemple, les indicateurs communaux du département 59 pour l'année 2014 seront contenus dans la table _indicateur.commune_d59_2014_.

#### Nommage des champs

Pour chacun des tables, les indicateurs générés sont nommés selon les règles suivantes :

|                        | code Typologie XXX | Appartement de type Tn  |
|------------------------|--------------------|-------------------------|
| Nombre de transactions | nbtrans_XXX        | nbtrans_apt_tn          |
| Nombre de transactions pour le calcul du prix | nbtranspx_XXX | nbtranspx_apt_tn |
| Volume de transactions | montant_XXX | montant_apt_tn |
| Médiane du prix | pxmedian_XXX | pxmedian_apt_tn |
| Premier quartile du prix | pxpq_XXX | pxpq_apt_tn |
| Dernier quartile du prix | pxdq_XXX | pxdq_apt_tn | 
| Dernier quartile du prix | pxdq_XXX | pxdq_apt_tn | 
| Médiane du prix par m2 | pxm2median_XXX | pxm2median_apt_tn |
| Premier quartile par m2 | pxm2pq_XXX | pxm2pq_apt_tn |
| Dernier quartile du prix par m2 | pxm2dq_XXX | pxm2dq_apt_tn |
| Somme des surfaces bâties | sbatitot_XXX | sbatitot_apt_tn |
| Médiane des surfaces bâties | sbatimedian_XXX | sbatimedian_apt_tn |

Pour exemple, l'indicateur du prix médian des ventes de maison ancienne (1113) aura pour nom _pxmedian_1113_. 

## Construction des indicateurs

### Echantillon minimal pour le calcul du prix


### Choix méthodologiques retenus



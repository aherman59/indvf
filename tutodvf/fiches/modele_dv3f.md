Titre: Description du modèle DV3F
Theme: Tutoriel
Numero: 3
Auteurs: Antoine Herman - Cerema
MAJ: 08/12/2016
Contact: dv3f@cerema.fr


## Contexte

Une fois le travail de structuration de la donnée accomplie avec le modèle DVF+, et toujours dans l'objectif de faciliter l'observation foncière et immobilière, la DGALN a demandé au Cerema d'engager un travail d'enrichissement de la donnée DVF à partir de données exogènes. 

Ainsi, une étude expérimentale réalisée en 2015 et financée par l'EPF Nord Pas-de-Calais et la DGALN, a permis de mesurer la faisabilité d'un croisement de DVF avec les Fichiers fonciers. Les résultats de cette étude, très encourageants, ont posé les bases de la construction d'un modèle de données dit "DV3F", reproductible à l'échelle nationale, qui élargit fortement les possibilités d'analyse. Ce modèle de données est en développement depuis mi-2015.

Ce modèle de données DV3F permet désormais de produire et de diffuser, à un rythme semestriel, une base de données nationale gratuite, sans réel équivalent pour l'analyse des marchés fonciers et immobiliers. Il pourra être améliorer à l'aide des différents retours d'expérience des utilisateurs.

## Les principaux apports de DV3F

Le modèle DV3F a d'abord pour objectif d'enrichir la donnée source DVF avec les variables des Fichiers fonciers intéressantes pour l'observation. Cet enrichissement est possible par le lien évident qui existe entre ses deux sources de données d'origine fiscale ; en effet, la donnée DVF provient des bases de données FIDJI et MAJIC de la DGFiP tandis que les Fichiers fonciers proviennent quasi-exclusivement de MAJIC. Les identifiants des différents biens sont communs et facilitent les rapprochement.

Le principal frein à ses rapprochements réside dans le fait que les Fichiers fonciers font état d'un "stock" au 1er janvier de l'année tandis que les Demandes de Valeurs Foncières retranscrivent plutôt le "flux" des ventes.   

### Une caractérisation plus fine des biens

Les caractéristiques des biens renseignés dans la donnée source DVF sont peu détaillées. Pour les locaux notamment, DVF
fournit uniquement le type du local, la surface du bâti et le nombre de pièces principales. 

Avec DV3F et les variables rapatriées des Fichiers fonciers, les informations sur les biens échangés sont plus précises et
permettent ainsi d'aller plus loin dans la caractérisation de certains biens. A titre d'exemple, pour les locaux, DV3F permet d'obtenir l'année de construction, de préciser le nombre et les types de dépendance ou encore d'identifier les logements.  

### La géolocalisation des données

Un des principaux intérêts de DV3F réside également dans la géolocalisation des données sources. L'apport de la géométrie parcellaire  accroit fortement les potentiels d'usage : représentations cartographiques, croisements avec d'autres périmètres (PLU par exemple), requêtes géométriques variées, etc. 

Les géométries proviennent d'un historique de parcelles constitué majoritairement à partir de différents
millésimes de la BD Parcellaire (IGN). Cela permet, dans DV3F, de géolocaliser des parcelles qui auraient disparu 
à la suite d'une vente et ainsi d'obtenir des taux de géolocalisation très satisfaisants. 

### Une information sur les acheteurs et les vendeurs

DV3F vise enfin à pallier l'absence d'informations sur les acquéreurs et vendeurs dans DVF. En travaillant à partir de plusieurs
millésimes des Fichiers fonciers, il est en effet possible de retrouver le propriétaire d'un bien avant et après une vente et
ainsi d'en déduire le vendeur et l'acheteur.

Les informations sur les propriétaires pouvant être récupérées à partir des millésimes disponibles des Fichiers fonciers sont donc rapatriées dans DV3F et accompagnées d'une estimation de la fiabilité liée au rapatriement.

Ces informations sont anonymisées pour les personnes physiques.  

## Un modèle assis sur DVF+.

Le modèle DV3F conserve la même structure et les mêmes variables que le modèle DVF+. 

Les 2 évolutions par rapport à DVF+ sont liées à l'apport des Fichiers fonciers :

* Ajout d'une nouvelle table **acheteur_vendeur** qui regroupe les caractéristiques des propriétaires,
* Ajout de nouvelles variables sur les 3 tables principales **mutation**, **disposition_parcelle** et **local**.

### Diagramme du modèle DV3F

Le diagramme du modèle DV3F est accessible [*ici*](ressources/modele_dv3f.png "Modèle DV3F").  Il décrit les champs des
18 tables du modèle et les relations entre elles. 


## Un enrichissement important des tables principales

Comme pour DVF+, la volonté est de concentrer les informations principales sur les tables principales **mutation**, **disposition_parcelle** et **local** qui comptent respectivement 109, 87 et 85 variables.

### Des variables issues des Fichiers fonciers

En plus des catégories de variables déjà présentes dans DVF+, trois autres catégories existent dans DV3F:

| Catégorie | Description  | Exemples |
|-----------|-----------------------|-------------------|
| Données Fichiers fonciers | Données provenant directement des Fichiers fonciers | ffancst, ffshab, ffsterr, etc. |
| Données de fiabilité | Indicateurs permettant de s'assurer de la qualité ou de l'exhaustivité d'un rapatriement de données issues des Fichiers fonciers | rapatffloc, fiabilitea, fiabmaxv, etc |
| Données issues des croisements DVF/FF | Données qui ont pu être déterminées en rapprochant les informations DVF avec celle des Fichiers fonciers | anciennete, segmusage, etc. |


### Syntaxe des variables

De nouvelles règles syntaxiques viennent également completer celles déjà existantes pour DVF+:

| Si la variable commence par... | Alors il s'agit d'un(e)...              |
|--------------------------------|-----------------------------------------|
| ff | donnée directement issue des Fichiers fonciers |
| l_ff | liste (type array) de données issues des Fichiers fonciers |

| Si la variable se termine par... | Alors il s'agit d'un(e)...              |
|--------------------------------|-----------------------------------------|
| a | donnée liée à l'acheteur |
| v | donnée liée au vendeur |


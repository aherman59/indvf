Titre: De DVF à DV3F
Theme: Bien démarrer avec DV3F
Numero: 0
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 28/08/2016
Contact: dv3f@cerema.fr

## Objectifs

Ce tutoriel a pour objectifs :

* de présenter ce que sont DVF, DVF+ et DV3F,
* de proposer une prise en main au regard des principaux usages,
* de proposer une description des notions essentielles autour de DV3F,
* d'expliciter les méthodes de construction de la donnée.

Elles contiennent de véritables bases pour débuter avec DVF+/DV3F.  

## Licence

Tous les contenus proposés sont sous licence Creative Commons CC-BY-NC-SA.

## DVF pour Demande de Valeurs Foncières

« Demande de Valeurs Foncières », ou DVF, est une :

>> Offre de **service** de la Direction Générale des Finances Publiques (DGFiP) qui permet aux **ayants-droits** d’obtenir **gratuitement** les données présentant l’ensemble des **transactions immobilières** des **5 dernières années** relevant de leur **périmètre géographique**.

Ce service a été mis en place officiellement en 2011 à la suite de la modification de l'article L135B du Livre des Procédures Fiscales qui met à disposition des organismes ayants-droits, l’ensemble des valeurs foncières déclarées à l’occasion des mutations intervenues dans les 5 dernières années pour l’exercice de leurs compétences en matière de politique foncière, d’urbanisme et d’aménagement et de transparence des marchés fonciers et immobiliers.

![*Chronologie DVF*](ressources/chronologie_dvf.png "Chronologie DVF")

La mise à disposition gratuite des données sur les transactions immobilières s'inscrit dans une démarche d’ouverture et de transparence croissante de l’administration française au service d’une meilleure gestion des territoires.

### Périmètre géographique de DVF

En terme de périmètre géographique, DVF est disponible pour la **France métropolitaine**, hors Alsace et Moselle, **ainsi que les DROM**, excepté Mayotte.

![*Périmètre DVF*](ressources/perimetre_geographique_dvf.png "Périmètre DVF")
_<p style="text-align:right;">(source GnDVF)</p>_

### Constitution de DVF

#### Des données issues de FIDJI et MAJIC

DVF est constituée à partir de 2 sources de données fiscales produites par la DGFiP. 

Le traitement DVF récupère, à la fois, des informations renseignées par les services de la publicité foncière dans la base de données FIDJI (Fichier Informatisé des Données Juridiques Immobilières) et des informations issues de la base de données MAJIC (Mise à Jour des Informations Cadastrales) pour produire des fichiers actualisés et accessibles aux ayants-droits à un rythme semestriel.

![*Sources DVF*](ressources/sources_constitution_dvf.png "Sources DVF")

#### Une donnée brute en 43 champs

La donnée DVF livrée se présente sous la forme de fichiers textes, encodés en UTF-8, lisibles sous différentes éditeurs de textes ou tableurs. 

Les différentes lignes de ces fichiers sont composées de 43 champs séparées par le caractère "|". Elles décrivent tout ou partie des éléments d'information d'une transaction immobilière (ou mutation).

L'illustration ci-dessous présente un échantillon d'un fichier source DVF (les valeurs foncières ont été masquées):

![*Donnée brute DVF*](ressources/exemple_donnee_brute_dvf.png "Donnée brute DVF")

Les 43 champs présents dans DVF sont les suivants :

| Libellé | Exemple               |
|---------|-----------------------|
| **Code du service CH** |5914P01 |
| **Référence document** |2009P00999 |
| **1er Article CGI** |1594D*1 |
| **2e Article CGI** |257-7-1*2 |
| **3e Article CGI**| |
| **4e Article CGI**| |
| **5e Article CGI**| |
| **Numéro de disposition**| |
| **Date de mutation** |16/01/2010 |
| **Nature de mutation** | Vente |
| **Valeur foncière** | 200 000 € |
| **Numéro de voie** |01 |
| **B/T/Q** | T|
| **Type de voie** | Rue |
| **Code voie** | 4242 |
| **Voie** | Jean Jaures |
| **Code postal** | 59000 |
| **Commune** | LILLE |
| **Code du département** | 59 |
| **Code de la commune** | 350 |
| **Préfixe de section** | 298 |
| **Section** | AB |
| **Numéro de plan** | 100 |
| **Numéro de volume** | |
| **1er lot** | |
| **Surface Carrez 1er lot** | |
| **2e lot** | |
| **Surface Carrez 2e lot** | |
| **3e lot** | |
| **Surface Carrez 3e lot** | |
| **4e lot** | |
| **Surface Carrez 4e lot** | |
| **5e lot** | |
| **Surface Carrez 5e lot** | |
| **Nombre de lots** | |
| **Code du type de local** | 2 |
| **Type du local** | Maison |
| **Identifiant du local** | 999999 |
| **Surface réelle bâti** | 88 |
| **Nombre pièces princ** | 4 |
| **Nature de culture** | S |
| **Nature de culture spéc.** | |
| **Surface de terrain** | 140 |

### Atouts et Limites de DVF pour l'observation foncière et immobilière

#### Atouts principaux

Les données DVF présentent plusieurs atouts. Elles sont :

* disponibles à une échelle nationale,
* gratuites,
* réputées exhaustives,
* globalement fiables,
* facilement géolocalisables.

#### Limites principales

Les données DVF présentent toutefois quelques limites :

* Elles sont utilisables uniquement sur les 5 dernières années,
* Elles sont complexes à exploiter en l'état,
* Elles peuvent être difficilement intelligibles pour les novices,
* Elles n'ont pas vocation première à permettre l'observation foncière et les informations fournies apparaissent rapidement limitantes pour une analyse fine.

La mise en place de modèles de données tels que DVF+ et DV3F cherchent à repousser ces limites en proposant notamment une structuration et un enrichissement de la donnée source.

## Le modèle DVF+

### Contexte

Les travaux autour de la création d’un modèle permettant de faciliter le passage des données DGFiP, « Demande
de valeurs foncières » (DVF), en base de données aisément exploitable s’inscrivent dans un processus qui a
débuté en 2011 à l’initiative d’un groupe technique lancé par l’ADEF, aujourd'hui devenu le Groupe National DVF (GnDVF). 

Ce groupe s’est réuni plusieurs fois et a associé, dès 2013, le CETE Nord-Picardie (aujourd’hui Direction Nord-Picardie du Cerema). Un modèle de données pour l’import des données natives de DVF a été produit et partagé collégialement par le groupe.

Depuis, le Cerema a travaillé, pour le compte de la DGALN, à étoffer ce modèle en y ajoutant de nouvelles
variables au sein d’un premier modèle, baptisé DVF+. 

Des outils et scripts, libres d'utilisation, sont, par ailleurs, proposés pour l'importation et la structuration de la donnée brute DVF dans une base de données PostgreSQL selon ce modèle.

### Intérêt d'une base de données DVF+

Les données DVF brutes fournies par la DGFiP sont livrées sous un format texte lisible depuis un éditeur de texte ou un tableur classique. Chaque ligne du fichier source est souvent une décomposition partielle d'une vente et comporte 43 champs qui mélangent des informations liées à différentes notions fiscales. Il devient très vite difficile de travailler à une analyse sérieuse à partir d'un tel fichier.

L'intérêt de la mise en place d'un modèle de données permettant l'intégration des données DVF est multiple :

* pouvoir gérer un gros volume de données,
* structurer l'information,
* accèder facilement et rapidement à l'information,
* combiner facilement les différentes informations,
* supprimer les doublons d'information,
* faciliter l'enrichissement des informations.

Le modèle DVF+ présente de tels atouts. En terme de structuration de la donnée initiale, chacune des tables du modèle représente une unique notion de DVF à laquelle sont affectées les données qui y sont directement liées. Cette structuration permet de supprimer les données dupliquées et de mettre en place des liaisons plutôt intuitives entre les tables. 

Par ailleurs, le modèle DVF+ ajoute, à une donnée d'origine fiscale, des variables issues de ces même données mais transformées ou agrégées pour permettre une exploitation plus aisée pour l'observation foncière et immobilière.

### Tables constitutives du modèle

Le modèle DVF+ est composé de 12 tables (dont 3 principales) et de 5 tables annexes.

Les 12 tables principales ou secondaires sont les suivantes : 

| Nom de la table | Description |
|-----------------|-------------|
|**mutation** |**Table des mutations**|
|mutation_art_cgi| Table des articles du code général des impôts attachés à la mutation|
|disposition| Table des dispositions|
|**disposition_parcelle**| **Table des parcelles attachées à la disposition**|
|parcelle| Table des parcelles|
|**local**| **Table des locaux**|
|suf| Table des subdivisions fiscales|
|volume| Table des volumes|
|lot| Table des lots|
|adresse| Table des adresses|
|adresse_dispoparc| Table de liaison entre la table adresse et la table disposition_parcelle|
|adresse_local| Table de liaison entre la table adresse et la table local|

Les tables _mutation_, _disposition_parcelle_ et _local_ sont dites "principales" dans le 
sens où les principales variables ont y été recentrées afin de faciliter l'utilisation
du modèle par des utilisateurs peu aguerris dans l'exploitation de bases de données. 
La grande majorité des analyses liées à l'observation foncière et immobilière peut 
être réalisée à partir des données issues de ces trois tables. 

Les 5 tables annexes sont les suivantes : 

| Nom de la table | Description |
|-----------------|-------------|
|ann_nature_mutation| Table contenant les natures de mutation|
|ann_cgi| Table contenant les articles CGI|
|ann_type_local| Table contenant les types de locaux|
|ann_nature_culture| Table contenant les natures de culture|
|ann_nature_culture_speciale| Table contenant les natures de culture spéciales|

Un schéma simplifié du modèle est présenté ci-dessous :


![*Diagramme DVF+ simplifié*](ressources/diagramme_dvf_plus_simple.jpg "Diagramme DVF+ simplifié")

### Variables constitutives du modèle

#### Des variables brutes et des variables plus élaborées facilitant l'analyse 

Plusieurs catégories de variables existent au sein de "DVF+":

| Catégorie | Description  | Exemples |
|-----------|-----------------------|-------------------|
| Identifiants de clef primaire | Entiers ou chaînes de caractère permettant de désigner une et une seule entité d’une table. L’identifiant de clef primaire de la table apparait au début de chacune des tables. | idmutation, iddispo, iddispoloc, etc. |
| Données brutes | Données provenant des données sources de la DGFiP et intégrées sans transformation dans le modèle. | refdoc, coddep, scarrez, etc. |
| Données brutes transformées | Données provenant des données sources de la DGFiP et intégrées sous une forme transformée (par concaténation, découpage, etc.). | anneemut, idpar, idloc, etc. |
| Données calculées et/ou agrégées | Données issues de calculs (mathématique, conditionnel, etc.) ou d’agrégations effectués à partir d’autres données du modèle. | vefa, nbsufidt, dcnt01, nbparmut, etc. |
 

Chacune des variables du modèle DVF+ est calculée uniquement à partir des données brutes de DVF, ces dernières étant d'ailleurs intégralement restituées par le modèle. Il n’y a pas de données exogènes à ce stade. Les variables calculées visent à pouvoir s’appliquer sur l’ensemble du territoire et à relever d’une méthodologie ne pouvant être remise en cause. 

Ces variables restent plutôt intitutives pour correspondre à des éléments d’analyse représentatifs des besoins courants des utilisateurs. Elle permettent, à la fois, d’effectuer rapidement des calculs d’indicateurs mais aussi d’aboutir à la mise en œuvre de méthodologies locales ou nationales plus complexes (ex: typologie de bien).

#### Syntaxe des variables

Quelques règles syntaxiques ont été mises en place sur les variables pour donner quelques repères à l'utilisateur :

| Si la variable commence par... | Alors il s'agit d'un(e)...              |
|--------------------------------|-----------------------------------------|
| id | identifiant |
| cod | code (postal, insee, etc...) |
| s | surface |
| nb | denombrement |
| l_ | liste (type array) |
| lib | libellé |

A noter que toutes les variables comportent au maximum 10 caractères de manière à faciliter l'exportation au format shp.

## Pour compléter votre lecture...

A savoir qu'un guide d'accompagnement sur DVF, co-construit par une large communauté d'utilisateurs, existe. Il est disponible ou téléchargeable sur le [site du Groupe national DVF](http://www.guide-dvf.fr).

Une littérature détaillée concernant les Fichiers fonciers est également disponible sur le site [GeoInformations](http://www.geoinformations.developpement-durable.gouv.fr/fichiers-fonciers-r549.html)



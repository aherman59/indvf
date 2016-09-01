Titre: Description du modèle DVF+
Theme: Base de données
Numero: 2
Auteurs: Antoine Herman - Cerema
MAJ: 01/09/2016
Contact: dv3f@cerema.fr

## Contexte

Les travaux autour de la création d’un modèle permettant de faciliter le passage des données DGFiP, « Demande
de valeurs foncières » (DVF), en base de données aisément exploitable s’inscrivent dans un processus qui a
débuté en 2011 à l’initiative d’un groupe technique lancé par l’ADEF, aujourd'hui devenu le Groupe National DVF (GnDVF). 

Ce groupe s’est réuni plusieurs fois et a associé, dès 2013, le CETE Nord-Picardie (aujourd’hui Direction Nord-Picardie du Cerema). Un modèle de données pour l’import des données natives de DVF a été produit et partagé collégialement par le groupe.

Depuis, le Cerema a travaillé, pour le compte de la DGALN, à étoffer ce modèle en y ajoutant de nouvelles
variables au sein d’un premier modèle, baptisé DVF+. 

Il propose, par ailleurs, des outils et scripts, libres d'utilisation, pour l'importation et la structuration de la donnée brute DVF dans une base de données PostgreSQL selon ce modèle.

## Intérêt de DVF+

Gérer de gros volume de données / Accéder facilement à l'information / Combiner facilement des informations 

Structurer la donnée (chaque table permet de représenter une unique notion de DVF et de rattacher les données qui y sont liées)
Supprimer les données dupliquées, très présentes dans DVF
Transformer une donnée d'origine fiscale en une donnée plus exploitable pour l'analyse foncière et immobilière

## Tables constitutives du modèle

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

## Variables constitutives du modèle

### Des variables brutes et des variables plus élaborées facilitant l'analyse 

Plusieurs catégories de variables existent au sein de "DVF+":

| Catégorie | Description  | Exemples |
|-----------|-----------------------|-------------------|
| Identifiants de clef primaire | Entiers ou chaînes de caractère permettant de désigner une et une seule entité d’une table. L’identifiant de clef primaire de la table apparait au début de chacune des tables. | idmutation, iddispo, iddispoloc, etc. |
| Données brutes | Données provenant des données sources de la DGFiP et intégrées sans transformation dans le modèle. | refdoc, coddep, scarrez, etc. |
| Données brutes transformées | Données provenant des données sources de la DGFiP et intégrées sous une forme transformée (par concaténation, découpage, etc.). | anneemut, idpar, idloc, etc. |
| Données calculées et/ou agrégées | Données issues de calculs (mathématique, conditionnel, etc.) ou d’agrégations effectués à partir d’autres données du modèle. | vefa, nbsufidt, dcnt01, nbparmut, etc. |
 

Chacune des variables du modèle DVF+ est calculée uniquement à partir des données brutes de DVF, ces dernières étant d'ailleurs intégralement restituées par le modèle. Il n’y a pas de données exogènes à ce stade. Les variables calculées visent à pouvoir s’appliquer sur l’ensemble du territoire et à relever d’une méthodologie ne pouvant être remise en cause. 

Ces variables restent plutôt intitutives pour correspondre à des éléments d’analyse représentatifs des besoins courants des utilisateurs. Elle permettent, à la fois, d’effectuer rapidement des calculs d’indicateur mais aussi d’aboutir à la mise en œuvre de méthodologies locales ou nationales plus complexes (ex: typologie de bien).

### Syntaxe des variables

Quelques règles syntaxiques ont été mises en place sur les variables pour donner quelques repères à l'utilisateur :

| Si la variable commence par... | Alors il s'agit d'un(e)...              |
|--------------------------------|-----------------------------------------|
| id | identifiant |
| cod | code (postal, insee, etc...) |
| s | surface |
| nb | denombrement |
|l_ | liste (type array) |
| lib | libellé |

A noter que toutes les variables comportent au maximum 10 caractères de manière à faciliter l'exportation au format shp.
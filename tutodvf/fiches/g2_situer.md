Titre: Situer dans le temps et l'espace
Theme: Bien démarrer avec DV3F
Numero: 2 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 18/04/2018
Contact: dv3f@cerema.fr

[TOC]

## Situer dans le temps

### Date de mutation
 
La date de mutation est le jour de la date de signature de l'acte notarié. 

C'est une donnée essentielle car les prix d'un même bien vendus en 2004 et 2014 ne sont pas comparables.

### Choix de la période d'observation

Il est important de bien définir les limites temporelles pour le type d'analyse que l'on souhaite réaliser. Deux contraintes s'appliquent pour le choix de la période d'observation :

* _Temps de latence liés à DVF_ : L'enregistrement des actes de vente par les services fiscaux peut prendre plusieurs mois ce qui implique une apparition tardive dans la donnée DVF. Ainsi, lorsque l'on effectue des analyses quantitatives (nombre de mutations ou volume de transactions, par exemple), il faut éviter de regarder l'évolution sur les derniers trimestres.
* _Appariement avec les Fichiers fonciers_ : la disponibilité des Fichiers fonciers peut impacter le niveau de remplissage de DV3F, notamment sur la dernière année et particulièrement pour les informations liées aux acheteurs. Ainsi, lorsque l'on souhaite travailler sur les logiques d'acteurs, par exemple, il est préférable de travailler sur la période couverte par les Fichiers fonciers.

Pour la version 2 de DV3F, il est conseillé de travailler sur la période 2010-2015.

### Cas pratiques

@TUTO@g2_situer_exos|Cas pratique S1 : Choisir sa période temporelle dans AppDVF|cas-pratique-s1-choisir-sa-periode-temporelle-a-partir-de-appdvf@TUTO@ 

@TUTO@g2_situer_exos|Cas pratique S2 : Choisir sa période temporelle dans PostgreSQL/PostGIS|cas-pratique-s2-choisir-sa-periode-temporelle-dans-postgresqlpostgis@TUTO@

```variables
@-@Variables associées@-@

Mutation, Local, Disposition_parcelle : @@mutation|anneemut@@, @@mutation|moismut@@ et @@mutation|datemut@@ 
Disposition_parcelle : @@disposition_parcelle|datemutpre@@, @@disposition_parcelle|datemutsui@@, @@disposition_parcelle|l_idmutpre@@ et @@disposition_parcelle|l_idmutsui@@
Local : @@local|datemutpre@@, @@local|datemutsui@@, @@local|l_idmutpre@@ et @@local|l_idmutsui@@  
``` 

## Situer dans l'espace

### Informations disponibles pour localiser

DV3F permet la localisation des biens selon plusieurs moyens : 

* via les informations administratives : code du département, code insee de la commune, code de section cadastrale, numéro des parcelles concernées par la vente ;
* via la géolocalisation à la parcelle : un localisant ponctuel et un contour vectorisé ;
* via l’adresse du bien : numéro de la voie, libellé de la voie, code postal et libellé de commune ;


### Géolocalisation dans DV3F

Des géométries sont présentes dans trois tables de DV3F :

* dans la table _disposition_parcelle_ : le contour et le localisant de chaque parcelle est restitué respectivement par @@disposition_parcelle|geompar@@ et @@disposition_parcelle|geomloc@@ ;  
* dans la table _local_ : le localisant de la parcelle sur laquelle se situe le local au moment de la vente est restitué par @@local|geomloc@@ ;
* dans la table _mutation_ : la variable @@mutation|geomparmut@@ correspond au contour de l'ensemble des parcelles ayant muté, la variable @@mutation|geomloc@@ correspond aux localisants des parcelles sur lesquels se situent les locaux mutés et la variable @@mutation|geompar@@ correspond au contour de l'ensemble des parcelles concernées.

### Sites distants


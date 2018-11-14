Titre: Dénombrer les mutations, les locaux et les parcelles
Theme: Bien démarrer avec DV3F
Numero: 1 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 12/04/2018
Contact: dv3f@cerema.fr

[TOC]

## Dénombrer les mutations

### Définition d'une mutation

Une mutation est une transaction permettant le passage de propriété d'un ou plusieurs biens entre un vendeur et un acheteur. Elle se matérialise par un acte notarié (le plus souvent, un acte de vente).

Concrètement, une mutation peut comprendre un mélange presque illimité des biens suivants :

* une parcelle nue (terrain), 
* un local (appartement, maison, local d'activité, dépendance),
* un volume (division de propriété très particulière).

Ainsi, la retranscription d'une vente de maison dans DV3F sera en général une mutation comprenant une parcelle et un local de type maison. 


### Mutations présentes dans DV3F

DV3F permet le référencement de toutes les mutations onéreuses en France, hors Alsace Moselle, et Mayotte. 

Toutes les mutations sont enregistrées à l’exception : 

* des mutations non onéreuses : succession, legs, etc.,
* des transferts de propriétés ne faisant pas l'objet d'un acte notarié tels que les ventes de part de SCI et certaines ventes de public à public,
* des mutations dites « complexes » dans l'enregistrement auprès de la DGFiP : celles-ci correspondent, en général, soit à des ventes de parcelles ayant de très grandes copropriétés soit à des ventes avec un litige.

Dans l'illustration ci-dessous, la parcelle entourée en rouge est concernée par des ventes mais cela n'a pas été retranscrit dans DV3F (mutation complexe):

![*Mutation "complexe"*](ressources/mutation_complexe.jpg "Mutation complexe")

<div class="embed-responsive embed-responsive-4by3">
<figure class="video_container">
  <video controls="true" allowfullscreen="true">
    <source src="/dv3f/static/img/tutodvf/Indvf.mp4" type="video/mp4">
  </video>
</figure>
</div>


### Identification de la mutation

Dans DVF+/DV3F, chaque ligne de la table _mutation_ correspond à une mutation de DVF. Chaque mutation est identifiée par deux identifiants uniques:

* @@mutation|idmutation@@, valeur entière générée lors de la création de la base, 
* @@mutation|idmutinvar@@, composé du code du service de la publicité foncière enregistré (@@mutation|codservch@@) et de la référence du document (@@mutation|refdoc@@) produit lors de cet enregistrement. 

Le code @@mutation|idmutation@@ est présent dans toutes les tables de DV3F et permet d’effectuer très simplement des jointures entre celles-ci. 

Le code @@mutation|idmutinvar@@ est la combinaison des codes utilisés par les services de publicité foncière. Il permet donc de retrouver les références de publicité foncière si l’utilisateur souhaite leur commander une référence officielle. @@mutation|idmutinvar@@ est invariant et permet de comparer des bases DVF+/DV3F entre elles.

### Cas Pratiques

@TUTO@g1_denombrer_exos|Cas pratique D1 : Dénombrer les mutations à partir de AppDVF|cas-pratique-d1-denombrer-les-mutations-a-partir-de-appdvf@TUTO@ 

@TUTO@g1_denombrer_exos|Cas pratique D2 : Dénombrer les mutations dans PostgreSQL/Postgis|cas-pratique-d2-denombrer-les-mutations-dans-postgresqlpostgis@TUTO@  





## Dénombrer les locaux


### Définition d'un local

Le local est un ensemble de :

>> « différentes constructions qui, en raison de leur agencement, forment un ensemble immobilier homogène d’un même compte-propriétaire ». 
>> 
>> « Ne sauraient être considérés comme constituant un local distinct, ni la pièce meublée d'un logement loué en meublé à un étudiant, ni les pièces occupées temporairement par un jeune ménage dans l'appartement des parents de l'un des conjoints, ni le garage d'une maison individuelle faisant l'objet à titre accidentel d'une location séparée, etc » 


### Type de locaux présents dans DV3F

Un local est différencié, par la DGFiP, en 4 catégories selon sa forme physique : 

* la maison,
* l'appartement,
* la dépendance (forcément liée à l'habitation),
* l'activité (et ses dépendances).

![*Formes physiques d'un local*](ressources/forme_physique_local.png "Formes physiques d'un local")

La notion de logement regroupe les locaux de type maison ou appartement. En ce qui concerne l'activité, les activités primaires ne sont pas observées mais il est possible, via DV3F, de différencier les activités secondaires et tertiaires. 


Cette différenciation de la forme physique est très fiable. Une nomenclature plus fine est disponible dans la table local (@@local|ffcnatloc@@). 

### Identification du local


Dans DVF+/DV3F, chaque ligne de la table _local_ représente l'état d'un local lors de sa mutation à laquelle on affecte un identifiant @@local|iddispoloc@@. 

Il existe également l'identifiant fiscal du local @@local|idloc@@, invariant dans le temps et indépendant de la mutation, qui correspond aussi à l'identifiant des Fichiers fonciers (idlocal). C'est cet identifiant qui est remonté au niveau de la table _mutation_. 

Ainsi, une mutation peut comporter 0, 1 ou plusieurs locaux mutés qui seront référencés dans la variable @@mutation|l_idlocmut@@ grâce à cet identifiant fiscal. Il est important de noter que ce reférencement peut parfois être incomplet du fait d'un temps de latence. Celui touche principalement les locaux vendus en VEFA. 

### Dénombrement des locaux

Dans la table _mutation_, des informations agrégées permettent de faciliter les décomptes et identifications des locaux ayant muté, selon leur forme physique ou, pour les logements, selon leur nombre de pièces et/ou leur ancienneté. 

### Cas Pratiques

@TUTO@g1_denombrer_exos|Cas pratique D3 : Dénombrer les locaux à partir de AppDVF|cas-pratique-d3-denombrer-les-locaux-a-partir-de-appdvf@TUTO@ 

@TUTO@g1_denombrer_exos|Cas pratique D4 : Dénombrer les locaux dans PostgreSQL/Postgis|cas-pratique-d4-denombrer-les-locaux-dans-postgresqlpostgis@TUTO@


```variables
@-@Variables associées@-@
Local : @@local|idloc@@, @@local|iddispoloc@@, @@local|codtyploc@@, @@local|libtyploc@@, @@local|ffctyploc@@, @@local|ffltyploc@@, @@local|ffcnatloc@@ et @@local|fflnatloc@@
Mutation : @@mutation|nblocmut@@, @@mutation|l_idlocmut@@, @@mutation|nblocmai@@, @@mutation|nblocapt@@, @@mutation|nblocdep@@, @@mutation|nblocact@@, @@mutation|nbmai1pp@@, @@mutation|nbmai2pp@@, @@mutation|nbmai3pp@@, @@mutation|nbmai4pp@@, @@mutation|nbmai5pp@@, @@mutation|nbapt1pp@@, @@mutation|nbapt2pp@@, @@mutation|nbapt3pp@@, @@mutation|nbapt4pp@@, @@mutation|nbapt5pp@@, @@mutation|nblocanc@@, @@mutation|nblocrecen@@, @@mutation|nblocneuf@@, @@mutation|ffnblocmai@@, @@mutation|ffnblocapt@@, @@mutation|ffnblocdep@@, @@mutation|ffnblocact@@, @@mutation|ffnbactsec@@ et @@mutation|ffnbactter@@ 
```

 

## Dénombrer les parcelles

### Définition d'une parcelle

La définition d'une parcelle est la suivante : 

>> « Portion de terrain d’un seul tenant, situé dans un même lieu-dit, appartenant à un même propriétaire ou à une même indivision 
>> et constituant une unité foncière indépendante selon l’agencement donné à la propriété. Le numérotage parcellaire est effectué,
>> à l’origine, sans interruption et par sections. Toute parcelle nouvelle ou modifiée reçoit un nouveau numéro pris à la 
>> suite du dernier attribué dans la section ; le numéro de la parcelle primitive n’est jamais réutilisé mais il permet 
>> de localiser la nouvelle parcelle créée qui fait référence à la parcelle primitive ». 

### Notion de parcelles mutées / parcelles concernées

Lorsque la propriété pleine et entière de la parcelle est transférée lors de la mutation, alors la parcelle est dite "mutée". 
Le prix de la vente comprend la propriété de ce bien.

Une parcelle est dite "concernée" si elle est :

* soit une parcelle mutée,
* soit une parcelle qui ne subit aucun transfert total de propriété mais dont la propriété d'au moins un bien présent sur celle-ci 
est transférée lors de la mutation (les cas les plus fréquents sont les ventes d'appartements).

![*Parcelles mutées/concernées*](ressources/parcelle_mutee_concernee.png "Parcelles mutées/concernées")


### Identification de la parcelle

La parcelle est référencée par un code alpha-numérique se composant du code insee du département (@@disposition_parcelle|coddep@@), de la commune (@@disposition_parcelle|codcomm@@), d'un préfixe de trois chiffres (@@disposition_parcelle|prefsect@@), du numéro de la section cadastral sur 2 caractères (@@disposition_parcelle|nosect@@), et de 4 chiffres désignant le numéro de la parcelle (@@disposition_parcelle|noplan@@).

Elle peut changer d’occupation mais pas de contour. Si le contour doit être modifié, alors la parcelle est remplacée par une autre parcelle. 
D'un point vue cadastral, cela se traduit par un changement d'identifiant.

Dans DVF+/DV3F, chaque ligne de la table _disposition_parcelle_ représente une "disposition-parcelle", c'est-à-dire l'état d'une parcelle lors qu'elle mute ou qu'elle est concernée par une vente. Chaque disposition-parcelle est identifiée par un identifiant @@disposition_parcelle|iddispopar@@ (valeur entière) et est rattachée à sa mutation par la variable @@disposition_parcelle|idmutation@@.

Ainsi, une mutation peut comporter 0, 1 ou plusieurs parcelles concernées et/ou mutées qui seront référencées respectivement dans les variables @@mutation|l_idpar@@ et @@mutation|l_idparmut@@.

### Dénombrement des parcelles

Dans la table mutation, des informations agrégées permettent de faciliter les décomptes et identifications des parcelles ayant muté ou simplement concernées par la mutation. 

### Cas Pratiques

@TUTO@g1_denombrer_exos|Cas pratique D5 : Dénombrer les parcelles à partir de AppDVF|cas-pratique-d5-denombrer-les-parcelles-a-partir-de-appdvf@TUTO@ 

@TUTO@g1_denombrer_exos|Cas pratique D6 : Dénombrer les parcelles dans PostgreSQL/Postgis|cas-pratique-d6-denombrer-les-parcelles-dans-postgresqlpostgis@TUTO@


```variables
@-@Variables associées@-@
Disposition_parcelle : @@disposition_parcelle|idpar@@, @@disposition_parcelle|iddispopar@@, @@disposition_parcelle|parcvendue@@, @@disposition_parcelle|coddep@@, @@disposition_parcelle|codcomm@@
Mutation : @@mutation|nbpar@@, @@mutation|l_idpar@@, @@mutation|nbparmut@@ et @@mutation|l_idparmut@@   
``` 



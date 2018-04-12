Titre: Dénombrer les mutations, les locaux et les parcelles
Theme: Bien démarrer avec DV3F
Numero: 1 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 12/04/2018
Contact: dv3f@cerema.fr



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

![*Mutation "complexe"*](ressources/mutation_complexe.jpg "Mutation complexe") 

### Identification de la mutation

Dans DVF+/DV3F, chaque ligne de la table mutation correspond à une mutation de DVF. Chaque mutation est identifiée par deux identifiants uniques:

* @@mutation|idmutation@@, valeur entière générée lors de la création de la base, 
* @@mutation|idmutinvar@@, composé du code du service de la publicité foncière enregistré (@@mutation|codservch@@) et de la référence du document (@@mutation|refdoc@@) produit lors de cet enregistrement. 

Le code @@mutation|idmutation@@ est présent dans toutes les tables de DV3F et permet d’effectuer très simplement des jointures entre celles-ci. 

Le code @@mutation|idmutinvar@@ est la combinaison des codes utilisés par les services de publicité foncière. Il permet donc de retrouver les références de publicité foncière si l’utilisateur souhaite leur commander une référence officielle. @@mutation|idmutinvar@@ est invariant et permet de comparer des bases DVF+/DV3F entre elles.

### Cas Pratiques

@TUTO@g1_denombrer_exos|Cas pratique 1 : Dénombrer les mutation à partir de AppDVF|cas-pratique-1-denombrer-les-mutations-a-partir-de-appdvf@TUTO@ 

@TUTO@g1_denombrer_exos|Cas pratique 2 : Dénombrer les mutation dans PostgreSQL/Postgis|cas-pratique-2-denombrer-les-mutations-dans-postgresqlpostgis@TUTO@  





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


En ce qui concerne l'activité, les activités primaires ne sont pas observées. Via les Fichiers fonciers, il est possible de différencier les activités secondaires et tertiaires. 

La notion de logement regroupe les locaux de type maison ou appartement.

Globalement, l'ensemble sont très fiables et concordantes. Les derniers variables issues des Fichiers fonciers sont à privilégier lorsqu'il s'agit de travailler sur une analyse fine faisant appel à d'autres variables également issues des Fichiers fonciers (notion d'ancienneté, par exemple). 

```variables
@-@Variables associées@-@
Local : @@local|codtyploc@@, @@local|libtyploc@@, @@local|ffctyploc@@, @@local|ffltyploc@@, @@local|ffcnatloc@@ et @@local|fflnatloc@@
Mutation : @@mutation|nblocmai@@, @@mutation|nblocapt@@, @@mutation|nblocdep@@, @@mutation|nblocact@@, @@mutation|ffnblocmai@@, @@mutation|ffnblocapt@@, @@mutation|ffnblocdep@@, @@mutation|ffnblocact@@, @@mutation|ffnbactsec@@ et @@mutation|ffnbactter@@ 

```

### Identification et décompte de locaux

Dans DVF+/DV3F, chaque ligne de la table _local_ représente l'état d'un local lors de sa mutation. Chaque local est identifiée par un identifiant @@local|iddispoloc@@ (valeur entière) et est rattachée à sa mutation par la variable @@local|idmutation@@.

Dans cette table _local_, on retrouve les variables liées à l'identité du local : @@local|idloc@@ qui est composé du code Insee de la commune auquel il apparaît et de la variable  @@local|identloc@@

Dans la table mutation, des informations agrégées permettent de faciliter les décomptes et identifications des locaux ayant muté : @@mutation|nblocmut@@ et @@mutation|l_idlocmut@@.

Attention, la présence du local dans DVF+/DV3F peut prendre parfois un certain temps. C'est ce qu'on appelle le temps de latence. Ainsi, pour les locaux neufs ou en VEFA, il est possible que ces derniers ne soient pas encore identifiés.

Par ailleurs, on peut constater un nombre non négligeable de mutations DVF qui ont au moins un local non présent dans les Fichiers fonciers. Ces manques concernent principalement les cas de VEFA et les mutations après le dernier millésime des Fichiers fonciers disponible. Si on s'attreint à travailler sur une période en accord avec les Fichiers fonciers, alors le taux d'erreur devient marginal, sauf pour les VEFA. Il est possible de s'appuyer sur la variable @@mutation|rapatffloc@@ de la table _mutation_ pour savoir si les informations issues des Fichiers fonciers ont bien été rapatriées. 

## Dénombrer les parcelles


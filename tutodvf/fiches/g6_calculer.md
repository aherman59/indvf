Titre: Calculer un prix de marché
Theme: Bien démarrer avec DV3F
Numero: 6
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 11/05/2018
Contact: dv3f@cerema.fr

[TOC]

## Le prix dans DV3F

Le prix exprimé dans DV3F est appelé valeur foncière (@@mutation|valeurfonc@@). 

C’est un prix en euros TTC. Il ne comprend ni les frais de notaires, ni les biens meubles. 

Pour un logement classique, les frais de notaire avoisinent 10% du prix et les biens meubles représentent a minima 5 à 10 000 euros supplémentaires lorsqu'il y a une cuisine aménagée ou des meubles intégrés.

Selon les situations, les frais d'agence sont inclus ou non dans le prix. Concrètement, si l’agence immobilière a été saisie par le vendeur (mandat de vente), ils seront inclus; si l’agence a été saisie par l’acheteur (mandat de recherche), ils ne seront pas inclus dans le prix remonté dans DV3F. 

En matière d’expropriation, le prix indiqué comprend le montant de l’indemnité.

Le montant de la TVA n’est pas disponible dans DV3F. Par contre, certains codes généraux des impôts (CGI) sont signalés (5 au maximum par mutation dans la variable @@mutation|l_artcgi@@) et c'est sur la base de ces articles que la taxation est définie. On peut donc parfois identifier la taxation appliquée. 
Malheureusement, ces articles ne sont pas tous restitués dans DV3F (en particulier ceux sur le monde agricole ou les codes CGI valables que ponctuellement).

Un travail d'exploitation des articles CGI a été mené par le GnDVF et permet une meilleure interprétation des articles CGI pour la ventilation des biens ayant muté (fiche 8 du Guide GnDVF).

Pour information, certains indicateurs de DV3F créés par le Cerema s’appuient aussi sur ces codes CGI.  En effet, même si son but premier n’est pas l’analyse et l’observation, chaque article CGI renvoit aussi des informations spécifiques sur l’acheteur ou le vendeur et/ou sur le(s) bien(s) muté(s), qui peuvent être très intéressantes. Par exemple, certains codes renseignent sur le fait qu'il s'agit de VEFA, ou signalent que l’acheteur est un organisme HLM. 

```variables
@-@Variables associées@-@
Mutation : @@mutation|valeurfonc@@, @@mutation|nbartcgi@@, @@mutation|l_artcgi@@.
``` 


## Utilisation des surfaces d'un local pour le prix

Pour effectuer des prix selon la surface du terrain ou du bien bâti, il est important de bien connaître ces deux notions de surfaces.

### Surface d'une parcelle

La surface @@mutation|ffsparc@@ est la surface officielle au cadastre et devrait être la référence à prendre pour la surface de la parcelle. 

Il existe deux autres variables décrivant la surface du terrain ayant muté dans DV3F et qui normalement sont équivalentes à la surface de la parcelle :

* @@mutation|sterr@@ qui correspond à la somme de toutes les surfaces des suf (subdivisions fiscales) issues de DVF ayant muté pour une même mutation, 
* @@mutation|ffsterr@@ qui correspond à la somme de toutes les surfaces des suf issues des Fichiers fonciers ayant muté pour une même mutation.

Il peut exister des différences de surface entre @@mutation|sterr@@, @@mutation|ffsterr@@, @@mutation|ffsparc@@ mais cela reste marginal et @@mutation|sterr@@ est systématiquement rempli, contrairement à @@mutation|ffsparc@@. De ce fait, il est conseillé d'utiliser en priorité @@mutation|sterr@@. 

Par contre, il est peut-être intéressant de s'assurer lorsqu’on travaille sur des échantillons ou de très petits nombres de mutations que ces variables sont cohérentes entre elles, surtout si l’on travaille sur l’occupation du sol (suf).

### Surface d'un local

La surface d'un local présente plusieurs définitions, ce qui peut rendre difficile le travail sur les prix au m2 et leur comparaison avec d'autres données.

#### Surface réelle bâtie

Dans DV3F, la surface bâtie représente la surface mesurée au sol du plancher entre murs ou séparations. Le résultat est arrondi au mètre carré inférieur.

Pour le calcul des surfaces, les instructions précises de la DGFiP sont décrites ci-après : 
>> « Dans le cas où, par suite de l'absence des documents susvisés, la surface des éléments doit être mesurée, il convient de comprendre dans cette dernière :

>> * la superficie des espaces tels que bow-windows (fenêtres en saillie sur une façade), alcôves, volumes de rangement, ouverts sur lesdits éléments ;
>> * celle occupée par les diverses installations : appareils sanitaires, éviers, placards en saillie des murs et cloisons, appareils de chauffage, cheminées, etc. ;
>> * celle des éléments de décors : colonnes, pilastres, etc.

>> En revanche, ne doivent pas être retenues dans cette surface les superficies occupées par :

>> * les embrasures des portes et des fenêtres ;
>> * les espaces occupés par des conduits de fumée et de ventilation ;
>> * les placards de rangement en renfoncement de faible superficie ;
>> * les emmarchements et trémies d'escaliers (surfaces correspondant aux marches, paliers intermédiaires et aux jours entre volées où peuvent être aménagés ascenseurs ou monte-charge, mais non les paliers d'étage qui sont compris dans 
>> * la surface réelle lorsqu'il s'agit d'une maison individuelle).»

Elle peut se décomposer en une surface dite "habitée", une surface professionnelle (ou liée à une activité) et une surface de dépendances.

Dans DV3F, la notion de surface réelle bâtie (@@mutation|sbati@@),est la somme de la surface habitée et de la surface professionnelle et la notion de surface réelle bâtie provenant des Fichiers fonciers (@@mutation|ffsbati@@),est la somme de la surface habitée, de la surface professionnelle et des surfaces des dépendances. Ainsi, lorsque le rapatriement est bien effectué, on peut écrire les égalités suivantes :

* sbati = ffshab + ffspro,
* ffsbati = ffshab + ffspro + ffsdep. 

Le détail des différentes composantes de surface selon l'occupation est disponible.


#### Surface Carrez

La surface privative ou surface Carrez doit être mentionnée dans le cadre d'une vente comprenant un lot de copropriété.  Elle se définit comme la superficie des planchers des locaux clos et couverts après déduction des surfaces occupées par les murs, cloisons, marches et cages d'escaliers, gaines, embrasures de portes et de fenêtres.

Elle ne comptabilise ni les surfaces dont la hauteur sous plafond est inférieure à 1,80m ni les surfaces de pièces de moins de 8 m². Cette surface est disponible pour les 5 premiers lots d'une mutation dans DVF mais n'est pas disponible pour les locaux (@@lot|scarrez@@).

![*Surfaces d'un local*](ressources/surface_local.png "Surfaces d'un local")

```variables
@-@Variables associées@-@
Mutation : @@mutation|sterr@@, @@mutation|ffsterr@@, @@mutation|ffsparc@@, @@mutation|l_dcnt@@, @@mutation|l_ffdcnt@@, @@mutation|sbati@@, @@mutation|ffsbati@@, @@mutation|ffshab@@, @@mutation|ffsdep@@, @@mutation|ffspro@@, @@mutation|sbatmai@@, @@mutation|smai1pp@@ à @@mutation|smai5pp@@, @@mutation|sbatapt@@, @@mutation|sapt1pp@@ à @@mutation|sapt5pp@@.  
Disposition_parcelle : @@disposition_parcelle|sterr@@, @@disposition_parcelle|ffsterr@@, @@disposition_parcelle|ffsparc@@, @@disposition_parcelle|dcnt01@@ à @@disposition_parcelle|dcnt13@@, @@disposition_parcelle|ffdcnt01@@ à @@disposition_parcelle|ffdcnt13@@.
Local : @@local|sbati@@, @@local|ffsbati@@, @@local|ffshab@@, @@local|ffsdep@@, @@local|ffspro@@.
Lot : @@lot|scarrez@@.
``` 

## Les indicateurs de prix

### Médiane, moyenne

Pour créer des prix moyens ou médians, il est fortement conseiller d’appliquer une logique de segmentation (cf @TUTO@g5_segmenter|Regrouper les mutations homogènes pour construire un segment de marché@TUTO@).

La moyenne ne peut être justifiée que lorsque l’on est sûr que l’ensemble est totalement homogène. Cet idéal pouvant toujours être remis en cause en pratique, il est toujours plus souhaitable de travailler avec la médiane qui atténue d'avantage l'effet d'éventuelles valeurs extrêmes. 

L'utilisation de la médiane permet également de travailler avec des quartiles ou des déciles (lorsque la taille de l'échantillon le permet) qui sont complémentaires pour observer la dispersion des prix.

A noter qu'il existe des outils statistiques plus complexes tels que les prix hédoniques ou l'analyse des données symboliques.


### Les euros constants

Les valeurs foncières peuvent être rapportées à une année de référence pour permettre la prise en compte de l’inflation. 

Une maison à 100 000 euros en 2009 n’a pas un prix équivalent à celui d’une maison de 100 000 euros en 2017, toutes choses égales par ailleurs. Les effets de l'inflation porteraient le prix à 108 446 euros (100 000 x 2568 / 2368 d'après les indicateurs de l'Insee). 

Les prix courants sont les prix tels qu'ils sont indiqués à une période donnée (100 000 en 2009). Les prix constants (100 000 ramené en 2017 soit 108 446) sont les prix en valeur réelle c'est-à-dire corrigés de la variation des prix par rapport à une donnée de base ou de référence. C'est pourquoi on parle aussi d'euros constants et d'euros courants.

### Les prix extrêmes

La variable @@mutation|filtre@@ permet d’évincer les prix à 0 ou 1 euros. Mais rien n’empêche l’utilisateur d’être plus strict dans l’éviction de mutations.
Par exemple, on peut évincer les mutations de moins de 100 euros.
 
A l’inverse, il y a manifestement quelques valeurs foncières anormalement hautes qui sont associées à des mutations dans DVF+/DV3F. Elles sont très rares mais peuvent poser des problèmes pour l'analyse des prix. Une rapide vérification sur la base de données permet de s'en assurer et éventuellement d'exclure les mutations qui présentent des prix anormaux.

### Cas Pratiques

@TUTO@g6_observer_exos|Cas pratique O3 : Analyse des prix à l'aide de AppDVF|cas-pratique-o3-analyse-des-prix-a-laide-de-appdvf@TUTO@

@TUTO@g6_observer_exos|Cas pratique O4 : Analyse des prix dans PostgreSQL/PostGIS|cas-pratique-o4-analyse-des-prix-dans-postgresqlpostgis@TUTO@


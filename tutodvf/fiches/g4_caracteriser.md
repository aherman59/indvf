Titre: Caractériser une mutation à l'aide de la typologie de bien
Theme: Bien démarrer avec DV3F
Numero: 4 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 11/05/2018
Contact: dv3f@cerema.fr

[TOC]

## La typologie de bien

Une typologie de biens classifie les mutations selon le ou les types de biens vendus. 

Il existe de nombreuses possibilités pour classifier les biens selon ce que l’on souhaite observer. Elle se doit de classer toutes les mutations et peut avoir plusieurs niveaux de classifications, imbriqués les uns dans les autres.

Aux vues des différentes interprétations d'une même terminologie et des possibilités presque illimitées de classement, il a été nécessaire d’établir une concertation pour trouver une typologie qui convienne au plus grand nombre. Pour cela, le groupe national DVF (GnDVF) a initié un groupe de réflexion à ce sujet. La typologie présente dans DV3F est le résultat de ces réflexions. 

Cette typologie possède au plus 5 niveaux :

* le niveau 1 différencie les biens bâtis des biens non bâtis,
* le niveau 2 présente les grandes catégories de biens immobiliers et fonciers,
* le niveau 3 présente les sous-catégories de biens immobiliers et fonciers (avec notamment les types d'activités ou l'occupation du sol),
* le niveau 4 intègre essentiellement les notions d’ancienneté des logements ou le détail de l'occupation des terrains agricoles,
* le niveau 5 intègre les notions de nombre de pièces pour les appartements.

Sont présentés dans les schémas suivants les différentes classes de typologie.

![*Typologie de bien batie*](ressources/typo_batie.png "Typologie de bien batie")

![*Typologie de bien non batie*](ressources/typo_nonbatie.png "Typologie de bien non batie")
 
 
Pour note de lecture, la vente d’un bâti d’activité secondaire aura le code 142, celle d'un terrain viticole, le code 2311.
 
A noter également que chaque catégorie n'a le même poids en terme de nombre de mutations. A titre d'exemple, la catégorie 'Une maison ancienne' (1113) représente environ 40% des ventes présentes dans DV3F (sur la période 2010-2015 en France).

## Utilisation de la typologie de bien 


Cette typologie peut être considérée comme fiable pour les biens immobiliers bâtis et en particulier les logements. Elle peut, par exemple, servir de base pour la construction d'indicateurs agrégés de suivi de dénombrement, de montant globaux et de prix. Seuls les VEFA et les volumes ne sont pas forcément caractérisés (code 101 et 102).

La typologie est à utiliser avec précaution pour tout ce qui concerne le foncier non bâti. Les catégories de biens proposés pour les mutations sans locaux sont à considérer comme une information à analyser plus finement, en particulier pour les terrains de « type TAB » qui ne correspondent qu’à une définition fiscale du terrain à bâtir. 

La codification par niveaux a un double intérêt:

* permettre une caractérisation la plus fine possible du ou des biens vendus,
* considérer des groupes de mutations homogènes selon le niveau de zoom souhaité (par exemple, les ventes d'un appartement sont issues du regroupement de toutes les catégories commençant par '121').

Bien évidemment, il est possible d'affiner ou de compléter cette typologie à partir des informations détenues dans DV3F, en particulier dans les tables local et disposition_parcelle.

A noter que lorsque l'on souhaite travailler à partir de données issues des Fichiers fonciers, @@mutation|rapatffloc@@ et @@mutation|rapatffpar@@ sont très utiles pour s'assurer que l'échantillon de mutations que l'on sélectionne le permet. 

### Cas Pratiques

@TUTO@g4_caracteriser_exos|Cas pratique C2 : Caractériser des mutations à l'aide de la typologie de biens dans PostgreSQL/PostGIS|cas-pratique-c2-caracteriser-des-mutations-a-laide-de-la-typologie-de-biens-dans-postgresqlpostgis@TUTO@

@TUTO@g4_caracteriser_exos|Cas pratique C3 : Affiner la typologie de biens dans PostgreSQL/PostGIS|cas-pratique-c3-affiner-la-typologie-de-biens-dans-postgresqlpostgis@TUTO@

```variables
@-@Variables associées@-@
Mutation : @@mutation|codtypbien@@, @@mutation|libtypbien@@, @@mutation|rapatffloc@@, @@mutation|rapatffpar@@ 
```


 
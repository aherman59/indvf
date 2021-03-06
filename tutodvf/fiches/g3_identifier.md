Titre: Identifier les acheteurs et vendeurs
Theme: Bien démarrer avec DV3F
Numero: 3 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 19/04/2018
Contact: dv3f@cerema.fr

[TOC]

## Identifier un acheteur ou un vendeur

### Les acheteurs-vendeurs dans DV3F

L'apport d'informations sur les acheteurs et vendeurs issus des Fichiers fonciers est l'un des atouts majeurs de DV3F. Toutes les informations liées aux personnes morales sont restituées. Seuls les informations liées aux propriétaires physiques sont anonymisées, leurs noms sont remplacés par un X. 

Dans DV3F, chaque ligne de la table acheteur_vendeur représente un acheteur ou un vendeur auquel on affecte un identifiant @@acheteur_vendeur|idachvend@@.
Ils correspondent aux différents droits de propriété de type 'propriétaire' (les 'gestionnaire' n'apparaissent pas) qui composent les comptes propriétaires acheteur ou vendeur rapatriés des Fichiers fonciers. Il existe une exception pour les particuliers qui, pour ne pas être distingués, sont regroupés, dans chaque département, avec un même @@acheteur_vendeur|idachvend@@.

Ainsi, à chaque mutation, peuvent correspondre un ou plusieurs vendeurs et un ou plusieurs acheteurs qui sont référencés par leur idachvend dans les variables @@mutation|l_idv@@ et @@mutation|l_ida@@. Les noms sont également remontés dans les variables @@mutation|l_nomv@@ et @@mutation|l_noma@@.

Toutes ces informations rapatriées répondent à un niveau d'exigence minimale. Il est toutefois possible de s'assurer d'une fiabilité maximale à l'aide des variables @@mutation|fiabmaxv@@ et @@mutation|fiabmaxa@@. Lorsque le rapatriement n'a pas pu se faire, toutes ces informations sont nulles.

Pour plus d'informations sur le rapatriement des acheteurs-vendeurs : @TUTO@rapatriement_fiabilite|Rapatriement et fiabilité des données Fichiers fonciers dans DV3F@TUTO@

### Regroupement via l'identité

Il est possible que plusieurs acheteurs-vendeurs (@@acheteur_vendeur|idachvend@@) correspondent dans la réalité à une même structure acheteuse ou vendeuse (si, par exemple, le nom ou la catégorie juridique n'est pas exactement le même). Une liaison entre ces identifiants est proposée à travers la variable @@acheteur_vendeur|identite@@.

| idachvend | ffnomprop | ffsiren | identite | nbidassoc |
|---------|--------------|---------|------------|-------|
| 2005968 | STE PLOMBIER DAINVILLE | 0123456789 | grp_nat0000456 | 3 |
| 2006416 | PLOMBIER DAINVILLE | | grp_nat0000456 | 3 |
| 2006417 | PLOMBIER DAINVILLE | 0123456789 | grp_nat0000456 | 3 |
| 2001096 | COMMUNE DE GRISELLES | | | 1 |
| 2004351 | OPH BELLE VIE | 478170103 | grp_nat0000732 | 3 |
| 2004352 | OFFICE PUBLIC DE L HABITAT | 478170103 | grp_nat0000732 | 3 |
| 2004353 | OFFICE PUBLIC DE L HABITAT | 478170103 | grp_nat0000732	| 3 |
| 2001550 | COMMUNE DE ARRAS | | | 1 |
| 2000094 | ARCANTA CHANTRAINE | 323347062 | | 1 |




### Cas Pratiques

@TUTO@g3_identifier_exos|Cas pratique I1 : Identifier les acheteurs et vendeurs dans PostgreSQL/PostGIS|cas-pratique-i1-identifier-les-acheteurs-et-vendeurs-dans-postgresqlpostgis@TUTO@

```variables
@-@Variables associées@-@
Acheteur_vendeur : @@acheteur_vendeur|idachvend@@, @@acheteur_vendeur|identite@@, @@acheteur_vendeur|ffnomprop@@ et @@acheteur_vendeur|ffsiren@@
Mutation : @@mutation|l_ida@@, @@mutation|l_idv@@, @@mutation|l_noma@@, @@mutation|l_nomv@@, @@mutation|fiabmaxa@@, @@mutation|fiabmaxv@@
Disposition_parcelle : @@disposition_parcelle|l_ida@@, @@disposition_parcelle|l_idv@@, @@disposition_parcelle|l_noma@@, @@disposition_parcelle|l_nomv@@, @@disposition_parcelle|fiabilitea@@, @@disposition_parcelle|fiabilitev@@, @@disposition_parcelle|l_nomgesta@@, @@disposition_parcelle|l_nomgestv@@
Local : @@local|l_ida@@, @@local|l_idv@@, @@local|l_noma@@, @@local|l_nomv@@, @@local|fiabilitea@@, @@local|fiabilitev@@, @@local|l_nomgesta@@, @@local|l_nomgestv@@
``` 

## Repérer les catégories d'acteurs

### La classification des propriétaires proposée dans DV3F

Outre la catégorie de personne physique (X0), DV3F propose aussi de classer les propriétaires « personne morale » pour constituer des groupes homogènes. Le schéma ci-dessous présente les différentes catégories existantes. 

![*Typologie propriétaire*](ressources/typo_proprio.png "Typologie Propriétaire")

Cette classification permet de faciliter l'identification de certaines logiques d'acteurs. Pour ne pas démultiplier les indicateurs, il a été décidé d'en proposer un seul alliant type de structure (par exemple, région, organisme de logement social, etc.) et champ d’action de la structure : réseau, route, eau, etc.

Ces catégories ont été créées spécifiquement pour DV3F et sont compatibles avec les Fichiers fonciers. 

Cette classification du propriétaire est présente dans la table _acheteur_vendeur_ à travers la variable @@acheteur_vendeur|codtyppro@@. 

Dans la table _mutation_, cette classification se retrouve dans les variables @@mutation|codtypprov@@ pour les vendeurs et @@mutation|codtypproa@@ pour les acheteurs. S'il y a plusieurs vendeurs de classe différente dans la mutation, celles-ci sont toutes restituées.


### Cas Pratiques

@TUTO@g3_identifier_exos|Cas pratique I2 : Repérer les catégories d'acteurs|cas-pratique-i2-reperer-les-categories-dacteurs@TUTO@

```variables
@-@Variables associées@-@
Acheteur_vendeur : @@acheteur_vendeur|codtyppro@@
Mutation : @@mutation|codtypproa@@, @@mutation|codtypprov@@
Disposition_parcelle : @@disposition_parcelle|codtypproa@@, @@disposition_parcelle|codtypprov@@
Local : @@local|codtypproa@@, @@local|codtypprov@@
```

## Adapter l'analyse à l'aide des rôles

### Le rôle dans DV3F

Une notion de "rôle" a été créé pour venir en complément de la typologie des propriétaires. Elle doit permettre de repérer un mode d'intervention de l'acheteur ou du vendeur sur les marchés fonciers et immobiliers qui pourrait s'apparenter à une catégorie d'acteurs spécifique.

Le rôle se base uniquement sur des informations liées à la mutation en elle-même (évolution des biens, articles CGI, etc.) tandis que la typologie de propriétaires se base uniquement sur les informations liées au propriétaire. Autrement dit, une même personne morale peut avoir plusieurs rôles dans DV3F. Par exemple, une collectivité (classée comme telle dans la typologie) peut parfois avoir un rôle d’aménageur même si ce n'est pas sa mission principale.

Dans la table mutation, deux indicateurs ont ainsi été créés pour caractériser ces différents rôles : 

* @@mutation|rolev@@, pour le vendeur, 
* @@mutation|rolea@@ pour l'acheteur. 

### Cas Pratiques

@TUTO@g3_identifier_exos|Cas pratique I3 : Fiabiliser l'analyse des modes d'action des acteurs sur les marchés|cas-pratique-i3-fiabiliser-lanalyse-des-modes-daction-des-acteurs-sur-les-marches@TUTO@

```variables
@-@Variables associées@-@
Mutation : @@mutation|rolea@@, @@mutation|rolev@@
Acheteur_vendeur : @@acheteur_vendeur|nbroleop@@, @@acheteur_vendeur|nbroleoa@@, @@acheteur_vendeur|nbroleos@@, @@acheteur_vendeur|nbrolena@@, @@acheteur_vendeur|nbrolenf@@
```

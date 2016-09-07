Titre: Rapatriement et fiabilité des données Fichiers fonciers dans DV3F
Theme: Base de données
Numero: 7
Auteurs: Antoine Herman, Magali Journet - Cerema
MAJ: 05/09/2016
Contact: dv3f@cerema.fr

## Périmètre du rapatriement 

La constitution de DV3F est basée sur le croisement des données DVF et des données Fichiers fonciers. Les objectif principaux de ce croisement sont de compléter les informations présentes dans DVF sur les biens vendus et d'apporter une information, totalement absente de DVF, sur les vendeurs et les acquéreurs de ces biens.  

Les données rapatriées des Fichiers fonciers concernent donc :

* les caractéristiques des biens de type "local",
* les caractéristiques des biens de type "parcelle",
* les vendeurs (propriétaires avant la vente),
* les acheteurs (propriétaires après la vente). 

## Difficultés du rapatriement  

Ce croisement est facilité par le fait que l'origine de ces sources est la même (DGFiP) et que les identifiants de chaque bien vendu sont présents dans les 2 bases de données mais, il se heurte toutefois à des difficultés liées notamment au caractère discontinu des Fichiers fonciers (chaque millésime fournit l'information existante au 1er janvier de l'année) ou aux délais d'actualisation de la donnée.

Devant ces difficultés, et même en supposant que l'information présente dans les Fichiers fonciers est totalement fiable, il est impossible de garantir que l'information intégrée dans DVF soit exacte.

Malgré tout, la méthodologie retenue pour le croisement entre DVF et les Fichiers fonciers et décrite ci-après cherche un juste équilibre entre un taux de rapatriement des données Fichiers fonciers satisfaisant et la garantie d'une information globalement fiable.

## Correction préalable des dates de mutation dans les Fichiers fonciers

Les méthodes de rapatriement employées s'appuient sur des correspondances entre la variable @@mutation|datemut@@ présente dans DVF et la variable _jdatat_ des Fichiers fonciers qui représente la dernière date de mutation connue du bien.

Pour pouvoir mettre en œuvre le rapatriement, il a été nécessaire de compléter ou de corriger la date de mutation _jdatat_ de certains biens pour certains millésimes des Fichiers fonciers. En effet, il a été constaté que des dates de mutation pouvaient être manquantes ou non actualisées lors d’un changement de propriétaire.

La méthode détaillée ci-dessous permet de garantir une chronologie dans l’évolution des propriétaires à partir des données disponibles. 

### Complétion des valeurs nulles

Pour le cas des biens ayant une date jdatat nulle pour un millésime N :

* soit il existe un millésime ayant le même compte propriétaire (_idprocpte_) et une date jdatat antérieure au 1er janvier de l’année N et dans ce cas, c’est cette date qui est affectée pour le bien au millésime N,
* soit ce millésime n’existe pas et c’est alors la date du 1er janvier du millésime N-1 (à défaut, le 1er janvier 0001 pour le premier millésime) qui est affectée.

### Correction des dates non actualisées lors d’un changement de compte propriétaire

Pour le cas des biens ayant une date non actualisée à la suite d’un changement de compte propriétaire, les dates de l’ensemble des millésimes n’ayant pas subi cette actualisation sont corrigées en affectant la date du 1er janvier du millésime précédant cet ensemble.

## Méthodes de rapatriement

### Rapatriement des caractéristiques du bien

Le rapatriement des caractéristiques des biens est simplement conditionné à l'existence de ce bien dans un des millésimes des Fichiers fonciers.

Les données de caractérisation du bien rapatriées sont celles du millésime Fichiers fonciers de l'année @@disposition_parcelle|ffanref@@.

Pour chaque bien des tables _local_ et _disposition_parcelle_, cette variable est définie en recherchant :

* l'année du premier millésime Fichiers fonciers pour lequel la date de mutation (_jdatat_) du bien correspond à celle de DVF (_datemut_),
* à défaut, l'année du millésime postérieur, le plus proche de la date de mutation DVF, dans lequel apparaît le bien,
* à défaut, l'année du dernier millésime dans lequel apparaît le bien.

### Rapatriement des informations liées à l'acheteur et au vendeur

Le rapatriement des données liées à l'acheteur et au vendeur d'un bien ayant muté à une date de mutation _datemut_ dans DVF peut s'effectuer s'il est possible de faire coïncider la chronologie des ventes de DVF avec celles des millésimes Fichiers fonciers. 

Les conditions de rapatriement sont les suivantes :

* s’il existe une date de mutation dans les Fichiers fonciers correspondant à _datemut_, on rapatrie les données propriétaires associées en tant que données de l’acheteur,
* s’il existe une date de mutation du bien dans les Fichiers fonciers précédant la vente dans DVF et qu’aucune mutation dans DVF n’est intercalée, alors on rapatrie les données propriétaires associées en tant que données du vendeur. Dans le cas d'une parcelle apparue, l'existence d'une précédente date de mutation de la parcelle mère est également regardée.

A noter que si plusieurs millésimes des Fichiers fonciers renseignent la même date de mutation, les données du millésime le plus proche de la date de mutation seront rapatriées.


Les schémas ci-dessous illustrent 3 situations permettant le rapatriement total ou partielle des informations sur l'acheteur et le vendeur.

![*Schéma principe rapatriement acheteur-vendeur *](ressources/rapatriement-achvend1.png "Schéma de principe de rapatriement de l'acheteur et du vendeur")
![*Schéma principe rapatriement acheteur-vendeur *](ressources/rapatriement-achvend2.png "Schéma de principe de rapatriement de l'acheteur et du vendeur")

### Rapatriement des informations liées au vendeur dans le cas des constructions neuves

La méthode précédente ne peut pas être appliquée aux locaux apparus. En effet, un local qui vient d’être construit, divisé, réuni, agrandi, etc, n’aura jamais d’antériorité dans les Fichiers fonciers, empêchant par là même de retrouver le vendeur. 

Pour les maisons, cela n’est pas problématique, car, lors d’une vente, une maison est composée d’un local et d’une parcelle. Il est donc possible de retrouver, via la parcelle, le vendeur.
 
Pour les appartements, la parcelle n’étant pas vendue, le vendeur est difficilement identifiable. Une méthode a toutefois été mise en œuvre pour les constructions neuves (y compris VEFA). En considérant que la construction d’un immeuble nécessite la maîtrise du foncier, le propriétaire de la parcelle précédant la création de la copropriété/indivision sera rapatrié comme le vendeur de la construction neuve et donc de l’appartement.

## Evaluation de la fiabilité du rapatriement

### Fiabilité du rapatriement des caractéristiques des biens

Les mises à jour des caractéristiques du local, d’une part, et de la date de mutation et du nom de propriétaire, d’autre part, semblent disjointes dans les Fichiers fonciers. De ce fait, il est difficile de qualifier la fiabilité du rapatriement.

### Fiabilité du rapatriement des informations liées au vendeur et à l'acheteur et au vendeur

Une échelle de fiabilité du rapatriement des données acheteur et vendeur a été mise en place dans DV3F :

| Note | Degré de fiabilité |
|------|--------------------|
| 0 | Aucun (car non rapatrié) |
| 1 | Moyen |
| 2 | à confirmer - à vérifier |
| 3 | Bon |
| 4 | Excellent |

Lors du rapatriement des données acheteur, la fiabilité associée est :

* moyenne (1) si plusieurs mutations du bien correspondant existent le même jour dans DVF,
* excellente (4) si la mutation du bien correspondant est la seule existante à cette date dans DVF.

Lors du rapatriement des données vendeur, la fiabilité associée est :

* moyenne (1) si plusieurs mutations du bien correspondant existent le même jour dans DVF,
* à confirmer (2) si la mutation du bien correspondant est la seule existante à cette date dans DVF et si cette date de mutation est supérieure à la date du dernier millésime Fichiers fonciers disponible,
* à vérifier (2) si la méthode employée correspond à celle des constructions neuves (cf ci-dessus),
* bonne (3) sinon.

La fiabilité du rapatriement des données vendeur ne peut être classée comme excellente car il est toujours possible qu'une mutation non onéreuse existe entre la date de mutation des Fichiers fonciers et la date de mutation de DVF.



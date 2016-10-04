Titre: Détermination de l'évolution des biens dans DV3F
Theme: Base de données
Numero: 6
Auteurs: Antoine Herman, Magali Journet - Cerema
MAJ: 05/09/2016
Contact: dv3f@cerema.fr

## Notion d'évolution d'un local ou d'une parcelle

Déterminer l’évolution d'un bien (parcelle ou local) avant ou après une mutation dans DV3F permet de comprendre le contexte de la vente, et indirectement, de mieux caractériser les acheteurs et les vendeurs.

Pour l’analyse des marchés, l’évolution du bien muté peut être associée à 3 types d’évolution :

* la **stabilité** : le bien est considéré comme stable si aucune modification structurelle n’a été effectuée sur celui-ci par le vendeur ou l’acheteur ;
* l’**apparition sous le vendeur** : le bien est considéré comme apparu sous le vendeur en cas de modification **avant la vente**. Cette modification revêt plusieurs types : réunion/division de parcelles, constructions de locaux, modifications importantes du local, etc. ; ;
* la **disparition sous l’acheteur** :  le bien est considéré comme disparu sous l’acheteur en cas de modification **après la vente**. Cette modification revêt plusieurs types : réunion/division de parcelles, démolitions de locaux, modifications importantes du local, etc.

Cette détermination concerne uniquement les biens qui ont muté. Par conséquent, les disparitions avant la vente ou les apparitions de locaux après la vente ne sont, ici, pas observées.

## Méthode de détermination de l'évolution des biens dans DV3F

Dans DV3F, on s'intéresse essentiellement à déterminer si le bien est apparu sous le vendeur et/ou disparu sous l’acheteur.

### Apparition sous le vendeur

Pour une date de mutation donnée, on considère que le bien est apparu sous le vendeur, lorsqu’il remplit l’ensemble des conditions suivantes :

* c’est la première fois qu’il mute dans DVF,
* il n’apparaît qu’une seule fois au plus à une date de mutation antérieure dans les Fichiers fonciers,
* il n’apparaît pas dans le millésime 2009 (c'est-à-dire le premier millésime disponible des Fichiers fonciers),
* pour une parcelle, l’apparition est de nature « physique » (réunion ou division)

### Disparition sous l'acheteur

Pour une date de mutation donnée, on considère que le bien est disparu sous l'acheteur, lorsqu’il remplit l’ensemble des conditions suivantes :

* il n’apparaît plus à une date de mutation ultérieure ni dans les Fichiers fonciers, ni dans DVF ;
* le bien n’apparaît plus dans le dernier millésime disponible des Fichiers fonciers.
* pour une parcelle, la disparition est de nature « physique » (réunion ou division)

### Notation des indicateurs d'évolution dans DV3F

Plusieurs variables liées à l'évolution des biens sont définis dans DV3F.

Les variables @@local|stabilitel@@ de la table local et @@disposition_parcelle|stabilitep@@ de la table disposition_parcelle combinent 2 initiales selon les modalités suivantes :

| Modalité | Description    |
|----------|----------------|
| AD | Bien apparu sous le vendeur et disparu sous l’acheteur |
| AN | Bien apparu sous le vendeur / Bien stable ou stabilité du bien non définie sous l’acheteur |
| NN | Bien stable sous le vendeur et l’acheteur ou alors la stabilité du bien n’a pu être définie |
| ND | Bien stable ou stabilité du bien non définie sous le vendeur / Bien disparu sous l’acheteur |

Au niveau de la table mutation, les variables @@mutation|nbpardisp@@, @@mutation|nbparapp@@, @@mutation|nblocdisp@@, @@mutation|nblocapp@@ comptabilisent respectivement les parcelles et locaux qui sont disparus sous l'acheteur et apparus sous le vendeur. 

### Commentaires sur la méthode de détermination 

Ce choix méthodologique se base sur une analyse des différents millésimes des Fichiers fonciers qui a permis d’établir que :

* le millésime d’apparition est un critère plus pertinent pour déterminer l’apparition que la première date de mutation (« jdatat ») apparaissant dans les Fichiers fonciers. D’abord, parce que le champ jdatat n’est pas systématiquement rempli alors que l’identifiant du bien l’est. Ensuite, parce qu’à la suite d’une transformation importante d’un bien, il est possible que la date de mutation de l’ancienne version du bien soit conservée.
* le taux d’erreur relatif au temps de latence des mises à jour des Fichiers fonciers est relativement faible pour les locaux d’habitation (de l’ordre de 5%) ainsi que pour les parcelles (presque nul). 

## Références

* Utilisation de plusieurs millésimes des Fichiers fonciers - [Etude multi-millésimes](http://www.geoinformations.developpement-durable.gouv.fr/etude-multi-millesimes-a3388.html) - juin 2016 
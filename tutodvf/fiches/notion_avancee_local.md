Titre: Notions avancées sur les locaux
Theme: Plus loin avec DV3F
Numero: 2
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 30/05/2018
Contact: dv3f@cerema.fr

[TOC]


## Logement et Habitation


Un logement (maison ou appartement) n'est pas synonyme d'habitation. A titre d'exemple, une boulangerie peut être considérée comme un logement. Inversement, une habitation peut être considérée comme un local d'activité secondaire (loft). Il a été constaté que les logements sont essentiellement à vocation d'habitation (99,4 % en France), même si quelques-uns peuvent être des locaux mixtes ou professionnels. 

![*Logement et habitation*](ressources/logement_habitat.png "Logement et habitation")

A l'exception de l'étude spécifique d'une forme particulière d'occupation (ex: loft), ces deux notions peuvent être confondues pour une analyse globale.

Pour les habitations, l'occupation du local décrit s'il est loué, occupé par le propriétaire, vacant, etc. (au 1er janvier de chaque année). 

```variables
@-@Variables associées@-@
Mutation : @@mutation|ffnbloch@@, @@mutation|codtypbien@@, @@mutation|libtypbien@@
Local : @@local|fflochab@@, @@local|ffoccv@@, @@local|ffocca@@
``` 

## Date de construction d'un local et ancienneté

La date de construction correspond à la date de livraison du local.

Pour les services fiscaux, la date de construction d'un local peut être réactualisée lorsque celui-ci subit une rénovation lourde.

L'ancienneté d'un local se définit en fonction de la différence entre l'année de mutation et l'année de construction du local : 

* 1 an ou moins : le local est neuf,
* de 2 à 4 ans : le local est récent, 
* 5 ans ou plus : le local est ancien.

Ces critères reposent, à la fois, sur le changement de fiscalité pour les ventes de biens de moins de 5 ans et une logique d'harmonisation avec les critères utilisées dans Filocom.

La date de construction provient des Fichiers fonciers. Cette donnée est réputée très fiable pour les logements depuis 1970 et depuis 2003 pour l'activité.

A noter qu'environ 10 % des locaux ont une année de construction non renseignée (valeur 0), ce qui empêche la détermination de l'ancienneté. Ce chiffre est à relativiser par le fait qu'il concerne principalement les locaux d'activité.

```variables
@-@Variables associées@-@
Mutation : @@mutation|ffancstmin@@, @@mutation|ffancstmax@@, @@mutation|nblocanc@@, @@mutation|nblocrecen@@, @@mutation|nblocneuf@@
Local : @@local|anciennete@@, @@local|ffancst@@
``` 

## Nombre de pièces d'un local

Globalement, dans DVF, le nombre de pièces principales se rattache aux "types" (T). Par exemple, un appartement possédant 3 pièces principales correspondra à un T3.

Elle correspond, plus précisement, à la somme des pièces considérées comme des chambres ou des salles-à-manger. Un bureau ou une bibliothèque de taille suffisante sont considérés fiscalement comme une chambre. Une grande salle à manger peut être comptabilisée comme deux pièces.

Le nombre de pièces principales dans DVF+/DV3F correspond à la variable @@local|nbpprinc@@. Les informations sur le nombre de pièces principales sont accessibles au niveau de la table mutation pour permettre de décompter plus facilement les appartements et maisons en fonction de leur nombre de pièces (T1 à T5+).

Dans DV3F, il est possible d'avoir une décomposition plus fine des pièces :

* @@local|ffnbpsam@@ pour les salles à manger,
* @@local|ffnbpcha@@ pour les chambres,
* @@local|ffnbpcu8@@ pour les cuisines de moins de 9 m2,
* @@local|ffnbpcu9@@ pour les cuisines d'au moins 9 m2,
* @@local|ffnbpsea@@ pour les salles d'eau,
* @@local|ffnbpann@@ pour les annexes.

![*Pieces principales*](ressources/pieces_principales.png "Pieces principales")

Attention, le terme "pièces principales d'habitation" dans Fichiers fonciers revêt une autre définition. Pour conserver le vocabulaire de DVF, la somme ffnbpsam + ffnbpcha issue des Fichiers fonciers a été également définie comme le nombre de pièces principales dans DV3F, représentée par la variable @@local|ffnbpprinc@@. Elle est comparable à @@local|nbpprinc@@.

On constate que certains locaux n'ont aucune pièce, ou bien 99 pièces. La détermination du nombre de pièce est donc subjectif et à prendre avec précaution. Par exemple, un studio peut correspondre à un aucune pièce ou à une pièce.


```variables
@-@Variables associées@-@
Mutation : @@mutation|nbapt1pp@@, @@mutation|nbapt2pp@@, @@mutation|nbapt3pp@@, @@mutation|nbapt4pp@@, @@mutation|nbapt5pp@@, @@mutation|nbmai1pp@@, @@mutation|nbmai2pp@@, @@mutation|nbmai3pp@@, @@mutation|nbmai4pp@@, @@mutation|nbmai5pp@@, @@mutation|ffnbloc1pp@@, @@mutation|ffnbloc2pp@@, @@mutation|ffnbloc3pp@@, @@mutation|ffnbloc4pp@@, @@mutation|ffnbloc5pp@@
Local : @@local|anciennete@@, @@local|ffancst@@
``` 

## Dépendances d'un logement

La dépendance, au sens fiscal, renvoie à 2 définitions différentes :

* soit un local en tant que tel : dans ce cas, la forme physique du local associé sera de type 'dépendance' (cf @TUTO@g1_denombrer|Dénombrer les mutations, les locaux et les parcelles@TUTO@),
* soit une partie d'un local de type 'maison' ou 'appartement'. Elle est soit intégrée au bâtiment principal, soit isolée (2 bâtis non reliés).

Ces dépendances ne sont pas à confondre avec les dépendances non bâties (cours, passages, jardins, parcs, aires de stationnement collectives à ciel ouvert, terrains, etc.) qui peuvent aussi impacter le prix d'un bien mais qui ne sont référencées dans DV3F.

Un propriétaire n'a pas l'obligation de déclarer certains travaux (par exemple, un abri de jardin d'une superficie inférieure à 5m²). Ces dépendances bâties ne seront donc pas prises en compte.

Par ailleurs, les données fiscales sont principalement basées sur les déclarations des particuliers. De ce fait, des incohérences existent avec la réalité. Par exemple, le propriétaire ne déclare pas qu'il a aménagé son grenier ou son garage en surface d’habitation (phénomène de surestimation des dépendances).

Les dépendances sont classées dans les Fichiers fonciers en une quinzaine de catégories dont les frontières entre certaines peuvent être floues. Dans DV3F, elles ont donc été regroupées en 5 catégories : 

* les garages/parkings/box : @@local|ffnbpgarag@@ pour la table local et @@mutation|ffnbpgarag@@ pour la table mutation, 
* les piscines: @@local|ffnbppisci@@ pour la table local et @@mutation|ffnbppisci@@ pour la table mutation,
* les terrasses (ou toiture terrasse): @@local|ffnbpterra@@ pour la table local et @@mutation|ffnbpterra@@ pour la table mutation,
* les serres et élements de pur agrément (terrain de tennis, etc.): @@local|ffnbpagrem@@ pour la table local.
* les autres : bûcher,  buanderie, chambre de domestique, cellier, cave, grenier, grenier ou cave, jardin d'hiver, pièce indépendante, remise, dépendance de local commun. Cette catégorie correspond à la variable @@local|ffnbpaut@@ pour la table local et @@mutation|ffnbpaut@@ pour la table mutation.

![*Pieces annexes*](ressources/pieces_annexes.png "Pieces annexes")

## Locaux construits après la vente

Dans DV3F, il est possible de déterminer, sur les parcelles, s’il y a eu construction après la vente. 

Bien sûr cela nécessite un recul temporel pour faire cette observation. Comme cette technique s’appuie sur les Fichiers fonciers, il est nécessaire d’avoir au moins un millésime des Fichiers fonciers après la vente. L’indicateur sera d’autant plus performant lorsqu’il y aura de millésimes de Fichiers fonciers après la vente. 

Dans DV3F, deux notions ont été différenciées : 

* la construction sous l’acheteur dans les 4 ans
* la construction, quel que soit l’acheteur et le délais de construction. 

Dans le premier cas, ceci permet de s’assurer que lors de la vente, l’acheteur avait très vraisemblablement l’intention de construire un ou des locaux, ce qui est clairement un facteur changeant du prix. Dans le deuxième cas, ceci n’est pas assuré car l’acheteur peut être seulement un aménageur, ou bien un particulier qui 10 ans plus tard aurait décidé de construire une maison supplémentaire sur son terrain. Dans tous les cas, ils représentent des terrains à bâtir au sens large.

Il ne faut par confondre la notion de locaux construits après la vente de la notion de locaux apparus (@@mutation|nblocapp@@). Dans ce dernier cas, ces locaux appartiennent à la vente et sont apparus sous le vendeur (avant la vente).

```variables
@-@Variables associées@-@
Mutation : @@mutation|nbcstloc4@@, @@mutation|nbcstloc@@, @@mutation|l_idcstloc4@@, @@mutation|l_idcstloc@@, @@mutation|nbcstmai4@@, @@mutation|nbcstapt4@@, @@mutation|nbcstact4@@, @@mutation|nbcstsoc4@@, @@mutation|nbcstmai@@, @@mutation|nbcstapt@@, @@mutation|nbcstact@@, @@mutation|nbcstsoc@@
Disposition_parcelle : @@disposition_parcelle|nbcstloc4@@, @@disposition_parcelle|nbcstloc@@, @@disposition_parcelle|l_idcstloc4@@, @@disposition_parcelle|l_idcstloc@@, @@disposition_parcelle|nbcstmai4@@, @@disposition_parcelle|nbcstapt4@@, @@disposition_parcelle|nbcstact4@@, @@disposition_parcelle|nbcstsoc4@@,@@disposition_parcelle|nbcstmai@@, @@disposition_parcelle|nbcstapt@@, @@disposition_parcelle|nbcstact@@, @@disposition_parcelle|nbcstsoc@@
``` 

## Les logements sociaux

Un logement social est un logement conventionné à prix modéré, pour des locataires sous plafond de ressources. 

Dans DV3F, pour les variables @@local|fflogsoc@@, @@mutation|ffnblogsoc@@, @@mutation|nbcstsoc4@@ et @@mutation|nbcstsoc@@, les logements sociaux sont repérés à partir des dégrèvements de taxe foncière présent dans les Fichiers fonciers. Ce recensement peut donc différer de RPLS.

Un logement social est souvent détenu par un organisme de logement social, mais il peut aussi être détenus par un propriétaire privé (exemple : conventionnement Anah). 

La modalité 'S' de la variable @@mutation|filtre@@ prend en compte d'avantages de critères pour repérer de potentielles mutations liées aux logements sociaux : la présence de logements sociaux pendant ou après la vente et l'achat par un organisme de logement social. 

## La notion de bâtiment

La notion de bâtiment est complexe dans DV3F et provient de la notion des Fichiers fonciers.  Un bâtiment est une agrégation de locaux portant le même identifiant bâtiment unique @@local|ffidbat@@. Cet identifiant intègre les différentes entrées d’un immeuble. Par conséquent, si un immeuble a deux entrées il y aura deux bâtiments dans les Fichiers fonciers.

La variable @@mutation|batiment@@ propose une méthodologie permettant de repérer, lors de la vente de plusieurs locaux, s'ils appartiennent au même bâtiment, en totalité ou partiellement. 

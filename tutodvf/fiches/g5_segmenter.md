Titre: Regrouper les mutations homogènes pour construire un segment de marché
Theme: Bien démarrer avec DV3F
Numero: 5 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 11/05/2018
Contact: dv3f@cerema.fr

[TOC]

## La segmentation de marché

Un segment de marché correspond à des transactions homogènes de biens acquis avec la même finalité (donc les mêmes possibilités de maintien en l'état ou de transformation), dont la valeur foncière (ou le prix) est globalement homogène ou se décompose à partir des mêmes caractéristiques, car elle procède d'une rencontre de l'offre et de la demande. Cela sous-entend que la transaction a lieu hors situation de monopole de l'acquéreur ou du vendeur et avec un nombre suffisant de biens sur lesquels pourraient se reporter la demande pour faire jouer la concurrence. En conséquence, on ne parlera de marché que lorsqu'on aura un nombre de biens par segments supérieur à 11.

L’intérêt d’un segment de marché est de définir un ensemble homogène où les biens sont comparables en termes de prix notamment. De ce fait, l'évaluation des biens ou l'observation des prix implique le recours à une segmentation, ce qui n'est pas nécessairement le cas pour l'observation de volume de ventes ou de biens. 

## La segmentation de marché dans DV3F

La segmentation des marchés est complexe et peut, tout comme la typologie de biens, être assez différente selon les objectifs de l’utilisateur. Suite à des concertations notamment avec le GnDVF et les services de l'Etat, DV3F propose une solution adaptable et ensemblière basée sur plusieurs faisceaux d’indicateurs déterminés qui ensemble, selon les combinaisons, permettent de constituer des marchés homogènes. 

Ces faisceaux d'indicateurs, outre la date de mutation, sont au nombre de cinq : 

* la typologie des biens comme vu précédemment,
* l’usage,
* les acteurs,
* les particularités de la mutation – conditions de ventes,
* le géo-marché.

![*Segmentation1*](ressources/segmentation1.png "Segmentation1")


Ces cinq faisceaux d'indicateurs peuvent aussi être transposés avec une notion temporelle. Dans ce cas, les acteurs deviennent le vendeur et l’acheteur. L’usage et la typologie sont référencés par rapport à la vente, avec un avant et un après. 

![*Segmentation2*](ressources/segmentation2.png "Segmentation2")

Par exemple, le prix associé à la vente d'une maison pourra dépendre :

* du type de maison et son usage avant la vente : ancienneté, surface de terrain, etc.,
* de la destination du bien (typologie et usage prévu après la vente) : démolition de la maison pour construction d'un immeuble, maison d'habitation transformée en maison médicale, etc.,
* du type de vendeur et d'acheteur : un promoteur, un particulier, etc.,
* des particularités de la mutation ou conditions de vente : échange, vente à l'euro symbolique, logement social, etc.,
* de la situation du bien dans son environnement : bord de mer, en centre-ville, dans la commune de Rochefourchat, etc.,  
* de la date de vente : avant la crise de 2008 ou après, etc.

Il est donc indispensable de retenir et d'allier ces différents critères selon leurs impacts supposés dans la construction du prix pour obtenir un segment de marché le plus pertinent possible.

Les principales variables de DV3F à combiner pour construire un segment de marché sont les suivantes :

* @@mutation|codtypbien@@, @@mutation|libtypbien@@ pour la typologie et l'usage (partiel) avant la vente : cf @TUTO@g4_caracteriser|Caractériser une mutation à l'aide de la typologie de bien@TUTO@,
* @@mutation|devenir@@ pour la destination du bien : cf ci-après, @TUTO@g5_segmenter|La notion de destination du bien et la variable devenir|la-notion-de-destination-du-bien-et-la-variable-devenir@TUTO@,
* @@mutation|codtypprov@@ et @@mutation|codtypproa@@ pour les vendeurs et les acheteurs : cf @TUTO@g3_identifier|Identifier les acheteurs et vendeurs@TUTO@, 
* @@mutation|filtre@@ pour les conditions de ventes : cf ci-après, @TUTO@g5_segmenter|Les particularités ou conditions de vente et la variable filtre|les-particularites-ou-conditions-de-vente-et-la-variable-filtre@TUTO@,
* les variables de localisation pour la situation du bien dans l'espace : cf @TUTO@g2_situer|Situer dans le temps et l'espace|situer-dans-lespace@TUTO@,
* @@mutation|datemut@@ pour la situation du bien dans le temps : cf @TUTO@g2_situer|Situer dans le temps et l'espace|situer-dans-le-temps@TUTO@.

![*Segmentation3*](ressources/segmentation3.png "Segmentation3")


### La notion de destination du bien et la variable devenir

Il ne sera jamais possible de connaître l'intention d'un acheteur au moment de la vente. Dans DV3F, avec un recul temporel suffisant, il reste toutefois possible de repérer certaines évolutions du bien. 

Ces évolutions sont retranscrites dans la variable @@mutation|devenir@@, avec notamment :

* la construction après la vente avec démolition avec les types de construction,
* la construction après la vente avec les types de construction,
* l’aménagement après la vente,
* la potentielle modification du bien,
* l'absence d'évolution constatée.

Le schema ci-après détaille les modalités proposées par cette variable avec leurs principes de construction :

![*Devenir*](ressources/devenir.png "Devenir")

Les évolutions retenues peuvent être une composante du prix plus déterminante que la typologie du bien vendu. Dans ces situations, il est donc essentiel d'intégrer le devenir dans la construction de certains segments de marché. A titre d'exemple, l'estimation des prix des terrains acquis par les promoteurs utilisant une méthode de type "compte-à-rebours" dépend très fortement du type de constructions envisagées. 

### Les particularités ou conditions de vente et la variable filtre

Dans la construction d'un prix, il est également important d'exclure certains mutations ayant des conditions de ventes particulières. Si l’on vend un bien à son enfant ou à un ami, le prix risque de ne pas être le même que si c’est une vente aux enchères, une expropriation, ou une vente simple. 

De même, si la typologie classifie les biens, elle ne retranscrit pas certaines spécificités qui peuvent changer considérablement le prix d’une vente. Par exemple, la vente d’un terrain de 5 ha, avec une maison, sera considérée dans la typologie comme une maison. Ceci est peut-être réducteur. 

DV3F propose, pour cela, un indicateur unique, @@mutation|filtre@@, qui alerte sur des biens rares ou des conditions de ventes spécifiques :

| Code | Libellé du filtre |
|------|-------------------|
| A | Mutation de type Adjudication |
| B | Mutation d'un appartement avec terrain |
| D | Mutation dont au moins un des biens a été vendu une deuxième fois le même jour |
| E | Mutation de type Echange |
| H | Mutation le prix est null, 0 ou 1 euro |
| L | Mutation comportant un bien exceptionnel parmi : logement de plus de 8 pièces strictement, maison de plus de 300m2 de surface bâtie, appartement de plus de 200m2 de surface batie |
| M | Mutation de plusieurs biens distancés de 1km ou appartenant à plusieurs communes |
| S | Transfert de propriétés entre deux opérateurs de logement social |
| X | Mutation de type Expropriation |
| 1 | Mutation d'un terrain bâti de plus de 1 ha/local vendu |
| 5 | Mutation d'un terrain bâti de plus de 5 ha/local vendu |
| 0 | Mutation ne comportant aucun des critères précédents |

Les critères listés ci-dessous peuvent être cumulatifs. Par exemple, le transfert de biens sociaux entre deux filiales HLM peut donner un filtre « HMST » (systématiquement dans l’ordre alphabétique puis numérique).

Un choix judicieux parmi ces critères permet d'évincer les biens atypiques ou les conditions ventes particulières, apportant une analyse plus fiable des prix.

## Utilisation de la segmentation

### Combinaison des indicateurs pour constituer un segment

Pour connaître les marchés fonciers et immobiliers, il est conseillé d’utiliser les segments de marchés, mélangeant les indicateurs décrits ci-avant. 

Même s’il existe potentiellement un grand nombre de possibilités, certains segments de marchés sont plus courants que d’autres.

Par exemple, le segment de marché le plus classique du logement peut être défini par la combinaison suivante:

* une typologie "maison" ou "appartement" (ou plus détaillé selon la convenance),
* un filtre  de valeur "0" pour exclure toutes les mutations spécifiques, 
* un devenir de valeur "S" pour ne conserver que les biens stables ou inchangés (logique d'acheteurs occupants),
* des acheteurs et vendeurs de particulier (X0) à particulier (X0), ou bien la vente de promoteur (F6) à particulier (X0), etc.,
* une échelle d'observation ou un territoire délimité (agrégation à la commune conseillée pour avoir une épaisseur statistique suffisante).

Bien entendu, il est possible d'utiliser d'autres variables de DV3F que celles proposées ci-avant pour construire son propre segment de marché.

Par ailleurs, si les indicateurs DV3F apportent déjà beaucoup d’éléments, il est aussi rappelé qu’utiliser des données exogènes peut s’avérer utile. En particulier, pour l’occupation du sol, ou l’usage du bien, mal restitués dans DV3F.


### Utilisation de segments prêts à l'emploi dans DV3F

Pour certains segments de marché très recherché mais qui sont complexes à élaborer, DV3F proposera des indicateurs de segmentation prêt-à-l'emploi dont la méthodologie a été concertée en amont.

#### Segment du terrain-à-batir

A ce jour, un premier indicateur de segment de marché est proposé et concerne le terrain-à-bâtir. En effet, ce segment répond à de nombreux enjeux que ce soit en termes de consommations d’espace, de dynamisme urbain, de renouvellement urbain, de densité, etc. 

Dans DV3F, une définition large du terrain-à-bâtir (TAB) est retenue. Un TAB est un terrain acquis dans la perspective de pouvoir y construire immédiatement, avec/ou sans transformation, par l'acquéreur ou un tiers. Cela concerne entre autres les particuliers qui veulent construire une maison, et les acteurs de l'aménagement et de la construction : lotisseur, constructeur de maison individuelle (lorsqu’il est acquéreur), aménageur, promoteur, etc. 

Un TAB est souvent un terrain non bâti, mais il peut être bâti au préalable. Par exemple, une maison acquise pour être démolie et permettre la construction d’un immeuble. Dès lors, un TAB peut être plus ou moins avancé dans la chaîne de transformation du foncier et sa valeur répondre à des raisonnements économiques différents (capacité d'emprunt foncier + construction de maison, compte à rebours promoteur, compte à rebours aménageur, etc).

L'indicateur permettant d'utiliser ce segment est @@mutation|segmtab@@.

![*TAB*](ressources/tab.png "TAB")

Une fiche spécifique sera prochainement élaborée sur ce sujet.


### Cas pratiques

@TUTO@g5_segmenter_exos|Cas pratique O2 : Observer des segments dans PostgreSQL/PostGIS|cas-pratique-o2-observer-des-segments-dans-postgresqlpostgis@TUTO@

```variables
@-@Variables associées@-@
Mutation : @@mutation|codtypbien@@, @@mutation|libtypbien@@, @@mutation|filtre@@, @@mutation|devenir@@, @@mutation|codtypprov@@, @@mutation|codtypproa@@, @@mutation|segmtab@@
``` 

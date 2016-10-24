Titre: Faites le tour des locaux...
Theme: Tutoriel
Numero: 7
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 24/10/2016
Contact: dv3f@cerema.fr

## Définition et caractéristiques du local dans DVF

### Définition

Le local est un ensemble de :

>> « différentes constructions qui, en raison de leur agencement, forment un ensemble immobilier homogène d’un même compte-propriétaire ». 
>> 
>> « Ne sauraient être considérés comme constituant un local distinct, ni la pièce meublée d'un logement loué en meublé à un étudiant, ni les pièces occupées temporairement par un jeune ménage dans l'appartement des parents de l'un des conjoints, ni le garage d'une maison individuelle faisant l'objet à titre accidentel d'une location séparée, etc » 

Un local peut être composé de plusieurs éléments bâtis.

Il est référencé par un code numérique qui constitue un identifiant départemental unique pour le local.

Le local est caractérisé par sa forme physique, son année de construction, sa surface et son nombre de pièces et dépendances. 

### Typologie liée à la forme physique du local

Un local est différencié, par la DGFiP, en 4 catégories selon sa forme physique : 

* la maison,
* l'appartement,
* la dépendance (forcément liée à l'habitation),
* l'activité (et ses dépendances).

![*Formes physiques d'un local*](ressources/forme_physique_local.png "Formes physiques d'un local")

En ce qui concerne l'activité, les activités primaires ne sont pas observées. Via les Fichiers fonciers, il est possible de différencier les activités secondaires et tertiaires. 

La notion de logement regroupe les locaux de type maison ou appartement.

### Logement et Habitation


Un logement (maison ou appartement) n'est pas synonyme d'habitation. A titre d'exemple, une boulangerie peut être considérée comme un logement. Inversement, une habitation peut être considérée comme un local d'activité secondaire (loft). Il a été constaté que les logements sont essentiellement à vocation d'habitation (99,4 % en France), même si quelques-uns peuvent être des locaux mixtes ou professionnels. 

![*Logement et habitation*](ressources/logement_habitat.png "Logement et habitation")

A l'exception de l'étude spécifique d'une forme particulière d'occupation (ex: loft), ces deux notions peuvent être confondues pour une analyse globale.

Pour les habitations, l'occupation du local décrit s'il est loué, occupé par le propriétaire, vacant, etc. (au 1er janvier de chaque année). 

### Date de construction d'un local et ancienneté

La date de construction correspond à la date de livraison du local.

Pour les services fiscaux, la date de construction d'un local peut être réactualisée lorsque celui-ci subit une rénovation lourde.

L'ancienneté d'un local se définit en fonction de la différence entre l'année de mutation et l'année de construction du local : 
- 1 an ou moins : le local est neuf,
- de 2 à 4 ans : le local est récent, 
- 5 ans ou plus : le local est ancien.

### Nombre de pièces d'un local

Globalement, dans DVF, le nombre de pièces principales se rattache aux "types" (T). Par exemple, un appartement possédant 3 pièces principales correspondra à un T3.

Elle correspond, plus précisement, à la somme des pièces considérées comme des chambres ou des salles-à-manger. Un bureau ou une bibliothèque de taille suffisante sont considérés fiscalement comme une chambre. Une grande salle à manger peut être comptabilisée comme deux pièces.

### Dépendances d'un logement

La dépendance, au sens fiscal, renvoie à 2 définitions différentes :

* soit un local en tant que tel : dans ce cas, la forme physique du local associé sera de type 'dépendance' (cf plus haut),
* soit une partie d'un local de type 'maison' ou 'appartement'. Elle est soit intégrée au bâtiment principal, soit isolée (2 bâtis non reliés).

La première définition est explicitée dans le paragraphe 'Typologie liée à la forme physique du local', plus haut. Cette partie concerne la seconde définition. 

Les dépendances d'un logement sont détaillées dans les Fichiers fonciers mais n'existent pas dans la donnée source DVF. 

Ces dépendances ne sont pas à confondre avec les dépendances non bâties (cours, passages, jardins, parcs, aires de stationnement collectives à ciel ouvert, terrains, etc.) qui peuvent aussi impacter le prix d'un bien mais qui ne sont  référencées ni dans les Fichiers fonciers, ni dans DVF.

Un propriétaire n'a pas l'obligation de déclarer certains travaux (par exemple, un abri de jardin d'une superficie inférieure à 5m²). Ces dépendances bâties ne seront donc pas prises en compte.

Par ailleurs, les données fiscales sont principalement basées sur les déclarations des particuliers. De ce fait, des incohérences existent avec la réalité. Par exemple, le propriétaire ne déclare pas qu'il a aménagé son grenier ou son garage en surface d’habitation (phénomène de surestimation des dépendances).

### Surfaces d'un local

#### Surface réelle bâtie

La surface bâtie représente la surface mesurée au sol du plancher entre murs ou séparations. Le résultat est arrondi au mètre carré inférieur.

Pour le calcul des surfaces, les instructions précises de la DGFiP sont décrites ci-après : 
>> « Dans le cas où, par suite de l'absence des documents susvisés, la surface des éléments doit être mesurée, il convient de comprendre dans cette dernière :

>> * la superficie des espaces tels que bow-windows (fenêtres en saillie sur une façade), alcôves, volumes de rangement, ouverts sur lesdits éléments ;
>> * celle occupée par les diverses installations : appareils sanitaires, éviers, placards en saillie des murs et cloisons, appareils de chauffage, cheminées, etc. ;
>> * celle des éléments de décors : colonnes, pilastres, etc.

>> En revanche, ne doivent pas être retenues dans cette surface les superficies occupées par :

>> * les embrasures des portes et des fenêtres ;
>> * les espaces occupés par des conduits de fumée et de ventilation ;
>> * les placards de rangement en renfoncement de faible superficie ;
>> * les emmarchements et trémies d'escaliers (surfaces correspondant aux marches, paliers intermédiaires et aux jours entre volées où peuvent être aménagés ascenseurs ou monte-charge, mais non les paliers d'étage qui sont compris dans >> * la surface réelle lorsqu'il s'agit d'une maison individuelle).»

Elle peut se décomposer en une surface dite "habitée", une surface professionnelle (ou liée à une activité) et une surface de dépendances.

Dans DVF, la notion de surface réelle bâtie, fournie pour le local, est, en réalité, la surface de l'ensemble du bâti ayant muté, sans le décompte des surfaces de dépendances et sans regarder l'occupation du local (habitation ou activité). Autrement dit, il s'agit de la somme de la surface habitée et de la surface professionnelle. 

Dans les Fichiers fonciers et donc dans DV3F, le détail des différentes composantes de surface selon l'occupation est disponible.

#### Surface Carrez

La surface privative ou surface Carrez doit être mentionnée dans le cadre d'une vente.  Elle se définit comme la superficie des planchers des locaux clos et couverts après déduction des surfaces occupées par les murs, cloisons, marches et cages d'escaliers, gaines, embrasures de portes et de fenêtres.

Elle ne comptabilise ni les surfaces dont la hauteur sous plafond est inférieure à 1,80m ni les surfaces de pièces de moins de 8 m².

Cette surface est disponible pour les 5 premiers lots d'une mutation dans DVF mais n'est pas disponible pour les locaux. De fait, elle est difficilement exploitable pour l'analyse.

#### Surface habitable

La surface habitable se définit, d'après le Code de la construction et de l'habitation comme :

>> « La surface habitable d'un logement est la surface de plancher construite, après déduction des surfaces occupées par les murs, cloisons, marches et cages d'escaliers, gaines, embrasures de portes et de fenêtres ; le volume habitable correspond au total des surfaces habitables ainsi définies multipliées par les hauteurs sous plafond.
Il n'est pas tenu compte de la superficie des combles non aménagés, caves, sous-sols, remises, garages, terrasses, loggias, balcons, séchoirs extérieurs au logement, vérandas, volumes vitrés prévus à l'article R. 111-10, locaux communs et autres dépendances des logements, ni des parties de locaux d'une hauteur inférieure à 1,80 mètre. »

Autrement dit, la surface habitable diffère à la surface réelle en ne comptabilisant pas les surfaces dont la hauteur sous plafond est inférieure à 1,80m. Par contre, à la différence de la surface Carrez, elle comptabilise les pièces de moins de 8 m2.

![*Surfaces d'un local*](ressources/surface_local.png "Surfaces d'un local")

### Evolution du local dans le temps

L'identifiant d'un local apparait lorsqu'il vient d'être construit, lorsqu'il subit une transformation importante (division, réunion, changement d'affectation, etc.) ou qu'il subit une modification du critère d'évaluation (procédure fiscale).

L'identifiant d'un local disparait losqu'il est démoli, lorsqu'il subit une transformation importante (division, réunion, changement d'affectation, etc.) ou qu'il subit une modification du critère d'évaluation (procédure fiscale). 
 
Lors de la mutation, il est intéressant de savoir si le vendeur a effectué des modifications lourdes sur les locaux existants ou en a construit de nouveaux. Si c'est le cas, on dit que le local est "apparu sous le vendeur". De même, si l'acheteur a effectué des modifications lourdes sur les locaux existants ou en a démoli, on dit que le local a "disparu sous l'acheteur". Le critère d'apparition peut servir à identifier des constructeurs tandis que le critère disparition peut servir à détecter d'éventuelles friches.

## Locaux dans DVF+/DV3F

### Identification et décompte de locaux

Dans DVF+/DV3F, chaque ligne de la table _local_ représente l'état d'un local lors de sa mutation. Chaque local est identifiée par un identifiant @@local|iddispoloc@@ (valeur entière) et est rattachée à sa mutation par la variable @@local|idmutation@@.

Dans cette table _local_, on retrouve les variables liées à l'identité du local : @@local|idloc@@ qui est composé du code Insee de la commune auquel il apparaît et de la variable  @@local|identloc@@

Dans la table mutation, des informations agrégées permettent de faciliter les décomptes et identifications des locaux ayant muté : @@mutation|nblocmut@@ et @@mutation|l_idlocmut@@.

Attention, la présence du local dans DVF+/DV3F peut prendre parfois un certain temps. C'est ce qu'on appelle le temps de latence. Ainsi, pour les locaux neufs ou en VEFA, il est possible que ces derniers ne soient pas encore identifiés.

Par ailleurs, on peut constater un nombre non négligeable de mutations DVF qui ont au moins un local non présent dans les Fichiers fonciers. Ces manques concernent principalement les cas de VEFA et les mutations après le dernier millésime des Fichiers fonciers disponible. Si on s'attreint à travailler sur une période en accord avec les Fichiers fonciers, alors le taux d'erreur devient marginal, sauf pour les VEFA. Il est possible de s'appuyer sur la variable @@mutation|rapatffloc@@ de la table _mutation_ pour savoir si les informations issues des Fichiers fonciers ont bien été rapatriées. 

### Géométrie du local

La géolocalisation du local dans DV3F n'est disponible qu'au travers du localisant de la parcelle qui le contient. Les géométries, de type point(s), sont disponibles à travers à les variables géométriques :

* @@local|geomloc@@ pour la table local,
* @@mutation|geomlocmut@@ pour la table mutation.

Une mutation comportant plusieurs locaux aura une seule entité géographique rassemblant tous les locaux mutés (geomlocmut) lors de cette mutation. La représentation géographique d'une mutation peut donc comporter plusieurs points (qui peuvent se superposer).

### Typologie liée à la forme physique du local

Les variables DVF+ qui différencient les formes physiques du local sont :

* @@local|codtyploc@@, @@local|libtyploc@@ pour la table _local_,
* @@mutation|nblocmai@@, @@mutation|nblocapt@@, @@mutation|nblocdep@@, @@mutation|nblocact@@ pour la table _mutation_.

Ces mêmes informations sont présentes dans les Fichiers fonciers et ont été rapatriées dans DV3F à travers les variables suivantes :
* @@local|ffctyploc@@, @@local|ffltyploc@@ pour la table _local_,
* @@mutation|ffnblocmai@@, @@mutation|ffnblocapt@@, @@mutation|ffnblocdep@@, @@mutation|ffnblocact@@ pour la table _mutation_.

Globalement, l'ensemble sont très fiables et concordantes. Les derniers variables issues des Fichiers fonciers sont à privilégier lorsqu'il s'agit de travailler sur une analyse fine faisant appel à d'autres variables également issues des Fichiers fonciers (notion d'ancienneté, par exemple). 

De plus, dans DVF+/DV3F, il est proposé une distinction supplémentaire selon le type d'activité:
* @@local|ffcnatloc@@ et @@local|fflnatloc@@ pour la table _local_,
* @@mutation|ffnbactsec@@, @@mutation|ffnbactter@@ pour la table _mutation_.

### Logement et habitation

Le caractère habité est uniquement disponible dans DV3F :

* @@local|fflochab@@ pour la table _local_ définit si le local est une habitation (quelle que soit sa forme physique),
* @@mutation|ffnbloch@@ pour la table _mutation_ dénombre le nombre de locaux d'habitation.

L'occupation de l'habitation est restituée dans la table local grâce aux variables @@local|ffoccv@@ et @@local|ffocca@@.

### Date de construction

La date de construction n'est disponible que dans DV3F car elle provient des Fichiers fonciers. Il s'agit de la variable @@local|ffancst@@. 

Cette donnée est réputée très fiable pour les logements depuis 1970 et depuis 2003 pour l'activité.

Pour chaque mutation, seules les années de construction minimale et maximale des locaux qui la composent ont été remontées: @@mutation|ffancstmin@@ et @@mutation|ffancstmax@@.

Par différence avec la variable @@local|anneemut@@, la variable d'ancienneté du local @@local|anciennete@@ peut être définie. Dans la table mutation, sont ainsi décomptés les locaux anciens, récents et neufs : @@mutation|nblocanc@@, @@mutation|nblocrecen@@, @@mutation|nblocneuf@@.

Attention, environ 10 % des locaux ont une année de construction non renseignée (valeur 0), ce qui empêche la détermination de l'ancienneté. Ce chiffre est à relativiser par le fait qu'il concerne principalement les locaux d'activité.

### Nombre de pièces principales

Le nombre de pièces principales dans DVF+/DV3F correspond à la variable @@local|nbpprinc@@. Les informations sur le nombre de pièces principales sont accessibles au niveau de la table mutation pour permettre de décompter plus facilement les appartements et maisons en fonction de leur nombre de pièces (T1 à T5+):

* @@mutation|nbapt1pp@@, @@mutation|nbapt2pp@@, @@mutation|nbapt3pp@@, @@mutation|nbapt4pp@@ et @@mutation|nbapt5pp@@ pour les appartements, 
* @@mutation|nbmai1pp@@, @@mutation|nbmai2pp@@, @@mutation|nbmai3pp@@, @@mutation|nbmai4pp@@ et @@mutation|nbmai5pp@@ pour les maisons.

Dans DV3F, il est possible d'avoir une décomposition plus fine des pièces :

* @@local|ffnbpsam@@ pour les salles à manger,
* @@local|ffnbpcha@@ pour les chambres,
* @@local|ffnbpcu8@@ pour les cuisines de moins de 9 m2,
* @@local|ffnbpcu9@@ pour les cuisines d'au moins 9 m2,
* @@local|ffnbpsea@@ pour les salles d'eau,
* @@local|ffnbpann@@ pour les annexes.

![*Pieces principales*](ressources/pieces_principales.png "Pieces principales")

Attention, le terme "pièces principales d'habitation" dans Fichiers fonciers revêt une autre définition. Pour conserver le vocabulaire de DVF, la somme ffnbpsam + ffnbpcha issue des Fichiers fonciers a été également définie comme le nombre de pièces principales dans DV3F, représentée par la variable @@local|ffnbpprinc@@. Elle est comparable à @@local|nbpprinc@@.

Cette information a été remontée à la table mutation pour décompter les locaux en fonction de leur nombre de pièces : @@mutation|ffnbloc1pp@@, @@mutation|ffnbloc2pp@@, @@mutation|ffnbloc3pp@@, @@mutation|ffnbloc4pp@@ et @@mutation|ffnbloc5pp@@.

On constate que certains locaux n'ont aucune pièce, ou bien 99 pièces. La détermination du nombre de pièce est donc subjectif et à prendre avec précaution. Par exemple, un studio peut correspondre à un aucune pièce ou à une pièce.

### Dépendance d'un logement

Les dépendances sont classées dans les Fichiers fonciers en une quinzaine de catégories dont les frontières entre certaines peuvent être floues. Dans DV3F, elles ont donc été regroupées en 5 catégories : 

* les garages/parkings/box : @@local|ffnbpgarag@@ pour la table local et @@mutation|ffnbpgarag@@ pour la table mutation, 
* les piscines: @@local|ffnbppisci@@ pour la table local et @@mutation|ffnbppisci@@ pour la table mutation,
* les terrasses (ou toiture terrasse): @@local|ffnbpterra@@ pour la table local et @@mutation|ffnbpterra@@ pour la table mutation,
* les serres et élements de pur agrément (terrain de tennis, etc.): @@local|ffnbpagrem@@ pour la table local.
* les autres : bûcher,  buanderie, chambre de domestique, cellier, cave, grenier, grenier ou cave, jardin d'hiver, pièce indépendante, remise, dépendance de local commun. Cette catégorie correspond à la variable @@local|ffnbpcav@@ pour la table local et @@mutation|ffnbpcav@@ pour la table mutation.

![*Pieces annexes*](ressources/pieces_annexes.png "Pieces annexes")

### Surfaces d'un local

#### Les variables liées aux surfaces du local dans DVF+/DV3F

La surface réelle bâtie au sens de DVF est restituée par les variables @@local|sbati@@ de la table local et @@mutation|sbati@@ de la table mutation.

Dans DV3F, les surfaces sont détaillées selon leur occupation :

* la surface habitée : @@local|ffshab@@ pour la table local et @@mutation|ffshab@@ pour la table mutation,
* la surface des dépendances (dépendances d'habitation ou isolées) : @@local|ffsdep@@ pour la table local et @@mutation|ffsdep@@ pour la table mutation,
* la surface professionnelle (activités) : @@local|ffspro@@ pour la table local et @@mutation|ffspro@@ pour la table mutation. 

La surface de l'ensemble des pièces du ou des locaux sont également rapatriés à partir des Fichiers fonciers dans DV3F. Il s'agit des variables @@local|ffsbati@@ de la table local et @@mutation|ffsbati@@ de la table mutation. Cette surface est la somme des surfaces des 3 occupations.

Il est important de noter que sbati et ffsbati ne correspondent pas aux mêmes surfaces. Lorsque le rapatriement est bien effectué, on peut écrire les égalités suivantes :

* sbati = ffshab + ffspro,
* ffsbati = ffshab + ffspro + ffsdep.

#### Surface en fonction de la forme physique du local et nombre de pièces

Dans DVF+/DV3F, pour faciliter l'analyse d'une mutation, la surface a été repartie selon la forme physique du local au travers des variables @@mutation|sbatmai@@, @@mutation|sbatapt@@ et @@mutation|sbatact@@.

Pour les logements, la surface a aussi été repartie en fonction du nombre de pièces : @@mutation|sapt1pp@@, @@mutation|smai1pp@@, @@mutation|sapt2pp@@, @@mutation|smai2pp@@, @@mutation|sapt3pp@@, @@mutation|smai3pp@@, @@mutation|sapt4pp@@, @@mutation|smai4pp@@, @@mutation|sapt5pp@@ et @@mutation|smai5pp@@.

#### Surface Carrez

La surface carrez est uniquement disponible pour les lots dans la table lot : @@lot|scarrez@@.

#### Approche de la surface habitable dans DV3F

La surface habitable n'est pas disponible dans DV3F. 

La surface réelle habitée ffshab de DV3F diffère de cette surface car :

* elle comptabilise les surfaces sous plafond de moins d'1m80 
* elle ne comptabilise aucune dépendance. 

Sur ce premier point, il n'est pas possible de faire de correction car la présence de mansarde ne peut pas être détectée à l'aide des variables DV3F. Par contre, la surface des dépendances est disponible. On peut donc essayer de corriger la surface habitée pour approcher la surface habitable. A noter cependant que pour les maisons, les zones habitées et les zones de dépendances sont parfois confondues et peu actualisées fiscalement.

Ainsi, pour approcher au plus près de la surface habitable, on peut donc imaginer les estimations haute et basse suivantes: 

* estimation basse : ffshab + le minimum entre ffsdep/2 et 8m2,
* estimation haute : ffshab + ffsdep.

### Locaux apparus / disparus

Dans DV3F, des méthodes de détermination de la stabilité des locaux ont permis d'aboutir à la création de plusieurs indicateurs :

* @@local|stabilitel@@ pour la table _local_,
* @@mutation|nblocapp@@ et @@mutation|nblocdisp@@ pour la table _mutation_.

La méthode de détermination des modifications des locaux s'appuie sur un travail de comparaison des millésimes des Fichiers fonciers (cf @TUTO@stabilite_bien|Détermination de la stabilité des biens dans DV3F@TUTO@).


Titre: Faites le tour des locaux...
Theme: Tutoriel
Numero: 5
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 31/08/2016
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

En ce qui concerne l'activité, les activités primaires ne sont pas observées. Via les Fichiers fonciers, il est possible de différencier les activités secondaires et tertiaires. 

La notion de logement regroupe les locaux de type maison ou appartement.

### Logement et Habitation


Un logement n'est pas synonyme d'habitation. A titre d'exemple, une boulangerie peut être considérée comme un local de type maison. Inversement, une habitation peut être considérée comme un local d'activité secondaire (loft). Il a été constaté que les logements sont essentiellement à vocation d'habitation (99,4 % en France), même si quelques-uns peuvent être des locaux mixtes ou professionnels. 

A l'exception de l'étude spécifique d'une forme particulière d'occupation (ex: loft), ces deux peuvent être confondues pour une analyse globale.

Pour les habitations, l'occupation du local décrit s'il est loué, occupé par le propriétaire, vacant, etc. (au 1er janvier de chaque année). 


### Date de construction d'un local et ancienneté

La date de cosntruction n'est disponible que dans DV3F. Elle provient des Fichiers fonciers. 
La date de construction est réputée très fiable pour les logements depuis 1970 et depuis 2003 pour l'activité. Attention cependant, certains locaux, et en particulier les activités peuvent ne pas vaoir de date de construction. 
Enfin, lorsqu'un local est profondément modifié (grosse rénovation), les services de la DGFiP peuvent remettre à jour sa date de construction. 
L'ancienneté d'un local se définit en fonction de la différence entre l'année de mutation et la date de construction du local : 
- moins de 1 ans : le local est neuf,
- de 2 à 4 ans, le local est récent, 
- plus de 5 ans, le local est ancien.
Quand la date de construction n'est pas connue, il n'a pas été possible d'évaluation l'ancienneté du local.

### Nombre de pièces d'un local

La notion de pièce principale d'habitation dans DV3F correspond à la somme des pièces considérées comme des chambres ou des salles-à-manger. Un bureau ou une bibliothèque de taille suffisante sont  considérés fiscalement comme une chambre. Une grande salle à manger peut être comptabilisée comme deux pièces.
Concrètement un appartement de 3 pièces prinicpales dans DVF correspond à la notion de T3.
Attention, les mots "pièces principales d'habitation" n'ont pas exactement la même signification entre DVF et Fichiers fonciers. La notion de pièce principale d'habitation dans DV3F est équivalente à celle de FILOCOM et à la notion npiece_p2 des Fichiers Fonciers.
On constate que certains locaux n'ont aucune pièce, ou bien 99 pièces. La détermination du nombre de pièce est donc subjectif et à prendre avec précaution. Par exemple, un studio peut correspondre à un aucune pièce ou à une pièce.

### Surface d'un local

La surface bâtie représente la surface mesurée au sol du plancher entre murs ou séparations.
Dans DVF, "sbati" représente la surface de l'ensemble du bâti ayant muté, sans le décompte des surfaces de dépendances et sans regarder l'occupation du local (habitation ou activité).
"Sbatmai", "sbatapt","sbatact","sapt1pp", etc. sont les surfaces par type de local (maison/appartement/activité) ou leur nombre de pièce. Ces surfaces ne regardent pas l'occupation du local. Ainsi une maison utilisée pour un cabinet médical et une habitation ne fera pas de différenciation de surface. "ffshab" et "ffspro" font justement cette différence, avec respectivement les surfaces dédiées à l'habitation et les surfaces dédiées à l'activité professionnelle. "ffsdep" donne la surface des dépendances isolées ou non.
Pour le calcul des surface, les instructions précises de la DGFiP sont décrites ci-après : 
« Dans le cas où, par suite de l'absence des documents susvisés, la surface des éléments doit être mesurée, il convient de comprendre dans cette dernière :
la superficie des espaces tels que bow-windows (fenêtres en saillie sur une façade), alcôves, volumes de rangement, ouverts sur lesdits éléments ;
celle occupée par les diverses installations : appareils sanitaires, éviers, placards en saillie des murs et cloisons, appareils de chauffage, cheminées, etc. ;
et celle des éléments de décors : colonnes, pilastres, etc.
En revanche, ne doivent pas être retenues dans cette surface les superficies occupées par :
les embrasures des portes et des fenêtres ;
les espaces occupés par des conduits de fumée et de ventilation ;
les placards de rangement en renfoncement de faible superficie ;
les emmarchements et trémies d'escaliers (surfaces correspondant aux marches, paliers intermédiaires et aux jours entre volées où peuvent être aménagés ascenseurs ou monte-charge, mais non les paliers d'étage qui sont compris dans la surface réelle lorsqu'il s'agit d'une maison individuelle).
Le résultat est arrondi au mètre carré inférieur.
Les notions liées à la surface sont identiques entre DVF et Fichiers fonciers, mais les intitulés sont trompeurs entre les deux bases. Dans DV3F, sbati = ffshab+ ffspro. La surface bâtie dans Fichiers fonciers  est égale à ffshab+ ffspro + ffsdep.
A noter aussi que les dizaines puis les centaines sont davantage remplies que les autres valeurs, ce qui laisse à penser que les propriétaires ont pu arrondir la surface lors de leur déclaration.
En général, la surface utilisée pour analyser des logements n'est pas la surface réelle liée aux impots, mais la surface habitable ou la surface carrez. Il existe quelques différences entre cs différentes définitions. 
La surface habitable ressemble à la surface réelle, car elle comptabilise les surfaces planchers. Mais, à la différence des impôts, elle ne comptabilise pas  les surfaces dont la hauteur sous plafond est inférieure à 1,80m.
La surface Carrez ne comptabilise pas  les surfaces dont la hauteur sous plafond est inférieure à 1,80m et elle ne comptabilise pas les surfaces de pièces de moins de 8 m².
Pour approcher au plus près de la surface habitable il existe donc une fourchette haute et basse : 
fourchette basse : ffshab
fourchette haute : ffshab + ffsdep
Pour les maisons, la surface réelle est la surface déclarée par les contribuables. Comme ces informations ne sont pas toujours mises à jour, il est possible que les combles aménagés pour la partie d’habitation soient toujours considérés comme dépendances pour les Fichiers fonciers. De plus les dépendances isolées sont parfois transformées en lieu de vie (chambre pour l’adolescent, garage transformé en pièce de vie, etc.). De ce fait, la fourchette haute (ffshab + ffsdep) serait la plus appropriée pour les maisons. 
A l’inverse, pour les appartements, ffshab serait la surface la plus approchante de la surface habitable. 
L’utilisateur décidera quelle définition prendre en fonction de ses besoins.


### Dépendances d'un local

Les dépendances dans DVF et Fichiers fonciers sont toujours des dépendances liées à l'habitation. 
Il existe plusieurs catégories regroupées en 4 types : 
- les garages/parkings/box,
- les piscines,
- les terrasses (ou toiture terrasse),
- autres : bûcher,  buanderie, chambre de domestique, cellier, cave, grenier, grenier ou cave,  jardin d'hiver, pièce indépendante, remise, dépendance de local commun.
N'ont pas été retenus les serres, et les éléments de pur agrément. 
Les dépendances peuvent être intégrées au bâti principal, ou être isolées.
Les dépendances importées des Fichiers fonciers sont des dépendances bâties, qu'il ne faut pas confondre avec les dépendances non bâties : cours, passages, jardins, parcs, aires de stationnement collectives à ciel ouvert, terrains, etc. qui peuvent aussi impacter le prix d'un bien mais qui ne sont pas référencés dans DV3F. 
Un propriétaire n'a pas l'obligation de déclarer certains travaux (par exemple, son abri de jardin si sa superficie est inférieure à 5m²). Ces dépendances bâties ne seront pas prises en compte.
Attention, les données des Fichiers fonciers sont des données fiscales basées en grande partie sur les déclarations des particuliers. De ce fait, des incohérences peuvent exister avec la réalité : 
un propriétaire peut être en infraction et ne pas avoir déclaré certains travaux. Par exemple, le propriétaire ne déclare pas qu'il a aménagé son grenier en surface d’habitation (surestimation des dépendances).
Certains champs de dépendance ont des usages très proches. Certains particuliers utilisent leur garage comme buanderie, tandis que d'autres l'utilisent pour leur voiture. Le classement dans un champ d'une pev n'assure pas que son occupation est conforme à ce classement.

### Disparition local

Un local peut muter plusieurs fois dans le temps, et changer de forme physique (agrandissement, réhabilitation, etc.). Cependant, si ces modifications sont trop importantes, alors les DGFiP préfère supprimer le numéro du local utilisé pour créer un ou des autres locaux. Autrement dit, si un local apparaît, c'est qu'il a subi une forte modification : construction, ajout de construction, démolition, division, réunion, etc.
Lors de la mutation, il est intéressant de savoir si le vendeur a effectué des grosses modifications sur le local. On dit que le local est apparu sous le vendeur. 
De même, lors de la mutation, il est intéressant de savoir si l'acheteur a effectué des grosses modifications sur le local. On dit que le local a disparu sous l'acheteur.
Aucun trie sur la nature de la modification du local n'a été effectué. 
Certaines modifications sont liés à des aménagements : construction, addition de construction, changement de consistance, changement d'affectation, etc. 
Inversement certaines modifications n'induisent pas forcément des aménagements : modification suite à contentieux, modification des critères d'évaluation, etc.
La méthode de détermination des modifications des locaux s'appuie sur un travail de comparaison des millésimes des Fichiers fonciers et sur la variable dnatcg. Cette méthode statistique manque encore de retours d'expériences pour confirmer sa fiabilité. Elle est donc à prendre avec précaution.

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




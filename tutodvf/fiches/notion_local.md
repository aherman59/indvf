Titre: ... et des locaux
Theme: Tutoriel
Numero: 5
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 31/08/2016
Contact: dv3f@cerema.fr

## Définition et caractéristiques du local dans DVF

### Définition du local

Le local est un ensemble de « différentes constructions qui, en raison de leur agencement, forment un ensemble immobilier homogène d’un même compte-propriétaire ». 
« Ne sauraient être considérés comme constituant un local distinct, ni la pièce meublée d'un logement loué en meublé à un étudiant, ni les pièces occupées temporairement par un jeune ménage dans l'appartement des parents de l'un des conjoints, ni le garage d'une maison individuelle faisant l'objet à titre accidentel d'une location séparée, etc » 
Un local peut être composé de plusieurs éléments bâtis. Les bâtiments publics comme les écoles, les hôpitaux… ne sont en général pas recensés dans l’application MAJIC puisqu’ils sont exonérés de taxe.
Un local est différencié en 4 catégories selon sa forme physique : 
- la maison,
- l'appartement,
- la dépendance (forcément liée à l'habitation),
- l'activité (et ses dépendances), ne sont pas compris les activités primaires, sont compris et peuvent être différenciées, les activités secondaires et tertiaires.
La différenciation entre maison, appartement, dépendance et activité est très fiable. 
Un logement est le regroupement des maisons et appartements quel que soient leurs occupations (habitation, activité libérale, etc.). Attention, un logement n'est pas forcément une habitation. Par exemple une boulangerie peut être dans une maison. Inversement, une habitation peut être dans un local industriel (loft). Au final, dans les Fichiers fonciers, on peut constater que les locaux de type maison et appartement sont essentiellement à vocation d'habitation (99,4 % en France), même si quelques-uns peuvent être des locaux mixtes ou professionnels. De ce fait, le choix de l’une des définitions par rapport aux autres impacte peu les tendances ou les proportions dans DVF. Par contre elle est essentiel lorsque l’observation porte sur un nombre réduit de locaux.
La présence du local dans DV3F peut prendre parfois un certain temps, encore plus lorsque ces données proviennent de Fichiers fonciers. C'est ce qu'on appelle le temps de latence. Ainsi, pour les logements neufs ou en VEFA, il est possible qu'aucun local ne soit décompté.
En première lecture, on peut constater un nombre non négligeable de mutations DVF qui ont au moins un local que Fichiers fonciers ne trouvent pas. Ces différences concernent principalement les cas de VEFA, les mutations avant 2008 et les mutations après le dernier millésime des Fichiers fonciers qui ne peuvent être prises en compte par les Fichiers fonciers. Si on s'attreint à travailler sur une période en accord avec les Fichiers fonciers (2009-2014 par exemple), alors le taux d'erreur devient marginal. Par contre si l'analyse effectuée concerne uniquement les VEFA, ce taux n'est plus marginal.
En outre de sa catégorie, le local se caractérise par sa date de construction, son nombre de pièce, sa surface, ses dépendances. 

### Date de cosntruction d'un local et ancienneté

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
Titre: Faites le tour de la parcelle...
Theme: Tutoriel
Numero: 4
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 31/08/2016
Contact: dv3f@cerema.fr

## Définition et caractéristiques d'une parcelle dans DVF

### Définition

La définition d'une parcelle est la suivante : 

>> « Portion de terrain d’un seul tenant, situé dans un même lieu-dit, appartenant à un même propriétaire ou à une même indivision 
>> et constituant une unité foncière indépendante selon l’agencement donné à la propriété. Le numérotage parcellaire est effectué,
>> à l’origine, sans interruption et par sections. Toute parcelle nouvelle ou modifiée reçoit un nouveau numéro pris à la 
>> suite du dernier attribué dans la section ; le numéro de la parcelle primitive n’est jamais réutilisé mais il permet 
>> de localiser la nouvelle parcelle créée qui fait référence à la parcelle primitive ». 

La parcelle est référencée par un code alpha-numérique se composant du code insee du département, de la commune, d'un préfixe de trois chiffres, du numéro de la section cadastral (2 caractères), 
et de 4 chiffres désignant le numéro de la parcelle.

Elle peut changer d’occupation mais pas de contour. Si le contour doit être modifié, alors la parcelle est remplacée par une autre parcelle. 
D'un point vue cadastral, cela se traduit par un changement d'identifiant.

Une parcelle peut être caractérisée selon son contour, son occupation et sa surface.

### Notion de parcelles mutées / parcelles concernées

Lorsque la propriété pleine et entière de la parcelle est transférée lors de la mutation, alors la parcelle est dite "mutée". 
Le prix de la vente comprend la propriété de ce bien.

Une parcelle est dite "concernée" si elle est :

* soit une parcelle mutée,
* soit une parcelle qui ne subit aucun transfert total de propriété mais dont la propriété d'au moins un bien présent sur celle-ci 
est transférée lors de la mutation (les cas les plus fréquents sont les ventes d'appartements).

### Notion de "disposition-parcelle"

Une parcelle concernée par une mutation peut présenter des caractéristiques qui évoluent dans le temps (hormis son contour). Il est alors nécessaire d'identifier ces différents états : la « disposition-parcelle » représente l'état d'une parcelle à une date de mutation précise.

### Contour de la parcelle

Le contour de la parcelle est celui défini au cadastre.

### Natures de culture

Une parcelle peut avoir de nombreuses formes d'occupations. Dans DVF, la DGFiP les regroupe selon 27 catégories appelées "nature de culture" 
ou 153 sous-catégories appelées "nature de culture spéciale". 

Par exemple, on trouve parmi les natures de culture : les terres, les vergers, les bois, les jardins, les taillis simples, les peupleraies, etc.

De même, on peut trouver parmi les natures de culture spéciales : les digues, les chênes-lièges, les pré-marais, les plages, les terrains de sport, 
les terrains vagues, les terrils, etc.

### Subdivisions fiscales

Une parcelle peut être composée de plusieurs natures de culture (ou culture spéciales); chaque nature de culture étant affectée à une subdivision 
fiscale (suf) identifiée par un numéro. Autrement dit, une suf correspond à une occupation du sol particulière, et chaque parcelle est composée d’une 
ou de plusieurs sufs. 

Par exemple, une parcelle peut être constituée d'une maison avec un terrain de camping. Elle se compose ainsi de 2 subdivisions fiscales.
La première est classée en SOL (S) pour la partie "maison". La seconde est classée en "terrain d'agrément"(AG) avec une nature de culture spéciale
de type "terrain de camping" (CAMP). 

Les subdivisions fiscales ont été générées en 1963 et leur mise à jour dépend de leur intérêt fiscal. 
L’actualisation concerne ainsi prioritairement les parcelles qui enregistrent une nouvelle construction.
 
Les surfaces de type artificialisé (notamment les surfaces de type « sol »), prises dans leur ensemble, sont donc plus fiables. 
A contrario, les changements d’occupation aboutissant à une vocation agricole ou naturelle sont peu suivies. Par exemple, des 
surfaces boisées peuvent apparaître comme agricoles, et inversement. 

De ce fait, l’utilisation des natures de culture et natures de culture spéciales est surtout pertinente là où il n’existe pas
de Mode d’Occupation des Sols (MOS) local, multi-année. Lorsque l’on travaille avec les sufs, il est conseillé de les regrouper en 4 ou 5 types. 

### Surface de terrain ayant muté

La surface du terrain ayant muté correspond à la somme des surfaces des subdivisions fiscales (suf) composant la ou les parcelles ayant muté.

### Evolution de la parcelle dans le temps

Le contour d'une parcelle est invariant dans le temps. Si il est modifié, alors la référence cadastrale de la parcelle change. Autrement dit, si un terrain est aménagée avec changement de contour de la parcelle (division, réunion, etc.) alors la parcelle d'origine disparaît et une ou des nouvelles parcelles apparaissent. 

Attention, à l'inverse, la modification de la référence cadastrale ne signifie pas nécessairement une évolution de contour. Il peut s'agir d'une modification administrative telle qu'une fusion-absorbtion de commune. 
 
Lors de la mutation, il est intéressant de savoir si le vendeur a effectué des aménagements de type réunion ou division sur la parcelle mutée pour notamment pouvoir lui attribuer un rôle d'aménageur. Si c'est le cas, on dit que la parcelle est "apparue sous le vendeur". De même, si l'acheteur a effectué des aménagements de type réunion ou division sur la parcelle mutée, on dit que la parcelle a "disparue sous l'acheteur". 

Si l'acheteur ou le vendeur n'a effectué aucune division ou réunion, la parcelle est considérée comme "stable", même si sa référence cadastrale a pu changer.

## Parcelles dans DVF+/DV3F

### Identification et décompte de parcelles

Dans DVF+/DV3F, chaque ligne de la table _disposition_parcelle_ représente une "disposition-parcelle", c'est-à-dire l'état d'une parcelle lors qu'elle mute ou qu'elle est concernée par une vente. Chaque disposition-parcelle est identifiée par un identifiant @@disposition_parcelle|iddispopar@@ (valeur entière) et est rattachée à sa mutation par la variable @@disposition_parcelle|idmutation@@.

Dans cette table _disposition_parcelle_, on retrouve les variables liées à :

* à la référence cadastrale de la parcelle : @@disposition_parcelle|idpar@@ qui se décompose en @@disposition_parcelle|coddep@@, @@disposition_parcelle|codcomm@@, @@disposition_parcelle|prefsect@@, @@disposition_parcelle|nosect@@, @@disposition_parcelle|noplan@@, 
* au caractère muté ou non de la parcelle : @@disposition_parcelle|parcvendue@@.

Dans la table mutation, des informations agrégées permettent de faciliter les décomptes et identifications :

* des parcelles concernées par la mutation : @@mutation|nbpar@@ et @@mutation|l_idpar@@
* des parcelles mutées : @@mutation|nbparmut@@ et @@mutation|l_idparmut@@

A noter, que pour la table mutation de DV3F, la variable @@mutation|rapatffpar@@ indique si les informations issues des Fichiers fonciers pour les parcelles concernées ont bien été rapatriées. 

### Géométrie de parcelles

Les contours des parcelles sont disponibles à travers à les variables géométriques :

* @@disposition_parcelle|geompar@@ pour la table disposition_parcelle,
* @@mutation|geompar@@ et @@mutation|geomparmut@@ pour la table mutation.

Une mutation comportant plusieurs parcelles aura une seule entité géographique rassemblant toutes les parcelles concernées (geompar) ou toutes les parcelles mutées (geomparmut) lors de cette mutation. La représentation géographique d'une mutation peut donc comporter des objets de contours disjoints.

A noter que les géométries sont intégrées à partir de plusieurs millésimes de la BD Parcellaire (constitution d'un historique des parcelles) et complétées par les données disponibles sur cadastre.gouv.fr, permettant une exhaustivité maximale.

### Occupation de la parcelle

Dans DVF+/DV3F, les informations liées aux surfaces des natures de culture et culture spéciales sont disponibles 
dans la table _suf_ (@@suf|natcult@@ et @@suf|natcultspe@@).

Les tables annexes _ann_nature_culture_ et _ann_nature_culture_speciale_ décrivent la correspondance entre les codes et libellés des différents
natures de culture définies par la DGFiP.

Pour ne pas surcharger d'informations l'utilisateur et faciliter la correspondance avec les Fichiers fonciers, 
ces différentes natures de culture ont d'abord été regroupées selon les 13 classes déjà disponibles dans les Fichiers fonciers : 

* dcnt01 : Terres  = T (terres) et TE (terres plantées)
* dcnt02 : Prés = P (prés) + PA (paurages) + PC (pacages) + PE (pré d'embouchure) + PH (herbages) + PP (pré plantes)
* dcnt03 : Vergers = VE (vergers)
* dcnt04 : Vignes = VI (vignes)
* dcnt05 : Bois = B (bois) + BF (futaies feuillues) + BM (futaies mixtes) + BO (oseraies) + BP (peupleraies) + BR (futaies résineuses) + BS (taillis sous futaie) + BT (taillis simples)
* dcnt06 : Landes =L (landes) + LB (landes boisées)
* dcnt07 : Carrières = CA (carrières)
* dcnt08 : Eaux = E (eaux)
* dcnt09 : Jardins = J (jardins)
* dcnt10 : Terrains à bâtir = AB (terrain à bâtir)
* dcnt11 : Terrains d’agréments = AG (terrains d'agréments)
* dcnt12 : Chemin de fer = CH (chemin de fer)
* dcnt13 : Sol = S (sols)

Les surfaces liées à ces regroupements sont disponibles pour les parcelles ayant muté, dans les tables _mutation_ (@@mutation|l_dcnt@@) 
et _disposition_parcelle_ (@@disposition_parcelle|dcnt01@@ à @@disposition_parcelle|dcnt13@@). 
Dans DV3F, ces mêmes catégories d'occupation ont également été rappatriées à partir des Fichiers fonciers pour les parcelles mutées 
(@@mutation|l_ffdcnt@@ pour la table mutation et @@disposition_parcelle|ffdcnt01@@ @@disposition_parcelle|ffdcnt13@@ pour la table disposition_parcelle). 

De plus, dans DVF+/DV3F, il est proposé un regroupement supplémentaire, qui s'appuie sur le retour d'expérience des Fichiers fonciers, permettant de faciliter les analyses liées à l'occupation.
Ce regroupement se décompose en 4 catégories :

* dcntagri : agricole (dcnt01 à 04)
* dcntsol : artificialisé (dcnt07, et 09 à 13)
* dcntnat : naturel (dcnt05 et dcnt06)
* dcnt08 : eau 

Les surfaces liées à ces regroupements sont disponibles pour les parcelles ayant muté 
dans la table _disposition_parcelle_ (@@disposition_parcelle|dcntagri@@, @@disposition_parcelle|dcntsol@@, @@disposition_parcelle|dcntnat@@). 
Dans DV3F, ces mêmes catégories d'occupation ont également été rappatriées à partir des Fichiers fonciers 
pour les parcelles mutées (@@disposition_parcelle|ffdcntagri@@, @@disposition_parcelle|ffdcntsol@@, @@disposition_parcelle|ffdcntnat@@)

Enfin, pour DV3F uniquement, et dans la table _mutation_, a été créé un indicateur d'occupation plus adapté à la détection de
segment de marchés fonciers ou immobiliers (variable @@mutation|occupation@@).

### Surface du terrain ayant muté

Il existe plusieurs variables décrivant la surface du terrain ayant muté dans DV3F :

* @@mutation|sterr@@ qui correspond à la somme de toutes les surfaces des suf issues de DVF ayant muté pour une même mutation, 
* @@mutation|ffsterr@@ qui correspond à la somme de toutes les surfaces des suf issues des Fichiers fonciers ayant muté pour une même mutation,
* @@mutation|ffsparc@@ qui correspond à la somme des surfaces de parcelles issues des Fichiers fonciers (variable dcntpa) ayant muté.

Il peut exister des différences de surface entre sterr, ffsterr, ffsparc et la surface de l'entité géométrique correspondante mais cela reste marginal. Par contre, il est peut-être intéressant de s'assurer lorsqu'on travaille sur des échantillons ou de tres petits nombres de mutations que ces variables sont cohérentes entre elles.

### Parcelles apparues / disparues

Dans DV3F, des méthodes de détermination de la stabilité des parcelles ont permis d'aboutir à la création de plusieurs indicateurs :

* @@disposition_parcelle|stabilitep@@ pour la table _disposition_parcelle_
* @@mutation|nbparapp@@ et @@mutation|nbpardisp@@ pour la table _mutation_

La méthode de détermination des modifications des parcelles s'appuie sur un travail de comparaison des millésimes des Fichiers fonciers (cf @TUTO@stabilite_bien|Détermination de la stabilité des biens dans DV3F@TUTO@)


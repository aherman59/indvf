Titre: Notions avancées sur les parcelles
Theme: Plus loin avec DV3F
Numero: 1
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 30/06/2018
Contact: dv3f@cerema.fr

[TOC]


## Natures de culture

Une parcelle peut avoir de nombreuses formes d'occupations. Dans DVF, la DGFiP les regroupe selon 27 catégories appelées "nature de culture" 
ou 153 sous-catégories appelées "nature de culture spéciale". 

Par exemple, on trouve parmi les natures de culture : les terres, les vergers, les bois, les jardins, les taillis simples, les peupleraies, etc.

De même, on peut trouver parmi les natures de culture spéciales : les digues, les chênes-lièges, les pré-marais, les plages, les terrains de sport, 
les terrains vagues, les terrils, etc.

## Subdivisions fiscales

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

## Occupation du sol dans DV3F

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

De plus, dans DVF+/DV3F, il est proposé un regroupement supplémentaire, qui s'appuie sur le retour d'expérience des Fichiers fonciers, permettant de faciliter les analyses liées à l'occupation.
Ce regroupement se décompose en 4 catégories :

* dcntagri : agricole (dcnt01 à 04)
* dcntsol : artificialisé (dcnt07, et 09 à 13)
* dcntnat : naturel (dcnt05 et dcnt06)
* dcnt08 : eau 

Le schéma ci-après montre les deux niveaux de regroupement :

![*Occupation du sol*](ressources/dcnt.png "Occupation du sol")

```variables
@-@Variables associées@-@
Mutation : @@mutation|l_dcnt@@, @@mutation|l_ffdcnt@@
Disposition_parcelle : @@disposition_parcelle|dcnt01@@ à @@disposition_parcelle|dcnt13@@, @@disposition_parcelle|ffdcnt01@@ à @@disposition_parcelle|ffdcnt13@@, @@disposition_parcelle|dcntagri@@, @@disposition_parcelle|dcntsol@@, @@disposition_parcelle|dcntnat@@, @@disposition_parcelle|ffdcntagri@@, @@disposition_parcelle|ffdcntsol@@, @@disposition_parcelle|ffdcntnat@@
``` 

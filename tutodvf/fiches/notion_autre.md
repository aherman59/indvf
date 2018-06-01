Titre: Autres notions avancées
Theme: Plus loin avec DV3F
Numero: 3
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 30/06/2018
Contact: dv3f@cerema.fr

[TOC]

## La notion de disposition

Une mutation est composée de une à plusieurs sous-parties, constituant chacune une unité d'analyse juridique,
qui sont appelées _dispositions_. 

Le montant de la transaction peut être réparti selon les différentes dispositions de la mutation. 
Seules les dispositions ayant un caractère onéreux sont référencées dans DVF. 

A noter qu'environ 98% des mutations ne présentent qu'une seule disposition dans DVF.

La notion de disposition est purement juridique et il est conseillé de travailler plutôt au niveau de la mutation pour effectuer des analyses ou de l'évaluation de biens.

```variables
@-@Variables associées@-@
Mutation : @@mutation|nbdispo@@
Disposition : @@disposition|iddispo@@, @@disposition|idmutation@@
``` 

## La notion de lot et de volume

### Division (ou partage) de propriété

Il existe des régimes juridiques permettant de partager des biens complexes entre plusieurs personnes physiques ou morales. L'exemple le plus fréquent est la copropriété.

Les règles de partage peuvent varier mais seuls deux règles de division sont disponibles dans DVF :
la division en lots (copropriété) et la division en volumes.

### Les lots

La division en lots (80% des propriétés divisées en France), ou copropriété, associe un lot à un unique compte-propriétaire. 

Le lot peut être de plusieurs natures : bâti, non bâti ou un ensemble des deux.

Le lot n’est pas rattaché à un élément physique précis tel qu’un logement. Ainsi un lot peut contenir plusieurs logements. À l’inverse, un local peut contenir plusieurs lots.

Dans un cas simple, un lot dans une copropriété d'un immeuble, correspond à un appartement avec une quote-part des parties communes (couloir, ascenseur, etc.).

Les informations liées aux lots ayant muté fournis dans DVF ne sont parfois pas toutes restituées, du fait d'une limitation du nombre de champs de numéro de lots (@@lot|nolot@@) et de surfaces carrez associées (@@lot|scarrez@@).

Par ailleurs, comme les lots n'ont pas de représentation physique, toutes les informations sont difficilement exploitables. Au niveau de la table mutation, seule une estimation du nombre de lots vendus a été remontée (@@mutation|nblot@@) dans DVF+.

Enfin, comme les numéros de lots ne suffisent pas pour faire une jointure efficiente avec les Fichiers fonciers (il manque une information sur l'identification de la propriété divisée (_dnupdl_ des Fichiers fonciers), il n'est pas aisé d'enrichir DVF+ avec les informations des Fichiers fonciers.   

Au final, lorsque la mutation restitue des lots, que l'information soit complète ou non, cela n'impacte pas les informations liées aux locaux. Il est fortement conseillé de travailler sur les locaux plutôt que les lots, même lorsque l’étude menée a pour objet les copropriétés. 

 
### Les volumes

La division en volumes (2% des propriétés divisées en France) est un partage de propriété d'un bien (le plus souvent, un immeuble bâti ou d’un groupement d’immeubles) selon des volumes, et n’ayant pas de parties communes. La superposition des volumes implique cependant la création de servitudes multiples (appui, passage, accrochage, surplomb…) et d’un règlement rédigé par le géomètre-expert pour administrer l’immeuble, l’entretenir et prévoir une éventuelle reconstruction. 

La division en volume est utilisée essentiellement lorsque le domaine privé et le domaine public se chevauchent, le domaine public ne pouvant pas faire partie d’une copropriété. En particulier, on retrouve ce système pour les logements sociaux sur le domaine public.

Le volume n'a pas de correspondance physique. Il peut englober un ou plusieurs locaux, ou au contraire, une partie d'un local seulement.

Même si, à l'heure actuelle, la division en volume représente une part réduite des partages de propriété, elle a tendance à se développer de plus en plus.

La table volume permet de recenser les numéros de volumes. Aucune autre information n'y est associée dans DVF. 
Au niveau de la table mutation, seule une estimation du nombre de volumes vendus a été remontée (@@mutation|nbvolmut@@) dans DVF+. 
La jointure avec les Fichiers fonciers reste encore une opération hasardeuse qu'il reste à explorer.

Contrairement aux lots, il est difficile de déterminer si les informations liées aux locaux sont complètes en présence de volumes. 


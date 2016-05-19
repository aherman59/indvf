Titre: Description de la typologie de propriétaires
Theme: Variable
Numero: 2
Auteurs: Antoine Herman, Magali Journet, Bertrand Leroux - Cerema
MAJ: 19/04/2016
Contact: dv3f@cerema.fr

## Typologie

Une première typologie de propriétaires a été établie pour faciliter l'identification de certaines catégories d'acheteurs ou de vendeurs. Elle
se base sur plusieurs variables issues des Fichiers fonciers.

Les variables associées à cette typologie sont préfixées par _codtyppro_ suivies d'un _a_ lorsqu'il s'agit de l'acheteur et d'un _v_ lorsqu'il s'agit
du vendeur. Elles se retrouvent dans les tables _acheteur_vendeur_, _mutation_, _disposition_parcelle_ et _local_

## Codification de la typologie

| Niveau 1 | Niveau 2| Code 1 | Code 2 |
|---------------------|---------------------|-----:|:-----|
|PUBLIC|ETAT|P|1|
|PUBLIC|REGION|P|2|
|PUBLIC|DEPARTEMENT|P|3|
|PUBLIC|INTERCOMMUNALITE|P|4|
|PUBLIC|COMMUNE|P|5|
|PUBLIC|COLLECTIVITE TERRITORIALE|P|6|
|PUBLIC|AUTRE PERSONNE MORALE PUBLIQUE|P|0|
|PROFESSIONNEL FONCIER IMMOBILIER|SEM/SPLA|F|4|
|PROFESSIONNEL FONCIER IMMOBILIER|EPF|F|2|
|PROFESSIONNEL FONCIER IMMOBILIER|SAFER|F|3|
|PROFESSIONNEL FONCIER IMMOBILIER|AMENAGEUR FONCIER|F|5|
|PROFESSIONNEL FONCIER IMMOBILIER|ORGANISME D’ACQUISITION / REHABILITATION (PACT, etc)|F|7|
|PROFESSIONNEL FONCIER IMMOBILIER|PROMOTEUR IMMOBILIER PRIVE|F|6|
|PROFESSIONNEL FONCIER IMMOBILIER|OFFICE HLM|F|1|
|STRUCTURE EN MILIEU AGRO- NATUREL|STRUCTURE AGRICOLE|A|1|
|STRUCTURE EN MILIEU AGRO- NATUREL|STRUCTURE FORESTIERE|A|2|
|STRUCTURE EN MILIEU AGRO- NATUREL|ORGANISME LIEE A L ENVIRONNEMENT|A|3|
|PROPRIETAIRE RESEAU|CONCESSIONNAIRE AUTOROUTIER|R|1|
|PROPRIETAIRE RESEAU|SNCF/RFF OU AUTRE RESEAU FERRE|R|2|
|PROPRIETAIRE RESEAU|STRUCTURE AERIENNE|R|3|
|PROPRIETAIRE RESEAU|STRUCTURE FLUVIALE OU MARITIME|R|4|
|PROPRIETAIRE RESEAU|EDF/GDF|R|5|
|PROPRIETAIRE RESEAU|AUTRE PROPRIETAIRE DU RESEAU|R|0|
|PERSONNE MORALE|AUTRE PERSONNE MORALE|M|0|
|PERSONNE PHYSIQUE|PERSONNE PHYSIQUE|X|0|

Une correction a été effectuée pour la typologie M0 lorsqu'il a pu être trouvé, au niveau départemental, une typologie plus précise pour le même
propriétaire (variable _identite_ identique dans la table _acheteur_vendeur_).


## Utilisation

Si plusieurs catégories d'acheteurs ou de vendeurs différentes ont pu être identifiées lors d'une vente, leurs codes sont
associées par concaténation. Par exemple, si pour une mutation, un EPF et une commune sont identifiés comme les acheteurs, la variable _codtypproa_
pour cette mutation aura la valeur _F2P5_.

Ainsi, d'un point de vue SQL, pour repérer toutes les mutations qui concernent l'Etat, une condition de type _LIKE_ est à privilégier.
 
Exemple :
```sql
SELECT *
FROM dvf.mutation
-- condition pour déterminer toutes les mutations pour lesquelles l'Etat a pu être identifié comme acheteur
WHERE codtypproa LIKE '%P1%';
```
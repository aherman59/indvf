Titre: La disposition, une sous-partie de la mutation
Theme: OLD
Numero: 5
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 31/08/2016
Contact: dv3f@cerema.fr

## Définition d'une disposition dans DVF

### Définition

Une mutation est composée de une à plusieurs sous-parties, constituant chacune une unité d'analyse juridique,
qui sont appelées _dispositions_. 

Le montant de la transaction peut être réparti selon les différentes dispositions de la mutation. 
Seules les dispositions ayant un caractère onéreux sont référencées dans DVF. 

A noter qu'environ 98% des mutations ne présentent qu'une seule disposition dans DVF.

### Utilisation

La notion de disposition est purement juridique et il est conseillé de travailler plutôt au niveau de la mutation pour effectuer des analyses ou de l'évaluation de biens.

## Dispositions dans DVF+/DV3F

Dans DVF+/DV3F, chaque ligne de la table _disposition_ correspond à une disposition de DVF. Chaque disposition est identifiée par l'identifiant @@disposition|iddispo@@ et est rattachée à sa mutation par la variable @@disposition|idmutation@@.

La variable @@mutation|nbdispo@@ de la table _mutation_ permet de connaître le nombre de dispositions présentes dans la mutation.

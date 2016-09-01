Titre: Description du modèle DVF+
Theme: Base de données
Numero: 2
Auteurs: Antoine Herman - Cerema
MAJ: 01/09/2016
Contact: dv3f@cerema.fr

## Contexte

Les travaux autour de la création d’un modèle permettant de faciliter le passage des données DGFiP, « Demande
de valeurs foncières » (DVF), en base de données aisément exploitable s’inscrivent dans un processus qui a
débuté en 2011 à l’initiative d’un groupe technique lancé par l’ADEF, aujourd'hui devenu le Groupe National DVF (GnDVF). 

Ce groupe s’est réuni plusieurs fois et a associé, dès 2013, le CETE Nord-Picardie (aujourd’hui Direction Nord-Picardie du Cerema). Un modèle de données pour l’import des données natives de DVF a été produit et partagé collégialement par le groupe.

Depuis, le Cerema a travaillé, pour le compte de la DGALN, à étoffer ce modèle en y ajoutant de nouvelles
variables au sein d’un premier modèle, baptisé DVF+. 

Il propose, par ailleurs, des outils et scripts, libres d'utilisation, pour l'importation et la structuration de la donnée brute DVF dans une base de données PostgreSQL selon ce modèle.

## Tables constitutives du modèle

Le modèle DVF+ est composé de 12 tables dite principales ou secondaires et de 5 tables annexes.

Les 12 tables principales ou secondaires sont les suivantes : 

| Nom de la table | Description |
|-----------------|-------------|
|**mutation** |**Table des mutations**|
|mutation_art_cgi| Table des articles du code général des impôts attachés à la mutation|
|disposition| Table des dispositions|
|**disposition_parcelle**| **Table des parcelles attachées à la disposition**|
|parcelle| Table des parcelles|
|**local**| **Table des locaux**|
|suf| Table des subdivisions fiscales|
|volume| Table des volumes|
|lot| Table des lots|
|adresse| Table des adresses|
|adresse_dispoparc| Table de liaison entre la table adresse et la table disposition_parcelle|
|adresse_local| Table de liaison entre la table adresse et la table local|

Les tables _mutation_, _disposition_parcelle_ et _local_ sont considérées comme principales dans le 
sens où les données ont été recentrées sur celles-ci afin de faciliter l'utilisation
du modèle par des utilisateurs novices quant à l'exploitation des bases de données. 

Les 5 tables annexes sont décrites les suivantes : 

| Nom de la table | Description |
|-----------------|-------------|
|ann_nature_mutation| Table contenant les natures de mutation|
|ann_cgi| Table contenant les articles CGI|
|ann_type_local| Table contenant les types de locaux|
|ann_nature_culture| Table contenant les natures de culture|
|ann_nature_culture_speciale| Table contenant les natures de culture spéciales|

Un schéma simplifié du modèle est présenté ci-dessous :

![*Diagramme DVF+ simplifié*](ressources/diagramme_dvf_plus_simple.jpg "Diagramme DVF+ simplifié")


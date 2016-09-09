Titre: La mutation, une notion-clef
Theme: Tutoriel
Numero: 2
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 31/08/2016
Contact: dv3f@cerema.fr

## Définition et caractéristiques d'une mutation dans DVF

### Définition

Une mutation est une transaction permettant le passage de propriété d'un ou plusieurs biens entre un vendeur et un acheteur. Elle se matérialise par un acte notarié (le plus souvent, un acte de vente).
 
Dans DVF, seules les transactions onéreuses entre deux personnes ou structures différentes sont restituées. 
Les successions et les transferts de parts de société ne le sont pas. 

Une mutation, dans DVF, est caractérisée principalement par une **nature de transaction**, un **prix**, et une **date de mutation**
et peut être associée à un ou plusieurs **articles du Code Général des Impôts** (CGI).

Il est possible d'identifier une mutation dans DVF à partir du code du service de la publicité foncière qui a enregistré 
l'acte de vente et de la référence du document produite lors de cet enregistrement. 

### Nature de la mutation

Une mutation peut revêtir plusieurs natures :
 
* Vente d'un bien existant (vente classique)
* Vente d'un bien sur plan (vente en l'état futur d'achèvement - VEFA)
* Vente de terrain à bâtir (TAB)
* Adjudication (vente aux enchères),
* Echange (un bien contre un autre, ou un bien contre un autre et une somme d'argent), 
* Expropriation.  

### Prix de la mutation

Le prix ("valeur foncière" au sens de la DGFiP) de la mutation est le montant financier, à la date de la mutation, échangé
 entre le vendeur et l'acheteur pour permettre le transfert de propriété des biens. 
Ce prix est en euros. Il comprend la TVA mais pas les frais de notaires, ou les biens meubles. 
En matière d’expropriation, le prix indiqué comprend le montant de l’indemnité.

### Date de la mutation 

La date de mutation est le jour de la date de signature de l'acte notarié. 

### Articles CGI

La taxation d’une mutation est effectuée en partie sur la base d'un ou plusieurs articles du code général des impôts (CGI). Même si son but premier n’est pas l’analyse et l’observation, chaque article CGI renvoit des informations spécifiques sur l’acheteur ou le vendeur et/ou sur le(s) bien(s) muté(s), qui peuvent être très intéressantes. Par exemple, certains codes renseignent sur le fait qu'il s'agit de VEFA, ou signalent que l’acheteur est un organisme HLM.
  
Cette donnée est très fiable, mais elle est incomplète : 

* seuls 5 articles CGI peuvent être associés à une mutation dans DVF,
* certains codes CGI n’ont pas été remontés dans DVF (en particulier ceux sur le monde agricole, ou les codes CGI valables que ponctuellement).

Un travail d'exploitation des articles CGI a été mené par le GnDVF et permet une meilleure interprétation des articles CGI pour la ventilation des biens ayant muté (fiche 8 du Guide GnDVF).

## Mutations dans DVF+/DV3F 

Dans DVF+/DV3F, chaque ligne de la table _mutation_ correspond à une mutation de DVF. Chaque mutation est identifiée
par l'identifiant @@mutation|idmutation@@ (valeur entière) ou encore par l'identifiant @@mutation|idmutinvar@@, composé du code du service d'enregistrement (@@mutation|codservch@@)
et de la référence du document (@@mutation|refdoc@@) et permettant des comparaisons inter-bases.

Dans cette table _mutation_, on retrouve les variables liées à :

* la nature de la mutation : @@mutation|idnatmut@@, @@mutation|libnatmut@@ et @@mutation|vefa@@ ;
* le prix : @@mutation|valeurfonc@@ ;
* la date de la mutation : @@mutation|anneemut@@, @@mutation|moismut@@, @@mutation|datemut@@ ;
* les articles CGI : @@mutation|nbartcgi@@, @@mutation|l_artcgi@@.

La table annexe _ann_cgi_ décrit les différents articles CGI présents dans DVF.  
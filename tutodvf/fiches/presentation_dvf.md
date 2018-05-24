Titre: DVF en bref
Theme: OLD
Numero: 1
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 31/08/2016
Contact: dv3f@cerema.fr


## DVF pour Demande de Valeurs Foncières

« Demande de Valeurs Foncières », ou DVF, est une :

>> Offre de **service** de la Direction Générale des Finances Publiques (DGFiP) qui permet aux **ayants-droits** d’obtenir **gratuitement** les données présentant l’ensemble des **transactions immobilières** des **5 dernières années** relevant de leur **périmètre géographique**.

Ce service a été mis en place officiellement en 2011 à la suite de la modification de l'article L135B du Livre des Procédures Fiscales qui met à disposition des organismes ayants-droits, l’ensemble des valeurs foncières déclarées à l’occasion des mutations intervenues dans les 5 dernières années pour l’exercice de leurs compétences en matière de politique foncière, d’urbanisme et d’aménagement et de transparence des marchés fonciers et immobiliers.

![*Chronologie DVF*](ressources/chronologie_dvf.png "Chronologie DVF")

La mise à disposition gratuite des données sur les transactions immobilières s'inscrit dans une démarche d’ouverture et de transparence croissante de l’administration française au service d’une meilleure gestion des territoires.

## Périmètre géographique de DVF

En terme de périmètre géographique, DVF est disponible pour la **France métropolitaine**, hors Alsace et Moselle, **ainsi que les DROM**, excepté Mayotte.

![*Périmètre DVF*](ressources/perimetre_geographique_dvf.png "Périmètre DVF")
_<p style="text-align:right;">(source GnDVF)</p>_

## Constitution de DVF

### Des données issues de FIDJI et MAJIC

DVF est constituée à partir de 2 sources de données fiscales produites par la DGFiP. 

Le traitement DVF récupère, à la fois, des informations renseignées par les services de la publicité foncière dans la base de données FIDJI (Fichier Informatisé des Données Juridiques Immobilières) et des informations issues de la base de données MAJIC (Mise à Jour des Informations Cadastrales) pour produire des fichiers actualisés et accessibles aux ayants-droits à un rythme semestriel.

![*Sources DVF*](ressources/sources_constitution_dvf.png "Sources DVF")

### Une donnée brute en 43 champs

La donnée DVF livrée se présente sous la forme de fichiers textes, encodés en UTF-8, lisibles sous différentes éditeurs de textes ou tableurs. 

Les différentes lignes de ces fichiers sont composées de 43 champs séparées par le caractère "|". Elles décrivent tout ou partie des éléments d'information d'une transaction immobilière (ou mutation).

L'illustration ci-dessous présente un échantillon d'un fichier source DVF (les valeurs foncières ont été masquées):

![*Donnée brute DVF*](ressources/exemple_donnee_brute_dvf.png "Donnée brute DVF")

Les 43 champs présents dans DVF sont les suivants :

| Libellé | Exemple               |
|---------|-----------------------|
| **Code du service CH** |5914P01 |
| **Référence document** |2009P00999 |
| **1er Article CGI** |1594D*1 |
| **2e Article CGI** |257-7-1*2 |
| **3e Article CGI**| |
| **4e Article CGI**| |
| **5e Article CGI**| |
| **Numéro de disposition**| |
| **Date de mutation** |16/01/2010 |
| **Nature de mutation** | Vente |
| **Valeur foncière** | 200 000 € |
| **Numéro de voie** |01 |
| **B/T/Q** | T|
| **Type de voie** | Rue |
| **Code voie** | 4242 |
| **Voie** | Jean Jaures |
| **Code postal** | 59000 |
| **Commune** | LILLE |
| **Code du département** | 59 |
| **Code de la commune** | 350 |
| **Préfixe de section** | 298 |
| **Section** | AB |
| **Numéro de plan** | 100 |
| **Numéro de volume** | |
| **1er lot** | |
| **Surface Carrez 1er lot** | |
| **2e lot** | |
| **Surface Carrez 2e lot** | |
| **3e lot** | |
| **Surface Carrez 3e lot** | |
| **4e lot** | |
| **Surface Carrez 4e lot** | |
| **5e lot** | |
| **Surface Carrez 5e lot** | |
| **Nombre de lots** | |
| **Code du type de local** | 2 |
| **Type du local** | Maison |
| **Identifiant du local** | 999999 |
| **Surface réelle bâti** | 88 |
| **Nombre pièces princ** | 4 |
| **Nature de culture** | S |
| **Nature de culture spéc.** | |
| **Surface de terrain** | 140 |

## Atouts et Limites de DVF pour l'observation foncière et immobilière

### Atouts principaux

Les données DVF présentent plusieurs atouts. Elles sont :

* disponibles à une échelle nationale,
* gratuites,
* réputées exhaustives,
* globalement fiables,
* facilement géolocalisables.

### Limites principales

Les données DVF présentent toutefois quelques limites :

* Elles sont utilisables uniquement sur les 5 dernières années,
* Elles sont complexes à exploiter en l'état,
* Elles peuvent être difficilement intelligibles pour les novices,
* Elles n'ont pas vocation première à permettre l'observation foncière et les informations fournies apparaissent rapidement limitantes pour une analyse fine.

La mise en place de modèles de données tels que DVF+ et DV3F cherchent à repousser ces limites en proposant notamment une structuration et un enrichissement de la donnée source.


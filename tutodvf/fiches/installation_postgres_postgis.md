Titre: Installer PostgreSQL et PostGIS
Theme: Base de données
Numero: 1
Auteurs: Antoine Herman - Cerema
MAJ: 20/04/2016
Contact: dv3f@cerema.fr

## Déroulement de l'installation

Ce document s'adresse aux utilisateurs novices de PostgreSQL, le système de gestion de base de données (ou SGBD)
qui est utilisé pour DVF+ et DV3F, en décrivant les différentes étapes d'installation nécessaires.

## Installation de PostgreSQL

Pour installer une version 9.X de PostgreSQL, rendez-vous dans la rubrique [Download](http://www.postgresql.org/download/) du site officiel. 


### sous Windows :

 * Téléchargez le package d'installation proposé par EnterpriseDB de la version souhaitée et lancez le fichier exécutable. 
Une fenêtre d'accueil s'ouvre :

![*Etape 1 : Fenêtre d'accueil*](ressources/postgresql-1.png "Installation PostgreSQL")

 * Cliquez sur **"Suivant"**. La fenêtre de saisie du répertoire d'installation s'affiche :

![*Etape 2 : Fenêtre de saisie du répertoire d'installation*](ressources/postgresql-2.png "Installation PostgreSQL")

 * Laissez la valeur par défaut et cliquez sur **"Suivant"**. La fenêtre de saisie du répertoire qui accueillera les données s'affiche:

![*Etape 3 : Fenêtre de saisie du répertoire de données*](ressources/postgresql-3.png "Installation PostgreSQL")

 * Laissez la valeur par défaut et cliquez sur **"Suivant"**. La fenêtre de saisie du mot de passe s'affiche:

![*Etape 4 : Fenêtre de saisie du mot de passe*](ressources/postgresql-4.png "Installation PostgreSQL")

 * Saisissez et confirmer un mot de passe à retenir impérativement. Il sera, par la suite, **nécessaire à la connexion
 au SGBD en tant que super-utilisateur (compte "_postgres_").** La fenêtre de saisie du port d'écoute de PostgreSQL s'affiche:

![*Etape 5 : Fenêtre de saisie du port*](ressources/postgresql-5.png "Installation PostgreSQL")

 * Laissez la valeur par défaut (5432) et  cliquez sur **"Suivant"**. La fenêtre de paramètrage s'affiche: 

![*Etape 6 : Fenêtre de paramètrage de la locale*](ressources/postgresql-6.png "Installation PostgreSQL")

 * Sélectionnez **"French, France""** et cliquez sur **"Suivant"** pour lancer l'installation de l'application PostgreSQL. A l'issue de l'installation,
 une dernière fenêtre apparaît :

![*Etape 7 : Fenêtre de sortie*](ressources/postgresql-7.png "Installation PostgreSQL")

* Décochez la case à cocher et cliquez sur **"Terminer"**. Il faut maintenant installer l'extension spatiale Postgis.

### sous Debian / Ubuntu

Dans un terminal, saisissez les commandes suivantes :

```bash
sudo apt-get update
sudo apt-get install postgresql-9.5-postgis-2.2 pgadmin3 postgresql-contrib-9.5
```

La dernière commande installe également PostGIS. Vous pouvez donc directement passer à l'étape de création de la base de données.

## Installation de PostGIS

### Sous Windows :

 * Téléchargez le package d'installation dans la rubrique [Windows Downloads](http://postgis.net/windows_downloads/) du site officiel de PostGIS, en vérifiant
 que le package téléchargé correspond à votre version de PostgreSQL.
 
 * Lancez le fichier exécutable. Une fenêtre d'accueil s'ouvre :
 
 ![*Etape 1 : Fenêtre d'accueil*](ressources/postgis-1.png "Installation PostGIS")
 
 * Cliquez sur le bouton **"I agree"**. La fenêtre de sélection des composants s'affiche :
 
  ![*Etape 2 : Fenêtre de sélection des composants*](ressources/postgis-2.png "Installation PostGIS")
  
 * Cliquez sur **"Next"**. La fenêtre de saisie du répertoire d'installation s'affiche :
 
  ![*Etape 3 : Fenêtre de saisie du répertoire d'installation*](ressources/postgis-3.png "Installation PostGIS")
  
 * Saisissez le répertoire d'installation que vous aviez défini pour PostgreSQL et cliquez sur **"Next"** pour lancer l'installation. A l'issue de
 l'installation, une dernière fenêtre apparaît :
 
  ![*Etape 4 : Fenêtre de sortie*](ressources/postgis-4.png "Installation PostGIS")
  
  * Cliquez sur **"Close"**. L'extension PostGIS est maintenant installée.


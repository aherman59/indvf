Titre: Installer une base de données DV3F
Theme: Base de données
Numero: 3
Auteurs: Antoine Herman - Cerema
MAJ: 20/04/2016
Contact: dv3f@cerema.fr

## Déroulement de l'installation

La mise en place de DV3F nécessite plusieurs étapes :

 1. Installer PostgreSQL version 9.X (DV3F a été développé sous la version 9.3)
 2. Installer l'extension spatiale PostGIS version 2.X (DVF3 a été développé sous la version 2.1)
 3. Créer une base de données vide
 4. Importer le jeu de données fourni dans la base de données vide

Les étapes 1 et 2 sont détaillées dans la fiche @TUTO@installation_postgres_postgis|Installer PostgreSQL et PostGIS@TUTO@.

## Créer la base de données

Avant de pouvoir intégrer les données DV3F livrées, il faut créer une base de données vide.

### A partir de pgAdmin

 * Recherchez l'application pgAdmin (pour Windows, via le menu Démarrer / PostgreSQL / pgAdmin III) et lancez la. L'interface
permettant d'accéder à PostgreSQL apparaît. Dans l'arborescence de gauche, positionnez-vous sur l'item 'Bases de données' et cliquez avec
le bouton droit pour Sélectionnez 'Ajouter une base de données...'.

![*Interface pgAdmin : Ajout de la base de données*](ressources/pgadmin-0.png "pgAdmin")

 * Saississez le nom de la base de données qui accueillera DV3F dans le champ 'Nom' et cliquez sur 'OK'. 

 ![*Interface pgAdmin : Fenêtre de création de la base de données*](ressources/pgadmin-0bis.png "pgAdmin")

 * La base est désormais créée et apparait dans l'arborescence. Sélectionnez-la et cliquez sur l'icône 'SQL' active. 

![*Interface pgAdmin : icône SQL*](ressources/pgadmin-1.png "pgAdmin")

* Une nouvelle fenêtre s'ouvre permettant l'édition de requête SQL. Pour que la base de données puisse utiliser l'extension PostGIS nécessaire à
DV3F, saississez les requêtes SQL suivantes :

```sql
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
```

 * Exécutez les requêtes en cliquant sur l'icône représentant un triangle vert ou tapant 'F5'. 
 
 ![*Interface pgAdmin : Fenêtre SQL*](ressources/pgadmin-2.png "pgAdmin")
 
### A partir de psql

 * Dans une console (Windows ou Linux), saississez les commandes suivantes:
 
```bash
psql -h localhost -p 5432 -U postgres -c "CREATE DATABASE dv3f;"
psql -h localhost -p 5432 -U postgres -d dv3f -c "CREATE EXTENSION postgis; CREATE EXTENSION postgis_topology;"
```

## Import des données DV3F

Les données DV3F livrées sont contenues dans un (ou plusieurs) fichiers zip protégés.

Pour décompresser ces données, un fichier au format txt contenant le mot de passe de déverrouillage vous aura été transmis par ailleurs. 

### Dézipper le fichier livré

 * Décompresser le(s) fichier(s) zip à l'aide d'un utilitaire tel que _7zip_ ou _Peazip_. Lorsque le mot de passe vous sera demandé, collez
 celui contenu dans le fichier txt associé.
 
 * Placez les fichiers sql de sortie dans un même répertoire (par exemple, ci-après, ceux du département _01_ dans un répertoire _livraison/_)
 
  ![*Répertoire des données DV3F à importer*](ressources/integration-1.png "integration")

### Intégrer les données dans PostgreSQL

 * Placer vous dans une console au niveau du répertoire contenant les fichiers sql. Sous Windows, une possibilité est de cliquer droit 
sur votre fenêtre graphique en maintenant la touche 'Shift' puis de sélectionner 'Ouvrez une fenêtre de commande ici'.

 ![*Accès à la console depuis le répertoire*](ressources/integration-2.png "integration")
 
 * Une fois la console ouverte, saississez les commandes suivantes en adaptant les paramètrages et les noms de fichiers. Il est impératif de commencer
 par importer le fichier contenant le suffixe _initial_
 
```bash
psql -h localhost -p 5432 -U postgres -d dv3f -f livraison_dv3f_vbeta_initial.sql
psql -h localhost -p 5432 -U postgres -d dv3f -f livraison_dv3f_vbeta_dep01.sql
```
 * Retournez sous pgAdmin, sélectionnez votre base de données dans l'arborescence (cliquez droit pour 'Rafraîchir' si besoin) et vous devriez voir
apparaître les schémas comprenant les tables de données DV3F. 

 ![*Données DV3F intégrées dans la base de données*](ressources/integration-3.png "integration")

 

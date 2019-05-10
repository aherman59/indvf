Titre: Installer une base de données DVF+ à partir des données brutes DVF
Theme: Mise en place de DVF+/DV3F
Numero: 2
Auteurs: Antoine Herman - Cerema
MAJ: 01/09/2016
Contact: dv3f@cerema.fr


## Déroulement de l'installation

La mise en place de DVF+ nécessite plusieurs étapes :

 1. Installer PostgreSQL version 9.X 
 2. Installer l'extension spatiale PostGIS version 2.X
 3. Créer une base de données vide
 4. Utiliser le module d'import ImportDVF+ de AppDVF pour intégrer et structurer la donnée brute

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
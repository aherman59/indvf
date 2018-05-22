Titre: Cas pratiques pour caractériser une mutation à l'aide de la typologie de bien
Theme: Bien démarrer avec DV3F
Numero: 4 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 16/05/2018
Contact: dv3f@cerema.fr


[TOC]

## Cas pratique C1 : Caractériser des mutations à l'aide de la typologie de biens à partir de AppDVF

(à venir)

## Cas pratique C2 : Caractériser des mutations à l'aide de la typologie de biens dans PostgreSQL/PostGIS

### Trouver la catégorie d'une mutation

Pour connaître la catégorie de la mutation ayant l'identifiant idmutation 123456 :

```sql
SELECT codtypbien, libtypbien
FROM dvf.mutation 
WHERE idmutation = 123456; 
```

### Repérer toutes les mutations d'une même catégorie

Pour lister toutes les mutations de terrains viticoles dans le département de la Gironde (33) :

```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '33' 
	AND codtypbien = '2311'; 
```

Pour lister toutes les mutations d'un seul appartement dans le département de la Haute-Savoie (74) :

```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '74' 
	AND codtypbien LIKE '121%'; 
```

### Répartition des ventes sur un département selon la typologie

Pour dénombrer le nombre de ventes par catégorie dans le département du Nord (59) au niveau le plus fin existant :

```sql
SELECT codtypbien, libtypbien, count(*)
FROM dvf.mutation 
WHERE coddep = '59' 
GROUP BY codtypbien, libtypbien
ORDER BY codtypbien; 
``` 

Pour dénombrer le nombre de ventes par catégorie dans le département du Nord (59) au niveau 3 de la typologie :

```sql
SELECT substring(codtypbien, 1, 3) AS niveau_3, count(*)
FROM dvf.mutation 
WHERE coddep = '59' 
GROUP BY niveau_3
ORDER BY niveau_3;  
```

### Notion thématique associée

@TUTO@g4_caracteriser|La typologie de bien|la-typologie-de-bien@TUTO@


## Cas pratique C3 : Affiner la typologie de biens dans PostgreSQL/PostGIS

### Construire une nouvelle catégorie à partir de la typologie existante

Pour lister toutes les mutations d'un seul appartement T3 dans le département de la Haute-Savoie (74) :

```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '74' 
	AND codtypbien LIKE '121_3' ; 
```

### Affiner une catégorie de la typologie existante

Pour dénombrer le nombre de mutations d'une maison ancienne de plus de 2000 m2 de terrain dans le département du Nord (59) :

```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '59' 
	AND codtypbien = '1113'
	AND sterr >= 2000; 
```

### Notion thématique associée

@TUTO@g4_caracteriser|La typologie de bien|la-typologie-de-bien@TUTO@

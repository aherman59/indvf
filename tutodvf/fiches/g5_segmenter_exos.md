Titre: Cas pratiques pour observer les segments de marché
Theme: Bien démarrer avec DV3F
Numero: 5 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 16/05/2018
Contact: dv3f@cerema.fr


[TOC]

## Cas pratique O1 : Observer des segments à l'aide de AppDVF 

(à venir)

## Cas pratique O2 : Observer des segments dans PostgreSQL/PostGIS

### Exclure ou sélectionner certaines mutations 

Pour déterminer la surface moyenne du terrain d'une maison en excluant les maisons aux terrains atypiques dans le département du Nord (59) :

```sql
SELECT avg(sterr)
FROM dvf.mutation 
WHERE coddep = '59'
	AND codtypbien = '111%'
	AND (filtre NOT LIKE '%M%' OR filtre NOT LIKE '%1%') -- le filtre '5' est nécessairement inclus dans le '1'
	AND sterr > 0;
```

Pour pré-repérer les ventes de maisons destinées à la démolition pour de la construction dense dans le département du Nord (59) :

```sql
SELECT avg(sterr)
FROM dvf.mutation 
WHERE coddep = '59'
	AND codtypbien = '111%'
	AND devenir LIKE 'CD-O';
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

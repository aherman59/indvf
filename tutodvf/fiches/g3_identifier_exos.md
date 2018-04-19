Titre: Cas pratiques pour identifier les acheteurs et vendeurs
Theme: Bien démarrer avec DV3F
Numero: 3 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 19/04/2018
Contact: dv3f@cerema.fr



[TOC]


## Cas pratique I1 : Identifier les acheteurs et vendeurs dans PostgreSQL/PostGIS

### Rechercher à partir d'un nom

Pour rechercher des achats de la SCI Picsou sur le département du Nord (59) quand l'on connait parfaitement le nom présent dans DV3F :

```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '59' AND 'SCI PICSOU' = ANY(l_noma); -- mettre en majuscule

-- ou

SELECT *
FROM dvf.mutation 
WHERE coddep = '59' AND 'SCI PICSOU' = ANY(l_noma) AND fiabmaxa IS TRUE; -- pour s'assurer d'une fiabilité maximale
```

Pour rechercher des achats de la SCI Picsou sur le département du Nord (59) quand l'on connait approximativement le nom :

```sql
SELECT DISTINCT t1.*
FROM dvf.mutation t1
JOIN 
(
	SELECT idachvend
	FROM dvf.acheteur_vendeur
	WHERE ffnomprop LIKE '%SCI%PICSOU%' -- mettre en majuscule
) t2
ON t2.idachvend = ANY(t1.l_ida)
WHERE coddep = '59';
```

Pour rechercher, de manière plus exhaustive, les achats de la SCI Picsou sur le département du Nord (59) quand l'on connait approximativement le nom :

```sql
SELECT DISTINCT t1.*
FROM 
	dvf.mutation t1
JOIN (
		SELECT idachvend
		FROM dvf.acheteur_vendeur
		WHERE identite IN (
					SELECT identite
					FROM dvf.acheteur_vendeur
					WHERE ffnomprop LIKE '%SCI%PICSOU%')
		UNION
		
		SELECT idachvend
		FROM dvf.acheteur_vendeur
		WHERE ffnomprop LIKE '%SCI%PICSOU%' 
				AND identite IS NULL	
	) t2
ON t2.idachvend = ANY(t1.l_ida)
WHERE coddep = '59';
```

A noter que ce type de requêtes permet potentiellement de reconstituer les propriétés achetées par une personne morale. Il convient de les utiliser dans le respect de la legislation.

### Rechercher à partir d'un code SIREN

Pour rechercher les ventes de la SCI Picsou sur le département du Nord (59) lorsque l'on connait son numero SIREN (591234567890):

```sql
SELECT DISTINCT t1.*
FROM 
	dvf.mutation t1
JOIN (
		SELECT idachvend
		FROM dvf.acheteur_vendeur
		WHERE identite IN (
					SELECT identite
					FROM dvf.acheteur_vendeur
					WHERE ffsiren = '591234567890')
		UNION
		
		SELECT idachvend
		FROM dvf.acheteur_vendeur
		WHERE ffsiren = '591234567890' 
				AND identite IS NULL	
	) t2
ON t2.idachvend = ANY(t1.l_idv)
WHERE coddep = '59';
```

### Notion thématique associée

@TUTO@g3_identifier|Identifier les acheteurs et vendeurs|identifier-un-acheteur-ou-un-vendeur@TUTO@


## Cas Pratique I2 : Repérer les catégories d'acteurs

### Sélectionner les mutations pour une catégorie d'acteur

Pour lister les mutations, sur la période 2010-2015, dans lesquelles une commune est intervenue dans le département du Nord (59) :

```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '59'
	AND anneemut >= 2010 AND anneemut <= 2015 
	AND ((codtypprov LIKE '%P5%' AND fiabmaxv IS TRUE) 
		OR (codtypproa LIKE '%P5%' AND fiabmaxa IS TRUE)); --  si DROM ou Paris, prendre aussi P6
```

### Dénombrer les mutations par catégorie d'acheteur

Pour dénombrer les mutations pour chaque catégorie d'acheteur entre 2010 et 2015 sur le département du Nord (59) :

```sql
SELECT codtypproa, count(*) AS nb_achat
FROM dvf.mutation 
WHERE coddep = '59'
	AND anneemut >= 2010 AND anneemut <= 2015 
	AND fiabmaxa IS TRUE
GROUP BY codtypproa
ORDER BY nb_achat DESC; 
```

Pour dénombrer les logements vendus par un organisme de logement social à un particulier entre 2010 et 2015 sur le département du Nord (59) : 

```sql
SELECT sum(nblocmai + nblocapt) as nombre_de_logements
FROM dvf.mutation 
WHERE coddep = '59'
	AND anneemut >= 2010 AND anneemut <= 2015 
	AND codtypprov LIKE '%F1%' AND fiabmaxv IS TRUE
	AND codtypproa LIKE '%X0%' AND fiabmaxa IS TRUE; 
```


### Notion thématique associée

@TUTO@g3_identifier|Repérer les catégories d'acteurs|reperer-les-categories-dacteurs@TUTO@

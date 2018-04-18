Titre: Cas pratiques pour situer
Theme: Bien démarrer avec DV3F
Numero: 2 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 12/04/2018
Contact: dv3f@cerema.fr



[TOC]

## Cas pratique S1 : Choisir sa période temporelle à partir de AppDVF

(à venir)


## Cas pratique S2 : Choisir sa période temporelle dans PostgreSQL/PostGIS

### Période annuelle

Pour obtenir le nombre de mutations qui ont eu lieu sur le département du Nord (59) en 2013 :

```sql
SELECT count(*) as nombre_de_mutations_2013
FROM dvf.mutation 
WHERE coddep = '59' AND anneemut = 2013;
```

Pour obtenir les mutations sur le département du Nord (59) sur la période 2010-2015 :

```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '59' AND (anneemut >= 2010 AND anneemut <= 2015);
```

Pour obtenir le montant de transactions par année sur le département du Nord (59) :

```sql
SELECT anneemut, sum(valeurfonc) as montant_de_transactions
FROM dvf.mutation 
WHERE coddep = '59'
GROUP BY anneemut
ORDER BY anneemut;
```

### Autre période temporelle

Pour lister les mutations sur le département du Nord (59) entre le 9 avril 2014 et le 8 mai 2014 :
```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '59' AND (datemut >= '2014-04-09' AND datemut <= '2014-05-08');
```

Pour obtenir le nombre et le montant de transactions par trimestre sur le département du Nord (59) :

```sql
SELECT anneemut || ' ' || trimestremut AS trimestre,
		 count(*) as nombre_de_mutations, 
		sum(valeurfonc) as montant_de_transactions
FROM 
(	
	SELECT *,
		   CASE 
				WHEN moismut IN (1, 2, 3) THEN 'Trimestre 1'
				WHEN moismut IN (4, 5, 6) THEN 'Trimestre 2'
				WHEN moismut IN (7, 8, 9) THEN 'Trimestre 3'
				WHEN moismut IN (10, 11, 12) THEN 'Trimestre 4'
		   END AS trimestremut
	FROM dvf.mutation 
	WHERE coddep = '59'
)t
GROUP BY anneemut, trimestremut
ORDER BY anneemut, trimestremut;
```

### Notion thématique associée

@TUTO@g2_situer|Situer dans le temps|situer-dans-le-temps@TUTO@
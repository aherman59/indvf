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


## Cas pratique S3 : Situer les mutations à partir de AppDVF

### Via GeoDV3F

(à venir)

### Via QGis - ExportDVF

(à venir)

## Cas pratique S4 : Situer les mutations dans PostgreSQL/PostGIS

### Trouver une mutation à partir d'une adresse

Pour récupérer les mutations qui concernent le boulevard Victor Hugo à Lille (code insee : 59350) :

```sql
SELECT DISTINCT * 
FROM dvf.mutation
WHERE coddep = '59' AND idmutation IN (
	SELECT idmutation FROM dvf.local WHERE coddep ='59' AND ffcodinsee = '59350' AND ffvoie LIKE '%BD%VICTOR%HUGO'	
	UNION 
	SELECT idmutation FROM dvf.disposition_parcelle WHERE coddep ='59'  AND ffcodinsee = '59350' AND ffvoie LIKE '%BD%VICTOR%HUGO' 
	);
```

### Retrouver les adresses associées à une mutation

Pour récupérer les adresses correspondant à la mutation dont l'identifiant est 123456:

```
SELECT DISTINCT COALESCE(ffnovoie::VARCHAR, '') || 
		COALESCE(ffbtq, '') || ' ' || 
		COALESCE(ffvoie, '') || ' ' || 
		COALESCE(ffcommune, '') AS adresse
FROM dvf.local WHERE idmutation = 123456	

UNION 

SELECT DISTINCT COALESCE(ffnovoie::VARCHAR, '') || 
		COALESCE(ffbtq, '') || ' ' || 
		COALESCE(ffvoie, '') || ' ' || 
		COALESCE(ffcommune, '') AS adresse
FROM dvf.disposition_parcelle WHERE idmutation = 123456	 
```

Pour récupérer les adresses présentes dans la source DVF correspondant à la mutation dont l'identifiant est 123456:

```
SELECT COALESCE(novoie::VARCHAR, '') || 
		COALESCE(btq, '') || ' ' || 
		COALESCE(typvoie, '') || ' ' || 
		COALESCE(voie, '') || ' ' || 
		COALESCE(codepostal, '') || ' ' || 
		COALESCE(commune, '') AS adresse
FROM dvf.adresse a
JOIN
(
	SELECT idadresse AS idadresse FROM dvf.adresse_dispoparc WHERE idmutation = 123456
	UNION
	SELECT idadresse FROM dvf.adresse_local WHERE idmutation = 123456
) t
ON a.idadresse = t.idadresse;
```

### Retrouver les mutations présentes dans un périmètre géographique déterminé

(à venir)

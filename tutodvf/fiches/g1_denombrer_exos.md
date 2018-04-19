Titre: Cas pratiques pour dénombrer
Theme: Bien démarrer avec DV3F
Numero: 1 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 12/04/2018
Contact: dv3f@cerema.fr



[TOC]

## Cas pratique D1 : Dénombrer les mutations à partir de AppDVF

(à venir)


## Cas pratique D2 : Dénombrer les mutations dans PostgreSQL/PostGIS

### Dénombrer sur un département

Pour obtenir le nombre de mutations qui ont eu lieu sur le département du Nord (59) :

```sql
SELECT count(*) as nombre_de_mutations
FROM dvf.mutation 
WHERE coddep = '59';
```

### Dénombrer sur une ou plusieurs communes

Pour obtenir le nombre de mutations qui concernent la commune de Lille (code insee : 59350) :

```sql
SELECT count(*) as nombre_de_mutations
FROM dvf.mutation
-- il est préférable de préciser le coddep pour réduire le temps de réponse 
WHERE coddep = '59' AND '59350' = ANY(l_codinsee);
```

Pour obtenir le nombre de mutations qui concernent exclusivement la commune de Lille (code insee : 59350) :

```sql
SELECT count(*) as nombre_de_mutations
FROM dvf.mutation
-- il est préférable de préciser le coddep pour réduire le temps de réponse 
WHERE coddep = '59' AND nbcomm = 1 AND l_codinsee[1] = '59350';
```

Pour obtenir le nombre de mutations qui concernent 2 communes (Lille - code insee : 59350 et Villeneuve d'Ascq - code insee : 59009) :

```sql
SELECT count(*) as nombre_de_mutations
FROM dvf.mutation
-- il est préférable de préciser le coddep pour réduire le temps de réponse 
WHERE coddep = '59' AND  l_codinsee && ARRAY['59350', '59009']::VARCHAR[];
```

### Notion thématique associée

@TUTO@g1_denombrer|Dénombrer les mutations|denombrer-les-mutations@TUTO@



## Cas pratique D3 : Dénombrer les locaux à partir de AppDVF
(à venir)

## Cas pratique D4 : Dénombrer les locaux dans PostgreSQL/PostGIS

### Dénombrer sur un département

Pour obtenir le nombre de locaux ayant muté sur le département du Nord (59) :

```sql
-- via la table mutation
SELECT sum(nblocmut) as nombre_de_locaux
FROM dvf.mutation 
WHERE coddep = '59';

-- via la table local (mode avancé)
SELECT count(*) as nombre_de_locaux
FROM
(
	SELECT DISTINCT idmutation, idloc
	FROM dvf.local
	WHERE coddep = '59'
)t;
```

### Dénombrer sur une commune


Pour obtenir le nombre de locaux mutés dont les mutations concernent exclusivement la commune de Lille (code insee : 59350) :

```sql
SELECT sum(nblocmut) as nombre_de_locaux
FROM dvf.mutation
-- il est préférable de préciser le coddep pour réduire le temps de réponse 
WHERE coddep = '59' AND nbcomm = 1 AND l_codinsee[1] = '59350';
```

Dans le cas précédent, les mutations concernant 2 ou plusieurs communes dont Lille sont exclues. Pour obtenir le nombre de locaux ayant muté sur la commune de Lille (code insee : 59350) sans prendre en compte les locaux des autres communes :

```sql
SELECT count(*)
FROM 
(
	SELECT DISTINCT idmutation, idloc
	FROM dvf.local
	WHERE substring(idpar, 1, 5) = '59350'
)t;
```

### Dénombrer selon la forme physique du local

Pour obtenir la répartition des locaux ayant muté selon leur forme physique sur le département du Nord (59) :

```sql
-- via la table mutation
SELECT 
	sum(nblocmut) as nombre_de_locaux,
	sum(nblocmai) as nombre_de_maisons,
	sum(nblocapt) as nombre_d_appartements,
	sum(nblocmai + nblocapt) as nombre_de_logements,
	sum(nblocdep) as nombre_de_dependance,
	sum(nblocact) as nombre_de_locaux_activites,
	sum(ffnbactsec) as nombre_d_activites_secondaires,
	sum(ffnbactter) as nombre_d_activites_tertiaires
FROM dvf.mutation 
WHERE coddep = '59';

-- via la table local (mode avancé)
SELECT 
	count(*) as nombre_de_locaux,
	sum(CASE WHEN codtyploc = 1 THEN 1 ELSE 0 END) AS nombre_de_maisons,
	sum(CASE WHEN codtyploc = 2 THEN 1 ELSE 0 END) as nombre_d_appartements,
	sum(CASE WHEN codtyploc IN (1, 2) THEN 1 ELSE 0 END) as nombre_de_logements,
	sum(CASE WHEN codtyploc = 3 THEN 1 ELSE 0 END) as nombre_de_dependance,
	sum(CASE WHEN codtyploc = 4 THEN 1 ELSE 0 END) as nombre_de_locaux_activites,
	sum(CASE WHEN ffctyploc = '4' AND ffcnatloc IN ('U', 'US', 'UN', 'UE', 'UG') THEN 1 ELSE 0 END) as nombre_d_activites_secondaires,
	sum(CASE WHEN ffctyploc = '4' AND ffcnatloc IN ('CA', 'CM', 'CB', 'CH', 'ME', 'SM') THEN 1 ELSE 0 END) as nombre_d_activites_tertiaires
FROM
(
	SELECT DISTINCT ON (idmutation, idloc) *
	FROM dvf.local
	WHERE coddep = '59'
)t;
```

### Dénombrer les appartements de moins de 3 pièces principales

Pour obtenir le nombre d'appartements de moins de 3 pièces principales (strictement) ayant muté sur le département du Nord (59) :

```sql
-- via la table mutation
SELECT sum(nbapt1pp + nbapt2pp) as nombre_appartement_moins_de_3_pieces
FROM dvf.mutation
WHERE coddep = '59';

-- via la table local
SELECT 
	count(*) AS nombre_appartement_moins_de_3_pieces
FROM
(
	SELECT DISTINCT ON (idmutation, idloc) *
	FROM dvf.local
	WHERE coddep = '59'
)t
WHERE codtyploc = 2 AND nbpprinc IN (0, 1, 2);
```


### Dénombrer les appartements T3 anciens

Pour obtenir le nombre d'appartements anciens de type T3 ayant muté sur le département du Nord (59) :

```sql
SELECT 
	count(*) AS nombre_T3_ancien
FROM
(
	SELECT DISTINCT ON (idmutation, idloc) *
	FROM dvf.local
	WHERE coddep = '59'
)t
WHERE codtyploc = 2 AND nbpprinc = 3 AND anciennete = 'ancien';
```

### Dénombrer les mutations d'un local déterminé

Pour lister toutes les mutations qui concernent le local ayant l'identifiant 595400649993 :

```sql
SELECT *
FROM dvf.mutation
WHERE coddep='59' AND '595400649993' = ANY(l_idlocmut);
```

Pour compter toutes les mutations qui concernent le local ayant l'identifiant 595400649993 :

```sql
SELECT count(*)
FROM dvf.mutation
WHERE coddep='59' AND '595400649993' = ANY(l_idlocmut);
```

### Notion thématique associée

@TUTO@g1_denombrer|Dénombrer les locaux|denombrer-les-locaux@TUTO@


## Cas pratique D5 : Dénombrer les parcelles à partir de AppDVF
(à venir)

## Cas pratique D6 : Dénombrer les parcelles dans PostgreSQL/PostGIS

### Dénombrer sur un département

Pour obtenir le nombre de parcelles ayant muté sur le département du Nord (59) :

```sql
-- via la table mutation
SELECT sum(nbparmut) as nombre_de_parcelles_mutees
FROM dvf.mutation 
WHERE coddep = '59';

-- via la table disposition_parcelle (mode avancé)
SELECT count(*) as nombre_de_parcelles_mutees
FROM
(
	SELECT DISTINCT idmutation, idpar
	FROM dvf.disposition_parcelle
	WHERE coddep = '59' AND parcvendue IS TRUE
)t;
```

Pour obtenir le nombre de parcelles concernées par une mutation sur le département du Nord (59) :

```sql
-- via la table mutation
SELECT sum(nbpar) as nombre_de_parcelles_concernees
FROM dvf.mutation 
WHERE coddep = '59';

-- via la table disposition_parcelle (mode avancé)
SELECT count(*) as nombre_de_parcelles_concernees
FROM
(
	SELECT DISTINCT idmutation, idpar
	FROM dvf.disposition_parcelle
	WHERE coddep = '59'
)t;
```

### Dénombrer sur une commune

Pour obtenir le nombre de parcelles mutées dont les mutations concernent exclusivement la commune de Lille (code insee : 59350) :

```sql
SELECT sum(nbparmut) AS nombre_de_parcelles_mutees
FROM dvf.mutation
-- il est préférable de préciser le coddep pour réduire le temps de réponse 
WHERE coddep = '59' AND nbcomm = 1 AND l_codinsee[1] = '59350';
```

Pour obtenir le nombre de parcelles mutées sur la commune de Lille (code insee : 59350) :

```sql
SELECT count(*) AS nombre_de_parcelles_mutees
FROM 
(
	SELECT DISTINCT idmutation, idpar
	FROM dvf.disposition_parcelle
	WHERE coddep || codcomm = '59350' AND parcvendue IS TRUE
)t;
```

### Dénombrer les mutations qui concernent une parcelle déterminée

Pour lister toutes les mutations qui concernent la parcelle ayant l'identifiant 59183540AL0328 :

```sql
SELECT *
FROM dvf.mutation
WHERE coddep='59' AND '59183540AL0328' = ANY(l_idpar);
```

Pour compter toutes les mutations qui concernent la parcelle ayant l'identifiant 59183540AL0328 :

```sql
SELECT count(*)
FROM dvf.mutation
WHERE coddep='59' AND '59183540AL0328' = ANY(l_idpar);

### Notion thématique associée

@TUTO@g1_denombrer|Dénombrer les parcelles|denombrer-les-parcelles@TUTO@
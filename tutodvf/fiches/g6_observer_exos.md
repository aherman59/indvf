Titre: Cas pratiques pour observer les segments de marché
Theme: Bien démarrer avec DV3F
Numero: 6 
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
SELECT *
FROM dvf.mutation 
WHERE coddep = '59'
	AND codtypbien = '111%'
	AND devenir LIKE 'CD-O';
```

### Construire un segment de marché 

Pour lister les ventes de logement de particulier à particulier (en vue d'analyser les prix) en 2014 dans le département du Nord (59):

```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '59'
	AND anneemut = 2014
	AND (codtypbien LIKE '11%' OR codtypbien LIKE '12%')
	AND filtre = '0'
	AND devenir = 'S'
	AND codtypprov = 'X0' AND codtypproa = 'X0';
```

Une piste pour repérer les ventes de terrains nus pour la construction de logements sociaux en 2012 dans le département du Nord (59):

```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '59'
	AND anneemut = 2012
	AND codtypbien LIKE '2%'
	AND (filtre = 'S' OR filtre = 'HS') -- ventes à 0 ou 1 euro retenues
```

### Utiliser les segments prêts à l'emploi

Pour lister des ventes de terrains nus à bâtir (en vue d'analyser les prix) dans le département du Nord (59):

```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '59'
	AND codtypbien LIKE '2%'
	AND (segmtab > 2) -- on impose un critère restrictif de sélection des TAB
	AND filtre = '0'
```

Pour lister des ventes de terrains nus naturels, agricoles ou forestiers (en vue d'analyser les prix) dans le département du Nord (59):

```sql
SELECT *
FROM dvf.mutation 
WHERE coddep = '59'
	AND codtypbien LIKE '2%'
	AND segmtab IS NULL -- on exclut un maximum de terrain pré-supposés TAB
	AND filtre = '0'
```

### Notion thématique associée

@TUTO@g5_segmenter|La segmentation de marché dans DV3F|la-segmentation-de-marche-dans-dv3f@TUTO@


## Cas pratique O3 : Analyse des prix à l'aide de AppDVF 

(à venir)

## Cas pratique O4 : Analyse des prix dans PostgreSQL/PostGIS

### Définir une fonction médiane (pour version PostgreSQL inférieur à 9.4):

Depuis la version 9.4 de PostgreSQL, une fonction, permettant notamment le calcul de la médiane, est disponible : percentile_disc

Cette fonction reste complexe. Il est vous est proposé trois fonctions ci-dessous qui peuvent être utilisées à la place de percentile_disc ou pour les versions antérieures à la 9.4. Ces fonctions (dvf.mediane, dvf.premier_quartile et dvf.dernier_quartile) sont à créer une seule fois (pour la base de données) puis reste utilisable par la suite. 

Nota : Ces fonctions doivent être présentes pour l'utilisation du module InDVF.  


```sql
CREATE OR REPLACE FUNCTION dvf.centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$  
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;

CREATE OR REPLACE FUNCTION dvf.mediane_0(anyarray)
  RETURNS anyelement AS
$BODY$  
  SELECT dvf.centile($1, 50);
$BODY$
  LANGUAGE sql;
  
CREATE OR REPLACE FUNCTION dvf.premier_quartile_0(anyarray)
  RETURNS anyelement AS
$BODY$  
  SELECT dvf.centile($1, 25);
$BODY$
  LANGUAGE sql;
  
CREATE OR REPLACE FUNCTION dvf.dernier_quartile_0(anyarray)
  RETURNS anyelement AS
$BODY$  
  SELECT dvf.centile($1, 75);
$BODY$
  LANGUAGE sql;

DROP AGGREGATE IF EXISTS dvf.mediane(NUMERIC);
CREATE aggregate dvf.mediane(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = dvf.mediane_0
);

DROP AGGREGATE IF EXISTS dvf. premier_quartile(NUMERIC);
CREATE aggregate dvf.premier_quartile(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = dvf.premier_quartile_0
);

DROP AGGREGATE IF EXISTS dvf.dernier_quartile(NUMERIC);
CREATE aggregate dvf.dernier_quartile(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = dvf.dernier_quartile_0
);
```

### Travailler en prix constant

Si l'on souhaite travailler en euros constants, il est également possible d'ajouter un champ _valeurfonc_euro_cst_ qui permet 
de corriger directement chacune des valeurs foncières par rapport à l'année de référence souhaitée.

Par exemple, pour ramener les valeurs des mutations par rapport à l'année 2010:

```sql
 SELECT 
	*,
	-- valeur foncière en euros constants 2010
	CASE
		WHEN anneemut = 2005 THEN round(valeurfonc/0.928, 2)
        WHEN anneemut = 2006 THEN round(valeurfonc/0.943, 2)
        WHEN anneemut = 2007 THEN round(valeurfonc/0.957, 2)
        WHEN anneemut = 2008 THEN round(valeurfonc/0.984, 2)
        WHEN anneemut = 2009 THEN round(valeurfonc/0.985, 2)
        WHEN anneemut = 2010 THEN round(valeurfonc/1, 2)
        WHEN anneemut = 2011 THEN round(valeurfonc/1.021, 2)
        WHEN anneemut = 2012 THEN round(valeurfonc/1.041, 2)
        WHEN anneemut = 2013 THEN round(valeurfonc/1.050, 2)
        WHEN anneemut = 2014 THEN round(valeurfonc/1.056, 2)
		ELSE valeurfonc
	END AS valeurfonc_euro_cst	
 FROM dvf.mutation;
``` 

### Déterminer un prix médian 

Pour déterminer le prix médian d'une maison vendue par un promoteur en 2014 dans le département du Nord (59):

```sql
SELECT count(*) AS nombre_de_ventes, dvf.mediane(valeurfonc) as prix_median
FROM dvf.mutation 
WHERE coddep = '59'
	AND anneemut = 2014
	AND codtypbien LIKE '111%'
	AND filtre = '0'
	AND devenir = 'S'
	AND (codtypprov LIKE '%F6%' OR rolev = 'Op');
```

Pour déterminer le prix au m2 médian d'un appartement ancien T3 en 2014 dans le département du Nord (59):

```sql
SELECT count(*) AS nombre_de_ventes, round(dvf.mediane(valeurfonc/sbati), 2) as prix_median
FROM dvf.mutation 
WHERE coddep = '59'
	AND anneemut = 2014
	AND codtypbien = '12133'
	AND filtre = '0'
	AND devenir = 'S'
	AND sbati > 0;
```

Pour déterminer le prix au m2 médian de terrains nus viticoles dans le département de la Gironde (33) entre 2012 et 2014 :

```sql
SELECT count(*) AS nombre_de_ventes, round(dvf.mediane(valeurfonc/sterr), 2) as prix_median
FROM dvf.mutation 
WHERE coddep = '33'
	AND anneemut > 2011 AND anneemut < 2015
	AND codtypbien = '2311'
	AND segmtab IS NULL -- on exclut un maximum de terrain pré-supposés TAB
	AND filtre = '0'
	AND sterr > 0;
```

Pour déterminer le prix au m2 médian d'un terrain à bâtir vendu entre particulier pour de la construction 'diffuse' entre 2012 et 2014 dans le département du Loiret (45):

```sql
SELECT count(*) AS nombre_de_ventes, round(dvf.mediane(valeurfonc/sterr), 2) as prix_median
FROM dvf.mutation 
WHERE coddep = '45'
	AND anneemut > 2011 AND anneemut < 2015
	AND codtypbien LIKE '2%'
	AND segmtab > 2 
	AND filtre = '0'
	AND devenir LIKE 'C-D%'
	AND codtypprov = 'X0' AND codtypproa = 'X0';
	AND sterr > 0;
```

### Notion thématique associée

@TUTO@g6_calculer|Calculer un prix de marché|calculer-un-prix-de-marche@TUTO@

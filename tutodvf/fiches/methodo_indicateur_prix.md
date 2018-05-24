Titre: Construire des indicateurs de prix à partir de DVF+
Theme: OLD
Numero: 4
Auteurs: Antoine Herman, Magali Journet - Cerema
MAJ: 27/04/2016
Contact: dv3f@cerema.fr

## Objectif

L'objectif est de produire un indicateur de prix à une échelle communale ou supra-communale 
en utilisant une segmentation ou une typologie préalablement établie.

Pour la suite, la [typologie des biens proposée par le GnDVF](http://guide-dvf.fr/utiliser-dvf/typologie-biens) sera 
utilisée dans les exemples. 

## Usage

* Produire une analyse sur les prix 
* Créer des cartographies
* Créer des tableaux de bord 

## Préalable

* Avoir accès à une base de données construite sur 
le [modèle DVF+](http://www.nord-picardie.cerema.fr/facilitez-vous-l-integration-des-donnees-demande-a972.html).   
* Avoir produit un champ décrivant une segmentation ou une typologie (cf [Construire la typologie de bien du GnDVF à partir de DVF+](methodo_typo_gndvf.html)) 

## Construction SQL

### Ajout d'une typologie

Une vue ou une table _dvf.typologie_bien_ est préalablement créée à partir de la table _dvf.mutation_ 
en y ajoutant un champ _libtypbien_ correspondant à une typologie définie.

Dans notre cas, la typologie GnDVF est utilisée :

```sql
DROP VIEW IF EXISTS dvf.typologie_bien;
CREATE VIEW dvf.typologie_bien AS(
	 SELECT 
		-- variables DVF+
		*,
		-- typologie biens GnDVF
		CASE
			WHEN libnatmut = 'Echange' THEN ...
			/*
			Intégrer ici le bloc de requête présentée 
			  dans la fiche 'Construire la typologie de bien du GnDVF à partir de DVF+'	
			*/ 
			...
			ELSE 'NON DETERMINE'
		END	AS libtypbien
	 FROM dvf.mutation
);
```

### Travail en euros constants

Si l'on souhaite travailler en euros constants, il est également possible d'ajouter un champ _valeurfonc_euro_cst_ qui permet 
de corriger directement chacune des valeurs foncières par rapport à l'année de référence souhaitée.

Par exemple, pour ramener les valeurs des mutations par rapport à l'année 2010:

```sql
DROP VIEW IF EXISTS dvf.typologie_bien;
CREATE VIEW dvf.typologie_bien AS(
	 SELECT 
		-- variables DVF+
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
		END AS valeurfonc_euro_cst,
		-- typologie biens GnDVF
		CASE
			WHEN libnatmut = 'Echange' THEN ...
			/*
			Intégrer ici le bloc de requête présentée 
			  dans la fiche 'Construire la typologie de bien du GnDVF à partir de DVF+'	
			*/ 
			...
			ELSE 'NON DETERMINE'
		END	AS libtypbien
	 FROM dvf.mutation
);
``` 

### Création d'une fonction médiane

La fonction permettant de renvoyer une médiane, très utile en analyse de prix, n'existe pas dans les versions de PostgreSQL antérieures à la 9.4.
 
Par conséquent, il faut d'abord définir plusieurs fonctions dans le schéma _dvf_.
  

```sql
CREATE OR REPLACE FUNCTION dvf.centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$
  /*
   Retourne le n-ième centile des valeurs du tableau (trié ou non)

   exemples : 
    SELECT dvf.centile(ARRAY[10,20,30,40,50], 50)
    >> 30

    SELECT dvf.centile(ARRAY[21,20,100,70,49,13,52,60], 10)
    >> 13
  */
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;
  
CREATE OR REPLACE FUNCTION dvf.mediane_0(anyarray)
  RETURNS anyelement AS
$BODY$
  /*
   Retourne la médiane des valeurs du tableau (trié ou non)

   exemple : 
    SELECT dvf.mediane_0(ARRAY[10,40,30,20,50])
    >> 30
  */
  SELECT dvf.centile($1, 50);
$BODY$
  LANGUAGE sql;
  
DROP AGGREGATE IF EXISTS dvf.mediane(NUMERIC);
CREATE aggregate dvf.mediane(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = dvf.mediane_0
);

CREATE OR REPLACE FUNCTION dvf.mediane_centree_10(anyarray NUMERIC[])
  RETURNS NUMERIC AS
$BODY$
/*
   Retourne la médiane des valeurs du tableau (trié ou non) contenues dans un intervalle centré
   Ici le centile exterieur est defini à 10 ce qui exclut les 10 % de valeurs les plus hautes et les 10 % de valeurs plus basses.

   exemple : 
    SELECT dvf.mediane_centree_10(ARRAY[10,50,3,47,29,49,12,78,85.5,0,1,0,1,1,0]);
    >> 10
  */
    DECLARE 
        array_sans_deciles NUMERIC[];
        borne_inf numeric;
        borne_sup numeric;
	centile_ext INTEGER;
    BEGIN
	centile_ext := 10;
        borne_inf := dvf.centile(anyarray, centile_ext);
        borne_sup := dvf.centile(anyarray, 99 - centile_ext);
        FOR i IN 1..array_upper(anyarray,1)
        LOOP
            IF anyarray[i] >= borne_inf AND anyarray[i] <= borne_sup THEN array_sans_deciles :=  array_sans_deciles || anyarray[i]; END IF;        
        END LOOP;
        RETURN dvf.centile(array_sans_deciles, 50);
    END;
$BODY$
  LANGUAGE plpgsql;

DROP AGGREGATE IF EXISTS dvf.mediane_10(NUMERIC);
CREATE aggregate dvf.mediane_10(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = dvf.mediane_centree_10
);	
```

Il est désormais possible d'utiliser les fonctions _dvf.mediane_ et _dvf.mediane_10_ comme des 
fonctions d'aggrégat classiques (_sum_, _avg_, _count_, etc.).

La fonction  _dvf.mediane_ calculera la médiane.

La fonction  _dvf.mediane_10_ exclura les 10 % de valeurs les plus hautes et les 10 % de valeurs les plus basses avant de calculer la médiane.

### Exemples de calcul d'une moyenne de prix à l'échelle communale

La requête suivante renvoie le prix moyen (en euros) d'un bien de type 'maison' à l'échelle de la commune de Lille (_code Insee : 59350_) :

```sql
SELECT round(avg(valeurfonc), 2) as prix_moyen_maison -- valeur arrondie à 2 décimales
FROM dvf.typologie_bien
WHERE libtypbien = 'BATI - MAISON' AND '59350' = ANY(l_codinsee);				
```

Pour travailler en euros constants, il suffit de remplacer _valeurfonc_ par _valeurfonc_euro_cst_ :
```sql
SELECT round(avg(valeurfonc_euro_cst), 2) as prix_moyen_maison -- valeur arrondie à 2 décimales
FROM dvf.typologie_bien
WHERE libtypbien = 'BATI - MAISON' AND '59350' = ANY(l_codinsee);				
```

### Exemples de calcul d'une médiane de prix

#### A l'échelle communale

La requête suivante renvoie ainsi le prix médian (en euros) d'un bien de type 'appartement' à l'échelle de la commune de Lille (_code Insee : 59350_) :

```sql
SELECT round(dvf.mediane(valeurfonc), 2) as prix_median_appartement -- valeur arrondie à 2 décimales
FROM dvf.typologie_bien
WHERE libtypbien = 'BATI - APPART' AND '59350' = ANY(l_codinsee);				
```

#### A l'échelle de plusieurs communes

La requête suivante renvoie le prix médian (en euros par m2) par année d'un bien de type 'appartement' à l'échelle des communes de Lille (_59350_), Villeneuve d'Ascq (_59009_),
Ronchin (_59507_), Lambersart (_59328_):

```sql
SELECT anneemut, round(dvf.mediane(valeurfonc/sbati), 2) as prix_median_m2_appartement
FROM dvf.typologie_bien
WHERE libtypbien = 'BATI - APPART' AND ARRAY['59350', '59009', '59507', '59328']::VARCHAR[] && l_codinsee
GROUP BY anneemut
ORDER BY anneemut; 
```

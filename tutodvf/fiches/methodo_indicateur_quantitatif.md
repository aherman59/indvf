Titre: Construire des indicateurs quantitatifs simples à partir de DVF+
Theme: Méthode
Numero: 3
Auteurs: Antoine Herman - Cerema
MAJ: 17/10/2016
Contact: dv3f@cerema.fr

## Objectif

L'objectif est de produire des indicateurs simples pour connaître le nombre de mutations
ou le volume de transaction à une échelle communale ou supra-communale 
en utilisant une segmentation ou une typologie préalablement établie.

Pour la suite, la [typologie des biens proposée par le GnDVF](http://guide-dvf.fr/utiliser-dvf/typologie-biens) sera 
utilisée dans les exemples. 

## Usage

* Produire une analyse quantitative 
* Créer des cartographies
* Créer des tableaux de bord 

## Préalable

* Avoir accès à une base de données construite sur le modèle DVF+ ou DV3F.   
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

### Exemples de décomptes de mutations

#### A l'échelle départementale

Pour obtenir le nombre de mutations qui ont eu lieu sur le département du Nord (59) entre 2011 et 2014 :

```sql
SELECT count(*) as nombre_de_mutations
FROM dvf.typologie_bien 
WHERE coddep = '59' AND anneemut >= 2011 AND anneemut <= 2014;
```

Pour obtenir le nombre de mutations de type 'Echange', par année, sur le département du Nord (59):

```sql
SELECT anneemut, count(*) as nombre_echanges_par_an
FROM dvf.typologie_bien 
WHERE coddep = '59' AND libnatmut = 'Echange'
GROUP BY anneemut
ORDER BY anneemut;
```

Pour obtenir le nombre de mutations, par année et pour chaque département, présent dans la base de données.
```sql
SELECT coddep, anneemut, count(*) as nombre_de_mutations_par_an_et_dept
FROM dvf.typologie_bien
GROUP BY coddep, anneemut
ORDER BY coddep, anneemut;
```

#### A l'échelle communale

Pour obtenir le nombre de mutations qui concernent la commune de Lille (_code Insee : 59350_) entre 2011 et 2014 :

```sql
SELECT count(*) as nombre_de_mutations
FROM dvf.typologie_bien 
WHERE '59350'=ANY(l_codinsee) AND anneemut >= 2011 AND anneemut <= 2014;
```

Pour obtenir le nombre de ventes d'un appartement (avec dépendances éventuelles), sur la commune de Lille, par année :

```sql
SELECT anneemut, count(*) as nombre_ventes_appart_par_an
FROM dvf.typologie_bien 
WHERE ARRAY['59350']::VARCHAR[] = l_codinsee 
	AND libnatmut = 'Vente' 
	AND nblocmut = nblocapt + nblocdep
	AND nblocapt = 1
	AND nbparmut = 0
GROUP BY anneemut
ORDER BY anneemut;

-- En utilisant la typologie de bien, les résultats seront très proches
SELECT anneemut, count(*) as nombre_de_mutations
FROM dvf.typologie_bien
WHERE libtypbien = 'BATI - APPART' 	AND ARRAY['59350']::VARCHAR[] = l_codinsee 
GROUP BY anneemut
ORDER BY anneemut;
```

### Exemple de calcul de volume de transactions

Pour obtenir le montant global des transactions sur le département du Nord (59) entre 2011 et 2014 :

```sql
SELECT sum(valeurfonc) as montant_transaction_total
FROM dvf.typologie_bien 
WHERE coddep = '59' AND anneemut >= 2011 AND anneemut <= 2014;

-- en format texte pour un affichage plus lisible
SELECT to_char(sum(valeurfonc), '9 999 999 999 999.99') as volume_transaction
FROM dvf.typologie_bien 
WHERE coddep = '59' AND anneemut >= 2011 AND anneemut <= 2014;
```

Pour obtenir le montant, par an, des ventes de foncier non bâti sur le département du Nord (59) :

```sql
SELECT anneemut, to_char(sum(valeurfonc), '9 999 999 999 999.99') as montant_vente_non_bati
FROM dvf.mutation 
WHERE coddep = '59' 
	AND nblocmut = 0 
	AND nbvolmut = 0
	AND libnatmut IN ('Vente', 'Vente terrain à bâtir')
	AND vefa IS FALSE
GROUP BY anneemut
ORDER BY anneemut;

-- En utilisant la typologie de bien, les résultats seront similaires
SELECT anneemut, to_char(sum(valeurfonc), '9 999 999 999 999.99') as montant_vente_non_bati
FROM dvf.mutation 
WHERE coddep = '59' AND libtypbien LIKE 'NON BATI -%'
GROUP BY anneemut
ORDER BY anneemut;
```
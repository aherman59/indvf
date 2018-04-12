Titre: Cas pratiques pour dénombrer
Theme: Bien démarrer avec DV3F
Numero: 1 
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 12/04/2018
Contact: dv3f@cerema.fr



## Cas pratique 1 : Dénombrer les mutations à partir de AppDVF

(à venir)


## Cas pratique 2 : Dénombrer les mutations dans PostgreSQL/PostGIS

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



## Cas pratique 3 : Dénombrer les parcelles


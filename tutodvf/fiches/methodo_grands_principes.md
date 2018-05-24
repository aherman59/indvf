Titre: Tout ce que vous allez oublier d'appliquer pour utiliser correctement DV3F
Theme: OLD
Numero: 1
Auteurs: Magali Journet, Antoine Herman - Cerema
MAJ: 17/10/2016
Contact: dv3f@cerema.fr

## Sur la valeur foncière

### La maison qui valait 3 milliards...

Il y a manifestement quelques valeurs foncières anormalement hautes qui sont associées à des mutations dans DVF+/DV3F. Elles sont très rares mais peuvent poser des problèmes pour l'analyse des prix.

Une rapide vérification sur la base de données peut permettre de s'en assurer et éventuellement d'exclure les mutations qui présentent des prix anormaux :

```sql
SELECT * FROM dvf.mutation ORDER BY valeurfonc DESC LIMIT 10;
```

### Prix soldés ne veulent pas toujours dire bonnes affaires!

DVF fournit les mutations de nature "Echange". Pour celles-ci, la valeur foncière fournie représente la différence de prix entre les biens échangés et non le prix des biens en eux-même. Il est donc préférable de les exclure pour l'analyse des prix.

```sql
-- Mutations hormis celle de nature "Echange"
SELECT * FROM dvf.mutation WHERE libnatmut != 'Echange';
```

Plus généralement, les prix dans DVF sont parfois à des valeurs nulles ou très faibles. Plusieurs raisons peuvent expliquer ces prix atypiques : vente à l'euro symbolique, vente dégrèvée des coûts de dépollution, vente entre filiales d'un même groupe, etc. Pour l’analyse des prix, il est donc important d’avoir un regard critique sur les données et d’enlever si nécessaire les valeurs faibles.

```sql
-- Mutations hormis celles ayant une valeur foncière de 0 ou 1 euro
SELECT * FROM dvf.mutation WHERE valeurfonc NOT IN(0, 1);

-- Mutations hormis celles ayant une valeur foncière inférieure à un seuil de 5000 euros
SELECT * FROM dvf.mutation WHERE valeurfonc > 5000;
```

### Bien nettoyer la surface avant application

Il est fréquent de vouloir restituer le prix sous la forme d'un montant rapporté à une surface ou un local:

* surface de terrain (€/m² de surface terrain) pour le non bâti,
* surface de construction (€/m² de surface totale, ou habitée, etc.) pour les appartements,
* local (€/local) pour les maisons ou les mutations avec plusieurs locaux.

Il est important, dans ce cas, de vérifier que le diviseur est non nul et correctement rempli pour l'échantillon en question. Il convient également de s'assurer que cette condition ne réduit pas significativement la population de l'échantillon avec le risque que le résultat ne perde du sens.

## Sur l'exhaustivité des données

### A chaque observation, sa période!

Il est important de bien définir les limites temporelles pour le type d'observation que l'on souhaite réaliser. En particulier, lorque l'on effectue des analyses quantitatives (nombre de mutations ou volume de transactions, par exemple), il faut éviter de regarder l'évolution sur les derniers trimestres du fait des temps de latence liés à l'enregistrement des actes de vente et à leurs appartitions dans DVF.

Autre exemple, si l'on travaille sur les jeux d'acteurs dans DV3F, que l'on souhaite une bonne fiabilité et un taux de remplissage optimum sur les acheteurs/vendeurs, il sera préférable de travailler sur la période couverte par les Fichiers fonciers.

Pour définir facilement sa période, la condition peut-être la suivante :
```sql
-- Pour une analyse sur la période 2010-2014
SELECT * FROM dvf.mutation WHERE anneemut >= 2010 AND anneemut <= 2014;
```

### VEFA indéterminées, terrain miné...

Les Ventes en l'état futur d'achèvement (VEFA) manquent fréquemment d'exhaustivité sur le nombre et l'identité des locaux vendus. Pour toute analyse quantitative, il est donc important de se rappeler que le nombre de locaux en VEFA est fortement sous-estimé.

Par ailleurs, il est possible qu’un local ne soit pas classer en VEFA alors que sa date de construction est postérieure à la date de mutation :

```sql
-- Mutations non classées en VEFA pour lesquelles tous les locaux ont été construits a posteriori
SELECT * FROM dvf.mutation WHERE anneemut < ffancstmin AND vefa IS FALSE;

-- Mutations non classées en VEFA pour lesquelles au moins 1 local a été construit a posteriori
SELECT DISTINCT m.* 
FROM dvf.mutation m 
JOIN dvf.local l 
On m.idmutation = l.idmutation 
WHERE l.anneemut < l.ffancst AND m.vefa IS FALSE
```

Pour ces situations, il est possible soit d'effectuer un redressement, soit de considérer ces cas comme des biais. 

## Sur la Dualité DVF / Fichiers fonciers

DV3F importe de nombreuses données des Fichiers fonciers. Les variables importées des Fichiers fonciers commencent pour certaines par «ff» pour mettre en évidence ce caractère «exogène» sinon, cela est précisé dans leurs définitions. Comme les Fichiers fonciers correspondent à des stocks (par exemple, nombre de locaux au 1er janvier d’une année) et DVF à un flux (par exemple, nombre de locaux vendus durant une année), il est difficile d’importer toutes les données, et il est possible que des incohérences apparaissent. 

### Le reflexe "rapatff"

Lorsque l'on souhaite travailler à partir de données rapatriées directement des Fichiers fonciers ou qui utilisent à la fois DVF et les Fichiers fonciers (comme l'ancienneté), @@mutation|rapatffloc@@ et @@mutation|rapatffpar@@ sont très utiles pour s'assurer que l'échantillon de mutations que l'on sélectionne le permet :

```sql
-- Mutations pour lesquels les informations des Fichiers fonciers liées aux parcelles sont présentes.
SELECT * FROM dvf.mutation WHERE rapatffpar IS TRUE;

-- Mutations pour lesquels les informations des Fichiers fonciers liées aux locaux sont présentes.
SELECT * FROM dvf.mutation WHERE rapatffloc IS TRUE
```

### DVF et Fichiers fonciers, à mélanger avec modération

Si l'on a la possibilité d’utiliser des variables aux définitions identiques provenant de DVF et des Fichiers fonciers, il est possible que celles-ci divergent. A priori, à définition équivalente, les données provenant de DVF doivent être considérées comme plus fiables que les données importées des Fichiers fonciers. Mais très souvent, la combinaison avec d'autres données Fichiers fonciers permettent des analyses plus fines. Dans ce cas, il est conseillé de travailler uniquement avec des données provenant des Fichiers fonciers. 

A titre d'exemple, si l'on veut observer le nombre d'appartements T2, la variable @@mutation|nbapt2pp@@ suffit mais si l'on veut avoir les appartements T2 neufs il vaut mieux utiliser @@mutation|ffnblocapt@@, @@mutation|ffnbloc2pp@@ et @@mutation|nblocneuf@@.

### Gagner un maximum de confiance

Globalement, les informations acheteurs et vendeurs, rapatriées des Fichiers fonciers, sont de bonne qualité. 

Pour des analyses des données davantage fiabilisées sur les propriétaires (acheteur ou vendeur), il est possible de vérifier que le degré de fiabilité des données correspondantes est maximal. @@mutation|fiabmaxv@@ et @@mutation|fiabmaxa@@ sont très utiles pour s'en assurer au niveau de la table mutation :

```sql
-- Mutations pour lesquels les informations des Fichiers fonciers liées aux vendeurs ont une bonne fiabilité.
SELECT * FROM dvf.mutation WHERE fiabmaxv IS TRUE;

-- Mutations pour lesquels les informations des Fichiers fonciers liées aux acheteurs ont une bonne fiabilité.
SELECT * FROM dvf.mutation WHERE fiabmaxa IS TRUE;
```

Cependant, il subsistera toujours un risque d'erreur.
 
## Plus généralement

### Les typologies peuvent vous sauver la vie!

Quel que soit l'analyse effectuée, il faut garder à l'esprit que des typologies et des segmentations ont été intégrées dans la base de données pour catégoriser assez rapidement les mutations, les biens ou les propriétaires. Elles ne répondent pas à tous les besoins mais elles limitent les principaux écueils décrits ci-dessus lors de l'utilisation de DVF+/DV3F. Elles peuvent faciliter le travail pour des besoins d'analyse rapide de certains segments de marché ou vous conforter dans la construction de vos propres méthodes d'analyse. 

### DocDV3F, votre nouveau livre de chevet

Dans DV3F, il est souvent facile de trouver ce que l’on veut observer mais il faut bien connaître les définitions des variables pour ne pas se méprendre. Le logement, par exemple : pour DV3F, c’est une maison ou un appartement quelle que soit son occupation (même une activité). Ce n’est pas la même définition que dans une base comme Filocom (logement occupé par de l’habitation). 

La première chose à effectuer en utilisant DV3F est donc de vérifier dans la documentation quelle est la définition de la variable, ses biais et ses précautions d’usage. 

Il est aussi important de rappeler que ce sont des données fiscales avec un but différent de l’observation ou de l’évaluation. Toute donnée utilisée comportera donc toujours un biais. 

De plus, l'expérience dans l'utilisation de ces données est encore balbutiante. Il est donc important de toujours garder un regard critique sur les résultats obtenus, et si possible de les comparer avec des données terrains ou d’autres données. Enfin, les fiches méthodes ont aussi été créées pour montrer pas à pas certaines façons d’utiliser DV3F.  

Il est possible de nous contacter par mail à [dv3f@cerema.fr](mailto:dv3f@cerema.fr) pour tout problème, suggestion, ou proposition d'amélioration. 


 


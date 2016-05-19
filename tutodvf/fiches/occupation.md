Titre: Description de la variable occupation
Theme: Variable
Numero: 3
Auteurs: Antoine Herman, Magali Journet - Cerema
MAJ: 10/05/2016
Contact: dv3f@cerema.fr

## Principe

La variable _occupation_ vise à proposer une typologie simplifiée de nature d'occupation basée sur les 
données d'occupation présentes dans DVF (c'est à dire les natures de culture, recomposées dans DV3F selon les subdivisions fiscales).

L'occupation est regroupée selon six catégories : Agricole, Naturel, Forestier, Urbain, Transport et Carrière et Loisir. 

## Codification de la typologie d'occupation

| Code | Type d'occupation  | Mode de détermination                                                      |
|------|--------------------|----------------------------------------------------------------------------|
| TC   | Transport/Carrière | il existe des subdivisions fiscales de type Carrières ou Chemin de fer  |
| UR   | Urbain             | non TC et il existe des subdivisions fiscales de type TAB ou Sol     |
| AG   | Agricole           | ni TC, ni UR et les surfaces de subdivisions fiscales de type Terre, Pré, Vigne et Verger sont dominantes |
| FO   | Forestier          | ni TC, ni UR et les surfaces de subdivisions fiscales de type Bois sont dominantes |
| LO   | Loisir             | ni TC, ni UR et les surfaces de subdivisions fiscales de type Jardin et Terrain d'agrément sont dominantes |
| NA   | Naturel            | ne valident aucune des conditions précédentes

## Pour aller plus loin...

L'occupation dans DV3F, issue des données fiscales, peut présenter des soucis de réactualisation
et, par conséquent, s'éloigner de la réalité. Pour une meilleure fiabilité, il peut être intéressant d'utiliser
d'autres sources de données telles qu'un mode d'occupation du sol (MOS), un plan local d'urbanisme (PLU), etc. 							 |
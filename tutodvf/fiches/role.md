Titre: Description de la variable role
Theme: Variable
Numero: 4
Auteurs: Antoine Herman, Magali Journet - Cerema
MAJ: 09/05/2016
Contact: dv3f@cerema.f

## Principe des rôles

En complément de la [typologie des propriétaires](codtyppro.html), les données DVF et Fichiers fonciers peuvent permettre de repérer
des modes d'intervention sur les marchés fonciers et immobiliers qui pourraient s'apparenter à des catégories d'acteurs spécifiques.

Dans cet objectif, les variables _rolev_ et _rolea_ présentes dans la table _mutation_ visent à préciser, pour chaque mutation, 
les "rôles" qu'ont joué le vendeur et l'acheteur.

## Codification des rôles

| Rôle dans la mutation | Code | Méthode de détermination |
|---------------------|-----|----------------------------------------------------------|
| Organisme aménageur | Oa | vendeur : l'une des parcelles vendues est apparue sous le vendeur ; acheteur : l'une des parcelles vendues est disparue sous l'acheteur |
| Organisme de réhabilitation | Or | vendeur : le code CGI '1594FQB' est présent pour la mutation |
| Organisme de promotion | Op | vendeur : il s'agit d'une mutation de type VEFA ou d'une vente d'un local neuf apparu sous le vendeur  |
| Organisme de logement social | Os | vendeur : le code CGI '296-1-a-*2' ou '296-1-b-*2' est présent pour la mutation; acheteur : le code CGI '1594H' est présent pour la mutation |
| SAFER| On | acheteur : le code CGI '1594FQG' est présent pour la mutation |
| Structure agricole ou agriculteur | Na | acheteur : le code CGI '1594FQE','1594FQE I','1594FQE II' ou '1594FQD' est présent pour la mutation |
| Structure forestière | Nf | acheteur : le code CGI '1137' est présent pour la mutation |

Pour une mutation, un acheteur ou un vendeur ne se voit attribuer au plus qu'un seul rôle. Même si elle reste très marginale, une priorisation
a été établie pour des propriétaires qui endossent plusieurs rôles : en premier Or puis Os, Op, On, Oa, Na, Nf.  

## Dénombrement des rôles

Si un acheteur ou un vendeur apparaît dans plusieurs mutations avec des rôles similaires, il devient possible de faire ressortir 
ses activités qui viendront ou non corroborer les informations issues de la typologie des propriétaires.  

Dans la table _acheteur_vendeur_, les rôles joués par chaque propriétaire sont comptabilisés dans les variables _nbroleoa_, _nbroleor_, 
_nbroleop_, _nbroleos_, _nbroleon_, _nbrolena_ et _nbrolenf_.

Par exemple, un propriétaire dont la valeur de _nbrolep_ est 10 correspond à un propriétaire identifié en tant qu'organisme promoteur 
dans 10 mutations. Il est donc très vraisemblable que ce propriétaire ait une activité de promoteur.

Pour aller plus loin dans le dénombrement et avoir une vision plus large des rôles joués par un acteur, il est possible aussi de sommer ces décomptes
en regroupant selon la variable _identite_.
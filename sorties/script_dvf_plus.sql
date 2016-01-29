---
-- SCRIPT DE CREATION DU MODELE DVF+ 
-- ETAPE 2/2
-- 
-- Auteur: 
--    CEREMA "PCI Foncier et Stratégies Foncières"
--    Direction Territoriale Nord-Picardie
--    Antoine HERMAN
--    Jérôme DOUCHE
--
-- Ce script est fourni sous licence Creative Commons 3.0 CC-BY-SA
--
-- Début d'exécution le 29/01/2016 à 21:39:20
---DROP TABLE IF EXISTS dvf.local_plus CASCADE;

-- table dvf.local_plus
CREATE TABLE dvf.local_plus
(
iddispoloc serial,
iddispopar integer,
idpar varchar(14),
idmutation integer,
idloc varchar(12),
identloc varchar(7),
codtyploc integer,
libtyploc varchar(254),
nbpprinc integer,
sbati numeric,
coddep varchar(3),
datemut Date,
anneemut integer,
moismut integer,
nbmutjour integer,
nbmutannee integer,
datemutpre Date,
l_idmutpre integer[],
datemutsui Date,
l_idmutsui integer[]   
);

COMMENT ON TABLE dvf.local_plus IS 'table des locaux';

COMMENT ON COLUMN dvf.local_plus.idloc IS 'identifiant du local (Fichier Fonciers)';

COMMENT ON COLUMN dvf.local_plus.libtyploc IS 'libellé du type de local';

COMMENT ON COLUMN dvf.local_plus.sbati IS 'surface réelle attachée à l''identifiant local';

COMMENT ON COLUMN dvf.local_plus.nbpprinc IS 'nombre de pièces principales';

COMMENT ON COLUMN dvf.local_plus.datemutpre IS 'date de la précédente mutation du local';

COMMENT ON COLUMN dvf.local_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.local_plus.iddispoloc IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.local_plus.datemutsui IS 'date de la mutation suivante du local';

COMMENT ON COLUMN dvf.local_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf.local_plus.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf.local_plus.l_idmutpre IS 'identifiants des mutations précédentes du local ayant eu lieu à la date de mutation précédente (datemutpre)';

COMMENT ON COLUMN dvf.local_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf.local_plus.codtyploc IS 'code du type de local';

COMMENT ON COLUMN dvf.local_plus.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf.local_plus.nbmutjour IS 'nombre de mutations du local au cours de la journée';

COMMENT ON COLUMN dvf.local_plus.identloc IS 'identifiant du local';

COMMENT ON COLUMN dvf.local_plus.l_idmutsui IS 'identifiants des mutations suivantes du local ayant eu lieu à la date de mutation suivante (datemutsui)';

COMMENT ON COLUMN dvf.local_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf.local_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf.local_plus.nbmutannee IS 'nombre de mutations du local au cours de l''année calendaire';

DROP TABLE IF EXISTS dvf.disposition_parcelle_plus CASCADE;

-- table dvf.disposition_parcelle_plus
CREATE TABLE dvf.disposition_parcelle_plus
(
iddispopar serial,
iddispo integer,
idparcelle integer,
idmutation integer,
idpar varchar(14),
coddep varchar(3),
codcomm varchar(3),
prefsect varchar(3),
nosect varchar(2),
noplan varchar(4),
datemut Date,
anneemut integer,
moismut integer,
parcvendue boolean,
nbmutjour integer,
nbmutannee integer,
datemutpre Date,
l_idmutpre integer[],
datemutsui Date,
l_idmutsui integer[],
dcnt01 numeric,
dcnt02 numeric,
dcnt03 numeric,
dcnt04 numeric,
dcnt05 numeric,
dcnt06 numeric,
dcnt07 numeric,
dcnt08 numeric,
dcnt09 numeric,
dcnt10 numeric,
dcnt11 numeric,
dcnt12 numeric,
dcnt13 numeric,
dcntsol numeric,
dcntagri numeric,
dcntnat numeric   
);

COMMENT ON TABLE dvf.disposition_parcelle_plus IS 'table des parcelles attachées à une disposition';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt12 IS 'surface de suf de type 12 ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt01 IS 'surface de suf de type 01 ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt04 IS 'surface de suf de type 04 ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcntsol IS 'surface de suf de type sol ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.idparcelle IS 'identifiant de la table parcelle';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.datemutsui IS 'date de la mutation suivante de la parcelle (date postérieure)';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt11 IS 'surface de suf de type 11 ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.noplan IS 'numéro de la parcelle';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt02 IS 'surface de suf de type 02  ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.nbmutjour IS 'nombre de mutations de la parcelle au cours de la journée';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.codcomm IS 'code insee de la commune';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt06 IS 'surface de suf de type 06 ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.parcvendue IS 'Vrai si la parcelle fait partie de la vente';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt07 IS 'surface de suf de type 07 ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.nbmutannee IS 'nombre de mutations de la parcelle au cours de l''année calendaire';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt13 IS 'surface de suf de type 13 ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcntnat IS 'surface de suf de type naturel ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.prefsect IS 'prefixe de section de la parcelle';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.l_idmutsui IS 'identifiants des mutations suivantes de la parcelle ayant eu lieu à la date de mutation suivante (datemutsui)';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt10 IS 'surface de suf de type 10 ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.datemutpre IS 'date de la précédente mutation de la parcelle (date antérieure)';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt09 IS 'surface de suf de type 09 ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.nosect IS 'numéro de section de la parcelle';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.iddispopar IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.l_idmutpre IS 'identifiants des mutations précédentes de la parcelle ayant eu lieu à la date de mutation précédente (datemutpre)';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.iddispo IS 'identifiant de la table disposition';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcntagri IS 'surface de suf de type agricole ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt03 IS 'surface de suf de type 03 ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt08 IS 'surface de suf de type 08 ayant muté';

COMMENT ON COLUMN dvf.disposition_parcelle_plus.dcnt05 IS 'surface de suf de type 05 ayant muté';

DROP TABLE IF EXISTS dvf.mutation_plus CASCADE;

-- table dvf.mutation_plus
CREATE TABLE dvf.mutation_plus
(
idmutation serial,
idmutinvar varchar(18),
idnatmut integer,
codservch varchar(7),
refdoc varchar(10),
datemut Date,
anneemut integer,
moismut integer,
coddep varchar(3),
libnatmut varchar(45),
nbartcgi integer,
l_artcgi varchar[],
vefa boolean,
valeurfonc numeric,
nbdispo integer,
nblot integer,
nbcomm integer,
l_codinsee varchar[],
nbsection integer,
l_section varchar[],
nbpar integer,
l_idpar varchar[],
nbparmut integer,
l_idparmut varchar[],
nbsuf integer,
sterr numeric,
l_dcnt numeric[],
nbvolmut integer,
nblocmut integer,
l_idlocmut varchar[],
nblocmai integer,
nblocapt integer,
nblocdep integer,
nblocact integer,
nbapt1pp integer,
nbapt2pp integer,
nbapt3pp integer,
nbapt4pp integer,
nbapt5pp integer,
nbmai1pp integer,
nbmai2pp integer,
nbmai3pp integer,
nbmai4pp integer,
nbmai5pp integer,
sbati numeric,
sbatmai numeric,
sbatapt numeric,
sbatact numeric,
sapt1pp numeric,
sapt2pp numeric,
sapt3pp numeric,
sapt4pp numeric,
sapt5pp numeric,
smai1pp numeric,
smai2pp numeric,
smai3pp numeric,
smai4pp numeric,
smai5pp numeric   
);

COMMENT ON TABLE dvf.mutation_plus IS 'table des mutations';

COMMENT ON COLUMN dvf.mutation_plus.l_idpar IS 'liste des identifiants de parcelles concernées par la mutation (idpar)';

COMMENT ON COLUMN dvf.mutation_plus.nblocdep IS 'nombre de dépendances ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nblocmai IS 'nombre de maisons ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.valeurfonc IS 'prix ou évaluation déclarée dans le cadre d''une mutation onéreuse';

COMMENT ON COLUMN dvf.mutation_plus.vefa IS 'vrai si la mutation est une Vente en l''état futur d''achèvement (VEFA)';

COMMENT ON COLUMN dvf.mutation_plus.l_dcnt IS 'Liste ordonnée des surfaces de suf de 01 à 13';

COMMENT ON COLUMN dvf.mutation_plus.l_section IS 'liste des sections concernées par la mutation';

COMMENT ON COLUMN dvf.mutation_plus.nbsection IS 'nombre de sections concernées par la mutation';

COMMENT ON COLUMN dvf.mutation_plus.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf.mutation_plus.l_idlocmut IS 'liste des identifiants de locaux ayant muté (idloc)';

COMMENT ON COLUMN dvf.mutation_plus.sbati IS 'surface de l''ensemble du bâti ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbvolmut IS 'nombre de volumes ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf.mutation_plus.nbparmut IS 'nombre de parcelles ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.refdoc IS 'référence d''enregistrement du document (acte de vente)';

COMMENT ON COLUMN dvf.mutation_plus.sapt1pp IS 'surface de l''ensemble des appartements avec 1 pièce principale ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.smai3pp IS 'surface de l''ensemble des maisons avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nblocact IS 'nombre de locaux d''activités ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbapt2pp IS 'nombre d''appartements avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.mutation_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf.mutation_plus.nbapt5pp IS 'nombre d''appartements avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.smai5pp IS 'surface de l''ensemble des maisons avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.sapt5pp IS 'surface de l''ensemble des appartements avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf.mutation_plus.nbdispo IS 'nombre de dispositions associées à la mutation';

COMMENT ON COLUMN dvf.mutation_plus.sbatact IS 'surface de l''ensemble du bâti d’activité ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.smai2pp IS 'surface de l''ensemble des maisons avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbpar IS 'nombre de parcelles concernées par la mutation';

COMMENT ON COLUMN dvf.mutation_plus.sterr IS 'surface de terrain ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbsuf IS 'nombre de subdivisions fiscales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.sapt2pp IS 'surface de l''ensemble des appartements avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbmai4pp IS 'nombre de maisons avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.sbatmai IS 'surface de l''ensemble des maisons ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbapt1pp IS 'nombre d''appartements avec une pièce principale ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbcomm IS 'nombre de communes concernées par la mutation';

COMMENT ON COLUMN dvf.mutation_plus.sapt3pp IS 'surface de l''ensemble des appartements avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.l_artcgi IS 'liste des codes d’articles CGI (Code Général des Impôts) associés à la mutation';

COMMENT ON COLUMN dvf.mutation_plus.libnatmut IS 'libellé de la nature de mutation';

COMMENT ON COLUMN dvf.mutation_plus.nbmai1pp IS 'nombre de maisons avec une pièce principale ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbapt3pp IS 'nombre d''appartements avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbmai5pp IS 'nombre de maisons avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.codservch IS 'code du service de conservation des hypothèques';

COMMENT ON COLUMN dvf.mutation_plus.sbatapt IS 'surface de l''ensemble des appartements ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbmai2pp IS 'nombre de maisons avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbapt4pp IS 'nombre d''appartements avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nblocmut IS 'nombre de locaux ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.l_codinsee IS 'liste des codes INSEE des communes concernées par la mutation';

COMMENT ON COLUMN dvf.mutation_plus.nbartcgi IS 'nombre d''articles du Code Général des Impôts (CGI) associés à la mutation';

COMMENT ON COLUMN dvf.mutation_plus.smai4pp IS 'surface de l''ensemble des maisons avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nblot IS 'nombre total de lots dans la mutation';

COMMENT ON COLUMN dvf.mutation_plus.l_idparmut IS 'liste des identifiants de parcelles ayant muté (idpar)';

COMMENT ON COLUMN dvf.mutation_plus.nblocapt IS 'nombre d''appartements ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.idmutinvar IS 'identifiant invariant de la mutation';

COMMENT ON COLUMN dvf.mutation_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf.mutation_plus.sapt4pp IS 'surface de l''ensemble des appartements avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.nbmai3pp IS 'nombre de maisons avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf.mutation_plus.smai1pp IS 'surface de l''ensemble des maisons avec 1 pièce principale ayant muté';

DROP TABLE IF EXISTS dvf_d62.local_plus CASCADE;

-- table fille dvf_d62.local_plus
CREATE TABLE dvf_d62.local_plus
(   
)INHERITS (dvf.local_plus);        

ALTER TABLE dvf_d62.local_plus 
ADD CONSTRAINT local_plus_pkey PRIMARY KEY (iddispoloc);

ALTER TABLE dvf_d62.local_plus 
ADD CONSTRAINT local_plus_unique UNIQUE (iddispopar, identloc);

ALTER TABLE dvf_d62.local_plus 
ADD CONSTRAINT local_plus_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.local_plus IS 'table des locaux';

COMMENT ON COLUMN dvf_d62.local_plus.idloc IS 'identifiant du local (Fichier Fonciers)';

COMMENT ON COLUMN dvf_d62.local_plus.libtyploc IS 'libellé du type de local';

COMMENT ON COLUMN dvf_d62.local_plus.sbati IS 'surface réelle attachée à l''identifiant local';

COMMENT ON COLUMN dvf_d62.local_plus.nbpprinc IS 'nombre de pièces principales';

COMMENT ON COLUMN dvf_d62.local_plus.datemutpre IS 'date de la précédente mutation du local';

COMMENT ON COLUMN dvf_d62.local_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.local_plus.iddispoloc IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.local_plus.datemutsui IS 'date de la mutation suivante du local';

COMMENT ON COLUMN dvf_d62.local_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.local_plus.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.local_plus.l_idmutpre IS 'identifiants des mutations précédentes du local ayant eu lieu à la date de mutation précédente (datemutpre)';

COMMENT ON COLUMN dvf_d62.local_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d62.local_plus.codtyploc IS 'code du type de local';

COMMENT ON COLUMN dvf_d62.local_plus.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d62.local_plus.nbmutjour IS 'nombre de mutations du local au cours de la journée';

COMMENT ON COLUMN dvf_d62.local_plus.identloc IS 'identifiant du local';

COMMENT ON COLUMN dvf_d62.local_plus.l_idmutsui IS 'identifiants des mutations suivantes du local ayant eu lieu à la date de mutation suivante (datemutsui)';

COMMENT ON COLUMN dvf_d62.local_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.local_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.local_plus.nbmutannee IS 'nombre de mutations du local au cours de l''année calendaire';

DROP TABLE IF EXISTS dvf_d62.disposition_parcelle_plus CASCADE;

-- table fille dvf_d62.disposition_parcelle_plus
CREATE TABLE dvf_d62.disposition_parcelle_plus
(   
)INHERITS (dvf.disposition_parcelle_plus);        

ALTER TABLE dvf_d62.disposition_parcelle_plus 
ADD CONSTRAINT disposition_parcelle_plus_pkey PRIMARY KEY (iddispopar);

ALTER TABLE dvf_d62.disposition_parcelle_plus 
ADD CONSTRAINT disposition_parcelle_plus_unique UNIQUE (iddispo, idparcelle);

ALTER TABLE dvf_d62.disposition_parcelle_plus 
ADD CONSTRAINT disposition_parcelle_plus_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.disposition_parcelle_plus IS 'table des parcelles attachées à une disposition';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt12 IS 'surface de suf de type 12 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt01 IS 'surface de suf de type 01 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt04 IS 'surface de suf de type 04 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcntsol IS 'surface de suf de type sol ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.idparcelle IS 'identifiant de la table parcelle';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.datemutsui IS 'date de la mutation suivante de la parcelle (date postérieure)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt11 IS 'surface de suf de type 11 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.noplan IS 'numéro de la parcelle';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt02 IS 'surface de suf de type 02  ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.nbmutjour IS 'nombre de mutations de la parcelle au cours de la journée';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.codcomm IS 'code insee de la commune';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt06 IS 'surface de suf de type 06 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.parcvendue IS 'Vrai si la parcelle fait partie de la vente';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt07 IS 'surface de suf de type 07 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.nbmutannee IS 'nombre de mutations de la parcelle au cours de l''année calendaire';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt13 IS 'surface de suf de type 13 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcntnat IS 'surface de suf de type naturel ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.prefsect IS 'prefixe de section de la parcelle';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.l_idmutsui IS 'identifiants des mutations suivantes de la parcelle ayant eu lieu à la date de mutation suivante (datemutsui)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt10 IS 'surface de suf de type 10 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.datemutpre IS 'date de la précédente mutation de la parcelle (date antérieure)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt09 IS 'surface de suf de type 09 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.nosect IS 'numéro de section de la parcelle';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.iddispopar IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.l_idmutpre IS 'identifiants des mutations précédentes de la parcelle ayant eu lieu à la date de mutation précédente (datemutpre)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.iddispo IS 'identifiant de la table disposition';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcntagri IS 'surface de suf de type agricole ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt03 IS 'surface de suf de type 03 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt08 IS 'surface de suf de type 08 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt05 IS 'surface de suf de type 05 ayant muté';

DROP TABLE IF EXISTS dvf_d62.mutation_plus CASCADE;

-- table fille dvf_d62.mutation_plus
CREATE TABLE dvf_d62.mutation_plus
(   
)INHERITS (dvf.mutation_plus);        

ALTER TABLE dvf_d62.mutation_plus 
ADD CONSTRAINT mutation_plus_pkey PRIMARY KEY (idmutation);

ALTER TABLE dvf_d62.mutation_plus 
ADD CONSTRAINT mutation_plus_unique UNIQUE (codservch, refdoc);

ALTER TABLE dvf_d62.mutation_plus 
ADD CONSTRAINT mutation_plus_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.mutation_plus IS 'table des mutations';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_idpar IS 'liste des identifiants de parcelles concernées par la mutation (idpar)';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblocdep IS 'nombre de dépendances ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblocmai IS 'nombre de maisons ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.valeurfonc IS 'prix ou évaluation déclarée dans le cadre d''une mutation onéreuse';

COMMENT ON COLUMN dvf_d62.mutation_plus.vefa IS 'vrai si la mutation est une Vente en l''état futur d''achèvement (VEFA)';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_dcnt IS 'Liste ordonnée des surfaces de suf de 01 à 13';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_section IS 'liste des sections concernées par la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbsection IS 'nombre de sections concernées par la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_idlocmut IS 'liste des identifiants de locaux ayant muté (idloc)';

COMMENT ON COLUMN dvf_d62.mutation_plus.sbati IS 'surface de l''ensemble du bâti ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbvolmut IS 'nombre de volumes ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbparmut IS 'nombre de parcelles ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.refdoc IS 'référence d''enregistrement du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.mutation_plus.sapt1pp IS 'surface de l''ensemble des appartements avec 1 pièce principale ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.smai3pp IS 'surface de l''ensemble des maisons avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblocact IS 'nombre de locaux d''activités ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbapt2pp IS 'nombre d''appartements avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbapt5pp IS 'nombre d''appartements avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.smai5pp IS 'surface de l''ensemble des maisons avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.sapt5pp IS 'surface de l''ensemble des appartements avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbdispo IS 'nombre de dispositions associées à la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.sbatact IS 'surface de l''ensemble du bâti d’activité ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.smai2pp IS 'surface de l''ensemble des maisons avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbpar IS 'nombre de parcelles concernées par la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.sterr IS 'surface de terrain ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbsuf IS 'nombre de subdivisions fiscales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.sapt2pp IS 'surface de l''ensemble des appartements avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbmai4pp IS 'nombre de maisons avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.sbatmai IS 'surface de l''ensemble des maisons ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbapt1pp IS 'nombre d''appartements avec une pièce principale ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbcomm IS 'nombre de communes concernées par la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.sapt3pp IS 'surface de l''ensemble des appartements avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_artcgi IS 'liste des codes d’articles CGI (Code Général des Impôts) associés à la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.libnatmut IS 'libellé de la nature de mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbmai1pp IS 'nombre de maisons avec une pièce principale ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbapt3pp IS 'nombre d''appartements avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbmai5pp IS 'nombre de maisons avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.codservch IS 'code du service de conservation des hypothèques';

COMMENT ON COLUMN dvf_d62.mutation_plus.sbatapt IS 'surface de l''ensemble des appartements ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbmai2pp IS 'nombre de maisons avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbapt4pp IS 'nombre d''appartements avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblocmut IS 'nombre de locaux ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_codinsee IS 'liste des codes INSEE des communes concernées par la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbartcgi IS 'nombre d''articles du Code Général des Impôts (CGI) associés à la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.smai4pp IS 'surface de l''ensemble des maisons avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblot IS 'nombre total de lots dans la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_idparmut IS 'liste des identifiants de parcelles ayant muté (idpar)';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblocapt IS 'nombre d''appartements ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.idmutinvar IS 'identifiant invariant de la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.mutation_plus.sapt4pp IS 'surface de l''ensemble des appartements avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbmai3pp IS 'nombre de maisons avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.smai1pp IS 'surface de l''ensemble des maisons avec 1 pièce principale ayant muté';

DROP TABLE IF EXISTS dvf_d59.local_plus CASCADE;

-- table fille dvf_d59.local_plus
CREATE TABLE dvf_d59.local_plus
(   
)INHERITS (dvf.local_plus);        

ALTER TABLE dvf_d59.local_plus 
ADD CONSTRAINT local_plus_pkey PRIMARY KEY (iddispoloc);

ALTER TABLE dvf_d59.local_plus 
ADD CONSTRAINT local_plus_unique UNIQUE (iddispopar, identloc);

ALTER TABLE dvf_d59.local_plus 
ADD CONSTRAINT local_plus_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.local_plus IS 'table des locaux';

COMMENT ON COLUMN dvf_d59.local_plus.idloc IS 'identifiant du local (Fichier Fonciers)';

COMMENT ON COLUMN dvf_d59.local_plus.libtyploc IS 'libellé du type de local';

COMMENT ON COLUMN dvf_d59.local_plus.sbati IS 'surface réelle attachée à l''identifiant local';

COMMENT ON COLUMN dvf_d59.local_plus.nbpprinc IS 'nombre de pièces principales';

COMMENT ON COLUMN dvf_d59.local_plus.datemutpre IS 'date de la précédente mutation du local';

COMMENT ON COLUMN dvf_d59.local_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.local_plus.iddispoloc IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.local_plus.datemutsui IS 'date de la mutation suivante du local';

COMMENT ON COLUMN dvf_d59.local_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.local_plus.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.local_plus.l_idmutpre IS 'identifiants des mutations précédentes du local ayant eu lieu à la date de mutation précédente (datemutpre)';

COMMENT ON COLUMN dvf_d59.local_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d59.local_plus.codtyploc IS 'code du type de local';

COMMENT ON COLUMN dvf_d59.local_plus.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d59.local_plus.nbmutjour IS 'nombre de mutations du local au cours de la journée';

COMMENT ON COLUMN dvf_d59.local_plus.identloc IS 'identifiant du local';

COMMENT ON COLUMN dvf_d59.local_plus.l_idmutsui IS 'identifiants des mutations suivantes du local ayant eu lieu à la date de mutation suivante (datemutsui)';

COMMENT ON COLUMN dvf_d59.local_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.local_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.local_plus.nbmutannee IS 'nombre de mutations du local au cours de l''année calendaire';

DROP TABLE IF EXISTS dvf_d59.disposition_parcelle_plus CASCADE;

-- table fille dvf_d59.disposition_parcelle_plus
CREATE TABLE dvf_d59.disposition_parcelle_plus
(   
)INHERITS (dvf.disposition_parcelle_plus);        

ALTER TABLE dvf_d59.disposition_parcelle_plus 
ADD CONSTRAINT disposition_parcelle_plus_pkey PRIMARY KEY (iddispopar);

ALTER TABLE dvf_d59.disposition_parcelle_plus 
ADD CONSTRAINT disposition_parcelle_plus_unique UNIQUE (iddispo, idparcelle);

ALTER TABLE dvf_d59.disposition_parcelle_plus 
ADD CONSTRAINT disposition_parcelle_plus_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.disposition_parcelle_plus IS 'table des parcelles attachées à une disposition';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt12 IS 'surface de suf de type 12 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt01 IS 'surface de suf de type 01 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt04 IS 'surface de suf de type 04 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcntsol IS 'surface de suf de type sol ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.idparcelle IS 'identifiant de la table parcelle';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.datemutsui IS 'date de la mutation suivante de la parcelle (date postérieure)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt11 IS 'surface de suf de type 11 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.noplan IS 'numéro de la parcelle';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt02 IS 'surface de suf de type 02  ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.nbmutjour IS 'nombre de mutations de la parcelle au cours de la journée';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.codcomm IS 'code insee de la commune';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt06 IS 'surface de suf de type 06 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.parcvendue IS 'Vrai si la parcelle fait partie de la vente';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt07 IS 'surface de suf de type 07 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.nbmutannee IS 'nombre de mutations de la parcelle au cours de l''année calendaire';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt13 IS 'surface de suf de type 13 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcntnat IS 'surface de suf de type naturel ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.prefsect IS 'prefixe de section de la parcelle';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.l_idmutsui IS 'identifiants des mutations suivantes de la parcelle ayant eu lieu à la date de mutation suivante (datemutsui)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt10 IS 'surface de suf de type 10 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.datemutpre IS 'date de la précédente mutation de la parcelle (date antérieure)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt09 IS 'surface de suf de type 09 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.nosect IS 'numéro de section de la parcelle';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.iddispopar IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.l_idmutpre IS 'identifiants des mutations précédentes de la parcelle ayant eu lieu à la date de mutation précédente (datemutpre)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.iddispo IS 'identifiant de la table disposition';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcntagri IS 'surface de suf de type agricole ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt03 IS 'surface de suf de type 03 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt08 IS 'surface de suf de type 08 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt05 IS 'surface de suf de type 05 ayant muté';

DROP TABLE IF EXISTS dvf_d59.mutation_plus CASCADE;

-- table fille dvf_d59.mutation_plus
CREATE TABLE dvf_d59.mutation_plus
(   
)INHERITS (dvf.mutation_plus);        

ALTER TABLE dvf_d59.mutation_plus 
ADD CONSTRAINT mutation_plus_pkey PRIMARY KEY (idmutation);

ALTER TABLE dvf_d59.mutation_plus 
ADD CONSTRAINT mutation_plus_unique UNIQUE (codservch, refdoc);

ALTER TABLE dvf_d59.mutation_plus 
ADD CONSTRAINT mutation_plus_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.mutation_plus IS 'table des mutations';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_idpar IS 'liste des identifiants de parcelles concernées par la mutation (idpar)';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblocdep IS 'nombre de dépendances ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblocmai IS 'nombre de maisons ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.valeurfonc IS 'prix ou évaluation déclarée dans le cadre d''une mutation onéreuse';

COMMENT ON COLUMN dvf_d59.mutation_plus.vefa IS 'vrai si la mutation est une Vente en l''état futur d''achèvement (VEFA)';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_dcnt IS 'Liste ordonnée des surfaces de suf de 01 à 13';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_section IS 'liste des sections concernées par la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbsection IS 'nombre de sections concernées par la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_idlocmut IS 'liste des identifiants de locaux ayant muté (idloc)';

COMMENT ON COLUMN dvf_d59.mutation_plus.sbati IS 'surface de l''ensemble du bâti ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbvolmut IS 'nombre de volumes ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbparmut IS 'nombre de parcelles ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.refdoc IS 'référence d''enregistrement du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.mutation_plus.sapt1pp IS 'surface de l''ensemble des appartements avec 1 pièce principale ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.smai3pp IS 'surface de l''ensemble des maisons avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblocact IS 'nombre de locaux d''activités ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbapt2pp IS 'nombre d''appartements avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbapt5pp IS 'nombre d''appartements avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.smai5pp IS 'surface de l''ensemble des maisons avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.sapt5pp IS 'surface de l''ensemble des appartements avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbdispo IS 'nombre de dispositions associées à la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.sbatact IS 'surface de l''ensemble du bâti d’activité ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.smai2pp IS 'surface de l''ensemble des maisons avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbpar IS 'nombre de parcelles concernées par la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.sterr IS 'surface de terrain ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbsuf IS 'nombre de subdivisions fiscales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.sapt2pp IS 'surface de l''ensemble des appartements avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbmai4pp IS 'nombre de maisons avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.sbatmai IS 'surface de l''ensemble des maisons ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbapt1pp IS 'nombre d''appartements avec une pièce principale ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbcomm IS 'nombre de communes concernées par la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.sapt3pp IS 'surface de l''ensemble des appartements avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_artcgi IS 'liste des codes d’articles CGI (Code Général des Impôts) associés à la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.libnatmut IS 'libellé de la nature de mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbmai1pp IS 'nombre de maisons avec une pièce principale ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbapt3pp IS 'nombre d''appartements avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbmai5pp IS 'nombre de maisons avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.codservch IS 'code du service de conservation des hypothèques';

COMMENT ON COLUMN dvf_d59.mutation_plus.sbatapt IS 'surface de l''ensemble des appartements ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbmai2pp IS 'nombre de maisons avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbapt4pp IS 'nombre d''appartements avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblocmut IS 'nombre de locaux ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_codinsee IS 'liste des codes INSEE des communes concernées par la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbartcgi IS 'nombre d''articles du Code Général des Impôts (CGI) associés à la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.smai4pp IS 'surface de l''ensemble des maisons avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblot IS 'nombre total de lots dans la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_idparmut IS 'liste des identifiants de parcelles ayant muté (idpar)';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblocapt IS 'nombre d''appartements ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.idmutinvar IS 'identifiant invariant de la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.mutation_plus.sapt4pp IS 'surface de l''ensemble des appartements avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbmai3pp IS 'nombre de maisons avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.smai1pp IS 'surface de l''ensemble des maisons avec 1 pièce principale ayant muté';

-- création du trigger de la table %(table)s 
CREATE OR REPLACE FUNCTION dvf.local_plus_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.local_plus VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.local_plus VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;
    
CREATE TRIGGER insert_local_plus_trigger
    BEFORE INSERT ON dvf.local_plus
    FOR EACH ROW EXECUTE PROCEDURE dvf.local_plus_insert_trigger();
-- création du trigger de la table %(table)s 
CREATE OR REPLACE FUNCTION dvf.disposition_parcelle_plus_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.disposition_parcelle_plus VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.disposition_parcelle_plus VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;
    
CREATE TRIGGER insert_disposition_parcelle_plus_trigger
    BEFORE INSERT ON dvf.disposition_parcelle_plus
    FOR EACH ROW EXECUTE PROCEDURE dvf.disposition_parcelle_plus_insert_trigger();
-- création du trigger de la table %(table)s 
CREATE OR REPLACE FUNCTION dvf.mutation_plus_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.mutation_plus VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.mutation_plus VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;
    
CREATE TRIGGER insert_mutation_plus_trigger
    BEFORE INSERT ON dvf.mutation_plus
    FOR EACH ROW EXECUTE PROCEDURE dvf.mutation_plus_insert_trigger();
CREATE TABLE dvf_d62.tmp_local_mutee_rangee AS(
    SELECT 
        idloc, datemut, anneemut, l_idmut, nbmutjour, rank() OVER (PARTITION BY idloc ORDER BY datemut) as rang
    FROM(
        SELECT 
            t.idloc, tt.datemut, tt.anneemut, array_agg(tt.idmutation) as l_idmut, count(*) as nbmutjour
        FROM(
            SELECT t1.idmutation, t1.idloc
            FROM dvf_d62.local t1  
            GROUP BY t1.idmutation, t1.idloc
            ) t
        JOIN dvf_d62.mutation tt
        ON t.idmutation = tt.idmutation
        GROUP BY t.idloc, tt.datemut, tt.anneemut
    ) ta
    --ORDER BY idloc, datemut
);
ALTER TABLE dvf_d62.tmp_local_mutee_rangee ADD PRIMARY KEY (idloc,datemut);

CREATE TABLE dvf_d62.tmp_calcul_local_iddispoloc AS(
SELECT
    t1.iddispoloc, 
    CASE WHEN t3.nbmutjour IS NULL THEN 0 ELSE t3.nbmutjour END::INTEGER AS nbmutjour,
    CASE WHEN t4.nbmutannee IS NULL THEN 0 ELSE t4.nbmutannee END::INTEGER AS nbmutannee,
    t5.datemut AS datemutpre,
    t5.l_idmut AS l_idmutpre,
    t6.datemut AS datemutsui, 
    t6.l_idmut AS l_idmutsui
FROM dvf_d62.local t1
LEFT JOIN dvf_d62.tmp_local_mutee_rangee    t3
ON t1.idloc = t3.idloc AND t1.datemut = t3.datemut
LEFT JOIN (SELECT idloc, anneemut, sum(nbmutjour) AS nbmutannee FROM dvf_d62.tmp_local_mutee_rangee GROUP BY idloc, anneemut) t4
ON t1.idloc = t4.idloc AND t1.anneemut = t4.anneemut
LEFT JOIN dvf_d62.tmp_local_mutee_rangee t5
ON t1.idloc = t5.idloc AND t3.rang-1 = t5.rang
LEFT JOIN dvf_d62.tmp_local_mutee_rangee    t6
ON t1.idloc = t6.idloc AND t3.rang+1 = t6.rang
);

CREATE TABLE dvf_d59.tmp_local_mutee_rangee AS(
    SELECT 
        idloc, datemut, anneemut, l_idmut, nbmutjour, rank() OVER (PARTITION BY idloc ORDER BY datemut) as rang
    FROM(
        SELECT 
            t.idloc, tt.datemut, tt.anneemut, array_agg(tt.idmutation) as l_idmut, count(*) as nbmutjour
        FROM(
            SELECT t1.idmutation, t1.idloc
            FROM dvf_d59.local t1  
            GROUP BY t1.idmutation, t1.idloc
            ) t
        JOIN dvf_d59.mutation tt
        ON t.idmutation = tt.idmutation
        GROUP BY t.idloc, tt.datemut, tt.anneemut
    ) ta
    --ORDER BY idloc, datemut
);
ALTER TABLE dvf_d59.tmp_local_mutee_rangee ADD PRIMARY KEY (idloc,datemut);

CREATE TABLE dvf_d59.tmp_calcul_local_iddispoloc AS(
SELECT
    t1.iddispoloc, 
    CASE WHEN t3.nbmutjour IS NULL THEN 0 ELSE t3.nbmutjour END::INTEGER AS nbmutjour,
    CASE WHEN t4.nbmutannee IS NULL THEN 0 ELSE t4.nbmutannee END::INTEGER AS nbmutannee,
    t5.datemut AS datemutpre,
    t5.l_idmut AS l_idmutpre,
    t6.datemut AS datemutsui, 
    t6.l_idmut AS l_idmutsui
FROM dvf_d59.local t1
LEFT JOIN dvf_d59.tmp_local_mutee_rangee    t3
ON t1.idloc = t3.idloc AND t1.datemut = t3.datemut
LEFT JOIN (SELECT idloc, anneemut, sum(nbmutjour) AS nbmutannee FROM dvf_d59.tmp_local_mutee_rangee GROUP BY idloc, anneemut) t4
ON t1.idloc = t4.idloc AND t1.anneemut = t4.anneemut
LEFT JOIN dvf_d59.tmp_local_mutee_rangee t5
ON t1.idloc = t5.idloc AND t3.rang-1 = t5.rang
LEFT JOIN dvf_d59.tmp_local_mutee_rangee    t6
ON t1.idloc = t6.idloc AND t3.rang+1 = t6.rang
);


INSERT INTO dvf_d62.local_plus
(
    iddispoloc, iddispopar, idpar, idmutation, idloc, identloc, codtyploc, libtyploc, nbpprinc, sbati, coddep, datemut, anneemut, moismut, nbmutjour, nbmutannee, datemutpre, l_idmutpre, datemutsui, l_idmutsui
)
(
SELECT 
	t.iddispoloc,
	t.iddispopar,
	t.idpar,
	t.idmutation,
	t.idloc,
	t.identloc,
	t.codtyploc,
	t.libtyploc,
	t.nbpprinc,
	t.sbati,
	t.coddep,
	t.datemut,
	t.anneemut,
	t.moismut,
	t0.nbmutjour,
	t0.nbmutannee,
	t0.datemutpre,
	t0.l_idmutpre,
	t0.datemutsui,
	t0.l_idmutsui
FROM dvf_d62.local t 
LEFT JOIN dvf_d62.tmp_calcul_local_iddispoloc t0
	ON t.iddispoloc = t0.iddispoloc
);
DROP TABLE IF EXISTS dvf_d62.tmp_calcul_local_iddispoloc CASCADE;

DROP TABLE IF EXISTS dvf_d62.tmp_local_mutee_rangee CASCADE;


INSERT INTO dvf_d59.local_plus
(
    iddispoloc, iddispopar, idpar, idmutation, idloc, identloc, codtyploc, libtyploc, nbpprinc, sbati, coddep, datemut, anneemut, moismut, nbmutjour, nbmutannee, datemutpre, l_idmutpre, datemutsui, l_idmutsui
)
(
SELECT 
	t.iddispoloc,
	t.iddispopar,
	t.idpar,
	t.idmutation,
	t.idloc,
	t.identloc,
	t.codtyploc,
	t.libtyploc,
	t.nbpprinc,
	t.sbati,
	t.coddep,
	t.datemut,
	t.anneemut,
	t.moismut,
	t0.nbmutjour,
	t0.nbmutannee,
	t0.datemutpre,
	t0.l_idmutpre,
	t0.datemutsui,
	t0.l_idmutsui
FROM dvf_d59.local t 
LEFT JOIN dvf_d59.tmp_calcul_local_iddispoloc t0
	ON t.iddispoloc = t0.iddispoloc
);
DROP TABLE IF EXISTS dvf_d59.tmp_calcul_local_iddispoloc CASCADE;

DROP TABLE IF EXISTS dvf_d59.tmp_local_mutee_rangee CASCADE;

DROP TABLE IF EXISTS dvf.local CASCADE;

ALTER TABLE dvf.local_plus RENAME To local;

DROP TABLE IF EXISTS dvf_d62.local CASCADE;

ALTER TABLE dvf_d62.local_plus RENAME To local;

DROP TABLE IF EXISTS dvf_d59.local CASCADE;

ALTER TABLE dvf_d59.local_plus RENAME To local;

DROP TRIGGER insert_local_plus_trigger ON dvf.local;
--CREATE TRIGGER insert_local_trigger
--BEFORE INSERT ON dvf.local
--FOR EACH ROW EXECUTE PROCEDURE dvf.local_insert_trigger();CREATE TABLE dvf_d62.tmp_calcul_parcelle_iddispopar AS(         
    SELECT
        t.iddispopar, 
        tt.*
    FROM
        dvf_d62.disposition_parcelle t
    LEFT JOIN
        dvf_d62.parcelle tt
        ON t.idparcelle = tt.idparcelle

);

CREATE TABLE dvf_d62.tmp_parcelle_mutee_rangee AS(
    SELECT 
        idparcelle, datemut, anneemut, l_idmut, l_iddispopar, nbmutjour, rank() OVER (PARTITION BY idparcelle ORDER BY datemut) as rang
    FROM(
        SELECT 
            t.idparcelle, tt.datemut, tt.anneemut, array_agg(tt.idmutation) as l_idmut, array_agg(t.iddispopar) As l_iddispopar, count(*) as nbmutjour
        FROM(
            SELECT t1.idmutation, t1.iddispopar, t1.idparcelle
            FROM dvf_d62.disposition_parcelle t1 
            JOIN dvf_d62.suf t2 
            ON t1.iddispopar = t2.iddispopar 
            GROUP BY t1.idmutation, t1.iddispopar, t1.idparcelle
            ) t
        JOIN dvf_d62.mutation tt
        ON t.idmutation = tt.idmutation
        GROUP BY t.idparcelle, tt.datemut, tt.anneemut
    ) ta
    --ORDER BY idparcelle, datemut
);
ALTER TABLE dvf_d62.tmp_parcelle_mutee_rangee ADD PRIMARY KEY (idparcelle,datemut);

CREATE TABLE dvf_d62.tmp_calcul_suf_iddispopar01 AS(        
    SELECT
        t1.iddispopar,
        t1.idparcelle,
        t1.datemut,
        CASE WHEN t3.idparcelle IS NULL THEN false ELSE true END::BOOLEAN AS parcvendue,
        COALESCE(t3.nbmutjour, 0)::INTEGER AS nbmutjour,
        COALESCE(t4.nbmutannee, 0)::INTEGER AS nbmutannee,
        CASE WHEN t5.datemut IS NULL THEN (SELECT max(datemut) FROM dvf_d62.tmp_parcelle_mutee_rangee WHERE idparcelle = t1.idparcelle AND datemut < t1.datemut) ELSE t5.datemut END AS datemutpre,
        CASE WHEN t6.datemut IS NULL THEN (SELECT min(datemut) FROM dvf_d62.tmp_parcelle_mutee_rangee WHERE idparcelle = t1.idparcelle AND datemut > t1.datemut) ELSE t6.datemut END AS datemutsui,
        t7.dcnt01,
        t7.dcnt02,
        t7.dcnt03,
        t7.dcnt04,
        t7.dcnt05,
        t7.dcnt06,
        t7.dcnt07,
        t7.dcnt08,
        t7.dcnt09,
        t7.dcnt10,
        t7.dcnt11,
        t7.dcnt12,
        t7.dcnt13
    FROM dvf_d62.disposition_parcelle t1
    LEFT JOIN dvf_d62.tmp_parcelle_mutee_rangee t3
    ON t1.idparcelle = t3.idparcelle AND t1.datemut = t3.datemut AND ARRAY[t1.iddispopar]::INTEGER[] && t3.l_iddispopar
    LEFT JOIN (SELECT idparcelle, anneemut, sum(nbmutjour) AS nbmutannee FROM dvf_d62.tmp_parcelle_mutee_rangee GROUP BY idparcelle, anneemut) t4
    ON t1.idparcelle = t4.idparcelle AND t1.anneemut = t4.anneemut
    LEFT JOIN dvf_d62.tmp_parcelle_mutee_rangee    t5
    ON t1.idparcelle = t5.idparcelle AND t3.rang-1 = t5.rang
    LEFT JOIN dvf_d62.tmp_parcelle_mutee_rangee    t6
    ON t1.idparcelle = t6.idparcelle AND t3.rang+1 = t6.rang
    LEFT JOIN 
    (    SELECT 
            iddispopar,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 1 THEN 1 ELSE 0 END),0) AS dcnt01,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 2 THEN 1 ELSE 0 END),0) AS dcnt02,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 3 THEN 1 ELSE 0 END),0) AS dcnt03,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 4 THEN 1 ELSE 0 END),0) AS dcnt04,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 5 THEN 1 ELSE 0 END),0) AS dcnt05,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 6 THEN 1 ELSE 0 END),0) AS dcnt06,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 7 THEN 1 ELSE 0 END),0) AS dcnt07,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 8 THEN 1 ELSE 0 END),0) AS dcnt08,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 9 THEN 1 ELSE 0 END),0) AS dcnt09,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 10 THEN 1 ELSE 0 END),0) AS dcnt10,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 11 THEN 1 ELSE 0 END),0) AS dcnt11,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 12 THEN 1 ELSE 0 END),0) AS dcnt12,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 13 THEN 1 ELSE 0 END),0) AS dcnt13
        FROM  (SELECT m.iddispopar, t.iddisposuf, t.nbsufidt, t.sterr, t.nodcnt FROM dvf_d62.disposition_parcelle m LEFT JOIN dvf_d62.suf t ON m.iddispopar = t.iddispopar) tt
        GROUP BY iddispopar
    ) t7
    ON  t1.iddispopar = t7.iddispopar
);

CREATE TABLE dvf_d62.tmp_calcul_suf_iddispopar AS(
SELECT
    iddispopar,
    datemut,
    parcvendue,
    nbmutjour,
    nbmutannee,
    datemutpre,
    (SELECT l_idmut FROM dvf_d62.tmp_parcelle_mutee_rangee tpre WHERE tpre.idparcelle = tf.idparcelle and tpre.datemut = tf.datemutpre) AS l_idmutpre,
    datemutsui,
    (SELECT l_idmut FROM dvf_d62.tmp_parcelle_mutee_rangee tsui WHERE tsui.idparcelle = tf.idparcelle and tsui.datemut = tf.datemutsui) AS l_idmutsui,
    dcnt01,
    dcnt02,
    dcnt03,
    dcnt04,
    dcnt05,
    dcnt06,
    dcnt07,
    dcnt08,
    dcnt09,
    dcnt10,
    dcnt11,
    dcnt12,
    dcnt13,
    dcnt09 + dcnt10 + dcnt11 + dcnt12+ dcnt13 AS dcntsol,
    dcnt01 + dcnt02 + dcnt03 + dcnt04 AS dcntagri,
    dcnt06 + dcnt07 AS dcntnat
FROM dvf_d62.tmp_calcul_suf_iddispopar01 tf
);

CREATE TABLE dvf_d59.tmp_calcul_parcelle_iddispopar AS(         
    SELECT
        t.iddispopar, 
        tt.*
    FROM
        dvf_d59.disposition_parcelle t
    LEFT JOIN
        dvf_d59.parcelle tt
        ON t.idparcelle = tt.idparcelle

);

CREATE TABLE dvf_d59.tmp_parcelle_mutee_rangee AS(
    SELECT 
        idparcelle, datemut, anneemut, l_idmut, l_iddispopar, nbmutjour, rank() OVER (PARTITION BY idparcelle ORDER BY datemut) as rang
    FROM(
        SELECT 
            t.idparcelle, tt.datemut, tt.anneemut, array_agg(tt.idmutation) as l_idmut, array_agg(t.iddispopar) As l_iddispopar, count(*) as nbmutjour
        FROM(
            SELECT t1.idmutation, t1.iddispopar, t1.idparcelle
            FROM dvf_d59.disposition_parcelle t1 
            JOIN dvf_d59.suf t2 
            ON t1.iddispopar = t2.iddispopar 
            GROUP BY t1.idmutation, t1.iddispopar, t1.idparcelle
            ) t
        JOIN dvf_d59.mutation tt
        ON t.idmutation = tt.idmutation
        GROUP BY t.idparcelle, tt.datemut, tt.anneemut
    ) ta
    --ORDER BY idparcelle, datemut
);
ALTER TABLE dvf_d59.tmp_parcelle_mutee_rangee ADD PRIMARY KEY (idparcelle,datemut);

CREATE TABLE dvf_d59.tmp_calcul_suf_iddispopar01 AS(        
    SELECT
        t1.iddispopar,
        t1.idparcelle,
        t1.datemut,
        CASE WHEN t3.idparcelle IS NULL THEN false ELSE true END::BOOLEAN AS parcvendue,
        COALESCE(t3.nbmutjour, 0)::INTEGER AS nbmutjour,
        COALESCE(t4.nbmutannee, 0)::INTEGER AS nbmutannee,
        CASE WHEN t5.datemut IS NULL THEN (SELECT max(datemut) FROM dvf_d59.tmp_parcelle_mutee_rangee WHERE idparcelle = t1.idparcelle AND datemut < t1.datemut) ELSE t5.datemut END AS datemutpre,
        CASE WHEN t6.datemut IS NULL THEN (SELECT min(datemut) FROM dvf_d59.tmp_parcelle_mutee_rangee WHERE idparcelle = t1.idparcelle AND datemut > t1.datemut) ELSE t6.datemut END AS datemutsui,
        t7.dcnt01,
        t7.dcnt02,
        t7.dcnt03,
        t7.dcnt04,
        t7.dcnt05,
        t7.dcnt06,
        t7.dcnt07,
        t7.dcnt08,
        t7.dcnt09,
        t7.dcnt10,
        t7.dcnt11,
        t7.dcnt12,
        t7.dcnt13
    FROM dvf_d59.disposition_parcelle t1
    LEFT JOIN dvf_d59.tmp_parcelle_mutee_rangee t3
    ON t1.idparcelle = t3.idparcelle AND t1.datemut = t3.datemut AND ARRAY[t1.iddispopar]::INTEGER[] && t3.l_iddispopar
    LEFT JOIN (SELECT idparcelle, anneemut, sum(nbmutjour) AS nbmutannee FROM dvf_d59.tmp_parcelle_mutee_rangee GROUP BY idparcelle, anneemut) t4
    ON t1.idparcelle = t4.idparcelle AND t1.anneemut = t4.anneemut
    LEFT JOIN dvf_d59.tmp_parcelle_mutee_rangee    t5
    ON t1.idparcelle = t5.idparcelle AND t3.rang-1 = t5.rang
    LEFT JOIN dvf_d59.tmp_parcelle_mutee_rangee    t6
    ON t1.idparcelle = t6.idparcelle AND t3.rang+1 = t6.rang
    LEFT JOIN 
    (    SELECT 
            iddispopar,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 1 THEN 1 ELSE 0 END),0) AS dcnt01,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 2 THEN 1 ELSE 0 END),0) AS dcnt02,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 3 THEN 1 ELSE 0 END),0) AS dcnt03,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 4 THEN 1 ELSE 0 END),0) AS dcnt04,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 5 THEN 1 ELSE 0 END),0) AS dcnt05,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 6 THEN 1 ELSE 0 END),0) AS dcnt06,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 7 THEN 1 ELSE 0 END),0) AS dcnt07,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 8 THEN 1 ELSE 0 END),0) AS dcnt08,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 9 THEN 1 ELSE 0 END),0) AS dcnt09,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 10 THEN 1 ELSE 0 END),0) AS dcnt10,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 11 THEN 1 ELSE 0 END),0) AS dcnt11,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 12 THEN 1 ELSE 0 END),0) AS dcnt12,
            COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 13 THEN 1 ELSE 0 END),0) AS dcnt13
        FROM  (SELECT m.iddispopar, t.iddisposuf, t.nbsufidt, t.sterr, t.nodcnt FROM dvf_d59.disposition_parcelle m LEFT JOIN dvf_d59.suf t ON m.iddispopar = t.iddispopar) tt
        GROUP BY iddispopar
    ) t7
    ON  t1.iddispopar = t7.iddispopar
);

CREATE TABLE dvf_d59.tmp_calcul_suf_iddispopar AS(
SELECT
    iddispopar,
    datemut,
    parcvendue,
    nbmutjour,
    nbmutannee,
    datemutpre,
    (SELECT l_idmut FROM dvf_d59.tmp_parcelle_mutee_rangee tpre WHERE tpre.idparcelle = tf.idparcelle and tpre.datemut = tf.datemutpre) AS l_idmutpre,
    datemutsui,
    (SELECT l_idmut FROM dvf_d59.tmp_parcelle_mutee_rangee tsui WHERE tsui.idparcelle = tf.idparcelle and tsui.datemut = tf.datemutsui) AS l_idmutsui,
    dcnt01,
    dcnt02,
    dcnt03,
    dcnt04,
    dcnt05,
    dcnt06,
    dcnt07,
    dcnt08,
    dcnt09,
    dcnt10,
    dcnt11,
    dcnt12,
    dcnt13,
    dcnt09 + dcnt10 + dcnt11 + dcnt12+ dcnt13 AS dcntsol,
    dcnt01 + dcnt02 + dcnt03 + dcnt04 AS dcntagri,
    dcnt06 + dcnt07 AS dcntnat
FROM dvf_d59.tmp_calcul_suf_iddispopar01 tf
);


INSERT INTO dvf_d62.disposition_parcelle_plus
(
    iddispopar, iddispo, idparcelle, idmutation, idpar, coddep, codcomm, prefsect, nosect, noplan, datemut, anneemut, moismut, parcvendue, nbmutjour, nbmutannee, datemutpre, l_idmutpre, datemutsui, l_idmutsui, dcnt01, dcnt02, dcnt03, dcnt04, dcnt05, dcnt06, dcnt07, dcnt08, dcnt09, dcnt10, dcnt11, dcnt12, dcnt13, dcntsol, dcntagri, dcntnat
)
(
SELECT 
	t.iddispopar,
	t.iddispo,
	t.idparcelle,
	t.idmutation,
	t1.idpar,
	t.coddep,
	t1.codcomm,
	t1.prefsect,
	t1.nosect,
	t1.noplan,
	t.datemut,
	t.anneemut,
	t.moismut,
	t0.parcvendue,
	t0.nbmutjour,
	t0.nbmutannee,
	t0.datemutpre,
	t0.l_idmutpre,
	t0.datemutsui,
	t0.l_idmutsui,
	t0.dcnt01,
	t0.dcnt02,
	t0.dcnt03,
	t0.dcnt04,
	t0.dcnt05,
	t0.dcnt06,
	t0.dcnt07,
	t0.dcnt08,
	t0.dcnt09,
	t0.dcnt10,
	t0.dcnt11,
	t0.dcnt12,
	t0.dcnt13,
	t0.dcntsol,
	t0.dcntagri,
	t0.dcntnat
FROM dvf_d62.disposition_parcelle t 
LEFT JOIN dvf_d62.tmp_calcul_suf_iddispopar t0
	ON t.iddispopar = t0.iddispopar
LEFT JOIN dvf_d62.tmp_calcul_parcelle_iddispopar t1
	ON t.iddispopar = t1.iddispopar
);
DROP TABLE IF EXISTS dvf_d62.tmp_calcul_parcelle_iddispopar CASCADE;

DROP TABLE IF EXISTS dvf_d62.tmp_calcul_suf_iddispopar CASCADE;

DROP TABLE IF EXISTS dvf_d62.tmp_calcul_suf_iddispopar01 CASCADE;

DROP TABLE IF EXISTS dvf_d62.tmp_parcelle_mutee_rangee CASCADE;


INSERT INTO dvf_d59.disposition_parcelle_plus
(
    iddispopar, iddispo, idparcelle, idmutation, idpar, coddep, codcomm, prefsect, nosect, noplan, datemut, anneemut, moismut, parcvendue, nbmutjour, nbmutannee, datemutpre, l_idmutpre, datemutsui, l_idmutsui, dcnt01, dcnt02, dcnt03, dcnt04, dcnt05, dcnt06, dcnt07, dcnt08, dcnt09, dcnt10, dcnt11, dcnt12, dcnt13, dcntsol, dcntagri, dcntnat
)
(
SELECT 
	t.iddispopar,
	t.iddispo,
	t.idparcelle,
	t.idmutation,
	t1.idpar,
	t.coddep,
	t1.codcomm,
	t1.prefsect,
	t1.nosect,
	t1.noplan,
	t.datemut,
	t.anneemut,
	t.moismut,
	t0.parcvendue,
	t0.nbmutjour,
	t0.nbmutannee,
	t0.datemutpre,
	t0.l_idmutpre,
	t0.datemutsui,
	t0.l_idmutsui,
	t0.dcnt01,
	t0.dcnt02,
	t0.dcnt03,
	t0.dcnt04,
	t0.dcnt05,
	t0.dcnt06,
	t0.dcnt07,
	t0.dcnt08,
	t0.dcnt09,
	t0.dcnt10,
	t0.dcnt11,
	t0.dcnt12,
	t0.dcnt13,
	t0.dcntsol,
	t0.dcntagri,
	t0.dcntnat
FROM dvf_d59.disposition_parcelle t 
LEFT JOIN dvf_d59.tmp_calcul_suf_iddispopar t0
	ON t.iddispopar = t0.iddispopar
LEFT JOIN dvf_d59.tmp_calcul_parcelle_iddispopar t1
	ON t.iddispopar = t1.iddispopar
);
DROP TABLE IF EXISTS dvf_d59.tmp_calcul_parcelle_iddispopar CASCADE;

DROP TABLE IF EXISTS dvf_d59.tmp_calcul_suf_iddispopar CASCADE;

DROP TABLE IF EXISTS dvf_d59.tmp_calcul_suf_iddispopar01 CASCADE;

DROP TABLE IF EXISTS dvf_d59.tmp_parcelle_mutee_rangee CASCADE;

DROP TABLE IF EXISTS dvf.disposition_parcelle CASCADE;

ALTER TABLE dvf.disposition_parcelle_plus RENAME To disposition_parcelle;

DROP TABLE IF EXISTS dvf_d62.disposition_parcelle CASCADE;

ALTER TABLE dvf_d62.disposition_parcelle_plus RENAME To disposition_parcelle;

DROP TABLE IF EXISTS dvf_d59.disposition_parcelle CASCADE;

ALTER TABLE dvf_d59.disposition_parcelle_plus RENAME To disposition_parcelle;

DROP TRIGGER insert_disposition_parcelle_plus_trigger ON dvf.disposition_parcelle;
--CREATE TRIGGER insert_disposition_parcelle_trigger
--BEFORE INSERT ON dvf.disposition_parcelle
--FOR EACH ROW EXECUTE PROCEDURE dvf.disposition_parcelle_insert_trigger();CREATE TABLE dvf_d62.tmp_calcul_ann_nature_mutation_idmutation AS(         
    SELECT
        t1.idmutation, 
        t2.libnatmut
    FROM
        dvf_d62.mutation t1
    LEFT JOIN
        dvf_annexe.ann_nature_mutation t2
    ON 
        t1.idnatmut = t2.idnatmut
);

CREATE TABLE dvf_d62.tmp_calcul_mutation_article_cgi_idmutation AS(         
    SELECT
        idmutation, 
        COALESCE(count(DISTINCT idartcgi), 0) AS nbartcgi,
        array_supprimer_null(array_agg(artcgi)) AS l_artcgi
        --
        -- A partir de la version 9.3 de PostgreSQL:
        -- array_remove(array_agg(artcgi), NULL) AS l_artcgi
    FROM
        (SELECT m.idmutation, t.idartcgi, tt.artcgi FROM dvf_d62.mutation m LEFT JOIN dvf_d62.mutation_article_cgi t ON m.idmutation = t.idmutation LEFT JOIN dvf_annexe.ann_cgi tt ON t.idartcgi = tt.idartcgi ORDER BY t.ordarticgi ASC) t1
    GROUP BY idmutation
);

CREATE TABLE dvf_d62.tmp_calcul_annexes_idmutation AS(         
    SELECT
        t1.idmutation, 
        CASE 
            WHEN t1.libnatmut = 'Vente en l''état futur d''achèvement' THEN TRUE
            WHEN '1594FQA*2'= ANY(t2.l_artcgi) THEN TRUE
            WHEN '257-7-1*2'= ANY(t2.l_artcgi) THEN TRUE
            WHEN '296-1-a-*2'= ANY(t2.l_artcgi) THEN TRUE
            WHEN '296-1-b-*2'= ANY(t2.l_artcgi) THEN TRUE
        ELSE FALSE
        END AS vefa
    FROM
    dvf_d62.tmp_calcul_ann_nature_mutation_idmutation t1
    LEFT JOIN
    dvf_d62.tmp_calcul_mutation_article_cgi_idmutation t2
    ON 
    t1.idmutation = t2.idmutation
);

CREATE TABLE dvf_d62.tmp_calcul_disposition_idmutation AS(         
    SELECT
        idmutation, 
        sum(valeurfonc) AS valeurfonc, 
        count(iddispo) AS nbdispo, 
        sum(nblot) AS nblot 
    FROM
        dvf_d62.disposition
    GROUP BY idmutation

);

CREATE TABLE  dvf_d62.tmp_calcul_disposition_parcelle_idmutation AS(

    SELECT 
        t.idmutation,
        count(DISTINCT t.codcomm) as nbcomm,
        array_agg(DISTINCT (t.coddep || t.codcomm)) as l_codinsee,
        count(DISTINCT t.nosect) as nbsection,
        array_agg(DISTINCT t.nosect) as l_section,
        count(t.iddispopar) as nbpar,
        array_agg(DISTINCT t.idpar) AS l_idpar,
        count(tt.iddispopar) AS nbparmut,
        array_supprimer_null(array_agg(DISTINCT tt.idpar)) AS l_idparmut
        --
        -- A partir de la version 9.3 de PostgreSQL:
        -- array_remove(array_agg(DISTINCT tt.idpar), NULL) AS l_idparmut
    FROM  dvf_d62.disposition_parcelle t
    LEFT JOIN (SELECT idmutation, iddispopar, idpar FROM dvf_d62.disposition_parcelle WHERE parcvendue = TRUE) tt
    ON t.iddispopar = tt.iddispopar
    GROUP BY t.idmutation                    

);

CREATE TABLE dvf_d62.tmp_calcul_suf_idmutation AS(

    SELECT 
        idmutation,
        COALESCE(count(iddisposuf), 0) as nbsuf,
        COALESCE(sum(nbsufidt * sterr), 0) AS sterr,
        ARRAY[COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 1 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 2 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 3 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 4 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 5 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 6 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 7 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 8 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 9 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 10 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 11 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 12 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 13 THEN 1 ELSE 0 END),0)]::NUMERIC[] as l_dcnt
    FROM  (SELECT m.idmutation, t.iddisposuf, t.nbsufidt, t.sterr, t.nodcnt FROM dvf_d62.mutation m LEFT JOIN dvf_d62.suf t ON m.idmutation = t.idmutation) tt 
    GROUP BY idmutation                    

);

CREATE TABLE dvf_d62.tmp_calcul_volume_idmutation AS(

    SELECT 
        idmutation,
        count(iddispovol) AS nbvolmut
    FROM  (SELECT m.idmutation, v.iddispovol FROM dvf_d62.mutation m LEFT JOIN dvf_d62.volume v ON m.idmutation = v.idmutation) t    
    GROUP BY idmutation
);

CREATE TABLE dvf_d62.tmp_calcul_local_idmutation AS(

    SELECT 
        idmutation,
        COALESCE(count(iddispoloc),0) as nblocmut,
        array_supprimer_null(array_agg(idloc)) as l_idlocmut,
        --
        -- à partir de la version 9.3
        -- array_remove(array_agg(idloc), NULL) as l_idlocmut,
        COALESCE(sum(CASE WHEN codtyploc = 1 THEN 1 ELSE 0 END),0) AS nblocmai,
        COALESCE(sum(CASE WHEN codtyploc = 2 THEN 1 ELSE 0 END),0) AS nblocapt,
        COALESCE(sum(CASE WHEN codtyploc = 3 THEN 1 ELSE 0 END),0) AS nblocdep,
        COALESCE(sum(CASE WHEN codtyploc = 4 THEN 1 ELSE 0 END),0) AS nblocact,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 1 THEN 1 ELSE 0 END),0) AS nbapt1pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 2 THEN 1 ELSE 0 END),0) AS nbapt2pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 3 THEN 1 ELSE 0 END),0) AS nbapt3pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 4 THEN 1 ELSE 0 END),0) AS nbapt4pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc > 4 THEN 1 ELSE 0 END),0) AS nbapt5pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 1 THEN 1 ELSE 0 END),0) AS nbmai1pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 2 THEN 1 ELSE 0 END),0) AS nbmai2pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 3 THEN 1 ELSE 0 END),0) AS nbmai3pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 4 THEN 1 ELSE 0 END),0) AS nbmai4pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc > 4 THEN 1 ELSE 0 END),0) AS nbmai5pp,
        COALESCE(sum(sbati),0) AS sbati,
        COALESCE(sum(CASE WHEN codtyploc = 1 THEN sbati ELSE 0 END),0) AS sbatmai,
        COALESCE(sum(CASE WHEN codtyploc = 2 THEN sbati ELSE 0 END),0) AS sbatapt,
        COALESCE(sum(CASE WHEN codtyploc = 4 THEN sbati ELSE 0 END),0) AS sbatact,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 1 THEN sbati ELSE 0 END),0) AS sapt1pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 2 THEN sbati ELSE 0 END),0) AS sapt2pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 3 THEN sbati ELSE 0 END),0) AS sapt3pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 4 THEN sbati ELSE 0 END),0) AS sapt4pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc > 4 THEN sbati ELSE 0 END),0) AS sapt5pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 1 THEN sbati ELSE 0 END),0) AS smai1pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 2 THEN sbati ELSE 0 END),0) AS smai2pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 3 THEN sbati ELSE 0 END),0) AS smai3pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 4 THEN sbati ELSE 0 END),0) AS smai4pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc > 4 THEN sbati ELSE 0 END),0) AS smai5pp
    FROM (SELECT m.idmutation, l.iddispoloc, l.idloc, l.codtyploc, l.nbpprinc, l.sbati FROM dvf_d62.mutation m LEFT JOIN dvf_d62.local l ON m.idmutation = l.idmutation) t      
    GROUP BY idmutation
); 

CREATE TABLE dvf_d59.tmp_calcul_ann_nature_mutation_idmutation AS(         
    SELECT
        t1.idmutation, 
        t2.libnatmut
    FROM
        dvf_d59.mutation t1
    LEFT JOIN
        dvf_annexe.ann_nature_mutation t2
    ON 
        t1.idnatmut = t2.idnatmut
);

CREATE TABLE dvf_d59.tmp_calcul_mutation_article_cgi_idmutation AS(         
    SELECT
        idmutation, 
        COALESCE(count(DISTINCT idartcgi), 0) AS nbartcgi,
        array_supprimer_null(array_agg(artcgi)) AS l_artcgi
        --
        -- A partir de la version 9.3 de PostgreSQL:
        -- array_remove(array_agg(artcgi), NULL) AS l_artcgi
    FROM
        (SELECT m.idmutation, t.idartcgi, tt.artcgi FROM dvf_d59.mutation m LEFT JOIN dvf_d59.mutation_article_cgi t ON m.idmutation = t.idmutation LEFT JOIN dvf_annexe.ann_cgi tt ON t.idartcgi = tt.idartcgi ORDER BY t.ordarticgi ASC) t1
    GROUP BY idmutation
);

CREATE TABLE dvf_d59.tmp_calcul_annexes_idmutation AS(         
    SELECT
        t1.idmutation, 
        CASE 
            WHEN t1.libnatmut = 'Vente en l''état futur d''achèvement' THEN TRUE
            WHEN '1594FQA*2'= ANY(t2.l_artcgi) THEN TRUE
            WHEN '257-7-1*2'= ANY(t2.l_artcgi) THEN TRUE
            WHEN '296-1-a-*2'= ANY(t2.l_artcgi) THEN TRUE
            WHEN '296-1-b-*2'= ANY(t2.l_artcgi) THEN TRUE
        ELSE FALSE
        END AS vefa
    FROM
    dvf_d59.tmp_calcul_ann_nature_mutation_idmutation t1
    LEFT JOIN
    dvf_d59.tmp_calcul_mutation_article_cgi_idmutation t2
    ON 
    t1.idmutation = t2.idmutation
);

CREATE TABLE dvf_d59.tmp_calcul_disposition_idmutation AS(         
    SELECT
        idmutation, 
        sum(valeurfonc) AS valeurfonc, 
        count(iddispo) AS nbdispo, 
        sum(nblot) AS nblot 
    FROM
        dvf_d59.disposition
    GROUP BY idmutation

);

CREATE TABLE  dvf_d59.tmp_calcul_disposition_parcelle_idmutation AS(

    SELECT 
        t.idmutation,
        count(DISTINCT t.codcomm) as nbcomm,
        array_agg(DISTINCT (t.coddep || t.codcomm)) as l_codinsee,
        count(DISTINCT t.nosect) as nbsection,
        array_agg(DISTINCT t.nosect) as l_section,
        count(t.iddispopar) as nbpar,
        array_agg(DISTINCT t.idpar) AS l_idpar,
        count(tt.iddispopar) AS nbparmut,
        array_supprimer_null(array_agg(DISTINCT tt.idpar)) AS l_idparmut
        --
        -- A partir de la version 9.3 de PostgreSQL:
        -- array_remove(array_agg(DISTINCT tt.idpar), NULL) AS l_idparmut
    FROM  dvf_d59.disposition_parcelle t
    LEFT JOIN (SELECT idmutation, iddispopar, idpar FROM dvf_d59.disposition_parcelle WHERE parcvendue = TRUE) tt
    ON t.iddispopar = tt.iddispopar
    GROUP BY t.idmutation                    

);

CREATE TABLE dvf_d59.tmp_calcul_suf_idmutation AS(

    SELECT 
        idmutation,
        COALESCE(count(iddisposuf), 0) as nbsuf,
        COALESCE(sum(nbsufidt * sterr), 0) AS sterr,
        ARRAY[COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 1 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 2 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 3 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 4 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 5 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 6 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 7 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 8 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 9 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 10 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 11 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 12 THEN 1 ELSE 0 END),0),
        COALESCE(sum(nbsufidt * sterr * CASE WHEN nodcnt = 13 THEN 1 ELSE 0 END),0)]::NUMERIC[] as l_dcnt
    FROM  (SELECT m.idmutation, t.iddisposuf, t.nbsufidt, t.sterr, t.nodcnt FROM dvf_d59.mutation m LEFT JOIN dvf_d59.suf t ON m.idmutation = t.idmutation) tt 
    GROUP BY idmutation                    

);

CREATE TABLE dvf_d59.tmp_calcul_volume_idmutation AS(

    SELECT 
        idmutation,
        count(iddispovol) AS nbvolmut
    FROM  (SELECT m.idmutation, v.iddispovol FROM dvf_d59.mutation m LEFT JOIN dvf_d59.volume v ON m.idmutation = v.idmutation) t    
    GROUP BY idmutation
);

CREATE TABLE dvf_d59.tmp_calcul_local_idmutation AS(

    SELECT 
        idmutation,
        COALESCE(count(iddispoloc),0) as nblocmut,
        array_supprimer_null(array_agg(idloc)) as l_idlocmut,
        --
        -- à partir de la version 9.3
        -- array_remove(array_agg(idloc), NULL) as l_idlocmut,
        COALESCE(sum(CASE WHEN codtyploc = 1 THEN 1 ELSE 0 END),0) AS nblocmai,
        COALESCE(sum(CASE WHEN codtyploc = 2 THEN 1 ELSE 0 END),0) AS nblocapt,
        COALESCE(sum(CASE WHEN codtyploc = 3 THEN 1 ELSE 0 END),0) AS nblocdep,
        COALESCE(sum(CASE WHEN codtyploc = 4 THEN 1 ELSE 0 END),0) AS nblocact,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 1 THEN 1 ELSE 0 END),0) AS nbapt1pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 2 THEN 1 ELSE 0 END),0) AS nbapt2pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 3 THEN 1 ELSE 0 END),0) AS nbapt3pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 4 THEN 1 ELSE 0 END),0) AS nbapt4pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc > 4 THEN 1 ELSE 0 END),0) AS nbapt5pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 1 THEN 1 ELSE 0 END),0) AS nbmai1pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 2 THEN 1 ELSE 0 END),0) AS nbmai2pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 3 THEN 1 ELSE 0 END),0) AS nbmai3pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 4 THEN 1 ELSE 0 END),0) AS nbmai4pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc > 4 THEN 1 ELSE 0 END),0) AS nbmai5pp,
        COALESCE(sum(sbati),0) AS sbati,
        COALESCE(sum(CASE WHEN codtyploc = 1 THEN sbati ELSE 0 END),0) AS sbatmai,
        COALESCE(sum(CASE WHEN codtyploc = 2 THEN sbati ELSE 0 END),0) AS sbatapt,
        COALESCE(sum(CASE WHEN codtyploc = 4 THEN sbati ELSE 0 END),0) AS sbatact,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 1 THEN sbati ELSE 0 END),0) AS sapt1pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 2 THEN sbati ELSE 0 END),0) AS sapt2pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 3 THEN sbati ELSE 0 END),0) AS sapt3pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc = 4 THEN sbati ELSE 0 END),0) AS sapt4pp,
        COALESCE(sum(CASE WHEN codtyploc = 2 AND nbpprinc > 4 THEN sbati ELSE 0 END),0) AS sapt5pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 1 THEN sbati ELSE 0 END),0) AS smai1pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 2 THEN sbati ELSE 0 END),0) AS smai2pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 3 THEN sbati ELSE 0 END),0) AS smai3pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc = 4 THEN sbati ELSE 0 END),0) AS smai4pp,
        COALESCE(sum(CASE WHEN codtyploc = 1 AND nbpprinc > 4 THEN sbati ELSE 0 END),0) AS smai5pp
    FROM (SELECT m.idmutation, l.iddispoloc, l.idloc, l.codtyploc, l.nbpprinc, l.sbati FROM dvf_d59.mutation m LEFT JOIN dvf_d59.local l ON m.idmutation = l.idmutation) t      
    GROUP BY idmutation
); 


INSERT INTO dvf_d62.mutation_plus
(
    idmutation, idmutinvar, idnatmut, codservch, refdoc, datemut, anneemut, moismut, coddep, libnatmut, nbartcgi, l_artcgi, vefa, valeurfonc, nbdispo, nblot, nbcomm, l_codinsee, nbsection, l_section, nbpar, l_idpar, nbparmut, l_idparmut, nbsuf, sterr, l_dcnt, nbvolmut, nblocmut, l_idlocmut, nblocmai, nblocapt, nblocdep, nblocact, nbapt1pp, nbapt2pp, nbapt3pp, nbapt4pp, nbapt5pp, nbmai1pp, nbmai2pp, nbmai3pp, nbmai4pp, nbmai5pp, sbati, sbatmai, sbatapt, sbatact, sapt1pp, sapt2pp, sapt3pp, sapt4pp, sapt5pp, smai1pp, smai2pp, smai3pp, smai4pp, smai5pp
)
(
SELECT 
	t.idmutation,
	t.idmutinvar,
	t.idnatmut,
	t.codservch,
	t.refdoc,
	t.datemut,
	t.anneemut,
	t.moismut,
	t.coddep,
	t1.libnatmut,
	t5.nbartcgi,
	t5.l_artcgi,
	t6.vefa,
	t2.valeurfonc,
	t2.nbdispo,
	t2.nblot,
	t7.nbcomm,
	t7.l_codinsee,
	t7.nbsection,
	t7.l_section,
	t7.nbpar,
	t7.l_idpar,
	t7.nbparmut,
	t7.l_idparmut,
	t3.nbsuf,
	t3.sterr,
	t3.l_dcnt,
	t4.nbvolmut,
	t0.nblocmut,
	t0.l_idlocmut,
	t0.nblocmai,
	t0.nblocapt,
	t0.nblocdep,
	t0.nblocact,
	t0.nbapt1pp,
	t0.nbapt2pp,
	t0.nbapt3pp,
	t0.nbapt4pp,
	t0.nbapt5pp,
	t0.nbmai1pp,
	t0.nbmai2pp,
	t0.nbmai3pp,
	t0.nbmai4pp,
	t0.nbmai5pp,
	t0.sbati,
	t0.sbatmai,
	t0.sbatapt,
	t0.sbatact,
	t0.sapt1pp,
	t0.sapt2pp,
	t0.sapt3pp,
	t0.sapt4pp,
	t0.sapt5pp,
	t0.smai1pp,
	t0.smai2pp,
	t0.smai3pp,
	t0.smai4pp,
	t0.smai5pp
FROM dvf_d62.mutation t 
LEFT JOIN dvf_d62.tmp_calcul_local_idmutation t0
	ON t.idmutation = t0.idmutation
LEFT JOIN dvf_d62.tmp_calcul_ann_nature_mutation_idmutation t1
	ON t.idmutation = t1.idmutation
LEFT JOIN dvf_d62.tmp_calcul_disposition_idmutation t2
	ON t.idmutation = t2.idmutation
LEFT JOIN dvf_d62.tmp_calcul_suf_idmutation t3
	ON t.idmutation = t3.idmutation
LEFT JOIN dvf_d62.tmp_calcul_volume_idmutation t4
	ON t.idmutation = t4.idmutation
LEFT JOIN dvf_d62.tmp_calcul_mutation_article_cgi_idmutation t5
	ON t.idmutation = t5.idmutation
LEFT JOIN dvf_d62.tmp_calcul_annexes_idmutation t6
	ON t.idmutation = t6.idmutation
LEFT JOIN dvf_d62.tmp_calcul_disposition_parcelle_idmutation t7
	ON t.idmutation = t7.idmutation
);
DROP TABLE IF EXISTS dvf_d62.tmp_calcul_ann_nature_mutation_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d62.tmp_calcul_annexes_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d62.tmp_calcul_disposition_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d62.tmp_calcul_disposition_parcelle_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d62.tmp_calcul_local_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d62.tmp_calcul_mutation_article_cgi_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d62.tmp_calcul_suf_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d62.tmp_calcul_volume_idmutation CASCADE;


INSERT INTO dvf_d59.mutation_plus
(
    idmutation, idmutinvar, idnatmut, codservch, refdoc, datemut, anneemut, moismut, coddep, libnatmut, nbartcgi, l_artcgi, vefa, valeurfonc, nbdispo, nblot, nbcomm, l_codinsee, nbsection, l_section, nbpar, l_idpar, nbparmut, l_idparmut, nbsuf, sterr, l_dcnt, nbvolmut, nblocmut, l_idlocmut, nblocmai, nblocapt, nblocdep, nblocact, nbapt1pp, nbapt2pp, nbapt3pp, nbapt4pp, nbapt5pp, nbmai1pp, nbmai2pp, nbmai3pp, nbmai4pp, nbmai5pp, sbati, sbatmai, sbatapt, sbatact, sapt1pp, sapt2pp, sapt3pp, sapt4pp, sapt5pp, smai1pp, smai2pp, smai3pp, smai4pp, smai5pp
)
(
SELECT 
	t.idmutation,
	t.idmutinvar,
	t.idnatmut,
	t.codservch,
	t.refdoc,
	t.datemut,
	t.anneemut,
	t.moismut,
	t.coddep,
	t1.libnatmut,
	t5.nbartcgi,
	t5.l_artcgi,
	t6.vefa,
	t2.valeurfonc,
	t2.nbdispo,
	t2.nblot,
	t7.nbcomm,
	t7.l_codinsee,
	t7.nbsection,
	t7.l_section,
	t7.nbpar,
	t7.l_idpar,
	t7.nbparmut,
	t7.l_idparmut,
	t3.nbsuf,
	t3.sterr,
	t3.l_dcnt,
	t4.nbvolmut,
	t0.nblocmut,
	t0.l_idlocmut,
	t0.nblocmai,
	t0.nblocapt,
	t0.nblocdep,
	t0.nblocact,
	t0.nbapt1pp,
	t0.nbapt2pp,
	t0.nbapt3pp,
	t0.nbapt4pp,
	t0.nbapt5pp,
	t0.nbmai1pp,
	t0.nbmai2pp,
	t0.nbmai3pp,
	t0.nbmai4pp,
	t0.nbmai5pp,
	t0.sbati,
	t0.sbatmai,
	t0.sbatapt,
	t0.sbatact,
	t0.sapt1pp,
	t0.sapt2pp,
	t0.sapt3pp,
	t0.sapt4pp,
	t0.sapt5pp,
	t0.smai1pp,
	t0.smai2pp,
	t0.smai3pp,
	t0.smai4pp,
	t0.smai5pp
FROM dvf_d59.mutation t 
LEFT JOIN dvf_d59.tmp_calcul_local_idmutation t0
	ON t.idmutation = t0.idmutation
LEFT JOIN dvf_d59.tmp_calcul_ann_nature_mutation_idmutation t1
	ON t.idmutation = t1.idmutation
LEFT JOIN dvf_d59.tmp_calcul_disposition_idmutation t2
	ON t.idmutation = t2.idmutation
LEFT JOIN dvf_d59.tmp_calcul_suf_idmutation t3
	ON t.idmutation = t3.idmutation
LEFT JOIN dvf_d59.tmp_calcul_volume_idmutation t4
	ON t.idmutation = t4.idmutation
LEFT JOIN dvf_d59.tmp_calcul_mutation_article_cgi_idmutation t5
	ON t.idmutation = t5.idmutation
LEFT JOIN dvf_d59.tmp_calcul_annexes_idmutation t6
	ON t.idmutation = t6.idmutation
LEFT JOIN dvf_d59.tmp_calcul_disposition_parcelle_idmutation t7
	ON t.idmutation = t7.idmutation
);
DROP TABLE IF EXISTS dvf_d59.tmp_calcul_ann_nature_mutation_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d59.tmp_calcul_annexes_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d59.tmp_calcul_disposition_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d59.tmp_calcul_disposition_parcelle_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d59.tmp_calcul_local_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d59.tmp_calcul_mutation_article_cgi_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d59.tmp_calcul_suf_idmutation CASCADE;

DROP TABLE IF EXISTS dvf_d59.tmp_calcul_volume_idmutation CASCADE;

DROP TABLE IF EXISTS dvf.mutation CASCADE;

ALTER TABLE dvf.mutation_plus RENAME To mutation;

DROP TABLE IF EXISTS dvf_d62.mutation CASCADE;

ALTER TABLE dvf_d62.mutation_plus RENAME To mutation;

DROP TABLE IF EXISTS dvf_d59.mutation CASCADE;

ALTER TABLE dvf_d59.mutation_plus RENAME To mutation;

DROP TRIGGER insert_mutation_plus_trigger ON dvf.mutation;
--CREATE TRIGGER insert_mutation_trigger
--BEFORE INSERT ON dvf.mutation
--FOR EACH ROW EXECUTE PROCEDURE dvf.mutation_insert_trigger();
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
-- Début d'exécution le 29/06/2016 à 21:00:48
---

ALTER TABLE dvf.local RENAME To local_plus;

ALTER TRIGGER insert_local_trigger ON dvf.local_plus RENAME TO insert_local_plus_trigger

ALTER TABLE dvf.disposition_parcelle RENAME To disposition_parcelle_plus;

ALTER TRIGGER insert_disposition_parcelle_trigger ON dvf.disposition_parcelle_plus RENAME TO insert_disposition_parcelle_plus_trigger

ALTER TABLE dvf.mutation RENAME To mutation_plus;

ALTER TRIGGER insert_mutation_trigger ON dvf.mutation_plus RENAME TO insert_mutation_plus_trigger

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

COMMENT ON COLUMN dvf_d59.local_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d59.local_plus.iddispoloc IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.local_plus.l_idmutpre IS 'identifiants des mutations précédentes du local ayant eu lieu à la date de mutation précédente (datemutpre)';

COMMENT ON COLUMN dvf_d59.local_plus.codtyploc IS 'code du type de local';

COMMENT ON COLUMN dvf_d59.local_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.local_plus.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.local_plus.identloc IS 'identifiant du local';

COMMENT ON COLUMN dvf_d59.local_plus.l_idmutsui IS 'identifiants des mutations suivantes du local ayant eu lieu à la date de mutation suivante (datemutsui)';

COMMENT ON COLUMN dvf_d59.local_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.local_plus.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d59.local_plus.idloc IS 'identifiant du local (Fichier Fonciers)';

COMMENT ON COLUMN dvf_d59.local_plus.datemutpre IS 'date de la précédente mutation du local';

COMMENT ON COLUMN dvf_d59.local_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.local_plus.libtyploc IS 'libellé du type de local';

COMMENT ON COLUMN dvf_d59.local_plus.nbmutjour IS 'nombre de mutations du local au cours de la journée';

COMMENT ON COLUMN dvf_d59.local_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.local_plus.nbpprinc IS 'nombre de pièces principales';

COMMENT ON COLUMN dvf_d59.local_plus.sbati IS 'surface réelle attachée à l''identifiant local';

COMMENT ON COLUMN dvf_d59.local_plus.datemutsui IS 'date de la mutation suivante du local';

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

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.prefsect IS 'prefixe de section de la parcelle';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.codcomm IS 'code insee de la commune';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcntnat IS 'surface de suf de type naturel ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt06 IS 'surface de suf de type 06 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.iddispo IS 'identifiant de la table disposition';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.parcvendue IS 'Vrai si la parcelle fait partie de la vente';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.iddispopar IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt08 IS 'surface de suf de type 08 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.l_idmutsui IS 'identifiants des mutations suivantes de la parcelle ayant eu lieu à la date de mutation suivante (datemutsui)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcntagri IS 'surface de suf de type agricole ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.idparcelle IS 'identifiant de la table parcelle';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.datemutsui IS 'date de la mutation suivante de la parcelle (date postérieure)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.nosect IS 'numéro de section de la parcelle';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt01 IS 'surface de suf de type 01 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.noplan IS 'numéro de la parcelle';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.nbmutjour IS 'nombre de mutations de la parcelle au cours de la journée';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt13 IS 'surface de suf de type 13 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt09 IS 'surface de suf de type 09 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt05 IS 'surface de suf de type 05 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt02 IS 'surface de suf de type 02  ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt04 IS 'surface de suf de type 04 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt10 IS 'surface de suf de type 10 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.l_idmutpre IS 'identifiants des mutations précédentes de la parcelle ayant eu lieu à la date de mutation précédente (datemutpre)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.datemutpre IS 'date de la précédente mutation de la parcelle (date antérieure)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt07 IS 'surface de suf de type 07 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcntsol IS 'surface de suf de type sol ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt12 IS 'surface de suf de type 12 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt11 IS 'surface de suf de type 11 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.dcnt03 IS 'surface de suf de type 03 ayant muté';

COMMENT ON COLUMN dvf_d59.disposition_parcelle_plus.nbmutannee IS 'nombre de mutations de la parcelle au cours de l''année calendaire';

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

COMMENT ON COLUMN dvf_d59.mutation_plus.l_idlocmut IS 'liste des identifiants de locaux ayant muté (idloc)';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbapt4pp IS 'nombre d''appartements avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.sapt2pp IS 'surface de l''ensemble des appartements avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbapt2pp IS 'nombre d''appartements avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.sbatapt IS 'surface de l''ensemble des appartements ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbpar IS 'nombre de parcelles concernées par la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.valeurfonc IS 'prix ou évaluation déclarée dans le cadre d''une mutation onéreuse';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbcomm IS 'nombre de communes concernées par la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.sapt4pp IS 'surface de l''ensemble des appartements avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblocdep IS 'nombre de dépendances ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.sapt5pp IS 'surface de l''ensemble des appartements avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.sapt1pp IS 'surface de l''ensemble des appartements avec 1 pièce principale ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.smai1pp IS 'surface de l''ensemble des maisons avec 1 pièce principale ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbmai2pp IS 'nombre de maisons avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblocmai IS 'nombre de maisons ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.sbati IS 'surface de l''ensemble du bâti ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblocmut IS 'nombre de locaux ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_dcnt IS 'Liste ordonnée des surfaces de suf de 01 à 13';

COMMENT ON COLUMN dvf_d59.mutation_plus.libnatmut IS 'libellé de la nature de mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.smai2pp IS 'surface de l''ensemble des maisons avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbmai5pp IS 'nombre de maisons avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbartcgi IS 'nombre d''articles du Code Général des Impôts (CGI) associés à la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbmai3pp IS 'nombre de maisons avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.smai4pp IS 'surface de l''ensemble des maisons avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.sterr IS 'surface de terrain ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_artcgi IS 'liste des codes d’articles CGI (Code Général des Impôts) associés à la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.vefa IS 'vrai si la mutation est une Vente en l''état futur d''achèvement (VEFA)';

COMMENT ON COLUMN dvf_d59.mutation_plus.smai3pp IS 'surface de l''ensemble des maisons avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbapt1pp IS 'nombre d''appartements avec une pièce principale ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.sapt3pp IS 'surface de l''ensemble des appartements avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_codinsee IS 'liste des codes INSEE des communes concernées par la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbsection IS 'nombre de sections concernées par la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_idparmut IS 'liste des identifiants de parcelles ayant muté (idpar)';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbsuf IS 'nombre de subdivisions fiscales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblocact IS 'nombre de locaux d''activités ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbapt5pp IS 'nombre d''appartements avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbparmut IS 'nombre de parcelles ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.sbatact IS 'surface de l''ensemble du bâti d’activité ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.idmutinvar IS 'identifiant invariant de la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbmai1pp IS 'nombre de maisons avec une pièce principale ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.refdoc IS 'référence d''enregistrement du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbapt3pp IS 'nombre d''appartements avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_section IS 'liste des sections concernées par la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.sbatmai IS 'surface de l''ensemble des maisons ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.l_idpar IS 'liste des identifiants de parcelles concernées par la mutation (idpar)';

COMMENT ON COLUMN dvf_d59.mutation_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbvolmut IS 'nombre de volumes ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbdispo IS 'nombre de dispositions associées à la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.nbmai4pp IS 'nombre de maisons avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblot IS 'nombre total de lots dans la mutation';

COMMENT ON COLUMN dvf_d59.mutation_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.mutation_plus.nblocapt IS 'nombre d''appartements ayant muté';

COMMENT ON COLUMN dvf_d59.mutation_plus.codservch IS 'code du service de conservation des hypothèques';

COMMENT ON COLUMN dvf_d59.mutation_plus.smai5pp IS 'surface de l''ensemble des maisons avec au moins 5 pièces principales ayant muté';

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

COMMENT ON COLUMN dvf_d62.local_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d62.local_plus.iddispoloc IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.local_plus.l_idmutpre IS 'identifiants des mutations précédentes du local ayant eu lieu à la date de mutation précédente (datemutpre)';

COMMENT ON COLUMN dvf_d62.local_plus.codtyploc IS 'code du type de local';

COMMENT ON COLUMN dvf_d62.local_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.local_plus.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.local_plus.identloc IS 'identifiant du local';

COMMENT ON COLUMN dvf_d62.local_plus.l_idmutsui IS 'identifiants des mutations suivantes du local ayant eu lieu à la date de mutation suivante (datemutsui)';

COMMENT ON COLUMN dvf_d62.local_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.local_plus.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d62.local_plus.idloc IS 'identifiant du local (Fichier Fonciers)';

COMMENT ON COLUMN dvf_d62.local_plus.datemutpre IS 'date de la précédente mutation du local';

COMMENT ON COLUMN dvf_d62.local_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.local_plus.libtyploc IS 'libellé du type de local';

COMMENT ON COLUMN dvf_d62.local_plus.nbmutjour IS 'nombre de mutations du local au cours de la journée';

COMMENT ON COLUMN dvf_d62.local_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.local_plus.nbpprinc IS 'nombre de pièces principales';

COMMENT ON COLUMN dvf_d62.local_plus.sbati IS 'surface réelle attachée à l''identifiant local';

COMMENT ON COLUMN dvf_d62.local_plus.datemutsui IS 'date de la mutation suivante du local';

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

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.prefsect IS 'prefixe de section de la parcelle';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.codcomm IS 'code insee de la commune';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcntnat IS 'surface de suf de type naturel ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt06 IS 'surface de suf de type 06 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.iddispo IS 'identifiant de la table disposition';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.parcvendue IS 'Vrai si la parcelle fait partie de la vente';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.iddispopar IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt08 IS 'surface de suf de type 08 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.l_idmutsui IS 'identifiants des mutations suivantes de la parcelle ayant eu lieu à la date de mutation suivante (datemutsui)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcntagri IS 'surface de suf de type agricole ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.idparcelle IS 'identifiant de la table parcelle';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.datemutsui IS 'date de la mutation suivante de la parcelle (date postérieure)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.nosect IS 'numéro de section de la parcelle';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt01 IS 'surface de suf de type 01 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.noplan IS 'numéro de la parcelle';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.nbmutjour IS 'nombre de mutations de la parcelle au cours de la journée';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt13 IS 'surface de suf de type 13 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt09 IS 'surface de suf de type 09 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt05 IS 'surface de suf de type 05 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt02 IS 'surface de suf de type 02  ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt04 IS 'surface de suf de type 04 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt10 IS 'surface de suf de type 10 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.l_idmutpre IS 'identifiants des mutations précédentes de la parcelle ayant eu lieu à la date de mutation précédente (datemutpre)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.datemutpre IS 'date de la précédente mutation de la parcelle (date antérieure)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt07 IS 'surface de suf de type 07 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcntsol IS 'surface de suf de type sol ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt12 IS 'surface de suf de type 12 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt11 IS 'surface de suf de type 11 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.dcnt03 IS 'surface de suf de type 03 ayant muté';

COMMENT ON COLUMN dvf_d62.disposition_parcelle_plus.nbmutannee IS 'nombre de mutations de la parcelle au cours de l''année calendaire';

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

COMMENT ON COLUMN dvf_d62.mutation_plus.l_idlocmut IS 'liste des identifiants de locaux ayant muté (idloc)';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbapt4pp IS 'nombre d''appartements avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.sapt2pp IS 'surface de l''ensemble des appartements avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbapt2pp IS 'nombre d''appartements avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.sbatapt IS 'surface de l''ensemble des appartements ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbpar IS 'nombre de parcelles concernées par la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.valeurfonc IS 'prix ou évaluation déclarée dans le cadre d''une mutation onéreuse';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbcomm IS 'nombre de communes concernées par la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.sapt4pp IS 'surface de l''ensemble des appartements avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblocdep IS 'nombre de dépendances ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.sapt5pp IS 'surface de l''ensemble des appartements avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.sapt1pp IS 'surface de l''ensemble des appartements avec 1 pièce principale ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.smai1pp IS 'surface de l''ensemble des maisons avec 1 pièce principale ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbmai2pp IS 'nombre de maisons avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblocmai IS 'nombre de maisons ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.sbati IS 'surface de l''ensemble du bâti ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblocmut IS 'nombre de locaux ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_dcnt IS 'Liste ordonnée des surfaces de suf de 01 à 13';

COMMENT ON COLUMN dvf_d62.mutation_plus.libnatmut IS 'libellé de la nature de mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.smai2pp IS 'surface de l''ensemble des maisons avec 2 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbmai5pp IS 'nombre de maisons avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbartcgi IS 'nombre d''articles du Code Général des Impôts (CGI) associés à la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbmai3pp IS 'nombre de maisons avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.smai4pp IS 'surface de l''ensemble des maisons avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.sterr IS 'surface de terrain ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_artcgi IS 'liste des codes d’articles CGI (Code Général des Impôts) associés à la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.vefa IS 'vrai si la mutation est une Vente en l''état futur d''achèvement (VEFA)';

COMMENT ON COLUMN dvf_d62.mutation_plus.smai3pp IS 'surface de l''ensemble des maisons avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbapt1pp IS 'nombre d''appartements avec une pièce principale ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.sapt3pp IS 'surface de l''ensemble des appartements avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_codinsee IS 'liste des codes INSEE des communes concernées par la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbsection IS 'nombre de sections concernées par la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_idparmut IS 'liste des identifiants de parcelles ayant muté (idpar)';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbsuf IS 'nombre de subdivisions fiscales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblocact IS 'nombre de locaux d''activités ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbapt5pp IS 'nombre d''appartements avec au moins 5 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbparmut IS 'nombre de parcelles ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.sbatact IS 'surface de l''ensemble du bâti d’activité ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.idmutinvar IS 'identifiant invariant de la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbmai1pp IS 'nombre de maisons avec une pièce principale ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.refdoc IS 'référence d''enregistrement du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbapt3pp IS 'nombre d''appartements avec 3 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_section IS 'liste des sections concernées par la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.sbatmai IS 'surface de l''ensemble des maisons ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.l_idpar IS 'liste des identifiants de parcelles concernées par la mutation (idpar)';

COMMENT ON COLUMN dvf_d62.mutation_plus.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbvolmut IS 'nombre de volumes ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbdispo IS 'nombre de dispositions associées à la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.nbmai4pp IS 'nombre de maisons avec 4 pièces principales ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblot IS 'nombre total de lots dans la mutation';

COMMENT ON COLUMN dvf_d62.mutation_plus.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.mutation_plus.nblocapt IS 'nombre d''appartements ayant muté';

COMMENT ON COLUMN dvf_d62.mutation_plus.codservch IS 'code du service de conservation des hypothèques';

COMMENT ON COLUMN dvf_d62.mutation_plus.smai5pp IS 'surface de l''ensemble des maisons avec au moins 5 pièces principales ayant muté';


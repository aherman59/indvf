---
-- SCRIPT DE CREATION DU MODELE DVF+ 
-- ETAPE 1/2
-- 
-- Auteur: 
--    CEREMA "PCI Foncier et Stratégies Foncières"
--    Direction Territoriale Nord-Picardie
--    Antoine HERMAN
--    Jérôme DOUCHE
--
-- Ce script est fourni sous licence Creative Commons 3.0 CC-BY-SA
--
-- Début d'exécution le 18/07/2016 à 22:50:30
---

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

DROP SCHEMA IF EXISTS dvf_d62 CASCADE;

CREATE SCHEMA dvf_d62;

DROP SCHEMA IF EXISTS dvf_d59 CASCADE;

CREATE SCHEMA dvf_d59;

DROP SCHEMA IF EXISTS dvf CASCADE;

CREATE SCHEMA dvf;

DROP SCHEMA IF EXISTS dvf_annexe CASCADE;

CREATE SCHEMA dvf_annexe;

DROP TABLE IF EXISTS dvf.mutation CASCADE;

-- table dvf.mutation
CREATE TABLE dvf.mutation
(
idmutation serial,
idmutinvar varchar(18),
idnatmut integer,
codservch varchar(7),
refdoc varchar(10),
datemut Date,
anneemut integer,
moismut integer,
coddep varchar(3)   
);

COMMENT ON TABLE dvf.mutation IS 'table des mutations';

COMMENT ON COLUMN dvf.mutation.idmutinvar IS 'identifiant invariant de la mutation';

COMMENT ON COLUMN dvf.mutation.coddep IS 'code du département';

COMMENT ON COLUMN dvf.mutation.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf.mutation.refdoc IS 'référence d''enregistrement du document (acte de vente)';

COMMENT ON COLUMN dvf.mutation.codservch IS 'code du service de conservation des hypothèques';

COMMENT ON COLUMN dvf.mutation.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf.mutation.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf.mutation.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.mutation.moismut IS 'mois de signature du document';

DROP TABLE IF EXISTS dvf.mutation_article_cgi CASCADE;

-- table dvf.mutation_article_cgi
CREATE TABLE dvf.mutation_article_cgi
(
idmutation integer,
idartcgi integer,
ordarticgi integer,
coddep varchar(3)   
);

COMMENT ON TABLE dvf.mutation_article_cgi IS 'table des articles du code général des impôts (CGI) attachés à la mutation';

COMMENT ON COLUMN dvf.mutation_article_cgi.coddep IS 'code du département';

COMMENT ON COLUMN dvf.mutation_article_cgi.ordarticgi IS 'numéro de l''ordre de l''article cgi';

COMMENT ON COLUMN dvf.mutation_article_cgi.idartcgi IS 'identifiant de la table annexe ann_cgi';

COMMENT ON COLUMN dvf.mutation_article_cgi.idmutation IS 'identifiant de clef primaire de la table mutation';

DROP TABLE IF EXISTS dvf.disposition CASCADE;

-- table dvf.disposition
CREATE TABLE dvf.disposition
(
iddispo serial,
idmutation integer,
nodispo integer,
valeurfonc numeric,
nblot integer,
coddep varchar(3)   
);

COMMENT ON TABLE dvf.disposition IS 'table des dispositions';

COMMENT ON COLUMN dvf.disposition.iddispo IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.disposition.coddep IS 'code du département';

COMMENT ON COLUMN dvf.disposition.nodispo IS 'numéro de disposition';

COMMENT ON COLUMN dvf.disposition.valeurfonc IS 'prix ou évaluation déclarée dans le cadre d''une mutation onéreuse';

COMMENT ON COLUMN dvf.disposition.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.disposition.nblot IS 'nombre total de lots dans la disposition';

DROP TABLE IF EXISTS dvf.disposition_parcelle CASCADE;

-- table dvf.disposition_parcelle
CREATE TABLE dvf.disposition_parcelle
(
iddispopar serial,
iddispo integer,
idparcelle integer,
idmutation integer,
coddep varchar(3),
datemut Date,
anneemut integer,
moismut integer   
);

COMMENT ON TABLE dvf.disposition_parcelle IS 'table des parcelles attachées à une disposition';

COMMENT ON COLUMN dvf.disposition_parcelle.iddispo IS 'identifiant de la table disposition';

COMMENT ON COLUMN dvf.disposition_parcelle.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf.disposition_parcelle.idparcelle IS 'identifiant de la table parcelle';

COMMENT ON COLUMN dvf.disposition_parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf.disposition_parcelle.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf.disposition_parcelle.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.disposition_parcelle.iddispopar IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.disposition_parcelle.moismut IS 'mois de signature du document';

DROP TABLE IF EXISTS dvf.parcelle CASCADE;

-- table dvf.parcelle
CREATE TABLE dvf.parcelle
(
idparcelle serial,
idpar varchar(14),
coddep varchar(3),
codcomm varchar(3),
prefsect varchar(3),
nosect varchar(2),
noplan varchar(4)   
);

COMMENT ON TABLE dvf.parcelle IS 'table des parcelles';

COMMENT ON COLUMN dvf.parcelle.noplan IS 'numéro de la parcelle';

COMMENT ON COLUMN dvf.parcelle.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf.parcelle.prefsect IS 'prefixe de section de la parcelle';

COMMENT ON COLUMN dvf.parcelle.codcomm IS 'code insee de la commune';

COMMENT ON COLUMN dvf.parcelle.idparcelle IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf.parcelle.nosect IS 'numéro de section de la parcelle';

DROP TABLE IF EXISTS dvf.local CASCADE;

-- table dvf.local
CREATE TABLE dvf.local
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
moismut integer   
);

COMMENT ON TABLE dvf.local IS 'table des locaux';

COMMENT ON COLUMN dvf.local.sbati IS 'surface réelle attachée à l''identifiant local';

COMMENT ON COLUMN dvf.local.codtyploc IS 'code du type de local';

COMMENT ON COLUMN dvf.local.iddispoloc IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.local.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf.local.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf.local.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf.local.libtyploc IS 'libellé du type de local';

COMMENT ON COLUMN dvf.local.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf.local.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf.local.coddep IS 'code du département';

COMMENT ON COLUMN dvf.local.idloc IS 'identifiant du local (Fichier Fonciers)';

COMMENT ON COLUMN dvf.local.nbpprinc IS 'nombre de pièces principales';

COMMENT ON COLUMN dvf.local.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.local.identloc IS 'identifiant du local';

DROP TABLE IF EXISTS dvf.adresse CASCADE;

-- table dvf.adresse
CREATE TABLE dvf.adresse
(
idadresse serial,
novoie integer,
btq varchar(1),
typvoie varchar(4),
codvoie varchar(4),
voie varchar(254),
codepostal varchar(5),
commune varchar(45),
idadrinvar varchar(532),
coddep varchar(3)   
);

COMMENT ON TABLE dvf.adresse IS 'table contenant les adresses (provenant des parcelles et des locaux';

COMMENT ON COLUMN dvf.adresse.codvoie IS 'code de la voie';

COMMENT ON COLUMN dvf.adresse.idadrinvar IS 'identifiant invariant de la table adresse';

COMMENT ON COLUMN dvf.adresse.idadresse IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.adresse.coddep IS 'code du département';

COMMENT ON COLUMN dvf.adresse.commune IS 'libellé de la commune';

COMMENT ON COLUMN dvf.adresse.typvoie IS 'type de voie';

COMMENT ON COLUMN dvf.adresse.novoie IS 'numéro de la voie';

COMMENT ON COLUMN dvf.adresse.voie IS 'libellé de la voie';

COMMENT ON COLUMN dvf.adresse.codepostal IS 'code postal';

COMMENT ON COLUMN dvf.adresse.btq IS 'indice de répétition';

DROP TABLE IF EXISTS dvf.suf CASCADE;

-- table dvf.suf
CREATE TABLE dvf.suf
(
iddisposuf serial,
iddispopar integer,
idmutation integer,
nbsufidt integer,
sterr numeric,
natcult varchar(2),
natcultspe varchar(5),
idsufinvar varchar(18),
coddep varchar(3),
nodcnt integer   
);

COMMENT ON TABLE dvf.suf IS 'table des subdivisions fiscales';

COMMENT ON COLUMN dvf.suf.sterr IS 'surface de terrain ayant muté';

COMMENT ON COLUMN dvf.suf.natcult IS 'libellé de nature de culture';

COMMENT ON COLUMN dvf.suf.natcultspe IS 'groupe de nature de culture spéciale';

COMMENT ON COLUMN dvf.suf.nbsufidt IS 'nombre de suf identiques';

COMMENT ON COLUMN dvf.suf.idsufinvar IS 'identifiant invariant de la table suf';

COMMENT ON COLUMN dvf.suf.iddisposuf IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.suf.coddep IS 'code du département';

COMMENT ON COLUMN dvf.suf.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.suf.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf.suf.nodcnt IS 'type de la suf';

DROP TABLE IF EXISTS dvf.volume CASCADE;

-- table dvf.volume
CREATE TABLE dvf.volume
(
iddispovol serial,
iddispopar integer,
idmutation integer,
novolume varchar(7),
coddep varchar(3)   
);

COMMENT ON TABLE dvf.volume IS 'table des volumes (division de l''espace dans la hauteur pour certaines co-propriétés verticales';

COMMENT ON COLUMN dvf.volume.novolume IS 'numéro de volume';

COMMENT ON COLUMN dvf.volume.coddep IS 'code du département';

COMMENT ON COLUMN dvf.volume.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.volume.iddispovol IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.volume.iddispopar IS 'identifiant de la table disposition_parcelle';

DROP TABLE IF EXISTS dvf.lot CASCADE;

-- table dvf.lot
CREATE TABLE dvf.lot
(
iddispolot serial,
iddispopar integer,
idmutation integer,
iddispoloc integer,
nolot varchar(7),
scarrez numeric,
coddep varchar(3)   
);

COMMENT ON TABLE dvf.lot IS 'table des lots (seuls les 5 premiers lots sont mentionnés)';

COMMENT ON COLUMN dvf.lot.coddep IS 'code du département';

COMMENT ON COLUMN dvf.lot.nolot IS 'numéro du lot';

COMMENT ON COLUMN dvf.lot.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf.lot.scarrez IS 'surface Loi Carrez du lot';

COMMENT ON COLUMN dvf.lot.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.lot.iddispolot IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.lot.iddispoloc IS 'identifiant de la table local';

DROP TABLE IF EXISTS dvf.adresse_dispoparc CASCADE;

-- table dvf.adresse_dispoparc
CREATE TABLE dvf.adresse_dispoparc
(
idadresse integer,
iddispopar integer,
coddep varchar(3),
idmutation integer   
);

COMMENT ON TABLE dvf.adresse_dispoparc IS 'table de liaison entre la table adresse et la table disposition_parcelle';

COMMENT ON COLUMN dvf.adresse_dispoparc.coddep IS 'code du département';

COMMENT ON COLUMN dvf.adresse_dispoparc.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.adresse_dispoparc.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf.adresse_dispoparc.idadresse IS 'identifiant de la table adresse';

DROP TABLE IF EXISTS dvf.adresse_local CASCADE;

-- table dvf.adresse_local
CREATE TABLE dvf.adresse_local
(
idadresse integer,
iddispoloc integer,
coddep varchar(3),
idmutation integer   
);

COMMENT ON TABLE dvf.adresse_local IS 'table de liaison entre la table adresse et la table local';

COMMENT ON COLUMN dvf.adresse_local.coddep IS 'code du département';

COMMENT ON COLUMN dvf.adresse_local.iddispoloc IS 'identifiant de la table local';

COMMENT ON COLUMN dvf.adresse_local.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.adresse_local.idadresse IS 'identifiant de la table adresse';

DROP TABLE IF EXISTS dvf_d62.mutation CASCADE;

-- table fille dvf_d62.mutation
CREATE TABLE dvf_d62.mutation
(   
)INHERITS (dvf.mutation);        

ALTER TABLE dvf_d62.mutation 
ADD CONSTRAINT mutation_pkey PRIMARY KEY (idmutation);

ALTER TABLE dvf_d62.mutation 
ADD CONSTRAINT mutation_unique UNIQUE (codservch, refdoc);

ALTER TABLE dvf_d62.mutation 
ADD CONSTRAINT mutation_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.mutation IS 'table des mutations';

COMMENT ON COLUMN dvf_d62.mutation.idmutinvar IS 'identifiant invariant de la mutation';

COMMENT ON COLUMN dvf_d62.mutation.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.mutation.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.mutation.refdoc IS 'référence d''enregistrement du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.mutation.codservch IS 'code du service de conservation des hypothèques';

COMMENT ON COLUMN dvf_d62.mutation.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf_d62.mutation.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.mutation.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.mutation.moismut IS 'mois de signature du document';

DROP TABLE IF EXISTS dvf_d62.mutation_article_cgi CASCADE;

-- table fille dvf_d62.mutation_article_cgi
CREATE TABLE dvf_d62.mutation_article_cgi
(   
)INHERITS (dvf.mutation_article_cgi);        

ALTER TABLE dvf_d62.mutation_article_cgi 
ADD CONSTRAINT mutation_article_cgi_pkey PRIMARY KEY (idmutation, idartcgi);

ALTER TABLE dvf_d62.mutation_article_cgi 
ADD CONSTRAINT mutation_article_cgi_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.mutation_article_cgi IS 'table des articles du code général des impôts (CGI) attachés à la mutation';

COMMENT ON COLUMN dvf_d62.mutation_article_cgi.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.mutation_article_cgi.ordarticgi IS 'numéro de l''ordre de l''article cgi';

COMMENT ON COLUMN dvf_d62.mutation_article_cgi.idartcgi IS 'identifiant de la table annexe ann_cgi';

COMMENT ON COLUMN dvf_d62.mutation_article_cgi.idmutation IS 'identifiant de clef primaire de la table mutation';

DROP TABLE IF EXISTS dvf_d62.disposition CASCADE;

-- table fille dvf_d62.disposition
CREATE TABLE dvf_d62.disposition
(   
)INHERITS (dvf.disposition);        

ALTER TABLE dvf_d62.disposition 
ADD CONSTRAINT disposition_pkey PRIMARY KEY (iddispo);

ALTER TABLE dvf_d62.disposition 
ADD CONSTRAINT disposition_unique UNIQUE (idmutation, nodispo);

ALTER TABLE dvf_d62.disposition 
ADD CONSTRAINT disposition_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.disposition IS 'table des dispositions';

COMMENT ON COLUMN dvf_d62.disposition.iddispo IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.disposition.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.disposition.nodispo IS 'numéro de disposition';

COMMENT ON COLUMN dvf_d62.disposition.valeurfonc IS 'prix ou évaluation déclarée dans le cadre d''une mutation onéreuse';

COMMENT ON COLUMN dvf_d62.disposition.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.disposition.nblot IS 'nombre total de lots dans la disposition';

DROP TABLE IF EXISTS dvf_d62.disposition_parcelle CASCADE;

-- table fille dvf_d62.disposition_parcelle
CREATE TABLE dvf_d62.disposition_parcelle
(   
)INHERITS (dvf.disposition_parcelle);        

ALTER TABLE dvf_d62.disposition_parcelle 
ADD CONSTRAINT disposition_parcelle_pkey PRIMARY KEY (iddispopar);

ALTER TABLE dvf_d62.disposition_parcelle 
ADD CONSTRAINT disposition_parcelle_unique UNIQUE (iddispo, idparcelle);

ALTER TABLE dvf_d62.disposition_parcelle 
ADD CONSTRAINT disposition_parcelle_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.disposition_parcelle IS 'table des parcelles attachées à une disposition';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.iddispo IS 'identifiant de la table disposition';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.idparcelle IS 'identifiant de la table parcelle';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.iddispopar IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.moismut IS 'mois de signature du document';

DROP TABLE IF EXISTS dvf_d62.parcelle CASCADE;

-- table fille dvf_d62.parcelle
CREATE TABLE dvf_d62.parcelle
(   
)INHERITS (dvf.parcelle);        

ALTER TABLE dvf_d62.parcelle 
ADD CONSTRAINT parcelle_pkey PRIMARY KEY (idparcelle);

ALTER TABLE dvf_d62.parcelle 
ADD CONSTRAINT parcelle_unique UNIQUE (idpar);

ALTER TABLE dvf_d62.parcelle 
ADD CONSTRAINT parcelle_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.parcelle IS 'table des parcelles';

COMMENT ON COLUMN dvf_d62.parcelle.noplan IS 'numéro de la parcelle';

COMMENT ON COLUMN dvf_d62.parcelle.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d62.parcelle.prefsect IS 'prefixe de section de la parcelle';

COMMENT ON COLUMN dvf_d62.parcelle.codcomm IS 'code insee de la commune';

COMMENT ON COLUMN dvf_d62.parcelle.idparcelle IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.parcelle.nosect IS 'numéro de section de la parcelle';

DROP TABLE IF EXISTS dvf_d62.local CASCADE;

-- table fille dvf_d62.local
CREATE TABLE dvf_d62.local
(   
)INHERITS (dvf.local);        

ALTER TABLE dvf_d62.local 
ADD CONSTRAINT local_pkey PRIMARY KEY (iddispoloc);

ALTER TABLE dvf_d62.local 
ADD CONSTRAINT local_unique UNIQUE (iddispopar, identloc);

ALTER TABLE dvf_d62.local 
ADD CONSTRAINT local_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.local IS 'table des locaux';

COMMENT ON COLUMN dvf_d62.local.sbati IS 'surface réelle attachée à l''identifiant local';

COMMENT ON COLUMN dvf_d62.local.codtyploc IS 'code du type de local';

COMMENT ON COLUMN dvf_d62.local.iddispoloc IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.local.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.local.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d62.local.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.local.libtyploc IS 'libellé du type de local';

COMMENT ON COLUMN dvf_d62.local.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d62.local.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.local.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.local.idloc IS 'identifiant du local (Fichier Fonciers)';

COMMENT ON COLUMN dvf_d62.local.nbpprinc IS 'nombre de pièces principales';

COMMENT ON COLUMN dvf_d62.local.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.local.identloc IS 'identifiant du local';

DROP TABLE IF EXISTS dvf_d62.adresse CASCADE;

-- table fille dvf_d62.adresse
CREATE TABLE dvf_d62.adresse
(   
)INHERITS (dvf.adresse);        

ALTER TABLE dvf_d62.adresse 
ADD CONSTRAINT adresse_pkey PRIMARY KEY (idadresse);

ALTER TABLE dvf_d62.adresse 
ADD CONSTRAINT adresse_unique UNIQUE (idadrinvar);

ALTER TABLE dvf_d62.adresse 
ADD CONSTRAINT adresse_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.adresse IS 'table contenant les adresses (provenant des parcelles et des locaux';

COMMENT ON COLUMN dvf_d62.adresse.codvoie IS 'code de la voie';

COMMENT ON COLUMN dvf_d62.adresse.idadrinvar IS 'identifiant invariant de la table adresse';

COMMENT ON COLUMN dvf_d62.adresse.idadresse IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.adresse.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.adresse.commune IS 'libellé de la commune';

COMMENT ON COLUMN dvf_d62.adresse.typvoie IS 'type de voie';

COMMENT ON COLUMN dvf_d62.adresse.novoie IS 'numéro de la voie';

COMMENT ON COLUMN dvf_d62.adresse.voie IS 'libellé de la voie';

COMMENT ON COLUMN dvf_d62.adresse.codepostal IS 'code postal';

COMMENT ON COLUMN dvf_d62.adresse.btq IS 'indice de répétition';

DROP TABLE IF EXISTS dvf_d62.suf CASCADE;

-- table fille dvf_d62.suf
CREATE TABLE dvf_d62.suf
(   
)INHERITS (dvf.suf);        

ALTER TABLE dvf_d62.suf 
ADD CONSTRAINT suf_pkey PRIMARY KEY (iddisposuf);

ALTER TABLE dvf_d62.suf 
ADD CONSTRAINT suf_unique UNIQUE (iddispopar, nbsufidt, idsufinvar);

ALTER TABLE dvf_d62.suf 
ADD CONSTRAINT suf_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.suf IS 'table des subdivisions fiscales';

COMMENT ON COLUMN dvf_d62.suf.sterr IS 'surface de terrain ayant muté';

COMMENT ON COLUMN dvf_d62.suf.natcult IS 'libellé de nature de culture';

COMMENT ON COLUMN dvf_d62.suf.natcultspe IS 'groupe de nature de culture spéciale';

COMMENT ON COLUMN dvf_d62.suf.nbsufidt IS 'nombre de suf identiques';

COMMENT ON COLUMN dvf_d62.suf.idsufinvar IS 'identifiant invariant de la table suf';

COMMENT ON COLUMN dvf_d62.suf.iddisposuf IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.suf.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.suf.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.suf.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.suf.nodcnt IS 'type de la suf';

DROP TABLE IF EXISTS dvf_d62.volume CASCADE;

-- table fille dvf_d62.volume
CREATE TABLE dvf_d62.volume
(   
)INHERITS (dvf.volume);        

ALTER TABLE dvf_d62.volume 
ADD CONSTRAINT volume_pkey PRIMARY KEY (iddispovol);

ALTER TABLE dvf_d62.volume 
ADD CONSTRAINT volume_unique UNIQUE (iddispopar, novolume);

ALTER TABLE dvf_d62.volume 
ADD CONSTRAINT volume_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.volume IS 'table des volumes (division de l''espace dans la hauteur pour certaines co-propriétés verticales';

COMMENT ON COLUMN dvf_d62.volume.novolume IS 'numéro de volume';

COMMENT ON COLUMN dvf_d62.volume.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.volume.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.volume.iddispovol IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.volume.iddispopar IS 'identifiant de la table disposition_parcelle';

DROP TABLE IF EXISTS dvf_d62.lot CASCADE;

-- table fille dvf_d62.lot
CREATE TABLE dvf_d62.lot
(   
)INHERITS (dvf.lot);        

ALTER TABLE dvf_d62.lot 
ADD CONSTRAINT lot_pkey PRIMARY KEY (iddispolot);

ALTER TABLE dvf_d62.lot 
ADD CONSTRAINT lot_unique UNIQUE (iddispopar, iddispoloc, nolot, scarrez);

ALTER TABLE dvf_d62.lot 
ADD CONSTRAINT lot_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.lot IS 'table des lots (seuls les 5 premiers lots sont mentionnés)';

COMMENT ON COLUMN dvf_d62.lot.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.lot.nolot IS 'numéro du lot';

COMMENT ON COLUMN dvf_d62.lot.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.lot.scarrez IS 'surface Loi Carrez du lot';

COMMENT ON COLUMN dvf_d62.lot.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.lot.iddispolot IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.lot.iddispoloc IS 'identifiant de la table local';

DROP TABLE IF EXISTS dvf_d62.adresse_dispoparc CASCADE;

-- table fille dvf_d62.adresse_dispoparc
CREATE TABLE dvf_d62.adresse_dispoparc
(   
)INHERITS (dvf.adresse_dispoparc);        

ALTER TABLE dvf_d62.adresse_dispoparc 
ADD CONSTRAINT adresse_dispoparc_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.adresse_dispoparc IS 'table de liaison entre la table adresse et la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.adresse_dispoparc.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.adresse_dispoparc.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.adresse_dispoparc.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.adresse_dispoparc.idadresse IS 'identifiant de la table adresse';

DROP TABLE IF EXISTS dvf_d62.adresse_local CASCADE;

-- table fille dvf_d62.adresse_local
CREATE TABLE dvf_d62.adresse_local
(   
)INHERITS (dvf.adresse_local);        

ALTER TABLE dvf_d62.adresse_local 
ADD CONSTRAINT adresse_local_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.adresse_local IS 'table de liaison entre la table adresse et la table local';

COMMENT ON COLUMN dvf_d62.adresse_local.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.adresse_local.iddispoloc IS 'identifiant de la table local';

COMMENT ON COLUMN dvf_d62.adresse_local.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.adresse_local.idadresse IS 'identifiant de la table adresse';

DROP TABLE IF EXISTS dvf_d59.mutation CASCADE;

-- table fille dvf_d59.mutation
CREATE TABLE dvf_d59.mutation
(   
)INHERITS (dvf.mutation);        

ALTER TABLE dvf_d59.mutation 
ADD CONSTRAINT mutation_pkey PRIMARY KEY (idmutation);

ALTER TABLE dvf_d59.mutation 
ADD CONSTRAINT mutation_unique UNIQUE (codservch, refdoc);

ALTER TABLE dvf_d59.mutation 
ADD CONSTRAINT mutation_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.mutation IS 'table des mutations';

COMMENT ON COLUMN dvf_d59.mutation.idmutinvar IS 'identifiant invariant de la mutation';

COMMENT ON COLUMN dvf_d59.mutation.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.mutation.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.mutation.refdoc IS 'référence d''enregistrement du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.mutation.codservch IS 'code du service de conservation des hypothèques';

COMMENT ON COLUMN dvf_d59.mutation.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf_d59.mutation.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.mutation.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.mutation.moismut IS 'mois de signature du document';

DROP TABLE IF EXISTS dvf_d59.mutation_article_cgi CASCADE;

-- table fille dvf_d59.mutation_article_cgi
CREATE TABLE dvf_d59.mutation_article_cgi
(   
)INHERITS (dvf.mutation_article_cgi);        

ALTER TABLE dvf_d59.mutation_article_cgi 
ADD CONSTRAINT mutation_article_cgi_pkey PRIMARY KEY (idmutation, idartcgi);

ALTER TABLE dvf_d59.mutation_article_cgi 
ADD CONSTRAINT mutation_article_cgi_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.mutation_article_cgi IS 'table des articles du code général des impôts (CGI) attachés à la mutation';

COMMENT ON COLUMN dvf_d59.mutation_article_cgi.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.mutation_article_cgi.ordarticgi IS 'numéro de l''ordre de l''article cgi';

COMMENT ON COLUMN dvf_d59.mutation_article_cgi.idartcgi IS 'identifiant de la table annexe ann_cgi';

COMMENT ON COLUMN dvf_d59.mutation_article_cgi.idmutation IS 'identifiant de clef primaire de la table mutation';

DROP TABLE IF EXISTS dvf_d59.disposition CASCADE;

-- table fille dvf_d59.disposition
CREATE TABLE dvf_d59.disposition
(   
)INHERITS (dvf.disposition);        

ALTER TABLE dvf_d59.disposition 
ADD CONSTRAINT disposition_pkey PRIMARY KEY (iddispo);

ALTER TABLE dvf_d59.disposition 
ADD CONSTRAINT disposition_unique UNIQUE (idmutation, nodispo);

ALTER TABLE dvf_d59.disposition 
ADD CONSTRAINT disposition_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.disposition IS 'table des dispositions';

COMMENT ON COLUMN dvf_d59.disposition.iddispo IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.disposition.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.disposition.nodispo IS 'numéro de disposition';

COMMENT ON COLUMN dvf_d59.disposition.valeurfonc IS 'prix ou évaluation déclarée dans le cadre d''une mutation onéreuse';

COMMENT ON COLUMN dvf_d59.disposition.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.disposition.nblot IS 'nombre total de lots dans la disposition';

DROP TABLE IF EXISTS dvf_d59.disposition_parcelle CASCADE;

-- table fille dvf_d59.disposition_parcelle
CREATE TABLE dvf_d59.disposition_parcelle
(   
)INHERITS (dvf.disposition_parcelle);        

ALTER TABLE dvf_d59.disposition_parcelle 
ADD CONSTRAINT disposition_parcelle_pkey PRIMARY KEY (iddispopar);

ALTER TABLE dvf_d59.disposition_parcelle 
ADD CONSTRAINT disposition_parcelle_unique UNIQUE (iddispo, idparcelle);

ALTER TABLE dvf_d59.disposition_parcelle 
ADD CONSTRAINT disposition_parcelle_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.disposition_parcelle IS 'table des parcelles attachées à une disposition';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.iddispo IS 'identifiant de la table disposition';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.idparcelle IS 'identifiant de la table parcelle';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.iddispopar IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.moismut IS 'mois de signature du document';

DROP TABLE IF EXISTS dvf_d59.parcelle CASCADE;

-- table fille dvf_d59.parcelle
CREATE TABLE dvf_d59.parcelle
(   
)INHERITS (dvf.parcelle);        

ALTER TABLE dvf_d59.parcelle 
ADD CONSTRAINT parcelle_pkey PRIMARY KEY (idparcelle);

ALTER TABLE dvf_d59.parcelle 
ADD CONSTRAINT parcelle_unique UNIQUE (idpar);

ALTER TABLE dvf_d59.parcelle 
ADD CONSTRAINT parcelle_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.parcelle IS 'table des parcelles';

COMMENT ON COLUMN dvf_d59.parcelle.noplan IS 'numéro de la parcelle';

COMMENT ON COLUMN dvf_d59.parcelle.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d59.parcelle.prefsect IS 'prefixe de section de la parcelle';

COMMENT ON COLUMN dvf_d59.parcelle.codcomm IS 'code insee de la commune';

COMMENT ON COLUMN dvf_d59.parcelle.idparcelle IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.parcelle.nosect IS 'numéro de section de la parcelle';

DROP TABLE IF EXISTS dvf_d59.local CASCADE;

-- table fille dvf_d59.local
CREATE TABLE dvf_d59.local
(   
)INHERITS (dvf.local);        

ALTER TABLE dvf_d59.local 
ADD CONSTRAINT local_pkey PRIMARY KEY (iddispoloc);

ALTER TABLE dvf_d59.local 
ADD CONSTRAINT local_unique UNIQUE (iddispopar, identloc);

ALTER TABLE dvf_d59.local 
ADD CONSTRAINT local_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.local IS 'table des locaux';

COMMENT ON COLUMN dvf_d59.local.sbati IS 'surface réelle attachée à l''identifiant local';

COMMENT ON COLUMN dvf_d59.local.codtyploc IS 'code du type de local';

COMMENT ON COLUMN dvf_d59.local.iddispoloc IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.local.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.local.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d59.local.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.local.libtyploc IS 'libellé du type de local';

COMMENT ON COLUMN dvf_d59.local.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d59.local.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.local.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.local.idloc IS 'identifiant du local (Fichier Fonciers)';

COMMENT ON COLUMN dvf_d59.local.nbpprinc IS 'nombre de pièces principales';

COMMENT ON COLUMN dvf_d59.local.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.local.identloc IS 'identifiant du local';

DROP TABLE IF EXISTS dvf_d59.adresse CASCADE;

-- table fille dvf_d59.adresse
CREATE TABLE dvf_d59.adresse
(   
)INHERITS (dvf.adresse);        

ALTER TABLE dvf_d59.adresse 
ADD CONSTRAINT adresse_pkey PRIMARY KEY (idadresse);

ALTER TABLE dvf_d59.adresse 
ADD CONSTRAINT adresse_unique UNIQUE (idadrinvar);

ALTER TABLE dvf_d59.adresse 
ADD CONSTRAINT adresse_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.adresse IS 'table contenant les adresses (provenant des parcelles et des locaux';

COMMENT ON COLUMN dvf_d59.adresse.codvoie IS 'code de la voie';

COMMENT ON COLUMN dvf_d59.adresse.idadrinvar IS 'identifiant invariant de la table adresse';

COMMENT ON COLUMN dvf_d59.adresse.idadresse IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.adresse.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.adresse.commune IS 'libellé de la commune';

COMMENT ON COLUMN dvf_d59.adresse.typvoie IS 'type de voie';

COMMENT ON COLUMN dvf_d59.adresse.novoie IS 'numéro de la voie';

COMMENT ON COLUMN dvf_d59.adresse.voie IS 'libellé de la voie';

COMMENT ON COLUMN dvf_d59.adresse.codepostal IS 'code postal';

COMMENT ON COLUMN dvf_d59.adresse.btq IS 'indice de répétition';

DROP TABLE IF EXISTS dvf_d59.suf CASCADE;

-- table fille dvf_d59.suf
CREATE TABLE dvf_d59.suf
(   
)INHERITS (dvf.suf);        

ALTER TABLE dvf_d59.suf 
ADD CONSTRAINT suf_pkey PRIMARY KEY (iddisposuf);

ALTER TABLE dvf_d59.suf 
ADD CONSTRAINT suf_unique UNIQUE (iddispopar, nbsufidt, idsufinvar);

ALTER TABLE dvf_d59.suf 
ADD CONSTRAINT suf_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.suf IS 'table des subdivisions fiscales';

COMMENT ON COLUMN dvf_d59.suf.sterr IS 'surface de terrain ayant muté';

COMMENT ON COLUMN dvf_d59.suf.natcult IS 'libellé de nature de culture';

COMMENT ON COLUMN dvf_d59.suf.natcultspe IS 'groupe de nature de culture spéciale';

COMMENT ON COLUMN dvf_d59.suf.nbsufidt IS 'nombre de suf identiques';

COMMENT ON COLUMN dvf_d59.suf.idsufinvar IS 'identifiant invariant de la table suf';

COMMENT ON COLUMN dvf_d59.suf.iddisposuf IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.suf.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.suf.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.suf.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.suf.nodcnt IS 'type de la suf';

DROP TABLE IF EXISTS dvf_d59.volume CASCADE;

-- table fille dvf_d59.volume
CREATE TABLE dvf_d59.volume
(   
)INHERITS (dvf.volume);        

ALTER TABLE dvf_d59.volume 
ADD CONSTRAINT volume_pkey PRIMARY KEY (iddispovol);

ALTER TABLE dvf_d59.volume 
ADD CONSTRAINT volume_unique UNIQUE (iddispopar, novolume);

ALTER TABLE dvf_d59.volume 
ADD CONSTRAINT volume_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.volume IS 'table des volumes (division de l''espace dans la hauteur pour certaines co-propriétés verticales';

COMMENT ON COLUMN dvf_d59.volume.novolume IS 'numéro de volume';

COMMENT ON COLUMN dvf_d59.volume.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.volume.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.volume.iddispovol IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.volume.iddispopar IS 'identifiant de la table disposition_parcelle';

DROP TABLE IF EXISTS dvf_d59.lot CASCADE;

-- table fille dvf_d59.lot
CREATE TABLE dvf_d59.lot
(   
)INHERITS (dvf.lot);        

ALTER TABLE dvf_d59.lot 
ADD CONSTRAINT lot_pkey PRIMARY KEY (iddispolot);

ALTER TABLE dvf_d59.lot 
ADD CONSTRAINT lot_unique UNIQUE (iddispopar, iddispoloc, nolot, scarrez);

ALTER TABLE dvf_d59.lot 
ADD CONSTRAINT lot_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.lot IS 'table des lots (seuls les 5 premiers lots sont mentionnés)';

COMMENT ON COLUMN dvf_d59.lot.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.lot.nolot IS 'numéro du lot';

COMMENT ON COLUMN dvf_d59.lot.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.lot.scarrez IS 'surface Loi Carrez du lot';

COMMENT ON COLUMN dvf_d59.lot.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.lot.iddispolot IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.lot.iddispoloc IS 'identifiant de la table local';

DROP TABLE IF EXISTS dvf_d59.adresse_dispoparc CASCADE;

-- table fille dvf_d59.adresse_dispoparc
CREATE TABLE dvf_d59.adresse_dispoparc
(   
)INHERITS (dvf.adresse_dispoparc);        

ALTER TABLE dvf_d59.adresse_dispoparc 
ADD CONSTRAINT adresse_dispoparc_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.adresse_dispoparc IS 'table de liaison entre la table adresse et la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.adresse_dispoparc.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.adresse_dispoparc.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.adresse_dispoparc.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.adresse_dispoparc.idadresse IS 'identifiant de la table adresse';

DROP TABLE IF EXISTS dvf_d59.adresse_local CASCADE;

-- table fille dvf_d59.adresse_local
CREATE TABLE dvf_d59.adresse_local
(   
)INHERITS (dvf.adresse_local);        

ALTER TABLE dvf_d59.adresse_local 
ADD CONSTRAINT adresse_local_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.adresse_local IS 'table de liaison entre la table adresse et la table local';

COMMENT ON COLUMN dvf_d59.adresse_local.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.adresse_local.iddispoloc IS 'identifiant de la table local';

COMMENT ON COLUMN dvf_d59.adresse_local.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.adresse_local.idadresse IS 'identifiant de la table adresse';

-- création du trigger de la table mutation
CREATE OR REPLACE FUNCTION dvf.mutation_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.mutation VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.mutation VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_mutation_trigger ON dvf.mutation;      
CREATE TRIGGER insert_mutation_trigger
    BEFORE INSERT ON dvf.mutation
    FOR EACH ROW EXECUTE PROCEDURE dvf.mutation_insert_trigger();

-- création du trigger de la table mutation_article_cgi
CREATE OR REPLACE FUNCTION dvf.mutation_article_cgi_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.mutation_article_cgi VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.mutation_article_cgi VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_mutation_article_cgi_trigger ON dvf.mutation_article_cgi;      
CREATE TRIGGER insert_mutation_article_cgi_trigger
    BEFORE INSERT ON dvf.mutation_article_cgi
    FOR EACH ROW EXECUTE PROCEDURE dvf.mutation_article_cgi_insert_trigger();

-- création du trigger de la table disposition
CREATE OR REPLACE FUNCTION dvf.disposition_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.disposition VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.disposition VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_disposition_trigger ON dvf.disposition;      
CREATE TRIGGER insert_disposition_trigger
    BEFORE INSERT ON dvf.disposition
    FOR EACH ROW EXECUTE PROCEDURE dvf.disposition_insert_trigger();

-- création du trigger de la table disposition_parcelle
CREATE OR REPLACE FUNCTION dvf.disposition_parcelle_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.disposition_parcelle VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.disposition_parcelle VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_disposition_parcelle_trigger ON dvf.disposition_parcelle;      
CREATE TRIGGER insert_disposition_parcelle_trigger
    BEFORE INSERT ON dvf.disposition_parcelle
    FOR EACH ROW EXECUTE PROCEDURE dvf.disposition_parcelle_insert_trigger();

-- création du trigger de la table parcelle
CREATE OR REPLACE FUNCTION dvf.parcelle_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.parcelle VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.parcelle VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_parcelle_trigger ON dvf.parcelle;      
CREATE TRIGGER insert_parcelle_trigger
    BEFORE INSERT ON dvf.parcelle
    FOR EACH ROW EXECUTE PROCEDURE dvf.parcelle_insert_trigger();

-- création du trigger de la table local
CREATE OR REPLACE FUNCTION dvf.local_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.local VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.local VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_local_trigger ON dvf.local;      
CREATE TRIGGER insert_local_trigger
    BEFORE INSERT ON dvf.local
    FOR EACH ROW EXECUTE PROCEDURE dvf.local_insert_trigger();

-- création du trigger de la table adresse
CREATE OR REPLACE FUNCTION dvf.adresse_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.adresse VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.adresse VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_adresse_trigger ON dvf.adresse;      
CREATE TRIGGER insert_adresse_trigger
    BEFORE INSERT ON dvf.adresse
    FOR EACH ROW EXECUTE PROCEDURE dvf.adresse_insert_trigger();

-- création du trigger de la table suf
CREATE OR REPLACE FUNCTION dvf.suf_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.suf VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.suf VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_suf_trigger ON dvf.suf;      
CREATE TRIGGER insert_suf_trigger
    BEFORE INSERT ON dvf.suf
    FOR EACH ROW EXECUTE PROCEDURE dvf.suf_insert_trigger();

-- création du trigger de la table volume
CREATE OR REPLACE FUNCTION dvf.volume_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.volume VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.volume VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_volume_trigger ON dvf.volume;      
CREATE TRIGGER insert_volume_trigger
    BEFORE INSERT ON dvf.volume
    FOR EACH ROW EXECUTE PROCEDURE dvf.volume_insert_trigger();

-- création du trigger de la table lot
CREATE OR REPLACE FUNCTION dvf.lot_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.lot VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.lot VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_lot_trigger ON dvf.lot;      
CREATE TRIGGER insert_lot_trigger
    BEFORE INSERT ON dvf.lot
    FOR EACH ROW EXECUTE PROCEDURE dvf.lot_insert_trigger();

-- création du trigger de la table adresse_dispoparc
CREATE OR REPLACE FUNCTION dvf.adresse_dispoparc_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.adresse_dispoparc VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.adresse_dispoparc VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_adresse_dispoparc_trigger ON dvf.adresse_dispoparc;      
CREATE TRIGGER insert_adresse_dispoparc_trigger
    BEFORE INSERT ON dvf.adresse_dispoparc
    FOR EACH ROW EXECUTE PROCEDURE dvf.adresse_dispoparc_insert_trigger();

-- création du trigger de la table adresse_local
CREATE OR REPLACE FUNCTION dvf.adresse_local_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     IF (NEW.coddep='62') THEN INSERT INTO dvf_d62.adresse_local VALUES(NEW.*); RETURN NULL;
ELSIF (NEW.coddep='59') THEN INSERT INTO dvf_d59.adresse_local VALUES(NEW.*); RETURN NULL;
ELSE RETURN NULL;END IF;
    
END;
$$
LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS insert_adresse_local_trigger ON dvf.adresse_local;      
CREATE TRIGGER insert_adresse_local_trigger
    BEFORE INSERT ON dvf.adresse_local
    FOR EACH ROW EXECUTE PROCEDURE dvf.adresse_local_insert_trigger();

DROP TABLE IF EXISTS dvf_annexe.ann_nature_culture CASCADE;

-- table dvf_annexe.ann_nature_culture
CREATE TABLE dvf_annexe.ann_nature_culture
(
natcult varchar(2),
libnatcult varchar(254)   
);

COMMENT ON TABLE dvf_annexe.ann_nature_culture IS 'table contenant les différentes natures de culture';

COMMENT ON COLUMN dvf_annexe.ann_nature_culture.natcult IS '';

COMMENT ON COLUMN dvf_annexe.ann_nature_culture.libnatcult IS '';

DROP TABLE IF EXISTS dvf_annexe.ann_nature_culture_speciale CASCADE;

-- table dvf_annexe.ann_nature_culture_speciale
CREATE TABLE dvf_annexe.ann_nature_culture_speciale
(
natcultspe varchar(5),
libnatcusp varchar(254)   
);

COMMENT ON TABLE dvf_annexe.ann_nature_culture_speciale IS 'table contenant les différentes natures de culture spéciale';

COMMENT ON COLUMN dvf_annexe.ann_nature_culture_speciale.natcultspe IS '';

COMMENT ON COLUMN dvf_annexe.ann_nature_culture_speciale.libnatcusp IS '';

DROP TABLE IF EXISTS dvf_annexe.ann_cgi CASCADE;

-- table dvf_annexe.ann_cgi
CREATE TABLE dvf_annexe.ann_cgi
(
idartcgi serial,
artcgi varchar(20),
libartcgi varchar(254)   
);

COMMENT ON TABLE dvf_annexe.ann_cgi IS 'table contenant les différents articles CGI';

COMMENT ON COLUMN dvf_annexe.ann_cgi.artcgi IS '';

COMMENT ON COLUMN dvf_annexe.ann_cgi.libartcgi IS '';

COMMENT ON COLUMN dvf_annexe.ann_cgi.idartcgi IS '';

DROP TABLE IF EXISTS dvf_annexe.ann_nature_mutation CASCADE;

-- table dvf_annexe.ann_nature_mutation
CREATE TABLE dvf_annexe.ann_nature_mutation
(
idnatmut serial,
libnatmut varchar(45)   
);

COMMENT ON TABLE dvf_annexe.ann_nature_mutation IS 'table contenant les natures de mutation';

COMMENT ON COLUMN dvf_annexe.ann_nature_mutation.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf_annexe.ann_nature_mutation.libnatmut IS 'libellé de la nature de mutation';

DROP TABLE IF EXISTS dvf_annexe.ann_type_local CASCADE;

-- table dvf_annexe.ann_type_local
CREATE TABLE dvf_annexe.ann_type_local
(
codtyploc integer,
libtyploc varchar(254)   
);

COMMENT ON TABLE dvf_annexe.ann_type_local IS 'table contenant les types de locaux';

COMMENT ON COLUMN dvf_annexe.ann_type_local.libtyploc IS '';

COMMENT ON COLUMN dvf_annexe.ann_type_local.codtyploc IS '';

-- ajout des données annexes
INSERT INTO dvf_annexe.ann_type_local(codtyploc, libtyploc) VALUES (1, 'Maison');
INSERT INTO dvf_annexe.ann_type_local(codtyploc, libtyploc) VALUES (2, 'Appartement');
INSERT INTO dvf_annexe.ann_type_local(codtyploc, libtyploc) VALUES (3, 'Dépendance');
INSERT INTO dvf_annexe.ann_type_local(codtyploc, libtyploc) VALUES (4, 'Local industriel, commercial ou assimilé');

INSERT INTO dvf_annexe.ann_nature_mutation(libnatmut) VALUES ('Vente');
INSERT INTO dvf_annexe.ann_nature_mutation(libnatmut) VALUES ('Vente en l''état futur d''achèvement');
INSERT INTO dvf_annexe.ann_nature_mutation(libnatmut) VALUES ('Expropriation');
INSERT INTO dvf_annexe.ann_nature_mutation(libnatmut) VALUES ('Vente terrain à bâtir');
INSERT INTO dvf_annexe.ann_nature_mutation(libnatmut) VALUES ('Adjudication');
INSERT INTO dvf_annexe.ann_nature_mutation(libnatmut) VALUES ('Echange');

SET client_encoding = 'UTF8';
-- CREATION DE TABLES ANNEXES TEMPORAIRES

 --> table ann_cgi
DROP TABLE IF EXISTS dvf_annexe.tmp_ann_cgi;
CREATE TABLE dvf_annexe.tmp_ann_cgi
(
    article_cgi character varying(20),
    lib_article_cgi character varying(254),
    CONSTRAINT tmp_ann_cgi_unique PRIMARY KEY (article_cgi)
);

 --> table tmp_ann_nature_culture
DROP TABLE IF EXISTS dvf_annexe.tmp_ann_nature_culture;
CREATE TABLE dvf_annexe.tmp_ann_nature_culture
(
    nature_culture character varying(2),
    lib_nature_culture character varying(254),
    CONSTRAINT tmp_ann_nature_culture_pkey PRIMARY KEY (nature_culture)    
);

 --> table tmp_ann_nature_culture_speciale
DROP TABLE IF EXISTS dvf_annexe.tmp_ann_nature_culture_speciale;
CREATE TABLE dvf_annexe.tmp_ann_nature_culture_speciale
(
    nature_culture_speciale character varying(5),
    lib_nature_culture_speciale character varying(254),
    CONSTRAINT tmp_nature_culture_speciale_pkey PRIMARY KEY (nature_culture_speciale)
);

--
--
--
--
--
--
-- IMPORT DES FICHIERS ANNEXES C:\Users\Antoine\git\indvf\importdvf/creation_dvf/ressources\natcult.csv, C:\Users\Antoine\git\indvf\importdvf/creation_dvf/ressources\natcultspe.csv, C:\Users\Antoine\git\indvf\importdvf/creation_dvf/ressources\artcgil135b.csv PAR UNE INSTRUCTION "COPY FROM"--
--
--
--
--
--
--
--
-- MAJ DES TABLES ANNEXES
INSERT INTO dvf_annexe.ann_cgi 
(
    artcgi,libartcgi
)
(
    SELECT t1.article_cgi, t1.lib_article_cgi 
    FROM dvf_annexe.tmp_ann_cgi t1
    LEFT JOIN dvf_annexe.ann_cgi t2 
    ON t1.article_cgi=t2.artcgi
    WHERE t2.artcgi IS NULL
);

INSERT INTO dvf_annexe.ann_nature_culture 
(
    natcult,libnatcult
)
(
    SELECT t1.nature_culture, t1.lib_nature_culture
    FROM dvf_annexe.tmp_ann_nature_culture t1
    LEFT JOIN dvf_annexe.ann_nature_culture t2 
    ON t1.nature_culture=t2.natcult
    WHERE t2.natcult IS NULL
);

INSERT INTO dvf_annexe.ann_nature_culture_speciale 
(
    natcultspe,libnatcusp
)
(
    SELECT t1.nature_culture_speciale, t1.lib_nature_culture_speciale
    FROM dvf_annexe.tmp_ann_nature_culture_speciale t1
    LEFT JOIN dvf_annexe.ann_nature_culture_speciale t2 
    ON t1.nature_culture_speciale=t2.natcultspe
    WHERE t2.natcultspe IS NULL
);

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe' 
AND tablename LIKE 'tmp_ann_%';

DROP TABLE IF EXISTS dvf_annexe.tmp_ann_cgi CASCADE;

DROP TABLE IF EXISTS dvf_annexe.tmp_ann_nature_culture CASCADE;

DROP TABLE IF EXISTS dvf_annexe.tmp_ann_nature_culture_speciale CASCADE;


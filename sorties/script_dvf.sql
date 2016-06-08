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
-- Début d'exécution le 08/06/2016 à 20:45:43
---

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

DROP SCHEMA IF EXISTS dvf_d59 CASCADE;

DROP SCHEMA IF EXISTS dvf_d62 CASCADE;

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

COMMENT ON COLUMN dvf.mutation.coddep IS 'code du département';

COMMENT ON COLUMN dvf.mutation.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf.mutation.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf.mutation.refdoc IS 'référence d''enregistrement du document (acte de vente)';

COMMENT ON COLUMN dvf.mutation.idmutinvar IS 'identifiant invariant de la mutation';

COMMENT ON COLUMN dvf.mutation.codservch IS 'code du service de conservation des hypothèques';

COMMENT ON COLUMN dvf.mutation.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf.mutation.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf.mutation.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf.mutation_article_cgi.idartcgi IS 'identifiant de la table annexe ann_cgi';

COMMENT ON COLUMN dvf.mutation_article_cgi.ordarticgi IS 'numéro de l''ordre de l''article cgi';

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

COMMENT ON COLUMN dvf.disposition.nblot IS 'nombre total de lots dans la disposition';

COMMENT ON COLUMN dvf.disposition.valeurfonc IS 'prix ou évaluation déclarée dans le cadre d''une mutation onéreuse';

COMMENT ON COLUMN dvf.disposition.coddep IS 'code du département';

COMMENT ON COLUMN dvf.disposition.nodispo IS 'numéro de disposition';

COMMENT ON COLUMN dvf.disposition.iddispo IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.disposition.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf.disposition_parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf.disposition_parcelle.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf.disposition_parcelle.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf.disposition_parcelle.idparcelle IS 'identifiant de la table parcelle';

COMMENT ON COLUMN dvf.disposition_parcelle.iddispopar IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.disposition_parcelle.iddispo IS 'identifiant de la table disposition';

COMMENT ON COLUMN dvf.disposition_parcelle.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf.disposition_parcelle.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf.parcelle.prefsect IS 'prefixe de section de la parcelle';

COMMENT ON COLUMN dvf.parcelle.noplan IS 'numéro de la parcelle';

COMMENT ON COLUMN dvf.parcelle.codcomm IS 'code insee de la commune';

COMMENT ON COLUMN dvf.parcelle.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf.parcelle.nosect IS 'numéro de section de la parcelle';

COMMENT ON COLUMN dvf.parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf.parcelle.idparcelle IS 'identifiant pour clef primaire';

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

COMMENT ON COLUMN dvf.local.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf.local.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf.local.sbati IS 'surface réelle attachée à l''identifiant local';

COMMENT ON COLUMN dvf.local.identloc IS 'identifiant du local';

COMMENT ON COLUMN dvf.local.idloc IS 'identifiant du local (Fichier Fonciers)';

COMMENT ON COLUMN dvf.local.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.local.coddep IS 'code du département';

COMMENT ON COLUMN dvf.local.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf.local.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf.local.nbpprinc IS 'nombre de pièces principales';

COMMENT ON COLUMN dvf.local.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf.local.libtyploc IS 'libellé du type de local';

COMMENT ON COLUMN dvf.local.iddispoloc IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.local.codtyploc IS 'code du type de local';

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

COMMENT ON COLUMN dvf.adresse.novoie IS 'numéro de la voie';

COMMENT ON COLUMN dvf.adresse.btq IS 'indice de répétition';

COMMENT ON COLUMN dvf.adresse.idadrinvar IS 'identifiant invariant de la table adresse';

COMMENT ON COLUMN dvf.adresse.voie IS 'libellé de la voie';

COMMENT ON COLUMN dvf.adresse.commune IS 'libellé de la commune';

COMMENT ON COLUMN dvf.adresse.idadresse IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.adresse.typvoie IS 'type de voie';

COMMENT ON COLUMN dvf.adresse.codepostal IS 'code postal';

COMMENT ON COLUMN dvf.adresse.codvoie IS 'code de la voie';

COMMENT ON COLUMN dvf.adresse.coddep IS 'code du département';

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

COMMENT ON COLUMN dvf.suf.iddisposuf IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.suf.idsufinvar IS 'identifiant invariant de la table suf';

COMMENT ON COLUMN dvf.suf.coddep IS 'code du département';

COMMENT ON COLUMN dvf.suf.sterr IS 'surface de terrain ayant muté';

COMMENT ON COLUMN dvf.suf.nodcnt IS 'type de la suf';

COMMENT ON COLUMN dvf.suf.natcultspe IS 'groupe de nature de culture spéciale';

COMMENT ON COLUMN dvf.suf.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf.suf.natcult IS 'libellé de nature de culture';

COMMENT ON COLUMN dvf.suf.nbsufidt IS 'nombre de suf identiques';

COMMENT ON COLUMN dvf.suf.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf.volume.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf.volume.novolume IS 'numéro de volume';

COMMENT ON COLUMN dvf.volume.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.volume.coddep IS 'code du département';

COMMENT ON COLUMN dvf.volume.iddispovol IS 'identifiant pour clef primaire';

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

COMMENT ON COLUMN dvf.lot.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf.lot.nolot IS 'numéro du lot';

COMMENT ON COLUMN dvf.lot.coddep IS 'code du département';

COMMENT ON COLUMN dvf.lot.iddispolot IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf.lot.iddispoloc IS 'identifiant de la table local';

COMMENT ON COLUMN dvf.lot.scarrez IS 'surface Loi Carrez du lot';

COMMENT ON COLUMN dvf.lot.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf.adresse_dispoparc.idadresse IS 'identifiant de la table adresse';

COMMENT ON COLUMN dvf.adresse_dispoparc.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf.adresse_dispoparc.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf.adresse_dispoparc.coddep IS 'code du département';

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

COMMENT ON COLUMN dvf.adresse_local.idadresse IS 'identifiant de la table adresse';

COMMENT ON COLUMN dvf.adresse_local.coddep IS 'code du département';

COMMENT ON COLUMN dvf.adresse_local.iddispoloc IS 'identifiant de la table local';

COMMENT ON COLUMN dvf.adresse_local.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf_d62.mutation.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.mutation.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.mutation.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf_d62.mutation.refdoc IS 'référence d''enregistrement du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.mutation.idmutinvar IS 'identifiant invariant de la mutation';

COMMENT ON COLUMN dvf_d62.mutation.codservch IS 'code du service de conservation des hypothèques';

COMMENT ON COLUMN dvf_d62.mutation.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.mutation.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d62.mutation.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf_d62.mutation_article_cgi.idartcgi IS 'identifiant de la table annexe ann_cgi';

COMMENT ON COLUMN dvf_d62.mutation_article_cgi.ordarticgi IS 'numéro de l''ordre de l''article cgi';

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

COMMENT ON COLUMN dvf_d62.disposition.nblot IS 'nombre total de lots dans la disposition';

COMMENT ON COLUMN dvf_d62.disposition.valeurfonc IS 'prix ou évaluation déclarée dans le cadre d''une mutation onéreuse';

COMMENT ON COLUMN dvf_d62.disposition.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.disposition.nodispo IS 'numéro de disposition';

COMMENT ON COLUMN dvf_d62.disposition.iddispo IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.disposition.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf_d62.disposition_parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.idparcelle IS 'identifiant de la table parcelle';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.iddispopar IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.iddispo IS 'identifiant de la table disposition';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.disposition_parcelle.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf_d62.parcelle.prefsect IS 'prefixe de section de la parcelle';

COMMENT ON COLUMN dvf_d62.parcelle.noplan IS 'numéro de la parcelle';

COMMENT ON COLUMN dvf_d62.parcelle.codcomm IS 'code insee de la commune';

COMMENT ON COLUMN dvf_d62.parcelle.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d62.parcelle.nosect IS 'numéro de section de la parcelle';

COMMENT ON COLUMN dvf_d62.parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.parcelle.idparcelle IS 'identifiant pour clef primaire';

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

COMMENT ON COLUMN dvf_d62.local.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d62.local.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d62.local.sbati IS 'surface réelle attachée à l''identifiant local';

COMMENT ON COLUMN dvf_d62.local.identloc IS 'identifiant du local';

COMMENT ON COLUMN dvf_d62.local.idloc IS 'identifiant du local (Fichier Fonciers)';

COMMENT ON COLUMN dvf_d62.local.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.local.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.local.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d62.local.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d62.local.nbpprinc IS 'nombre de pièces principales';

COMMENT ON COLUMN dvf_d62.local.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.local.libtyploc IS 'libellé du type de local';

COMMENT ON COLUMN dvf_d62.local.iddispoloc IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.local.codtyploc IS 'code du type de local';

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

COMMENT ON COLUMN dvf_d62.adresse.novoie IS 'numéro de la voie';

COMMENT ON COLUMN dvf_d62.adresse.btq IS 'indice de répétition';

COMMENT ON COLUMN dvf_d62.adresse.idadrinvar IS 'identifiant invariant de la table adresse';

COMMENT ON COLUMN dvf_d62.adresse.voie IS 'libellé de la voie';

COMMENT ON COLUMN dvf_d62.adresse.commune IS 'libellé de la commune';

COMMENT ON COLUMN dvf_d62.adresse.idadresse IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.adresse.typvoie IS 'type de voie';

COMMENT ON COLUMN dvf_d62.adresse.codepostal IS 'code postal';

COMMENT ON COLUMN dvf_d62.adresse.codvoie IS 'code de la voie';

COMMENT ON COLUMN dvf_d62.adresse.coddep IS 'code du département';

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

COMMENT ON COLUMN dvf_d62.suf.iddisposuf IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.suf.idsufinvar IS 'identifiant invariant de la table suf';

COMMENT ON COLUMN dvf_d62.suf.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.suf.sterr IS 'surface de terrain ayant muté';

COMMENT ON COLUMN dvf_d62.suf.nodcnt IS 'type de la suf';

COMMENT ON COLUMN dvf_d62.suf.natcultspe IS 'groupe de nature de culture spéciale';

COMMENT ON COLUMN dvf_d62.suf.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.suf.natcult IS 'libellé de nature de culture';

COMMENT ON COLUMN dvf_d62.suf.nbsufidt IS 'nombre de suf identiques';

COMMENT ON COLUMN dvf_d62.suf.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf_d62.volume.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.volume.novolume IS 'numéro de volume';

COMMENT ON COLUMN dvf_d62.volume.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.volume.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.volume.iddispovol IS 'identifiant pour clef primaire';

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

COMMENT ON COLUMN dvf_d62.lot.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.lot.nolot IS 'numéro du lot';

COMMENT ON COLUMN dvf_d62.lot.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.lot.iddispolot IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d62.lot.iddispoloc IS 'identifiant de la table local';

COMMENT ON COLUMN dvf_d62.lot.scarrez IS 'surface Loi Carrez du lot';

COMMENT ON COLUMN dvf_d62.lot.idmutation IS 'identifiant de clef primaire de la table mutation';

DROP TABLE IF EXISTS dvf_d62.adresse_dispoparc CASCADE;

-- table fille dvf_d62.adresse_dispoparc
CREATE TABLE dvf_d62.adresse_dispoparc
(   
)INHERITS (dvf.adresse_dispoparc);        

ALTER TABLE dvf_d62.adresse_dispoparc 
ADD CONSTRAINT adresse_dispoparc_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.adresse_dispoparc IS 'table de liaison entre la table adresse et la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.adresse_dispoparc.idadresse IS 'identifiant de la table adresse';

COMMENT ON COLUMN dvf_d62.adresse_dispoparc.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d62.adresse_dispoparc.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d62.adresse_dispoparc.coddep IS 'code du département';

DROP TABLE IF EXISTS dvf_d62.adresse_local CASCADE;

-- table fille dvf_d62.adresse_local
CREATE TABLE dvf_d62.adresse_local
(   
)INHERITS (dvf.adresse_local);        

ALTER TABLE dvf_d62.adresse_local 
ADD CONSTRAINT adresse_local_check CHECK (coddep = '62');

COMMENT ON TABLE dvf_d62.adresse_local IS 'table de liaison entre la table adresse et la table local';

COMMENT ON COLUMN dvf_d62.adresse_local.idadresse IS 'identifiant de la table adresse';

COMMENT ON COLUMN dvf_d62.adresse_local.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d62.adresse_local.iddispoloc IS 'identifiant de la table local';

COMMENT ON COLUMN dvf_d62.adresse_local.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf_d59.mutation.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.mutation.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.mutation.idnatmut IS 'identifiant de clef primaire de la table ann_nature_mutation';

COMMENT ON COLUMN dvf_d59.mutation.refdoc IS 'référence d''enregistrement du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.mutation.idmutinvar IS 'identifiant invariant de la mutation';

COMMENT ON COLUMN dvf_d59.mutation.codservch IS 'code du service de conservation des hypothèques';

COMMENT ON COLUMN dvf_d59.mutation.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.mutation.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d59.mutation.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf_d59.mutation_article_cgi.idartcgi IS 'identifiant de la table annexe ann_cgi';

COMMENT ON COLUMN dvf_d59.mutation_article_cgi.ordarticgi IS 'numéro de l''ordre de l''article cgi';

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

COMMENT ON COLUMN dvf_d59.disposition.nblot IS 'nombre total de lots dans la disposition';

COMMENT ON COLUMN dvf_d59.disposition.valeurfonc IS 'prix ou évaluation déclarée dans le cadre d''une mutation onéreuse';

COMMENT ON COLUMN dvf_d59.disposition.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.disposition.nodispo IS 'numéro de disposition';

COMMENT ON COLUMN dvf_d59.disposition.iddispo IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.disposition.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf_d59.disposition_parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.idparcelle IS 'identifiant de la table parcelle';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.iddispopar IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.iddispo IS 'identifiant de la table disposition';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.disposition_parcelle.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf_d59.parcelle.prefsect IS 'prefixe de section de la parcelle';

COMMENT ON COLUMN dvf_d59.parcelle.noplan IS 'numéro de la parcelle';

COMMENT ON COLUMN dvf_d59.parcelle.codcomm IS 'code insee de la commune';

COMMENT ON COLUMN dvf_d59.parcelle.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d59.parcelle.nosect IS 'numéro de section de la parcelle';

COMMENT ON COLUMN dvf_d59.parcelle.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.parcelle.idparcelle IS 'identifiant pour clef primaire';

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

COMMENT ON COLUMN dvf_d59.local.moismut IS 'mois de signature du document';

COMMENT ON COLUMN dvf_d59.local.idpar IS 'identifiant de la parcelle (Fichiers fonciers)';

COMMENT ON COLUMN dvf_d59.local.sbati IS 'surface réelle attachée à l''identifiant local';

COMMENT ON COLUMN dvf_d59.local.identloc IS 'identifiant du local';

COMMENT ON COLUMN dvf_d59.local.idloc IS 'identifiant du local (Fichier Fonciers)';

COMMENT ON COLUMN dvf_d59.local.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.local.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.local.datemut IS 'date de signature du document (acte de vente)';

COMMENT ON COLUMN dvf_d59.local.anneemut IS 'annee de signature du document';

COMMENT ON COLUMN dvf_d59.local.nbpprinc IS 'nombre de pièces principales';

COMMENT ON COLUMN dvf_d59.local.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.local.libtyploc IS 'libellé du type de local';

COMMENT ON COLUMN dvf_d59.local.iddispoloc IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.local.codtyploc IS 'code du type de local';

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

COMMENT ON COLUMN dvf_d59.adresse.novoie IS 'numéro de la voie';

COMMENT ON COLUMN dvf_d59.adresse.btq IS 'indice de répétition';

COMMENT ON COLUMN dvf_d59.adresse.idadrinvar IS 'identifiant invariant de la table adresse';

COMMENT ON COLUMN dvf_d59.adresse.voie IS 'libellé de la voie';

COMMENT ON COLUMN dvf_d59.adresse.commune IS 'libellé de la commune';

COMMENT ON COLUMN dvf_d59.adresse.idadresse IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.adresse.typvoie IS 'type de voie';

COMMENT ON COLUMN dvf_d59.adresse.codepostal IS 'code postal';

COMMENT ON COLUMN dvf_d59.adresse.codvoie IS 'code de la voie';

COMMENT ON COLUMN dvf_d59.adresse.coddep IS 'code du département';

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

COMMENT ON COLUMN dvf_d59.suf.iddisposuf IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.suf.idsufinvar IS 'identifiant invariant de la table suf';

COMMENT ON COLUMN dvf_d59.suf.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.suf.sterr IS 'surface de terrain ayant muté';

COMMENT ON COLUMN dvf_d59.suf.nodcnt IS 'type de la suf';

COMMENT ON COLUMN dvf_d59.suf.natcultspe IS 'groupe de nature de culture spéciale';

COMMENT ON COLUMN dvf_d59.suf.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.suf.natcult IS 'libellé de nature de culture';

COMMENT ON COLUMN dvf_d59.suf.nbsufidt IS 'nombre de suf identiques';

COMMENT ON COLUMN dvf_d59.suf.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf_d59.volume.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.volume.novolume IS 'numéro de volume';

COMMENT ON COLUMN dvf_d59.volume.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.volume.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.volume.iddispovol IS 'identifiant pour clef primaire';

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

COMMENT ON COLUMN dvf_d59.lot.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.lot.nolot IS 'numéro du lot';

COMMENT ON COLUMN dvf_d59.lot.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.lot.iddispolot IS 'identifiant pour clef primaire';

COMMENT ON COLUMN dvf_d59.lot.iddispoloc IS 'identifiant de la table local';

COMMENT ON COLUMN dvf_d59.lot.scarrez IS 'surface Loi Carrez du lot';

COMMENT ON COLUMN dvf_d59.lot.idmutation IS 'identifiant de clef primaire de la table mutation';

DROP TABLE IF EXISTS dvf_d59.adresse_dispoparc CASCADE;

-- table fille dvf_d59.adresse_dispoparc
CREATE TABLE dvf_d59.adresse_dispoparc
(   
)INHERITS (dvf.adresse_dispoparc);        

ALTER TABLE dvf_d59.adresse_dispoparc 
ADD CONSTRAINT adresse_dispoparc_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.adresse_dispoparc IS 'table de liaison entre la table adresse et la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.adresse_dispoparc.idadresse IS 'identifiant de la table adresse';

COMMENT ON COLUMN dvf_d59.adresse_dispoparc.iddispopar IS 'identifiant de la table disposition_parcelle';

COMMENT ON COLUMN dvf_d59.adresse_dispoparc.idmutation IS 'identifiant de clef primaire de la table mutation';

COMMENT ON COLUMN dvf_d59.adresse_dispoparc.coddep IS 'code du département';

DROP TABLE IF EXISTS dvf_d59.adresse_local CASCADE;

-- table fille dvf_d59.adresse_local
CREATE TABLE dvf_d59.adresse_local
(   
)INHERITS (dvf.adresse_local);        

ALTER TABLE dvf_d59.adresse_local 
ADD CONSTRAINT adresse_local_check CHECK (coddep = '59');

COMMENT ON TABLE dvf_d59.adresse_local IS 'table de liaison entre la table adresse et la table local';

COMMENT ON COLUMN dvf_d59.adresse_local.idadresse IS 'identifiant de la table adresse';

COMMENT ON COLUMN dvf_d59.adresse_local.coddep IS 'code du département';

COMMENT ON COLUMN dvf_d59.adresse_local.iddispoloc IS 'identifiant de la table local';

COMMENT ON COLUMN dvf_d59.adresse_local.idmutation IS 'identifiant de clef primaire de la table mutation';

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

COMMENT ON COLUMN dvf_annexe.ann_nature_culture.libnatcult IS '';

COMMENT ON COLUMN dvf_annexe.ann_nature_culture.natcult IS '';

DROP TABLE IF EXISTS dvf_annexe.ann_nature_culture_speciale CASCADE;

-- table dvf_annexe.ann_nature_culture_speciale
CREATE TABLE dvf_annexe.ann_nature_culture_speciale
(
natcultspe varchar(5),
libnatcusp varchar(254)   
);

COMMENT ON TABLE dvf_annexe.ann_nature_culture_speciale IS 'table contenant les différentes natures de culture spéciale';

COMMENT ON COLUMN dvf_annexe.ann_nature_culture_speciale.libnatcusp IS '';

COMMENT ON COLUMN dvf_annexe.ann_nature_culture_speciale.natcultspe IS '';

DROP TABLE IF EXISTS dvf_annexe.ann_cgi CASCADE;

-- table dvf_annexe.ann_cgi
CREATE TABLE dvf_annexe.ann_cgi
(
idartcgi serial,
artcgi varchar(20),
libartcgi varchar(254)   
);

COMMENT ON TABLE dvf_annexe.ann_cgi IS 'table contenant les différents articles CGI';

COMMENT ON COLUMN dvf_annexe.ann_cgi.idartcgi IS '';

COMMENT ON COLUMN dvf_annexe.ann_cgi.artcgi IS '';

COMMENT ON COLUMN dvf_annexe.ann_cgi.libartcgi IS '';

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
-- IMPORT DES FICHIERS ANNEXES /home/antoine/git/indvf/importdvf/creation_dvf/ressources/natcult.csv, /home/antoine/git/indvf/importdvf/creation_dvf/ressources/natcultspe.csv, /home/antoine/git/indvf/importdvf/creation_dvf/ressources/artcgil135b.csv PAR UNE INSTRUCTION "COPY FROM"--
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

CREATE OR REPLACE FUNCTION array_supprimer_null(numlot VARCHAR[])
  RETURNS VARCHAR[] AS
$BODY$
/*
   Retourne un tableau en enlevant les valeurs NULL (à partir de la version 9.3, devient obsolète avec apparition de array_remove)
  */
DECLARE    
    lot VARCHAR[];
    resultat VARCHAR[];
BEGIN
        lot := numlot;        
        FOR i IN 1..array_upper(lot,1)
        LOOP
            IF lot[i] IS NOT NULL THEN resultat := resultat || lot[i]; END IF;        
        END LOOP;
        RETURN resultat;
END;
$BODY$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION pgcd(valeurs integer[])
  RETURNS integer AS
$BODY$
/*
  Retourne le Plus Grand Commun Diviseur de l'ensemble des valeurs du tableau d'entier.
  Si le tableau ne contient qu'un seul entier, Retourne sa valeur absolue.
 
  Exemple : SELECT pgcd(ARRAY[14,28,49,70]);
  7
 */
DECLARE
    v integer[];
    reste integer;
    a integer;
    b integer;
    gcd integer;
BEGIN
    v := valeurs;
    gcd := 0;
    IF array_length(v,1) > 1 THEN        
        a := v[1];    
        FOR i IN 2..array_upper(v,1)
        LOOP         
            b:=v[i];
            IF b<>0 THEN 
                LOOP
                    reste:=a%b;
                    a:=b;
                    b:=reste;
                    EXIT WHEN reste=0;
                END LOOP;
                
                IF abs(a) < gcd OR gcd = 0 THEN 
                    gcd := abs(a);
                    a := gcd;
                END IF;
                EXIT WHEN gcd=1;
            ELSE
                gcd=0;
                EXIT;
            END IF;    
        END LOOP;
    ELSE
        gcd = abs(v[1]);
    END IF;
        RETURN gcd;
END;
$BODY$
  LANGUAGE plpgsql; 

CREATE SCHEMA IF NOT EXISTS source;

SET client_encoding = 'UTF8';
SET datestyle = 'ISO, DMY';
-- ******************************
-- CREATION DE LA TABLE TEMPORAIRE VIDE POUR IMPORT DES DONNEES
-- ******************************

DROP TABLE IF EXISTS source.tmp;
CREATE TABLE source.tmp
(
    code_service_ch character varying(7),
    reference_document character varying(10),
    "1_articles_cgi" character varying(20),
    "2_articles_cgi" character varying(20),
    "3_articles_cgi" character varying(20),
    "4_articles_cgi" character varying(20),
    "5_articles_cgi" character varying(20),
    no_disposition integer,
    date_mutation date,
    nature_mutation character varying(34),
    valeur_fonciere character varying,     -- PASSE EN NUMERIC ENSUITE APRES AVOIR REMPLACE LES VIRGULES PAR DES POINTS
    no_voie integer,    
    b_t_q character varying(1),        
    type_de_voie character varying(4),    
    code_voie character varying(4),        
    voie character varying(254),        
    code_postal character varying(5),    
    commune character varying(254),    
    code_departement character varying(3),    -- COMPLETE ENSUITE PAR DES "0" SI NECESSAIRE
    code_commune character varying(3),        -- COMPLETE ENSUITE PAR DES "0" SI NECESSAIRE
    prefixe_de_section character varying(3),    -- COMPLETE ENSUITE PAR DES "0" SI NECESSAIRE
    section character varying(2),            -- COMPLETE ENSUITE PAR DES "0" SI NECESSAIRE
    no_plan character varying(4),            -- COMPLETE ENSUITE PAR DES "0" SI NECESSAIRE
    no_volume character varying(7),        
    "1er_lot" character varying(7),
    surface_carrez_du_1er_lot character varying,     -- PASSE EN NUMERIC ENSUITE APRES AVOIR REMPLACE LES VIRGULES PAR DES POINTS
    "2eme_lot" character varying(7),
    surface_carrez_du_2eme_lot character varying,     -- PASSE EN NUMERIC ENSUITE APRES AVOIR REMPLACE LES VIRGULES PAR DES POINTS
    "3eme_lot" character varying(7),
    surface_carrez_du_3eme_lot character varying,     -- PASSE EN NUMERIC ENSUITE APRES AVOIR REMPLACE LES VIRGULES PAR DES POINTS
    "4eme_lot" character varying(7),
    surface_carrez_du_4eme_lot character varying,     -- PASSE EN NUMERIC ENSUITE APRES AVOIR REMPLACE LES VIRGULES PAR DES POINTS
    "5eme_lot" character varying(7),
    surface_carrez_du_5eme_lot character varying,     -- PASSE EN NUMERIC ENSUITE APRES AVOIR REMPLACE LES VIRGULES PAR DES POINTS
    nombre_de_lots integer,
    code_type_local integer,            
    type_local character varying(254),
    identifiant_local character varying(10),
    surface_reelle_bati integer,
    nombre_pieces_principales integer,
    nature_culture character varying(2),            
    nature_culture_speciale character varying(5),    
    surface_terrain integer
);

DROP TABLE IF EXISTS source.tmp_0;
CREATE TABLE source.tmp_0 AS 
(
    SELECT
        t.*
    FROM(
    
        SELECT 
            code_service_ch, reference_document,
            concat(code_service_ch, '_', reference_document) AS idmutinvar, 
            "1_articles_cgi", "2_articles_cgi", "3_articles_cgi", "4_articles_cgi", "5_articles_cgi", no_disposition, 
            date_mutation, 
            EXTRACT(YEAR FROM date_mutation)::integer as anneemut,
            EXTRACT(MONTH FROM date_mutation)::integer as moismut,            
            nature_mutation, 
    
            (replace(valeur_fonciere, ',', '.'))::numeric AS valeur_fonciere, 
    
                    no_voie, b_t_q, 
            type_de_voie, code_voie, voie, lpad(code_postal,5,'0') AS code_postal, commune, 
            CASE WHEN code_departement NOT LIKE '97_' THEN lpad(COALESCE(code_departement,''), 2, '0') ELSE code_departement END AS code_departement,
            CASE WHEN code_departement NOT LIKE '97_' THEN lpad(COALESCE(code_commune,''), 3, '0') ELSE lpad(COALESCE(code_commune,''), 2, '0') END AS code_commune,
            lpad(COALESCE(prefixe_de_section,''), 3, '0') AS prefixe_de_section,
            lpad(COALESCE(section,''), 2, '0') AS section,
            lpad(COALESCE(no_plan,''), 4, '0') AS no_plan,
            no_volume, 
            "1er_lot", (replace(surface_carrez_du_1er_lot, ',', '.'))::numeric AS surface_carrez_du_1er_lot, 
            "2eme_lot", (replace(surface_carrez_du_2eme_lot, ',', '.'))::numeric AS surface_carrez_du_2eme_lot, 
            "3eme_lot", (replace(surface_carrez_du_3eme_lot, ',', '.'))::numeric AS surface_carrez_du_3eme_lot, 
            "4eme_lot", (replace(surface_carrez_du_4eme_lot, ',', '.'))::numeric AS surface_carrez_du_4eme_lot, 
            "5eme_lot", (replace(surface_carrez_du_5eme_lot, ',', '.'))::numeric AS surface_carrez_du_5eme_lot, 
            nombre_de_lots, code_type_local, 
            type_local, identifiant_local, surface_reelle_bati, nombre_pieces_principales, 
            nature_culture, nature_culture_speciale, surface_terrain,
            
            CASE 
                WHEN nature_culture LIKE 'T%' THEN 1
                WHEN nature_culture LIKE 'P%' THEN 2
                WHEN nature_culture = 'VE' THEN 3
                WHEN nature_culture = 'VI' THEN 4
                WHEN nature_culture LIKE 'B%' THEN 5
                WHEN nature_culture LIKE 'L%' THEN 6
                WHEN nature_culture = 'CA' THEN 7
                WHEN nature_culture = 'E' THEN 8
                WHEN nature_culture = 'J' THEN 9
                WHEN nature_culture = 'AB' THEN 10
                WHEN nature_culture = 'AG' THEN 11
                WHEN nature_culture = 'CH' THEN 12
                WHEN nature_culture = 'S' THEN 13
            ELSE NULL 
            END AS nodcnt,
    
            CASE WHEN code_departement NOT LIKE '97_' THEN lpad(COALESCE(code_departement,''), 2, '0') ELSE code_departement END||
                CASE WHEN code_departement NOT LIKE '97_' THEN lpad(COALESCE(code_commune,''), 3, '0') ELSE lpad(COALESCE(code_commune,''), 2, '0') END||
                lpad(COALESCE(prefixe_de_section,''), 3, '0')||lpad(COALESCE(section,''), 2, '0')||lpad(COALESCE(no_plan,''), 4, '0') 
            AS idpar,
            
            CASE WHEN code_departement NOT LIKE '97_' THEN lpad(COALESCE(code_departement,''), 2, '0') ELSE code_departement END||
            CASE 
                WHEN lpad(COALESCE(prefixe_de_section,''), 3, '0') = '000' THEN 
                    CASE 
                        WHEN code_departement NOT LIKE '97_' THEN lpad(COALESCE(code_commune,''), 3, '0') 
                        ELSE lpad(COALESCE(code_commune,''), 2, '0') 
                    END 
                ELSE 
                    CASE 
                        WHEN code_departement NOT LIKE '97_' THEN lpad(COALESCE(prefixe_de_section,''), 3, '0') 
                        ELSE lpad(COALESCE(substring(prefixe_de_section from '..$'),''), 2, '0') 
                    END 
            END||
            lpad(identifiant_local, 7, '0') AS idloc,
    
            CASE WHEN no_voie IS NULL THEN '' ELSE no_voie::varchar END || '$' ||
                CASE WHEN b_t_q IS NULL THEN '' ELSE b_t_q END || '$' ||
                CASE WHEN code_voie IS NULL THEN '' ELSE code_voie END || '$' ||
                CASE WHEN type_de_voie IS NULL THEN '' ELSE type_de_voie END || '$' ||
                CASE WHEN voie IS NULL THEN '' ELSE voie END || '$' ||
                CASE WHEN code_postal IS NULL THEN '' ELSE code_postal END || '$' ||
                CASE WHEN commune IS NULL THEN '' ELSE commune END 
            AS idadr_tmp,
            
            CASE WHEN nature_culture IS NULL THEN '' ELSE nature_culture::varchar END || '$' ||
                CASE WHEN nature_culture_speciale IS NULL THEN '' ELSE nature_culture_speciale::varchar END || '$' ||
                CASE WHEN surface_terrain IS NULL THEN '' ELSE surface_terrain::varchar END
            AS idsuf_tmp
            
        FROM 
            source.tmp
    ) t
    LEFT JOIN dvf.mutation tt
    ON t.idmutinvar = tt.idmutinvar
    WHERE tt.idmutinvar IS NULL
);

DROP TABLE IF EXISTS source.tmp CASCADE;

CREATE OR REPLACE FUNCTION array_supprimer_null(numlot VARCHAR[])
  RETURNS VARCHAR[] AS
$BODY$
/*
   Retourne un tableau en enlevant les valeurs NULL (à partir de la version 9.3, devient obsolète avec apparition de array_remove)
  */
DECLARE    
    lot VARCHAR[];
    resultat VARCHAR[];
BEGIN
        lot := numlot;        
        FOR i IN 1..array_upper(lot,1)
        LOOP
            IF lot[i] IS NOT NULL THEN resultat := resultat || lot[i]; END IF;        
        END LOOP;
        RETURN resultat;
END;
$BODY$
  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION pgcd(valeurs integer[])
  RETURNS integer AS
$BODY$
/*
  Retourne le Plus Grand Commun Diviseur de l'ensemble des valeurs du tableau d'entier.
  Si le tableau ne contient qu'un seul entier, Retourne sa valeur absolue.
 
  Exemple : SELECT pgcd(ARRAY[14,28,49,70]);
  7
 */
DECLARE
    v integer[];
    reste integer;
    a integer;
    b integer;
    gcd integer;
BEGIN
    v := valeurs;
    gcd := 0;
    IF array_length(v,1) > 1 THEN        
        a := v[1];    
        FOR i IN 2..array_upper(v,1)
        LOOP         
            b:=v[i];
            IF b<>0 THEN 
                LOOP
                    reste:=a%b;
                    a:=b;
                    b:=reste;
                    EXIT WHEN reste=0;
                END LOOP;
                
                IF abs(a) < gcd OR gcd = 0 THEN 
                    gcd := abs(a);
                    a := gcd;
                END IF;
                EXIT WHEN gcd=1;
            ELSE
                gcd=0;
                EXIT;
            END IF;    
        END LOOP;
    ELSE
        gcd = abs(v[1]);
    END IF;
        RETURN gcd;
END;
$BODY$
  LANGUAGE plpgsql; 

DROP TABLE IF EXISTS source.tmp_calcul_lot CASCADE;

CREATE TABLE source.tmp_calcul_lot AS(

    SELECT 
        t1.idmutinvar, t1.no_disposition, t1.idpar,
        COALESCE(t1.nb_de_lots_distinct,0) + COALESCE(t2.nombre_de_lots_sup5,0) - COALESCE(nb_de_lots_distinct_sup5,0) AS nblot
    FROM
    (
    SELECT idmutinvar, no_disposition, idpar,
        array_length(ARRAY(SELECT DISTINCT unnest(array_supprimer_null(array_cat(array_agg("1er_lot"),array_cat(array_agg("2eme_lot"),array_cat(array_agg("3eme_lot"),array_cat(array_agg("4eme_lot"), array_agg("5eme_lot")))))::VARCHAR[]))),1) as nb_de_lots_distinct
        --
        -- à partir de la version 9.3
        --array_length(ARRAY(SELECT DISTINCT unnest(array_remove(array_cat(array_agg("1er_lot"),array_cat(array_agg("2eme_lot"),array_cat(array_agg("3eme_lot"),array_cat(array_agg("4eme_lot"), array_agg("5eme_lot"))))), NULL)::VARCHAR[])),1) as nb_de_lots_distinct
      FROM source.tmp_0
      WHERE nombre_de_lots != 0
      GROUP BY idmutinvar, no_disposition, idpar
     ) t1
    LEFT JOIN
    (
    SELECT idmutinvar, no_disposition, idpar,
        array_length(ARRAY(SELECT DISTINCT unnest(array_supprimer_null(array_cat(array_agg("1er_lot"),array_cat(array_agg("2eme_lot"),array_cat(array_agg("3eme_lot"),array_cat(array_agg("4eme_lot"), array_agg("5eme_lot")))))::VARCHAR[]))),1) as nb_de_lots_distinct_sup5,
        --
        -- à partir de la version 9.3
        --array_length(ARRAY(SELECT DISTINCT unnest(array_remove(array_cat(array_agg("1er_lot"),array_cat(array_agg("2eme_lot"),array_cat(array_agg("3eme_lot"),array_cat(array_agg("4eme_lot"), array_agg("5eme_lot"))))), NULL)::VARCHAR[])),1) as nb_de_lots_distinct_sup5,
        SUM(nombre_de_lots) as nombre_de_lots_sup5
      FROM source.tmp_0
      WHERE nombre_de_lots > 5
      GROUP BY idmutinvar, no_disposition, idpar
    ) t2
    ON t1.idmutinvar = t2.idmutinvar and t1.no_disposition = t2.no_disposition and t1.idpar = t2.idpar
);

SELECT count(*) FROM dvf.mutation;

-- insertion table mutation
INSERT INTO dvf.mutation 
(
    idmutinvar, idnatmut, codservch, refdoc, datemut, anneemut, moismut, coddep
)
(
    SELECT t.idmutinvar, t1.idnatmut, t.code_service_ch, t.reference_document, t.date_mutation, t.anneemut, t.moismut, t.code_departement
    FROM source.tmp_0 t
    LEFT JOIN dvf_annexe.ann_nature_mutation t1 ON t.nature_mutation=t1.libnatmut
    LEFT JOIN dvf.mutation t2 ON t.code_service_ch=t2.codservch AND t.reference_document=t2.refdoc 
    WHERE t2.idmutation IS NULL
    GROUP BY t.idmutinvar, t.code_service_ch, t.reference_document, t.date_mutation, t1.idnatmut, t.anneemut, t.moismut, t.code_departement    
);

SELECT count(*) FROM dvf.mutation;

SELECT count(*) FROM dvf.mutation_article_cgi;

-- insertion table mutation_article_cgi
INSERT INTO dvf.mutation_article_cgi
(
    idmutation, idartcgi, ordarticgi, coddep
)
(
    SELECT t2.idmutation, t3.idartcgi, 1 AS ordarticgi, t2.coddep
    FROM source.tmp_0 t
    LEFT JOIN dvf.mutation t2 ON t.code_service_ch=t2.codservch AND t.reference_document=t2.refdoc  
    LEFT JOIN dvf_annexe.ann_cgi t3 ON t."1_articles_cgi"=t3.artcgi
    LEFT JOIN dvf.mutation_article_cgi t4 ON t2.idmutation=t4.idmutation AND 1=t4.ordarticgi
    WHERE 
        t."1_articles_cgi" IS NOT NULL 
        AND t4.idmutation IS NULL
    GROUP BY t2.idmutation, t3.idartcgi, t2.coddep
    
    UNION

    SELECT t2.idmutation, t3.idartcgi, 2 AS ordarticgi, t2.coddep
    FROM source.tmp_0 t
    LEFT JOIN dvf.mutation t2 ON t.code_service_ch=t2.codservch AND t.reference_document=t2.refdoc  
    LEFT JOIN dvf_annexe.ann_cgi t3 ON t."2_articles_cgi"=t3.artcgi
    LEFT JOIN dvf.mutation_article_cgi t4 ON t2.idmutation=t4.idmutation AND 2=t4.ordarticgi
    WHERE 
        t."2_articles_cgi" IS NOT NULL 
        AND t4.idmutation IS NULL
    GROUP BY t2.idmutation, t3.idartcgi, t2.coddep

    UNION

    SELECT t2.idmutation, t3.idartcgi, 3 AS ordarticgi, t2.coddep
    FROM source.tmp_0 t
    LEFT JOIN dvf.mutation t2 ON t.code_service_ch=t2.codservch AND t.reference_document=t2.refdoc  
    LEFT JOIN dvf_annexe.ann_cgi t3 ON t."3_articles_cgi"=t3.artcgi
    LEFT JOIN dvf.mutation_article_cgi t4 ON t2.idmutation=t4.idmutation AND 3=t4.ordarticgi
    WHERE 
        t."3_articles_cgi" IS NOT NULL 
        AND t4.idmutation IS NULL
    GROUP BY t2.idmutation, t3.idartcgi, t2.coddep

    UNION

    SELECT t2.idmutation, t3.idartcgi, 4 AS ordarticgi, t2.coddep
    FROM source.tmp_0 t
    LEFT JOIN dvf.mutation t2 ON t.code_service_ch=t2.codservch AND t.reference_document=t2.refdoc  
    LEFT JOIN dvf_annexe.ann_cgi t3 ON t."4_articles_cgi"=t3.artcgi
    LEFT JOIN dvf.mutation_article_cgi t4 ON t2.idmutation=t4.idmutation AND 4=t4.ordarticgi
    WHERE 
        t."4_articles_cgi" IS NOT NULL 
        AND t4.idmutation IS NULL
    GROUP BY t2.idmutation, t3.idartcgi, t2.coddep
    
    UNION

    SELECT t2.idmutation, t3.idartcgi, 5 AS ordarticgi, t2.coddep
    FROM source.tmp_0 t
    LEFT JOIN dvf.mutation t2 ON t.code_service_ch=t2.codservch AND t.reference_document=t2.refdoc  
    LEFT JOIN dvf_annexe.ann_cgi t3 ON t."5_articles_cgi"=t3.artcgi
    LEFT JOIN dvf.mutation_article_cgi t4 ON t2.idmutation=t4.idmutation AND 5=t4.ordarticgi
    WHERE 
        t."5_articles_cgi" IS NOT NULL 
        AND t4.idmutation IS NULL
    GROUP BY t2.idmutation, t3.idartcgi, t2.coddep
    
);

SELECT count(*) FROM dvf.mutation_article_cgi;

SELECT count(*) FROM dvf.disposition;

-- insertion table disposition
INSERT INTO dvf.disposition 
(
    idmutation, nodispo, valeurfonc, nblot, coddep
)
(
    SELECT tt.idmutation, tt.no_disposition, tt.valeur_fonciere, COALESCE(tt.nblot, 0), tt.code_departement
    FROM
    (
        SELECT t2.idmutation, t.no_disposition, t.valeur_fonciere, t4.nblot, t.code_departement
        FROM source.tmp_0 t
        LEFT JOIN dvf.mutation t2 ON t.code_service_ch=t2.codservch AND t.reference_document=t2.refdoc
        LEFT JOIN 
            (
                SELECT 
                    idmutinvar, no_disposition, sum(nblot) as nblot
                FROM
                source.tmp_calcul_lot
                GROUP BY idmutinvar, no_disposition
            ) t4 
            ON t.idmutinvar = t4.idmutinvar AND t.no_disposition = t4.no_disposition
        LEFT JOIN dvf.disposition t3 ON t2.idmutation=t3.idmutation AND t.no_disposition=t3.nodispo         
        WHERE iddispo IS NULL
        GROUP BY t2.idmutation, t.no_disposition,t.valeur_fonciere, t4.nblot, t.code_departement        
    ) tt
    GROUP BY tt.idmutation, tt.no_disposition, tt.valeur_fonciere, tt.nblot, tt.code_departement    
);

SELECT count(*) FROM dvf.disposition;

SELECT count(*) FROM dvf.parcelle;

-- insertion table parcelle
INSERT INTO dvf.parcelle 
(
    idpar, coddep, codcomm, prefsect, nosect, noplan
)
(
    SELECT 
        t.idpar,
        t.code_departement,
        t.code_commune,
        t.prefixe_de_section,
        t.section,
        t.no_plan
    FROM source.tmp_0 t
    LEFT JOIN dvf.parcelle t4 ON t.idpar=t4.idpar
    WHERE t4.idparcelle IS NULL
    GROUP BY t.idpar, t.code_departement, t.code_commune, t.prefixe_de_section, t.section, t.no_plan
);

SELECT count(*) FROM dvf.parcelle;

SELECT count(*) FROM dvf.disposition_parcelle;

-- insertion table disposition_parcelle
INSERT INTO dvf.disposition_parcelle 
(
    iddispo, idparcelle, idmutation, coddep, datemut, anneemut, moismut 
)
(
    SELECT t3.iddispo, t4.idparcelle, t2.idmutation, t2.coddep, t2.datemut, t.anneemut, t.moismut
    FROM source.tmp_0 t
    LEFT JOIN dvf.mutation t2 ON t.code_service_ch=t2.codservch AND t.reference_document=t2.refdoc 
    LEFT JOIN dvf.disposition t3 ON t2.idmutation=t3.idmutation AND t.no_disposition=t3.nodispo
    LEFT JOIN dvf.parcelle t4 ON t.idpar=t4.idpar
    LEFT JOIN dvf.disposition_parcelle t5 ON t3.iddispo=t5.iddispo AND t4.idparcelle=t5.idparcelle
    WHERE t5.iddispopar IS NULL
    GROUP BY t3.iddispo, t4.idparcelle, t2.idmutation, t2.coddep, t2.datemut, t.anneemut, t.moismut
);

SELECT count(*) FROM dvf.disposition_parcelle;

SELECT count(*) FROM dvf.adresse;

-- insertion table adresse
INSERT INTO dvf.adresse 
(
    novoie, btq, codvoie, typvoie, voie, codepostal, commune, idadrinvar, coddep
)
(
    SELECT t.no_voie, t.b_t_q, t.code_voie, t.type_de_voie, t.voie, t.code_postal, t.commune, t.idadr_tmp, t.code_departement
    FROM source.tmp_0 t
    LEFT JOIN dvf.adresse t6 ON t.idadr_tmp=t6.idadrinvar
    WHERE t6.idadresse IS NULL
    GROUP BY t.no_voie, t.b_t_q, t.code_voie, t.type_de_voie, t.voie, t.code_postal, t.commune, t.idadr_tmp, t.code_departement
    ORDER BY t.no_voie, t.b_t_q, t.code_voie, t.type_de_voie, t.voie, t.code_postal, t.commune, t.idadr_tmp, t.code_departement
);

SELECT count(*) FROM dvf.adresse;

DROP TABLE IF EXISTS source.tmp_0_tmp CASCADE;

CREATE TABLE source.tmp_0_tmp AS
(
    SELECT 
        t2.idmutation,
        t2.coddep,
        t2.datemut,
        t2.anneemut,
        t2.moismut,
        t5.iddispopar,
        t3.iddispo, 
        t4.idparcelle,
        t4.idpar,
        -- pour table "volume"
        no_volume, 
        -- pour table "lot"
        "1er_lot", surface_carrez_du_1er_lot, "2eme_lot", surface_carrez_du_2eme_lot, 
        "3eme_lot", surface_carrez_du_3eme_lot, "4eme_lot", surface_carrez_du_4eme_lot, 
        "5eme_lot", surface_carrez_du_5eme_lot, 
        -- pour table "local"
        code_type_local, type_local, identifiant_local, surface_reelle_bati, nombre_pieces_principales, idloc,
        -- pour table "suf" 
        nature_culture, nature_culture_speciale, surface_terrain, nodcnt,
        -- pour table "adresse"
        no_voie, b_t_q, type_de_voie, code_voie, voie, code_postal, commune,
        -- pour tous
        idadr_tmp, idsuf_tmp
    FROM source.tmp_0 t
    LEFT JOIN dvf.mutation t2 ON t.code_service_ch=t2.codservch AND t.reference_document=t2.refdoc 
    LEFT JOIN dvf.disposition t3 ON t2.idmutation=t3.idmutation AND t.no_disposition=t3.nodispo
    LEFT JOIN dvf.parcelle t4 ON t.idpar=t4.idpar
    LEFT JOIN dvf.disposition_parcelle t5 ON t3.iddispo=t5.iddispo AND t4.idparcelle=t5.idparcelle
);

SELECT count(*) FROM dvf.local;

-- insertion table local
INSERT INTO dvf.local 
(
    idmutation, iddispopar, idpar, idloc, identloc, codtyploc, libtyploc, nbpprinc, sbati, coddep, datemut, anneemut, moismut
)
(
    SELECT t.idmutation, t.iddispopar, t.idpar, t.idloc, t.identifiant_local, t.code_type_local, t.type_local, t.nombre_pieces_principales, t.surface_reelle_bati, t.coddep, t.datemut, t.anneemut, t.moismut
    FROM source.tmp_0_tmp t
    LEFT JOIN dvf.local t7 ON t.iddispopar=t7.iddispopar AND t.identifiant_local=t7.identloc
    WHERE 
        t7.iddispoloc IS NULL
        AND t.identifiant_local IS NOT NULL
    GROUP BY t.idmutation, t.iddispopar, t.idpar, t.idloc, t.identifiant_local, t.code_type_local, t.type_local, t.nombre_pieces_principales, t.surface_reelle_bati, t.coddep, t.datemut, t.anneemut, t.moismut
    ORDER BY t.idmutation, t.iddispopar, t.identifiant_local, t.code_type_local, t.nombre_pieces_principales, t.surface_reelle_bati
);

SELECT count(*) FROM dvf.local;

SELECT count(*) FROM dvf.volume;

-- insertion table volume
INSERT INTO dvf.volume 
(
    iddispopar, idmutation, novolume, coddep
)
(
    SELECT t.iddispopar, t.idmutation, t.no_volume, t.coddep
    FROM source.tmp_0_tmp t
    LEFT JOIN dvf.volume t8 ON t.iddispopar=t8.iddispopar AND t.no_volume=t8.novolume
    WHERE 
        t8.iddispovol IS NULL
        AND t.no_volume IS NOT NULL
    GROUP BY t.iddispopar, t.idmutation, t.no_volume, t.coddep
    ORDER BY t.iddispopar, t.idmutation, t.no_volume
);

SELECT count(*) FROM dvf.volume;

SELECT count(*) FROM dvf.suf;

DROP TABLE IF EXISTS source.tmp_suf;
CREATE TABLE source.tmp_suf AS
(
    SELECT
        iddispopar, idmutation, count(*) as nb_suf_idt, surface_terrain, nature_culture, nature_culture_speciale, idsuf_tmp, coddep, nodcnt
    FROM 
        source.tmp_0_tmp t1
    WHERE
        nature_culture IS NOT NULL
    GROUP BY 
        iddispopar, idmutation, surface_terrain, nature_culture, nature_culture_speciale, idsuf_tmp, coddep, nodcnt
);
-- insertion table suf
INSERT INTO dvf.suf 
(
    iddispopar, idmutation, nbsufidt, sterr, natcult, natcultspe, idsufinvar, coddep, nodcnt
)
(
    SELECT
        t1.iddispopar, t1.idmutation, t1.nb_suf_idt/t2.pgcd_nb_suf_idt AS nb_suf_idt, t1.surface_terrain*t1.nb_suf_idt/t2.pgcd_nb_suf_idt AS surface_terrain, t1.nature_culture, t1.nature_culture_speciale, t1.idsuf_tmp, t1.coddep, t1.nodcnt
    FROM 
        source.tmp_suf t1
    LEFT JOIN
        (SELECT iddispopar, pgcd(array_agg(nb_suf_idt)::integer[]) AS pgcd_nb_suf_idt FROM source.tmp_suf GROUP BY iddispopar) t2
    ON
        t1.iddispopar=t2.iddispopar
    LEFT JOIN
        dvf.suf t3
    ON 
        t1.iddispopar=t3.iddispopar
    WHERE
        t3.iddispopar IS NULL
);
DROP TABLE IF EXISTS source.tmp_suf;

SELECT count(*) FROM dvf.suf;

SELECT count(*) FROM dvf.lot;

-- insertion table lot
INSERT INTO dvf.lot
(
    iddispopar, idmutation, iddispoloc, nolot, scarrez, coddep
)
(
    SELECT t.iddispopar, t.idmutation, t.iddispoloc, t.nolot, t.surf, t.coddep
    FROM
    (
        SELECT t1.iddispopar, t1.idmutation, t3.iddispoloc, t1."1er_lot" as nolot, surface_carrez_du_1er_lot as surf, t1.coddep
        FROM source.tmp_0_tmp t1
        LEFT JOIN dvf.lot t2 ON t1.iddispopar=t2.iddispopar AND t2.nolot=t1."1er_lot"
        LEFT JOIN dvf.local t3 ON t1.iddispopar=t3.iddispopar AND t1.identifiant_local=t3.identloc
        WHERE 
            t1."1er_lot" IS NOT NULL 
            AND t2.iddispolot IS NULL
        
        UNION
    
        SELECT t1.iddispopar, t1.idmutation, t3.iddispoloc, t1."2eme_lot" as nolot, surface_carrez_du_2eme_lot as surf, t1.coddep
        FROM source.tmp_0_tmp t1
        LEFT JOIN dvf.lot t2 ON t1.iddispopar=t2.iddispopar AND t2.nolot=t1."2eme_lot"
        LEFT JOIN dvf.local t3 ON t1.iddispopar=t3.iddispopar AND t1.identifiant_local=t3.identloc
        WHERE 
            t1."2eme_lot" IS NOT NULL 
            AND t2.iddispolot IS NULL
        
        UNION
    
        SELECT t1.iddispopar, t1.idmutation, t3.iddispoloc, t1."3eme_lot" as nolot, surface_carrez_du_3eme_lot as surf, t1.coddep
        FROM source.tmp_0_tmp t1
        LEFT JOIN dvf.lot t2 ON t1.iddispopar=t2.iddispopar AND t2.nolot=t1."3eme_lot"
        LEFT JOIN dvf.local t3 ON t1.iddispopar=t3.iddispopar AND t1.identifiant_local=t3.identloc
        WHERE 
            t1."3eme_lot" IS NOT NULL 
            AND t2.iddispolot IS NULL
        
        UNION
    
        SELECT t1.iddispopar, t1.idmutation, t3.iddispoloc, t1."4eme_lot" as nolot, surface_carrez_du_4eme_lot as surf, t1.coddep
        FROM source.tmp_0_tmp t1
        LEFT JOIN dvf.lot t2 ON t1.iddispopar=t2.iddispopar AND t2.nolot=t1."4eme_lot"
        LEFT JOIN dvf.local t3 ON t1.iddispopar=t3.iddispopar AND t1.identifiant_local=t3.identloc
        WHERE 
            t1."4eme_lot" IS NOT NULL 
            AND t2.iddispolot IS NULL
        
        UNION
    
        SELECT t1.iddispopar, t1.idmutation, t3.iddispoloc, t1."5eme_lot" as nolot, surface_carrez_du_5eme_lot as surf, t1.coddep
        FROM source.tmp_0_tmp t1
        LEFT JOIN dvf.lot t2 ON t1.iddispopar=t2.iddispopar AND t2.nolot=t1."5eme_lot"
        LEFT JOIN dvf.local t3 ON t1.iddispopar=t3.iddispopar AND t1.identifiant_local=t3.identloc
        WHERE 
            t1."5eme_lot" IS NOT NULL 
            AND t2.iddispolot IS NULL
    ) t
    GROUP BY t.iddispopar, t.idmutation, t.iddispoloc, t.nolot, t.surf, t.coddep
);

SELECT count(*) FROM dvf.lot;

SELECT count(*) FROM dvf.adresse_local;

SELECT count(*) FROM dvf.adresse_dispoparc;

DROP TABLE IF EXISTS source.tmp_adresse_dispoparc_local;
CREATE TABLE source.tmp_adresse_dispoparc_local AS
(
    SELECT t3.idadresse, t2.iddispoloc, t.iddispopar, t.coddep, t.idmutation
    FROM source.tmp_0_tmp t
    LEFT JOIN dvf.local t2 ON t.iddispopar=t2.iddispopar AND t.identifiant_local=t2.identloc
    LEFT JOIN dvf.adresse t3 ON t.idadr_tmp=t3.idadrinvar
);
    -- insertion adresse_dispoparc
    INSERT INTO dvf.adresse_dispoparc 
    (
        idadresse, iddispopar, coddep, idmutation
    )
    (
        SELECT t1.idadresse, t1.iddispopar, t1.coddep, t1.idmutation
        FROM source.tmp_adresse_dispoparc_local t1
        LEFT JOIN dvf.adresse_dispoparc t2
        ON t1.idadresse=t2.idadresse AND t1.iddispopar=t2.iddispopar
        WHERE 
            t1.idadresse IS NOT NULL
            AND t1.iddispopar IS NOT NULL
            AND t2.idadresse IS NULL
            AND t2.iddispopar IS NULL
        GROUP BY t1.idadresse, t1.iddispopar, t1.coddep, t1.idmutation
        
    );

    -- insertion adresse_local
    INSERT INTO dvf.adresse_local 
    (
        idadresse, iddispoloc, coddep, idmutation
    )
    (
        SELECT t1.idadresse, t1.iddispoloc, t1.coddep, t1.idmutation
        FROM source.tmp_adresse_dispoparc_local t1
        LEFT JOIN dvf.adresse_local t2
        ON t1.idadresse=t2.idadresse AND t1.iddispoloc=t2.iddispoloc
        WHERE 
            t1.idadresse IS NOT NULL
            AND t1.iddispoloc IS NOT NULL
            AND t2.idadresse IS NULL
            AND t2.iddispoloc IS NULL
        GROUP BY t1.idadresse, t1.iddispoloc, t1.coddep, t1.idmutation
        
    );
DROP TABLE IF EXISTS source.tmp_adresse_dispoparc_local;

SELECT count(*) FROM dvf.adresse_dispoparc;

SELECT count(*) FROM dvf.adresse_local;

DROP TABLE IF EXISTS source.tmp_calcul_lot CASCADE;

DROP TABLE IF EXISTS source.tmp_0_tmp CASCADE;


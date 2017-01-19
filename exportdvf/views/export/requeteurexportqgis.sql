## BOX
SELECT MIN(ST_XMIN(geompar)) AS XMIN, 
	   MIN(ST_YMIN(geompar)) AS YMIN, 
	   MAX(ST_XMAX(geompar)) AS XMAX, 
	   MAX(ST_YMAX(geompar)) AS YMAX 
FROM dvf.mutation
WHERE geompar IS NOT NULL

## GENERER_VUES_QGIS
/* 
Ajout vues pour l'analyse et la visualisation sous Qgis
*/

-------------------------------------------------- View: dvf.mutationtypo
-- cast en text de tous les champs l_xx
-- renommage de certains champs dont le nom exécédait 10 car
-- passage en st-multi de toutes les géométries

DROP VIEW IF EXISTS dvf.mutationtypo CASCADE;
CREATE OR REPLACE VIEW dvf.mutationtypo AS 
 SELECT mutation.idmutation,
    mutation.idmutinvar,
    mutation.idnatmut,
    mutation.codservch,
    mutation.refdoc,
    mutation.datemut,
    mutation.anneemut,
    mutation.moismut,
    mutation.coddep,
    mutation.libnatmut,
    mutation.nbartcgi,
    mutation.l_artcgi,
    mutation.vefa,
    mutation.valeurfonc,
    mutation.nbdispo,
    mutation.nblot,
    mutation.nbcomm,
    mutation.l_codinsee,
    mutation.nbsection,
    mutation.l_section,
    mutation.nbpar,
    mutation.l_idpar,
    mutation.nbparmut,
    mutation.l_idparmut,
    mutation.nbsuf,
    mutation.sterr,
    mutation.l_dcnt,
    mutation.nbvolmut,
    mutation.nblocmut,
    mutation.l_idlocmut,
    mutation.nblocmai,
    mutation.nblocapt,
    mutation.nblocdep,
    mutation.nblocact,
    mutation.nbapt1pp,
    mutation.nbapt2pp,
    mutation.nbapt3pp,
    mutation.nbapt4pp,
    mutation.nbapt5pp,
    mutation.nbmai1pp,
    mutation.nbmai2pp,
    mutation.nbmai3pp,
    mutation.nbmai4pp,
    mutation.nbmai5pp,
    mutation.sbati,
    mutation.sbatmai,
    mutation.sbatapt,
    mutation.sbatact,
    mutation.sapt1pp,
    mutation.sapt2pp,
    mutation.sapt3pp,
    mutation.sapt4pp,
    mutation.sapt5pp,
    mutation.smai1pp,
    mutation.smai2pp,
    mutation.smai3pp,
    mutation.smai4pp,
    mutation.smai5pp,
    mutation.l_idv,
    mutation.l_nomv,
    mutation.codtypprov,
    mutation.fiabmaxv,
    mutation.l_ida,
    mutation.l_noma,
    mutation.codtypproa,
    mutation.fiabmaxa,
    mutation.ffsparc,
    mutation.ffsterr,
    mutation.l_ffdcnt,
    mutation.nbpardisp,
    mutation.nbparapp,
    mutation.ffnblocmai,
    mutation.ffnblocapt,
    mutation.ffnblocdep,
    mutation.ffnblocact,
    mutation.ffnbactsec,
    mutation.ffnbactter,
    mutation.ffnbloch,
    mutation.nblocanc,
    mutation.nblocrecen,
    mutation.nblocneuf,
    mutation.ffancstmin,
    mutation.ffancstmax,
    mutation.ffnbloc1pp,
    mutation.ffnbloc2pp,
    mutation.ffnbloc3pp,
    mutation.ffnbloc4pp,
    mutation.ffnbloc5pp,
    mutation.ffnbpgarag,
    mutation.ffnbpterra,
    mutation.ffnbppisci,
    mutation.ffnbpcav,
    mutation.nblocdisp,
    mutation.nblocapp,
    mutation.ffsbati,
    mutation.ffshab,
    mutation.ffsdep,
    mutation.ffspro,
    mutation.occupation,
    mutation.codtypbien,
    mutation.libtypbien,
    mutation.rapatffloc,
    mutation.rapatffpar,
    st_multi(mutation.geomlocmut)::geometry(MultiPoint,2154) AS geomlocmut,
    st_multi(mutation.geomparmut)::geometry(MultiPolygon,2154) AS geomparmut,
    st_multi(mutation.geompar)::geometry(MultiPolygon,2154) AS geompar,
    mutation.rolev,
    mutation.rolea,
    mutation.segmusage,
        CASE
            WHEN mutation.sterr > 0::numeric THEN round(mutation.valeurfonc / mutation.sterr, 2)
            ELSE NULL::numeric
        END AS e_m2_terr,
        CASE
            WHEN mutation.sbati > 0::numeric THEN round(mutation.valeurfonc / mutation.sbati, 2)
            ELSE NULL::numeric
        END AS e_m2_bati,
        CASE
            WHEN (COALESCE(mutation.sbatmai, 0::numeric) + COALESCE(mutation.sbatapt, 0::numeric)) > 0::numeric THEN round(mutation.valeurfonc / (COALESCE(mutation.sbatmai, 0::numeric) + COALESCE(mutation.sbatapt, 0::numeric)), 2)
            ELSE NULL::numeric
        END AS e_m2_bat_h,
    COALESCE(mutation.nblot > 0, false) AS pres_lot,
        CASE
            WHEN mutation.valeurfonc IS NULL OR (mutation.valeurfonc = ANY (ARRAY[0::numeric, 1::numeric])) THEN 'HorsNorme'::text
            WHEN mutation.libnatmut::text = 'Echange'::text THEN 'Echange de biens'::text
            WHEN mutation.libnatmut::text = 'Expropriation'::text THEN 'Expropriation'::text
            WHEN mutation.libnatmut::text = 'Adjudication'::text THEN 'Adjudication'::text
            WHEN mutation.nbvolmut IS NOT NULL AND mutation.nbvolmut > 0 THEN 'Volume'::text
            WHEN mutation.vefa IS TRUE THEN 'VEFA'::text
            WHEN mutation.nbcomm > 1 THEN 'Pluricommunal'::text
            WHEN mutation.nblocmut >= 1 THEN 'avec Bâti'::text
            WHEN mutation.nblocmut = 0 THEN 'sans Bâti'::text
            ELSE 'Erreur'::text
        END AS typologie1,
        CASE
            WHEN mutation.nbvolmut IS NOT NULL AND mutation.nbvolmut > 0 THEN 'Volume'::text
            WHEN mutation.vefa IS TRUE THEN
            CASE
                WHEN mutation.nblocmut = (mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai = 1 THEN 'VEFA-MI'::text
                WHEN mutation.nblocmut = (mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai > 1 THEN 'VEFA-MIs'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocdep) AND mutation.nblocapt = 1 THEN 'VEFA-APP'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocdep) AND mutation.nblocapt > 1 THEN 'VEFA-APPs'::text
                WHEN mutation.nblocmut = (mutation.nblocact + mutation.nblocdep) AND mutation.nblocact = 1 THEN 'VEFA-ACT'::text
                WHEN mutation.nblocmut = (mutation.nblocact + mutation.nblocdep) AND mutation.nblocact > 1 THEN 'VEFA-ACTs'::text
                ELSE 'VEFA-Autres'::text
            END
            WHEN mutation.nblocmut >= 1 THEN
            CASE
                WHEN mutation.l_artcgi && ARRAY['1594Ibis'::character varying] AND (mutation.nblocapt > 0 OR mutation.nblocmai > 0) THEN 'LOGT/ACT'::text
                WHEN mutation.libnatmut::text = 'Vente terrain à bâtir'::text THEN 'TAB-BATI'::text
                WHEN mutation.sterr > 10000::numeric AND mutation.l_dcnt[10] > 0::numeric THEN 'TAB-BATI'::text
                WHEN mutation.sterr > 10000::numeric AND ARRAY['1137'::character varying] && mutation.l_artcgi THEN 'Terrains Forestiers Batis'::text
                WHEN mutation.sterr > 10000::numeric AND ARRAY['1594FQD'::character varying, '1594FQE'::character varying, '1594FQE I'::character varying, '1594FQE II'::character varying, '1594FQG'::character varying] && mutation.l_artcgi THEN 'Terrains Agricoles Batis'::text
                WHEN mutation.l_artcgi && ARRAY['1137'::character varying] THEN 'BATIFOR'::text
                WHEN ARRAY['1594FQD'::character varying, '1594FQE'::character varying, '1594FQE I'::character varying, '1594FQE II'::character varying, '1594FQG'::character varying] && mutation.l_artcgi THEN 'BATIAGRI'::text
                WHEN mutation.sterr > 10000::numeric AND (mutation.l_dcnt[1] >= ALL (mutation.l_dcnt)) THEN 'Terrains Agricoles Batis'::text
                WHEN mutation.sterr > 10000::numeric AND (mutation.l_dcnt[2] >= ALL (mutation.l_dcnt)) THEN 'Terrains Agricoles Batis'::text
                WHEN mutation.sterr > 10000::numeric AND (mutation.l_dcnt[3] >= ALL (mutation.l_dcnt)) THEN 'Terrains Agricoles Batis'::text
                WHEN mutation.sterr > 10000::numeric AND (mutation.l_dcnt[4] >= ALL (mutation.l_dcnt)) THEN 'Terrains Agricoles Batis'::text
                WHEN mutation.nblocmut = mutation.nblocdep AND mutation.nblocdep >= 1 THEN 'DEP'::text
                WHEN mutation.nblocmut = (mutation.nblocact + mutation.nblocdep) AND mutation.nblocact >= 1 THEN 'ACT'::text
                WHEN mutation.sbati < 9::numeric THEN 'Bâti indéfini'::text
                WHEN mutation.nblocmut = (mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai = 1 THEN 'MI'::text
                WHEN mutation.nblocmut = (mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai > 1 THEN 'MIs'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocdep) AND mutation.nblocapt = 1 THEN 'APP'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocdep) AND mutation.nblocapt > 1 THEN 'APPs'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai >= 1 AND mutation.nblocapt >= 1 THEN 'MIs-APPs'::text
                WHEN (mutation.nblocapt >= 1 OR mutation.nblocmai >= 1) AND mutation.nblocact >= 1 THEN 'MIXTE HAB-ACT'::text
                ELSE 'BATI-Autres'::text
            END
            WHEN mutation.nblocmut = 0 THEN
            CASE
                WHEN mutation.libnatmut::text = 'Vente terrain à bâtir'::text OR mutation.l_dcnt[10] > 0::numeric OR ARRAY['1594D*2'::character varying, '1594OGA'::character varying, '257-7-1*3'::character varying, '278 sexies I.1'::character varying, '691bis'::character varying] && mutation.l_artcgi THEN 'TAB'::text
                WHEN ARRAY['1137'::character varying] && mutation.l_artcgi THEN 'Terrains Forestiers'::text
                WHEN ARRAY['1594FQD'::character varying, '1594FQE'::character varying, '1594FQE I'::character varying, '1594FQE II'::character varying, '1594FQG'::character varying] && mutation.l_artcgi THEN 'Terrains Agricoles'::text
                WHEN mutation.l_dcnt[11] >= ALL (mutation.l_dcnt) THEN 'Terrains Agrément'::text
                WHEN mutation.l_dcnt[9] >= ALL (mutation.l_dcnt) THEN 'Terrains Agrément'::text
                WHEN mutation.l_dcnt[5] >= ALL (mutation.l_dcnt) THEN 'Terrains Forestiers'::text
                WHEN mutation.l_dcnt[6] >= ALL (mutation.l_dcnt) THEN 'Terrains Naturels'::text
                WHEN mutation.l_dcnt[8] >= ALL (mutation.l_dcnt) THEN 'Terrains Naturels'::text
                WHEN mutation.l_dcnt[1] >= ALL (mutation.l_dcnt) THEN 'Terrains Agricoles'::text
                WHEN mutation.l_dcnt[2] >= ALL (mutation.l_dcnt) THEN 'Terrains Agricoles'::text
                WHEN mutation.l_dcnt[3] >= ALL (mutation.l_dcnt) THEN 'Terrains Agricoles'::text
                WHEN mutation.l_dcnt[4] >= ALL (mutation.l_dcnt) THEN 'Terrains Agricoles'::text
                WHEN mutation.l_dcnt[13] >= ALL (mutation.l_dcnt) THEN 'Terrains artificialisés'::text
                ELSE 'NONBATI-Autres'::text
            END
            ELSE 'NeSaitPas'::text
        END AS typologie2,
        CASE
            WHEN mutation.nbvolmut IS NOT NULL AND mutation.nbvolmut > 0 THEN 'Volume'::text
            WHEN mutation.vefa IS TRUE THEN
            CASE
                WHEN mutation.nblocmut = (mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai = 1 THEN 'VEFA-MI'::text
                WHEN mutation.nblocmut = (mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai > 1 THEN 'VEFA-MIs'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocdep) AND mutation.nblocapt = 1 THEN 'VEFA-APP'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocdep) AND mutation.nblocapt = 2 THEN 'VEFA-2APP'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocdep) AND mutation.nblocapt > 1 THEN 'VEFA-APPs'::text
                WHEN mutation.nblocmut = (mutation.nblocact + mutation.nblocdep) AND mutation.nblocact = 1 THEN 'VEFA-ACT'::text
                WHEN mutation.nblocmut = (mutation.nblocact + mutation.nblocdep) AND mutation.nblocact > 1 THEN 'VEFA-ACTs'::text
                ELSE 'VEFA-Autres'::text
            END
            WHEN mutation.nblocmut IS NOT NULL AND mutation.nblocmut >= 1 THEN
            CASE
                WHEN mutation.l_artcgi && ARRAY['1594Ibis'::character varying] AND (mutation.nblocapt > 0 OR mutation.nblocmai > 0) THEN 'LOGT/ACT'::text
                WHEN mutation.l_artcgi && ARRAY['1137'::character varying] THEN 'BATIFOR'::text
                WHEN ARRAY['1594FQD'::character varying, '1594FQE'::character varying, '1594FQE I'::character varying, '1594FQE II'::character varying, '1594FQG'::character varying] && mutation.l_artcgi THEN 'BATIAGRI'::text
                WHEN mutation.libnatmut::text = 'Vente terrain à bâtir'::text THEN 'TAB'::text
                WHEN mutation.sterr > 10000::numeric AND mutation.l_dcnt[10] > 0::numeric THEN 'TAB'::text
                WHEN mutation.sterr > 10000::numeric AND ARRAY['1137'::character varying] && mutation.l_artcgi THEN 'BOIS'::text
                WHEN mutation.sterr > 10000::numeric AND ARRAY['1594FQD'::character varying, '1594FQE'::character varying, '1594FQE I'::character varying, '1594FQE II'::character varying, '1594FQG'::character varying] && mutation.l_artcgi THEN
                CASE
                    WHEN mutation.l_dcnt[1] >= ALL (mutation.l_dcnt[1:4]) THEN 'T'::text
                    WHEN mutation.l_dcnt[2] >= ALL (mutation.l_dcnt[1:4]) THEN 'PRE'::text
                    WHEN mutation.l_dcnt[3] >= ALL (mutation.l_dcnt[1:4]) THEN 'VE'::text
                    WHEN mutation.l_dcnt[4] >= ALL (mutation.l_dcnt[1:4]) THEN 'VI'::text
                    ELSE NULL::text
                END
                WHEN mutation.sterr > 10000::numeric AND (mutation.l_dcnt[1] >= ALL (mutation.l_dcnt)) THEN 'T Bati'::text
                WHEN mutation.sterr > 10000::numeric AND (mutation.l_dcnt[2] >= ALL (mutation.l_dcnt)) THEN 'PRE Bati'::text
                WHEN mutation.sterr > 10000::numeric AND (mutation.l_dcnt[3] >= ALL (mutation.l_dcnt)) THEN 'VE Bati'::text
                WHEN mutation.sterr > 10000::numeric AND (mutation.l_dcnt[4] >= ALL (mutation.l_dcnt)) THEN 'VI Bati'::text
                WHEN mutation.nblocmut = mutation.nblocdep AND mutation.nblocdep = 1 THEN 'DEP'::text
                WHEN mutation.nblocmut = mutation.nblocdep AND mutation.nblocdep > 1 THEN 'DEPs'::text
                WHEN mutation.nblocmut = (mutation.nblocact + mutation.nblocdep) AND mutation.nblocact >= 1 THEN 'ACT'::text
                WHEN mutation.sbati < 9::numeric THEN 'Bâti indéfini'::text
                WHEN mutation.nblocmut = (mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai = 1 AND COALESCE(mutation.sterr, 0::numeric) = 0::numeric THEN 'MIV'::text
                WHEN mutation.nblocmut = (mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai = 1 AND mutation.sterr > 0::numeric AND (mutation.sterr - mutation.sbati /
                CASE
                    WHEN mutation.sbati > 100::numeric THEN 2
                    ELSE 1
                END::numeric) >= 200::numeric THEN 'MIJ'::text
                WHEN mutation.nblocmut = (mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai = 1 AND mutation.sterr > 0::numeric AND (mutation.sterr - mutation.sbati /
                CASE
                    WHEN mutation.sbati > 100::numeric THEN 2
                    ELSE 1
                END::numeric) < 200::numeric THEN 'MIE'::text
                WHEN mutation.nblocmut = (mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai > 1 AND COALESCE(mutation.sterr, 0::numeric) = 0::numeric THEN 'MIVs'::text
                WHEN mutation.nblocmut = (mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai > 1 AND COALESCE(mutation.sterr, 0::numeric) > 0::numeric THEN 'MITs'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocdep) AND mutation.nblocapt = 1 THEN 'APP'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocdep) AND mutation.nblocapt = 2 THEN '2APP'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocdep) AND mutation.nblocapt >= 3 THEN 'IMM RESID'::text
                WHEN mutation.nblocmut = (mutation.nblocapt + mutation.nblocmai + mutation.nblocdep) AND mutation.nblocmai >= 1 AND mutation.nblocapt >= 1 THEN 'MIs-APPs'::text
                WHEN mutation.nblocmai = 1 AND mutation.nblocact >= 1 THEN 'MI-ACT'::text
                WHEN mutation.nblocapt = 1 AND mutation.nblocact >= 1 THEN 'APP-ACT'::text
                WHEN mutation.nblocapt >= 1 AND mutation.nblocact >= 1 THEN 'MIXTE HAB-ACT'::text
                ELSE 'BATI-Autres'::text
            END
            WHEN mutation.nblocmut IS NULL OR mutation.nblocmut = 0 THEN
            CASE
                WHEN mutation.libnatmut::text = 'Vente terrain à bâtir'::text OR mutation.l_dcnt[10] > 0::numeric OR ARRAY['1594D*2'::character varying, '1594OGA'::character varying, '257-7-1*3'::character varying, '278 sexies I.1'::character varying, '691bis'::character varying] && mutation.l_artcgi THEN 'TAB'::text
                WHEN ARRAY['1137'::character varying] && mutation.l_artcgi THEN 'BOIS'::text
                WHEN ARRAY['1594FQD'::character varying, '1594FQE'::character varying, '1594FQE I'::character varying, '1594FQE II'::character varying, '1594FQG'::character varying] && mutation.l_artcgi THEN
                CASE
                    WHEN mutation.l_dcnt[1] >= ALL (mutation.l_dcnt[1:4]) THEN 'T'::text
                    WHEN mutation.l_dcnt[2] >= ALL (mutation.l_dcnt[1:4]) THEN 'PRE'::text
                    WHEN mutation.l_dcnt[3] >= ALL (mutation.l_dcnt[1:4]) THEN 'VE'::text
                    WHEN mutation.l_dcnt[4] >= ALL (mutation.l_dcnt[1:4]) THEN 'VI'::text
                    ELSE NULL::text
                END
                WHEN mutation.l_dcnt[9] >= ALL (mutation.l_dcnt) THEN 'JARD'::text
                WHEN mutation.l_dcnt[11] >= ALL (mutation.l_dcnt) THEN 'AG'::text
                WHEN mutation.l_dcnt[5] >= ALL (mutation.l_dcnt) THEN 'BOIS'::text
                WHEN mutation.l_dcnt[6] >= ALL (mutation.l_dcnt) THEN 'L'::text
                WHEN mutation.l_dcnt[8] >= ALL (mutation.l_dcnt) THEN 'EAU'::text
                WHEN mutation.l_dcnt[1] >= ALL (mutation.l_dcnt) THEN 'T'::text
                WHEN mutation.l_dcnt[2] >= ALL (mutation.l_dcnt) THEN 'PRE'::text
                WHEN mutation.l_dcnt[3] >= ALL (mutation.l_dcnt) THEN 'VE'::text
                WHEN mutation.l_dcnt[4] >= ALL (mutation.l_dcnt) THEN 'VI'::text
                WHEN mutation.l_dcnt[13] >= ALL (mutation.l_dcnt) THEN 'S'::text
                ELSE 'NONBATI-Autres'::text
            END
            ELSE 'NeSaitPas'::text
        END AS typologie3,
    -- pour plus tard
    NULL::text as typologie4,
    mutation.l_codinsee[1] AS idcom,
    st_x(st_centroid(
        CASE
            WHEN st_isempty(mutation.geompar) THEN NULL::geometry
            ELSE mutation.geompar
        END)) AS st_x,
    st_y(st_centroid(
        CASE
            WHEN st_isempty(mutation.geompar) THEN NULL::geometry
            ELSE mutation.geompar
        END)) AS st_y,
    st_x(st_transform(st_centroid(
        CASE
            WHEN st_isempty(mutation.geompar) THEN NULL::geometry
            ELSE mutation.geompar
        END), 4326)) AS x_mercator,
    st_y(st_transform(st_centroid(
        CASE
            WHEN st_isempty(mutation.geompar) THEN NULL::geometry
            ELSE mutation.geompar
        END), 4326)) AS y_mercator,
    st_x(st_centroid(
        CASE
            WHEN st_isempty(mutation.geomlocmut) THEN NULL::geometry
            ELSE mutation.geomlocmut
        END)) AS xbati,
    st_y(st_centroid(
        CASE
            WHEN st_isempty(mutation.geomlocmut) THEN NULL::geometry
            ELSE mutation.geomlocmut
        END)) AS ybati,
    st_x(st_transform(st_centroid(
        CASE
            WHEN st_isempty(mutation.geomlocmut) THEN NULL::geometry
            ELSE mutation.geomlocmut
        END), 4326)) AS xbati_4326,
    st_y(st_transform(st_centroid(
        CASE
            WHEN st_isempty(mutation.geomlocmut) THEN NULL::geometry
            ELSE mutation.geomlocmut
        END), 4326)) AS ybati_4326
   FROM dvf.mutation;


--------------------------------- View: dvf.localtypo
-- cast en text de tous les champs l_xx
-- passage en st-multi de la géométrie


-- View: dvf.localtypo
DROP VIEW IF EXISTS dvf.localtypo CASCADE;
CREATE OR REPLACE VIEW dvf.localtypo AS 
 SELECT local.iddispoloc,
    local.iddispopar,
    local.idpar,
    local.idmutation,
    local.idloc,
    local.identloc,
    local.codtyploc,
    local.libtyploc,
    local.nbpprinc,
    local.sbati,
    local.coddep,
    local.datemut,
    local.anneemut,
    local.moismut,
    local.nbmutjour,
    local.nbmutannee,
    local.datemutpre,
    local.l_idmutpre::text,
    local.datemutsui,
    local.l_idmutsui::text,
    local.ffidcpv,
    local.fiabilitev,
    local.l_idv::text,
    local.nbdroiprov,
    local.l_nomv::text,
    local.nbdroigesv,
    local.l_nomgesv::text,
    local.codtypprov,
    local.ffidcpa,
    local.fiabilitea,
    local.l_ida::text,
    local.nbdroiproa,
    local.l_noma::text,
    local.nbdroigesa,
    local.l_nomgesa::text,
    local.codtypproa,
    local.ffdatemut,
    local.exactffdvf,
    local.ffancst,
        CASE
            WHEN local.ffancst <> 0 AND local.ffancst <> '-1'::integer AND (date_part('year'::text, local.datemut) - local.ffancst::double precision) <= 1::double precision THEN 'neuf'::text
            WHEN local.ffancst <> 0 AND local.ffancst <> '-1'::integer AND (date_part('year'::text, local.datemut) - local.ffancst::double precision) < 5::double precision THEN 'recent'::text
            WHEN local.ffancst <> 0 AND local.ffancst <> '-1'::integer AND (date_part('year'::text, local.datemut) - local.ffancst::double precision) >= 5::double precision THEN 'ancien'::text
            WHEN mutationtypo.vefa THEN 'neuf'::text
            WHEN (date_part('year'::text, local.datemutpre) - local.anneemut::double precision) >= 5::double precision THEN 'ancien'::text
            ELSE 'non defini'::text
        END AS anciennete,
    local.ffidbat,
    local.ffcodinsee,
    local.ffcommune,
    local.ffnovoie,
    local.ffbtq,
    local.ffvoie,
    local.fftyppdl,
    local.ffclascad,
    local.ffvalloc,
    local.ffcodeval,
    local.fflibeval,
    local.ffcchgeval,
    local.ffdchgeval,
    local.stabilitel,
    local.ffctyploc,
    local.ffltyploc,
    local.ffcnatloc,
    local.fflnatloc,
    local.ffcodnace,
    local.fflibnace,
    local.fflochab,
    local.ffoccv,
    local.ffocca,
    local.ffshab,
    local.ffsdep,
    local.ffspro,
    local.ffsbati,
    local.ffnbpsam,
    local.ffnbpcha,
    local.ffnbpcu8,
    local.ffnbpcu9,
    local.ffnbpsea,
    local.ffnbpann,
    local.ffnbpprinc,
    local.ffnbpgarag,
    local.ffnbpagrem,
    local.ffnbpterra,
    local.ffnbppisci,
    local.ffnbpcav,
    local.ffanref,
    local.ffanvend,
    local.ffanach,
    st_multi(local.geomloc)::geometry(MultiPoint,2154) AS geomloc,
    local.srcgeom,
    local.parcvect,
    mutationtypo.sterr,
    mutationtypo.segmusage,
    mutationtypo.codtypbien,
    mutationtypo.libtypbien,
    mutationtypo.nblocmut,
    mutationtypo.libnatmut,
    mutationtypo.nbdispo,
    mutationtypo.nbcomm,
    mutationtypo.l_codinsee::text,
    mutationtypo.nblocmai,
    mutationtypo.nblocapt,
    mutationtypo.nblocdep,
    mutationtypo.nblocact,
    mutationtypo.sbatact,
    mutationtypo.l_idlocmut::text,
    mutationtypo.nbsuf,
    mutationtypo.nbparmut,
    mutationtypo.l_idparmut::text,
    mutationtypo.l_idpar::text,
    mutationtypo.refdoc,
    mutationtypo.codservch,
    mutationtypo.l_artcgi::text,
    mutationtypo.nbartcgi,
    mutationtypo.valeurfonc,
    mutationtypo.e_m2_terr,
    mutationtypo.e_m2_bati,
    mutationtypo.e_m2_bat_h,
    mutationtypo.occupation,
    mutationtypo.l_dcnt::text,
    mutationtypo.pres_lot,
    mutationtypo.typologie1,
    mutationtypo.typologie2,
    mutationtypo.typologie3,
        CASE
            WHEN (local.ffnbpprinc IS NULL OR local.ffnbpprinc = 0) AND (local.nbpprinc IS NULL OR local.nbpprinc = 0) THEN 'NSP'::text
            WHEN local.nbpprinc > 0 AND local.nbpprinc < 5 THEN 'T'::text || local.nbpprinc::text
            WHEN local.nbpprinc >= 5 THEN 'T5+'::text
            WHEN local.ffnbpprinc > 0 AND local.ffnbpprinc < 5 THEN 'T'::text || local.ffnbpprinc::text
            WHEN local.ffnbpprinc >= 5 THEN 'T5+'::text
            WHEN local.sbati > 0::numeric AND local.sbati < 35::numeric THEN 'T1'::text
            WHEN local.sbati > 0::numeric AND local.sbati < 55::numeric THEN 'T2'::text
            WHEN local.sbati > 0::numeric AND local.sbati < 80::numeric THEN 'T3'::text
            WHEN local.sbati > 0::numeric AND local.sbati < 100::numeric THEN 'T4'::text
            WHEN local.sbati > 0::numeric AND local.sbati >= 100::numeric THEN 'T5+'::text
            ELSE 'NSP'::text
        END AS typologie4,
    (mutationtypo.nblocmut - mutationtypo.nblocdep) = 1 AS localseul,
        CASE
            WHEN local.ffancst < 1915 THEN ']avant 1914]'::text
            WHEN local.ffancst < 1954 THEN ']1914,1953]'::text
            WHEN local.ffancst < 1975 THEN ']1953,1974]'::text
            WHEN local.ffancst < 1991 THEN ']1974,1990]'::text
            WHEN local.ffancst < 2001 THEN ']1990,2000]'::text
            WHEN mutationtypo.vefa IS NOT NULL THEN '[après 2000['::text
            WHEN local.ffancst IS NULL THEN NULL::text
            ELSE NULL::text
        END::character varying(14) AS periode_const,
    "substring"(local.idpar::text, 1, 5) AS idcom,
    st_x(st_centroid(
        CASE
            WHEN st_isempty(local.geomloc) THEN NULL::geometry
            ELSE local.geomloc
        END)) AS xbati,
    st_y(st_centroid(
        CASE
            WHEN st_isempty(local.geomloc) THEN NULL::geometry
            ELSE local.geomloc
        END)) AS ybati,
    st_x(st_transform(st_centroid(
        CASE
            WHEN st_isempty(local.geomloc) THEN NULL::geometry
            ELSE local.geomloc
        END), 4326)) AS xbati_4326,
    st_y(st_transform(st_centroid(
        CASE
            WHEN st_isempty(local.geomloc) THEN NULL::geometry
            ELSE local.geomloc
        END), 4326)) AS ybati_4326
   FROM dvf.mutationtypo,
    dvf.local
  WHERE local.idmutation = mutationtypo.idmutation and local.coddep=mutationtypo.coddep;
-- attention si plusieurs livraisons les idmutation ne sont plus uniques!!
  
-------------------------------------------------- View: dvf.mutationtypo_geomlocmut
-- vue de la vue mutationtypo avec une seule géomtrie

DROP VIEW IF EXISTS dvf.mutationtypo_geomlocmut CASCADE;
CREATE OR REPLACE VIEW dvf.mutationtypo_geomlocmut AS 
 SELECT mutationtypo.idmutation,
    mutationtypo.idmutinvar,
    mutationtypo.idnatmut,
    mutationtypo.codservch,
    mutationtypo.refdoc,
    mutationtypo.datemut,
    mutationtypo.anneemut,
    mutationtypo.moismut,
    mutationtypo.coddep,
    mutationtypo.libnatmut,
    mutationtypo.nbartcgi,
    mutationtypo.l_artcgi::text,
    mutationtypo.vefa,
    mutationtypo.valeurfonc,
    mutationtypo.nbdispo,
    mutationtypo.nblot,
    mutationtypo.nbcomm,
    mutationtypo.l_codinsee::text,
    mutationtypo.nbsection,
    mutationtypo.l_section::text,
    mutationtypo.nbpar,
    mutationtypo.l_idpar::text,
    mutationtypo.nbparmut,
    mutationtypo.l_idparmut::text,
    mutationtypo.nbsuf,
    mutationtypo.sterr,
    mutationtypo.l_dcnt::text,
    mutationtypo.nbvolmut,
    mutationtypo.nblocmut,
    mutationtypo.l_idlocmut::text,
    mutationtypo.nblocmai,
    mutationtypo.nblocapt,
    mutationtypo.nblocdep,
    mutationtypo.nblocact,
    mutationtypo.nbapt1pp,
    mutationtypo.nbapt2pp,
    mutationtypo.nbapt3pp,
    mutationtypo.nbapt4pp,
    mutationtypo.nbapt5pp,
    mutationtypo.nbmai1pp,
    mutationtypo.nbmai2pp,
    mutationtypo.nbmai3pp,
    mutationtypo.nbmai4pp,
    mutationtypo.nbmai5pp,
    mutationtypo.sbati,
    mutationtypo.sbatmai,
    mutationtypo.sbatapt,
    mutationtypo.sbatact,
    mutationtypo.sapt1pp,
    mutationtypo.sapt2pp,
    mutationtypo.sapt3pp,
    mutationtypo.sapt4pp,
    mutationtypo.sapt5pp,
    mutationtypo.smai1pp,
    mutationtypo.smai2pp,
    mutationtypo.smai3pp,
    mutationtypo.smai4pp,
    mutationtypo.smai5pp,
    mutationtypo.l_idv::text,
    mutationtypo.l_nomv::text,
    mutationtypo.codtypprov,
    mutationtypo.fiabmaxv,
    mutationtypo.l_ida::text,
    mutationtypo.l_noma::text,
    mutationtypo.codtypproa,
    mutationtypo.fiabmaxa,
    mutationtypo.ffsparc,
    mutationtypo.ffsterr,
    mutationtypo.l_ffdcnt::text,
    mutationtypo.nbpardisp,
    mutationtypo.nbparapp,
    mutationtypo.ffnblocmai,
    mutationtypo.ffnblocapt,
    mutationtypo.ffnblocdep,
    mutationtypo.ffnblocact,
    mutationtypo.ffnbactsec,
    mutationtypo.ffnbactter,
    mutationtypo.ffnbloch,
    mutationtypo.nblocanc,
    mutationtypo.nblocrecen,
    mutationtypo.nblocneuf,
    mutationtypo.ffancstmin,
    mutationtypo.ffancstmax,
    mutationtypo.ffnbloc1pp,
    mutationtypo.ffnbloc2pp,
    mutationtypo.ffnbloc3pp,
    mutationtypo.ffnbloc4pp,
    mutationtypo.ffnbloc5pp,
    mutationtypo.ffnbpgarag,
    mutationtypo.ffnbpterra,
    mutationtypo.ffnbppisci,
    mutationtypo.ffnbpcav,
    mutationtypo.nblocdisp,
    mutationtypo.nblocapp,
    mutationtypo.ffsbati,
    mutationtypo.ffshab,
    mutationtypo.ffsdep,
    mutationtypo.ffspro,
    mutationtypo.occupation,
    mutationtypo.codtypbien,
    mutationtypo.libtypbien,
    mutationtypo.rapatffloc,
    mutationtypo.rapatffpar,
    mutationtypo.geomlocmut,
    mutationtypo.rolev,
    mutationtypo.rolea,
    mutationtypo.segmusage,
    mutationtypo.e_m2_terr,
    mutationtypo.e_m2_bati,
    mutationtypo.e_m2_bat_h,
    mutationtypo.pres_lot,
    mutationtypo.typologie1,
    mutationtypo.typologie2,
    mutationtypo.typologie3,
    mutationtypo.typologie4,
    mutationtypo.idcom,
    mutationtypo.st_x,
    mutationtypo.st_y,
    mutationtypo.x_mercator,
    mutationtypo.y_mercator,
    mutationtypo.xbati,
    mutationtypo.ybati,
    mutationtypo.xbati_4326,
    mutationtypo.ybati_4326
   FROM dvf.mutationtypo;


 -------------------------------------------------- View: dvf.mutationtypo_geompar

DROP VIEW IF EXISTS dvf.mutationtypo_geompar CASCADE;
CREATE OR REPLACE VIEW dvf.mutationtypo_geompar AS 
 SELECT mutationtypo.idmutation,
    mutationtypo.idmutinvar,
    mutationtypo.idnatmut,
    mutationtypo.codservch,
    mutationtypo.refdoc,
    mutationtypo.datemut,
    mutationtypo.anneemut,
    mutationtypo.moismut,
    mutationtypo.coddep,
    mutationtypo.libnatmut,
    mutationtypo.nbartcgi,
    mutationtypo.l_artcgi::text,
    mutationtypo.vefa,
    mutationtypo.valeurfonc,
    mutationtypo.nbdispo,
    mutationtypo.nblot,
    mutationtypo.nbcomm,
    mutationtypo.l_codinsee::text,
    mutationtypo.nbsection,
    mutationtypo.l_section::text,
    mutationtypo.nbpar,
    mutationtypo.l_idpar::text,
    mutationtypo.nbparmut,
    mutationtypo.l_idparmut::text,
    mutationtypo.nbsuf,
    mutationtypo.sterr,
    mutationtypo.l_dcnt::text,
    mutationtypo.nbvolmut,
    mutationtypo.nblocmut,
    mutationtypo.l_idlocmut::text,
    mutationtypo.nblocmai,
    mutationtypo.nblocapt,
    mutationtypo.nblocdep,
    mutationtypo.nblocact,
    mutationtypo.nbapt1pp,
    mutationtypo.nbapt2pp,
    mutationtypo.nbapt3pp,
    mutationtypo.nbapt4pp,
    mutationtypo.nbapt5pp,
    mutationtypo.nbmai1pp,
    mutationtypo.nbmai2pp,
    mutationtypo.nbmai3pp,
    mutationtypo.nbmai4pp,
    mutationtypo.nbmai5pp,
    mutationtypo.sbati,
    mutationtypo.sbatmai,
    mutationtypo.sbatapt,
    mutationtypo.sbatact,
    mutationtypo.sapt1pp,
    mutationtypo.sapt2pp,
    mutationtypo.sapt3pp,
    mutationtypo.sapt4pp,
    mutationtypo.sapt5pp,
    mutationtypo.smai1pp,
    mutationtypo.smai2pp,
    mutationtypo.smai3pp,
    mutationtypo.smai4pp,
    mutationtypo.smai5pp,
    mutationtypo.l_idv::text,
    mutationtypo.l_nomv::text,
    mutationtypo.codtypprov,
    mutationtypo.fiabmaxv,
    mutationtypo.l_ida::text,
    mutationtypo.l_noma::text,
    mutationtypo.codtypproa,
    mutationtypo.fiabmaxa,
    mutationtypo.ffsparc,
    mutationtypo.ffsterr,
    mutationtypo.l_ffdcnt::text,
    mutationtypo.nbpardisp,
    mutationtypo.nbparapp,
    mutationtypo.ffnblocmai,
    mutationtypo.ffnblocapt,
    mutationtypo.ffnblocdep,
    mutationtypo.ffnblocact,
    mutationtypo.ffnbactsec,
    mutationtypo.ffnbactter,
    mutationtypo.ffnbloch,
    mutationtypo.nblocanc,
    mutationtypo.nblocrecen,
    mutationtypo.nblocneuf,
    mutationtypo.ffancstmin,
    mutationtypo.ffancstmax,
    mutationtypo.ffnbloc1pp,
    mutationtypo.ffnbloc2pp,
    mutationtypo.ffnbloc3pp,
    mutationtypo.ffnbloc4pp,
    mutationtypo.ffnbloc5pp,
    mutationtypo.ffnbpgarag,
    mutationtypo.ffnbpterra,
    mutationtypo.ffnbppisci,
    mutationtypo.ffnbpcav,
    mutationtypo.nblocdisp,
    mutationtypo.nblocapp,
    mutationtypo.ffsbati,
    mutationtypo.ffshab,
    mutationtypo.ffsdep,
    mutationtypo.ffspro,
    mutationtypo.occupation,
    mutationtypo.codtypbien,
    mutationtypo.libtypbien,
    mutationtypo.rapatffloc,
    mutationtypo.rapatffpar,
    mutationtypo.geompar,
    mutationtypo.rolev,
    mutationtypo.rolea,
    mutationtypo.segmusage,
    mutationtypo.e_m2_terr,
    mutationtypo.e_m2_bati,
    mutationtypo.e_m2_bat_h,
    mutationtypo.pres_lot,
    mutationtypo.typologie1,
    mutationtypo.typologie2,
    mutationtypo.typologie3,
    mutationtypo.typologie4,
    mutationtypo.idcom,
    mutationtypo.st_x,
    mutationtypo.st_y,
    mutationtypo.x_mercator,
    mutationtypo.y_mercator,
    mutationtypo.xbati,
    mutationtypo.ybati,
    mutationtypo.xbati_4326,
    mutationtypo.ybati_4326
   FROM dvf.mutationtypo;


------------------------------------------ View: dvf.mutationtypo_geomparmut

DROP VIEW IF EXISTS dvf.mutationtypo_geomparmut CASCADE;
CREATE OR REPLACE VIEW dvf.mutationtypo_geomparmut AS 
 SELECT mutationtypo.idmutation,
    mutationtypo.idmutinvar,
    mutationtypo.idnatmut,
    mutationtypo.codservch,
    mutationtypo.refdoc,
    mutationtypo.datemut,
    mutationtypo.anneemut,
    mutationtypo.moismut,
    mutationtypo.coddep,
    mutationtypo.libnatmut,
    mutationtypo.nbartcgi,
    mutationtypo.l_artcgi::text,
    mutationtypo.vefa,
    mutationtypo.valeurfonc,
    mutationtypo.nbdispo,
    mutationtypo.nblot,
    mutationtypo.nbcomm,
    mutationtypo.l_codinsee::text,
    mutationtypo.nbsection,
    mutationtypo.l_section::text,
    mutationtypo.nbpar,
    mutationtypo.l_idpar::text,
    mutationtypo.nbparmut,
    mutationtypo.l_idparmut::text,
    mutationtypo.nbsuf,
    mutationtypo.sterr,
    mutationtypo.l_dcnt::text,
    mutationtypo.nbvolmut,
    mutationtypo.nblocmut,
    mutationtypo.l_idlocmut::text,
    mutationtypo.nblocmai,
    mutationtypo.nblocapt,
    mutationtypo.nblocdep,
    mutationtypo.nblocact,
    mutationtypo.nbapt1pp,
    mutationtypo.nbapt2pp,
    mutationtypo.nbapt3pp,
    mutationtypo.nbapt4pp,
    mutationtypo.nbapt5pp,
    mutationtypo.nbmai1pp,
    mutationtypo.nbmai2pp,
    mutationtypo.nbmai3pp,
    mutationtypo.nbmai4pp,
    mutationtypo.nbmai5pp,
    mutationtypo.sbati,
    mutationtypo.sbatmai,
    mutationtypo.sbatapt,
    mutationtypo.sbatact,
    mutationtypo.sapt1pp,
    mutationtypo.sapt2pp,
    mutationtypo.sapt3pp,
    mutationtypo.sapt4pp,
    mutationtypo.sapt5pp,
    mutationtypo.smai1pp,
    mutationtypo.smai2pp,
    mutationtypo.smai3pp,
    mutationtypo.smai4pp,
    mutationtypo.smai5pp,
    mutationtypo.l_idv::text,
    mutationtypo.l_nomv::text,
    mutationtypo.codtypprov,
    mutationtypo.fiabmaxv,
    mutationtypo.l_ida::text,
    mutationtypo.l_noma::text,
    mutationtypo.codtypproa,
    mutationtypo.fiabmaxa,
    mutationtypo.ffsparc,
    mutationtypo.ffsterr,
    mutationtypo.l_ffdcnt::text,
    mutationtypo.nbpardisp,
    mutationtypo.nbparapp,
    mutationtypo.ffnblocmai,
    mutationtypo.ffnblocapt,
    mutationtypo.ffnblocdep,
    mutationtypo.ffnblocact,
    mutationtypo.ffnbactsec,
    mutationtypo.ffnbactter,
    mutationtypo.ffnbloch,
    mutationtypo.nblocanc,
    mutationtypo.nblocrecen,
    mutationtypo.nblocneuf,
    mutationtypo.ffancstmin,
    mutationtypo.ffancstmax,
    mutationtypo.ffnbloc1pp,
    mutationtypo.ffnbloc2pp,
    mutationtypo.ffnbloc3pp,
    mutationtypo.ffnbloc4pp,
    mutationtypo.ffnbloc5pp,
    mutationtypo.ffnbpgarag,
    mutationtypo.ffnbpterra,
    mutationtypo.ffnbppisci,
    mutationtypo.ffnbpcav,
    mutationtypo.nblocdisp,
    mutationtypo.nblocapp,
    mutationtypo.ffsbati,
    mutationtypo.ffshab,
    mutationtypo.ffsdep,
    mutationtypo.ffspro,
    mutationtypo.occupation,
    mutationtypo.codtypbien,
    mutationtypo.libtypbien,
    mutationtypo.rapatffloc,
    mutationtypo.rapatffpar,
    mutationtypo.geomparmut,
    mutationtypo.rolev,
    mutationtypo.rolea,
    mutationtypo.segmusage,
    mutationtypo.e_m2_terr,
    mutationtypo.e_m2_bati,
    mutationtypo.e_m2_bat_h,
    mutationtypo.pres_lot,
    mutationtypo.typologie1,
    mutationtypo.typologie2,
    mutationtypo.typologie3,
    mutationtypo.typologie4,
    mutationtypo.idcom,
    mutationtypo.st_x,
    mutationtypo.st_y,
    mutationtypo.x_mercator,
    mutationtypo.y_mercator,
    mutationtypo.xbati,
    mutationtypo.ybati,
    mutationtypo.xbati_4326,
    mutationtypo.ybati_4326
   FROM dvf.mutationtypo;
 

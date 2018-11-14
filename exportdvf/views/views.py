'''

Copyright ou © ou Copr. Cerema, (juin 2017) 

dv3f@cerema.fr

Ce logiciel est un programme informatique servant à l'utilisation de la donnée DVF

Ce logiciel est régi par la licence CeCILL soumise au droit français et
respectant les principes de diffusion des logiciels libres. Vous pouvez
utiliser, modifier et/ou redistribuer ce programme sous les conditions
de la licence CeCILL telle que diffusée par le CEA, le CNRS et l'INRIA 
sur le site "http://www.cecill.info".

En contrepartie de l'accessibilité au code source et des droits de copie,
de modification et de redistribution accordés par cette licence, il n'est
offert aux utilisateurs qu'une garantie limitée.  Pour les mêmes raisons,
seule une responsabilité restreinte pèse sur l'auteur du programme,  le
titulaire des droits patrimoniaux et les concédants successifs.

A cet égard  l'attention de l'utilisateur est attirée sur les risques
associés au chargement,  à l'utilisation,  à la modification et/ou au
développement et à la reproduction du logiciel par l'utilisateur étant 
donné sa spécificité de logiciel libre, qui peut le rendre complexe à 
manipuler et qui le réserve donc à des développeurs et des professionnels
avertis possédant  des  connaissances  informatiques approfondies.  Les
utilisateurs sont donc invités à charger  et  tester  l'adéquation  du
logiciel à leurs besoins dans des conditions permettant d'assurer la
sécurité de leurs systèmes et ou de leurs données et, plus généralement, 
à l'utiliser et l'exploiter dans les mêmes conditions de sécurité. 

Le fait que vous puissiez accéder à cet en-tête signifie que vous avez 
pris connaissance de la licence CeCILL, et que vous en avez accepté les
termes.

'''

import os
from django.http import HttpResponse
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.decorators import login_required

from .contexte import ContexteExport
from .export.export_qgis import ExportQGis
from .export.export_qgis import RequeteurExportQGis

@login_required
def choix(request):
    contexte_export = ContexteExport(request)
    if not contexte_export.success:
        return redirect('main:configuration_bdd')
    if not contexte_export.config_active.a_les_vues_qgis():
        msg_erreur = """La base de données ne possède pas les vues nécessaires à la génération du projet Qgis.
                        <br>Pour les créer, vous devez demander à l'administrateur de la base de données d'exécuter les requêtes suivantes :
                        <br>
                        <br>DROP VIEW IF EXISTS dvf.localtypo CASCADE;
                        <br>CREATE OR REPLACE VIEW dvf.mutationtypo as
                        <br>SELECT a.*, 
                        <br>niv1, libniv1, niv2, libniv2, niv3, libniv3, niv4, libniv4, niv5, libniv5,
                         <br>CASE
                         <br>           WHEN a.sterr > 0::numeric THEN round(a.valeurfonc / a.sterr, 2)
                         <br>           ELSE NULL::numeric
                         <br>       END as e_m2_terr,
                         <br>CASE
                         <br>           WHEN a.sbati > 0::numeric THEN round(a.valeurfonc / a.sbati, 2)
                         <br>           ELSE NULL::numeric
                         <br>       END as e_m2_bati,
                         <br>CASE
                         <br>           WHEN (COALESCE(a.sbatmai, 0::numeric) + COALESCE(a.sbatapt, 0::numeric)) > 0::numeric THEN round(a.valeurfonc / (COALESCE(a.sbatmai, 0::numeric) + COALESCE(a.sbatapt, 0::numeric)), 2)
                         <br>           ELSE NULL::numeric
                         <br>       END as e_m2_bat_h,
                        <br>a.l_codinsee[1] as idcom
                        <br>FROM dvf.mutation a, dvf_annexe.ann_typologie b 
                        <br>WHERE a.codtypbien=b.codtypbien;
                        <br>
                        <br>DROP VIEW IF EXISTS dvf.localtypo CASCADE;
                        <br>CREATE OR REPLACE VIEW dvf.localtypo AS 
                        <br>SELECT local.iddispoloc, local.iddispopar, local.idpar, local.idmutation, local.idloc,
                        <br>local.identloc, local.codtyploc, local.libtyploc, local.nbpprinc, local.sbati,
                        <br>local.coddep, local.datemut, local.anneemut, local.moismut, local.nbmutjour,
                        <br>local.nbmutannee, local.datemutpre, local.l_idmutpre::text, local.datemutsui,
                        <br>local.l_idmutsui::text, local.ffidcpv, local.fiabilitev, local.l_idv::text,
                        <br>local.nbdroiprov, local.l_nomv::text, local.nbdroigesv, local.l_nomgesv::text,
                        <br>local.codtypprov, local.ffidcpa, local.fiabilitea, local.l_ida::text,
                        <br>local.nbdroiproa, local.l_noma::text, local.nbdroigesa, local.l_nomgesa::text,
                        <br>local.codtypproa, local.ffdatemut, local.exactffdvf, local.ffancst,
                        <br>    CASE
                        <br>        WHEN local.ffancst <> 0 AND local.ffancst <> '-1'::integer AND (date_part('year'::text, local.datemut) - local.ffancst::double precision) <= 1::double precision THEN 'neuf'::text
                        <br>        WHEN local.ffancst <> 0 AND local.ffancst <> '-1'::integer AND (date_part('year'::text, local.datemut) - local.ffancst::double precision) < 5::double precision THEN 'recent'::text
                        <br>        WHEN local.ffancst <> 0 AND local.ffancst <> '-1'::integer AND (date_part('year'::text, local.datemut) - local.ffancst::double precision) >= 5::double precision THEN 'ancien'::text
                        <br>        WHEN mutation.vefa THEN 'neuf'::text
                        <br>        WHEN (date_part('year'::text, local.datemutpre) - local.anneemut::double precision) >= 5::double precision THEN 'ancien'::text
                        <br>        ELSE 'non defini'::text
                        <br>    END AS anciennete,
                        <br>local.ffidbat, local.ffcodinsee, local.ffcommune, local.ffnovoie,
                        <br>local.ffbtq, local.ffvoie, local.fftyppdl, local.ffclascad,
                        <br>local.ffvalloc, local.ffcodeval, local.fflibeval,
                        <br>local.ffcchgeval, local.ffdchgeval, local.stabilitel,
                        <br>local.ffctyploc, local.ffltyploc, local.ffcnatloc,
                        <br>local.fflnatloc, local.ffcodnacea, local.fflibnacea,
                        <br>local.fflochab, local.ffoccv, local.ffocca,
                        <br>local.ffshab, local.ffsdep, local.ffspro,
                        <br>local.ffsbati, local.ffnbpsam, local.ffnbpcha,
                        <br>local.ffnbpcu8, local.ffnbpcu9, local.ffnbpsea,
                        <br>local.ffnbpann, local.ffnbpprinc, local.ffnbpgarag,
                        <br>local.ffnbpagrem, local.ffnbpterra, local.ffnbppisci,
                        <br>local.ffnbpaut, local.ffanref, local.ffanvend, local.ffanach,
                        <br>st_multi(local.geomloc)::geometry(MultiPoint,2154) AS geomloc,
                        <br>local.srcgeom, local.parcvect, mutation.sterr,
                        <br>mutation.segmtab, mutation.codtypbien, mutation.libtypbien,
                        <br>mutation.nblocmut, mutation.libnatmut, mutation.nbdispo,
                        <br>mutation.nbcomm, mutation.l_codinsee, mutation.nblocmai,
                        <br>mutation.nblocapt, mutation.nblocdep, mutation.nblocact,
                        <br>mutation.sbatact, mutation.l_idlocmut::text, mutation.nbsuf,
                        <br>mutation.nbparmut, mutation.l_idparmut::text, mutation.l_idpar::text,
                        <br>mutation.refdoc, mutation.codservch, mutation.l_artcgi::text,
                        <br>mutation.nbartcgi, mutation.valeurfonc,
                        <br>CASE
                        <br>            WHEN mutation.sterr > 0::numeric THEN round(mutation.valeurfonc / mutation.sterr, 2)
                        <br>            ELSE NULL::numeric
                        <br>        END as e_m2_terr,
                        <br>CASE
                        <br>            WHEN mutation.sbati > 0::numeric THEN round(mutation.valeurfonc / mutation.sbati, 2)
                        <br>            ELSE NULL::numeric
                        <br>        END as e_m2_bati,
                        <br>CASE
                        <br>            WHEN (COALESCE(mutation.sbatmai, 0::numeric) + COALESCE(mutation.sbatapt, 0::numeric)) > 0::numeric THEN round(mutation.valeurfonc / (COALESCE(mutation.sbatmai, 0::numeric) + COALESCE(mutation.sbatapt, 0::numeric)), 2)
                        <br>            ELSE NULL::numeric
                        <br>        END as e_m2_bat_h,
                        <br>mutation.l_dcnt::text,
                        <br>(mutation.nblocmut - mutation.nblocdep) = 1 AS localseul,
                        <br>    CASE
                        <br>        WHEN local.ffancst < 1915 THEN ']avant 1914]'::text
                        <br>        WHEN local.ffancst < 1954 THEN ']1914,1953]'::text
                        <br>        WHEN local.ffancst < 1975 THEN ']1953,1974]'::text
                        <br>        WHEN local.ffancst < 1991 THEN ']1974,1990]'::text
                        <br>        WHEN local.ffancst < 2001 THEN ']1990,2000]'::text
                        <br>        WHEN mutation.vefa IS NOT NULL THEN '[après 2000['::text
                        <br>        WHEN local.ffancst IS NULL THEN NULL::text
                        <br>        ELSE NULL::text
                        <br>    END::character varying(14) AS periode_const,
                        <br>typo.niv2,
                        <br>typo.libniv2,
                        <br>typo.niv3,
                        <br>typo.libniv3,
                        <br>typo.niv4,
                        <br>typo.libniv4,
                        <br>typo.niv5,
                        <br>typo.libniv5,
                        <br>mutation.filtre,
                        <br>mutation.devenir,
                        <br>"substring"(local.idpar::text, 1, 5) AS idcom    
                        <br>FROM dvf.mutation,
                        <br>dvf.local, dvf_annexe.ann_typologie as typo
                        <br>WHERE local.idmutation = mutation.idmutation and local.coddep=mutation.coddep
                        <br>AND mutation.codtypbien=typo.codtypbien;
            """
        messages.add_message(request, messages.ERROR, msg_erreur)    
    request.session = contexte_export.request.session    
    return render(request, 'choix_export.html', None) 

@login_required
def projet_qgis(request):
    if request.session['type_bdd'] != 'DV3F':
        return redirect('main:configuration_bdd')
    requeteur_export = RequeteurExportQGis(request.session['params'])
    '''
    success, _ = requeteur_export.generer_vues_qgis()
    if not success:
        return redirect('main:configuration_bdd')
    '''
    box = requeteur_export.emprise()
    export_qgis = ExportQGis(request.session, box)     
    response = HttpResponse(export_qgis.flux_archive(), content_type='application/zip')
    response['Content-Disposition'] = 'attachment; filename={0}'.format(export_qgis.nom_prj('zip'))
    export_qgis.nettoyer()
    return response

## LISTER_CODES_INSEE_COMMUNE
SELECT DISTINCT coddep || codcomm as codinsee FROM dvf_d{0}.disposition_parcelle WHERE coddep = '{0}' ORDER BY codinsee;
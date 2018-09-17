## LISTER_CODES_INSEE_COMMUNE
SELECT DISTINCT coddep || codcomm as codinsee FROM dvf_d{0}.disposition_parcelle WHERE coddep = '{0}' ORDER BY codinsee;

## TESTER_FONCTIONS_AGGREGATS
SELECT dvf.mediane(n), dvf.premier_quartile(n), dvf.dernier_quartile(n) FROM generate_series(1, 10) n; 
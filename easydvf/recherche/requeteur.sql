## RECUPERER_MUTATIONS_DV3F
SELECT idmutation, idmutinvar, datemut, valeurfonc, sbati, sterr, codtypbien, libtypbien
FROM dvf.mutation
WHERE l_codinsee && ARRAY['{0}']::VARCHAR[];

## RECUPERER_MUTATIONS_DVF_PLUS
SELECT idmutation, idmutinvar, datemut, valeurfonc, sbati, sterr, 
CASE WHEN nblocmut > 0 THEN '12' ELSE '25' END AS codtypbien, 
CASE WHEN nblocmut > 0 THEN 'BATI' ELSE 'NON BATI' END ASlibtypbien
FROM dvf.mutation
WHERE l_codinsee && ARRAY['{0}']::VARCHAR[];
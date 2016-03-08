## RECUPERER_MUTATIONS
SELECT idmutation, idmutinvar, datemut, valeurfonc, sbati, sterr, codtypbien, libtypbien
FROM dvf.mutation
WHERE l_codinsee && ARRAY['{0}']::VARCHAR[];
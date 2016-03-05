## RECUPERER_MUTATIONS
SELECT idmutation, idmutinvar, datemut, valeurfonc, sbati, sterr
FROM dvf.mutation
WHERE l_codinsee && ARRAY['59001', '59002']::VARCHAR[];
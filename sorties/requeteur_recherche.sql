SELECT idmutation, datemut, valeurfonc, sbati, sterr, nblocmut, nbparmut, codtypbien, libtypbien
FROM dvf.mutation
WHERE l_codinsee && ARRAY['59001']::VARCHAR[];

SELECT idmutation, datemut, valeurfonc, sbati, sterr, nblocmut, nbparmut, codtypbien, libtypbien
FROM dvf.mutation
WHERE l_codinsee && ARRAY['59350']::VARCHAR[];

SELECT codservch, refdoc, nblocmut, nbparmut, libtypbien FROM dvf.mutation WHERE idmutation = 23;

SELECT idmutation, datemut, valeurfonc, sbati, sterr, nblocmut, nbparmut, codtypbien, libtypbien
FROM dvf.mutation
WHERE l_codinsee && ARRAY['59001']::VARCHAR[];

SELECT idmutation, datemut, valeurfonc, sbati, sterr, nblocmut, nbparmut, codtypbien, libtypbien
FROM dvf.mutation
WHERE l_codinsee && ARRAY['59001']::VARCHAR[];

SELECT codservch, refdoc, nblocmut, nbparmut, libtypbien FROM dvf.mutation WHERE idmutation = 438464;


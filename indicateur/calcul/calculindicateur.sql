## CALCULER_SOMME_PAR_ANNEE
SELECT anneemut, sum({0}) 
FROM dvf.mutation 
WHERE l_codinsee && ARRAY[{1}]::VARCHAR[]
GROUP BY anneemut;

## CALCULER_SOMME_MULTI_ANNEE
SELECT COALESCE(SUM({0}), 0)
FROM dvf.mutation
WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] AND anneemut >= {2} AND anneemut <= {3}

## COMPTER_PAR_ANNEE
SELECT anneemut, count({0})
FROM dvf.mutation
WHERE l_codinsee && ARRAY[{1}]::VARCHAR[]
GROUP BY anneemut;

## COMPTER_MULTI_ANNEE
SELECT COUNT({0})
FROM dvf.mutation
WHERE l_codinsee && ARRAY[{1}]::VARCHAR[] AND anneemut >= {2} AND anneemut <= {3}



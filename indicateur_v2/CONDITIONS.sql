## FILTRE URBA4 PRIX
WHERE devenir = 'S'
AND filtre IN ('0', '1')
AND nbcomm = 1
AND (
    (-- Maisons
        codtypbien LIKE '11%'
        AND codtypbien NOT IN ('110', '1110', '1114')
    )

    OR  (-- Apparts
        ((codtypbien LIKE '122%' AND nbsite = 1)  --MAJ suite visio Urba4 : à remplacer par un filtre de distance
        OR (codtypbien LIKE '122%' AND nbsite > 1 AND nblocdep > 0)  --MAJ suite visio Urba4 : à remplacer par un filtre de distance
        OR codtypbien = '1210'      
        OR codtypbien LIKE '1211%'
        OR codtypbien LIKE '1212%'
        OR codtypbien LIKE '1213%')
        AND codtypbien NOT IN ('1224', '1229')
    )
)


## FILTRE URBA4 VOLUMES
WHERE devenir = 'S'
AND filtre IN ('0', '1')
AND (
    (-- Maisons
        codtypbien LIKE '11%'
        AND codtypbien NOT IN ('110', '1114')
    )

    OR  (-- Apparts
        codtypbien LIKE '12%'
        AND codtypbien NOT IN ('120', '1214', '1224', '1229')
    )
)
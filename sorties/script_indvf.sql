CREATE OR REPLACE FUNCTION centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$
  /*
   Retourne le n-ième centile des valeurs du tableau (trié ou non)

   exemples : 
    SELECT centile(ARRAY[10,20,30,40,50], 50)
    >> 30

    SELECT centile(ARRAY[21,20,100,70,49,13,52,60], 10)
    >> 13
  */
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;

CREATE OR REPLACE FUNCTION mediane_centree_10(anyarray NUMERIC[])
  RETURNS NUMERIC AS
$BODY$
/*
   Retourne la médiane des valeurs du tableau (trié ou non) contenues dans l'intervalle
   Ici le centile exterieur est defini à 10 ce qui exclut les 10 % de valeurs les plus hautes et les 10 % de valeurs plus basses.

   exemples :   

    SELECT mediane_centree_10(ARRAY[10,50,3,47,29,49,12,78,85.5,0,1),0,1,1,0], 10);
    >> 10
  */
    DECLARE 
        array_sans_deciles NUMERIC[];
        borne_inf numeric;
        borne_sup numeric;
    BEGIN
        borne_inf := centile(anyarray, 10);
        borne_sup := centile(anyarray, 99 - 10);
        FOR i IN 1..array_upper(anyarray,1)
        LOOP
            IF anyarray[i] >= borne_inf AND anyarray[i] <= borne_sup THEN array_sans_deciles :=  array_sans_deciles || anyarray[i]; END IF;        
        END LOOP;
        RETURN centile(array_sans_deciles, 50);
    END;
$BODY$
  LANGUAGE plpgsql;

DROP AGGREGATE IF EXISTS mediane_10(NUMERIC);
CREATE aggregate mediane_10(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = mediane_centree_10
);

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59001']::VARCHAR[] 
	) t

GROUP BY anneemut;

SELECT anneemut, sum(valeurfonc)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59001']::VARCHAR[]
	) t

GROUP BY anneemut;

SELECT COALESCE(SUM(valeurfonc), 0)
FROM (
	SELECT * 
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY['59001']::VARCHAR[] AND anneemut >= 2010 AND anneemut <= 2013
	) t
;

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59001']::VARCHAR[] 
	) t
 WHERE codtypbien='25' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(sterr) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59001']::VARCHAR[]
	) t
 WHERE codtypbien='25' 
GROUP BY anneemut;

SELECT anneemut, sum(valeurfonc)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59001']::VARCHAR[]
	) t
 WHERE codtypbien='145' 
GROUP BY anneemut;

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59001']::VARCHAR[] 
	) t
 WHERE codtypbien='132' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(valeurfonc) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59001']::VARCHAR[]
	) t
 WHERE codtypbien='132' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(valeurfonc/sbati) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59001']::VARCHAR[]
	) t
 WHERE codtypbien='122' 
GROUP BY anneemut;

CREATE OR REPLACE FUNCTION centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$
  /*
   Retourne le n-ième centile des valeurs du tableau (trié ou non)

   exemples : 
    SELECT centile(ARRAY[10,20,30,40,50], 50)
    >> 30

    SELECT centile(ARRAY[21,20,100,70,49,13,52,60], 10)
    >> 13
  */
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;

CREATE OR REPLACE FUNCTION mediane_centree_10(anyarray NUMERIC[])
  RETURNS NUMERIC AS
$BODY$
/*
   Retourne la médiane des valeurs du tableau (trié ou non) contenues dans l'intervalle
   Ici le centile exterieur est defini à 10 ce qui exclut les 10 % de valeurs les plus hautes et les 10 % de valeurs plus basses.

   exemples :   

    SELECT mediane_centree_10(ARRAY[10,50,3,47,29,49,12,78,85.5,0,1),0,1,1,0], 10);
    >> 10
  */
    DECLARE 
        array_sans_deciles NUMERIC[];
        borne_inf numeric;
        borne_sup numeric;
    BEGIN
        borne_inf := centile(anyarray, 10);
        borne_sup := centile(anyarray, 99 - 10);
        FOR i IN 1..array_upper(anyarray,1)
        LOOP
            IF anyarray[i] >= borne_inf AND anyarray[i] <= borne_sup THEN array_sans_deciles :=  array_sans_deciles || anyarray[i]; END IF;        
        END LOOP;
        RETURN centile(array_sans_deciles, 50);
    END;
$BODY$
  LANGUAGE plpgsql;

DROP AGGREGATE IF EXISTS mediane_10(NUMERIC);
CREATE aggregate mediane_10(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = mediane_centree_10
);

CREATE OR REPLACE FUNCTION centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$
  /*
   Retourne le n-ième centile des valeurs du tableau (trié ou non)

   exemples : 
    SELECT centile(ARRAY[10,20,30,40,50], 50)
    >> 30

    SELECT centile(ARRAY[21,20,100,70,49,13,52,60], 10)
    >> 13
  */
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;

CREATE OR REPLACE FUNCTION mediane_centree_10(anyarray NUMERIC[])
  RETURNS NUMERIC AS
$BODY$
/*
   Retourne la médiane des valeurs du tableau (trié ou non) contenues dans l'intervalle
   Ici le centile exterieur est defini à 10 ce qui exclut les 10 % de valeurs les plus hautes et les 10 % de valeurs plus basses.

   exemples :   

    SELECT mediane_centree_10(ARRAY[10,50,3,47,29,49,12,78,85.5,0,1),0,1,1,0], 10);
    >> 10
  */
    DECLARE 
        array_sans_deciles NUMERIC[];
        borne_inf numeric;
        borne_sup numeric;
    BEGIN
        borne_inf := centile(anyarray, 10);
        borne_sup := centile(anyarray, 99 - 10);
        FOR i IN 1..array_upper(anyarray,1)
        LOOP
            IF anyarray[i] >= borne_inf AND anyarray[i] <= borne_sup THEN array_sans_deciles :=  array_sans_deciles || anyarray[i]; END IF;        
        END LOOP;
        RETURN centile(array_sans_deciles, 50);
    END;
$BODY$
  LANGUAGE plpgsql;

DROP AGGREGATE IF EXISTS mediane_10(NUMERIC);
CREATE aggregate mediane_10(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = mediane_centree_10
);

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59006']::VARCHAR[] 
	) t

GROUP BY anneemut;

SELECT anneemut, sum(valeurfonc)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59006']::VARCHAR[]
	) t

GROUP BY anneemut;

SELECT COALESCE(SUM(valeurfonc), 0)
FROM (
	SELECT * 
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY['59006']::VARCHAR[] AND anneemut >= 2010 AND anneemut <= 2013
	) t
;

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59006']::VARCHAR[] 
	) t
 WHERE codtypbien='25' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(sterr) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59006']::VARCHAR[]
	) t
 WHERE codtypbien='25' 
GROUP BY anneemut;

SELECT anneemut, sum(valeurfonc)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59006']::VARCHAR[]
	) t
 WHERE codtypbien='145' 
GROUP BY anneemut;

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59006']::VARCHAR[] 
	) t
 WHERE codtypbien='132' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(valeurfonc) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59006']::VARCHAR[]
	) t
 WHERE codtypbien='132' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(valeurfonc/sbati) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59006']::VARCHAR[]
	) t
 WHERE codtypbien='122' 
GROUP BY anneemut;

CREATE OR REPLACE FUNCTION centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$
  /*
   Retourne le n-ième centile des valeurs du tableau (trié ou non)

   exemples : 
    SELECT centile(ARRAY[10,20,30,40,50], 50)
    >> 30

    SELECT centile(ARRAY[21,20,100,70,49,13,52,60], 10)
    >> 13
  */
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;

CREATE OR REPLACE FUNCTION mediane_centree_10(anyarray NUMERIC[])
  RETURNS NUMERIC AS
$BODY$
/*
   Retourne la médiane des valeurs du tableau (trié ou non) contenues dans l'intervalle
   Ici le centile exterieur est defini à 10 ce qui exclut les 10 % de valeurs les plus hautes et les 10 % de valeurs plus basses.

   exemples :   

    SELECT mediane_centree_10(ARRAY[10,50,3,47,29,49,12,78,85.5,0,1),0,1,1,0], 10);
    >> 10
  */
    DECLARE 
        array_sans_deciles NUMERIC[];
        borne_inf numeric;
        borne_sup numeric;
    BEGIN
        borne_inf := centile(anyarray, 10);
        borne_sup := centile(anyarray, 99 - 10);
        FOR i IN 1..array_upper(anyarray,1)
        LOOP
            IF anyarray[i] >= borne_inf AND anyarray[i] <= borne_sup THEN array_sans_deciles :=  array_sans_deciles || anyarray[i]; END IF;        
        END LOOP;
        RETURN centile(array_sans_deciles, 50);
    END;
$BODY$
  LANGUAGE plpgsql;

DROP AGGREGATE IF EXISTS mediane_10(NUMERIC);
CREATE aggregate mediane_10(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = mediane_centree_10
);

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59090']::VARCHAR[] 
	) t

GROUP BY anneemut;

SELECT anneemut, sum(valeurfonc)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59090']::VARCHAR[]
	) t

GROUP BY anneemut;

SELECT COALESCE(SUM(valeurfonc), 0)
FROM (
	SELECT * 
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY['59090']::VARCHAR[] AND anneemut >= 2010 AND anneemut <= 2013
	) t
;

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59090']::VARCHAR[] 
	) t
 WHERE codtypbien='25' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(sterr) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59090']::VARCHAR[]
	) t
 WHERE codtypbien='25' 
GROUP BY anneemut;

SELECT anneemut, sum(valeurfonc)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59090']::VARCHAR[]
	) t
 WHERE codtypbien='145' 
GROUP BY anneemut;

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59090']::VARCHAR[] 
	) t
 WHERE codtypbien='132' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(valeurfonc) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59090']::VARCHAR[]
	) t
 WHERE codtypbien='132' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(valeurfonc/sbati) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59090']::VARCHAR[]
	) t
 WHERE codtypbien='122' 
GROUP BY anneemut;

CREATE OR REPLACE FUNCTION centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$
  /*
   Retourne le n-ième centile des valeurs du tableau (trié ou non)

   exemples : 
    SELECT centile(ARRAY[10,20,30,40,50], 50)
    >> 30

    SELECT centile(ARRAY[21,20,100,70,49,13,52,60], 10)
    >> 13
  */
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;

CREATE OR REPLACE FUNCTION mediane_centree_10(anyarray NUMERIC[])
  RETURNS NUMERIC AS
$BODY$
/*
   Retourne la médiane des valeurs du tableau (trié ou non) contenues dans l'intervalle
   Ici le centile exterieur est defini à 10 ce qui exclut les 10 % de valeurs les plus hautes et les 10 % de valeurs plus basses.

   exemples :   

    SELECT mediane_centree_10(ARRAY[10,50,3,47,29,49,12,78,85.5,0,1),0,1,1,0], 10);
    >> 10
  */
    DECLARE 
        array_sans_deciles NUMERIC[];
        borne_inf numeric;
        borne_sup numeric;
    BEGIN
        borne_inf := centile(anyarray, 10);
        borne_sup := centile(anyarray, 99 - 10);
        FOR i IN 1..array_upper(anyarray,1)
        LOOP
            IF anyarray[i] >= borne_inf AND anyarray[i] <= borne_sup THEN array_sans_deciles :=  array_sans_deciles || anyarray[i]; END IF;        
        END LOOP;
        RETURN centile(array_sans_deciles, 50);
    END;
$BODY$
  LANGUAGE plpgsql;

DROP AGGREGATE IF EXISTS mediane_10(NUMERIC);
CREATE aggregate mediane_10(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = mediane_centree_10
);

CREATE OR REPLACE FUNCTION centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$
  /*
   Retourne le n-ième centile des valeurs du tableau (trié ou non)

   exemples : 
    SELECT centile(ARRAY[10,20,30,40,50], 50)
    >> 30

    SELECT centile(ARRAY[21,20,100,70,49,13,52,60], 10)
    >> 13
  */
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;

CREATE OR REPLACE FUNCTION mediane_centree_10(anyarray NUMERIC[])
  RETURNS NUMERIC AS
$BODY$
/*
   Retourne la médiane des valeurs du tableau (trié ou non) contenues dans l'intervalle
   Ici le centile exterieur est defini à 10 ce qui exclut les 10 % de valeurs les plus hautes et les 10 % de valeurs plus basses.

   exemples :   

    SELECT mediane_centree_10(ARRAY[10,50,3,47,29,49,12,78,85.5,0,1),0,1,1,0], 10);
    >> 10
  */
    DECLARE 
        array_sans_deciles NUMERIC[];
        borne_inf numeric;
        borne_sup numeric;
    BEGIN
        borne_inf := centile(anyarray, 10);
        borne_sup := centile(anyarray, 99 - 10);
        FOR i IN 1..array_upper(anyarray,1)
        LOOP
            IF anyarray[i] >= borne_inf AND anyarray[i] <= borne_sup THEN array_sans_deciles :=  array_sans_deciles || anyarray[i]; END IF;        
        END LOOP;
        RETURN centile(array_sans_deciles, 50);
    END;
$BODY$
  LANGUAGE plpgsql;

DROP AGGREGATE IF EXISTS mediane_10(NUMERIC);
CREATE aggregate mediane_10(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = mediane_centree_10
);

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59421']::VARCHAR[] 
	) t

GROUP BY anneemut;

SELECT anneemut, sum(valeurfonc)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59421']::VARCHAR[]
	) t

GROUP BY anneemut;

SELECT COALESCE(SUM(valeurfonc), 0)
FROM (
	SELECT * 
	FROM dvf.mutation
	WHERE l_codinsee && ARRAY['59421']::VARCHAR[] AND anneemut >= 2010 AND anneemut <= 2013
	) t
;

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59421']::VARCHAR[] 
	) t
 WHERE codtypbien='25' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(sterr) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59421']::VARCHAR[]
	) t
 WHERE codtypbien='25' 
GROUP BY anneemut;

SELECT anneemut, sum(valeurfonc)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59421']::VARCHAR[]
	) t
 WHERE codtypbien='145' 
GROUP BY anneemut;

SELECT anneemut, count(idmutation)
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59421']::VARCHAR[] 
	) t
 WHERE codtypbien='132' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(valeurfonc) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59421']::VARCHAR[]
	) t
 WHERE codtypbien='132' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(valeurfonc/sbati) 
FROM (
	SELECT *  
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59421']::VARCHAR[]
	) t
 WHERE codtypbien='122' 
GROUP BY anneemut;

CREATE OR REPLACE FUNCTION centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$
  /*
   Retourne le n-ième centile des valeurs du tableau (trié ou non)

   exemples : 
    SELECT centile(ARRAY[10,20,30,40,50], 50)
    >> 30

    SELECT centile(ARRAY[21,20,100,70,49,13,52,60], 10)
    >> 13
  */
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;

CREATE OR REPLACE FUNCTION mediane_centree_10(anyarray NUMERIC[])
  RETURNS NUMERIC AS
$BODY$
/*
   Retourne la médiane des valeurs du tableau (trié ou non) contenues dans l'intervalle
   Ici le centile exterieur est defini à 10 ce qui exclut les 10 % de valeurs les plus hautes et les 10 % de valeurs plus basses.

   exemples :   

    SELECT mediane_centree_10(ARRAY[10,50,3,47,29,49,12,78,85.5,0,1),0,1,1,0], 10);
    >> 10
  */
    DECLARE 
        array_sans_deciles NUMERIC[];
        borne_inf numeric;
        borne_sup numeric;
    BEGIN
        borne_inf := centile(anyarray, 10);
        borne_sup := centile(anyarray, 99 - 10);
        FOR i IN 1..array_upper(anyarray,1)
        LOOP
            IF anyarray[i] >= borne_inf AND anyarray[i] <= borne_sup THEN array_sans_deciles :=  array_sans_deciles || anyarray[i]; END IF;        
        END LOOP;
        RETURN centile(array_sans_deciles, 50);
    END;
$BODY$
  LANGUAGE plpgsql;

DROP AGGREGATE IF EXISTS mediane_10(NUMERIC);
CREATE aggregate mediane_10(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = mediane_centree_10
);

CREATE OR REPLACE FUNCTION centile(anyarray, integer)
  RETURNS anyelement AS
$BODY$
  /*
   Retourne le n-ième centile des valeurs du tableau (trié ou non)

   exemples : 
    SELECT centile(ARRAY[10,20,30,40,50], 50)
    >> 30

    SELECT centile(ARRAY[21,20,100,70,49,13,52,60], 10)
    >> 13
  */
  SELECT t[$2/100.0 * array_upper($1,1) + 0.5] FROM (SELECT ARRAY(SELECT unnest($1) ORDER BY 1) as t) t1;
$BODY$
  LANGUAGE sql;

CREATE OR REPLACE FUNCTION mediane_centree_10(anyarray NUMERIC[])
  RETURNS NUMERIC AS
$BODY$
/*
   Retourne la médiane des valeurs du tableau (trié ou non) contenues dans l'intervalle
   Ici le centile exterieur est defini à 10 ce qui exclut les 10 % de valeurs les plus hautes et les 10 % de valeurs plus basses.

   exemples :   

    SELECT mediane_centree_10(ARRAY[10,50,3,47,29,49,12,78,85.5,0,1),0,1,1,0], 10);
    >> 10
  */
    DECLARE 
        array_sans_deciles NUMERIC[];
        borne_inf numeric;
        borne_sup numeric;
    BEGIN
        borne_inf := centile(anyarray, 10);
        borne_sup := centile(anyarray, 99 - 10);
        FOR i IN 1..array_upper(anyarray,1)
        LOOP
            IF anyarray[i] >= borne_inf AND anyarray[i] <= borne_sup THEN array_sans_deciles :=  array_sans_deciles || anyarray[i]; END IF;        
        END LOOP;
        RETURN centile(array_sans_deciles, 50);
    END;
$BODY$
  LANGUAGE plpgsql;

DROP AGGREGATE IF EXISTS mediane_10(NUMERIC);
CREATE aggregate mediane_10(NUMERIC)
(
sfunc = array_append,
stype = NUMERIC[],
finalfunc = mediane_centree_10
);

SELECT anneemut, count(idmutation)
FROM (
	SELECT * , 
CASE 
	WHEN libnatmut = 'Echange' THEN '7' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN '9' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN '8' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN '4' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN '31'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '32'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '33'
			ELSE '34'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN '25'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '212'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '213'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN '25'
			WHEN l_dcnt[10] = sterr THEN '25'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN '211'                
			WHEN l_dcnt[5] = sterr THEN '212'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN '213'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN '221'                
			ELSE '231'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN '111' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '141'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '145'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN '111'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN '111' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN '142'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN '143' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN '144'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN '131'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '132'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN '121'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '122'
			ELSE '144'
		END
	ELSE '0'
	END AS codtypbien,
	
CASE 
	WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN 'ADJUVICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN 'VOLUME' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN 'VEFA - INDUSTRIEL ET COMMERCIAL'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'VEFA - APPART'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'VEFA - MAISON'
			ELSE 'VEFA - NON DETERMINE'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'NON BATI - TERRAINS FORESTIERS'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'NON BATI - TERRAINS AGRICOLES'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_dcnt[10] = sterr THEN 'NON BATI - TERRAINS A BATIR'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN 'NON BATI - TERRAINS NATURELS'                
			WHEN l_dcnt[5] = sterr THEN 'NON BATI - TERRAINS FORESTIERS'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN 'NON BATI - TERRAINS AGRICOLES'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN 'NON BATI - TERRAINS ARTIFICIALISES'                
			ELSE 'NON BATI - TERRAINS MIXTES'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'BATI - BIEN AGRICOLE'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'BATI - BIEN FORESTIER'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN 'BATI - INDUSTRIEL ET COMMERCIAL' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - DEPENDANCE LOGEMENT'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN 'BATI - LOGEMENT MIXTE' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN 'BATI - BATI INDEFINI'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISONS'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISON'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPARTS'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPART'
			ELSE 'BATI - NON DETERMINE'
		END
	ELSE 'NON DETERMINE'
END AS libtypbien

 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59350']::VARCHAR[] 
	) t

GROUP BY anneemut;

SELECT anneemut, sum(valeurfonc)
FROM (
	SELECT * , 
CASE 
	WHEN libnatmut = 'Echange' THEN '7' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN '9' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN '8' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN '4' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN '31'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '32'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '33'
			ELSE '34'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN '25'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '212'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '213'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN '25'
			WHEN l_dcnt[10] = sterr THEN '25'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN '211'                
			WHEN l_dcnt[5] = sterr THEN '212'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN '213'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN '221'                
			ELSE '231'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN '111' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '141'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '145'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN '111'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN '111' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN '142'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN '143' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN '144'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN '131'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '132'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN '121'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '122'
			ELSE '144'
		END
	ELSE '0'
	END AS codtypbien,
	
CASE 
	WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN 'ADJUVICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN 'VOLUME' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN 'VEFA - INDUSTRIEL ET COMMERCIAL'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'VEFA - APPART'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'VEFA - MAISON'
			ELSE 'VEFA - NON DETERMINE'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'NON BATI - TERRAINS FORESTIERS'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'NON BATI - TERRAINS AGRICOLES'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_dcnt[10] = sterr THEN 'NON BATI - TERRAINS A BATIR'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN 'NON BATI - TERRAINS NATURELS'                
			WHEN l_dcnt[5] = sterr THEN 'NON BATI - TERRAINS FORESTIERS'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN 'NON BATI - TERRAINS AGRICOLES'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN 'NON BATI - TERRAINS ARTIFICIALISES'                
			ELSE 'NON BATI - TERRAINS MIXTES'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'BATI - BIEN AGRICOLE'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'BATI - BIEN FORESTIER'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN 'BATI - INDUSTRIEL ET COMMERCIAL' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - DEPENDANCE LOGEMENT'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN 'BATI - LOGEMENT MIXTE' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN 'BATI - BATI INDEFINI'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISONS'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISON'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPARTS'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPART'
			ELSE 'BATI - NON DETERMINE'
		END
	ELSE 'NON DETERMINE'
END AS libtypbien

 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59350']::VARCHAR[]
	) t

GROUP BY anneemut;

SELECT COALESCE(SUM(valeurfonc), 0)
FROM (
	SELECT * , 
CASE 
	WHEN libnatmut = 'Echange' THEN '7' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN '9' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN '8' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN '4' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN '31'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '32'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '33'
			ELSE '34'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN '25'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '212'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '213'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN '25'
			WHEN l_dcnt[10] = sterr THEN '25'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN '211'                
			WHEN l_dcnt[5] = sterr THEN '212'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN '213'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN '221'                
			ELSE '231'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN '111' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '141'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '145'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN '111'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN '111' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN '142'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN '143' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN '144'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN '131'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '132'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN '121'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '122'
			ELSE '144'
		END
	ELSE '0'
	END AS codtypbien,
	
CASE 
	WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN 'ADJUVICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN 'VOLUME' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN 'VEFA - INDUSTRIEL ET COMMERCIAL'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'VEFA - APPART'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'VEFA - MAISON'
			ELSE 'VEFA - NON DETERMINE'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'NON BATI - TERRAINS FORESTIERS'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'NON BATI - TERRAINS AGRICOLES'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_dcnt[10] = sterr THEN 'NON BATI - TERRAINS A BATIR'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN 'NON BATI - TERRAINS NATURELS'                
			WHEN l_dcnt[5] = sterr THEN 'NON BATI - TERRAINS FORESTIERS'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN 'NON BATI - TERRAINS AGRICOLES'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN 'NON BATI - TERRAINS ARTIFICIALISES'                
			ELSE 'NON BATI - TERRAINS MIXTES'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'BATI - BIEN AGRICOLE'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'BATI - BIEN FORESTIER'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN 'BATI - INDUSTRIEL ET COMMERCIAL' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - DEPENDANCE LOGEMENT'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN 'BATI - LOGEMENT MIXTE' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN 'BATI - BATI INDEFINI'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISONS'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISON'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPARTS'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPART'
			ELSE 'BATI - NON DETERMINE'
		END
	ELSE 'NON DETERMINE'
END AS libtypbien


	FROM dvf.mutation
	WHERE l_codinsee && ARRAY['59350']::VARCHAR[] AND anneemut >= 2010 AND anneemut <= 2013
	) t
;

SELECT anneemut, count(idmutation)
FROM (
	SELECT * , 
CASE 
	WHEN libnatmut = 'Echange' THEN '7' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN '9' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN '8' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN '4' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN '31'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '32'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '33'
			ELSE '34'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN '25'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '212'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '213'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN '25'
			WHEN l_dcnt[10] = sterr THEN '25'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN '211'                
			WHEN l_dcnt[5] = sterr THEN '212'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN '213'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN '221'                
			ELSE '231'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN '111' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '141'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '145'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN '111'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN '111' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN '142'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN '143' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN '144'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN '131'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '132'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN '121'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '122'
			ELSE '144'
		END
	ELSE '0'
	END AS codtypbien,
	
CASE 
	WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN 'ADJUVICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN 'VOLUME' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN 'VEFA - INDUSTRIEL ET COMMERCIAL'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'VEFA - APPART'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'VEFA - MAISON'
			ELSE 'VEFA - NON DETERMINE'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'NON BATI - TERRAINS FORESTIERS'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'NON BATI - TERRAINS AGRICOLES'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_dcnt[10] = sterr THEN 'NON BATI - TERRAINS A BATIR'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN 'NON BATI - TERRAINS NATURELS'                
			WHEN l_dcnt[5] = sterr THEN 'NON BATI - TERRAINS FORESTIERS'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN 'NON BATI - TERRAINS AGRICOLES'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN 'NON BATI - TERRAINS ARTIFICIALISES'                
			ELSE 'NON BATI - TERRAINS MIXTES'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'BATI - BIEN AGRICOLE'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'BATI - BIEN FORESTIER'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN 'BATI - INDUSTRIEL ET COMMERCIAL' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - DEPENDANCE LOGEMENT'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN 'BATI - LOGEMENT MIXTE' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN 'BATI - BATI INDEFINI'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISONS'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISON'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPARTS'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPART'
			ELSE 'BATI - NON DETERMINE'
		END
	ELSE 'NON DETERMINE'
END AS libtypbien

 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59350']::VARCHAR[] 
	) t
 WHERE codtypbien='25' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(sterr) 
FROM (
	SELECT * , 
CASE 
	WHEN libnatmut = 'Echange' THEN '7' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN '9' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN '8' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN '4' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN '31'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '32'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '33'
			ELSE '34'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN '25'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '212'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '213'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN '25'
			WHEN l_dcnt[10] = sterr THEN '25'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN '211'                
			WHEN l_dcnt[5] = sterr THEN '212'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN '213'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN '221'                
			ELSE '231'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN '111' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '141'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '145'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN '111'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN '111' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN '142'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN '143' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN '144'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN '131'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '132'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN '121'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '122'
			ELSE '144'
		END
	ELSE '0'
	END AS codtypbien,
	
CASE 
	WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN 'ADJUVICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN 'VOLUME' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN 'VEFA - INDUSTRIEL ET COMMERCIAL'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'VEFA - APPART'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'VEFA - MAISON'
			ELSE 'VEFA - NON DETERMINE'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'NON BATI - TERRAINS FORESTIERS'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'NON BATI - TERRAINS AGRICOLES'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_dcnt[10] = sterr THEN 'NON BATI - TERRAINS A BATIR'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN 'NON BATI - TERRAINS NATURELS'                
			WHEN l_dcnt[5] = sterr THEN 'NON BATI - TERRAINS FORESTIERS'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN 'NON BATI - TERRAINS AGRICOLES'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN 'NON BATI - TERRAINS ARTIFICIALISES'                
			ELSE 'NON BATI - TERRAINS MIXTES'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'BATI - BIEN AGRICOLE'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'BATI - BIEN FORESTIER'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN 'BATI - INDUSTRIEL ET COMMERCIAL' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - DEPENDANCE LOGEMENT'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN 'BATI - LOGEMENT MIXTE' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN 'BATI - BATI INDEFINI'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISONS'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISON'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPARTS'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPART'
			ELSE 'BATI - NON DETERMINE'
		END
	ELSE 'NON DETERMINE'
END AS libtypbien

 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59350']::VARCHAR[]
	) t
 WHERE codtypbien='25' 
GROUP BY anneemut;

SELECT anneemut, sum(valeurfonc)
FROM (
	SELECT * , 
CASE 
	WHEN libnatmut = 'Echange' THEN '7' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN '9' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN '8' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN '4' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN '31'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '32'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '33'
			ELSE '34'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN '25'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '212'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '213'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN '25'
			WHEN l_dcnt[10] = sterr THEN '25'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN '211'                
			WHEN l_dcnt[5] = sterr THEN '212'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN '213'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN '221'                
			ELSE '231'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN '111' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '141'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '145'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN '111'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN '111' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN '142'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN '143' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN '144'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN '131'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '132'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN '121'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '122'
			ELSE '144'
		END
	ELSE '0'
	END AS codtypbien,
	
CASE 
	WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN 'ADJUVICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN 'VOLUME' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN 'VEFA - INDUSTRIEL ET COMMERCIAL'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'VEFA - APPART'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'VEFA - MAISON'
			ELSE 'VEFA - NON DETERMINE'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'NON BATI - TERRAINS FORESTIERS'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'NON BATI - TERRAINS AGRICOLES'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_dcnt[10] = sterr THEN 'NON BATI - TERRAINS A BATIR'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN 'NON BATI - TERRAINS NATURELS'                
			WHEN l_dcnt[5] = sterr THEN 'NON BATI - TERRAINS FORESTIERS'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN 'NON BATI - TERRAINS AGRICOLES'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN 'NON BATI - TERRAINS ARTIFICIALISES'                
			ELSE 'NON BATI - TERRAINS MIXTES'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'BATI - BIEN AGRICOLE'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'BATI - BIEN FORESTIER'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN 'BATI - INDUSTRIEL ET COMMERCIAL' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - DEPENDANCE LOGEMENT'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN 'BATI - LOGEMENT MIXTE' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN 'BATI - BATI INDEFINI'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISONS'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISON'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPARTS'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPART'
			ELSE 'BATI - NON DETERMINE'
		END
	ELSE 'NON DETERMINE'
END AS libtypbien

 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59350']::VARCHAR[]
	) t
 WHERE codtypbien='145' 
GROUP BY anneemut;

SELECT anneemut, count(idmutation)
FROM (
	SELECT * , 
CASE 
	WHEN libnatmut = 'Echange' THEN '7' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN '9' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN '8' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN '4' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN '31'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '32'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '33'
			ELSE '34'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN '25'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '212'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '213'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN '25'
			WHEN l_dcnt[10] = sterr THEN '25'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN '211'                
			WHEN l_dcnt[5] = sterr THEN '212'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN '213'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN '221'                
			ELSE '231'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN '111' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '141'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '145'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN '111'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN '111' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN '142'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN '143' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN '144'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN '131'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '132'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN '121'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '122'
			ELSE '144'
		END
	ELSE '0'
	END AS codtypbien,
	
CASE 
	WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN 'ADJUVICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN 'VOLUME' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN 'VEFA - INDUSTRIEL ET COMMERCIAL'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'VEFA - APPART'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'VEFA - MAISON'
			ELSE 'VEFA - NON DETERMINE'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'NON BATI - TERRAINS FORESTIERS'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'NON BATI - TERRAINS AGRICOLES'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_dcnt[10] = sterr THEN 'NON BATI - TERRAINS A BATIR'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN 'NON BATI - TERRAINS NATURELS'                
			WHEN l_dcnt[5] = sterr THEN 'NON BATI - TERRAINS FORESTIERS'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN 'NON BATI - TERRAINS AGRICOLES'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN 'NON BATI - TERRAINS ARTIFICIALISES'                
			ELSE 'NON BATI - TERRAINS MIXTES'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'BATI - BIEN AGRICOLE'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'BATI - BIEN FORESTIER'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN 'BATI - INDUSTRIEL ET COMMERCIAL' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - DEPENDANCE LOGEMENT'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN 'BATI - LOGEMENT MIXTE' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN 'BATI - BATI INDEFINI'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISONS'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISON'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPARTS'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPART'
			ELSE 'BATI - NON DETERMINE'
		END
	ELSE 'NON DETERMINE'
END AS libtypbien

 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59350']::VARCHAR[] 
	) t
 WHERE codtypbien='132' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(valeurfonc) 
FROM (
	SELECT * , 
CASE 
	WHEN libnatmut = 'Echange' THEN '7' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN '9' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN '8' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN '4' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN '31'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '32'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '33'
			ELSE '34'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN '25'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '212'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '213'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN '25'
			WHEN l_dcnt[10] = sterr THEN '25'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN '211'                
			WHEN l_dcnt[5] = sterr THEN '212'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN '213'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN '221'                
			ELSE '231'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN '111' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '141'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '145'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN '111'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN '111' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN '142'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN '143' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN '144'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN '131'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '132'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN '121'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '122'
			ELSE '144'
		END
	ELSE '0'
	END AS codtypbien,
	
CASE 
	WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN 'ADJUVICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN 'VOLUME' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN 'VEFA - INDUSTRIEL ET COMMERCIAL'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'VEFA - APPART'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'VEFA - MAISON'
			ELSE 'VEFA - NON DETERMINE'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'NON BATI - TERRAINS FORESTIERS'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'NON BATI - TERRAINS AGRICOLES'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_dcnt[10] = sterr THEN 'NON BATI - TERRAINS A BATIR'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN 'NON BATI - TERRAINS NATURELS'                
			WHEN l_dcnt[5] = sterr THEN 'NON BATI - TERRAINS FORESTIERS'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN 'NON BATI - TERRAINS AGRICOLES'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN 'NON BATI - TERRAINS ARTIFICIALISES'                
			ELSE 'NON BATI - TERRAINS MIXTES'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'BATI - BIEN AGRICOLE'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'BATI - BIEN FORESTIER'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN 'BATI - INDUSTRIEL ET COMMERCIAL' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - DEPENDANCE LOGEMENT'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN 'BATI - LOGEMENT MIXTE' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN 'BATI - BATI INDEFINI'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISONS'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISON'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPARTS'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPART'
			ELSE 'BATI - NON DETERMINE'
		END
	ELSE 'NON DETERMINE'
END AS libtypbien

 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59350']::VARCHAR[]
	) t
 WHERE codtypbien='132' 
GROUP BY anneemut;

SELECT anneemut, mediane_10(valeurfonc/sbati) 
FROM (
	SELECT * , 
CASE 
	WHEN libnatmut = 'Echange' THEN '7' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN '9' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN '8' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN '4' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN '31'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '32'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '33'
			ELSE '34'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN '25'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '212'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '213'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN '25'
			WHEN l_dcnt[10] = sterr THEN '25'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN '211'                
			WHEN l_dcnt[5] = sterr THEN '212'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN '213'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN '221'                
			ELSE '231'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN '111' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN '141'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN '145'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN '111'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN '111' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN '142'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN '143' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN '144'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN '131'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN '132'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN '121'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN '122'
			ELSE '144'
		END
	ELSE '0'
	END AS codtypbien,
	
CASE 
	WHEN libnatmut = 'Echange' THEN 'ECHANGE DE BIENS' -- ON MET UNE CATEGORIE A PART POUR LES ECHANGES
	WHEN libnatmut = 'Expropriation' THEN 'EXPROPRIATION' -- ON MET UNE CATEGORIE A PART POUR LES EXPROPRIATIONS
	WHEN libnatmut = 'Adjudication' THEN 'ADJUVICATION' -- ON MET UNE CATEGORIE A PART POUR LES ADJUVICATIONS
	WHEN nbvolmut > 0 THEN 'VOLUME' -- VOLUME
	WHEN vefa IS TRUE THEN -- VEFA
		CASE 
			WHEN nblocact > 0 AND nblocapt = 0 AND nblocmai = 0 THEN 'VEFA - INDUSTRIEL ET COMMERCIAL'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'VEFA - APPART'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'VEFA - MAISON'
			ELSE 'VEFA - NON DETERMINE'
		END
	WHEN nblocmut = 0 THEN -- NON BATI
		CASE
			WHEN l_artcgi && ARRAY['1594D*2','257-7-1*3','278 sexies I.1','691bis', '1594OGA']::VARCHAR[]  THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'NON BATI - TERRAINS FORESTIERS'
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'NON BATI - TERRAINS AGRICOLES'
			WHEN libnatmut = 'Vente terrain à bâtir' THEN 'NON BATI - TERRAINS A BATIR'
			WHEN l_dcnt[10] = sterr THEN 'NON BATI - TERRAINS A BATIR'                 
			WHEN l_dcnt[6] + l_dcnt[8] = sterr THEN 'NON BATI - TERRAINS NATURELS'                
			WHEN l_dcnt[5] = sterr THEN 'NON BATI - TERRAINS FORESTIERS'                
			WHEN l_dcnt[1] + l_dcnt[2] + l_dcnt[3] + l_dcnt[4] = sterr THEN 'NON BATI - TERRAINS AGRICOLES'                
			WHEN l_dcnt[7] + l_dcnt[9] + l_dcnt[11] + l_dcnt[12] + l_dcnt[13] = sterr THEN 'NON BATI - TERRAINS ARTIFICIALISES'                
			ELSE 'NON BATI - TERRAINS MIXTES'
			-- IL N'Y A PAS de "NON BATI - NON DETERMINE" 
		END
	WHEN nblocmut > 0 THEN -- BATI
		CASE
			WHEN l_artcgi && ARRAY['1594Ibis']::VARCHAR[] AND (nblocapt > 0 OR nblocmai > 0) THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL' -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
			WHEN l_artcgi && ARRAY['1594FQE', '1594FQE I', '1594FQE II', '1594FQD', '1594FQG']::VARCHAR[] THEN 'BATI - BIEN AGRICOLE'
			WHEN l_artcgi && ARRAY['1137']::VARCHAR[] THEN 'BATI - BIEN FORESTIER'                            
			-- QUESTION SUR LES MUTATIONS POUR LESQUELS IL Y A UN LOCAL VENDU ET DES ARTICLES CGI OU UN LIBELLE DE NATURE DE MUTATION CORRESPONDANT A DES TAB
			WHEN nblocact > 0 THEN
				CASE 
					WHEN nblocapt > 0 OR nblocmai > 0 OR nblocdep > 0 THEN 'BATI - LOGEMENT/INDUSTRIEL ET COMMERCIAL'  -- correspond à la catégorie HABITAT/ECO de la typologie GNDVF
					WHEN nblocapt = 0 AND nblocmai = 0 AND nblocdep = 0 THEN 'BATI - INDUSTRIEL ET COMMERCIAL' 
				END
			WHEN nblocdep > 0 AND nblocapt = 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - DEPENDANCE LOGEMENT'
			WHEN nblocapt > 0 AND nblocmai > 0 AND nblocact = 0 THEN 'BATI - LOGEMENT MIXTE' -- correspond à la catégorie HABITAT MIXTE de la typologie GNDVF
			WHEN sbati < 9 THEN 'BATI - BATI INDEFINI'
			WHEN nblocmai > 1 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISONS'
			WHEN nblocmai > 0 AND nblocapt = 0 AND nblocact = 0 THEN 'BATI - MAISON'
			WHEN nblocapt > 1 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPARTS'
			WHEN nblocapt > 0 AND nblocmai = 0 AND nblocact = 0 THEN 'BATI - APPART'
			ELSE 'BATI - NON DETERMINE'
		END
	ELSE 'NON DETERMINE'
END AS libtypbien

 
	FROM dvf.mutation 
	WHERE l_codinsee && ARRAY['59350']::VARCHAR[]
	) t
 WHERE codtypbien='122' 
GROUP BY anneemut;


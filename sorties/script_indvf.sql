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


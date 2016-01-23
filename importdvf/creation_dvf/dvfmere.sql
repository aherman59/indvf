## _CREER_TABLE        
-- table {0}.{1}
CREATE TABLE {0}.{1}
(
{2}   
);

## _CREER_TABLE_HERITEE        
-- table fille {0}.{1}
CREATE TABLE {0}.{1}
(   
)INHERITS ({2}.{3});        

## _AJOUT_INSERT_TRIGGER
-- création du trigger de la table %(table)s 
CREATE OR REPLACE FUNCTION {0}.{1}_insert_trigger()
RETURNS TRIGGER AS $$
BEGIN
     {2}
    
END;
$$
LANGUAGE plpgsql;
    
CREATE TRIGGER insert_{1}_trigger
    BEFORE INSERT ON {0}.{1}
    FOR EACH ROW EXECUTE PROCEDURE {0}.{1}_insert_trigger();

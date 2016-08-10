SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d62';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying' THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d62'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle WHERE coddep = '59' ORDER BY codinsee;SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle WHERE coddep = '59' ORDER BY codinsee;SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle WHERE coddep = '59' ORDER BY codinsee;SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle WHERE coddep = '59' ORDER BY codinsee;SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle WHERE coddep = '59' ORDER BY codinsee;SELECT DISTINCT coddep || codcomm as codinsee FROM dvf.disposition_parcelle WHERE coddep = '59' ORDER BY codinsee;SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT schema_name FROM information_schema.schemata;

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_d59';

SELECT tablename 
FROM pg_tables 
WHERE schemaname = 'dvf_annexe';

SELECT schema_name 
FROM information_schema.schemata 
WHERE schema_name LIKE 'dvf_d%';

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf'
AND table_name = 'local'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'mutation'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'disposition_parcelle'
ORDER BY ordinal_position;

SELECT 
	ordinal_position as num, 
	column_name as nom, 
	CASE 
		WHEN data_type = 'character varying'  AND character_maximum_length IS NOT NULL THEN data_type || '(' || character_maximum_length || ')' 
		WHEN data_type = 'ARRAY' THEN
			CASE 
				WHEN udt_name = '_text' then 'TEXT[]'
				WHEN udt_name = '_int4' THEN 'INTEGER[]'
				WHEN udt_name = '_varchar' THEN 'CHARACTER VARYING[]'
				WHEN udt_name = '_numeric' THEN 'NUMERIC[]'
			END
		WHEN data_type = 'USER-DEFINED' THEN 'geometry'
		ELSE data_type 
	END AS typ
FROM information_schema.columns
WHERE table_schema = 'dvf_d59'
AND table_name = 'local'
ORDER BY ordinal_position;


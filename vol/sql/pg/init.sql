CREATE SCHEMA unfixed;
SET search_path = unfixed;
\ir ddl/t1.sql

CREATE SCHEMA fixed;
SET search_path = fixed;
\ir ddl/t1.sql

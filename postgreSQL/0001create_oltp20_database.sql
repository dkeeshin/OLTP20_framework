\c postgres

DROP DATABASE IF EXISTS oltp20_control;

CREATE DATABASE oltp20_control
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

\c oltp20_control

CREATE SCHEMA message;
CREATE SCHEMA setup;
CREATE SCHEMA stage;
CREATE SCHEMA reference;

\c postgres

DROP DATABASE IF EXISTS oltp20_register;

CREATE DATABASE oltp20_register
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

DROP DATABASE IF EXISTS oltp20_region_register;

CREATE DATABASE oltp20_region_register
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

DROP DATABASE IF EXISTS oltp20_archive;

CREATE DATABASE oltp20_archive
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

\c oltp20_archive

CREATE SCHEMA message;
CREATE SCHEMA setup;
CREATE SCHEMA stage;
CREATE SCHEMA reference;

\c postgres




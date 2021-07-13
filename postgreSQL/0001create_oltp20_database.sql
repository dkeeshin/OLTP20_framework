\c postgres

DROP DATABASE IF EXISTS oltp20_control;

CREATE DATABASE oltp20_control;

\c oltp20_control

CREATE SCHEMA message;
CREATE SCHEMA setup;
CREATE SCHEMA stage;
CREATE SCHEMA reference;

\c postgres

DROP DATABASE IF EXISTS oltp20_register;

CREATE DATABASE oltp20_register
    ;

DROP DATABASE IF EXISTS oltp20_region_register;

CREATE DATABASE oltp20_region_register;

DROP DATABASE IF EXISTS oltp20_archive;

CREATE DATABASE oltp20_archive;

\c oltp20_archive

CREATE SCHEMA message;
CREATE SCHEMA setup;
CREATE SCHEMA stage;
CREATE SCHEMA reference;

\c postgres




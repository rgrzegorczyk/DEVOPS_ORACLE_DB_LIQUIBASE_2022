--liquibase formatted sql
--changeset rgrzegorczyk:countries stripComments:false context:v1 labels:task1
--comment Create the COUNTRIES table to hold country information for customers and company locations
--rollback DROP TABLE countries;
CREATE TABLE countries 
    ( country_id      VARCHAR2(100) 
       CONSTRAINT  country_id_nn NOT NULL 
    , country_name    VARCHAR2(40) 
    , region_id       NUMBER 
    , CONSTRAINT     country_c_id_pk 
        	     PRIMARY KEY (country_id) 
    );
--changeset rgrzegorczyk:countries_comm stripComments:false context:v1 labels:task1
--comment Countries table comments
--rollback SELECT 1 FROM DUAL;
COMMENT ON TABLE countries
IS 'country table. Contains 25 rows. References with locations table.';

COMMENT ON COLUMN countries.country_id
IS 'Primary key of countries table.';

COMMENT ON COLUMN countries.country_name
IS 'Country name';

COMMENT ON COLUMN countries.region_id
IS 'Region ID for the country. Foreign key to region_id column in the departments table.';

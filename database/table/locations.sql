--liquibase formatted sql
--changeset rgrzegorczyk:locations stripComments:false context:v1 labels:task1 
--comment Create the LOCATIONS table to hold address information for company departments
--rollback DROP TABLE locations;
CREATE TABLE locations
    ( location_id    NUMBER(4)
    , street_address VARCHAR2(40)
    , postal_code    VARCHAR2(12)
    , city       VARCHAR2(30)
	CONSTRAINT     loc_city_nn  NOT NULL
    , state_province VARCHAR2(25)
    , country_id     VARCHAR2(100)
    ) ;

--changeset rgrzegorczyk:locations_PK_index stripComments:false context:v1 labels:task1 
--comment loc_id_pk
--rollback DROP INDEX loc_id_pk;
CREATE UNIQUE INDEX loc_id_pk
ON locations (location_id) ;

--changeset rgrzegorczyk:locations_PK stripComments:false context:v1 labels:task1 
--comment loc_id_pk
--rollback ALTER TABLE locations DROP constraint loc_id_pk;
ALTER TABLE locations
ADD CONSTRAINT loc_id_pk PRIMARY KEY (location_id);

--changeset rgrzegorczyk:locations_comm stripComments:false context:v1 labels:task1 
--comment Locations table comments
--rollback SELECT 1 FROM DUAL;
COMMENT ON TABLE locations
IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';

COMMENT ON COLUMN locations.location_id
IS 'Primary key of locations table';

COMMENT ON COLUMN locations.street_address
IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';

COMMENT ON COLUMN locations.postal_code
IS 'Postal code of the location of an office, warehouse, or production site 
of a company. ';

COMMENT ON COLUMN locations.city
IS 'A not null column that shows city where an office, warehouse, or 
production site of a company is located. ';

COMMENT ON COLUMN locations.state_province
IS 'State or Province where an office, warehouse, or production site of a 
company is located.';

COMMENT ON COLUMN locations.country_id
IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';

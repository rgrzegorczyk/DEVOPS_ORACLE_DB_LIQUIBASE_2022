--liquibase formatted sql
--changeset rgrzegorczyk:regions stripComments:false context:v2 labels:task2
--comment Create the REGIONS table to hold region information for locations 
--rollback DROP TABLE REGIONS;
CREATE TABLE regions
    ( region_id      NUMBER 
       CONSTRAINT  region_id_nn NOT NULL 
    , region_name    VARCHAR2(25) 
    );

--changeset rgrzegorczyk:regions_PK_index stripComments:false context:v2 labels:task2
--comment reg_id_pk
--rollback DROP INDEX reg_id_pk;
CREATE UNIQUE INDEX reg_id_pk
ON regions (region_id);

--changeset rgrzegorczyk:regions_PK stripComments:false context:v2 labels:task3
--comment loc_id_pk
--rollback ALTER TABLE regions DROP constraint reg_id_pk;
ALTER TABLE regions
ADD ( CONSTRAINT reg_id_pk
       		 PRIMARY KEY (region_id)
    ) ;

--changeset rgrzegorczyk:regions_comm stripComments:false context:v2 labels:task3
--comment Regions comments
--rollback SELECT 1 FROM DUAL
COMMENT ON TABLE regions 
IS 'Regions table that contains region numbers and names. Contains 4 rows; references with the Countries table.';

COMMENT ON COLUMN regions.region_id
IS 'Primary key of regions table.';

COMMENT ON COLUMN regions.region_name
IS 'Names of regions. Locations are in the countries of these regions.';    
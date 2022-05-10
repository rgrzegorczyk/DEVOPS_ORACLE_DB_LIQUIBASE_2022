-- liquibase formatted sql

-- changeset pretius:1652167487037-1
CREATE SEQUENCE LOCATIONS_SEQ START WITH 3300 INCREMENT BY 100 MAXVALUE 9900 NOCACHE;

-- changeset pretius:1652167487037-2
CREATE TABLE APPLICATION_PARAMS (CODE VARCHAR2(30 CHAR), NAME VARCHAR2(200 CHAR), VALUE VARCHAR2(200 CHAR), DESCRIPTION VARCHAR2(4000 CHAR), SCOPE VARCHAR2(200 CHAR), PARAM_TYPE VARCHAR2(50 CHAR) DEFAULT 'VARCHAR2', IS_EDITABLE VARCHAR2(20 CHAR) DEFAULT '1');

-- changeset pretius:1652167487037-3
CREATE TABLE COUNTRIES (COUNTRY_ID VARCHAR2(100 BYTE) CONSTRAINT COUNTRY_ID_NN NOT NULL, COUNTRY_NAME VARCHAR2(40 BYTE), REGION_ID NUMBER, CONSTRAINT COUNTRY_C_ID_PK PRIMARY KEY (COUNTRY_ID));
COMMENT ON TABLE COUNTRIES IS 'country table. Contains 25 rows. References with locations table.';
COMMENT ON COLUMN COUNTRIES.COUNTRY_ID IS 'Primary key of countries table.';
COMMENT ON COLUMN COUNTRIES.COUNTRY_NAME IS 'Country name';
COMMENT ON COLUMN COUNTRIES.REGION_ID IS 'Region ID for the country. Foreign key to region_id column in the departments table.';

-- changeset pretius:1652167487037-4
CREATE TABLE JOBS (JOB_ID VARCHAR2(10 BYTE) NOT NULL, JOB_TITLE VARCHAR2(35 BYTE) CONSTRAINT JOB_TITLE_NN NOT NULL, MIN_SALARY NUMBER(6, 0), MAX_SALARY NUMBER(6, 0), CONSTRAINT JOB_ID_PK PRIMARY KEY (JOB_ID));

-- changeset pretius:1652167487037-5
CREATE TABLE LOCATIONS (LOCATION_ID NUMBER(4, 0) NOT NULL, STREET_ADDRESS VARCHAR2(40 BYTE), POSTAL_CODE VARCHAR2(12 BYTE), CITY VARCHAR2(30 BYTE) CONSTRAINT LOC_CITY_NN NOT NULL, STATE_PROVINCE VARCHAR2(25 BYTE), COUNTRY_ID VARCHAR2(100 BYTE), CONSTRAINT LOC_ID_PK PRIMARY KEY (LOCATION_ID));
COMMENT ON TABLE LOCATIONS IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables.';
COMMENT ON COLUMN LOCATIONS.LOCATION_ID IS 'Primary key of locations table';
COMMENT ON COLUMN LOCATIONS.STREET_ADDRESS IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';
COMMENT ON COLUMN LOCATIONS.POSTAL_CODE IS 'Postal code of the location of an office, warehouse, or production site 
of a company.';
COMMENT ON COLUMN LOCATIONS.CITY IS 'A not null column that shows city where an office, warehouse, or 
production site of a company is located.';
COMMENT ON COLUMN LOCATIONS.STATE_PROVINCE IS 'State or Province where an office, warehouse, or production site of a 
company is located.';
COMMENT ON COLUMN LOCATIONS.COUNTRY_ID IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';

-- changeset pretius:1652167487037-6
CREATE TABLE REGIONS (REGION_ID NUMBER CONSTRAINT REGION_ID_NN NOT NULL, REGION_NAME VARCHAR2(25 BYTE), CONSTRAINT REG_ID_PK PRIMARY KEY (REGION_ID));
COMMENT ON TABLE REGIONS IS 'Regions table that contains region numbers and names. Contains 4 rows; references with the Countries table.';
COMMENT ON COLUMN REGIONS.REGION_ID IS 'Primary key of regions table.';
COMMENT ON COLUMN REGIONS.REGION_NAME IS 'Names of regions. Locations are in the countries of these regions.';

-- changeset pretius:1652167487037-7
ALTER TABLE LOCATIONS ADD CONSTRAINT LOC_C_ID_FK FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRIES (COUNTRY_ID);

-- changeset pretius:1652167487037-8
CREATE OR REPLACE FORCE VIEW "COUNTRIES_LOCATIONS_V" ("COUNTRY_NAME", "STREET_ADDRESS", "POSTAL_CODE", "CITY", "STATE_PROVINCE") AS SELECT c.country_name,
	       l.street_address,
	       l.postal_code,
	       l.city,
	       l.state_province
	  FROM locations l
	  JOIN countries c ON c.country_id = l.country_id;

-- changeset pretius:1652167487037-9
CREATE OR REPLACE FORCE VIEW "LOCATIONS_V" ("STREET_ADDRESS", "POSTAL_CODE", "CITY", "STATE_PROVINCE") AS SELECT 
	       l.street_address,
	       l.postal_code,
	       l.city,
	       l.state_province
	  FROM locations l;


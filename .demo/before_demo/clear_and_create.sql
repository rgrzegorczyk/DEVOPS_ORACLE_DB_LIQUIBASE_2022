select * from user_objects;

liquibase dropAll
drop table DATABASECHANGELOGLOCK purge;
drop table DATABASECHANGELOG purge;


DROP VIEW countries_locations_v;
DROP view locations_v;
DROP table application_params;
DROP PACKAGE BODY countries_pkg;
DROP PACKAGE countries_pkg;
drop table test;
select * from user_objects;

liquibase dropAll
drop table DATABASECHANGELOGLOCK purge;
drop table DATABASECHANGELOG purge;


DROP VIEW countries_locations_v;
DROP view locations_v;
DROP table application_params;
DROP PACKAGE BODY countries_pkg;
DROP PACKAGE countries_pkg;
drop table test;
drop table locations;
drop table jobs;
drop table countries;
drop index REG_ID_PK;
drop table regions;
drop sequence locations_seq;


purge recyclebin;


purge recyclebin;
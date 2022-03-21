--liquibase formatted sql
--changeset rgrzegorczyk:locations_seq stripComments:false context:v1 labels:task1 
--comment Sequence for locations table
--rollback DROP SEQUENCE locations_seq;
CREATE SEQUENCE locations_seq
 START WITH     3300
 INCREMENT BY   100
 MAXVALUE       9900
 NOCACHE
 NOCYCLE;

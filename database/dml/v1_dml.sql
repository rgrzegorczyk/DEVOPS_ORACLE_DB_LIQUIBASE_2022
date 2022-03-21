--liquibase formatted sql
--changeset rgrzegorczyk:insert_app_params stripComments:false context:v1 labels:task1
--comment Insert environment type 
--rollback DELETE FROM APPLICATION_PARAMS WHERE CODE='ENVIRONMENT';
INSERT INTO APPLICATION_PARAMS (CODE, NAME, VALUE) VALUES ('ENVIRONMENT', 'Environment type', 'DEV')

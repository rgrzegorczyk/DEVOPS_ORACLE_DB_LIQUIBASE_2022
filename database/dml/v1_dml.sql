--liquibase formatted sql
--changeset rgrzegorczyk:insert_app_params stripComments:false context:v1 labels:task1
--comment Insert environment type 
--preconditions onFail:continue  onSqlOutput:TEST
--precondition-sql-check expectedResult:1 select COUNT(*) FROM user_objects where object_name='APPLICATION_PARAMS' and object_type='TABLE' and rownum=1;
--rollback DELETE FROM APPLICATION_PARAMS WHERE CODE='ENVIRONMENT';
INSERT INTO APPLICATION_PARAMS (CODE, NAME, VALUE) VALUES ('ENVIRONMENT', 'Environment type', 'DEV')


--liquibase formatted sql
--changeset rgrzegorczyk:loc_c_id_fk stripComments:false context:v1 labels:task1 
--comment FK locations to coutries 
--rollback ALTER TABLE locations DROP CONSTRAINT loc_c_id_fk;
ALTER TABLE locations
ADD CONSTRAINT loc_c_id_fk
       		 FOREIGN KEY (country_id)
        	  REFERENCES countries(country_id);

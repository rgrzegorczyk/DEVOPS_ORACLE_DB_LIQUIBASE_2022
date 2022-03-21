--liquibase formatted sql
--changeset rgrzegorczyk:jobs stripComments:false context:v1 labels:task1
--comment Create the JOBS table to hold the different names of job roles within the company.
--rollback DROP TABLE jobs;
CREATE TABLE jobs
    ( job_id         VARCHAR2(10)
    , job_title      VARCHAR2(35)
	CONSTRAINT     job_title_nn  NOT NULL
    , min_salary     NUMBER(6)
    , max_salary     NUMBER(6)
    ) ;

--changeset rgrzegorczyk:job_id_pk_INDEX stripComments:false context:v1 labels:task1
--comment job_id_pk
--rollback DROP INDEX job_id_pk;
CREATE UNIQUE INDEX job_id_pk 
ON jobs (job_id) ;

--changeset rgrzegorczyk:job_id_pk stripComments:false context:v1 labels:task1 
--comment job_id_pk
--rollback ALTER TABLE jobs DROP constraint job_id_pk;
ALTER TABLE jobs
ADD ( CONSTRAINT job_id_pk
      		 PRIMARY KEY(job_id)
    ) ;
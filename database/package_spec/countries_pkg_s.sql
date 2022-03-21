--liquibase formatted sql
--changeset rgrzegorczyk:countries_pkg_s runOnChange:true stripComments:false context:v1 labels:task1 
--comment countries_pkg specification
--rollback DROP PACKAGE countries_pkg;
create or replace package countries_pkg
as

/* function to show country id*/
function f_get_country_id_by_name(
  pi_country_name IN countries.country_name%TYPE
) return VARCHAR2;

  
end countries_pkg;

/

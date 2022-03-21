--liquibase formatted sql
--changeset rgrzegorczyk:countries_pkg_b runOnChange:true stripComments:false context:v1 labels:task1 
--comment countries_pkg body
--rollback DROP PACKAGE BODY countries_pkg;
create or replace package body countries_pkg
as
  /* function to show country id*/
  function f_get_country_id_by_name(
    pi_country_name in countries.country_name%TYPE)
  return
    VARCHAR2
  as
    v_return countries.country_id%TYPE;
  begin
    select country_id
      into v_return
      from countries
     where country_name = pi_country_name;

    return v_return;
  exception
    when others then
      v_return := 'USA';
      return v_return;
  end f_get_country_id_by_name;
  
end countries_pkg;

/

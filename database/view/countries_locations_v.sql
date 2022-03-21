--liquibase formatted sql
--changeset rgrzegorczyk:countries_locations_v runOnChange:true stripComments:false context:v1 labels:task1 
--comment View showing countries and locations
--rollback DROP VIEW countries_locations_v;
CREATE OR REPLACE VIEW countries_locations_v AS
	SELECT c.country_name,
	       l.street_address,
	       l.postal_code,
	       l.city,
	       l.state_province
	  FROM locations l
	  JOIN countries c ON c.country_id = l.country_id;
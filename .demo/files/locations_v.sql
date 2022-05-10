CREATE OR REPLACE VIEW locations_v AS
	SELECT 
	       l.street_address,
	       l.postal_code,
	       l.city,
	       l.state_province
	  FROM locations l;
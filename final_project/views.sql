-- Представления

USE mvideo;

CREATE OR REPLACE VIEW catalogs_view (catalog, catalog_id) AS 
	SELECT name, id FROM catalogs ORDER BY name;
	
SELECT * FROM catalogs_view;


CREATE OR REPLACE VIEW products_view AS 
	SELECT name, price, category_id FROM products ORDER BY category_id;

SELECT * FROM products_view;

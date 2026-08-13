
-- Geolocation removing duplicate zip code prefixes

SELECT 
  geolocation_zip_code_prefix,
  AVG(geolocation_lat) geolocation_lat,
  AVG(geolocation_lng) geolocation_lng,
  MODE() WITHIN GROUP (ORDER BY geolocation_city) geolocation_city,
  MODE() WITHIN GROUP (ORDER BY geolocation_state) geolocation_state
FROM bronze.olist_geolocation_dataset
GROUP BY geolocation_zip_code_prefix;


-- Checking for unmatched values 
SELECT DISTINCT
  p.product_category_name product,
  t.product_category_name translation
FROM bronze.olist_products_dataset p
FULL JOIN bronze.product_category_name_translation t 
ON t.product_category_name = p.product_category_name;

-- Adding missing values
INSERT INTO bronze.product_category_name_translation (product_category_name, product_category_name_english)
VALUES 
    ('pc_gamer', 'pc_gamer'),
    ('portateis_cozinha_e_preparadores_de_alimentos', 'portable_kitchen_and_food_preparers');

SELECT *
FROM bronze.olist_customers_dataset
LIMIT 1000;




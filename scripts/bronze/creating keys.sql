/*================
PRIMARY KEYS
================*/

ALTER TABLE bronze.olist_customers_dataset
  ADD CONSTRAINT pk_olist_customers_dataset 
  PRIMARY KEY (customer_id);

-- Cheking for ID duplicates
SELECT *
FROM (
  SELECT
    customer_id,
    COUNT(*) OVER(PARTITION BY customer_id) id_count
  FROM bronze.olist_customers_dataset
)
WHERE id_count > 1;


ALTER TABLE bronze.olist_orders_dataset
  ADD CONSTRAINT pk_olist_orders_dataset
  PRIMARY KEY (order_id);


ALTER TABLE bronze.olist_products_dataset
  ADD CONSTRAINT pk_olist_products_dataset
  PRIMARY KEY (product_id);


ALTER TABLE bronze.olist_sellers_dataset
  ADD CONSTRAINT pk_olist_sellers_dataset
  PRIMARY KEY (seller_id);


/*================
FOREIGN KEYS
================*/

-- olist_order_items_dataset

ALTER TABLE bronze.olist_order_items_dataset
  ADD CONSTRAINT fk_olist_order_items_dataset__olist_orders_dataset
  FOREIGN KEY (order_id)
  REFERENCES bronze.olist_orders_dataset (order_id);

ALTER TABLE bronze.olist_order_items_dataset
  ADD CONSTRAINT fk_olist_order_items_dataset__olist_products_dataset
  FOREIGN KEY (product_id)
  REFERENCES bronze.olist_products_dataset (product_id);

ALTER TABLE bronze.olist_order_items_dataset
  ADD CONSTRAINT fk_olist_order_items_dataset__olist_sellers_dataset
  FOREIGN KEY (seller_id)
  REFERENCES bronze.olist_sellers_dataset (seller_id);


-- olist_order_payments_dataset
ALTER TABLE bronze.olist_order_payments_dataset
  ADD CONSTRAINT fk_olist_order_payments_dataset__olist_orders_dataset
  FOREIGN KEY (order_id)
  REFERENCES bronze.olist_orders_dataset (order_id);


-- olist_order_reviews_dataset
ALTER TABLE bronze.olist_order_reviews_dataset
  ADD CONSTRAINT fk_olist_order_reviews_dataset__olist_orders_dataset
  FOREIGN KEY (order_id)
  REFERENCES bronze.olist_orders_dataset (order_id);


-- olist_orders_dataset
ALTER TABLE bronze.olist_orders_dataset
  ADD CONSTRAINT fk_olist_orders_dataset__olist_customers_dataset
  FOREIGN KEY (customer_id)
  REFERENCES bronze.olist_customers_dataset (customer_id);


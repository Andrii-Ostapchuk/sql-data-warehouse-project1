/*
===============================================================================
DDL Script: Bronze Layer Table Creation
===============================================================================
Script Purpose:
    - Defines the relational schema for the Bronze (raw/ingestion) layer.
    - Drops existing tables if present to support repeatable/idempotent execution.
    - Creates dimension tables (calendar, customers, products, stores) followed by 
      the central fact table (sales).
    - Enforces primary keys and explicit foreign key constraints to establish 
      referential integrity between transactional sales and entity metadata.
===============================================================================
*/


DROP TABLE IF EXISTS bronze.olist_customers_dataset;

CREATE TABLE bronze.olist_customers_dataset (
  customer_id VARCHAR(50),
  customer_unique_id VARCHAR(50),
  customer_zip_code_prefix VARCHAR(10),
  customer_city VARCHAR(20),
  customer_state VARCHAR(2)
);


DROP TABLE IF EXISTS bronze.olist_geolocation_dataset;

CREATE TABLE bronze.olist_geolocation_dataset (
  geolocation_zip_code_prefix VARCHAR(5),
  geolocation_lat FLOAT,
  geolocation_lng FLOAT,
  geolocation_city VARCHAR(20),
  geolocation_state VARCHAR(2)
);


DROP TABLE IF EXISTS bronze.olist_order_items_dataset;

CREATE TABLE bronze.olist_order_items_dataset (
  order_id VARCHAR(50),
  order_item_id INT,
  product_id VARCHAR(50),
  seller_id VARCHAR(50),
  shipping_limit_date DATE,
  price FLOAT,
  freight_value FLOAT
);


DROP TABLE IF EXISTS bronze.olist_order_payments_dataset;

CREATE TABLE bronze.olist_order_payments_dataset (
  order_id VARCHAR(50),
  payment_sequential INT,
  payment_type VARCHAR(10),
  payment_installments INT,
  payment_value FLOAT
);


DROP TABLE IF EXISTS bronze.olist_order_reviews_dataset;

CREATE TABLE bronze.olist_order_reviews_dataset (
  review_id VARCHAR(50),
  order_id VARCHAR(50),
  review_score INT,
  review_comment_title VARCHAR(50),
  review_comment_message TEXT,
  review_creation_date DATE,
  review_answer_timestamp DATE
);

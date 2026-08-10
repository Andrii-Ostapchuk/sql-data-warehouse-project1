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

-- ============================================================================
-- 1. Calendar Dimension Table
-- Stores date breakdown fields for time-series aggregation and filtering.
-- ============================================================================
DROP TABLE IF EXISTS bronze.calendar;

CREATE TABLE bronze.calendar (
  date DATE,
  year INT,
  month INT,
  day INT,
  week INT,
  day_of_week INT
);

-- ============================================================================
-- 2. Customers Dimension Table
-- Customer profile data including demographics and membership details.
-- ============================================================================
DROP TABLE IF EXISTS bronze.customers;

CREATE TABLE bronze.customers (
  customer_id VARCHAR(10) PRIMARY KEY,
  age INT,
  gender VARCHAR(8),
  loyalty_member BOOLEAN,
  join_date DATE
);

-- ============================================================================
-- 3. Products Dimension Table
-- Product catalog containing item classifications and specifications.
-- ============================================================================
DROP TABLE IF EXISTS bronze.products;

CREATE TABLE bronze.products (
  product_id VARCHAR(6) PRIMARY KEY,
  product_name VARCHAR(30),
  brand VARCHAR(10),
  category VARCHAR(10),
  cocoa_percent INT,
  weight_g INT
);

-- ============================================================================
-- 4. Stores Dimension Table
-- Store entity metadata including geographical locations and store types.
-- ============================================================================
DROP TABLE IF EXISTS bronze.stores;

CREATE TABLE bronze.stores (
  store_id VARCHAR(5) PRIMARY KEY,
  store_name VARCHAR(20),
  city VARCHAR(20),
  country VARCHAR(20),
  store_type VARCHAR(10)
);

-- ============================================================================
-- 5. Sales Fact Table
-- Transactional line items containing financial metrics and operational metrics.
-- Foreign keys link each sales record to products, stores, and customers.
-- Must be created AFTER the referenced dimension tables are defined.
-- ============================================================================
DROP TABLE IF EXISTS bronze.sales;

CREATE TABLE bronze.sales (
  order_id VARCHAR(12) PRIMARY KEY,
  order_date DATE,
  product_id VARCHAR(6),
  CONSTRAINT fk_sales_products
    FOREIGN KEY (product_id) 
    REFERENCES bronze.products(product_id),
  store_id VARCHAR(5), 
  CONSTRAINT fk_sales_stores
    FOREIGN KEY (store_id)
    REFERENCES bronze.stores(store_id),
  customer_id VARCHAR(10),
  CONSTRAINT fk_sales_customers
    FOREIGN KEY (customer_id)
    REFERENCES bronze.customers(customer_id),
  quantity INT,
  unit_price FLOAT,
  discount FLOAT,
  revenue FLOAT,
  cost FLOAT,
  profit FLOAT
);
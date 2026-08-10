/*
===============================================================================
Data Ingestion Script: Bronze Layer Bulk Load
===============================================================================
Script Purpose:
    - Populates raw Bronze layer tables by bulk importing data from CSV source files.
    - Uses PostgreSQL COPY statement with standard CSV options (HEADER true, DELIMITER ',').
    - Order of execution loads dimension entities (calendar, customers, products, stores) 
      before the sales fact table to prevent foreign key violation conflicts.
===============================================================================
*/

-- ============================================================================
-- 1. Load Calendar Data
-- Ingests calendar date definitions into the bronze.calendar table.
-- ============================================================================
COPY bronze.calendar
FROM 'D:/Data Analysis/1_SQL/dwh_project/sql-data-warehouse-project1/datasets/calendar.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

-- ============================================================================
-- 2. Load Customer Data
-- Ingests raw customer profile and membership details into bronze.customers.
-- ============================================================================
COPY bronze.customers
FROM 'D:/Data Analysis/1_SQL/dwh_project/sql-data-warehouse-project1/datasets/customers.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

-- ============================================================================
-- 3. Load Product Catalog Data
-- Ingests product descriptions, categories, and attributes into bronze.products.
-- ============================================================================
COPY bronze.products
FROM 'D:/Data Analysis/1_SQL/dwh_project/sql-data-warehouse-project1/datasets/products.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

-- ============================================================================
-- 4. Load Store Metadata
-- Ingests physical and online store location details into bronze.stores.
-- ============================================================================
COPY bronze.stores
FROM 'D:/Data Analysis/1_SQL/dwh_project/sql-data-warehouse-project1/datasets/stores.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);

-- ============================================================================
-- 5. Load Sales Transactions
-- Ingests transactional sales records into bronze.sales.
-- Executed last to ensure foreign key entities (products, stores, customers) exist.
-- ============================================================================
COPY bronze.sales
FROM 'D:/Data Analysis/1_SQL/dwh_project/sql-data-warehouse-project1/datasets/sales.csv'
WITH (
    FORMAT csv,
    HEADER true,
    DELIMITER ','
);
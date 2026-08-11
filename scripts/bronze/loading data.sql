/*
===============================================================================
Data Ingestion Script for Stored Procedure: Bronze Layer Bulk Load (with Execution Timing)
===============================================================================
Script Purpose:
    - Populates raw Bronze layer tables by bulk importing data from CSV source files.
    - Uses PostgreSQL COPY statement with standard CSV options (HEADER true, DELIMITER ',').
    - Tracks and prints step-by-step execution duration as well as total procedure runtime
      using clock_timestamp() and RAISE NOTICE messaging.
===============================================================================
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    v_start_time TIMESTAMPTZ;
    v_end_time   TIMESTAMPTZ;
    v_step_start TIMESTAMPTZ;
    v_step_end   TIMESTAMPTZ;
BEGIN
    v_start_time := clock_timestamp();
    
    RAISE NOTICE '==================================================';
    RAISE NOTICE 'Starting Bronze Layer Loading Process';
    RAISE NOTICE '==================================================';

    -- ============================================================================
    -- 1. Load Calendar Data
    -- ============================================================================
    v_step_start := clock_timestamp();
    
    TRUNCATE TABLE bronze.calendar CASCADE;

    COPY bronze.calendar
    FROM 'D:/Data Analysis/1_SQL/dwh_project/sql-data-warehouse-project1/datasets/calendar.csv'
    WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ','
    );
    
    v_step_end := clock_timestamp();
    RAISE NOTICE 'Table "bronze.calendar" loaded in: %', (v_step_end - v_step_start);

    -- ============================================================================
    -- 2. Load Customer Data
    -- ============================================================================
    v_step_start := clock_timestamp();
    
    TRUNCATE TABLE bronze.customers CASCADE;

    COPY bronze.customers
    FROM 'D:/Data Analysis/1_SQL/dwh_project/sql-data-warehouse-project1/datasets/customers.csv'
    WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ','
    );
    
    v_step_end := clock_timestamp();
    RAISE NOTICE 'Table "bronze.customers" loaded in: %', (v_step_end - v_step_start);

    -- ============================================================================
    -- 3. Load Product Catalog Data
    -- ============================================================================
    v_step_start := clock_timestamp();
    
    TRUNCATE TABLE bronze.products CASCADE;

    COPY bronze.products
    FROM 'D:/Data Analysis/1_SQL/dwh_project/sql-data-warehouse-project1/datasets/products.csv'
    WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ','
    );
    
    v_step_end := clock_timestamp();
    RAISE NOTICE 'Table "bronze.products" loaded in: %', (v_step_end - v_step_start);

    -- ============================================================================
    -- 4. Load Store Metadata
    -- ============================================================================
    v_step_start := clock_timestamp();
    
    TRUNCATE TABLE bronze.stores CASCADE;

    COPY bronze.stores
    FROM 'D:/Data Analysis/1_SQL/dwh_project/sql-data-warehouse-project1/datasets/stores.csv'
    WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ','
    );
    
    v_step_end := clock_timestamp();
    RAISE NOTICE 'Table "bronze.stores" loaded in: %', (v_step_end - v_step_start);

    -- ============================================================================
    -- 5. Load Sales Transactions
    -- ============================================================================
    v_step_start := clock_timestamp();
    
    TRUNCATE TABLE bronze.sales CASCADE;

    COPY bronze.sales
    FROM 'D:/Data Analysis/1_SQL/dwh_project/sql-data-warehouse-project1/datasets/sales.csv'
    WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ','
    );
    
    v_step_end := clock_timestamp();
    RAISE NOTICE 'Table "bronze.sales" loaded in: %', (v_step_end - v_step_start);

    -- ============================================================================
    -- Summary Reporting
    -- ============================================================================
    v_end_time := clock_timestamp();
    
    RAISE NOTICE '==================================================';
    RAISE NOTICE 'Bronze Layer Loading Completed Successfully';
    RAISE NOTICE 'Total Execution Time: %', (v_end_time - v_start_time);
    RAISE NOTICE '==================================================';

END;
$$;

CALL bronze.load_bronze();
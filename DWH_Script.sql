CREATE DATABASE data_ware_house;

USE data_ware_house;

GO
CREATE TABLE customers (
    cst_id INT,
    cst_key VARCHAR(20),
    cst_firstname VARCHAR(100),
    cst_lastname VARCHAR(100),
    cst_marital_status CHAR(1),
    cst_gndr CHAR(1),
    cst_create_date DATE
);

GO
CREATE TABLE products (
    prd_id INT ,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(150),
    prd_cost DECIMAL(10,2),
    prd_line VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE
);

GO
CREATE TABLE sales (
    sls_ord_num VARCHAR(20),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales DECIMAL(12,2),
    sls_quantity INT,
    sls_price DECIMAL(12,2)
);

GO
CREATE TABLE customer_details (
    CID VARCHAR(20),
    BDATE DATE,
    GEN VARCHAR(10)
);

GO
CREATE TABLE customer_location (
    CID VARCHAR(20),
    CNTRY VARCHAR(100)
);

GO
CREATE TABLE product_category (
    ID VARCHAR(20),
    CAT VARCHAR(100),
    SUBCAT VARCHAR(100),
    MAINTENANCE VARCHAR(10)
);



-- LOAD THE DATA INTO TABLES

-- TABLE: customers
BULK INSERT customers
FROM "C:\Users\VIJAY K G\OneDrive\Documents\VIJAY K G\SQL with Baraa\sql-data-warehouse-project\datasets\source_crm\cust_info.csv"
WITH(
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );


-- TABLE: products
BULK INSERT products
FROM "C:\Users\VIJAY K G\OneDrive\Documents\VIJAY K G\SQL with Baraa\sql-data-warehouse-project\datasets\source_crm\prd_info.csv"
WITH(
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );


-- TABLE: sales
BULK INSERT sales
FROM "C:\Users\VIJAY K G\OneDrive\Documents\VIJAY K G\SQL with Baraa\sql-data-warehouse-project\datasets\source_crm\sales_details.csv"
WITH(
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );


-- TABLE: customer_details
BULK INSERT customer_details
FROM "C:\Users\VIJAY K G\OneDrive\Documents\VIJAY K G\SQL with Baraa\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv"
WITH(
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );


-- TABLE: customer_location
BULK INSERT customer_location
FROM "C:\Users\VIJAY K G\OneDrive\Documents\VIJAY K G\SQL with Baraa\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv"
WITH(
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );


-- TABLE: product_category
BULK INSERT product_category
FROM "C:\Users\VIJAY K G\OneDrive\Documents\VIJAY K G\SQL with Baraa\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv"
WITH(
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );


-- DATA PREVIEW 

SELECT TOP(500) * FROM customers;
SELECT TOP(500) * FROM products;
SELECT TOP(500) * FROM sales;
SELECT TOP(500) * FROM customer_details;
SELECT TOP(500) * FROM customer_location;
SELECT TOP(500) * FROM product_category;
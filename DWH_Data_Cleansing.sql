
USE data_ware_house;


-- DATA PREVIEW 

SELECT TOP(500) * FROM customers;
SELECT TOP(500) * FROM products;
SELECT TOP(500) * FROM sales;
SELECT TOP(500) * FROM customer_details;
SELECT TOP(500) * FROM customer_location;
SELECT TOP(500) * FROM product_category;

-- CHECK FOR NULL's AND DUPLICATES IN PRIMARY KEY

SELECT 
	cst_id,
	count(*) 
FROM customers
GROUP BY cst_id
HAVING count(*) > 1 OR cst_id IS NULL;


-- CLEANSING THE CUSTOMERS TABLE DATA

GO
CREATE VIEW customers_clean AS
SELECT 
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,

    CASE 
        WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
        WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
        ELSE 'n/a'
    END AS cst_marital_status,

    CASE 
        WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
        WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
        ELSE 'n/a'
    END AS cst_gndr,

    cst_create_date

FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY cst_id 
            ORDER BY cst_create_date
        ) AS flag_last
    FROM customers
    WHERE cst_id IS NOT NULL
) t
WHERE flag_last = 1;


-- CLEANSING THE PRODUCTS TABLE DATA

GO
CREATE VIEW products_clean AS
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY prd_id, prd_key, prd_start_dt
               ORDER BY prd_id
           ) AS rn
    FROM products
)
SELECT 
    prd_id,
    REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
    SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
    prd_nm,
    ISNULL(prd_cost,0) AS prd_cost,
    CASE UPPER(TRIM(prd_line))
        WHEN 'M' THEN 'Mountain'
        WHEN 'R' THEN 'Road'
        WHEN 'S' THEN 'Other Sales'
        WHEN 'T' THEN 'Touring'
        ELSE 'n/a'
    END AS prd_line,
    CAST(prd_start_dt AS DATE) AS prd_start_dt,
    CAST(DATEADD(DAY,-1,
        LEAD(prd_start_dt) OVER (
            PARTITION BY prd_key ORDER BY prd_start_dt
        )) AS DATE) AS prd_end_dt
FROM CTE
WHERE rn = 1;



-- CLEANSING THE SALES TABLE DATA

GO
CREATE VIEW sales_clean AS 
SELECT 
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
                THEN sls_quantity * ABS(sls_price)
         ELSE sls_sales
    END AS sls_sales,
    sls_quantity,
    CASE WHEN sls_price IS NULL OR sls_price <= 0 
                THEN sls_sales / NULLIF(sls_quantity,0)
         ELSE sls_price
    END AS sls_price
FROM SALES;



-- CLEANSING THE CUSTOMER DETAILS TABLE DATA

GO
CREATE VIEW customer_details_clean AS
SELECT 
    CASE WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID, 4, LEN(CID))
         ELSE CID
    END AS cid,
    CASE WHEN BDATE > GETDATE() THEN NULL
         ELSE BDATE
    END AS bdate,
    CASE WHEN UPPER(TRIM(GEN)) IN ('F', 'Female') THEN 'Female'
         WHEN UPPER(TRIM(GEN)) IN ('M', 'Male') THEN 'Male'
         ELSE 'n/a'
    END AS gen
FROM customer_details;


-- CLEANSING THE CUSTOMER LOCATION TABLE DATA

GO
CREATE VIEW customer_location_clean AS 
SELECT 
REPLACE(CID,'-','') AS cid,
CASE WHEN TRIM(CNTRY) = 'DE' THEN 'Germany'
     WHEN TRIM(CNTRY) IN ('US', 'USA') THEN 'United States'
     WHEN TRIM(CNTRY) = '' OR CNTRY IS NULL THEN 'n/a'
     ELSE CNTRY
END AS country
FROM customer_location;


-- CLEANSING THE PRODUCT CATEGORY TABLE DATA

GO 
CREATE VIEW product_category_clean AS
SELECT 
ID AS id,
CAT AS cat,
SUBCAT AS subcat,
MAINTENANCE AS maintenance
FROM product_category;


-- ALL CLEANED DATA TABLES

GO
SELECT * FROM customers_clean;
SELECT * FROM products_clean;
SELECT * FROM sales_clean;
SELECT * FROM customer_details_clean;
SELECT * FROM customer_location_clean;
SELECT * FROM product_category_clean;














USE data_ware_house;


SELECT * FROM customers_clean;
SELECT * FROM products_clean;
SELECT * FROM sales_clean;
SELECT * FROM customer_details_clean;
SELECT * FROM customer_location_clean;
SELECT * FROM product_category_clean;


-- ALL CUSTOMERS DETAILS ARE JOINED

GO
CREATE VIEW dim_customers AS
SELECT
    ROW_NUMBER() OVER (ORDER BY C1.cst_id) AS customer_key,
    C1.cst_id AS customer_id,
    C1.cst_key AS customer_number,
    C1.cst_firstname AS first_name,
    C1.cst_lastname AS last_name,
    C3.country AS country,
    C1.cst_marital_status AS marital_status,
    CASE 
        WHEN C1.cst_gndr != 'n/a' THEN C1.cst_gndr
        ELSE COALESCE(C2.gen, 'n/a')
    END AS gender,
    C2.bdate AS birth_date,
    C1.cst_create_date AS create_date
FROM customers_clean C1
LEFT JOIN customer_details_clean C2
    ON C1.cst_key = C2.cid
LEFT JOIN customer_location_clean C3
    ON C2.cid = C3.cid;
GO


-- ALL PRODUCTS DETAILS ARE JOINED

GO 
CREATE VIEW dim_products AS 
SELECT
    ROW_NUMBER() OVER (ORDER BY P1.prd_start_dt, P1.prd_key) AS product_key,
    P1.prd_id AS product_id,
    P1.prd_key AS product_number,
    P1.prd_nm AS product_name,
    P1.cat_id AS category_id,
    P2.cat AS category,
    P2.subcat AS sub_category,
    P2.maintenance AS maintenance,
    P1.prd_cost AS product_cost,
    P1.prd_line AS product_line,
    P1.prd_start_dt AS start_date
FROM products_clean P1
LEFT JOIN product_category_clean P2
    ON P1.cat_id = P2.id
WHERE P1.prd_end_dt IS NULL;
GO


-- ALL SALES DETAILS ARE JOINED

GO
CREATE VIEW fact_sales AS
SELECT
    s.sls_ord_num AS order_number,
    p.product_key,
    c.customer_key,
    s.sls_order_dt AS order_date,
    s.sls_ship_dt AS ship_date,
    s.sls_due_dt AS due_date,
    s.sls_sales AS sales_amount,
    s.sls_quantity AS quantity,
    s.sls_price AS price
FROM sales_clean s
LEFT JOIN dim_products p
    ON s.sls_prd_key = p.product_number
LEFT JOIN dim_customers c
    ON s.sls_cust_id = c.customer_id;
GO

-- ALL CUSTOMER, PRODUCT, AND SALE SUMMARIES

SELECT * FROM dim_customers;
SELECT * FROM dim_products;
SELECT * FROM fact_sales;


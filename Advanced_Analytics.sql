
USE data_ware_house;

SELECT * FROM dim_customers;
SELECT * FROM dim_products;
SELECT * FROM fact_sales;

-- year wise total sale

SELECT 
    YEAR(order_date) AS order_year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)


-- month wise total sale

SELECT 
    MONTH(order_date) AS order_mpnth,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)


-- calculate the total sales per month 
-- and the running total of sales over time 

SELECT 
    order_date,
    total_sales,
    SUM(total_sales) OVER(ORDER BY order_date) AS running_total_sales,
    AVG(avg_price) OVER(ORDER BY order_date) AS moving_avg_price
FROM(
	SELECT 
		DATETRUNC (MONTH, order_date) AS order_date,
		SUM(sales_amount) AS total_sales,
		AVG(price) AS avg_price
	FROM fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC (MONTH, order_date)
	) t



/* Analyze yearly product performance by comparing:
   1. Current sales vs average product sales
   2. Current sales vs previous year sales
*/

WITH yearly_product_sales AS
(
    SELECT
        YEAR(s.order_date) AS order_year,
        p.product_name,
        SUM(s.sales_amount) AS current_sales
    FROM fact_sales AS s
    LEFT JOIN dim_products AS p
        ON s.product_key = p.product_key
    WHERE s.order_date IS NOT NULL
    GROUP BY
        YEAR(s.order_date),
        p.product_name
),

product_analysis AS
(
    SELECT
        order_year,
        product_name,
        current_sales,

        AVG(current_sales) OVER (
            PARTITION BY product_name
        ) AS avg_sales,

        LAG(current_sales) OVER (
            PARTITION BY product_name
            ORDER BY order_year
        ) AS py_sales

    FROM yearly_product_sales
)

SELECT
    order_year,
    product_name,
    current_sales,
    avg_sales,

    current_sales - avg_sales AS diff_avg,

    CASE
        WHEN current_sales > avg_sales THEN 'Above Avg'
        WHEN current_sales < avg_sales THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,

    py_sales,

    current_sales - py_sales AS py_diff,

    CASE
        WHEN current_sales > py_sales THEN 'Increase'
        WHEN current_sales < py_sales THEN 'Decrease'
        ELSE 'No change'
    END AS py_change

FROM product_analysis
ORDER BY
    product_name,
    order_year;


-- which category contribute the most to overall sales

WITH category_sales AS
(
    SELECT
        p.category,
        SUM(s.sales_amount) AS total_sales
    FROM fact_sales AS s
    LEFT JOIN dim_products AS p
        ON s.product_key = p.product_key
    GROUP BY p.category
),

category_analysis AS
(
    SELECT
        category,
        total_sales,
        SUM(total_sales) OVER () AS overall_sales
    FROM category_sales
)

SELECT
    category,
    total_sales,
    overall_sales,
    CONCAT(
        ROUND((CAST(total_sales AS FLOAT) * 100.0) / overall_sales, 2),
        '%'
    ) AS sales_percentage
FROM category_analysis
ORDER BY total_sales DESC;


-- segment products into cost range and count how many products fall into each segment

WITH product_segment AS
(
    SELECT
        product_key,
        product_name,
        product_cost,
    CASE WHEN product_cost < 100 THEN 'Below 100'
         WHEN product_cost BETWEEN 100 AND 500 THEN '100-500'
         WHEN product_cost BETWEEN 500 AND 1000 THEN '500-1000'
         ELSE 'Above 1000'
    END AS cost_range
    FROM dim_products
) 

SELECT 
    cost_range,
    COUNT(*) AS total_products
FROM product_segment
GROUP BY cost_range
ORDER BY total_products DESC;

/* Group customers into three segments based on their spending behavior:
VIP: at least 12 months of history and spending more than 5000
Regular: at least 12 months of history but spending 5000 or less 
New: lifespan less than 12 months 
And find the total number of customers by each group */

WITH customer_spending AS
(
    SELECT 
        c.customer_key,
        SUM(s.sales_amount) AS total_spending,
        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order,
        DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS life_span
    FROM fact_sales s
    LEFT JOIN dim_customers c
        ON s.customer_key = c.customer_key
    GROUP BY c.customer_key
),

segment_wise_customer AS
(
    SELECT
        customer_key,
        total_spending,
        life_span,
        CASE WHEN life_span >= 12 AND total_spending > 5000 THEN 'VIP'
             WHEN life_span >= 12 AND total_spending <= 5000 THEN 'Regular'
             ELSE 'New'
        END AS customer_segment
    FROM customer_spending
)

SELECT
    customer_segment,
    COUNT(customer_key) AS total_customers 
FROM segment_wise_customer
GROUP BY customer_segment
ORDER BY total_customers DESC;
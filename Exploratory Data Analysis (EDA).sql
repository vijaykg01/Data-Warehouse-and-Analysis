
USE data_ware_house;

SELECT * FROM dim_customers;
SELECT * FROM dim_products;
SELECT * FROM fact_sales;

-- Explore All ONJECTS in the database
SELECT * FROM INFORMATION_SCHEMA.TABLES


-- Explore All COLUMNS in the database
SELECT * FROM INFORMATION_SCHEMA.COLUMNS;


-- find the total sales 
SELECT 
	SUM(sales_amount) AS Total_sales
FROM fact_sales;

-- find how many items are sold
SELECT 
	SUM(quantity) AS Total_quantity
FROM fact_sales;

-- find the avg of selling price
SELECT 
	AVG(price) AS Avg_price
FROM fact_sales;

-- find the total number of orders
SELECT 
	COUNT(DISTINCT order_number) AS Total_orders
FROM fact_sales;

-- find the total number of products
SELECT 
	COUNT(product_name) AS Total_products
FROM dim_products;

-- find the total number of customers
SELECT 
	COUNT(customer_key) AS Total_customers
FROM dim_customers;

-- find total number of customers that placed an order
 SELECT 
	COUNT(DISTINCT customer_key) AS Total_customers
FROM dim_customers;


-- Generate a report that shows all key matrix of the business

SELECT 'Total Sales' AS Measure_Name, SUM(sales_amount) AS Measure_Value FROM fact_sales
UNION ALL 
SELECT 'Total Quantity' AS Measure_Name, SUM(quantity) AS Measure_Value FROM fact_sales
UNION ALL
SELECT 'Avg Price' AS Measure_Name, AVG(price) AS Measure_Value FROM fact_sales
UNION ALL
SELECT 'Total Orders' AS Measure_Name, COUNT(DISTINCT order_number) AS Measure_Value FROM fact_sales
UNION ALL
SELECT 'Total Customers' AS Measure_Name, COUNT(customer_key) AS Measure_Value FROM dim_customers
UNION ALL
SELECT 'Total Products' AS Measure_Name, COUNT(product_name) AS Measure_Value FROM dim_products;


-- find total customers by countries
SELECT
	country,
	COUNT(1) AS total_customers
FROM dim_customers
GROUP BY country
ORDER BY 2 DESC;

-- total customers by gender

SELECT
	gender,
	COUNT(1) AS total_customers
FROM dim_customers
GROUP BY gender
ORDER BY 2 DESC;

-- total products by category

SELECT
	category,
	COUNT(1) AS total_products
FROM dim_products
GROUP BY category
ORDER BY 2 DESC;

-- what is the avg cost in each category

SELECT
	category,
	AVG(product_cost) AS avg_cost
FROM dim_products
GROUP BY category
ORDER BY 2 DESC;

-- find total revenue genrated by each category

SELECT
	p.category,
	SUM(s.sales_amount) AS total_revenue
FROM fact_sales s
LEFT JOIN dim_products p
	ON s.product_key = p.product_key
GROUP BY p.category
ORDER BY 2 DESC;

-- find total revenue genrated by each customer

SELECT
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(s.sales_amount) AS total_revenue
FROM fact_sales s
LEFT JOIN dim_customers c 
	ON c.customer_key = s.customer_key
GROUP BY 
	c.customer_key,
	c.first_name,
	c.last_name
ORDER BY 4 DESC;

-- what is the distribution of sold items across countries

SELECT
	c.country,
	SUM(s.quantity) AS total_sold_items
FROM fact_sales s
LEFT JOIN dim_customers c 
	ON c.customer_key = s.customer_key
GROUP BY c.country
ORDER BY 2 DESC;

-- which top 5 products generates higest revenue

SELECT TOP 5
	p.product_name,
	SUM(s.sales_amount) as total_revenue
FROM fact_sales s
LEFT JOIN dim_products p
	ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY 2 DESC;

-- or

-- which top 5 products generates higest revenue

SELECT *
FROM 
	(SELECT 
		p.product_name,
		SUM(s.sales_amount) as total_revenue,
		RANK() OVER(ORDER BY SUM(s.sales_amount) DESC) AS rank_products
	FROM fact_sales s
	LEFT JOIN dim_products p
		ON s.product_key = p.product_key
	GROUP BY p.product_name
	) t
WHERE rank_products <= 5;

-- what are the 5 worst performing products in terms of sales

SELECT TOP 5
	p.product_name,
	SUM(s.sales_amount) as total_revenue
FROM fact_sales s
LEFT JOIN dim_products p
	ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY 2;

-- or

SELECT *
FROM 
	(SELECT 
		p.product_name,
		SUM(s.sales_amount) as total_revenue,
		RANK() OVER(ORDER BY SUM(s.sales_amount) ASC) AS rank_products
	FROM fact_sales s
	LEFT JOIN dim_products p
		ON s.product_key = p.product_key
	GROUP BY p.product_name
	) t
WHERE rank_products <= 5;
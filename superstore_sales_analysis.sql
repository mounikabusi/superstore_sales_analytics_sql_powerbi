CREATE database superstore_data;
USE  superstore_data;

CREATE TABLE superstore_sales (
    order_id VARCHAR(50),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(50),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    region VARCHAR(50),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    sales DECIMAL(10,2),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,2)
);
SELECT * FROM superstore_sales;

SELECT DISTINCT category,
                sub_category
FROM superstore_sales
ORDER BY category;

SELECT COUNT(*) FROM superstore_sales;

-- customer average sales
SELECT customer_name,AVG(sales) AS average_sales FROM superstore_sales
GROUP BY customer_name
ORDER BY average_sales DESC;

-- total sales of the company
SELECT ROUND(SUM(sales)) as total_sales
FROM superstore_sales;

-- total sales by each category
SELECT category,ROUND(SUM(sales)) as category_sales 
FROM superstore_sales
GROUP BY category
ORDER BY category_sales DESC;

-- total profit by each category
SELECT category,ROUND(SUM(profit)) as category_profit 
FROM superstore_sales
GROUP BY category
ORDER BY category_profit DESC;

-- Show unique categories available in dataset.
SELECT DISTINCT(category) FROM superstore_sales; 

-- top 5 customers
SELECT customer_name,SUM(sales) AS total_sales FROM superstore_sales
GROUP BY customer_name
ORDER BY total_sales DESC LIMIT 5;

-- Which region generated highest sales
SELECT country,region,SUM(sales) AS total_sales FROM superstore_sales
GROUP BY country, region
ORDER BY total_sales DESC LIMIT 1;

-- Subcategories Making Loss
SELECT sub_category,SUM(profit) AS total_profit FROM superstore_sales
GROUP BY sub_category
HAVING SUM(profit)<0
ORDER BY total_profit;

-- statewise sales and profit
SELECT state,SUM(sales) AS total_sales,SUM(profit) AS total_profit FROM superstore_sales
GROUP BY state
ORDER BY total_profit DESC;

-- Find which ship mode generated highest sales.
SELECT ship_mode,SUM(sales) AS total_sales FROM superstore_sales
GROUP BY ship_mode
ORDER BY total_sales DESC;

-- Find total quantity sold in each category.
SELECT SUM(quantity) AS total_quantity,category FROM superstore_sales
GROUP BY category
ORDER BY total_quantity;

-- Find customers whose total sales are greater than 5000.
SELECT customer_name,
       SUM(sales) AS total_sales
FROM superstore_sales
GROUP BY customer_name
HAVING SUM(sales) >= 5000
ORDER BY total_sales DESC;

-- total sales per year
SELECT YEAR(order_date),SUM(sales) AS total_sales FROM superstore_sales
GROUP BY YEAR(order_date) 
ORDER BY total_sales DESC;

-- per month sales per year
SELECT YEAR(order_date),MONTHNAME(order_date),SUM(sales) FROM superstore_sales
GROUP BY YEAR(order_date),MONTHNAME(order_date)
ORDER BY YEAR(order_date) ;

-- average sales per year
SELECT YEAR(order_date),ROUND(AVG(sales)) AS average_sales FROM superstore_sales
GROUP BY YEAR(order_date)
ORDER BY average_sales;

-- ranking highest sales categories
SELECT 
    sub_category,
    SUM(sales) AS total_sales,
   RANK() OVER(ORDER BY  SUM(sales) DESC)AS sales_rank
FROM superstore_sales
GROUP BY sub_category;

-- sales category as per sales
SELECT 
    sub_category,
    SUM(sales) AS total_sales,
CASE
        WHEN SUM(sales) > 50000 THEN 'High'
        WHEN SUM(sales) > 20000 THEN 'Medium'
        ELSE 'Low'
    END AS sales_category
FROM superstore_sales
GROUP BY sub_category;


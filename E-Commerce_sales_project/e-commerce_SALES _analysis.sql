use Ecommerce_sales_analysis
select * from customers;
select * from order_items;
select * from orders;
select * from products;
select * from sales_cleaned;
-- check the nulls--
select 
count(*) as total_Rows,
sum(case when customer_id is null then 1 else 0 end ) as customer_id_missing,
sum(case when country is null then 1 else 0 end ) as country_missing,
sum(case when signup_date is null then 1 else 0 end) as signup_date_missing 
from customers;
-- to check the duplicate values 
select customer_id , 
count(*) as duplicate_Count 
from customers
group by customer_id
having count(*)>1;
-- orders_items , check nulls--
select 
count(*) as total_Rows,
sum(case when order_id is null then 1 else 0 end ) as order_id_missing,
sum(case when product_id is null then 1 else 0 end ) as product_id_missing,
sum(case when quantity is null then 1 else 0 end) as quantity_missing,
sum(case when price is null then 1 else 0 end) as price_missing
from order_items;
-- duplciate 
select order_id ,
count(*) as duplicate_Count 
from order_items
group by order_id
having count(*)>1;

select product_id ,
count(*) as duplicate_Count 
from order_items
group by product_id
having count(*)>1;
--orders 
-- we will only run the missing values query becuase we already checked for duplicates here order_id , customer id 
select 
count(*) as total_Rows,
sum(case when order_id is null then 1 else 0 end ) as order_id_missing,
sum(case when customer_id is null then 1 else 0 end ) as customer_id_missing,
sum(case when order_date is null then 1 else 0 end) as order_date_missing,
sum(case when status is null then 1 else 0 end) as status_missing
from orders;
-- products 
-- since we already did for product id we are going to check only the product missing values 
select 
count(*) as total_Rows,
sum(case when product_id is null then 1 else 0 end ) as product_id_missing,
sum(case when product_name is null then 1 else 0 end ) as product_name_missing,
sum(case when category is null then 1 else 0 end) as category_missing
from products;

-- sales_cleaned data we are going to only check for missing values becuase the unique values or the duplicates we already identified 

select 
count(*) as total_Rows,
sum(case when order_id is null then 1 else 0 end ) as order_id_missing,
sum(case when product_id is null then 1 else 0 end ) as product_id_missing,
sum(case when quantity is null then 1 else 0 end) as quantity_missing,
sum(case when price is null then 1 else 0 end) as missing_price,
sum(case when Revenue is null then 1 else 0 end) as missing_revenue,
sum(case when customer_id is null then 1 else 0 end) as missing_customer_id,
sum(case when order_date is null then 1 else 0 end) as missing_order_Date,
sum(case when status is null then 1 else 0 end) as missing_status,
sum(case when year is null then 1 else 0 end) as missing_year,
sum(case when month is null then 1 else 0 end) as missing_month 
from sales_cleaned;
-- data analysis
-- customers - customer distribution by country 
select country,
count(*) as total_customers
from customers
group by country 
order by total_customers desc;
-- customer signup trend 
select year(signup_date) as signup_year,
count(*) as total_customers
from customers 
group by year(signup_date)
order by signup_year;

--joins--
--inner joins-- only matching rows--
-- Customers who have orders--
SELECT c.customer_id, c.country, o.order_id, o.order_date
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

--LEFT JOIN - All customers, even without orders--
---- Find customers who never ordered (important business insight)
SELECT c.customer_id, c.country, o.order_id
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- All customers with their revenue if any--
SELECT c.customer_id, c.country, SUM(s.Revenue) AS total_revenue
FROM customers c
LEFT JOIN sales_cleaned s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.country;

--RIGHT JOIN - All orders, even with missing customers--
---- All orders + customer info (shows orphan orders if any)--
SELECT o.order_id, o.customer_id, c.country
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

--FULL OUTER JOIN - Everything from both tables--
-- Only mismatched records--
SELECT c.customer_id AS cust_id, o.order_id, o.customer_id AS order_cust_id
FROM customers c
FULL OUTER JOIN orders o ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL OR o.order_id IS NULL;

--CROSS JOIN - Cartesian product (Products x Categories)--
---- Generate all possible combinations for discount testing--
SELECT c.country, p.category
FROM (SELECT DISTINCT country FROM customers) c
CROSS JOIN (SELECT DISTINCT category FROM products) p
ORDER BY c.country, p.category;

--SELF JOIN - Join table to itself--
---- Find customers from same country--

SELECT c1.customer_id AS customer1, c2.customer_id AS customer2, c1.country
FROM customers c1
INNER JOIN customers c2 ON c1.country = c2.country AND c1.customer_id < c2.customer_id
ORDER BY c1.country;

-- Orders on same date--
SELECT o1.order_id AS order1, o2.order_id AS order2, o1.order_date
FROM orders o1
JOIN orders o2 ON o1.order_date = o2.order_date AND o1.order_id < o2.order_id;

-- using joins how we can do analysis and use aggrgate functions
-- how many orders has each customer placed 
select c.customer_id,
c.country,
count(o.order_id) as total_orders
from customers as c 
left join orders as o 
on c.customer_id=o.customer_id
group by 
c.customer_id,
c.country
order by total_orders desc;
-- if we want to join we can join the customers table column customer id with the sales cleaned column customer id 
-- we can join ordeer_items and orders tables based on order id 
-- we can also join products table with order_items and products tables on basis of product id column 
-- in general data cleaning is not in sql it is done in excel or python becuase in sql data cleaning is little bit tough sql is mainly for data manipulation and analysis 
-- customers table data cleaning 
-- missing values 
-- duplicates 
-- how to see missing values in customers table 
-- case is the conditional statemnt 
-- A. Check for NULLS
SELECT * FROM customers WHERE customer_id IS NULL OR country IS NULL OR signup_date IS NULL;
SELECT * FROM orders WHERE order_id IS NULL OR customer_id IS NULL;
SELECT * FROM order_items WHERE quantity IS NULL OR price IS NULL;
SELECT * FROM products WHERE product_name IS NULL;

-- Data Standardization (TRIM, UPPER)
UPDATE customers SET country = TRIM(country);
UPDATE orders SET status = TRIM(status);

-- Invalid Data Check - Quantity and Price should be > 0
SELECT * FROM order_items WHERE quantity <= 0 OR price <= 0;

-- Date Integrity - Order should be after Signup
SELECT o.order_id, c.customer_id, c.signup_date, o.order_date
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_date < c.signup_date;

-- sales_cleaned table is already cleaned: Only Completed orders (1625 rows)
-- Original orders had 1000 orders (805 Completed, 103 Cancelled, 92 Returned)
-- And 2000 order_items. So 375 items were from Cancelled/Returned orders and were removed.


-- Indexing for JOINs and filtering
CREATE INDEX idx_order_customer ON orders(customer_id);
CREATE INDEX idx_order_dates ON orders(order_date);
CREATE INDEX idx_orders_items_orders ON order_items(order_id);
CREATE INDEX idx_orders_items_products ON order_items(product_id);
CREATE INDEX idx_sales_customers_dates ON sales_cleaned(customer_id, order_date);
CREATE INDEX idx_sales_products ON sales_cleaned(product_id);
CREATE INDEX idx_customer_countries ON customers(country);
CREATE INDEX idx_product_categories ON products(category);

-- Composite index for heavy queries
CREATE INDEX idx_sale_year_month ON sales_cleaned(year, month, customer_id);

-- operators--
--Arithmetic, Logical, Comparison, LIKE, IN, BETWEEN
--  Arithmetic + Comparison Operator: High value orders
select order_id,cast(quantity as bigint) * price as revenue , quantity , price 
from order_items where cast(quantity as bigint) * price>200;

-- Logical + IN + BETWEEN + LIKE Operator
SELECT c.customer_id, c.country, o.order_id, o.status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE c.country IN ('Spain', 'Italy', 'France')
  AND o.order_date BETWEEN '2024-01-01' AND '2024-06-30'
  AND o.status LIKE 'Comp%'
  AND NOT (c.country = 'France' AND o.status = 'Cancelled');

--  Operators on sales_cleaned
SELECT * FROM sales_cleaned
WHERE Revenue >= 100 AND Revenue <= 500
  AND month IN (8,9,10) AND year = 2024;

-- Clauses--
--WHERE, GROUP BY, HAVING, ORDER BY, DISTINCT---
-- -- GROUP BY + HAVING: Top categories
SELECT p.category, COUNT(*) AS total_orders, SUM(s.Revenue) AS total_revenue
FROM sales_cleaned s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
HAVING SUM(s.Revenue) > 10000
ORDER BY total_revenue DESC;

-- DISTINCT + GROUP BY: Monthly sales by country
SELECT TOP 20 c.country, s.year, s.month, 
       SUM(s.Revenue) AS monthly_revenue,
       COUNT(DISTINCT s.customer_id) AS unique_customers
FROM sales_cleaned s
JOIN customers c ON s.customer_id = c.customer_id
WHERE s.status = 'Completed'
GROUP BY c.country, s.year, s.month
ORDER BY c.country, s.year, s.month DESC;

--Windows functions--
--ROW_NUMBER, RANK, SUM, LAG, AVG--
-- A. ROW_NUMBER, RANK, DENSE_RANK: Rank customers by revenue
SELECT customer_id, total_revenue,
       ROW_NUMBER() OVER (ORDER BY total_revenue DESC) AS row_num,
       RANK() OVER (ORDER BY total_revenue DESC) AS rank_num,
       DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS dense_rank_num
FROM (
  SELECT customer_id, SUM(Revenue) AS total_revenue
  FROM sales_cleaned GROUP BY customer_id
) t;

--  PARTITION BY: Revenue running total per country
SELECT c.country, s.order_date, s.Revenue,
       SUM(s.Revenue) OVER (PARTITION BY c.country ORDER BY s.order_date) AS running_total_country,
       AVG(s.Revenue) OVER (PARTITION BY c.country) AS avg_country,
       ROW_NUMBER() OVER (PARTITION BY c.country ORDER BY s.Revenue DESC) AS rank_in_country
FROM sales_cleaned s
JOIN customers c ON s.customer_id = c.customer_id;

--  LAG / LEAD: MoM Growth
SELECT year, month, SUM(Revenue) AS monthly_revenue,
       LAG(SUM(Revenue), 1) OVER (ORDER BY year, month) AS prev_month_rev,
       SUM(Revenue) - LAG(SUM(Revenue),1) OVER (ORDER BY year, month) AS growth,
       ROUND( (SUM(Revenue) - LAG(SUM(Revenue),1) OVER (ORDER BY year, month)) * 100.0 / LAG(SUM(Revenue),1) OVER (ORDER BY year, month), 2) AS growth_pct
FROM sales_cleaned
GROUP BY year, month
ORDER BY year, month;

--  NTILE + Cumulative Distribution
SELECT product_id, SUM(Revenue) AS product_rev,
       NTILE(4) OVER (ORDER BY SUM(Revenue) DESC) AS quartile,
       CUME_DIST() OVER (ORDER BY SUM(Revenue) DESC) AS cume_dist
FROM sales_cleaned GROUP BY product_id;

-- Subqueries (Scalar, Correlated, IN, EXISTS)--
---- Scalar Subquery: Orders above average revenue--

SELECT order_id, Revenue
FROM sales_cleaned
WHERE Revenue > (SELECT AVG(Revenue) FROM sales_cleaned);

-- IN Subquery: Customers who bought 'Body' category--
SELECT DISTINCT customer_id FROM sales_cleaned
WHERE product_id IN (SELECT product_id FROM products WHERE category = 'Body');

--  Correlated Subquery: Top product per customer
SELECT s1.customer_id, s1.product_id, s1.Revenue
FROM sales_cleaned s1
WHERE s1.Revenue = (SELECT MAX(s2.Revenue) FROM sales_cleaned s2 
  WHERE s2.customer_id = s1.customer_id);

--  EXISTS + Derived Table Subquery
SELECT c.customer_id, c.country
FROM customers c
WHERE EXISTS (
  SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id AND o.status = 'Completed')
AND c.customer_id IN (SELECT customer_id FROM sales_cleaned 
  GROUP BY customer_id HAVING SUM(Revenue) > 1000);

-- FROM Subquery: Complex Analysis--
SELECT country, AVG(customer_total) AS avg_customer_value
FROM (
  SELECT c.country, s.customer_id, SUM(s.Revenue) AS customer_total
  FROM sales_cleaned s JOIN customers c ON s.customer_id=c.customer_id
  GROUP BY c.country, s.customer_id
) t
GROUP BY country;

-- SQL BASIC ANALYSIS — JOINS & AGGREGATE FUNCTIONS
-- Dataset: customers, orders, order_items, products, sales_cleaned

--  Overall totals (aggregate functions: COUNT, SUM, AVG)

SELECT COUNT(DISTINCT order_id) AS total_orders,
       SUM(Revenue)             AS total_revenue,
       ROUND(AVG(Revenue), 2)   AS avg_line_revenue
FROM sales_cleaned;

--  Revenue & units sold by product category
--    JOIN: order_items -> products
SELECT p.category,
       SUM(oi.quantity)             AS units_sold,
       SUM(CAST(quantity AS DECIMAL(18,2)) * CAST(price AS DECIMAL(18,2)))  AS revenue
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;

--  Top 5 products by revenue
SELECT Top 5 p.product_name, p.category,
       SUM(CAST(quantity AS DECIMAL(18,2)) * CAST(price AS DECIMAL(18,2))) AS revenue,
       SUM(oi.quantity)            AS units
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.product_name , p.category
ORDER BY revenue DESC;

-- Revenue & order count by country
--    JOIN: customers -> orders -> order_items (3-table join)
SELECT c.country,
       COUNT(DISTINCT o.order_id)   AS orders,
       SUM(CAST(quantity AS DECIMAL(18,2)) * CAST(price AS DECIMAL(18,2)))  AS revenue
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id
JOIN order_items oi  ON oi.order_id  = o.order_id
GROUP BY c.country
ORDER BY revenue DESC;

-- Order status breakdown
SELECT status, COUNT(*) AS num_orders
FROM orders
GROUP BY status
ORDER BY num_orders DESC;

-- Monthly revenue trend (2024)
SELECT year, month, SUM(Revenue) AS revenue
FROM sales_cleaned
GROUP BY year, month
ORDER BY year, month;

-- Top 5 customers by total spend
SELECT Top 5 c.customer_id, c.country,
       SUM(s.Revenue)              AS total_spend,
       COUNT(DISTINCT s.order_id)  AS num_orders
FROM sales_cleaned s
JOIN customers c ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c. country
ORDER BY total_spend DESC;

-- Order value distribution (MIN / AVG / MAX using a subquery)
SELECT 
    MIN(order_total) AS min_order,
    ROUND(AVG(order_total), 2) AS avg_order,
    MAX(order_total) AS max_order
FROM (
    SELECT 
        order_id,
        SUM(CAST(quantity AS DECIMAL(18,2)) * CAST(price AS DECIMAL(18,2))) AS order_total
    FROM order_items
    GROUP BY order_id
) AS order_values;

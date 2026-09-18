use [Marketing analysis]
select * from Car_sales_data;
-- ARITHMETIC: +, -, *, /, %
SELECT Customer_Name, Price, Price * 0.18 AS GST, Price + 1000 AS price_with_fee
FROM Car_sales_data;

-- LOGICAL OPERATORS: AND, OR, NOT, IN, BETWEEN, LIKE
SELECT * FROM Car_sales_data WHERE Company IN ('Ford', 'Toyota', 'BMW') AND Price BETWEEN 20000 AND 40000;
SELECT * FROM Car_sales_data WHERE Dealer_Name LIKE '%Motors%' AND NOT Transmission = 'Manual';
SELECT * FROM Car_sales_data WHERE Color = 'Black' OR Color = 'Red';
--clause--
-- WHERE
SELECT * FROM Car_sales_data WHERE Company = 'Ford' AND Price > 25000;

-- GROUP BY + ORDER BY
SELECT Company, COUNT(*) AS total_cars, AVG(Price) AS avg_price
FROM Car_sales_data
GROUP BY Company
ORDER BY avg_price DESC;

-- HAVING (filter after GROUP BY)
SELECT Company, COUNT(*) AS total_cars
FROM Car_sales_data
GROUP BY Company
HAVING COUNT(*) > 1000;

-- Combined---
SELECT Dealer_Region, Body_Style, AVG(Price) as avg_price
FROM Car_sales_data
WHERE Transmission = 'Auto'
GROUP BY Dealer_Region, Body_Style
HAVING AVG(Price) > 20000
ORDER BY Dealer_Region;

-- ACID properties--
-- Full transaction or nothing. e.g., money deducted + car sold must both happen.--
-- Data always valid after transaction.--
-- Two dealers selling same car at same time won't conflict.--
-- Once sale saved, stays even if power fails.--

START TRANSACTION;
UPDATE Car_sales_data SET Price = Price - 1000 WHERE Car_id = 'C_CND_000001';
-- if error then ROLLBACK else COMMIT;
COMMIT;
-- data cleaning--
-- Remove unwanted characters
UPDATE Car_sales_data SET Engine = REPLACE(Engine, 'Â', '');

-- TRIM spaces
UPDATE Car_sales_data SET Dealer_Name = TRIM(Dealer_Name);
UPDATE Car_sales_data SET Color = TRIM(Color);

-- Standardize Date
-- For MySQL: STR_TO_DATE(Date, '%m/%d/%Y')

-- Handle nulls / duplicates
SELECT * FROM Car_sales_data WHERE Customer_Name IS NULL;
SELECT Car_id, COUNT(*) FROM Car_sales_data GROUP BY Car_id HAVING COUNT(*) > 1;

-- Fix Gender mismatch (Data Cleaning example)
SELECT Customer_Name, Gender FROM Car_sales_data WHERE Customer_Name IN ('Geraldine', 'Gia', 'Gianna');
-- UPDATE car_sales SET Gender = 'Female' WHERE Customer_Name LIKE '%ine';

-- DATA EXTRACTION--
-- Basic extraction
SELECT Customer_Name, Company, Model, Price FROM Car_sales_data;

-- DISTINCT
SELECT DISTINCT Company FROM Car_sales_data;
SELECT DISTINCT Body_Style, Transmission FROM Car_sales_data;

-- TOP / LIMIT
SELECT top 10 * FROM Car_sales_data ORDER BY Price DESC;
-- Pattern extraction--
SELECT * FROM Car_sales_data WHERE Model LIKE 'E%'; 
-- starts with E

-- Sub quaries & Nested quaries--
-- SUBQUERY in WHERE
SELECT * FROM Car_sales_data 
WHERE Price > (SELECT AVG(Price) FROM Car_sales_data);

-- NESTED / Subquery in FROM
SELECT Company, avg_price FROM (
    SELECT Company, AVG(Price) AS avg_price FROM Car_sales_data GROUP BY Company
) AS company_avg WHERE avg_price > 30000;

-- Subquery with IN
SELECT * FROM Car_sales_data 
WHERE Dealer_Region IN (
    SELECT Dealer_Region FROM Car_sales_data GROUP BY Dealer_Region HAVING COUNT(*) > 100
);

-- Correlated Subquery
SELECT c1.Customer_Name, c1.Company, c1.Price
FROM Car_sales_data c1
WHERE c1.Price = (SELECT MAX(Price) FROM Car_sales_data c2 WHERE c2.Company = c1.Company);

--Functions--
-- STRING
SELECT Customer_Name, UPPER(Customer_Name), LOWER(Company), LEN(Model) FROM Car_sales_data ;

-- NUMERIC
SELECT Price, ROUND(Price/1000, 1) AS price_k, CEILING(Annual_Income/10000) FROM Car_sales_data ;

-- DATE
SELECT Date, YEAR(Date), MONTH(Date) FROM Car_sales_data ;

-- AGGREGATE
SELECT 
    COUNT(*) AS total,
    SUM(Price) AS total_revenue,
    AVG(Price) AS avg_price,
    MIN(Price) AS min_price,
    MAX(Price) AS max_price
FROM Car_sales_data;

-- Normalization check (1NF, 2NF, 3NF)
-- Your table is NOT normalized. For 3NF we should split:
-- Table1: Customers(Cust_ID, Name, Gender, Income)
-- Table2: Dealers(Dealer_No, Dealer_Name, Region)
-- Table3: Cars(Car_id, Company, Model, Engine, Body_Style)
-- Table4: Sales(Sale_ID, Car_id, Cust_ID, Dealer_No, Date, Price)

-- IF & CASE statement
-- IF (MySQL) / IIF (SQL Server)

select customer_name ,price, case when price>50000 then 'luxury ' else 'budget' end as catgeory from Car_sales_data;

-- CASE - Most important
SELECT 
    Customer_Name,
    Price,
    Annual_Income,
    CASE 
        WHEN Price > 80000 THEN 'Super Luxury'
        WHEN Price > 40000 THEN 'Luxury'
        WHEN Price > 20000 THEN 'Mid Range'
        ELSE 'Economy'
    END AS Price_Segment,
    CASE
        WHEN Annual_Income > 1000000 THEN 'High Income'
        WHEN Annual_Income > 100000 THEN 'Middle Income'
        ELSE 'Low Income'
    END AS Income_Group
FROM Car_sales_data;

-- CASE with GROUP BY
SELECT 
    CASE WHEN Transmission = 'Auto' THEN 'Automatic' ELSE 'Manual' END AS Trans_Type,
    COUNT(*) AS total_sales,
    AVG(Price) AS avg_price
FROM Car_sales_data
GROUP BY Transmission;

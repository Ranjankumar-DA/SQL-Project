use finance;
SELECT * FROM finance_dataset;
--DATA CLEANING
SELECT
SUM(CASE when transaction_id is null then 1 else 0 end) as transaction_id_missing,
SUM(CASE when date is null then 1 else 0 end) as date_missing,
SUM(CASE when vendor is null then 1 else 0 end) as vendor_missing,
SUM(CASE when amount is null then 1 else 0 end) as amount_missing
FROM finance_dataset;

--ALTER + UPDATE
--Add a column risk_level and update
ALTER TABLE finance_dataset add risk_level varchar(20);
SELECT * FROM finance_dataset;

-- if amount > 100 then 'High', if >500 then 'Medium' else 'Low'. (Use CASE)
UPDATE finance_dataset set risk_level =
CASE 
  WHEN amount >100 THEN 'High'
  WHEN amount >500 THEN 'Medium'
  ELSE 'Low'
END;
--CHECK STATEMENT
SELECT amount,risk_level FROM finance_dataset ORDER BY amount desc;

--TRIM space
--Remove extra spaces from vendor and category columns using LTRIM and RTRIM
SELECT TRIM(vendor) as clean_vendor,
TRIM(category) as clean_category FROM finance_dataset;

UPDATE finance_dataset set vendor =TRIM(vendor);
UPDATE finance_dataset set category =TRIM(category);

--AGGREGATE FUNCTION(SUM,AVG.MAX.MIN,COUNT)
---- Total, Average, Count of each Account-
SELECT account,
COUNT(*) AS total_count,
SUM(amount) AS total_amount,
AVG(amount) AS avg_amount,
MAX(amount) AS max_amount,
MIN(amount) AS min_amount
FROM finance_dataset
GROUP BY account;

---- Total Revenue vs Expense
SELECT SUM(amount) as total_revenue
FROM finance_dataset WHERE account = 'Revenue';

--OPERATORS(- =, >, <, AND, OR, BETWEEN, IN, LIKE)
SELECT * FROM finance_dataset where amount >500 AND payment_method='Credit Card';
SELECT * FROM finance_dataset where account ='Expense' AND amount >400;
SELECT top 10 * FROM finance_dataset where payment_method ='Cash' OR payment_method ='Bank Transfer';
SELECT top 5 * FROM finance_dataset where vendor IN ('FoodExpress','CloudSoft') AND 
amount BETWEEN 50 AND 300;
SELECT * FROM finance_dataset where vendor NOT LIKE '%logiTrans%';

--CLAUSE(WHERE,ORDER BY ,GROUP BY,HAVING,DISTINCT)
--WHERE
SELECT * FROM finance_dataset WHERE is_fraud =0;
SELECT * FROM finance_dataset where payment_method ='Credit Card' AND amount <30;
SELECT DISTINCT payment_method FROM finance_dataset;

--ORDER BY
--Show all transactions ordered by date newest first.
SELECT top 10 * FROM finance_dataset ORDER BY transaction_id asc;

--GROUP BY + ORDER BY
--Find total amount for each account
SELECT SUM(amount) as total_amount,
COUNT(*) AS total_transactions FROM finance_dataset
GROUP BY account
ORDER BY total_amount;

--HAVING
--Find categories where total amount > 5000.
SELECT category,
SUM(amount) as total_amount, 
COUNT(*) as total_count FROM finance_dataset 
GROUP BY category
HAVING sum(amount) >5000
ORDER BY total_amount desc;

--SUBQuery
--Find transactions whose amount is greater than the average amount of all transactions.
SELECT transaction_id,vendor,amount FROM finance_dataset
WHERE amount > (SELECT AVG(amount) FROM finance_dataset)
ORDER BY amount desc;

--Subquery with IN
-- Find all transactions of vendors who have at least one fraud case.
SELECT * FROM finance_dataset
WHERE vendor IN (SELECT DISTINCT vendor FROM finance_dataset where is_fraud =1)
ORDER BY vendor;

SELECT DISTINCT vendor FROM finance_dataset WHERE vendor NOT IN (
SELECT DISTINCT vendor FROM finance_dataset WHERE is_fraud =1
);

SELECT * FROM finance_dataset WHERE amount = (SELECT MAX(amount) FROM finance_dataset
);

--Subquerry(with clause and aggreagte function)
--Find categories whose average is greater than the overall average.
SELECT category,AVG(amount) as avg_cat FROM finance_dataset
GROUP BY category
HAVING AVG(amount) > (SELECT AVG(amount) FROM finance_dataset)
ORDER BY avg_cat desc;

-- Correlated Subquery
--Find transactions where amount is greater than the average amount of its own category.
SELECT f1.transaction_id, f1.vendor, f1.category, f1.amount
FROM finance_dataset f1
WHERE f1.amount > (SELECT AVG(f2.amount) FROM finance_dataset f2 WHERE f2.category = f1.category)
ORDER BY f1.category,f1.amount desc;

-- WINDOW FUNCTION
--Calculate running total of amount ordered by date using SUM() OVER(ORDER BY date)
SELECT transaction_id, amount,
SUM(amount) over(ORDER BY transaction_id) as running_total
FROM finance_dataset;

--PARTITION BY(its like a group by )
--SUM,AVG,COUNT,MAX,MIN
SELECT top 10 category,amount,
SUM(amount) OVER(PARTITION BY category) as total_category,
AVG(amount) OVER(PARTITION BY category) as avg_category,
MAX(amount) OVER(PARTITION BY category) as max_category,
MIN(amount) OVER(PARTITION BY category) as min_category,
COUNT(*) OVER(PARTITION BY category) as count_category
FROM finance_dataset
ORDER BY amount desc;

--ROW_NUMBER()
SELECT vendor,amount,ROW_NUMBER() OVER(ORDER BY amount desc) as row_num
FROM finance_dataset;

--RANK()
--if the values are same it skips the next value and assigns the same rank to the value 
SELECT vendor,amount,RANK() OVER(ORDER BY amount desc) as rank_amount
FROM finance_dataset;

--DENSE_RANK()
--dense rank dont skip the next rank it assigns the next rank to the value 
SELECT vendor,amount,DENSE_RANK() OVER(ORDER BY amount desc) as rank_amount
FROM finance_dataset;

--LAG()
-- Access of previous row 
SELECT transaction_id,amount,
LAG(amount) OVER(ORDER BY transaction_id) as previous_row_amount
FROM finance_dataset;

--LEAD()
--Access to the next row
SELECT transaction_id,amount,
LEAD(amount) OVER(ORDER BY transaction_id) as next_row_amount
FROM finance_dataset;

--VIEW/INDEXING/CTE
--VIEW(to save the data)
CREATE VIEW high_value_tx as 
SELECT * FROM finance_dataset WHERE amount >200;

SELECT * FROM high_value_tx WHERE category='Travel';

--VIEW WITH Aggerage + GROUP BY 
create view category_summary as
SELECT category,
SUM(amount) as total_amount,
AVG(amount) as avg_amount,
MAX(amount) as max_amount,
COUNT(*) as total_count
FROM finance_dataset
GROUP BY category;

--window function + rank()
create view ranked_expense as 
SELECT category,vendor,amount,
RANK() OVER(PARTITION BY category ORDER BY amount desc) as rank_in_category
FROM finance_dataset;

SELECT * FROM ranked_expense
ORDER BY amount desc;

--INDEXING
CREATE INDEX idx_category ON finance_dataset(category);
SELECT * FROM finance_dataset WHERE category = 'IT Services';

--CTE(comman table express)
--it is a temproary named table result that set  makes complicated query easy to read

--Using CTE, find top 3 vendors with highest total fraud amount.
WITH fraud_total as(
SELECT  top 3 vendor, SUM(amount) as total_fraud FROM finance_dataset
WHERE is_fraud =1 
GROUP BY vendor)
SELECT vendor, total_fraud FROM fraud_total
ORDER BY total_fraud desc;










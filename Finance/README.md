# Finance Data Analysis Using SQL

## Project Overview

This project focuses on analyzing financial transaction data using SQL. The database is named `finance`, and the primary table used for analysis is `finance_dataset`.

The project demonstrates how SQL can be used to clean, transform, analyze, and extract meaningful insights from financial transaction data. The analysis covers transaction amounts, accounts, vendors, categories, payment methods, fraud indicators, and transaction risk levels.

The project also demonstrates intermediate and advanced SQL concepts, including aggregate functions, filtering, grouping, subqueries, correlated subqueries, window functions, views, indexing, and Common Table Expressions (CTEs).

## Dataset Description

The `finance_dataset` table contains financial transaction records. Each record represents a transaction and includes information related to the transaction, vendor, financial amount, category, payment method, account type, and fraud status.

The major fields identified in the SQL analysis include:

| Column           | Description                                                                  |
| ---------------- | ---------------------------------------------------------------------------- |
| `transaction_id` | Unique identifier for each financial transaction                             |
| `date`           | Date associated with the transaction                                         |
| `vendor`         | Name of the vendor associated with the transaction                           |
| `amount`         | Monetary value of the transaction                                            |
| `account`        | Account classification, such as Revenue or Expense                           |
| `category`       | Category associated with the transaction                                     |
| `payment_method` | Method used to make the payment, such as Credit Card, Cash, or Bank Transfer |
| `is_fraud`       | Indicator used to identify whether a transaction is associated with fraud    |

## Data Cleaning

The project begins with data-quality checks to identify missing values in important fields.

The following columns are checked for NULL values:

* Transaction ID
* Date
* Vendor
* Amount

The project also uses `TRIM()` to remove unnecessary spaces from the `vendor` and `category` columns.

These cleaning operations help improve data consistency and prepare the dataset for reliable analysis.

## Risk Level Classification

A new column called `risk_level` is added to the dataset.

A SQL `CASE` statement is used to classify transactions according to their transaction amount.

The project demonstrates how business rules can be implemented directly within SQL to create additional analytical fields.

## Financial Analysis

Aggregate functions are used to analyze financial transactions by account.

The project calculates:

* Total number of transactions
* Total transaction amount
* Average transaction amount
* Maximum transaction amount
* Minimum transaction amount

These metrics provide an overview of financial activity across different account types.

## Revenue and Expense Analysis

The project separates transactions based on account classification.

For example, transactions belonging to the `Revenue` account are analyzed to calculate total revenue.

Expense transactions can also be filtered based on transaction amount to identify higher-value expenses.

This provides a basic view of the relationship between revenue and expenditure activity.

## Payment Method Analysis

The project analyzes transactions according to payment method.

Payment methods examined include:

* Credit Card
* Cash
* Bank Transfer

SQL filtering conditions are used to identify transactions based on specific payment methods and transaction amounts.

## Vendor Analysis

Vendor-level analysis is performed to identify transactions associated with specific vendors.

The project uses operators such as:

* `IN`
* `NOT IN`
* `LIKE`
* `NOT LIKE`

This allows specific vendors to be included, excluded, or searched using pattern matching.

## Category Analysis

Transaction categories are grouped to calculate:

* Total transaction amount
* Number of transactions
* Average transaction amount
* Maximum transaction amount
* Minimum transaction amount

The `HAVING` clause is used to identify categories whose total transaction amount exceeds a specified threshold.

This helps identify categories with significant financial activity.

## Fraud Analysis

Fraud detection is an important part of the project.

The `is_fraud` field is used to identify fraudulent transactions.

The analysis includes:

* Identifying fraudulent transactions
* Finding vendors associated with fraud cases
* Identifying vendors with no recorded fraud cases
* Calculating total fraud amounts by vendor
* Ranking vendors based on fraud-related transaction amounts

This provides a foundation for identifying potentially high-risk vendors and transactions.

## Subquery Analysis

The project uses SQL subqueries to perform more advanced financial analysis.

Examples include:

* Finding transactions whose amount is greater than the overall average transaction amount
* Finding transactions associated with vendors that have at least one fraud case
* Finding transactions with the maximum transaction amount
* Finding categories whose average transaction amount is greater than the overall average

Subqueries allow the analysis to compare individual transactions and groups against calculated benchmark values.

## Correlated Subquery

A correlated subquery is used to identify transactions whose amount is greater than the average transaction amount within their own category.

This provides a more detailed way of identifying unusually high-value transactions relative to their category.

## Window Functions

Several SQL window functions are demonstrated in the project.

### Running Total

`SUM() OVER(ORDER BY ...)` is used to calculate a running total of transaction amounts.

This can help analyze the cumulative financial value of transactions.

### Partitioned Analysis

`PARTITION BY` is used to calculate category-level metrics while retaining individual transaction records.

The project calculates:

* Total amount by category
* Average amount by category
* Maximum amount by category
* Minimum amount by category
* Transaction count by category

## Ranking Functions

The project demonstrates three important ranking functions:

### ROW_NUMBER()

Assigns a unique sequential number to each transaction based on transaction amount.

### RANK()

Ranks transactions according to their amounts. Transactions with the same amount receive the same rank, and subsequent ranks may be skipped.

### DENSE_RANK()

Ranks transactions while ensuring that ranking numbers are not skipped when duplicate values occur.

These functions can be useful for identifying high-value transactions and ranking vendors or financial activities.

## LAG and LEAD Functions

The project uses:

`LAG()` to access the amount from the previous transaction.

`LEAD()` to access the amount from the following transaction.

These functions can be useful for comparing transaction values across sequential records.

## Views

Multiple SQL views are created to simplify repeated analysis.

### High Value Transactions

The `high_value_tx` view stores transactions where the transaction amount exceeds a defined threshold.

### Category Summary

The `category_summary` view provides summarized information for each transaction category, including:

* Total amount
* Average amount
* Maximum amount
* Transaction count

### Ranked Expenses

The `ranked_expense` view ranks transactions within each category based on transaction amount.

Views make frequently used analytical queries easier to access and reuse.

## Indexing

An index is created on the `category` column.

The purpose of the index is to improve the efficiency of queries that frequently filter or search transactions by category.

## Common Table Expression

A Common Table Expression, or CTE, is used to simplify complex queries.

The project uses a CTE to identify the top vendors based on their total fraudulent transaction amount.

This approach makes complex SQL queries more readable and easier to maintain.

## SQL Concepts Used

This project demonstrates the following SQL concepts:

* SELECT
* WHERE
* DISTINCT
* ORDER BY
* GROUP BY
* HAVING
* AND / OR
* IN / NOT IN
* BETWEEN
* LIKE / NOT LIKE
* Aggregate Functions
* CASE Statements
* Data Cleaning
* Subqueries
* Correlated Subqueries
* Window Functions
* PARTITION BY
* ROW_NUMBER()
* RANK()
* DENSE_RANK()
* LAG()
* LEAD()
* Views
* Indexing
* Common Table Expressions
* Fraud Analysis
* Financial Risk Classification

## Business Questions Explored

The project can help answer several important financial questions:

* What is the total transaction amount for each account?
* What is the average transaction amount?
* Which categories have the highest transaction values?
* Which transactions have amounts above the overall average?
* Which vendors are associated with fraudulent transactions?
* Which vendors have the highest total fraud amount?
* Which categories have transaction amounts above the overall category average?
* Which transactions are unusually high compared with their category?
* What are the highest-value transactions?
* How do transaction amounts vary across payment methods?
* What are the cumulative transaction amounts over time?
* How can transactions be classified according to risk level?

## Project Objective

The primary objective of this project is to demonstrate practical SQL skills through financial transaction analysis.

The project focuses on transforming raw financial transaction data into meaningful information that can support:

* Financial reporting
* Expense analysis
* Revenue analysis
* Vendor analysis
* Fraud detection
* Risk classification
* Transaction monitoring
* Business decision-making

## Key Skills Demonstrated

This project demonstrates practical experience with SQL-based data analysis, including data cleaning, exploratory analysis, financial aggregation, fraud analysis, advanced filtering, subqueries, window functions, ranking, views, indexing, and CTEs.

It is designed as a portfolio project to demonstrate the ability to work with financial datasets and apply SQL techniques to solve real-world analytical problems.

## Conclusion

This Finance Transaction Analysis project demonstrates how SQL can be used to transform financial transaction data into meaningful business insights. The project covered the complete analytical process, starting with data-quality checks and cleaning and progressing to financial analysis, fraud detection, risk classification, and advanced SQL analysis.

# Car Sales Data Analysis Using SQL

## Project Overview

This project focuses on analyzing a car sales dataset using SQL. The database is named `Marketing analysis`, and the main table used for analysis is `Car_sales_data`.

The purpose of this project is to demonstrate SQL skills for extracting, cleaning, filtering, grouping, and analyzing car sales information. The analysis covers customer information, vehicle details, dealer information, pricing, customer income, transmission type, body style, and regional sales data.

The project also demonstrates the use of SQL operators, aggregate functions, subqueries, CASE statements, transactions, data-cleaning techniques, and normalization concepts.

## Dataset Description

The `Car_sales_data` table contains information related to customers, vehicles, dealers, and individual car sales transactions.

The main fields identified in the dataset are:

| Column          | Description                                                    |
| --------------- | -------------------------------------------------------------- |
| `Car_id`        | Unique identification number assigned to a car or sales record |
| `Date`          | Date on which the car sale was recorded                        |
| `Customer_Name` | Name of the customer who purchased the vehicle                 |
| `Gender`        | Gender information of the customer                             |
| `Annual_Income` | Annual income of the customer                                  |
| `Company`       | Manufacturer or brand of the vehicle                           |
| `Model`         | Model name of the vehicle                                      |
| `Engine`        | Engine specification or engine-related information             |
| `Transmission`  | Transmission type of the vehicle, such as Automatic or Manual  |
| `Color`         | Color of the vehicle                                           |
| `Body_Style`    | Body style of the vehicle                                      |
| `Price`         | Selling price of the vehicle                                   |
| `Dealer_Name`   | Name of the dealer responsible for the sale                    |
| `Dealer_No`     | Dealer identification number                                   |
| `Dealer_Region` | Region in which the dealer operates                            |

## SQL Concepts Used

This project demonstrates several SQL concepts and techniques, including:

* SELECT statements and data extraction
* WHERE clause
* Arithmetic operators
* Logical operators such as `AND`, `OR`, `NOT`, `IN`, `BETWEEN`, and `LIKE`
* DISTINCT values
* GROUP BY
* ORDER BY
* HAVING clause
* Aggregate functions
* String functions
* Numeric functions
* Date functions
* CASE statements
* Subqueries
* Nested queries
* Correlated subqueries
* Transactions
* Data cleaning
* Duplicate detection
* NULL value identification
* Data standardization
* Database normalization concepts

## Data Cleaning

Several data-cleaning operations are included in the SQL project.

Examples include:

* Removing unwanted characters from the `Engine` column
* Removing unnecessary spaces from dealer names
* Trimming spaces from vehicle colors
* Checking for missing customer names
* Identifying duplicate `Car_id` values
* Checking gender inconsistencies
* Reviewing date standardization requirements

These steps help improve data quality before performing analysis.

## Sales Analysis

The project analyzes several important areas of the car sales data.

### Company-Wise Sales Analysis

Cars are grouped by company to calculate:

* Total number of cars sold
* Average selling price
* Companies with large numbers of sales

This helps compare the sales activity of different automobile manufacturers.

### Price Analysis

SQL aggregate functions are used to calculate:

* Total sales revenue
* Average car price
* Minimum car price
* Maximum car price

Cars are also classified into different pricing categories using CASE statements.

The categories used in the project include:

* Economy
* Mid Range
* Luxury
* Super Luxury

### Customer Income Analysis

Customer annual income is analyzed and classified into income groups.

The project uses categories such as:

* Low Income
* Middle Income
* High Income

This can help study the relationship between customer income and vehicle purchasing behavior.

### Transmission Analysis

The dataset contains different transmission types, including Automatic and Manual vehicles.

The analysis calculates:

* Total sales by transmission type
* Average vehicle price by transmission type

### Dealer and Regional Analysis

The project analyzes dealer information and sales regions.

Dealer-related analysis includes:

* Dealer name
* Dealer region
* Vehicle body style
* Average vehicle price
* Sales volume by region

This can help identify differences in sales patterns across dealer locations.

### Vehicle Analysis

Vehicle characteristics analyzed in the project include:

* Manufacturer
* Model
* Engine
* Transmission
* Color
* Body style
* Price

The project also searches for specific vehicle models using pattern matching.

## Aggregate Functions Used

The following aggregate functions are demonstrated:

`COUNT()` – Calculates the total number of records.

`SUM()` – Calculates total sales revenue.

`AVG()` – Calculates the average vehicle price.

`MIN()` – Finds the lowest vehicle price.

`MAX()` – Finds the highest vehicle price.

## Subquery Analysis

The project uses different types of subqueries.

Examples include:

* Finding cars priced above the overall average price
* Finding companies with an average price above a specified amount
* Finding dealer regions with more than a specified number of sales
* Finding the highest-priced car within each company

These queries demonstrate how subqueries can be used

# digital-wallet-kpi-tracker

A small data analytics project based on a payment and card-processing migration scenario.

The project covers:
- Data cleaning using Python and Pandas
- SQL data-quality checks
- Source-to-target migration reconciliation
- Transaction and customer analysis
- Power BI reporting and DAX

## Project Overview

This project uses sample customer, card, account, and transaction data.

The main purpose is to check whether the data is clean and whether the source and target data are matching after a migration.

The basic flow is:

Raw Data → Python Cleaning → SQL Validation → Reconciliation → KPI Analysis → Power BI

## Business Objective

During a payment-system migration, customer, card, account, and transaction data is moved from one system to another.

The data needs to be checked for:
- Missing records
- Duplicate records
- Missing mandatory values
- Invalid dates and IDs
- Incorrect transaction amounts
- Relationship issues between customers, accounts, and cards
- Differences between source and target record counts
- Differences in business KPIs

The main objective is to make sure the migrated data is usable for reporting and analysis.

## Project Scenario

The project contains these main entities:

| Entity | Description |
|---|---|
| Customer | Customer information |
| Card | Card and customer/card details |
| Account | Account information |
| Transaction | Payment and transaction details |
| Migration | Source and target data comparison |

The data is sample data created for learning and portfolio use. It does not contain real customer or financial information.



|


##  KPI Analysis

The KPI queries are kept in `03_kpi_summaries.sql`.

Main KPIs:

| KPI | Description |
|---|---|
| Total Customers | Number of unique customers |
| Total Cards | Number of cards |
| Total Transactions | Total transaction count |
| Transaction Value | Total transaction amount |
| Average Transaction | Average transaction amount |
| Successful Transactions | Count of successful transactions |
| Failed Transactions | Count of failed transactions |
| Pending Transactions | Count of pending transactions |
| Success Rate | Percentage of successful transactions |



## Skills Used

### SQL

- Joins
- CTEs
- Subqueries
- Aggregations
- GROUP BY
- HAVING
- CASE
- Window functions
- Data reconciliation
- Data-quality checks

### Python

- Pandas
- NumPy
- CSV processing
- Data cleaning
- Missing-value checks
- Duplicate checks
- Data-type conversion
- Data validation

### Power BI

- Data modeling
- Power Query
- DAX
- KPI measures
- Dashboard creation
- Filters and slicers
- Business reporting

### Analytics

- Data quality
- Migration validation
- Reconciliation
- Transaction analysis
- Customer analysis
- KPI reporting

## Dashboard Preview




## Possible Improvements

Some future additions could be:
- Automated data-quality reports
- More reconciliation checks
- Incremental data validation
- Automated SQL tests
- Python reconciliation reports
- Customer segmentation
- Transaction anomaly checks
- Power BI drill-through pages
- Row-level security
- Automatic dashboard refresh


## Author

**Dinesh Kumar Behera**

Data Analyst

Skills:
`SQL` • `Python` • `Pandas` • `Power BI` • `DAX` • `Excel` • `Data Quality` • `Data Reconciliation`


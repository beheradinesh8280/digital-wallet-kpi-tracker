# 💳 digital-wallet-kpi-tracker

### Data Quality • Migration Reconciliation • Transaction Analytics • Power BI

> **An end-to-end Data Analytics project demonstrating data cleaning, SQL validation, migration reconciliation, KPI analysis, and interactive Power BI reporting for a payment-processing migration scenario.**

---

## 📌 Project Overview

**digital-wallet-kpi-tracker** is an end-to-end data analytics project designed to simulate a real-world **payment and card-processing data migration** environment.

The project focuses on validating customer, card, account, and transaction data during migration while transforming raw datasets into reliable business insights.

The solution combines:

- 🐍 **Python / Pandas** for data preprocessing and cleansing
- 🗄️ **SQL** for data-quality validation and reconciliation
- 📊 **Power BI** for interactive reporting and KPI visualization
- 🔍 **Data reconciliation techniques** for source-to-target migration validation
- 📈 **Business analytics** for transaction and customer performance monitoring

The project follows a practical analytics workflow:

```text
                    RAW DATA
                       │
                       ▼
              ┌─────────────────┐
              │ Python / Pandas │
              │ Data Cleaning   │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ SQL Validation  │
              │ Data Quality    │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ Reconciliation  │
              │ Source vs Target│
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ KPI & Analytics │
              │ SQL Aggregation │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │    Power BI     │
              │    Dashboard    │
              └─────────────────┘
```

---

# 🎯 Business Objective

Payment-system migrations involve moving large volumes of customer, card, account, and transaction data from a **source system** to a **target system**.

Data must be validated to ensure that:

- No critical records are lost.
- Duplicate records are identified.
- Mandatory fields are populated.
- Transaction amounts remain consistent.
- Customer and account relationships are preserved.
- Dates and identifiers are valid.
- Source and target record counts reconcile.
- Business KPIs remain consistent after migration.

### Primary objective

> **Build a reliable analytical framework to validate migrated payment data and provide business-ready transaction insights through Power BI.**

---

# 🏦 Project Scenario

This project simulates a payment-processing migration involving entities such as:

| Entity | Description |
|---|---|
| 👤 Customer | Customer master information |
| 💳 Card | Card and customer/card relationships |
| 🏦 Account | Customer account information |
| 💰 Transaction | Payment and transaction activity |
| 🔄 Migration | Source-to-target data validation |

The datasets are designed for **portfolio and learning purposes** and do not contain real customer or financial information.

---

# 🧩 Key Business Questions

The analysis addresses questions such as:

### Customer Analytics

- How many customers are present?
- Are customer IDs unique?
- Are mandatory customer attributes missing?
- Which customers have multiple accounts or cards?

### Transaction Analytics

- What is the total transaction volume?
- What is the total transaction value?
- What is the average transaction amount?
- What percentage of transactions are successful?
- How many transactions failed or remain pending?
- Which transaction channels generate the most activity?

### Migration Validation

- Does the source record count match the target?
- Are transaction amounts preserved?
- Which customers have mismatched records?
- Are records missing from either source or target?
- Are duplicate records present after migration?

### Data Quality

- Which columns contain NULL values?
- Are there duplicate transaction IDs?
- Are transaction amounts valid?
- Are dates correctly formatted?
- Are categorical values valid?

---

# 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| 🐍 Python | Data preprocessing and cleansing |
| 🐼 Pandas | Data manipulation and validation |
| 🗄️ SQL | Data quality and reconciliation |
| 📐 CTEs | Structured migration validation |
| 🔢 Window Functions | Ranking and analytical calculations |
| 📊 Power BI | Dashboard and business reporting |
| 🧮 DAX | KPI and analytical measures |
| 📁 CSV | Sample source datasets |
| 📝 Git / GitHub | Version control and portfolio management |

---

# 📂 Project Structure

```text
digital-wallet-kpi-tracker/
│
├── assets/
│   └── dashboard_preview.png
│
├── data/
│   └── sample_datasets/
│       ├── customers.csv
│       ├── cards.csv
│       ├── accounts.csv
│       └── transactions.csv
│
├── sql/
│   ├── 01_data_quality_checks.sql
│   ├── 02_reconciliation_ctes.sql
│   └── 03_kpi_summaries.sql
│
├── python/
│   └── data_cleaning.py
│
├── reports/
│   └── Way4_Payment_Analytics.pbix
│
├── README.md
│
└── .gitignore
```

---

# 🐍 1. Python Data Cleaning

The Python preprocessing layer prepares raw datasets for downstream SQL validation and Power BI analysis.

### Key activities

- Load CSV datasets using Pandas
- Standardize column names
- Remove duplicate records
- Identify missing values
- Validate data types
- Convert date fields
- Validate numeric fields
- Identify invalid transaction amounts
- Perform basic data-quality checks
- Export cleaned datasets

### Example

```python
import pandas as pd

df = pd.read_csv("Transaction.csv")

# Standardize column names
df.columns = (
    df.columns
      .str.strip()
      .str.lower()
      .str.replace(" ", "_")
)

# Check duplicates
print("Duplicates:", df.duplicated().sum())

# Check missing values
print(df.isnull().sum())

# Convert numeric field
df["amount"] = pd.to_numeric(
    df["amount"],
    errors="coerce"
)

# Convert date field
df["transaction_date"] = pd.to_datetime(
    df["transaction_date"],
    errors="coerce"
)
```

---

# 🗄️ 2. SQL Data Quality Validation

The SQL layer performs structured validation against the cleaned datasets.

## `01_data_quality_checks.sql`

This script covers:

### Duplicate validation

```sql
SELECT
    transaction_id,
    COUNT(*) AS record_count
FROM transactions
GROUP BY transaction_id
HAVING COUNT(*) > 1;
```

### NULL validation

```sql
SELECT *
FROM customers
WHERE customer_id IS NULL;
```

### Invalid amount validation

```sql
SELECT *
FROM transactions
WHERE amount IS NULL
   OR amount <= 0;
```

### Invalid status validation

```sql
SELECT *
FROM transactions
WHERE status NOT IN (
    'SUCCESS',
    'FAILED',
    'PENDING'
);
```

---

# 🔄 3. Migration Reconciliation

The migration validation layer compares **source and target datasets**.

The objective is to identify discrepancies in:

- Record counts
- Customer records
- Transaction records
- Transaction amounts
- Missing records
- Duplicate records

## `02_reconciliation_ctes.sql`

### Source vs Target Example

```sql
WITH source_data AS (
    SELECT
        customer_id,
        COUNT(*) AS source_count,
        SUM(amount) AS source_amount
    FROM source_transactions
    GROUP BY customer_id
),

target_data AS (
    SELECT
        customer_id,
        COUNT(*) AS target_count,
        SUM(amount) AS target_amount
    FROM target_transactions
    GROUP BY customer_id
)

SELECT
    COALESCE(s.customer_id, t.customer_id) AS customer_id,

    s.source_count,
    t.target_count,

    s.source_amount,
    t.target_amount,

    COALESCE(s.source_count, 0)
      - COALESCE(t.target_count, 0) AS count_difference,

    COALESCE(s.source_amount, 0)
      - COALESCE(t.target_amount, 0) AS amount_difference

FROM source_data s

FULL OUTER JOIN target_data t
    ON s.customer_id = t.customer_id

WHERE
    COALESCE(s.source_count, 0)
      <> COALESCE(t.target_count, 0)

    OR

    COALESCE(s.source_amount, 0)
      <> COALESCE(t.target_amount, 0);
```

This approach helps identify customers where migrated transaction counts or amounts do not reconcile.

---

# 🔢 4. Window Function Analysis

Window functions are used for analytical validation and ranking.

### Example: Latest transaction per customer

```sql
WITH ranked_transactions AS (

    SELECT
        transaction_id,
        customer_id,
        transaction_date,
        amount,

        ROW_NUMBER() OVER (
            PARTITION BY customer_id
            ORDER BY transaction_date DESC
        ) AS rn

    FROM transactions
)

SELECT *
FROM ranked_transactions
WHERE rn = 1;
```

This identifies the latest transaction associated with each customer.

---

# 📊 5. KPI & Business Analysis

## `03_kpi_summaries.sql`

The KPI layer transforms transaction data into business-level metrics.

### Core KPIs

| KPI | Description |
|---|---|
| Total Customers | Number of unique customers |
| Total Cards | Number of cards |
| Total Transactions | Overall transaction volume |
| Transaction Value | Total monetary transaction value |
| Average Transaction | Average transaction amount |
| Successful Transactions | Number of successful transactions |
| Failed Transactions | Number of failed transactions |
| Pending Transactions | Number of pending transactions |
| Success Rate | Percentage of successful transactions |

### Example

```sql
SELECT
    COUNT(*) AS total_transactions,

    COUNT(DISTINCT customer_id)
        AS total_customers,

    SUM(amount)
        AS total_transaction_amount,

    AVG(amount)
        AS average_transaction_amount

FROM transactions;
```

---

# 📈 Power BI Dashboard

The Power BI dashboard provides an interactive view of the payment-processing data.

### Dashboard Preview

![digital-wallet-kpi-tracker Dashboard](assets/dashboard_preview.png)

---

## 📊 Dashboard Components

### Executive KPI Cards

The dashboard can include:

```text
┌────────────────┐ ┌────────────────┐ ┌────────────────┐
│ Total Customers│ │Total Transactions│ │Transaction Value│
│     10,000     │ │     125,000      │ │   ₹XX.XX M     │
└────────────────┘ └────────────────┘ └────────────────┘

┌────────────────┐ ┌────────────────┐ ┌────────────────┐
│ Success Rate   │ │ Failed Txns    │ │ Avg Transaction│
│     XX.XX%     │ │      XXXX      │ │     ₹XXXX      │
└────────────────┘ └────────────────┘ └────────────────┘
```

###  Visuals

- 📌 KPI Cards
- 📊 Transaction volume by month
- 📈 Transaction value trend
- 🍩 Transaction status distribution
- 📊 Transactions by channel
- 📊 Transactions by transaction type
- 📋 Customer transaction summary
- 🔍 Migration reconciliation summary

---

# 🧮 Power BI / DAX Measures

Example measures used for reporting:

### Total Transactions

```DAX
Total Transactions =
COUNTROWS(Transactions)
```

### Total Transaction Amount

```DAX
Total Transaction Amount =
SUM(Transactions[Amount])
```

### Average Transaction Amount

```DAX
Average Transaction Amount =
AVERAGE(Transactions[Amount])
```

### Successful Transactions

```DAX
Successful Transactions =
CALCULATE(
    COUNTROWS(Transactions),
    Transactions[Status] = "SUCCESS"
)
```

### Success Rate

```DAX
Success Rate =
DIVIDE(
    [Successful Transactions],
    [Total Transactions],
    0
)
```

---

# 🔗 Data Model

A relational model can be structured around the customer and transaction entities.

```text
                 ┌──────────────┐
                 │  Customers   │
                 │──────────────│
                 │ CustomerID   │
                 │ Name         │
                 │ Segment      │
                 └──────┬───────┘
                        │
                        │ 1 : Many
                        ▼
                 ┌──────────────┐
                 │ Transactions │
                 │──────────────│
                 │ TransactionID│
                 │ CustomerID   │
                 │ AccountID    │
                 │ CardID       │
                 │ DateKey      │
                 │ Amount       │
                 │ Status       │
                 │ Channel      │
                 └──────┬───────┘
                        │
             ┌──────────┴──────────┐
             ▼                     ▼
      ┌──────────────┐      ┌──────────────┐
      │    Cards     │      │   Accounts   │
      │──────────────│      │──────────────│
      │ CardID       │      │ AccountID    │
      │ CustomerID   │      │ CustomerID   │
      └──────────────┘      └──────────────┘
```

---

# 🔍 Data Quality Framework

The project follows a structured data-quality framework:

```text
                 DATA QUALITY
                      │
       ┌──────────────┼──────────────┐
       ▼              ▼              ▼
    Completeness   Uniqueness    Validity
       │              │              │
       ▼              ▼              ▼
      NULLs        Duplicates     Invalid
                                  values
       │              │              │
       └──────────────┼──────────────┘
                      ▼
                 CONSISTENCY
                      │
                      ▼
              Source vs Target
                 Reconciliation
```

### Validation Areas

- **Completeness** — Missing/NULL values
- **Uniqueness** — Duplicate identifiers
- **Validity** — Invalid dates, amounts, and categories
- **Consistency** — Source and target comparison
- **Integrity** — Customer/card/account relationships

---

# 🔄 End-to-End Workflow

```text
1. Collect Sample Data
          ↓
2. Inspect Raw Data
          ↓
3. Clean Using Pandas
          ↓
4. Validate Data Quality
          ↓
5. Load/Analyze Using SQL
          ↓
6. Reconcile Source vs Target
          ↓
7. Calculate Business KPIs
          ↓
8. Build Power BI Data Model
          ↓
9. Create DAX Measures
          ↓
10. Build Interactive Dashboard
          ↓
11. Analyze Business Insights
```

---

# 📌 Key Analytical Areas

### 💳 Payment Analytics

Analysis of transaction activity across:

- Transaction status
- Transaction type
- Payment channel
- Transaction amount
- Transaction date

### 👤 Customer Analytics

Analysis of:

- Customer transaction activity
- Customer-level transaction value
- Customer transaction frequency
- Customer-to-card relationships

### 🔄 Migration Analytics

Validation of:

- Source record counts
- Target record counts
- Record-level differences
- Amount-level differences
- Missing records
- Duplicate records

---

# 🧪 Testing & Validation Approach

The project applies multiple validation levels.

| Validation | Purpose |
|---|---|
| Schema Validation | Confirm expected columns and data types |
| NULL Validation | Identify missing mandatory values |
| Duplicate Validation | Detect duplicate records |
| Format Validation | Validate dates and identifiers |
| Range Validation | Identify invalid transaction amounts |
| Referential Validation | Validate entity relationships |
| Count Reconciliation | Compare source and target counts |
| Amount Reconciliation | Compare monetary totals |
| KPI Validation | Validate dashboard calculations |

---

# 📁 Dataset Structure

The sample datasets may contain fields such as:

### Customer

```text
CustomerID
CustomerName
DateOfBirth
Gender
City
CustomerSegment
```

### Card

```text
CardID
CustomerID
AccountID
CardType
CardStatus
IssueDate
ExpiryDate
```

### Transaction

```text
TransactionID
CustomerID
AccountID
CardID
MerchantID
DateKey
Amount
Currency
Status
Channel
TransactionType
```

> **Note:** Dataset values used in this repository are anonymized/sample data intended for demonstration and portfolio purposes.

---

# 🛡️ Data Privacy

This project does **not** use real customer payment information.

All datasets should be:

- Anonymized
- Synthetic
- Masked
- Free from personally identifiable information
- Free from real card numbers
- Free from sensitive financial information

Never commit production data, credentials, API keys, passwords, or confidential company information to the repository.

---

# 🚀 How to Run the Project

## Step 1 — Clone the Repository

```bash
git clone <repository-url>
cd digital-wallet-kpi-tracker
```

## Step 2 — Install Python Dependencies

```bash
pip install pandas numpy openpyxl
```

## Step 3 — Run Data Cleaning

```bash
python python/data_cleaning.py
```

## Step 4 — Execute SQL Scripts

Run the SQL scripts in the following order:

```text
01_data_quality_checks.sql
        ↓
02_reconciliation_ctes.sql
        ↓
03_kpi_summaries.sql
```

## Step 5 — Open Power BI

Open:

```text
reports/Way4_Payment_Analytics.pbix
```

Refresh the dataset and review the dashboard.

---

# 📊 Expected Outcomes

The project demonstrates the ability to:

- Clean and preprocess raw datasets
- Perform structured data-quality checks
- Identify duplicates and missing values
- Validate business rules
- Reconcile source and target systems
- Use CTEs and window functions
- Calculate business KPIs
- Build analytical data models
- Create DAX measures
- Develop interactive Power BI dashboards
- Communicate data-driven findings

---

# 💼 Skills Demonstrated

### SQL

```text
✓ Joins
✓ CTEs
✓ Subqueries
✓ Aggregations
✓ GROUP BY / HAVING
✓ CASE statements
✓ Window Functions
✓ Data Reconciliation
✓ Data Quality Validation
```

### Python

```text
✓ Pandas
✓ NumPy
✓ CSV Processing
✓ Data Cleaning
✓ Missing Value Handling
✓ Duplicate Detection
✓ Data Type Conversion
✓ Data Validation
```

### Power BI

```text
✓ Data Modeling
✓ Power Query
✓ DAX
✓ KPI Development
✓ Interactive Dashboards
✓ Filters & Slicers
✓ Business Reporting
```

### Analytics

```text
✓ Data Quality
✓ Migration Validation
✓ Reconciliation
✓ Transaction Analytics
✓ Customer Analytics
✓ KPI Reporting
```

---

# 📸 Dashboard Preview

The repository includes a dashboard preview under:

```text
assets/dashboard_preview.png
```

To display the image on GitHub:

```markdown
![digital-wallet-kpi-tracker](assets/dashboard_preview.png)
```

---

# 🗺️ Future Enhancements

Potential extensions include:

- Automated data-quality reports
- Additional migration reconciliation rules
- Incremental data validation
- Automated SQL testing
- Python-based reconciliation reports
- Advanced customer segmentation
- Fraud-pattern analysis
- Transaction anomaly detection
- Power BI drill-through pages
- Row-level security
- Automated dashboard refresh
- CI/CD integration for analytics workflows

---

# 📚 Project Learning Outcomes

This project demonstrates an end-to-end approach to solving a practical data analytics problem rather than focusing only on dashboard creation.

The workflow connects:

```text
DATA ENGINEERING
       +
DATA QUALITY
       +
SQL ANALYTICS
       +
MIGRATION VALIDATION
       +
BUSINESS INTELLIGENCE
```

The primary learning outcome is understanding how raw operational data can be transformed into **validated, reconciled, and business-ready analytical information**.

---

# 👨‍💻 Author

**Dinesh Kumar Behera**

### Data Analyst

**Core Skills**

`SQL` • `Python` • `Pandas` • `Power BI` • `DAX` • `Excel` • `Data Quality` • `Data Reconciliation`

---

# ⭐ Repository Purpose

This repository is created as a **portfolio project** to demonstrate practical Data Analyst capabilities across data preparation, SQL analytics, migration validation, and business intelligence.

If you find the project useful, feel free to ⭐ the repository.

---

## 📜 Disclaimer

This project is an educational and portfolio demonstration.

**digital-wallet-kpi-tracker**, payment-processing concepts, and related terminology are used to describe the simulated business scenario. The project does not contain proprietary production data, confidential information, or actual customer payment details.

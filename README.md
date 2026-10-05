# SQL Data Warehouse & Advanced Analytics

## 📌 Overview

An end-to-end **SQL Server Data Warehouse and Analytics project** using CRM and ERP data. The project covers data cleaning, transformation, dimensional modeling, exploratory analysis, and advanced SQL analytics.

## 🏗️ Project Workflow

```text
CRM + ERP Data
      ↓
Data Cleansing
      ↓
Data Transformation
      ↓
Dimensional Model
      ↓
EDA
      ↓
Advanced Analytics
```

## 📊 Data Model

The project uses a **star-schema-style model**:

* `dim_customers` — Customer information
* `dim_products` — Product and category information
* `fact_sales` — Sales transactions and measures

## 🧹 Data Cleaning & Transformation

* Removed duplicate records
* Handled NULL and invalid values
* Standardized customer, product, and country data
* Validated dates and sales values
* Used `ROW_NUMBER()` for duplicate handling
* Used `LEAD()` and `DATEADD()` for product validity
* Created customer and product dimensions
* Built the sales fact

## 📈 Analysis

### Exploratory Data Analysis

* Sales and quantity KPIs
* Customer analysis
* Product analysis
* Revenue by category
* Top and bottom products

### Advanced Analytics

* Yearly and monthly sales trends
* Running totals
* Moving averages
* Year-over-year product performance
* Category contribution
* Product cost segmentation
* Customer segmentation

## 🧠 SQL Skills

* Joins
* CTEs
* Subqueries
* CASE statements
* Aggregate functions
* Window functions
* `ROW_NUMBER()`
* `RANK()`
* `LAG()`
* `LEAD()`
* `SUM() OVER()`
* `AVG() OVER()`
* Date & string functions
* Views
* Data cleansing & transformation

## 🛠️ Technologies

* **Microsoft SQL Server**
* **T-SQL**
* **SQL Server Management Studio (SSMS)**
* **CSV**
* **Data Warehousing**
* **Dimensional Modeling**

## 📂 Repository Structure

```text
├── DWH_Script.sql
├── DWH_Data_Cleansing.sql
├── DWH_Data_Transformation.sql
├── Exploratory Data Analysis (EDA).sql
├── Advanced_Analytics.sql
└── README.md
```

## 🚀 How to Run

1. Install **SQL Server** and **SSMS**.
2. Run `DWH_Script.sql`.
3. Update the CSV file paths if required.
4. Run `DWH_Data_Cleansing.sql`.
5. Run `DWH_Data_Transformation.sql`.
6. Run `Exploratory Data Analysis (EDA).sql`.
7. Run `Advanced_Analytics.sql`.

## 🎯 Key Business Questions

* Which products and categories generate the most revenue?
* How are sales changing over time?
* Which products are performing above or below average?
* Which customers contribute the most revenue?
* How can customers be segmented based on spending and lifetime?

## 👨‍💻 About

**Vijay K G**
Aspiring **Data Analyst** skilled in **SQL, Excel, Power BI, and Python**, with a focus on data analysis, reporting, and business insights.

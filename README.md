# SQL Data Warehouse & Advanced Analytics

### End-to-End Data Warehouse & Sales Analytics | SQL Server | Power BI

## 📌 Overview

An end-to-end **SQL Server Data Warehouse and Business Analytics project** using CRM and ERP datasets.

The project covers data ingestion, data cleaning, transformation, dimensional modeling, exploratory data analysis (EDA), advanced SQL analytics, and interactive Power BI dashboard development.

The objective is to transform raw business data into structured analytical datasets and meaningful business insights.

## 🏗️ Project Workflow

```text
CRM + ERP Data
      ↓
Data Loading (BULK INSERT)
      ↓
Data Cleansing
      ↓
Data Transformation
      ↓
Dimensional Modeling
      ↓
Exploratory Data Analysis
      ↓
Advanced SQL Analytics
      ↓
Power BI Dashboard
      ↓
Business Insights
```

## 📊 Data Model

The project uses a **star-schema-style analytical model**:

| View | Description |
|---|---|
| `dim_customers` | Customer information, demographics and location |
| `dim_products` | Product details and category information |
| `fact_sales` | Sales transactions, order dates and measures |

## 🧹 Data Cleaning & Transformation

- Removed duplicate records.
- Handled NULL and invalid values.
- Standardized customer, product and country data.
- Validated dates and sales values.
- Used `ROW_NUMBER()` for duplicate handling.
- Used `LEAD()` and `DATEADD()` for product validity.
- Integrated CRM and ERP datasets using `LEFT JOIN`.
- Created customer and product dimension views.
- Developed the sales fact view.

## 📈 SQL Analytics

### Exploratory Data Analysis (EDA)

- Total sales and quantity KPIs.
- Customer analysis.
- Product analysis.
- Revenue by category.
- Top and bottom-performing products.
- Country-wise customer analysis.

### Advanced Analytics

- Yearly and monthly sales trends.
- Monthly running totals.
- Moving averages.
- Year-over-year product performance.
- Category contribution analysis.
- Product cost segmentation.
- Customer segmentation.

## 📊 Power BI – Sales Performance & Business Analytics Dashboard

Developed an interactive Power BI dashboard to analyse sales performance, revenue trends, product categories and geographical sales distribution.

### Dashboard Preview

<img width="1548" height="870" alt="image" src="https://github.com/user-attachments/assets/f349fd0e-192b-4a91-b595-1acd6759e786" /> (images/Sales_Performance_Dashboard.png)

### Key Performance Indicators (KPIs)

| KPI | Value |
|---|---:|
| Total Sales | ₹58.71M |
| Sold Quantity | 120.85K |
| Average Selling Price | ₹486.04 |
| Total Orders | 27.66K |
| Total Products | 295 |

### Dashboard Visualizations

1. **YoY Sales Analysis** – Annual sales trends from 2010 to 2014.
2. **Sales by Category** – Revenue contribution across Bikes, Accessories and Clothing.
3. **Month Slicer** – Interactive monthly filtering.
4. **Current & Previous Year Sales by Category** – Comparative category-level sales analysis.
5. **YoY Sales Variance** – Waterfall analysis of annual sales movements from 2010 to 2014.
6. **Sales by Country** – Geographical sales performance comparison.

### Power BI Concepts

- Data Modeling
- DAX Measures
- KPI Development
- Time-Based Analysis
- Year-over-Year Comparison
- Interactive Slicers
- Data Visualization

**Dashboard File:** `PowerBI/Sales_Dashboard.pbix`

## 🧠 SQL Skills

- Joins
- CTEs
- Subqueries
- CASE statements
- Aggregate functions
- Window functions
- `ROW_NUMBER()`
- `RANK()`
- `LAG()`
- `LEAD()`
- `SUM() OVER()`
- `AVG() OVER()`
- Date and string functions
- Views
- Data cleansing and transformation

## 🛠️ Technologies

| Technology | Application |
|---|---|
| Microsoft SQL Server 2022 | Database development |
| T-SQL | Data cleaning and analytics |
| SQL Server Management Studio | SQL development |
| Microsoft Power BI | Dashboard development |
| DAX | Analytical calculations |
| CSV | Source datasets |
| Data Warehousing | Data integration and modeling |

## 📂 Repository Structure

```text
Data-Warehouse-and-Analysis/
│
├── datasets/
│
├── scripts/
│   ├── DWH_Script.sql
│   ├── DWH_Data_Cleansing.sql
│   ├── DWH_Data_Transformation.sql
│   ├── Exploratory Data Analysis (EDA).sql
│   └── Advanced_Analytics.sql
│
├── PowerBI/
│   └── Sales_Dashboard.pbix
│
├── images/
│   └── Sales_Performance_Dashboard.png
│
├── docs/
│   └── SQL_Data_Warehouse_and_Sales_Analytics_Documentation.pdf
│
└── README.md
```

## 📄 Project Documentation

Detailed project documentation covering:

- Database development and data loading.
- Data cleaning and quality checks.
- Data transformation and analytical modeling.
- Exploratory and advanced SQL analytics.
- Power BI dashboard design and analysis.


## 🚀 How to Run

1. Install Microsoft SQL Server and SSMS.
2. Clone or download this repository.
3. Run `DWH_Script.sql`.
4. Update CSV file paths according to your local environment.
5. Run `DWH_Data_Cleansing.sql`.
6. Run `DWH_Data_Transformation.sql`.
7. Run `Exploratory Data Analysis (EDA).sql`.
8. Run `Advanced_Analytics.sql`.
9. Open `Sales_Dashboard.pbix` in Power BI Desktop.
10. Configure the data source and refresh the dashboard if required.

## 🎯 Key Business Questions

- Which products and categories generate the highest revenue?
- How are sales changing over time?
- Which products perform above or below average?
- Which customers contribute the most revenue?
- How can customers be segmented based on spending and purchase history?
- Which countries contribute the most sales?
- How does current-year sales performance compare with previous years?

## 🎓 Key Learnings

- SQL Server database development.
- Data cleaning and transformation.
- Relational data integration.
- Dimensional modeling.
- Exploratory Data Analysis.
- Advanced SQL and window functions.
- DAX calculations and Power BI reporting.
- Translating business data into actionable insights.

## 👨‍💻 About

**Vijay K G**

Aspiring Data Analyst

**Technical Skills:** SQL | Excel | Power BI | Python

Interested in Data Analytics, Business Intelligence, data visualization and transforming raw data into meaningful business insights.

---

⭐ If you find this project useful, feel free to explore the repository.


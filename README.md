# Retail Sales Analysis | MySQL & Power BI

## Project Overview

This project analyses retail sales data to identify business trends, evaluate product and regional performance, understand customer purchasing behaviour, and generate actionable business insights.

The analysis uses **MySQL** for data exploration and business analysis and **Microsoft Power BI** for interactive dashboards and visualisation.

## Dataset Information

- **Dataset:** Sales Forecasting – Superstore
- **Source:** [Kaggle – Sales Forecasting Dataset](https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting)
- **CSV file:** `superstore.csv`
- **Records:** 9,800
- **Columns:** 18
- **Period:** 2015–2018

## Tools & Technologies

- MySQL – Data storage, data quality checks and SQL analysis
- Microsoft Excel – Initial data inspection and preparation
- Microsoft Power BI – Interactive dashboards and visualisation
- DAX – Measures and customer classification

## Project Workflow

1. Dataset inspection and preparation using Excel.
2. Database and table creation in MySQL.
3. CSV data import and verification.
4. Data exploration and quality checks.
5. SQL-based business analysis.
6. Power BI dashboard development using DAX.
7. Business insights and recommendations.

## Key Performance Indicators

| Metric | Result |
|---|---:|
| Total Sales | $2,261,536.78 |
| Total Records | 9,800 |
| Unique Orders | 4,922 |
| Unique Customers | 793 |
| Repeat Customers | 780 |
| One-time Customers | 13 |

## SQL Analysis

The project includes SQL queries covering:

- Initial data exploration
- Data quality checks
- Category-wise and sub-category-wise sales
- Region-wise sales
- Customer segment analysis
- Top 10 customers by sales
- Top 10 products by sales
- Monthly and yearly sales trends
- Shipping mode analysis
- Average order-to-ship time
- Top 10 states and cities by sales
- Customer order frequency
- Repeat versus one-time customer analysis
- Most frequently recorded products

**SQL query file:** [queries.sql](queries.sql)

## Power BI Dashboards

Four interactive dashboard pages were developed.

### 1. Sales Overview
- Total Sales, Total Orders and Total Customers
- Sales by Region
- Sales by Segment
- Sales by Category and Sub-category
- Sales by Month

### 2. Detailed Analysis
- Top 10 Customers by Sales
- Top 10 Products by Sales

### 3. Customer and Geographic Analysis
- Sales by Shipping Mode
- Top 10 States by Sales
- Top 10 Cities by Sales
- Top 10 Customers by Order Frequency

### 4. Customer Retention and Product Insights
- Repeat versus One-time Customers
- Top 10 Most Frequently Recorded Products
- Segment and Category slicers

**Power BI file:** `PowerBI/Retail_Sales_Analysis.pbix`

## Key Business Insights

1. **Category Performance:** Technology generated the highest sales of $827,455.87, contributing approximately 36.6% of total sales.

2. **Regional Performance:** The West region generated the highest sales of $710,219.68, contributing approximately 31.4% of total sales.

3. **Customer Segments:** The Consumer segment contributed $1,148,060.53, approximately 50.8% of total sales.

4. **Product Performance:** Phones was the highest-revenue sub-category, generating $327,782.45.

5. **Geographic Performance:** California generated the highest state-level sales of $446,306.46. New York City was the highest-performing city, with $252,462.55.

6. **Customer Retention:** 780 out of 793 customers were repeat customers, representing approximately 98.36%.

7. **Monthly Performance:** November 2018 recorded the highest monthly sales of $117,938.16.

8. **Yearly Performance:** Sales increased by approximately 30.6% in 2017 and 20.3% in 2018 compared with the respective previous years.

## Business Recommendations

- Maintain suitable inventory for high-performing categories and products.
- Investigate opportunities to improve sales in lower-performing regions.
- Strengthen customer retention through loyalty programmes and personalised offers.
- Develop strategies to attract new customers.
- Review order processing and shipping efficiency.
- Use historical monthly sales patterns to support inventory and promotional planning.

## Data Limitations

The dataset does not contain:

- Quantity
- Profit
- Discount

Therefore:
- Sales analysis represents revenue, not profit.
- Product frequency represents the number of sales records, not actual units sold.
- Shipping time represents the interval between order date and ship date, not customer delivery time.

## Project Files

- `queries.sql` – MySQL analysis queries
- `PowerBI/` – Power BI dashboard file and documentation
- `Business_Insights/` – Business insights report
- `Final_Report/` – Combined project report
- `screenshots/` – Dashboard screenshots

*Folder and file links should be updated to match the final repository structure.*

## Project Outcome

Developed a retail sales analysis project using MySQL and Power BI to analyse 9,800 records, evaluate sales performance, understand customer behaviour, and communicate findings through four interactive dashboards.


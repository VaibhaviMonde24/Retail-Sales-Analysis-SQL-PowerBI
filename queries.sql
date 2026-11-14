/*
PROJECT: Retail Sales Analysis
DATASET: Sales Forecasting – Kaggle
SOURCE: https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting
CSV FILE: superstore.csv
DATABASE: retail_sales
TABLE: orders

Dataset details:
- 9,800 records
- 18 columns
- Date range: 2015-01-03 to 2018-12-30

Notes:
- Order Date and Ship Date are stored as VARCHAR in DD-MM-YYYY format.
- Date calculations therefore use STR_TO_DATE(..., '%d-%m-%Y').
- The dataset does not contain Quantity, Profit or Discount columns.
- COUNT(*) is a count of records, not units sold.
- MySQL 5.5-compatible queries are used.
*/

USE retail_sales;

-- =========================================================
-- 1. INITIAL DATA EXPLORATION
-- =========================================================

-- 1.1 Total number of records
SELECT COUNT(*) AS total_records
FROM orders;

-- 1.2 Number of unique customers
SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM orders;

-- 1.3 Product categories
SELECT DISTINCT category
FROM orders;

-- 1.4 Order date range
SELECT
    MIN(STR_TO_DATE(order_date, '%d-%m-%Y')) AS first_order,
    MAX(STR_TO_DATE(order_date, '%d-%m-%Y')) AS last_order
FROM orders;

-- 1.5 Total sales
SELECT ROUND(SUM(sales), 2) AS total_sales
FROM orders;

-- 1.6 Check duplicate Row IDs
SELECT
    row_id,
    COUNT(*) AS row_id_count
FROM orders
GROUP BY row_id
HAVING COUNT(*) > 1;


-- =========================================================
-- 2. DATA QUALITY CHECKS
-- =========================================================

-- 2.1 Check zero or negative sales
SELECT *
FROM orders
WHERE sales <= 0;

-- 2.2 Check invalid order dates
SELECT order_date
FROM orders
WHERE STR_TO_DATE(order_date, '%d-%m-%Y') IS NULL;

-- 2.3 Check shipping dates earlier than order dates
SELECT *
FROM orders
WHERE STR_TO_DATE(ship_date, '%d-%m-%Y')
    < STR_TO_DATE(order_date, '%d-%m-%Y');

-- 2.4 Check missing values in the first six columns
SELECT
    SUM(row_id IS NULL) AS missing_row_id,
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(order_date IS NULL) AS missing_order_date,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(product_id IS NULL) AS missing_product_id,
    SUM(sales IS NULL) AS missing_sales
FROM orders;

-- 2.5 Check missing values in the remaining twelve columns
SELECT
    SUM(ship_date IS NULL) AS missing_ship_date,
    SUM(ship_mode IS NULL) AS missing_ship_mode,
    SUM(customer_name IS NULL) AS missing_customer_name,
    SUM(segment IS NULL) AS missing_segment,
    SUM(country IS NULL) AS missing_country,
    SUM(city IS NULL) AS missing_city,
    SUM(state IS NULL) AS missing_state,
    SUM(postal_code IS NULL) AS missing_postal_code,
    SUM(region IS NULL) AS missing_region,
    SUM(category IS NULL) AS missing_category,
    SUM(sub_category IS NULL) AS missing_sub_category,
    SUM(product_name IS NULL) AS missing_product_name
FROM orders;

-- 2.6 Check duplicate combinations of Row ID, Order ID and Product ID
SELECT
    row_id,
    order_id,
    product_id,
    COUNT(*) AS duplicate_count
FROM orders
GROUP BY row_id, order_id, product_id
HAVING COUNT(*) > 1;


-- =========================================================
-- 3. UNIQUE-VALUE EXPLORATION
-- =========================================================

-- 3.1 Shipping modes
SELECT DISTINCT ship_mode
FROM orders;

-- 3.2 Customer segments
SELECT DISTINCT segment
FROM orders;

-- 3.3 Sales regions
SELECT DISTINCT region
FROM orders;


-- =========================================================
-- 4. CATEGORY-WISE SALES ANALYSIS
-- =========================================================

SELECT
    category,
    COUNT(*) AS total_records,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY category
ORDER BY total_sales DESC;


-- =========================================================
-- 5. REGION-WISE SALES ANALYSIS
-- =========================================================

SELECT
    region,
    COUNT(*) AS total_records,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY region
ORDER BY total_sales DESC;


-- =========================================================
-- 6. CUSTOMER SEGMENT SALES ANALYSIS
-- =========================================================

SELECT
    segment,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(*) AS total_records,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY segment
ORDER BY total_sales DESC;


-- =========================================================
-- 7. TOP 10 CUSTOMERS BY SALES
-- =========================================================

SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY customer_id, customer_name
ORDER BY total_sales DESC
LIMIT 10;


-- =========================================================
-- 8. TOP 10 PRODUCTS BY SALES
-- =========================================================

SELECT
    product_id,
    product_name,
    SUM(sales) AS total_sales
FROM orders
GROUP BY product_id, product_name
ORDER BY total_sales DESC
LIMIT 10;


-- =========================================================
-- 9. MONTHLY SALES TREND ANALYSIS
-- =========================================================

SELECT
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS sales_year,
    MONTH(STR_TO_DATE(order_date, '%d-%m-%Y')) AS sales_month,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY sales_year, sales_month
ORDER BY sales_year, sales_month;


-- =========================================================
-- 10. YEAR-WISE SALES ANALYSIS
-- =========================================================

SELECT
    YEAR(STR_TO_DATE(order_date, '%d-%m-%Y')) AS sales_year,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY sales_year
ORDER BY sales_year;


-- =========================================================
-- 11. SHIPPING MODE ANALYSIS
-- =========================================================

SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY ship_mode
ORDER BY total_orders DESC;


-- =========================================================
-- 12. AVERAGE ORDER-TO-SHIP TIME ANALYSIS
-- =========================================================

SELECT
    ship_mode,
    ROUND(
        AVG(
            DATEDIFF(
                STR_TO_DATE(ship_date, '%d-%m-%Y'),
                STR_TO_DATE(order_date, '%d-%m-%Y')
            )
        ),
        2
    ) AS avg_shipping_days
FROM orders
GROUP BY ship_mode
ORDER BY avg_shipping_days;


-- =========================================================
-- 13. TOP 10 STATES BY SALES
-- =========================================================

SELECT
    state,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;


-- =========================================================
-- 14. SUB-CATEGORY-WISE SALES ANALYSIS
-- =========================================================

SELECT
    sub_category,
    COUNT(*) AS total_records,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY sub_category
ORDER BY total_sales DESC;


-- =========================================================
-- 15. TOP 10 CITIES BY SALES
-- =========================================================

SELECT
    city,
    state,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY city, state
ORDER BY total_sales DESC
LIMIT 10;


-- =========================================================
-- 16. CUSTOMER ORDER FREQUENCY ANALYSIS
-- =========================================================

SELECT
    customer_id,
    customer_name,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY customer_id, customer_name
ORDER BY total_orders DESC
LIMIT 10;


-- =========================================================
-- 17. REPEAT VS ONE-TIME CUSTOMER ANALYSIS
-- =========================================================

SELECT
    CASE
        WHEN customer_orders = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS customer_orders
    FROM orders
    GROUP BY customer_id
) AS customer_summary
GROUP BY customer_type;


-- =========================================================
-- 18. MOST FREQUENTLY RECORDED PRODUCTS
-- =========================================================

SELECT
    product_id,
    product_name,
    COUNT(*) AS total_records,
    ROUND(SUM(sales), 2) AS total_sales
FROM orders
GROUP BY product_id, product_name
ORDER BY total_records DESC
LIMIT 10;

/*
END OF RETAIL SALES ANALYSIS SQL SCRIPT

Interpretation reminders:
- The shipping-time calculation is the interval from order date to ship date,
  not the delivery date or customer receipt date.
- The frequently recorded product query counts sales records, not units sold,
  because the dataset has no Quantity column.
- Sales should not be described as profit because the dataset has no Profit column.
*/

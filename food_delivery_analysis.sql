-- 📋 Problem 1: Find the Top 3 Outlets by Cuisine Type
-- Without using LIMIT or TOP functions.

WITH cte AS (
    SELECT 
        Cuisine, 
        Restaurant_Id, 
        COUNT(*) AS no_of_orders
    FROM orders
    GROUP BY Cuisine, Restaurant_id
)
SELECT * 
FROM ( 
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY Cuisine ORDER BY no_of_orders DESC) AS rn
    FROM cte
) a
WHERE rn <= 3;

-- Insight:
-- Shows the top 3 performing restaurants within each cuisine based on order volume.

-- 📋 Problem 2: Find the Daily New Customer Count from the Launch Date

WITH cte AS (
    SELECT 
        Customer_code,
        CAST(MIN(Placed_at) AS DATE) AS first_order_date 
    FROM orders
    GROUP BY Customer_code
)
SELECT 
    first_order_date,
    COUNT(*) AS no_of_new_customer
FROM cte
GROUP BY first_order_date
ORDER BY first_order_date;

-- Insight:
-- Shows how many new customers were acquired each day from 1st Jan 2025 onwards.

-- 📋 Problem 3: Find Customers Acquired in Jan 2025 Who Only Placed One Order

SELECT 
    Customer_code,
    COUNT(*) AS no_of_order 
FROM orders
WHERE MONTH(Placed_at) = 1 
  AND YEAR(Placed_at) = 2025 
  AND Customer_code NOT IN (
        SELECT DISTINCT Customer_code
        FROM orders
        WHERE NOT (MONTH(Placed_at) = 1 AND YEAR(Placed_at) = 2025)
  )
GROUP BY Customer_code
HAVING COUNT(*) = 1
ORDER BY Customer_code;

-- Insight:
-- Lists customers acquired in January 2025 who placed only one order and did not order again.

-- 📋 Problem 4: Customers Inactive in Last 7 Days But Acquired 1 Month Ago with Promo

WITH cte AS (
    SELECT 
        Customer_code, 
        MIN(Placed_at) AS first_order_date,
        MAX(Placed_at) AS last_order_date
    FROM orders 
    GROUP BY Customer_code
)
SELECT 
    cte.*,
    Promo_code_Name AS first_order_promo
FROM cte 
INNER JOIN orders 
    ON cte.Customer_code = orders.Customer_code 
   AND cte.first_order_date = orders.Placed_at
WHERE last_order_date < DATE_ADD(NOW(), INTERVAL -7 DAY)
  AND first_order_date < DATE_ADD(NOW(), INTERVAL -1 MONTH)
  AND Promo_code_Name IS NOT NULL
ORDER BY first_order_date;

-- Insight:
-- Customers acquired a month ago using promo but have been inactive in the last 7 days.

-- 📋 Problem 5: Query for Trigger After Every Third Order
-- Below is the basic query for finding every third order.

-- 1.
WITH cte AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY Customer_code ORDER BY Placed_at) AS order_number
    FROM orders
)
SELECT * 
FROM cte 
WHERE order_number % 3 = 0;
  
-- In a production environment, to avoid sending duplicate triggers, we should limit it to today's orders only. Here's how:

-- 2.
WITH cte AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY Customer_code ORDER BY Placed_at) AS order_number
    FROM orders
)
SELECT * 
FROM cte 
WHERE order_number % 3 = 0 
  AND CAST(Placed_at AS DATE) = CAST(NOW() AS DATE);

-- Insight:
-- First query identifies customers who have placed their 3rd, 6th, 9th (and so on) orders, enabling the Growth team to trigger personalized 
-- communications at every third order milestone.
-- And the last query ensures only today's qualifying events are targeted to avoid duplicate messaging.

-- 📋 Problem 6: Customers Who Placed More Than One Order Using Promo Codes

SELECT 
    Customer_code,
    COUNT(Order_id) AS no_of_order,
    COUNT(Promo_code_Name) AS promo_order
FROM orders
GROUP BY Customer_code
HAVING no_of_order > 1 
   AND promo_order = no_of_order;

-- 📋 Problem 7: What Percent of Customers Were Organically Acquired in Jan 2025

-- Note: Since the dataset only contains orders from 2025, 
-- it is appropriate to filter WHERE MONTH(Placed_at) = 1 inside the CTE itself without causing any issues.

WITH cte AS (
    SELECT *, 
        DENSE_RANK() OVER (PARTITION BY Customer_code ORDER BY Placed_at ASC) AS rnk
    FROM orders
    WHERE MONTH(Placed_at) = 1 
)
SELECT CONCAT(
        ROUND(
            COUNT(CASE WHEN rnk = 1 AND Promo_code_Name IS NULL THEN Customer_code END) * 100.0 / 
            COUNT(DISTINCT Customer_code), 
        2), 
    "%") AS customer_pct
FROM cte;

-- Insight:
-- Calculates what percent of customers acquired in January 2025 placed their first order without using a promo.

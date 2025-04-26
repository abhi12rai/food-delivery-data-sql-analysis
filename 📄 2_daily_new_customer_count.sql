-- 📋 Problem 2: Find the Daily New Customer Count from the Launch Date

-- Step 1: Find each customer's first order date
WITH FirstOrders AS (
    SELECT 
        Customer_code,
        MIN(CAST(Placed_at AS DATE)) AS FirstOrderDate
    FROM 
        orders
    GROUP BY 
        Customer_code
)

-- Step 2: Count how many customers had their first order on each day
SELECT 
    FirstOrderDate AS NewCustomerDate,
    COUNT(Customer_code) AS NewCustomerCount
FROM 
    FirstOrders
GROUP BY 
    FirstOrderDate
ORDER BY 
    NewCustomerDate;

-- Insight:
-- Shows how many new customers were acquired each day from 1st Jan 2025 onwards.

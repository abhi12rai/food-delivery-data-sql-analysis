-- 📋 Problem 3: Find Customers Acquired in Jan 2025 Who Only Placed One Order

-- Step 1: Find each customer's first order date
WITH CustomerOrders AS (
    SELECT 
        Customer_code,
        MIN(CAST(Placed_at AS DATE)) AS FirstOrderDate,
        COUNT(Order_id) AS TotalOrders
    FROM 
        orders
    GROUP BY 
        Customer_code
)

-- Step 2: Filter customers acquired in Jan 2025 with only one order
SELECT 
    Customer_code
FROM 
    CustomerOrders
WHERE 
    FirstOrderDate BETWEEN '2025-01-01' AND '2025-01-31'
    AND TotalOrders = 1;

-- Insight:
-- Lists customers acquired in January 2025 who placed only one order and did not order again.

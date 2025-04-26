-- 📋 Problem 1: Find the Top 3 Outlets by Cuisine Type
-- Without using LIMIT or TOP functions.

-- Step 1: Create a CTE to calculate order count per restaurant within each cuisine
WITH CuisineOutletRank AS (
    SELECT 
        Cuisine,
        Restaurant_id,
        COUNT(*) AS TotalOrders,
        ROW_NUMBER() OVER (PARTITION BY Cuisine ORDER BY COUNT(*) DESC) AS rn
    FROM 
        orders
    GROUP BY 
        Cuisine, Restaurant_id
)

-- Step 2: Select top 3 outlets per cuisine based on the rank
SELECT 
    Cuisine,
    Restaurant_id,
    TotalOrders
FROM 
    CuisineOutletRank
WHERE 
    rn <= 3
ORDER BY 
    Cuisine, rn;

-- Insight:
-- Shows the top 3 performing restaurants within each cuisine based on order volume.

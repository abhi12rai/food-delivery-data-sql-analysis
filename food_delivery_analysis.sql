-- 1. Find the top 3 outlets by cuisine type without using the LIMIT and TOP functions.
WITH CTE AS (
    SELECT Cuisine, Restaurant_Id, COUNT(*) AS NumOrders,
           ROW_NUMBER() OVER (PARTITION BY Cuisine ORDER BY COUNT(*) DESC) AS RN
    FROM Orders
    GROUP BY Cuisine, Restaurant_Id
)
SELECT Cuisine, Restaurant_Id
FROM CTE
WHERE RN <=3;

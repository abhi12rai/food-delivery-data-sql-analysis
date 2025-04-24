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

**Explanation:**
1. I use a CTE (Common Table Expression) to get the count of orders for each Restaurant_ID within each Cuisine type.
2. Within the CTE, we also generate the row number for each Restaurant_ID within each Cuisine, 
   ordered by the number of orders in descending order.
3. Finally, we select the rows where the row number is <=3 to get the top 3 outlet for each Cuisine. 
   This way, we can get the top 3 (or any number) outlets for each Cuisine type without using the LIMIT or TOP functions.
======================================================================================================================================================================================================================

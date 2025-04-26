-- 📋 Problem 1: Find the Top 3 Outlets by Cuisine Type
-- Without using LIMIT or TOP functions.

WITH CTE AS (
    SELECT Cuisine, Restaurant_Id, COUNT(*) AS no_of_orders
from orders
group by Cuisine, Restaurant_id)
select * from ( 
			select *,
           ROW_NUMBER() OVER (PARTITION BY cuisine ORDER BY no_of_orders DESC) AS rn
    FROM cte) a
WHERE RN <=3;

-- Insight:
-- Shows the top 3 performing restaurants within each cuisine based on order volume.

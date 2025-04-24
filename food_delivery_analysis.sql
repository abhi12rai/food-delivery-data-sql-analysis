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
=============================================================================================================================

-- 2.Find the daily new customer count from the launch date(how many new customers joined each day)
with cte as (
select Customer_code,cast(min(Placed_at) as date) as
 first_order_date from orders
group by Customer_code)
select first_order_date,count(Customer_code) as no_of_new_customer
from cte
group by first_order_date
order by first_order_date;
=================================================================================================================================
-- 3.Count of all users who were acquired in January 2025 and only placed one order in January and did not placed any other order
with cte as (
select Customer_code,count(*)as no_of_order from orders
where month(placed_at)=1 and year(placed_at)=2025
group by customer_code
having no_of_order =1)
select customer_code from cte 
where customer_code not in (select distinct Customer_code from orders
where month(placed_at) in (2,3));

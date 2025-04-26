-- 📋 Problem 5: Query for Trigger After Every Third Order
-- Below is the basic query for finding every third order.
--1.
with cte as (
select *,
row_number() over(partition by Customer_code order by Placed_at) as order_number
from orders
)
select * from cte 
where order_number%3=0;
  
-- In a production environment, to avoid sending duplicate triggers, we should limit it to today's orders only. Here's how:
--2.
with cte as (
select *,
row_number() over(partition by Customer_code order by Placed_at) as order_number
from orders
)
select * from cte 
where order_number%3=0 and cast(placed_at as date)=cast(now() as date);

-- Insight:
-- Frist query identifies customers who have placed their 3rd, 6th, 9th (and so on) orders, enabling the Growth team to trigger personalized 
-- communications at every third order milestone. 
-- And last query ensures only today's qualifying events are targeted to avoid duplicate messaging.

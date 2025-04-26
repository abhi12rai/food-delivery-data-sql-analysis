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

-- 📋 Problem 2: Find the Daily New Customer Count from the Launch Date

with cte as (
select Customer_code,cast(min(Placed_at) as date) as
 first_order_date from orders
group by Customer_code)
select first_order_date,count(*) as no_of_new_customer
from cte
group by first_order_date
order by first_order_date;

-- Insight:
-- Shows how many new customers were acquired each day from 1st Jan 2025 onwards.

-- 📋 Problem 3: Find Customers Acquired in Jan 2025 Who Only Placed One Order

select Customer_code,count(*) as no_of_order 
from orders
where month(placed_at)=1 and year(placed_at)=2025 
and Customer_code not in (select distinct Customer_code
from orders
where not (month(placed_at)=1 and year(placed_at)=2025)) 
group by customer_code
having count(*) =1
order by Customer_code;

-- Insight:
-- Lists customers acquired in January 2025 who placed only one order and did not order again.

-- 📋 Problem 4: Customers Inactive in Last 7 Days But Acquired 1 Month Ago with Promo

with cte as (
select customer_code, min(Placed_at) as first_order_date,
max(Placed_at) as last_order_date
 from orders 
 group by customer_code)
 select cte.*,Promo_code_Name as first_order_promo
 from cte 
 inner join orders on cte.customer_code=orders.customer_code and
	  cte.first_order_date=orders.Placed_at
where last_order_date < Date_add(now(), interval -7 day) and
	  first_order_date< Date_add(now(), interval -1 month) and
	  Promo_code_Name is not null
order by first_order_date;

-- Insight:
-- Customers acquired a month ago using promo but have been inactive in the last 7 days.

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

-- 📋 Problem 6: Customers Who Placed More Than One Orders Using Promo Codes

select Customer_code,count(order_id) as no_of_order,
count(Promo_code_Name) as promo_order
from orders
group by Customer_code
having no_of_order>1 and promo_order=no_of_order;

-- 📋 Problem 7: What Percent of Customers Were Organically Acquired in Jan 2025

-- Note= Since the dataset only contains orders from 2025, 
-- it is appropriate to filter WHERE MONTH(placed_at) = 1 inside the CTE itself without causing any issues.

with cte as(
select *, 
dense_rank() over(partition by customer_code order by Placed_at asc) as rnk
from orders
where month(placed_at)=1 
)
select concat(round(
	count(case when rnk=1 and promo_code_name is null then customer_code end)*100.0/
    count(distinct customer_code),2),"%") as customer_pct
from cte;

-- Insight:
-- Calculates what percent of customers acquired in January 2025 placed their first order without using a promo.

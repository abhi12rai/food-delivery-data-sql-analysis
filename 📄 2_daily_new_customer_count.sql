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

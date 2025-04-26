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


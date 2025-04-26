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












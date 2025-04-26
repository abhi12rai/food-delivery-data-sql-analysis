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

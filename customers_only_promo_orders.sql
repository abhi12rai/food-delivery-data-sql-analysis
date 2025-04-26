-- 📋 Problem 6: Customers Who Placed More Than One Orders Using Promo Codes

select Customer_code,count(order_id) as no_of_order,
count(Promo_code_Name) as promo_order
from orders
group by Customer_code
having no_of_order>1 and promo_order=no_of_order;


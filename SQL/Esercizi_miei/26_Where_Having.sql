-- EXERCISE 1 — Simple Filtering
-- Using a products table (price, category):
-- Show only products with a price greater than 50.
SELECT *
FROM products
where price > 50;

-- EXERCISE 2 — Group Filtering
-- Using the same products table:
-- Show categories where the average price is greater than 100.
SELECT 
  category, 
  avg(price) as average_price
FROM products 
group by category
having avg(price) > 100;

-- EXERCISE 3 — Mixed Filtering
-- Using an orders table (customer_id, amount, order_date):
-- Show customers who placed orders after 2025-01-01
-- and whose total spending is greater than 500.
select 
  customer_id, 
  sum(amount) as total_spending
from orders
where order_date > '2025-01-01'
group by customer_id
having sum(amount) > 500 ;

-- EXERCISE 4 — Counting Rows
-- Using an employees table (department_id, salary):
-- Show departments that have more than 3 employees.
select department_id, count(*) as department_employees
from employees 
group by department_id
having count(*) > 3;

-- EXERCISE 5 — Advanced Logic
-- Using an orders table:
-- Show customers who:
-- placed at least 5 orders
-- and whose average order amount is above 200
select 
  customer_id, 
  count(*) as total_orders, 
  avg(amount) as average_amount
from orders
group by customer_id
having (count(*) > 5) and (avg(amount) > 200);

------------
Hint Section (optional to print)
WHERE filters rows before GROUP BY
HAVING filters aggregated results after GROUP BY
If you use SUM(), AVG(), COUNT() → think HAVING
------------
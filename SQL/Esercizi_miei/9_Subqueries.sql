-- =====================================
-- EXERCISE 9 — Subqueries (Core Skill)
-- =====================================
-- Using the "customers" and "orders" tables:
--
-- Write queries to:
-- 1) Show customers who spent more than the average order amount
-- 2) Show customers who placed the highest single order
-- 3) Show customers who have never placed an order (use a subquery, not a JOIN)
-- 4) Show the top 3 customers by total spending using a subquery

-- customers who spent more than the average order amount
SELECT * FROM customers
WHERE customer_id IN (
  SELECT customer_id 
  FROM orders
  WHERE amount > (
    SELECT AVG(amount)
    FROM orders
  )
);

-- customers who placed the highest single order
SELECT * FROM customers
WHERE customer_id IN (
  SELECT customer_id 
  FROM orders
  WHERE amount = (
    SELECT MAX(amount)
    FROM orders
  )
);

-- customers who have never placed an order
SELECT * 
FROM customers 
WHERE customer_id NOT IN (
  SELECT customer_id FROM orders
);

-- the top 3 customers by total spending
SELECT c.*
FROM customers c
JOIN (
  SELECT customer_id
  FROM orders
  GROUP BY customer_id
  ORDER BY SUM(amount) DESC
  LIMIT 3
) top_customers
ON c.customer_id = top_customers.customer_id;


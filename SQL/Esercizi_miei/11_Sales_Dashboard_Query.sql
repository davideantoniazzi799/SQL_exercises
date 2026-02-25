-- =====================================
-- EXERCISE 11 — Sales Dashboard Query
-- =====================================
-- Using tables: customers, orders
--
-- Write queries to:
-- 1) Show customer name, total orders, and total amount spent
-- 2) Add a column "customer_level":
--      - "BRONZE" if total < 100
--      - "SILVER" if total BETWEEN 100 AND 300
--      - "GOLD" if total > 300
-- 3) Show only GOLD customers
-- 4) Order results by total amount DESC

-- Show customer name, total orders, and total amount spent
SELECT 
  cust.name, 
  count(ord.order_id) AS total_orders, 
  sum(ord.amount) AS total_amount_spent
FROM customers as cust
LEFT JOIN orders as ord 
ON cust.customer_id = ord.customer_id
GROUP BY cust.customer_id;

-- Add a column "customer_level":
--      - "BRONZE" if total < 100
--      - "SILVER" if total BETWEEN 100 AND 300
--      - "GOLD" if total > 300

SELECT 
  customer_id,
  sum(amount) as total_amount_spent,
  CASE
    WHEN sum(amount) < 100 THEN 'BRONZE'
    WHEN sum(amount) BETWEEN 100 AND 300 THEN 'SILVER'
    ELSE 'GOLD'
  END AS customer_level
FROM orders
GROUP BY customer_id;

-- Only GOLD customers
SELECT 
  customer_id,
  sum(amount) as total_amount_spent,
  CASE
    WHEN sum(amount) < 100 THEN 'BRONZE'
    WHEN sum(amount) BETWEEN 100 AND 300 THEN 'SILVER'
    ELSE 'GOLD'
  END AS customer_level
FROM orders
GROUP BY customer_id
HAVING customer_level = 'GOLD';

-- Ordered results by total amount DESC
SELECT 
  customer_id,
  sum(amount) as total_amount_spent,
  CASE
    WHEN sum(amount) < 100 THEN 'BRONZE'
    WHEN sum(amount) BETWEEN 100 AND 300 THEN 'SILVER'
    ELSE 'GOLD'
  END AS customer_level
FROM orders
GROUP BY customer_id
ORDER BY total_amount_spent DESC;


SELECT *
FROM (
    SELECT 
        cust.name,
        COUNT(ord.order_id) AS total_orders,
        SUM(ord.amount) AS total_amount_spent,
        CASE
            WHEN SUM(ord.amount) < 100 THEN 'BRONZE'
            WHEN SUM(ord.amount) BETWEEN 100 AND 300 THEN 'SILVER'
            ELSE 'GOLD'
        END AS customer_level
    FROM customers AS cust
    LEFT JOIN orders AS ord
        ON cust.customer_id = ord.customer_id
    GROUP BY cust.customer_id, cust.name
) AS summary
WHERE customer_level = 'GOLD'
ORDER BY total_amount_spent DESC;
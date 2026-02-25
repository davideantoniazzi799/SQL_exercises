-- =====================================
-- EXERCISE 8 — CASE & Conditional Logic
-- =====================================
-- Using the "orders" table from previous exercises:
--
-- Write queries to:
-- 1) Create a column called "order_type":
--      - "SMALL" if amount < 50
--      - "MEDIUM" if amount BETWEEN 50 AND 200
--      - "LARGE" if amount > 200
--
-- 2) Count how many orders fall into each category
-- 3) Show total sales per order type

-- Column order_type 
SELECT 
  order_id,
  customer_id,
  amount,
  CASE
    WHEN amount < 50 THEN 'SMALL'
    WHEN amount BETWEEN 50 AND 200 THEN 'MEDIUM'
    ELSE 'LARGE'
  END AS order_type
FROM orders;

-- Count type of orders
SELECT 
  CASE
    WHEN amount < 50 THEN 'SMALL'
    WHEN amount BETWEEN 50 AND 200 THEN 'MEDIUM'
    ELSE 'LARGE'
  END AS order_type,
  count(*) AS total_orders
FROM orders
GROUP BY order_type;

-- Total sales per order type
SELECT 
  CASE
    WHEN amount < 50 THEN 'SMALL'
    WHEN amount BETWEEN 50 AND 200 THEN 'MEDIUM'
    ELSE 'LARGE'
  END AS order_type,
  count(*) AS total_orders,
  sum(amount) as total_sales
FROM orders
GROUP BY order_type;


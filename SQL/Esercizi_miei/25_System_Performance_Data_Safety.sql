-- ==========================================================
-- EXERCISE 5 — System Performance & Data Safety
-- ==========================================================
-- Using orders table from Exercise 22

-- Write queries to:
-- 1) Create an index on (customer_id, order_date)
-- 2) Use EXPLAIN to analyze a query that finds
--    total spending per customer in the last 6 months
-- 3) Write a subquery that finds customers who placed
--    their most recent order in the last 30 days
-- 4) Show customers whose total spending is in the TOP 20%
--    of all customers (no LIMIT)
-- 5) Wrap a DELETE statement for old orders
--    (older than 3 years) inside a TRANSACTION
--    with ROLLBACK safety

-- Create an index on (customer_id, order_date)
CREATE INDEX idx_custid_orderdate
ON orders (customer_id, order_date);

-- Use EXPLAIN to analyze a query that finds total spending per customer in the last 6 months
EXPLAIN
SELECT
  customer_id,
  SUM(amount) AS total_spending
FROM orders
WHERE order_date >= CURDATE() - INTERVAL 6 MONTH
GROUP BY customer_id;

-- Write a subquery that finds customers who placed their most recent order in the last 30 days
SELECT *
FROM orders 
WHERE customer_id in (
  SELECT customer_id
  FROM orders
  HAVING DATEDIFF(CURDATE(), order_date) < 30
);

-- Show customers whose total spending is in the TOP 20% of all customers (no LIMIT)
SELECT
  customer_id,
  total_spending
FROM (
  SELECT
    customer_id,
    SUM(amount) AS total_spending
  FROM orders
  GROUP BY customer_id -- Compute total spending per customer
) t1
WHERE (
  SELECT COUNT(*)
  FROM (
    SELECT
      customer_id,
      SUM(amount) AS spending
    FROM orders
    GROUP BY customer_id
  ) t2
  WHERE t2.spending > t1.total_spending -- Count how many customers spent more
) < (
  SELECT COUNT(DISTINCT customer_id) * 0.2
  FROM orders -- If fewer than top 20% → you’re in
)
ORDER BY total_spending DESC;

-- Wrap a DELETE statement for old orders(older than 3 years) inside a TRANSACTION with ROLLBACK safety
START TRANSACTION;

DELETE FROM orders
WHERE order_date < CURDATE() - INTERVAL 3 YEAR;

-- SAFETY CHECK
SELECT COUNT(*) AS rows_to_delete
FROM orders
WHERE order_date < CURDATE() - INTERVAL 3 YEAR;

-- If result looks correct → COMMIT
-- If not → ROLLBACK

COMMIT;
-- or
-- ROLLBACK;

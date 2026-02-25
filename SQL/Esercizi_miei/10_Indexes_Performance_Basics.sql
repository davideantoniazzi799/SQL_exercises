-- =====================================
-- EXERCISE 10 — Indexes & Performance Basics
-- =====================================
-- Using the "orders" table:
--
-- Write queries to:
-- 1) Create an index on customer_id
-- 2) Create a composite index on (customer_id, amount)
-- 3) Show all indexes on the table
-- 4) Drop the composite index
-- 5) Explain a query that selects orders by customer_id

-- index on customer_id
CREATE INDEX idx_customer
ON orders (customer_id);

-- composite index on (customer_id, amount)
CREATE INDEX idx_custid_amount
ON orders (customer_id, amount);

-- all indexes on the table
SHOW INDEX from orders;

-- Drop the composite index
DROP index idx_custid_amount ON orders;

-- Explain a query that selects orders by customer_id
EXPLAIN 
SELECT *
FROM orders 
WHERE customer_id = 3;



-- =====================================
-- EXERCISE 4 — GROUP BY & HAVING
-- =====================================
-- Using the "orders" table:
--
-- Write queries to:
-- 1) Show total sales per customer
-- 2) Show number of orders per customer
-- 3) Show only customers with total sales greater than 200
-- 4) Show customers who placed more than 1 order

-- Total sales and orders per customer
SELECT customer_name, SUM(amount) AS total_sales, count(*) AS total_orders
FROM orders
GROUP BY customer_name;

-- Customers with total sales > 200
SELECT customer_name, sum(amount) AS total_sales
FROM orders
GROUP BY customer_name
HAVING total_sales > 200;

-- Customers with total orders > 1
SELECT customer_name, count(*) AS total_orders
FROM orders
GROUP BY customer_name
HAVING total_orders > 1;
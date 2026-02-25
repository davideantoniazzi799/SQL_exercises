-- =====================================
-- EXERCISE 5 — Joins (Real World Practice)
-- =====================================
-- Create tables:
--
-- customers:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- name (VARCHAR)
-- city (VARCHAR)
--
-- orders:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- customer_id (INT)
-- amount (DECIMAL)
--
-- Insert at least 5 customers and 8 orders
--
-- Then write queries to:
-- 1) Show all orders with customer names
-- 2) Show total amount spent per customer
-- 3) Show customers who have never placed an order
-- 4) Show the customer with the highest total spending

CREATE TABLE IF NOT EXISTS customers(
  customer_id int primary key not null auto_increment,
  name varchar(50) not null,
  city varchar(50)
);

CREATE TABLE IF NOT EXISTS orders(
  order_id int primary key not null auto_increment,
  customer_id int not null,
  amount decimal(10,2) not null check (amount > 0)
);

INSERT INTO customers(name, city) values
("Luca", "Roma"),
("Mattia", "Savona"),
("Lucia", "Bari"),
("Gianluca", "La Spezia"),
("Giuseppe", "Viterbo"),
("Cristina", "Sassari"),
("Marco", "Enna"),
("Anna", "Palermo");

INSERT INTO orders(customer_id, amount) VALUES
(1, 234),
(2, 35),
(5, 45.99),
(4, 99.99),
(3, 10.15),
(7, 56),
(6, 48),
(8, 127),
(8, 89),
(3, 13.89);

-- All orders with customer name
SELECT ord.customer_id, cust.name, ord.order_id, ord.amount
FROM customers as cust
RIGHT JOIN orders as ord 
ON cust.customer_id = ord.customer_id;

-- Total amount per customer
SELECT 
  ord.customer_id, 
  cust.name, 
  count(ord.order_id) AS total_orders, 
  sum(ord.amount) AS total_amount
FROM customers as cust
LEFT JOIN orders as ord 
ON cust.customer_id = ord.customer_id
GROUP BY cust.customer_id;

-- Customers with no order
SELECT
  cust.name, 
  count(ord.order_id) AS total_orders 
FROM customers as cust
LEFT JOIN orders as ord 
ON cust.customer_id = ord.customer_id
GROUP BY cust.customer_id
HAVING total_orders = 0;

-- Max total amount per customer
SELECT 
  cust.name,
  sum(ord.amount) AS total_amount
FROM customers as cust
LEFT JOIN orders as ord 
ON cust.customer_id = ord.customer_id
GROUP BY cust.customer_id
ORDER BY total_amount DESC LIMIT 1;
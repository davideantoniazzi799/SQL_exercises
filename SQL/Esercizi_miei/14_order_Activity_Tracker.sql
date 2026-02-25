-- =====================================
-- EXERCISE 14 — Order Activity Tracker
-- =====================================
-- Using the "orders" table
--
-- Write queries to:
-- 1) Show order_id, amount, and days since the order was placed
-- 2) Show orders placed in the last 30 days
-- 3) Group orders by customer and show:
--      - total orders
--      - total amount
--      - last order date
-- 4) Show only customers whose last order was more than 60 days ago

/*
DROP TABLE orders;
*/
  
CREATE TABLE IF NOT EXISTS orders(
  order_id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  customer_name varchar(255) NOT NULL,
  amount decimal(10,2) NOT NULL,
  order_date date NOT NULL
);

INSERT INTO orders(customer_name, amount, order_date) values
("Pizzeria S.r.L.", 235.89, "2022-08-08"),
("Andrea Tempi", 35.76, "2024-08-18"),
("Sella Servizi", 768.99, "2021-10-01"),
("Carrozzeria Manea", 99.99, "2023-01-07"),
("Luca", 18, "2023-08-29"),
("Mano Servizi", 23.65, "2022-12-14"),
("Lanaro Giocattoli", 78.99, "2020-06-08"),
("Pentagono Difesa", 657.78, "2021-04-09");

-- Show order_id, amount, and days since the order was placed
SELECT
  order_id,
  amount,
  DATEDIFF(CURDATE(), order_date) as days_since_last_order
FROM orders;

-- Show orders placed in the last 30 days
SELECT * FROM orders
WHERE DATEDIFF(CURDATE(), order_date) < 30;

-- Group orders by customer and show:
--      - total orders
--      - total amount
--      - last order date
SELECT 
  customer_name,
  COUNT(*) as total_orders,
  SUM(amount) as total_amount,
  MAX(order_date) as last_order_date 
FROM orders
GROUP BY customer_name;

-- Show only customers whose last order was more than 60 days ago
SELECT 
  customer_name,
  MAX(order_date) AS last_order_date,
  DATEDIFF(CURDATE(), MAX(order_date)) AS days_since_last_order
FROM orders
GROUP BY customer_name
HAVING DATEDIFF(CURDATE(), MAX(order_date)) > 60;


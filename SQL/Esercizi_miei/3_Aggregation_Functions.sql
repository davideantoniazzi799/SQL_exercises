-- =====================================
-- EXERCISE 3 — Aggregation Functions
-- =====================================
-- Create a table "orders" with:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- customer_name (VARCHAR)
-- amount (DECIMAL)
-- order_date (DATE)
--
-- Insert at least 8 orders
--
-- Then write queries to:
-- 1) Show total number of orders
-- 2) Show total sales amount
-- 3) Show average order value
-- 4) Show highest and lowest order amount

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

-- Total number of orders
SELECT count(*) AS Total_orders FROM orders;

-- Total amount of orders
SELECT SUM(amount) AS Total_amount FROM orders;

-- Average order value
SELECT AVG(amount) AS Average_amount FROM orders;

-- Highest and lowest order amount
SELECT amount AS Highest_order FROM orders ORDER BY amount DESC LIMIT 1;
SELECT amount AS Lowest_order FROM orders ORDER BY amount ASC LIMIT 1;

/*
SELECT 
  MAX(amount) AS Highest_order,
  MIN(amount) AS Lowest_order
FROM orders;
*/
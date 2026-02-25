-- =====================================
-- EXERCISE 15 — Performance & Optimization
-- =====================================
-- Using tables: customers, orders
--
-- Write queries to:
-- 1) Create an index on orders.customer_id
-- 2) Use EXPLAIN to analyze this query:
--      - Show total spending per customer
-- 3) Rewrite the query using a subquery instead of GROUP BY
-- 4) Show customers whose total spending is in the TOP 20% of all customers

/*
DROP TABLE customers;
DROP TABLE orders;
*/
  
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

-- Create an index on orders.customer_id
CREATE INDEX idx_customer
ON orders (customer_id);

-- Use EXPLAIN to analyze this query:
--      - Show total spending per customer

EXPLAIN 
SELECT
  customer_id,
  SUM(amount) as total_spending
FROM orders
GROUP BY customer_id;

-- Rewrite the query using a subquery instead of GROUP BY
SELECT 
  c.customer_id,
  c.name,
  t.total_spending
FROM customers c
JOIN (
  SELECT 
    customer_id,
    SUM(amount) AS total_spending
  FROM orders
  GROUP BY customer_id
) t
ON c.customer_id = t.customer_id;

-- Show customers whose total spending is in the TOP 20% of all customers
SELECT 
  c.customer_id,
  c.name,
  t.total_spending
FROM customers c
JOIN (
  SELECT 
    customer_id,
    SUM(amount) AS total_spending
  FROM orders
  GROUP BY customer_id
) t
ON c.customer_id = t.customer_id
WHERE (
  SELECT COUNT(*)
  FROM (
    SELECT 
      customer_id,
      SUM(amount) AS spending
    FROM orders
    GROUP BY customer_id
  ) ranked
  WHERE ranked.spending > t.total_spending
) <= (
  SELECT COUNT(DISTINCT customer_id) * 0.2
  FROM orders
)
ORDER BY t.total_spending DESC;
-- ==========================================================
-- EXERCISE 2 — Sales Analytics & Classification
-- ==========================================================
-- Create tables:
--
-- customers:
--   id (INT, PRIMARY KEY, AUTO_INCREMENT)
--   name (VARCHAR, NOT NULL)
--   city (VARCHAR)
--
-- orders:
--   id (INT, PRIMARY KEY, AUTO_INCREMENT)
--   customer_id (INT, FK → customers.id)
--   amount (DECIMAL, NOT NULL CHECK amount > 0)
--   order_date (DATE, NOT NULL)
--
-- Insert:
--   - 6 customers
--   - 15 orders

-- Then write queries to:
-- 1) Show total orders and total spending per customer
-- 2) Add a column "customer_tier":
--      BRONZE → total < 100
--      SILVER → total BETWEEN 100 AND 300
--      GOLD   → total > 300
-- 3) Show only GOLD customers
-- 4) Show customers who spent more than the average customer spending (subquery)
-- 5) Show the TOP 3 customers by spending WITHOUT using LIMIT

/*
DROP TABLE customers;
DROP table orders;
*/

CREATE TABLE IF NOT EXISTS customers(
  customer_id int not null primary key auto_increment,
  name varchar(255) not null,
  city varchar(255) not null
);

CREATE TABLE IF NOT EXISTS orders(
  order_id int not null primary key auto_increment,
  customer_id int not null,
  amount decimal(10,2) not null check (amount > 0),
  order_date date not null

  FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE -- if a department_id changes, the information changes also for the employees related to it
) ENGINE=InnoDB;

INSERT INTO customers(name, city) VALUES 
("Luca", "Rome"),
("Andrea", "Venice"),
("Matteo", "Rome"),
("Sara", "Turin"),
("Aurora", "Bari"),
("Stefano", "Turin");

INSERT INTO orders(customer_id, amount, order_date) values
(2, 2345, "2025-12-24"),
(1, 80, "2025-11-18"),
(4, 12, "2026-01-11"),
(1, 45, "2025-11-29"),
(5, 123, "2025-12-10"),
(6, 2345, "2026-01-13"),
(4, 1200, "2025-12-01"),
(1, 14, "2025-11-24"),
(1, 10.15, "2025-10-24"),
(2, 25, "2025-12-01"),
(3, 28, "2025-12-08"),
(6, 59.99, "2025-12-20"),
(5, 9.99, "2025-12-29"),
(4, 18, "2025-09-01"),
(3, 1200, "2025-10-07");

-- Show total orders and total spending per customer, add a column "customer_tier":
--      BRONZE → total < 100
--      SILVER → total BETWEEN 100 AND 300
--      GOLD   → total > 300
-- and select only 'GOLD' customers
SELECT 
  c.customer_id,
  c.name, 
  count(o.order_id) as total_orders, 
  sum(o.amount) as total_amount,
  CASE
  when sum(o.amount) < 100 then 'BRONZE'
  when sum(o.amount) between 100 and 300 then 'SILVER'
  else 'GOLD'
  END as 'customer_tier'
FROM customers AS c
LEFT JOIN orders as o
ON c.customer_id = o.customer_id
group by c.customer_id
having customer_tier = 'GOLD';

-- Show customers who spent more than the average customer spending (subquery)
SELECT 
  c.customer_id,
  c.name, 
  count(o.order_id) as total_orders, 
  sum(o.amount) as total_amount
FROM customers AS c
JOIN orders as o
ON c.customer_id = o.customer_id
group by c.customer_id
having sum(o.amount) > (
  SELECT AVG(total_spending)
  FROM (
    SELECT SUM(amount) AS total_spending
    FROM orders
    GROUP BY customer_id
  ) AS totals
);

-- Show the TOP 3 customers by spending WITHOUT using LIMIT
SELECT
  c.customer_id,
  c.name,
  sum(o.amount) as total_amount
FROM customers as c
JOIN orders as o
ON c.customer_id = o.customer_id
group by c.customer_id, c.name
HAVING (
  SELECT COUNT(*)
  FROM (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
  ) t
  WHERE t.total_spent > SUM(o.amount)
) < 3
ORDER BY total_amount DESC;


-- =====================================
-- EXERCISE 12 — Product Performance Report
-- =====================================
-- Create a table "products":
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- name (VARCHAR)
-- category (VARCHAR)
-- price (DECIMAL)
-- created_at (DATE)
--
-- Insert at least 8 products
--
-- Then write queries to:
-- 1) Show category, number of products, and average price
-- 2) Show only categories with average price > 10
-- 3) Show products created this year
-- 4) Create a column "price_label":
--      - "CHEAP" if price < 10
--      - "NORMAL" if price BETWEEN 10 AND 50
--      - "EXPENSIVE" if price > 50

CREATE TABLE IF NOT EXISTS products(
  id int primary key not null auto_increment,
  name varchar(255) not null unique,
  category varchar(255) not null,
  price decimal(10,2) not null,
  created_at date not null
);

/*
DROP TABLE products
*/

INSERT INTO products(name, category, price, created_at) values
("Pasta", "Food", 0.99, "2023-05-15"),
("Rice", "Food", 0.97, "2022-11-18"),
("Water", "Beverage", 0.49, "2018-03-01"),
("Shampoo", "Bathroom", 1.19, "2024-08-25"),
("Broom", "House", 1.99, "2022-06-10"),
("Aperol", "Alcohol", 9.99, "2021-09-08"),
("Coca cola", "Beverage", 0.99, "2023-09-01"),
("Yogurt", "Food", 0.88, "2020-02-24"),
("Gin Tonic", "Alcohol", 24.55, "2022-10-28");

-- Show category, number of products, and average price
SELECT 
  category, 
  count(*) as number_products, 
  round(avg(price), 2) as average_price
FROM products
group by category;

-- Show only categories with average price > 10
SELECT 
  category, 
  count(*) as number_products, 
  round(avg(price), 2) as average_price
FROM products
group by category
having avg(price) > 10;

-- Show products created this year
SELECT *
FROM products
WHERE YEAR(created_at) = YEAR(CURDATE());

-- Create a column "price_label":
--      - "CHEAP" if price < 10
--      - "NORMAL" if price BETWEEN 10 AND 50
--      - "EXPENSIVE" if price > 50

SELECT 
  id,
  name, 
  CASE 
  when price < 10 then 'CHEAP'
  when price between 10 and 50 then 'NORMAL'
  else 'EXPENSIVE'
  END AS price_label
FROM products;
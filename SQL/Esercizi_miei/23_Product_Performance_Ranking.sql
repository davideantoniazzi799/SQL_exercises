-- ==========================================================
-- EXERCISE 3 — Product Performance & Ranking
-- ==========================================================
-- Create table:
--
-- products:
--   id (INT, PRIMARY KEY, AUTO_INCREMENT)
--   name (VARCHAR, UNIQUE, NOT NULL)
--   category (VARCHAR, NOT NULL)
--   price (DECIMAL, NOT NULL)
--   created_at (DATE)
--
-- Insert at least 12 products across 4 categories

-- Then write queries to:
-- 1) Show average price per category
-- 2) Show categories with average price above global average price (subquery)
-- 3) Label each product:
--      CHEAP → price < category average
--      EXPENSIVE → price > category average
-- 4) Show the top-priced product in each category (subquery)
-- 5) Create an index on (category, price) and use EXPLAIN on one query

/*
DROP TABLE products;
*/

CREATE TABLE if not exists products(
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) UNIQUE NOT NULL,
  category VARCHAR(255) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  created_at DATE
);

insert into products(name, category, price, created_at) values
("Water", "Beverage", 0.49, "2023-01-01"),
("Coke", "Beverage", 0.89, "2023-05-01"),
("Bread", "Food", 0.79, "2021-09-01"),
("Nutella", "Food", 2.29, "2024-07-01"),
("Shampoo", "Bathroom", 1.89, "2024-03-01"),
("Pizza", "Food", 3.99, "2024-01-01"),
("Fish", "Food", 7.89, "2022-02-10"),
("Fanta", "Beverage", 0.89, "2023-05-01"),
("Ice cubes", "Frozen products", 1.89, "2025-01-01"),
("Ice-cream", "Frozen products", 2.49, "2023-10-01"),
("Green Olives", "Food", 1.39, "2023-07-12"),
("Whiskey", "Alcohol", 18.99, "2023-11-11");

-- Show average price per category
select 
  category, 
  round(avg(price), 2) as average_catergory_price
from products
group by category;

-- Show categories with average price above global average price (subquery)
select 
  category, 
  round(avg(price), 2) as average_category_price
from products
group by category
having avg(price) > (
  select 
    avg(price) as average_price
  from products
);

-- Label each product:
--      CHEAP → price < category average
--      EXPENSIVE → price > category average

SELECT 
  p.name,
  p.category,
  p.price,
  CASE
    WHEN p.price < (
      SELECT AVG(p2.price)
      FROM products p2
      WHERE p2.category = p.category
    ) THEN 'CHEAP'
    ELSE 'EXPENSIVE'
  END AS product_tier
FROM products p;

-- Show the top-priced product in each category (subquery)
SELECT *
FROM products p
WHERE p.price = (
  SELECT MAX(p2.price)
  FROM products p2
  WHERE p2.category = p.category
);

-- Create an index on (category, price) and use EXPLAIN on one query
CREATE INDEX idx_category_price
ON products (category, price);

EXPLAIN
SELECT *
FROM products
WHERE category = 'Food'
ORDER BY price DESC;
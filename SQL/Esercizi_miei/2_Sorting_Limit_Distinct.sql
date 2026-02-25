-- =====================================
-- EXERCISE 2 — Sorting, LIMIT & DISTINCT
-- =====================================
-- Create a table "products" with:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- name (VARCHAR)
-- category (VARCHAR)
-- price (DECIMAL)
--
-- Insert at least 8 products
--
-- Then write queries to:
-- 1) Show all products ordered by price DESC
-- 2) Show the 3 cheapest products
-- 3) Show all DISTINCT categories
-- 4) Show products with price BETWEEN 10 and 50

CREATE TABLE IF NOT EXISTS products(
  product_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  category varchar(50) NOT NULL,
  price decimal(6,2) NOT NULL
);

INSERT INTO products(name, category, price) values
("Pasta", "Food", 0.99),
("Ham", "Food", 1.19),
("Yogurt", "Food", 1.09),
("Water", "Drinks", 0.49),
("Apple", "Fruit", 0.79),
("Carrot", "Vegetables", 0.39),
("Mandarin", "Fruit", 0.49),
("Pop_Corn", "Snacks", 0.99);

-- All prodcuts ordered from most to less expensive
SELECT * FROM products ORDER BY price DESC;

-- 3 cheapest products
SELECT * FROM products ORDER BY price ASC LIMIT 3;

-- All distinct categories
SELECT DISTINCT category FROM products;

-- Products with price between 10 and 50
SELECT * FROM products
WHERE price BETWEEN 10 AND 50;


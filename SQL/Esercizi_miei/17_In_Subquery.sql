-- =====================================
-- EXERCISE 2 — IN Subquery
-- =====================================
-- Create tables:
--
-- authors:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- name (VARCHAR)
--
-- books:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- title (VARCHAR)
-- author_id (INT)
-- price (DECIMAL)
--
-- Insert at least 5 authors and 10 books
--
-- Then write a query to:
-- Show authors who have written at least one book
-- priced higher than 20

CREATE TABLE IF NOT EXISTS authors(
  author_id int primary key not null auto_increment,
  name varchar(255) not null
);

CREATE TABLE IF NOT EXISTS books(
  book_id int primary key not null auto_increment,
  title varchar(255) not null unique,
  author_id int not null,
  price decimal(5,2) not null
);

INSERT INTO authors(name) VALUES 
("Roberto Saviano"),
("Michela Murgia"),
("Stephen King"),
("Ken Follet"),
("J.K. Rowling"),
("Bram Stroker"),
("George Orwell");

INSERT INTO books(title, author_id, price) values
("It", 3, 18.99),
("The Outsider", 3, 16.90),
("La Fattoria degli Animali", 7, 11.99),
("Dracula", 6, 13.49),
("Gomorra", 1, 12.99),
("Harry Potter e la Pietra Filosofale", 5, 10.99),
("I Pilastri della Terra", 4, 17.99),
("Harry Potter e la Camera dei Segreti", 5, 10.99),
("Zero Zero Zero", 1, 11.49),
("1984", 7, 12.90),
("Joyland", 3, 11.15);

-- Task:
-- Use a subquery with IN to find authors
-- who appear in the result of a books query

-- Show authors who have written at least one book priced higher than 20
SELECT * 
FROM authors 
WHERE author_id IN 
  (SELECT author_id 
  FROM books
  WHERE price > 20);

-- Author withour a recorded book
SELECT * 
FROM authors 
WHERE author_id NOT IN 
  (SELECT author_id 
  FROM books);






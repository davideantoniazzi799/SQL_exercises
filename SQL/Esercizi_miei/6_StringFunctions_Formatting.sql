-- =====================================
-- EXERCISE 6 — String Functions & Formatting
-- =====================================
-- Create a table "employees" with:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- first_name (VARCHAR)
-- last_name (VARCHAR)
-- email (VARCHAR)
--
-- Insert at least 6 employees
--
-- Then write queries to:
-- 1) Show full name as: "LASTNAME, Firstname"
-- 2) Show all emails in lowercase
-- 3) Show the length of each employee's full name
-- 4) Show only employees whose last name starts with "M"

CREATE TABLE employees(
  employee_id int primary key not null auto_increment,
  first_name varchar(50) not null,
  last_name varchar(50) not null,
  email varchar(255) not null unique
);

INSERT INTO employees(first_name, last_name, email) VALUES 
("Luca", "Rossi", "luca.rossi@gmail.com"),
("Andrea", "Creati", "andrea.cr@gmail.com"),
("Alfonso", "Verdi", "alf.verd88@gmail.com"),
("Mario", "Lanaro", "mario.lnr@outlook.com"),
("Gianna", "Colte", "colt.gianna1@gmail.com"),
("Marta", "Testolin", "marta.testolin11@gmail.com");

-- Full name
SELECT CONCAT(UPPER(last_name),', ', first_name) as full_name from employees;

-- Email lowercase
SELECT LOWER(email) from employees;

-- Full name length
SELECT 
  CONCAT(UPPER(last_name),', ', first_name) as full_name,
  LENGTH(CONCAT(UPPER(last_name), first_name)) as length_full_name 
from employees;
  
-- Last name's first letter M
SELECT * FROM employees
WHERE last_name LIKE 'M%';







-- =====================================
-- EXERCISE 13 — Employee & Sales Ranking
-- =====================================
-- Create tables:
--
-- employees:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- first_name (VARCHAR)
-- last_name (VARCHAR)
--
-- sales:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- employee_id (INT)
-- amount (DECIMAL)
--
-- Insert at least 5 employees and 10 sales
--
-- Then write queries to:
-- 1) Show full employee name and total sales
-- 2) Rank employees by total sales (highest first)
-- 3) Show only the TOP 3 employees
-- 4) Show employees who sold more than the average total sales

/*
drop table employees;
drop table sales;
*/

CREATE TABLE IF NOT EXISTS employees(
  employee_id int not null primary key auto_increment,
  first_name varchar(255) not null,
  last_name varchar(255) not null
);

CREATE TABLE IF NOT EXISTS sales(
  sales_id int primary key not null auto_increment,
  employee_id int not null,
  amount decimal(10,2) not null
);

INSERT INTO employees(first_name, last_name) VALUES 
("Andrea", "Luigini"),
("Marco", "Grigi"),
("Lucia", "Rosselli"),
("Matteo", "Rossi"),
("Angela", "Pagliuca"),
("Costanzo", "Arringhi");

INSERT INTO sales(employee_id, amount) values
(2, 34.33),
(1, 18),
(5, 12.99),
(2, 57.09),
(3, 90.87),
(4, 9.99),
(1, 7.88),
(5, 19),
(5, 9),
(2, 39.10),
(3, 59.99),
(2, 13.45);

-- Show full employee name and total sales, and rank employees by total sales (highest first)
SELECT 
  CONCAT(last_name,' ', first_name) as full_name, 
  sum(amount) as total_sales
FROM employees AS emp
LEFT JOIN sales AS sal
ON emp.employee_id = sal.employee_id
GROUP BY emp.employee_id
ORDER BY sum(amount) DESC;

-- Show only the TOP 3 employees
SELECT 
  CONCAT(last_name,' ', first_name) as full_name, 
  sum(amount) as total_sales
FROM employees AS emp
LEFT JOIN sales AS sal
ON emp.employee_id = sal.employee_id
GROUP BY emp.employee_id
ORDER BY sum(amount) DESC LIMIT 3;

-- Show employees who sold more than the average total sales
SELECT 
  CONCAT(emp.last_name, ' ', emp.first_name) AS full_name,
  SUM(sal.amount) AS total_sales
FROM employees AS emp
JOIN sales AS sal
  ON emp.employee_id = sal.employee_id
GROUP BY emp.employee_id
HAVING SUM(sal.amount) > (
  SELECT AVG(employee_total)
  FROM (
    SELECT 
      SUM(amount) AS employee_total
    FROM sales
    GROUP BY employee_id
  ) AS totals
);
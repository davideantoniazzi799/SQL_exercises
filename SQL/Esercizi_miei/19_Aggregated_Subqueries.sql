-- =====================================
-- EXERCISE 4 — Aggregated Subquery
-- =====================================
-- Create a table "departments":
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- name (VARCHAR)
--
-- Create a table "staff":
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- name (VARCHAR)
-- department_id (INT)
-- salary (DECIMAL)
--
-- Insert at least 4 departments and 10 staff members
--
-- Then write a query to:
-- Show employees who earn MORE than
-- the average salary of their own department

CREATE TABLE IF NOT EXISTS departments(
  department_id int primary key not null auto_increment,
  name varchar(255) not null unique
);

CREATE TABLE IF NOT EXISTS staff(
  staff_id int primary key not null auto_increment,
  name varchar(255) not null,
  department_id int not null,
  salary decimal(10,2) not null
);

INSERT INTO departments(name) VALUES 
("Logistics"),
("Transports"),
("Technical Office"),
("Management"),
("Security"),
("HR");

INSERT INTO staff(name, department_id, salary) values
("Luca Rossi", 2, 1235.55),
("Mario Verdi", 1, 1400),
("Lucia Gigli", 3, 1500.99),
("Andrea Stambi", 5, 1350),
("Ettore Greco", 4, 2800),
("Marco Cappelli", 1, 1200),
("Sara Tedeschi", 4, 2900),
("Paolo Testolin", 2, 1300),
("Sofia Amato", 6, 1400),
("Armando Corridi", 3, 1600),
("Stefano Fontana", 3, 1700);

-- Task:
-- Use a correlated subquery that calculates
-- the average salary per department

-- Show employees who earn MORE than the average salary of their own department
SELECT  
  s.staff_id,
  s.name,
  s.salary,
  d.department
  FROM staff s
JOIN (
  SELECT 
    department_id,
    name AS department
  FROM departments
) d
ON s.department_id = d.department_id
WHERE s.salary > (
  SELECT 
    avg(salary)
  FROM staff s2
  WHERE s2.department_id = s.department_id -- "What is the average salary of THIS employee’s department?"
);
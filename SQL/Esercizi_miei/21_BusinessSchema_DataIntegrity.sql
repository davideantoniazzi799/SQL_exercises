-- ==========================================================
-- EXERCISE 1 — Business Schema & Data Integrity
-- ==========================================================
-- Create tables:
--
-- departments:
--   id (INT, PRIMARY KEY, AUTO_INCREMENT)
--   name (VARCHAR, UNIQUE, NOT NULL)
--
-- employees:
--   id (INT, PRIMARY KEY, AUTO_INCREMENT)
--   first_name (VARCHAR, NOT NULL)
--   last_name (VARCHAR, NOT NULL)
--   department_id (INT, FK → departments.id)
--   hire_date (DATE, NOT NULL)
--   salary (DECIMAL, CHECK salary BETWEEN 1200 AND 6000)
--
-- tasks:
--   id (INT, PRIMARY KEY, AUTO_INCREMENT)
--   employee_id (INT, FK → employees.id)
--   title (VARCHAR, NOT NULL)
--   due_date (DATE)
--   status (VARCHAR DEFAULT 'OPEN')
--
-- Insert:
--   - 4 departments
--   - 8 employees
--   - 12 tasks

-- Then write queries to:
-- 1) Show each employee with their department name
-- 2) Show number of employees per department
-- 3) Show employees hired in the last 2 years
-- 4) Show employees who have no tasks assigned
-- 5) Show departments where average salary is above 3000

/*
DROP TABLE departments;
DROP TABLE employees;
DROP TABLE tasks;
*/

CREATE TABLE IF NOT EXISTS departments(
  department_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) UNIQUE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE employees(
  employee_id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  department_id INT NOT NULL,
  hire_date DATE NOT NULL,
  salary DECIMAL(10,2) NOT NULL CHECK (salary BETWEEN 1200 AND 6000),

  FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE -- if a department_id changes, the information changes also for the employees related to it
) ENGINE=InnoDB;

CREATE TABLE tasks(
  task_id INT PRIMARY KEY AUTO_INCREMENT,
  employee_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  due_date DATE,
  status VARCHAR(255) DEFAULT 'open',

  FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id)
    ON DELETE CASCADE -- if an employee is deleted, also its tasks are
    ON UPDATE CASCADE 
) ENGINE=InnoDB;

INSERT INTO departments(name) VALUES
("Logistica"),
("Ufficio Tecnico"),
("Saldatura"),
("Pulitura");

INSERT INTO employees(first_name, last_name, department_id, hire_date, salary) values
("Luca", "Rossi", 2, "2022-08-28", 1300),
("Sofia", "Cauci", 1, "2024-09-18", 1450),
("Antonella", "Sebastiani", 2, "2021-06-19", 1600),
("Stefano", "Gentili", 3, "2023-01-15", 1700),
("Marco", "Terrioli", 4, "2024-11-15", 1300),
("Alberto", "Costanzo", 1, "2021-11-12", 1650),
("Matteo", "Andreoni", 3, "2021-07-06", 1800),
("Luisa", "Ceroni", 2, "2025-10-10", 1400);

INSERT INTO tasks(employee_id, title, due_date, status) values 
(2, "Spedizione", "2026-07-07", "open"),
(1, "Corrispondenze", "2026-03-01", "open"),
(5, "Controllo mensile rimanenze", "2026-01-31", "closed"),
(6, "Chiamare cliente lamiere", "2026-03-02", "open"),
(4, "Pulizia camera zona 1", "2025-09-08", "closed"),
(6, "Saldo totale rimanenze", "2026-12-31", "open"),
(2, "Chiusura bilancio annuale", "2026-12-31", "open"),
(8, "Spedizione pacco lavoro", "2026-04-01", "open"),
(4, "Firma contratto", "2026-01-31", "closed"),
(3, "Conferma ferie estive", "2026-02-25", "open"),
(1, "Chiamata per conferma ordine X", "2026-02-10", "open"),
(8, "Progetto disegno", "2026-02-27", "open");

-- Show each employee with their department name
SELECT 
  employees.employee_id,
  employees.first_name, 
  employees.last_name, 
  employees.department_id, 
  departments.name
FROM employees
LEFT JOIN departments 
ON employees.department_id = departments.department_id;

-- Show number of employees per department
SELECT 
  departments.department_id,
  departments.name,
  COUNT(employees.employee_id) AS total_employees
FROM departments
LEFT JOIN employees 
ON departments.department_id = employees.department_id
GROUP BY departments.department_id;

-- Show employees hired in the last 2 years
select * from employees
WHERE (YEAR(CURDATE()) - YEAR(hire_date)) < 3;

-- Show employees who have no tasks assigned
SELECT 
  e.employee_id,
  e.first_name,
  e.last_name
FROM employees e
LEFT JOIN tasks t
ON e.employee_id = t.employee_id
WHERE t.employee_id IS NULL;

-- Show departments where average salary is above 3000
SELECT 
  dep.name,
  avg(emp.salary) AS average_salary
FROM departments AS dep
JOIN employees AS emp
ON dep.department_id = emp.department_id
GROUP BY dep.department_id
HAVING avg(emp.salary) > 3000;
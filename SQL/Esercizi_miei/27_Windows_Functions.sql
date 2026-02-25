-- ==========================================================
-- WINDOW FUNCTIONS — ENTRY-LEVEL PRACTICE
-- ==========================================================
-- Window functions allow you to perform calculations
-- across a set of rows related to the current row
-- WITHOUT collapsing rows like GROUP BY does.
--
-- In these exercises, you will practice:
-- - OVER()
-- - PARTITION BY
-- - ORDER BY inside window functions
-- - ROW_NUMBER()
-- - RANK()
--
-- IMPORTANT:
-- Window functions are written in the SELECT clause
-- and do NOT replace WHERE or GROUP BY.
--
-- Do NOT use subqueries unless explicitly requested.

-- ==========================================================
-- EXERCISE 1 — Global Average with OVER()
-- ==========================================================
-- Using an employees table:
-- (employee_id, first_name, department_id, salary)
--
-- Write a query that:
-- Shows each employee with:
-- - their salary
-- - the average salary of ALL employees
--
-- The average salary must appear on every row
-- using a window function.

SELECT 
  employee_id, 
  first_name, 
  last_name, 
  department_id,
  salary,
  avg(salary) OVER () as average_salary
FROM employees;

-- ==========================================================
-- EXERCISE 2 — Department Average Salary
-- ==========================================================
-- Using the same employees table
--
-- Write a query that:
-- Shows each employee with:
-- - their salary
-- - the average salary of their OWN department
--
-- Use PARTITION BY department_id.

SELECT 
  employee_id, 
  first_name, 
  last_name, 
  department_id,
  salary,
  avg(salary) OVER (PARTITION BY department_id) as avg_department_salary
FROM employees;

-- ==========================================================
-- EXERCISE 3 — Salary Difference from Department Average
-- ==========================================================
-- Using the employees table
--
-- Write a query that:
-- Shows each employee with:
-- - salary
-- - department average salary
-- - the difference between their salary
--   and the department average
--
-- (salary - department_avg)
SELECT 
  employee_id, 
  first_name, 
  last_name, 
  department_id,
  salary,
  round(avg(salary) OVER (PARTITION BY department_id), 2) as avg_department_salary,
  round(salary -  avg(salary) OVER (PARTITION BY department_id), 2) as avg_department_difference
FROM employees;

-- ==========================================================
-- EXERCISE 4 — Row Number per Department
-- ==========================================================
-- Using the employees table
--
-- Write a query that:
-- Assigns a row number to each employee
-- within their department
--
-- The highest salary should have row number = 1
--
-- Use:
-- ROW_NUMBER() with PARTITION BY and ORDER BY.

SELECT 
  employee_id, 
  first_name, 
  last_name, 
  department_id,
  salary,
  ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) as employees_salary_order
FROM employees;

-- ==========================================================
-- EXERCISE 5 — Ranking Salaries (RANK vs DENSE_RANK)
-- ==========================================================
-- Using the employees table
--
-- Write a query that:
-- Shows each employee with:
-- - their salary
-- - their rank within the department using RANK()
-- - their rank within the department using DENSE_RANK()
--
-- Order salaries from highest to lowest.
--
-- Observe the difference when two employees
-- have the same salary.
SELECT 
  employee_id, 
  first_name, 
  last_name, 
  department_id,
  salary,
  RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) as employees_salary_order_r,
  DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) as employees_salary_order_rd
FROM employees;

-- ==========================================================
-- EXERCISE 1 — Running Salary Total per Department
-- ==========================================================
-- Write a query that:
-- Shows each employee with:
-- - salary
-- - a running total of salaries within their department
--
-- The running total should:
-- - reset for each department
-- - be ordered by salary DESC

-- Hint:
-- Use SUM() OVER() with PARTITION BY and ORDER BY
SELECT 
  employee_id, 
  first_name, 
  last_name, 
  department_id,
  salary,
  SUM(salary) OVER(
   PARTITION BY department_id 
   ORDER BY salary DESC
   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as total_dep_salary
FROM employees;

-- ==========================================================
-- EXERCISE 2 — Compare Salary with Previous Employee
-- ==========================================================
-- Write a query that:
-- Shows each employee with:
-- - salary
-- - the previous employee's salary in the same department
-- - the difference between their salary and the previous one
--
-- Order employees by salary DESC within each department.
--
-- Hint:
-- Use LAG()
SELECT 
  employee_id, 
  first_name, 
  last_name, 
  department_id,
  salary,
  LAG (salary, 1, 0) OVER (PARTITION BY department_id ORDER BY hire_date) as prev_dep_emp_salary,
  salary - LAG (salary, 1, 0) OVER (PARTITION BY department_id ORDER BY hire_date) as diff_prev_dep_emp_salary
FROM employees;

-- ==========================================================
-- EXERCISE 3 — Salary Percent Rank per Department
-- ==========================================================
-- Write a query that:
-- Shows each employee with:
-- - salary
-- - their PERCENT_RANK within their department
--
-- Highest salary should be closest to 1.
--
-- Hint:
-- Use PERCENT_RANK() with ORDER BY salary
SELECT 
  employee_id, 
  first_name, 
  last_name, 
  department_id,
  salary,
  1 - PERCENT_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) as dep_emp_percent_rank
FROM employees;

-- ==========================================================
-- EXERCISE 4 — Quartile Classification
-- ==========================================================
-- Write a query that:
-- Divides employees into 4 salary groups (quartiles)
-- within each department.
--
-- Show:
-- - employee
-- - salary
-- - quartile number (1 to 4)
--
-- Hint:
-- Use NTILE(4)
SELECT 
  employee_id, 
  first_name, 
  last_name, 
  department_id,
  salary,
  NTILE(4) OVER (PARTITION BY department_id ORDER BY salary) as salary_group
FROM employees;

-- ==========================================================
-- EXERCISE 5 — Department Salary Gap Using Window Functions
-- ==========================================================
-- Write a query that:
-- Shows each employee with:
-- - salary
-- - highest salary in their department
-- - lowest salary in their department
-- - salary gap (max - min)
--
-- Do NOT use GROUP BY.
--
-- Hint:
-- Use MAX() OVER() and MIN() OVER()
SELECT 
  employee_id, 
  first_name, 
  last_name, 
  department_id,
  salary,
  MAX(salary) OVER (PARTITION BY department_id) AS max_dep_salary,
  MIN(salary) OVER (PARTITION BY department_id) AS min_dep_salary,
  (MAX(salary) OVER (PARTITION BY department_id) - 
  MIN(salary) OVER (PARTITION BY department_id)) as max_min_dep_diff
FROM employees;

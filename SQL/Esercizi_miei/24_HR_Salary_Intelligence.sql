-- ==========================================================
-- EXERCISE 4 — HR Salary Intelligence
-- ==========================================================
-- Using employees table from Exercise 1

-- Write queries to:
-- 1) Show employees who earn more than the average salary
--    of their own department (correlated subquery)
-- 2) Rank employees by salary within their department
--    WITHOUT using LIMIT or window functions
-- 3) Show only the TOP 2 highest-paid employees per department
-- 4) Show departments where the salary gap
--    (MAX - MIN) is greater than 2000

-- 1) Show employees who earn more than the average salary
--    of their own department (correlated subquery)
SELECT *
FROM employees AS e
WHERE e.salary > (
  SELECT AVG(e2.salary)
  FROM employees e2
  WHERE e2.department_id = e.department_id
);

-- Rank employees by salary within their department
--    WITHOUT using LIMIT or window functions
SELECT
  e.employee_id,
  e.first_name,
  e.last_name,
  e.department_id,
  e.salary,
  (
    SELECT COUNT(*)
    FROM employees e2
    WHERE e2.department_id = e.department_id
      AND e2.salary > e.salary
  ) + 1 AS salary_rank
FROM employees e
ORDER BY e.department_id, salary_rank;


-- Show only the TOP 2 highest-paid employees per department
SELECT
  e.employee_id,
  e.first_name,
  e.last_name,
  e.department_id,
  e.salary
FROM employees e
WHERE (
  SELECT COUNT(*)
  FROM employees e2
  WHERE e2.department_id = e.department_id
    AND e2.salary > e.salary
) < 2
ORDER BY e.department_id, e.salary DESC;

-- Show departments where the salary gap (MAX - MIN) is greater than 2000
SELECT
  department_id,
  MAX(salary) AS max_salary,
  MIN(salary) AS min_salary,
  MAX(salary) - MIN(salary) AS salary_gap
FROM employees
GROUP BY department_id
HAVING MAX(salary) - MIN(salary) > 2000;

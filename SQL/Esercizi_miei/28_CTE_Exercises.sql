-- ==========================================================
-- EXERCISE 1 — Basic CTE (Simple Filtering)
-- ==========================================================
-- Using the employees table:
-- (employee_id, first_name, last_name, department_id, salary)
--
-- Create a CTE named high_earners that:
-- - selects employees with salary > 80000
--
-- Then:
-- - select all columns from the CTE
-- - order the result by salary DESC
--
-- Goal:
-- Practice basic WITH syntax.

WITH high_earners AS (
  SELECT *
  FROM employees
  where salary > 80000
)
SELECT *
FROM high_earners
order by salary desc;
  
-- ==========================================================
-- EXERCISE 2 — CTE with Aggregation
-- ==========================================================
-- Using the employees table:
--
-- Create a CTE named department_avg that:
-- - calculates the average salary per department
-- - shows department_id and avg_salary
--
-- Then:
-- - select only departments where avg_salary > 75000
-- - order by avg_salary DESC
--
-- Goal:
-- Practice GROUP BY inside a CTE.

WITH department_avg AS(
  select
    department_id,
    avg(salary) as avg_salary
  from employees
  group by department_id
)
SELECT department_id, avg_salary
FROM department_avg
WHERE avg_salary>75000
order by avg_salary desc;
  
-- ==========================================================
-- EXERCISE 3 — CTE Replacing a Subquery
-- ==========================================================
-- Using the employees table:
--
-- Create a CTE named company_avg that:
-- - calculates the average salary of ALL employees
--
-- Then:
-- - select all employees whose salary is above the company average
-- - show employee name, salary, and company average
--
-- Goal:
-- Use a CTE instead of a scalar subquery.

WITH company_avg as(
  SELECT round(avg(salary), 2) as salary_avg
  FROM employees
)
SELECT 
  e.first_name,
  e.last_name,
  e.salary,
  c.salary_avg
FROM employees e
CROSS JOIN company_avg c
WHERE e.salary > c.salary_avg;
/*
Global aggregation
No GROUP BY
Returns one row
Needs CROSS JOIN
*/


-- ==========================================================
-- EXERCISE 4 — Multiple CTEs
-- ==========================================================
-- Using the employees table:
--
-- Create two CTEs:
--
-- 1) department_stats:
--    - department_id
--    - max_salary
--    - min_salary
--
-- 2) salary_gap:
--    - department_id
--    - salary_gap (max_salary - min_salary)
--
-- Then:
-- - select all columns from salary_gap
-- - order by salary_gap DESC
--
-- Goal:
-- Practice chaining multiple CTEs.

WITH department_stats AS(
  SELECT department_id, 
    MAX(salary) as max_salary, 
    MIN(salary) as min_salary
  FROM employees
  GROUP BY department_id
),
salary_gap as(
  SELECT department_id,
  (max_salary - min_salary) as sal_gap
  FROM department_stats 
)
SELECT department_id, sal_gap
FROM salary_gap
order by sal_gap desc;

-- ==========================================================
-- EXERCISE 5 — CTE + JOIN
-- ==========================================================
-- Using the employees table:
--
-- Create a CTE named ranked_employees that:
-- - assigns ROW_NUMBER()
--   partitioned by department_id
--   ordered by salary DESC
--
-- Then:
-- - select only employees with row_number = 1
-- - show employee name, department_id, and salary
--
-- Goal:
-- Combine CTE with window functions.

WITH ranked_employees AS(
  SELECT 
    first_name, 
    last_name,
    department_id, 
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) as employees_salary_order
  from employees
)
SELECT 
  first_name, 
  last_name,
  department_id, 
  salary
FROM ranked_employees
WHERE employees_salary_order = 1;

-- ==========================================================
-- EXERCISE 6 — CTE + JOIN (Department Comparison)
-- ==========================================================
-- Using the employees table:
-- (employee_id, first_name, last_name, department_id, salary)
--
-- Create a CTE named department_avg that:
-- - calculates the average salary per department
--
-- Then:
-- - join employees with department_avg
-- - show:
--     first_name
--     last_name
--     department_id
--     salary
--     avg_salary
--     difference between salary and department average
--
-- Order results by department_id, salary DESC.
--
-- Goal:
-- Practice joining a CTE back to the base table.

WITH department_avg as (
  select 
    department_id,
    round(avg(salary), 2) as average_salary
  from employees
  group by department_id
)
select 
  e.first_name, 
  e.last_name, 
  e.department_id, 
  e.salary, 
  d.average_salary, 
  (e.salary - d.average_salary) as diff_salary_depavg
from employees e
join department_avg d
on e.department_id = d.department_id
order by e.department_id, e.salary desc;
/*
Grouped aggregation
Uses GROUP BY
Returns multiple rows
Needs normal JOIN with ON condition
*/
  
-- ==========================================================
-- EXERCISE 7 — CTE with HAVING Logic Separation
-- ==========================================================
-- Using the employees table:
--
-- Create a CTE named department_counts that:
-- - counts number of employees per department
-- - shows department_id and employee_count
--
-- Then:
-- - select only departments with more than 3 employees
-- - order by employee_count DESC
--
-- Goal:
-- Separate aggregation logic from filtering logic.
WITH department_counts as (
  select 
    department_id, 
    count(*) as employee_count 
  from employees 
  group by department_id
)
select 
  department_id, 
  employee_count 
from department_counts 
where employee_count > 3
order by employee_count DESC;

-- ==========================================================
-- EXERCISE 8 — CTE Reuse (Above Department Average Only)
-- ==========================================================
-- Using the employees table:
--
-- Create a CTE named department_avg that:
-- - calculates average salary per department
--
-- Then:
-- - join it to employees
-- - select only employees whose salary is ABOVE
--   their department average
--
-- Show:
--     first_name
--     last_name
--     department_id
--     salary
--     avg_salary
--
-- Order by department_id, salary DESC.
--
-- Goal:
-- Combine CTE aggregation with conditional filtering.
with department_avg as (
  select 
    department_id, 
    round(avg(salary), 2) as dep_avg_salary
  from employees
  group by department_id
)
select 
  e.first_name, 
  e.last_name, 
  e.department_id, 
  e.salary, 
  d.dep_avg_salary
from employees e
join department_avg d
on e.department_id = d.department_id
where e.salary > d.dep_avg_salary
order by e.employee_id, e.salary desc;

-- ==========================================================
-- EXERCISE 9 — CTE + Window Function (Top 2 Per Department)
-- ==========================================================
-- Using the employees table:
--
-- Create a CTE named ranked_employees that:
-- - assigns ROW_NUMBER()
--   partitioned by department_id
--   ordered by salary DESC
--
-- Then:
-- - select employees where row_number <= 2
-- - show:
--     first_name
--     last_name
--     department_id
--     salary
--
-- Order by department_id, salary DESC.
--
-- Goal:
-- Extend previous ranking logic.
with ranked_employees as (
  SELECT 
    first_name, 
    last_name,
    department_id, 
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) as employees_salary_order
  from employees
)
SELECT 
  first_name, 
  last_name,
  department_id, 
  salary
FROM ranked_employees
WHERE employees_salary_order <= 2
Order by department_id, salary DESC;

-- ==========================================================
-- EXERCISE 10 — Introductory Recursive CTE (Numbers 1–10)
-- ==========================================================
-- Create a recursive CTE named numbers that:
-- - starts at 1
-- - increments by 1
-- - stops at 10
--
-- Then:
-- - select all numbers from the CTE
--
-- Goal:
-- Practice basic recursive CTE structure.
--
-- Hint:
-- Use:
--     WITH RECURSIVE
--     UNION ALL
WITH RECURSIVE number(n) AS (
  SELECT 1              -- anchor member
  UNION ALL
  SELECT n + 1          -- recursive member
  FROM number
  WHERE n < 10          -- stopping condition
)
SELECT * FROM number;

/*
==========================================================
EXERCISE 11 — Multi-CTE Salary Intelligence
==========================================================
Using the employees table:
(employee_id, first_name, last_name, department_id, salary)
Create two CTEs:
1) department_avg
- department_id
- avg_salary
2) ranked_employees
- include ROW_NUMBER()
partitioned by department_id
ordered by salary DESC
Then:
- Join both CTEs
- Show only employees:
whose salary is above department average
AND ranked in top 3 within their department
Show:
first_name, last_name, department_id, salary, avg_salary, rank
Order by department_id, salary DESC
Goal:
Practice stacking multiple CTEs with ranking + filtering.
*/
with department_avg as(
  select 
    department_id, 
    round(avg(salary), 2) as dep_avg_salary
  from employees
  group by department_id
),
ranked_employees as (
  SELECT 
    first_name, 
    last_name,
    department_id, 
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) as employees_salary_rank
  from employees
)
SELECT 
  r.first_name, 
  r.last_name, 
  r.department_id, 
  r.salary, 
  d.dep_avg_salary, 
  r.employees_salary_rank
FROM ranked_employees r
JOIN department_avg d
  on r.department_id = d.department_id
where r.salary > d.dep_avg_salary AND r.employees_salary_rank <= 3
order by r.department_id, r.salary DESC;

/*
==========================================================
EXERCISE 12 — Department Salary Gap Filter
==========================================================
Using employees table
Create a CTE department_stats that:
- department_id
- max_salary
- min_salary
- salary_gap (max - min)
Then:
- Join employees with department_stats
- Show only departments where salary_gap > 5000
Show:
first_name, last_name, department_id, salary, salary_gap
Order by salary_gap DESC, salary DESC
Goal:
Combine aggregation CTE + conditional join filter.
*/
with department_stats as(
  select 
    department_id, 
    max(salary) as max_salary, 
    min(salary) as min_salary, 
    max(salary)-min(salary) as salary_gap
  from employees
  group by department_id
)
select e.first_name, e.last_name, e.department_id, e.salary, d.salary_gap
from employees e
join department_stats d
  on e.department_id = d.department_id
where d.salary_gap > 5000
Order by d.salary_gap DESC, e.salary DESC;

/*
==========================================================
EXERCISE 13 — CTE + Global Percentile Filtering
==========================================================
Using employees table
Create a CTE named salary_totals:
- employee_id
- salary
Then:
- Calculate total number of employees
- Keep only employees whose salary is in the TOP 25% of all employees
Do NOT use LIMIT.
Hint:
Count how many salaries are higher than each employee.
Show:
first_name, last_name, salary
Order by salary DESC
Goal: Use CTE + ranking logic without window functions.
*/
with salary_totals as(
  select employee_id, salary
  from employees
)
select e.first_name, e.last_name, e.salary
from employees e
WHERE ( 
  SELECT COUNT(*)
  FROM salary_totals s2
  WHERE s2.salary > e.salary
) < (
  SELECT COUNT(*) * 0.25
  FROM salary_totals
)
Order by e.salary DESC;

/*
==========================================================
EXERCISE 14 — Recursive CTE with Salary Growth Simulation
==========================================================
Create a recursive CTE that:
- Starts with a base salary of 30000
- Increases salary by 5% each year
- Simulates 10 years
Output:
year_number, salary
Format salary rounded to 2 decimals.
Goal: Practice recursive numeric growth logic.
*/
WITH RECURSIVE salary_growth(year_number, salary) AS (
  SELECT 1, 30000.00
  UNION ALL
  SELECT year_number + 1, round(salary * 1.05, 2)      
  FROM salary_growth
  WHERE year_number < 10
)
SELECT *
FROM salary_growth;

/*
==========================================================
EXERCISE 15 — CTE + Running Department Total
==========================================================
Using employees table
Create a CTE named salary_running_total:
- Include:
employee_id, department_id, salary, cumulative_salary, 
cumulative_salary should be: SUM(salary) OVER (PARTITION BY department_id ORDER BY salary DESC)
Then:
- From that CTE
- Show only rows where cumulative_salary exceeds 50% of the department total salary
Hint:
You may need a second CTE to calculate department totals.
Show: 
employee_id, department_id, salary, cumulative_salary
Order by department_id, salary DESC
Goal: Combine window function CTE + filtering layer.
*/
with salary_running_total as(
  select 
    employee_id, 
    department_id, 
    salary, 
    SUM(salary) OVER (PARTITION BY department_id ORDER BY salary DESC) as cumulative_salary
  from employees), 
department_total_salary as(
  select 
    department_id, 
    sum(salary) as department_totals 
  from employees 
  group by department_id
)
select s.employee_id, s.department_id, s.salary, s.cumulative_salary
from salary_running_total s
JOIN department_total_salary d
    ON s.department_id = d.department_id
WHERE s.cumulative_salary > d.department_totals * 0.5
Order by s.department_id, s.salary DESC;
-- =====================================
-- EXERCISE 7 — Date & Time Functions
-- =====================================
-- Create a table "projects" with:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- project_name (VARCHAR)
-- start_date (DATE)
-- end_date (DATE)
--
-- Insert at least 5 projects
--
-- Then write queries to:
-- 1) Show all project durations in days
-- 2) Show only projects that last more than 30 days
-- 3) Show projects that started in the current year
-- 4) Show how many days remain until each project ends

CREATE TABLE projects(
  project_id int primary key not null auto_increment,
  project_name varchar(255) not null unique,
  start_date date not null,
  end_date date not null
);

INSERT INTO projects(project_name, start_date, end_date) values
("Robo_Call Scam", "2023-12-01", "2024-12-01"),
("Space Shuttle", "2018-06-01", "2026-12-31"),
("Phone Call Translator", "2022-03-01", "2024-10-08"),
("Pizza_Avatar", "2021-09-01", "2022-02-01"),
("Waste Recycle", "2016-12-01", "2028-03-31"),
("Future Generation", "2023-11-15", "2024-06-01");

-- Project duration days
SELECT 
  project_name, 
  DATEDIFF(end_date, start_date) as Total_days
FROM projects;

-- Projects duration > 30 days
SELECT 
  project_name, 
  DATEDIFF(end_date, start_date) as total_days
FROM projects
HAVING total_days > 30;

-- Project started this year
SELECT * FROM projects WHERE YEAR(start_date) = year(CURDATE());

-- Days remaining for every project
SELECT 
  project_name, 
  DATEDIFF(end_date, CURDATE()) as days_remaing
FROM projects
WHERE end_date > CURDATE();
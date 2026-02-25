-- =====================================
-- EXERCISE 1 — Basic SELECT & Filtering
-- =====================================
-- Create a table "students" with:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- name (VARCHAR)
-- age (INT)
-- city (VARCHAR)
--
-- Insert at least 5 students
--
-- Then write queries to:
-- 1) Select all students
-- 2) Select only students older than 20
-- 3) Select students from "Rome"
-- 4) Select only name and city columns

CREATE TABLE IF NOT EXISTS students(
  students_id int PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name varchar(50) NOT NULL,
  age TINYINT UNSIGNED NOT NULL,
  city varchar(50) NOT NULL
);

-- DROP TABLE students

INSERT INTO students (name, age, city) values
("Luca", 23, "Rome"),
("Andrea", 24, "Milan"),
("Sofia", 19, "Venice"),
("Maria", 25, "Venice"),
("Matteo", 21, "Rome"),
("Aurora", 25, "Bari"),
("Alessandro", 18, "Genova"),
("Tommaso", 24, "Milan");

-- All the students
SELECT * FROM students;

-- Only students older than 20
SELECT * FROM students WHERE age > 20;

-- Only students from Rome
SELECT * FROM students WHERE city = 'Rome';

-- Only columns name and city
SELECT name, city FROM students;
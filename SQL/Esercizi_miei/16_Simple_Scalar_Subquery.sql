-- =====================================
-- EXERCISE 1 — Simple Scalar Subquery
-- =====================================
-- Create a table "movies" with:
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- title (VARCHAR)
-- rating (DECIMAL)
-- year_released (INT)
--
-- Insert at least 6 movies
--
-- Then write a query to:
-- Show all movies that have a rating higher than the average rating

CREATE TABLE IF NOT EXISTS movies(
  movie_id int primary key not null auto_increment,
  title varchar(255) not null unique,
  rating decimal(3,1) not null,
  year_released int not null
);

INSERT INTO movies (title, rating, year_released) VALUES
("Sky Warriors", 7.5, 2019),
("Ocean Deep", 8.2, 2021),
("Silent Code", 6.9, 2018),
("Red Horizon", 8.8, 2022),
("Night Signal", 7.1, 2020),
("Last Empire", 9.0, 2023);

-- Task:
-- Use a subquery in WHERE to compare each movie's rating
-- against the average rating of all movies

-- Comparison of every movie with average rating
SELECT 
  movie_id,
  title,
  rating,
  (SELECT avg(rating) from movies) as average_rating
FROM movies;

-- Movies with rating higher than the average
SELECT *
FROM movies
WHERE rating > (SELECT AVG(rating) FROM movies);

-- Movies with rating lower than the average
SELECT *
FROM movies
WHERE rating < (SELECT AVG(rating) FROM movies);



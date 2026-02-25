-- =====================================
-- EXERCISE 5 — Ranking Logic Subquery (Intermediate)
-- =====================================
-- Create a table "players":
-- id (INT, PRIMARY KEY, AUTO_INCREMENT)
-- name (VARCHAR)
-- score (INT)
-- country (VARCHAR)
--
-- Insert at least 10 players
--
-- Then write a query to:
-- Show players who are in the TOP 3 highest scores
-- WITHOUT using LIMIT

CREATE TABLE IF NOT EXISTS players (
  player_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  score INT NOT NULL,
  country VARCHAR(255) NOT NULL
);

INSERT INTO players(name, score, country) values
("Luca", 89, "Italy"),
("Jeff", 78, "Canada"),
("Robin", 79, "USA"),
("Dimitriv", 91, "Russia"),
("Andrey", 97, "Romania"),
("Pierre", 81, "France"),
("Rick", 90, "UK"),
("Sergio", 78, "Spain"),
("Stefanos", 92, "Greece"),
("Micheal", 85, "Germany");

-- Task:
-- Use a subquery that counts how many players
-- have a higher score than each player
-- and keep only those where that count is less than 3

-- Show players who are in the TOP 3 highest scores WITHOUT using LIMIT
SELECT
  p1.player_id,
  p1.name,
  p1.score,
  p1.country
FROM players p1
WHERE ( -- “How many players scored higher than THIS player?”
  SELECT COUNT(*)
  FROM players p2
  WHERE p2.score > p1.score
) < 3
ORDER BY p1.score DESC;
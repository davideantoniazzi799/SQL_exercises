-- =====================================
-- EXERCISE 3 — NOT IN Subquery
-- =====================================
-- Using the same authors and books tables
--
-- Write a query to:
-- Show authors who have NOT written any books

-- Task:
-- Use a subquery with NOT IN
-- to filter out authors that appear in the books table

-- Author without a written book
SELECT * 
FROM authors 
WHERE author_id NOT IN 
  (SELECT author_id 
  FROM books);








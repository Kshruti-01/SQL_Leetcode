/* Write your T-SQL query statement below */
-- CTE to find user who rated the most movies
WITH UserRatingCount AS (
    SELECT u.name, COUNT(*) AS rating_count
    FROM MovieRating mr
    JOIN Users u ON mr.user_id = u.user_id
    GROUP BY u.name
),
TopUser AS (
    SELECT TOP 1 name AS results
    FROM UserRatingCount
    ORDER BY rating_count DESC, name ASC
),

-- CTE to find highest average rated movie in Feb 2020
MovieRatingFeb AS (
    SELECT m.title, AVG(mr.rating * 1.0) AS avg_rating
    FROM MovieRating mr
    JOIN Movies m ON mr.movie_id = m.movie_id
    WHERE mr.created_at BETWEEN '2020-02-01' AND '2020-02-29'
    GROUP BY m.title
),
TopMovie AS (
    SELECT TOP 1 title AS results
    FROM MovieRatingFeb
    ORDER BY avg_rating DESC, title ASC
)

-- Final union of both results
SELECT * FROM TopUser
UNION ALL
SELECT * FROM TopMovie;

/* Write your T-SQL query statement below */
WITH OrderedQueue AS (
    SELECT *,
           SUM(weight) OVER (ORDER BY turn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_weight
    FROM Queue
),
ValidBoarding AS (
    SELECT *
    FROM OrderedQueue
    WHERE running_weight <= 1000
)
SELECT TOP 1 person_name
FROM ValidBoarding
ORDER BY turn DESC;

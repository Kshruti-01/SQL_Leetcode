/* Write your T-SQL query statement below */
WITH DailyAmount AS (
    SELECT 
        visited_on,
        SUM(amount) AS amount
    FROM Customer
    GROUP BY visited_on
),
MovingAverage AS (
    SELECT 
        d1.visited_on,
        SUM(d2.amount) AS amount,
        ROUND(AVG(CAST(d2.amount AS FLOAT)), 2) AS average_amount
    FROM DailyAmount d1
    JOIN DailyAmount d2 
        ON d2.visited_on BETWEEN DATEADD(DAY, -6, d1.visited_on) AND d1.visited_on
    GROUP BY d1.visited_on
)
SELECT *
FROM MovingAverage
WHERE visited_on >= (
    SELECT DATEADD(DAY, 6, MIN(visited_on)) FROM DailyAmount
)
ORDER BY visited_on;

/* Write your T-SQL query statement below */
WITH FirstLogin AS (
    SELECT 
        player_id, 
        MIN(event_date) AS first_login
    FROM Activity
    GROUP BY player_id
),
NextDayLogins AS (
    SELECT 
        a.player_id
    FROM Activity a
    JOIN FirstLogin f 
      ON a.player_id = f.player_id 
     AND a.event_date = DATEADD(DAY, 1, f.first_login)
)
SELECT 
    CAST(ROUND(
        1.0 * COUNT(DISTINCT n.player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity), 
        2
    ) AS DECIMAL(4,2)) AS fraction
FROM NextDayLogins n;

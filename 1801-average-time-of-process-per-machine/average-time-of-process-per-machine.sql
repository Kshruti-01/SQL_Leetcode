/* Write your T-SQL query statement below */
WITH ProcessTimes AS (
    SELECT 
        machine_id,
        process_id,
        MAX(CASE WHEN activity_type = 'start' THEN timestamp END) AS start_time,
        MAX(CASE WHEN activity_type = 'end' THEN timestamp END) AS end_time
    FROM 
        Activity
    GROUP BY 
        machine_id, process_id
),
Durations AS (
    SELECT 
        machine_id,
        end_time - start_time AS duration
    FROM 
        ProcessTimes
)
SELECT 
    machine_id,
    ROUND(AVG(duration), 3) AS processing_time
FROM 
    Durations
GROUP BY 
    machine_id;

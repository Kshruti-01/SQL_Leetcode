/* Write your T-SQL query statement below */
SELECT 
    w1.id
FROM 
    Weather w1
JOIN 
    Weather w2 ON DATEADD(DAY, 1, w2.recordDate) = w1.recordDate
WHERE 
    w1.temperature > w2.temperature;

/* Write your T-SQL query statement below */
SELECT 
    e.employee_id,
    e.name,
    COUNT(*) AS reports_count,
    ROUND(AVG(CAST(r.age AS FLOAT)), 0) AS average_age
FROM Employees e
JOIN Employees r ON e.employee_id = r.reports_to
GROUP BY e.employee_id, e.name
ORDER BY e.employee_id;



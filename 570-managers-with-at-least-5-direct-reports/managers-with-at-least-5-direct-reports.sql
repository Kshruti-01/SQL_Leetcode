/* Write your T-SQL query statement below */
SELECT 
    e.name
FROM 
    Employee e
JOIN (
    SELECT 
        managerId
    FROM 
        Employee
    WHERE 
        managerId IS NOT NULL
    GROUP BY 
        managerId
    HAVING 
        COUNT(*) >= 5
) AS mgrs
ON e.id = mgrs.managerId;

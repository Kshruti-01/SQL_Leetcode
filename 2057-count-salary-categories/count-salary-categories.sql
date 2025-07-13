/* Write your T-SQL query statement below */
-- Use CTE to count accounts per category
WITH SalaryCategory AS (
    SELECT 
        CASE 
            WHEN income < 20000 THEN 'Low Salary'
            WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
            WHEN income > 50000 THEN 'High Salary'
        END AS category
    FROM Accounts
),
CategoryCounts AS (
    SELECT category, COUNT(*) AS accounts_count
    FROM SalaryCategory
    GROUP BY category
)

-- Select from all fixed categories and LEFT JOIN with actual counts
SELECT 
    c.category,
    ISNULL(cc.accounts_count, 0) AS accounts_count
FROM (
    SELECT 'Low Salary' AS category
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'High Salary'
) AS c
LEFT JOIN CategoryCounts cc
    ON c.category = cc.category
ORDER BY 
    CASE c.category
        WHEN 'Low Salary' THEN 1
        WHEN 'Average Salary' THEN 2
        WHEN 'High Salary' THEN 3
    END;

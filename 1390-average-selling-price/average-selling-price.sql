/* Write your T-SQL query statement below */
SELECT 
    p.product_id,
    ROUND(
        CASE 
            WHEN SUM(u.units) = 0 OR SUM(u.units) IS NULL THEN 0
            ELSE SUM(u.units * p.price) * 1.0 / SUM(u.units)
        END,
        2
    ) AS average_price
FROM 
    Prices p
LEFT JOIN 
    UnitsSold u
    ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY 
    p.product_id;

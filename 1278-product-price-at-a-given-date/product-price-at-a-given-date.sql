/* Write your T-SQL query statement below */
WITH LatestChanges AS (
    SELECT 
        product_id, 
        MAX(change_date) AS max_date
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id
),
PriceOnDate AS (
    SELECT 
        p.product_id, 
        p.new_price
    FROM Products p
    JOIN LatestChanges lc
        ON p.product_id = lc.product_id 
        AND p.change_date = lc.max_date
)
SELECT 
    all_products.product_id, 
    ISNULL(pod.new_price, 10) AS price
FROM 
    (SELECT DISTINCT product_id FROM Products) all_products
LEFT JOIN 
    PriceOnDate pod 
    ON all_products.product_id = pod.product_id;

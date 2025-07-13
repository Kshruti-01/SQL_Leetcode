/* Write your T-SQL query statement below */
WITH FirstOrders AS (
    SELECT 
        customer_id, 
        MIN(order_date) AS first_order_date
    FROM Delivery
    GROUP BY customer_id
),
FirstOrderDetails AS (
    SELECT d.*
    FROM Delivery d
    JOIN FirstOrders f
      ON d.customer_id = f.customer_id 
     AND d.order_date = f.first_order_date
)
SELECT 
    ROUND(
        100.0 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) 
        / COUNT(*), 2
    ) AS immediate_percentage
FROM FirstOrderDetails;


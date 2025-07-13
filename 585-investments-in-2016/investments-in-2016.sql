/* Write your T-SQL query statement below */
SELECT 
    ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM Insurance
WHERE tiv_2015 IN (
    SELECT tiv_2015
    FROM Insurance
    GROUP BY tiv_2015
    HAVING COUNT(*) > 1
)
AND NOT EXISTS (
    SELECT 1
    FROM Insurance AS i2
    WHERE i2.lat = Insurance.lat 
      AND i2.lon = Insurance.lon 
      AND i2.pid <> Insurance.pid
);

-- Cohorts

-- Cohort analysis (customer retention)
WITH FirstPurchase AS (
    SELECT 
        CustomerID,
        MIN(OrderDate) AS FirstPurchaseDate
    FROM Orders
    GROUP BY CustomerID
),
MonthlyCohorts AS (
    SELECT 
        CustomerID,
        DATE_FORMAT(FirstPurchaseDate, '%Y-%m') AS CohortMonth,
        DATE_FORMAT(OrderDate, '%Y-%m') AS OrderMonth,
        TIMESTAMPDIFF(MONTH, FirstPurchaseDate, OrderDate) AS MonthsSinceFirstPurchase
    FROM Orders o
    JOIN FirstPurchase fp ON o.CustomerID = fp.CustomerID
)
SELECT 
    CohortMonth,
    COUNT(DISTINCT CASE WHEN MonthsSinceFirstPurchase = 0 THEN CustomerID END) AS Month0,
    COUNT(DISTINCT CASE WHEN MonthsSinceFirstPurchase = 1 THEN CustomerID END) AS Month1,
    COUNT(DISTINCT CASE WHEN MonthsSinceFirstPurchase = 2 THEN CustomerID END) AS Month2,
    ROUND(COUNT(DISTINCT CASE WHEN MonthsSinceFirstPurchase = 1 THEN CustomerID END) * 100.0 / 
          COUNT(DISTINCT CASE WHEN MonthsSinceFirstPurchase = 0 THEN CustomerID END), 2) AS RetentionRateMonth1
FROM MonthlyCohorts
GROUP BY CohortMonth
ORDER BY CohortMonth;

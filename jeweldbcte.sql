--- To create a CTE for TotalSales
WITH TotalSales AS (
    SELECT 
        o.CustomerID,
        SUM(o.TotalAmount) AS TotalSpent
    FROM 
        Orders o
    GROUP BY 
        o.CustomerID
)
SELECT 
    c.Name,
    ts.TotalSpent
FROM 
    Customers c
JOIN 
    TotalSales ts ON c.CustomerID = ts.CustomerID;

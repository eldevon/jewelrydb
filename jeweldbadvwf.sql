-- (Advanced Window Functions) - Running total, ranking, and moving averages
SELECT 
    o.OrderID,
    c.Name AS CustomerName,
    o.OrderDate,
    o.TotalAmount,
    -- Running total per customer
    SUM(o.TotalAmount) OVER (
        PARTITION BY o.CustomerID 
        ORDER BY o.OrderDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS CustomerRunningTotal,
    
    -- Rank customers by total spending
    RANK() OVER (
        ORDER BY SUM(o.TotalAmount) OVER (PARTITION BY o.CustomerID) DESC
    ) AS CustomerSpendingRank,
    
    -- Moving average of last 3 orders
    AVG(o.TotalAmount) OVER (
        ORDER BY o.OrderDate 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS MovingAvg3Orders,
    
    -- Percent of total sales
    o.TotalAmount / SUM(o.TotalAmount) OVER () * 100 AS PercentOfTotalSales
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
ORDER BY o.OrderDate;

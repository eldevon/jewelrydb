-- To calculate the total spent by each customer
SELECT 
    c.CustomerID,
    c.Name,
    SUM(o.TotalAmount) OVER (PARTITION BY c.CustomerID) AS TotalSpent
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID;

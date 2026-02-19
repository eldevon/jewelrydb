-- A subquery to find customers who spent more than the average
SELECT 
    Name 
FROM 
    Customers 
WHERE 
    CustomerID IN (SELECT CustomerID FROM Orders GROUP BY CustomerID HAVING SUM(TotalAmount) > (SELECT AVG(TotalAmount) FROM Orders));

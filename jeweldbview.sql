-- View for sales analytics (Business Intelligence)
CREATE VIEW SalesAnalytics AS
SELECT 
    DATE(o.OrderDate) AS SaleDate,
    c.CategoryName,
    p.Name AS ProductName,
    SUM(oi.Quantity) AS TotalQuantity,
    SUM(oi.Quantity * oi.Price) AS TotalRevenue,
    AVG(oi.Price) AS AveragePrice,
    COUNT(DISTINCT o.CustomerID) AS UniqueCustomers
FROM Orders o
JOIN Order_Items oi ON o.OrderID = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY DATE(o.OrderDate), c.CategoryName, p.Name;

-- Materialized view simulation (using table)
CREATE TABLE MonthlySalesSummary (
    MonthYear VARCHAR(7),
    CategoryID INT,
    TotalSales DECIMAL(10,2),
    TotalQuantity INT,
    PRIMARY KEY (MonthYear, CategoryID)
);

-- (An Event Scheduler) - Create event to update monthly sales summary
CREATE EVENT UpdateMonthlySales
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    -- Archive old orders
    INSERT INTO OrdersArchive
    SELECT * FROM Orders 
    WHERE OrderDate < DATE_SUB(NOW(), INTERVAL 1 YEAR);
    
    DELETE FROM Orders 
    WHERE OrderDate < DATE_SUB(NOW(), INTERVAL 1 YEAR);
    
    -- Update monthly summary
    TRUNCATE TABLE MonthlySalesSummary;
    
    INSERT INTO MonthlySalesSummary
    SELECT 
        DATE_FORMAT(o.OrderDate, '%Y-%m') AS MonthYear,
        p.CategoryID,
        SUM(oi.Quantity * oi.Price) AS TotalSales,
        SUM(oi.Quantity) AS TotalQuantity
    FROM Orders o
    JOIN Order_Items oi ON o.OrderID = oi.OrderID
    JOIN Products p ON oi.ProductID = p.ProductID
    GROUP BY DATE_FORMAT(o.OrderDate, '%Y-%m'), p.CategoryID;
END;

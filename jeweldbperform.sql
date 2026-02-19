-- (Performance Optimization) -- Index optimization
CREATE INDEX idx_orders_customer_date ON Orders(CustomerID, OrderDate);
CREATE INDEX idx_products_category_stock ON Products(CategoryID, Stock);
CREATE INDEX idx_order_items_product ON Order_Items(ProductID);

-- Partitioning by date (for large datasets)
ALTER TABLE Orders 
PARTITION BY RANGE (YEAR(OrderDate)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Query optimization with EXPLAIN
EXPLAIN ANALYZE
SELECT 
    c.Name,
    SUM(o.TotalAmount) AS TotalSpent,
    COUNT(o.OrderID) AS OrderCount
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= '2023-01-01'
GROUP BY c.CustomerID, c.Name
HAVING TotalSpent > 1000;

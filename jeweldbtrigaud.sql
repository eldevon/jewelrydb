-- Triggers for auditing and Low Stock Notification
-- Trigger for audit logging
CREATE TABLE OrderAudit (
    AuditID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    CustomerID INT,
    OldTotalAmount DECIMAL(10,2),
    NewTotalAmount DECIMAL(10,2),
    ChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    ChangedBy VARCHAR(100)
);

DELIMITER $$
CREATE TRIGGER OrderUpdateAudit
AFTER UPDATE ON Orders
FOR EACH ROW
BEGIN
    IF OLD.TotalAmount != NEW.TotalAmount THEN
        INSERT INTO OrderAudit (OrderID, CustomerID, OldTotalAmount, NewTotalAmount, ChangedBy)
        VALUES (NEW.OrderID, NEW.CustomerID, OLD.TotalAmount, NEW.TotalAmount, USER());
    END IF;
END$$
DELIMITER ;

-- Trigger for low stock notification
DELIMITER $$
CREATE TRIGGER LowStockAlert
AFTER UPDATE ON Products
FOR EACH ROW
BEGIN
    IF NEW.Stock < 5 AND OLD.Stock >= 5 THEN
        INSERT INTO Notifications (ProductID, Message, CreatedAt)
        VALUES (NEW.ProductID, CONCAT('Low stock alert: ', NEW.Name, ' has only ', NEW.Stock, ' units left'), NOW());
    END IF;
END$$
DELIMITER ;

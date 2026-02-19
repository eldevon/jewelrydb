-- (Transactional Management) - Complex transaction with savepoints
START TRANSACTION;

SAVEPOINT before_inventory_check;

-- Check inventory
SELECT @stock := Stock FROM Products WHERE ProductID = 1 FOR UPDATE;

IF @stock >= 2 THEN
    -- Place order
    INSERT INTO Orders (CustomerID, TotalAmount) VALUES (1, 1000.00);
    SET @order_id = LAST_INSERT_ID();
    
    SAVEPOINT before_order_items;
    
    -- Add order items
    INSERT INTO Order_Items (OrderID, ProductID, Quantity, Price)
    VALUES (@order_id, 1, 2, 500.00);
    
    -- Update stock
    UPDATE Products SET Stock = Stock - 2 WHERE ProductID = 1;
    
    COMMIT;
ELSE
    ROLLBACK TO SAVEPOINT before_inventory_check;
    SELECT 'Insufficient stock' AS Result;
    ROLLBACK;
END IF;

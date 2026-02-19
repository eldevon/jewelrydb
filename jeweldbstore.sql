-- A Stored Procedure to place an order with some validation
DELIMITER $$
CREATE PROCEDURE PlaceOrder(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_stock INT;
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_order_id INT;
    
    -- Check stock availability
    SELECT Stock, Price INTO v_stock, v_price 
    FROM Products WHERE ProductID = p_product_id;
    
    IF v_stock >= p_quantity THEN
        -- Calculate total
        SET v_total = v_price * p_quantity;
        
        -- Create order
        INSERT INTO Orders (CustomerID, TotalAmount) 
        VALUES (p_customer_id, v_total);
        
        SET v_order_id = LAST_INSERT_ID();
        
        -- Add order item
        INSERT INTO Order_Items (OrderID, ProductID, Quantity, Price)
        VALUES (v_order_id, p_product_id, p_quantity, v_price);
        
        SELECT 'Order placed successfully' AS Message, v_order_id AS OrderID;
    ELSE
        SELECT 'Insufficient stock' AS Message;
    END IF;
END$$
DELIMITER ;

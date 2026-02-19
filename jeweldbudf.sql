-- A User Defined Function to calculate the discount based on customer loyalty
DELIMITER $$
CREATE FUNCTION CalculateDiscount(customer_id INT, purchase_amount DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_orders INT;
    DECLARE discount_rate DECIMAL(5,2);
    
    -- Count customer orders
    SELECT COUNT(*) INTO total_orders 
    FROM Orders 
    WHERE CustomerID = customer_id;
    
    -- Determine discount based on loyalty
    IF total_orders >= 10 THEN
        SET discount_rate = 0.15;
    ELSEIF total_orders >= 5 THEN
        SET discount_rate = 0.10;
    ELSEIF total_orders >= 2 THEN
        SET discount_rate = 0.05;
    ELSE
        SET discount_rate = 0.00;
    END IF;
    
    RETURN purchase_amount * discount_rate;
END$$
DELIMITER ;

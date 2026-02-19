-- Insert Categories
INSERT INTO Categories (CategoryName) VALUES
('Rings'), ('Necklaces'), ('Bracelets'), ('Earrings');

-- Insert Customers
INSERT INTO Customers (Name, Email, Phone, Address) VALUES
('Alice Smith', 'alice@example.com', '123-456-7890', '123 Elm St'),
('Bob Johnson', 'bob@example.com', '234-567-8901', '456 Oak St'),
('Charlie Brown', 'charlie@example.com', '345-678-9012', '789 Pine St');

-- Insert Products
INSERT INTO Products (Name, Description, Price, Stock, CategoryID) VALUES
('Gold Ring', 'A beautiful gold ring.', 500.00, 10, 1),
('Diamond Necklace', 'Elegant diamond necklace.', 1200.00, 5, 2),
('Silver Bracelet', 'Stylish silver bracelet.', 300.00, 15, 3),
('Pearl Earrings', 'Classic pearl earrings.', 400.00, 20, 4);

-- Insert Orders
INSERT INTO Orders (CustomerID, TotalAmount) VALUES
(1, 500.00),
(2, 1200.00),
(3, 300.00);

-- Insert Order Items
INSERT INTO Order_Items (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 500.00),
(2, 2, 1, 1200.00),
(3, 3, 1, 300.00);

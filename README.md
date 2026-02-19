# jewelrydb
A jewelry store database blueprint database for the application that contains the setup and important procedures-functions
*** Database Design ***:
Entities and Relationships:

Customers: Stores customer information.
Products: Stores product details.
Orders: Stores order details.
Order_Items: Stores details of items in each order.
Categories: Stores product categories.
Schema Diagram:

Customers (CustomerID, Name, Email, Phone, Address)
Products (ProductID, Name, Description, Price, Stock, CategoryID)
Orders (OrderID, CustomerID, OrderDate, TotalAmount)
Order_Items (OrderItemID, OrderID, ProductID, Quantity, Price)
Categories (CategoryID, CategoryName)

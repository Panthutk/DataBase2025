#This line not gonna in real life work just for homework nar
DROP DATABASE IF EXISTS RestaurantTycoon;

CREATE DATABASE RestaurantTycoon;
USE RestaurantTycoon;

-- Insert Table

-- Customer Table
CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    customerName VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20)
);

-- Menu Table
CREATE TABLE Menu (
    menuID INT PRIMARY KEY,
    itemName VARCHAR(100),
    price DECIMAL(6,2),
    category VARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders (
    orderID INT PRIMARY KEY,
    customerID INT,
    orderDate DATE,
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    orderID INT,
    menuID INT,
    quantity INT,
    PRIMARY KEY (orderID, menuID),
    FOREIGN KEY (orderID) REFERENCES Orders(orderID),
    FOREIGN KEY (menuID) REFERENCES Menu(menuID)
);


-- Insert Data

-- Insert Customers
INSERT INTO Customer VALUES (1, 'SomTamKaiYang', 'somtam@email.com', '0811111111');
INSERT INTO Customer VALUES (2, 'JanKaoMar', 'jankao@email.com', '0822222222');
INSERT INTO Customer VALUES (3, 'PingToHi', 'pingto@email.com', '0833333333');
INSERT INTO Customer VALUES (4, 'BengingDown', 'benging@email.com', '0844444444');
INSERT INTO Customer VALUES (5, 'WetoLow', 'weto@email.com', '0855555555');

-- Insert Menu Items
INSERT INTO Menu VALUES (1, 'Burger', 120.00, 'Main');
INSERT INTO Menu VALUES (2, 'Pizza', 200.00, 'Main');
INSERT INTO Menu VALUES (3, 'Fries', 60.00, 'Side');
INSERT INTO Menu VALUES (4, 'Coke', 40.00, 'Drink');
INSERT INTO Menu VALUES (5, 'Ice Cream', 80.00, 'Dessert');
INSERT INTO Menu VALUES (6, 'Salad', 90.00, 'Side');

-- Insert Orders
INSERT INTO Orders VALUES (1, 1, '2025-08-01');
INSERT INTO Orders VALUES (2, 2, '2025-08-02');
INSERT INTO Orders VALUES (3, 1, '2025-08-03');
INSERT INTO Orders VALUES (4, 3, '2025-08-03');
INSERT INTO Orders VALUES (5, 4, '2025-08-04');


-- Insert Order Details
INSERT INTO OrderDetails VALUES (1, 1, 2);  
INSERT INTO OrderDetails VALUES (1, 4, 2);  
INSERT INTO OrderDetails VALUES (2, 2, 1);  
INSERT INTO OrderDetails VALUES (3, 3, 1);  
INSERT INTO OrderDetails VALUES (3, 5, 1);  
INSERT INTO OrderDetails VALUES (4, 1, 1);  
INSERT INTO OrderDetails VALUES (4, 2, 1);  
INSERT INTO OrderDetails VALUES (5, 6, 2);  
INSERT INTO OrderDetails VALUES (5, 4, 1); 

-- Business Talk

-- 1. Basic Selection with WHERE
SELECT * FROM Menu WHERE price > 100;

-- 2. Cartesian Product Operations
SELECT Customer.customerName, Menu.itemName
FROM Customer, Menu;

SELECT Orders.orderID, Menu.itemName
FROM Orders, Menu;

-- 3. Aggregation Functions
SELECT MIN(price) AS cheapest, MAX(price) AS expensive
FROM Menu;

SELECT SUM(quantity) AS totalSold FROM OrderDetails;

-- 4. GROUP BY with HAVING
SELECT customerID, COUNT(orderID) AS totalOrders
FROM Orders
GROUP BY customerID
HAVING COUNT(orderID) > 1;

-- 5. Set Operations (UNION)
SELECT customerName FROM Customer WHERE customerID=1
UNION
SELECT customerName FROM Customer WHERE customerID=2;

-- 6. Table Variables - Aliases
SELECT c.customerName, o.orderDate
FROM Customer c, Orders o
WHERE c.customerID = o.customerID;

-- 7. Theta-join
SELECT m.itemName, m.price
FROM Menu m, OrderDetails od
WHERE m.menuID = od.menuID AND m.price > 100;

-- 8. ORDER BY multiple columns
SELECT * FROM Orders ORDER BY customerID, orderDate;

-- 9. LIKE operator
SELECT * FROM Customer WHERE customerName LIKE 'S%';

-- 10. Complex query (JOIN + GROUP BY + HAVING)
SELECT c.customerName, SUM(m.price * od.quantity) AS totalSpent
FROM Customer c
JOIN Orders o ON c.customerID = o.customerID
JOIN OrderDetails od ON o.orderID = od.orderID
JOIN Menu m ON od.menuID = m.menuID
GROUP BY c.customerName
HAVING SUM(m.price * od.quantity) > 200;




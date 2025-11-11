DROP DATABASE IF EXISTS ecommerce_shop;

-- Create the database
CREATE DATABASE ecommerce_shop;
USE ecommerce_shop;

-- 1. Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255) NOT NULL UNIQUE
);

-- 2. Shipping Addresses table
CREATE TABLE ShippingAddresses (
    address_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    address VARCHAR(255) NOT NULL,
    postcode VARCHAR(20) NOT NULL,
    country VARCHAR(100) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 3. Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- 4. Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (address_id) REFERENCES ShippingAddresses(address_id)
);

-- 5. Order Items table
CREATE TABLE OrderItems (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Insert sample data

-- Insert customers
INSERT INTO Customers (customer_name, customer_email) VALUES
('Alice Wong', 'alice@email.com'),
('Bob Lee', 'bob@email.com');

-- Insert shipping addresses
INSERT INTO ShippingAddresses (customer_id, address, postcode, country) VALUES
(1, '123 Main St', '10110', 'Thailand'),
(1, '77 Sukhumvit Rd', '10110', 'Thailand'),
(2, '456 Silom Rd', '10500', 'Thailand');

-- Insert products
INSERT INTO Products (product_name, price) VALUES
('iPhone 15', 1200.00),
('AirPods Pro', 200.00),
('MacBook Pro', 2500.00);

-- Insert orders
INSERT INTO Orders (order_id, customer_id, address_id, order_date) VALUES
(5001, 1, 1, '2025-08-20'),
(5002, 2, 3, '2025-08-20'),
(5003, 1, 2, '2025-08-21');

-- Insert order items
INSERT INTO OrderItems (order_id, product_id, quantity, price) VALUES
(5001, 1, 1, 1200.00),
(5001, 2, 2, 200.00),
(5002, 3, 1, 2500.00),
(5003, 1, 1, 1200.00),
(5003, 3, 1, 2500.00);
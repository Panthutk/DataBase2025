DROP DATABASE IF EXISTS HotelManagement;
-- Create Database
CREATE DATABASE HotelManagement;
USE HotelManagement;

-- 1. DDL Commands
-- Create Customer table
CREATE TABLE Customer (
  CustomerID VARCHAR(10) PRIMARY KEY,
  Name VARCHAR(100),
  Phone VARCHAR(20),
  Email VARCHAR(100),
  Address VARCHAR(100),
  Nationality VARCHAR(50)
);

-- Create Room table
CREATE TABLE Room (
  RoomID VARCHAR(10) PRIMARY KEY,
  RoomType VARCHAR(20),
  Capacity INT,
  Price DECIMAL(10,2),
  Status VARCHAR(20)
);

-- Create Booking table
CREATE TABLE Booking (
  BookingID VARCHAR(10) PRIMARY KEY,
  CustomerID VARCHAR(10),
  RoomID VARCHAR(10),
  CheckInDate DATE,
  CheckOutDate DATE,
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

-- Create Staff table
CREATE TABLE Staff (
  StaffID VARCHAR(10) PRIMARY KEY,
  Name VARCHAR(100),
  Role VARCHAR(50),
  Phone VARCHAR(20),
  Salary DECIMAL(10,2)
);

-- 2. DML Commands
-- Insert into Customer table
INSERT INTO Customer VALUES
('C001', 'Sum Ting Wong', '891112222', 'sumting@hotel.c', 'Bangkok', 'Thai'),
('C002', 'Banging Down', '812223333', 'banging@hotel.c', 'London', 'British'),
('C003', 'We Lo Tow', '823334444', 'welow@hotel.co', 'Chiang Mai', 'Thai'),
('C004', 'Plng ToHl', '834445555', 'pingtohi@hotel.c', 'Seoul', 'Korean'),
('C005', 'Not So Fast', '845556666', 'notfast@hotel.c', 'Madrid', 'Spanish');

-- Insert into Room table
INSERT INTO Room VALUES
('R101', 'Single', 1, 1200, 'Available'),
('R102', 'Double', 2, 2000, 'Booked'),
('R201', 'Suite', 4, 5000, 'Available'),
('R202', 'Double', 2, 2200, 'Booked'),
('R301', 'Single', 1, 1000, 'Available');

-- Insert into Booking table
INSERT INTO Booking VALUES
('B001', 'C001', 'R102', '2025-08-01', '2025-08-05'),
('B002', 'C002', 'R202', '2025-08-03', '2025-08-06'),
('B003', 'C003', 'R201', '2025-08-02', '2025-08-07'),
('B004', 'C004', 'R101', '2025-08-04', '2025-08-08'),
('B005', 'C005', 'R301', '2025-08-05', '2025-08-10');

-- Insert into Staff table
INSERT INTO Staff VALUES
('S001', 'John Smith', 'Manager', '901112222', 40000),
('S002', 'Alice Brown', 'Receptionist', '912223333', 25000),
('S003', 'Bob Lee', 'Cleaner', '923334444', 15000),
('S004', 'Mary White', 'Receptionist', '934445555', 26000),
('S005', 'James Black', 'Security', '945556666', 22000);

-- -- 3. Query Implementation
-- -- Query 1: List all customers with their nationality
SELECT CustomerID, Name, Nationality
FROM Customer;

-- -- Query 2: Show all bookings with customer names and room types
SELECT b.BookingID, c.Name, r.RoomType
FROM Booking b
JOIN Customer c ON b.CustomerID = c.CustomerID
JOIN Room r ON b.RoomID = r.RoomID;

-- Query 3: List all staff who are Receptionists
SELECT StaffID, Name, Salary
FROM Staff
WHERE Role = 'Receptionist';
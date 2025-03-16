CREATE DATABASE QLBH
go
USE QLBH;

-- Tạo bảng Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL
);

-- Tạo bảng Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    SupplierID INT,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    UnitInStock INT NOT NULL,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Tạo bảng Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CompanyName VARCHAR(100) NOT NULL,
    Address VARCHAR(200),
    City VARCHAR(50),
    Region VARCHAR(50),
    Country VARCHAR(50)
);

-- Tạo bảng Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    BirthDate DATE,
    City VARCHAR(50)
);

-- Tạo bảng Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Tạo bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    Discount DECIMAL(5, 2) DEFAULT 0.00,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Thêm dữ liệu vào Suppliers
INSERT INTO Suppliers (SupplierID, SupplierName)
VALUES 
    (101, 'Công ty TNHH Văn Lâm'),
    (205, 'Công ty CP Thùy Dương'),
    (310, 'Công ty tư nhân Duy Lợi ')

-- Thêm dữ liệu vào Products
INSERT INTO Products (ProductID, ProductName, SupplierID, UnitPrice, UnitInStock)
VALUES 
    (1, 'bình giữ nhiệt', 101, 240.00, 4),
    (2, 'socola', 205, 90.00, 15),
    (3, 'mũ bảo hiểm', 310, 150.00, 3),
    (4, 'ba lô đi học', 101, 250.00, 8),
    (5, 'áo khoát', 205, 420.00, 2)

-- Thêm dữ liệu vào Customers
INSERT INTO Customers (CustomerID, CompanyName, Address, City, Region, Country)
VALUES 
    (1, 'Cửa hàng bánh ABC ', '123 Đường Lê Lợi', 'TP Tuy Hòa', 'Miền Trung', 'Việt Nam'),
    (2, 'Tiệm sữa gấu', '456 Đường Nguyễn Huệ', 'TPHCM', 'Miền Nam', 'Việt Nam'),
    (3, 'Cửa hàng đồ chơi CYAD', '789 Đường Trần Phú', 'Hà Nội', 'Miền Bắc', 'Việt Nam'),
    (4, 'Tiệm bánh Honey', '102 Collins Street', 'Melbourne', 'Victoria', 'Australia'),
    (5, 'Landing coffee', '202 Đường Phạm Ngũ Lão', 'Hội An', 'Miền Trung', 'Việt Nam')

-- Thêm dữ liệu vào Employees
INSERT INTO Employees (EmployeeID, LastName, FirstName, BirthDate, City)
VALUES 
    (1, 'Fuller', 'Nhược Nam', '1996-04-12', 'Hà Nội'),
    (2, 'Trần', 'Triết Viễn', '1995-09-03', 'TP HCM'),
    (3, 'Hứa', 'Quang Hán', '1980-10-03', 'Đà Nẵng'),
    (4, 'Phan', 'Chí Thiện', '2005-05-05', 'Phú Yên'),
	(5, 'Lê', 'Thanh Hương', '2002-02-17', 'Đà Nẵng'),
    (6, 'Nguyễn', 'Duy Lợi', '2007-02-14', 'Phú Yên')
-- Thêm dữ liệu vào Orders
INSERT INTO Orders (OrderID, CustomerID, EmployeeID, OrderDate)
VALUES 
    (1, 1, 1, '1997-01-10'),
    (2, 2, 2, '1997-04-11'),
    (3, 3, 3, '1997-07-12'),
    (4, 4, 4, '1997-09-13')




-- Thêm dữ liệu vào OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES 
    (1, 1, 240.00, 2, 30.00),
    (1, 2, 90.00, 3, 0.00),
    (2, 3, 310.00, 5, 10.00),
    (3, 4, 250.00, 1, 20.00),
    (4, 5, 420.00, 4, 15.00)



---CÂU 1

SELECT Customers.CustomerID, CompanyName, Address, OrderID, Orderdate
FROM Customers, Orders
WHERE Customers.CustomerID = Orders.CustomerID
AND YEAR (OrderDate) = 1997 AND MONTH (OrderDate) = 7
Order by CustomerID, OrderDate DESC

--c2
SELECT Customers.CustomerID, CompanyName, Address, OrderID, OrderDate
FROM Customers, Orders
WHERE Customers.CustomerID = Orders.CustomerID
AND OrderDate BETWEEN '1997-01-10' and '1997-09-13'
Order by CustomerID, OrderDate DESC


---C3
select Products.ProductID, ProductName
from Products, OrderDetails, Orders
where Products.ProductID = OrderDetails.ProductID
And OrderDetails.OrderID = Orders.OrderID
And OrderDate = '1996-07-16' 
---c4
SELECT Orders.OrderID, CompanyName, OrderDate
FROM Customers, Orders
WHERE Customers.CustomerID = Orders.CustomerID
AND YEAR(OrderDate) = 1997
AND MONTH(OrderDate) IN (4, 9)
ORDER BY CompanyName, OrderDate DESC
--c5
SELECT Orders.OrderID, Employees.LastName, Employees.FirstName, OrderDate
FROM Employees, Orders
WHERE Employees.EmployeeID = Orders.EmployeeID
AND LastName = 'Fuller'
--c6
SELECT Products.ProductID, ProductName, SupplierID
FROM Products, OrderDetails, Orders
WHERE Products.ProductID = OrderDetails.ProductID
AND OrderDetails.OrderID = Orders.OrderID
AND SupplierID IN (1, 3, 6)
AND YEAR(OrderDate) = 1997
AND MONTH(OrderDate) BETWEEN 4 AND 6
ORDER BY SupplierID, ProductID
--c7
SELECT ProductID, ProductName
FROM Products
WHERE UnitPrice = (SELECT UnitPrice FROM OrderDetails WHERE Products.ProductID = OrderDetails.ProductID)
--c8
SELECT Products.ProductID, ProductName
FROM Products, OrderDetails
WHERE Products.ProductID = OrderDetails.ProductID
AND OrderDetails.OrderID = 10248
--c9
SELECT DISTINCT Employees.EmployeeID, LastName, FirstName
FROM Employees, Orders
WHERE Employees.EmployeeID = Orders.EmployeeID
AND YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 7
--c10
SELECT Products.ProductID, ProductName, Orders.OrderID, OrderDate, Customers.CustomerID, 
       OrderDetails.UnitPrice, Quantity, Quantity * OrderDetails.UnitPrice AS Total
FROM Products, OrderDetails, Orders, Customers
WHERE Products.ProductID = OrderDetails.ProductID
AND OrderDetails.OrderID = Orders.OrderID
AND Orders.CustomerID = Customers.CustomerID
AND YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 12
AND DATEPART(WEEKDAY, OrderDate) IN (7, 1)
ORDER BY ProductID, Quantity DESC
--c11
SELECT Employees.EmployeeID, LastName + ' ' + FirstName AS EmployeeName, 
       Orders.OrderID, OrderDate, Products.ProductID, Quantity, OrderDetails.UnitPrice, 
       Quantity * OrderDetails.UnitPrice AS Total
FROM Employees, Orders, OrderDetails, Products
WHERE Employees.EmployeeID = Orders.EmployeeID
AND Orders.OrderID = OrderDetails.OrderID
AND OrderDetails.ProductID = Products.ProductID
AND YEAR(OrderDate) = 1996
--c12
SELECT OrderID, OrderDate
FROM Orders
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) = 12
AND DATEPART(WEEKDAY, OrderDate) = 7

--c13
SELECT Employees.EmployeeID, LastName, FirstName
FROM Employees
WHERE EmployeeID NOT IN (SELECT EmployeeID FROM Orders)

--c14
SELECT ProductID, ProductName
FROM Products
WHERE ProductID NOT IN (SELECT ProductID FROM OrderDetails)

--c15
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders)

drop table Suppliers
drop table Products
drop table OrderDetails
drop table Customers
drop table Employees
drop table Orders
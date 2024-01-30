
INSERT DATABASE trndyol;

USE trndyol;

-- Müsteri Tablosu
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Address VARCHAR(255)
);

-- Ürün Tablosu
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

-- Siparis Tablosu
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Siparis Detaylari Tablosu
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);







-------------------------TRIGGERLER---------------------------------


--Products tablosuna yeni bir ürün eklendiğinde çalışır ve bir log tablosuna bu ekleme işlemini kaydeder.

CREATE TRIGGER trg_ProductAdded
AFTER INSERT ON Products
FOR EACH ROW
BEGIN
  INSERT INTO ProductLog (ProductID, Action, LogDate)
  VALUES (NEW.ProductID, 'Ürün Eklendi', NOW());
END;



--Customers tablosuna yeni bir müşteri eklendiğinde çalışır ve bir log tablosuna bu ekleme işlemini kaydeder.

CREATE TRIGGER trg_CustomerAdded
AFTER INSERT ON Customers
FOR EACH ROW
BEGIN
  INSERT INTO CustomerLog (CustomerID, Action, LogDate)
  VALUES (NEW.CustomerID, 'Müşteri Eklendi', NOW());
END;



-- Orders tablosuna yeni bir sipariş eklendiğinde çalışır ve bir log tablosuna bu ekleme işlemini kaydeder.
CREATE TRIGGER trg_OrderAdded
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
  INSERT INTO OrderLog (OrderID, Action, LogDate)
  VALUES (NEW.OrderID, 'Sipariş eklendi', NOW());
END;


---OrderDetails tablosuna yeni bir sipariş detayı eklendiğinde çalışır ve bir log tablosuna bu ekleme işlemini kaydeder.

CREATE TRIGGER trg_OrderDetailAdded
AFTER INSERT ON OrderDetails
FOR EACH ROW
BEGIN
  INSERT INTO OrderDetailLog (OrderDetailID, Action, LogDate)
  VALUES (NEW.OrderDetailID, 'Sipariş Detayı Eklendi', NOW());
END;





-----------------PROCEDERLAR-----------------------

--Ürün Ekleme (Product Insert) Procedure:
CREATE PROCEDURE sp_InsertProduct
    @ProductID INT,
    @ProductName NVARCHAR(255),
    @Price DECIMAL(18, 2),
    @StockQuantity INT
AS
BEGIN
    INSERT INTO Products (ProductID, ProductName, Price, StockQuantity)
    VALUES (@ProductID, @ProductName, @Price, @StockQuantity);
END;


--Sipariş Ekleme (Order Insert) Procedure:

CREATE PROCEDURE sp_InsertOrder
    @OrderID INT,
    @CustomerID INT,
    @OrderDate DATE
AS
BEGIN
    INSERT INTO Orders (OrderID, CustomerID, OrderDate)
    VALUES (@OrderID, @CustomerID, @OrderDate);
END;



--------------SORGULAR---------------


--Belirli Bir Ürünün Fiyatı ve Stok Durumu:

SELECT ProductName, Price, StockQuantity FROM Products WHERE ProductID = 111;


--En Yüksek Fiyatlı Ürün:


SELECT * FROM Products ORDER BY Price DESC LIMIT 1;


--Belirli Bir Tarihte Yapılan Siparişler:

SELECT * FROM Orders WHERE OrderDate = '2024-02-01';


--Belirli Bir Müşterinin Toplam Harcaması:

SELECT c.CustomerID, c.FirstName, c.LastName, SUM(p.Price * od.Quantity) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE c.CustomerID = 1
GROUP BY c.CustomerID, c.FirstName, c.LastName;


--Belirli Bir Ürünün Satışları ve Toplam Geliri:

SELECT p.ProductName, SUM(od.Quantity) AS TotalSales, SUM(p.Price * od.Quantity) AS TotalRevenue
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;


--En Çok Satılan Ürün:

SELECT p.ProductName, SUM(od.Quantity) AS TotalSales
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC
LIMIT 1;


--Ürün Güncelleme:

UPDATE Products
SET Price = Price * 1.1  -- Fiyatları %10 artırma
WHERE StockQuantity < 20;
--sql Examination with Henry
--Q1.To Create a Database AxiaStores
CREATE database AxiaStores;

--Q2&3. To create three tables CustomerTB,ProductTB and OrdersTB plus inserting corresponding records
CREATE TABLE CustomerTB (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    City VARCHAR(50)

);

 --inserting values into CustomerTB table
       INSERT INTO CustomerTB (CustomerID,FirstName,LastName,Email,Phone,City)
       VALUES 
       (1,'Musa','Ahmed','musa.ahmed@hotmail.com','08031230001','Lagos'),
       (2,'Ray','Samson','ray.samson@hotmail.com','08031230002','Ibadan'),                   (3,'Chinedu','Okafor','chinedu.okafor@hotmail.com','08031230003','Enugu'),
       (4,'Dare','Adewale','dare.adewale@hotmail.com','08031230004','Abuja'),
       (5,'Efe','Ojo','efe.ojo@hotmail.com','08031230005','Port Harcourt'),
       (6,'Aisha','Bello','aisha.bello@hotmail.com','08031230006','Kano'),
       (7,'Tunde','Salami','tunde.salami@hotmail.com','08031230007','Ilorin'),
       (8,'Nneka','Umeh','nneka.umeh@hotmail.com','08031230008','Owerri'),
       (9,'Kelvin','Peters','kelvin.peters@hotmail.com','08031230009','Asaba'),
       (10,'Blessing','Mark','blessing.mark@hotmail.com','08031230010','Uyo');


--Creating table ProductTB
CREATE TABLE ProductTB (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(50),
Category VARCHAR(50),
UnitPrice DECIMAL(10,2),
StockQty INT,
);

 --inserting values into ProductTB table
       INSERT INTO ProductTB (ProductID,ProductName,Category,UnitPrice,StockQty)
       VALUES 
       (1,'Wireless Mouse','Accessories','7500','120'),
       (2,'USB-C Charger 65W','Electronics','14500','75'),
       (3,'Noise‑Cancel Headset','Audio ','85500','50'),
       (4,'27" 4K Monitor','Displays  ','185000','20'),
       (5,'Laptop Stand','Accessories','19500','90'),
       (6,'Bluetooth Speaker','Audio','52000','60'),
       (7,'Mechanica Keyboard','Accessories','18500','40'),
       (8,'WebCam 1080p','Electronics','25500','55'),
       (9,'Smartwatch Series 5','Wearables','320000','30'),
       (10,'Portable SSD 1TB','Storage ','125000','35');

--Creating a table OrdersTB
CREATE TABLE OrdersTB(
OrderID INT PRIMARY KEY,
CustomerID INT,
ProductID INT,
OrderDate DATE,
Quantity INT,
FOREIGN KEY (CustomerID) REFERENCES CustomerTB(CustomerID),
FOREIGN KEY (ProductID) REFERENCES ProductTB(ProductID)
);

--Inserting values into OrdersTB Table
INSERT INTO OrdersTB(OrderID,CustomerID,ProductID,OrderDate,Quantity)
VALUES
('1001','1','3','2025-06-01','1'),
('1002','2','1','2025-06-03','2'),
('1003','3','5','2025-06-05','1'),
('1004','4','4','2025-06-10','1'),
('1005','5','2','2025-06-12','3'),
('1006','6','7','2025-06-15','1'),
('1007','7','6','2025-06-18','2'),
('1008','8','8','2025-06-20','1'),
('1009','9','9','2025-06-22','1'),
('1010','10','10','2025-06-25','2');



-- 4. To Return the FirstName and Email of every customer who ever purchased the product "Wireless Mouse"
SELECT DISTINCT 
    c.FirstName, 
    c.Email
FROM 
    OrdersTB o
INNER JOIN 
    ProductTB p ON o.ProductID = p.ProductID
INNER JOIN 
    CustomerTB c ON o.CustomerID = c.CustomerID
WHERE 
    p.ProductName = 'Wireless Mouse';



-- 5. To List all Customers' full names in ascending alphabetical order (LastName, then FirstName)
SELECT 
    LastName, 
    FirstName
FROM 
    CustomerTB
ORDER BY 
    LastName ASC, 
    FirstName ASC;


-- 6. Show every order together with the customer’s full name, the product name, quantity,unit price, total price and order date. 
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerFullName,
    p.ProductName,
    o.Quantity,
    p.UnitPrice,
    (o.Quantity * p.UnitPrice) AS TotalPrice,
    o.OrderDate
FROM 
    OrdersTB AS o
INNER JOIN 
    CustomerTB AS c ON o.CustomerID = c.CustomerID
INNER JOIN 
    ProductTB AS p ON o.ProductID = p.ProductID;


 -- 7.To Show average sales per product category and sort in descending order
SELECT 
    p.Category,
    AVG(o.Quantity * p.UnitPrice) AS AverageSales
FROM 
    OrdersTB AS o
INNER JOIN 
    ProductTB AS p ON o.ProductID = p.ProductID
GROUP BY 
    p.Category
ORDER BY 
    AverageSales DESC;

-- 8.To Select the city that generated the highest revenue for AxiaStores 
SELECT TOP (1)
    c.City,
    SUM(o.Quantity * p.UnitPrice) AS TotalRevenue
FROM 
    OrdersTB AS o
INNER JOIN 
    CustomerTB AS c ON o.CustomerID = c.CustomerID
INNER JOIN 
    ProductTB AS p ON o.ProductID = p.ProductID
GROUP BY 
    c.City
ORDER BY 
    TotalRevenue DESC;



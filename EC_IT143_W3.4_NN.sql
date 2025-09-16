/***********************************************************************************
******************************
NAME: AdventureWorks Q&A Script
PURPOSE: Translate user questions into working SQL queries using AdventureWorks.
MODIFICATION LOG:
Ver   Date        Author    Description
----- ----------  --------  --------------------------------------------------------
1.0   09/16/2025  Nephi Nyegonum Initial build for IT143 Assignment
RUNTIME:
Varies per query
NOTES:
This script contains 8 questions (2 marginal, 2 moderate, 2 increased complexity,
2 metadata). Each question is commented above the SQL statement with the author.
***********************************************************************************
*******************************/

-- Q1 (Marginal Complexity) (Author: Nephi Nyegonum) 
-- A1: Find all products in Production.Product that have a safety stock level below 400.
SELECT ProductID, Name, SafetyStockLevel
FROM Production.Product
WHERE SafetyStockLevel < 400;

-- Q2 (Marginal Complexity) (Author: Lokelani Chanel Mu'amoholeva) 
-- A2: Return a single count of all employees in HumanResources.Employee.
SELECT COUNT(*) AS TotalEmployees
FROM HumanResources.Employee;

-- Q3 (Moderate Complexity) (Author: David Chukwuemeka Adeniyi) 
-- A3: Show the top three customers by total sales, along with their order counts.
SELECT TOP 3 
       soh.CustomerID AS Customer,
       SUM(sod.LineTotal) AS TotalSales,
       COUNT(soh.SalesOrderID) AS OrderCount
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod
     ON soh.SalesOrderID = sod.SalesOrderID
GROUP BY soh.CustomerID
ORDER BY TotalSales DESC;

-- Q4 (Moderate Complexity) (Author: David Chukwuemeka Adeniyi) 
-- A4: Calculate net revenue per product (list price - standard cost), and list the top two.
SELECT TOP 2 
       p.Name,
       SUM((p.ListPrice - p.StandardCost) * sod.OrderQty) AS NetRevenue
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod
     ON p.ProductID = sod.ProductID
GROUP BY p.Name
ORDER BY NetRevenue DESC;

-- Q5 (Increased Complexity) (Author: Nephi Nyegonum) 
-- A5: Calculate the average number of vacation hours across all employees.
SELECT AVG(VacationHours) AS AverageVacationHours
FROM HumanResources.Employee;

-- Q6 (Increased Complexity) (Author: Lokelani Chanel Mu'amoholeva) 
-- A6: Retrieve the five most expensive products based on ListPrice.
SELECT TOP 5 
       ProductID,
       Name,
       ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

-- Q7 (Metadata) (Author: Shane Sta. Ana) 
-- A7: Find all AdventureWorks tables that have a column with "Date" in its name.
SELECT DISTINCT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%Date%';

-- Q8 (Metadata) (Author: Shane Sta. Ana) 
-- A8: List all indexes on Sales.SalesOrderDetail, showing the key and included columns.
SELECT i.name AS IndexName,
       c.name AS ColumnName,
       ic.is_included_column
FROM sys.indexes i
JOIN sys.index_columns ic
     ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c
     ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN sys.tables t
     ON i.object_id = t.object_id
WHERE t.name = 'SalesOrderDetail';

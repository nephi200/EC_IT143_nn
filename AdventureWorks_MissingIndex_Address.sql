/****************************************************************************************
NAME: W6.4_PerformanceAnalysis.sql
PURPOSE: Queries and index creation steps for performance analysis assignment.

DATE: 10/04/2025
AUTHOR: Nephi Nyegonum
****************************************************************************************/
-- Original query that triggered the missing index recommendation
SELECT *
FROM [AdventureWorks2022].[Person].[Address]
WHERE [AddressLine2] = 'Suite 100';

-- Missing Index Details from SQLQuery19.sql - NYEGONUM-37MA7K.AdventureWorks2022
-- The Query Processor estimates that implementing the following index could improve the query cost by 74.2166%.

-- SQL Server's suggested index (with placeholder name)
-- CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
-- ON [Person].[Address] ([AddressLine2])
-- INCLUDE ([AddressLine1],[City],[StateProvinceID],[PostalCode],[SpatialLocation],[rowguid],[ModifiedDate])

-- Final index creation script with proper name
USE [AdventureWorks2022];
GO

CREATE NONCLUSTERED INDEX IX_Address_AddressLine2
ON [Person].[Address] ([AddressLine2])
INCLUDE ([AddressLine1], [City], [StateProvinceID], [PostalCode], [SpatialLocation], [rowguid], [ModifiedDate]);
GO

-- Re-run the query to measure performance improvement
SELECT *
FROM [AdventureWorks2022].[Person].[Address]
WHERE [AddressLine2] = 'Suite 100';
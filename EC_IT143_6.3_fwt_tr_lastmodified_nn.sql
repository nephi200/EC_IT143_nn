/*****************************************************************************************************************
NAME:    EC_IT143_6.3_fwt_tr_lastmodified_nn.sql
PURPOSE: Create a trigger to track when a record was last modified in dbo.t_w3_schools_customers.

MODIFICATION LOG:
Ver      Date        Author            Description
-----   ----------   -----------       -------------------------------------------------------------------------------
1.0     04/10/2025   NEPHI NYEGONUM    Final working version after disabling nested triggers.

RUNTIME: 
0m 10s

NOTES: 
This script follows the 6-step process: question, answer, research, trigger creation, test, and follow-up curiosity.
******************************************************************************************************************/

-- Step 1: Ask the Question
-- Q: How can I track when a record was last modified?
-- A: I want a timestamp column that updates automatically whenever a record is changed.

-- Step 2: Begin Creating an Answer
-- My idea: Use an AFTER UPDATE trigger to set LastModified = GETDATE().

-- Step 3: Research and Test
-- SQL Server supports AFTER UPDATE triggers and GETDATE() returns the current timestamp.
-- Resources:
-- 1. https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql
-- 2. https://stackoverflow.com/questions/12724461/sql-server-trigger-after-update

-- Step 4: Create the Trigger
-- Ensure the LastModified column exists
IF COL_LENGTH('dbo.t_w3_schools_customers', 'LastModified') IS NULL
BEGIN
    ALTER TABLE dbo.t_w3_schools_customers
    ADD LastModified DATETIME;
END;

-- Drop existing trigger if it exists
IF OBJECT_ID('dbo.trg_LastModified', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER dbo.trg_LastModified;
END;
GO

-- Create the trigger
CREATE TRIGGER trg_LastModified
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.t_w3_schools_customers
    SET LastModified = GETDATE()
    WHERE CustomerID IN (SELECT CustomerID FROM Inserted);
END;
GO

-- Step 5: Test Results
-- Force a change to ensure the trigger fires
UPDATE dbo.t_w3_schools_customers
SET City = 'TriggerTest_' + CAST(GETDATE() AS VARCHAR)
WHERE CustomerID = 3;

-- Verify LastModified was updated
SELECT CustomerID, ContactName, City, LastModified
FROM dbo.t_w3_schools_customers
WHERE CustomerID = 3;

-- Step 6: Ask the Next Question
-- Q: How can I track who modified the record?
-- A: I want to explore using SYSTEM_USER to capture the SQL Server login name.
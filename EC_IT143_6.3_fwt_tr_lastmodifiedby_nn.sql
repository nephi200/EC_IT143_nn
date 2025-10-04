/*****************************************************************************************************************
NAME:    EC_IT143_6.3_fwt_tr_lastmodifiedby_nn.sql
PURPOSE: Create a trigger to track who last modified a record in dbo.t_w3_schools_customers.

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
-- Q: How can I track who last modified a record?
-- A: I want a column that stores the SQL Server login name of the user who made the change.

-- Step 2: Begin Creating an Answer
-- My idea: Use SYSTEM_USER inside an AFTER UPDATE trigger to set LastModifiedBy.

-- Step 3: Research and Test
-- SYSTEM_USER returns the current login name and works inside triggers.
-- Resources:
-- 1. https://learn.microsoft.com/en-us/sql/t-sql/functions/system-user-transact-sql
-- 2. https://stackoverflow.com/questions/12724461/sql-server-trigger-after-update

-- Step 4: Create the Trigger
-- Ensure the LastModifiedBy column exists
IF COL_LENGTH('dbo.t_w3_schools_customers', 'LastModifiedBy') IS NULL
BEGIN
    ALTER TABLE dbo.t_w3_schools_customers
    ADD LastModifiedBy NVARCHAR(128);
END;

-- Drop existing trigger if it exists
IF OBJECT_ID('dbo.trg_LastModifiedBy', 'TR') IS NOT NULL
BEGIN
    DROP TRIGGER dbo.trg_LastModifiedBy;
END;
GO

-- Create the trigger
CREATE TRIGGER trg_LastModifiedBy
ON dbo.t_w3_schools_customers
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.t_w3_schools_customers
    SET LastModifiedBy = SYSTEM_USER
    WHERE CustomerID IN (SELECT CustomerID FROM Inserted);
END;
GO

-- Step 5: Test Results
-- Force a change to ensure the trigger fires
UPDATE dbo.t_w3_schools_customers
SET City = 'TriggerTest_' + CAST(GETDATE() AS VARCHAR)
WHERE CustomerID = 4;

-- Verify LastModifiedBy was updated
SELECT CustomerID, ContactName, City, LastModifiedBy
FROM dbo.t_w3_schools_customers
WHERE CustomerID = 4;

-- Step 6: Ask the Next Question
-- Q: Can I combine both audit fields into one trigger?
-- A: I want to explore combining LastModified and LastModifiedBy into a single trigger for efficiency.
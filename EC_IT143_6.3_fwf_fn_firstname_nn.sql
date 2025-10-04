/*****************************************************************************************************************
NAME:        EC_IT143_6.3_fwf_fn_firstname_nn.sql
PURPOSE:     Extract the first name from the ContactName field using ad hoc query and scalar function.

MODIFICATION LOG:
Ver      Date        Author            Description
-----   ----------   -----------       -------------------------------------------------------------------------------
1.0     09/16/2025   NEPHI NYEGONUM    Built script for first name extraction in EC IT143 Fun with Functions.

RUNTIME: 
~0m 5s

NOTES: 
This script demonstrates how to solve the problem of extracting first names from the ContactName column.
Steps include:
- Writing an ad hoc query
- Researching and testing the best approach
- Creating a user-defined scalar function
- Comparing results of both methods
- Running a zero-results test for validation
******************************************************************************************************************/

/*---------------------------------------------------------------------------------------------------------------
 Q1 (Step 1): How do I extract the first name from the ContactName field?
 A1 (Step 2): By using LEFT() and CHARINDEX() to return the portion of the string before the first space.
---------------------------------------------------------------------------------------------------------------*/

-- Step 3: Ad hoc query
SELECT ContactName,
       LEFT(ContactName, CHARINDEX(' ', ContactName) - 1) AS FirstName
FROM dbo.t_w3_schools_customers;
GO

/*---------------------------------------------------------------------------------------------------------------
 Step 4: Research & Test
 - Research confirmed that CHARINDEX finds the first space in the ContactName string.
 - LEFT extracts all characters before that position.
 - Tested this query in SSMS on sample data, and results matched expectations.
 Source: https://learn.microsoft.com/en-us/sql/t-sql/functions/charindex-transact-sql
---------------------------------------------------------------------------------------------------------------*/

-- Step 5: Scalar function
ALTER FUNCTION dbo.fn_GetFirstName (@ContactName NVARCHAR(100))
RETURNS NVARCHAR(50)
AS
BEGIN
    RETURN LEFT(@ContactName, CHARINDEX(' ', @ContactName) - 1);
END;
GO

-- Step 6: Compare ad hoc vs scalar function results
SELECT ContactName,
       dbo.fn_GetFirstName(ContactName) AS FirstName_UDF,
       LEFT(ContactName, CHARINDEX(' ', ContactName) - 1) AS FirstName_AdHoc
FROM dbo.t_w3_schools_customers;
GO

-- Step 7: 0-results expected validation
WITH ValidationCTE AS (
    SELECT ContactName
    FROM dbo.t_w3_schools_customers
    WHERE dbo.fn_GetFirstName(ContactName) 
          <> LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
)
SELECT * 
FROM ValidationCTE;
GO

/*---------------------------------------------------------------------------------------------------------------
 Q2 (Step 8): What am I curious about now?
 A2: How to extract the LAST NAME from the ContactName field using a similar approach.
---------------------------------------------------------------------------------------------------------------*/

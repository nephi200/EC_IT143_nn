/*****************************************************************************************************************
NAME:        EC_IT143_6.3_fwf_fn_lastname_nn.sql
PURPOSE:     Extract the last name from the ContactName field using ad hoc query and scalar function.

MODIFICATION LOG:
Ver      Date        Author            Description
-----   ----------   -----------       -------------------------------------------------------------------------------
1.0     09/16/2025   NEPHI NYEGONUM    Built script for last name extraction in EC IT143 Fun with Functions.

RUNTIME: 
~0m 5s

NOTES: 
This script demonstrates how to solve the problem of extracting last names from the ContactName column.
Steps include:
- Writing an ad hoc query
- Researching and testing the best approach
- Creating a user-defined scalar function
- Comparing results of both methods
- Running a zero-results test for validation
******************************************************************************************************************/

/*---------------------------------------------------------------------------------------------------------------
 Q1 (Step 1): How do I extract the last name from the ContactName field?
 A1 (Step 2): By using RIGHT(), LEN(), and CHARINDEX() to return the portion of the string after the first space.
---------------------------------------------------------------------------------------------------------------*/

-- Step 3: Ad hoc query
SELECT ContactName,
       LTRIM(RIGHT(ContactName, LEN(ContactName) - CHARINDEX(' ', ContactName))) AS LastName
FROM dbo.t_w3_schools_customers;
GO

/*---------------------------------------------------------------------------------------------------------------
 Step 4: Research & Test
 - Research confirmed that LEN() finds the total length of the string.
 - CHARINDEX(' ', ContactName) finds the position of the first space.
 - RIGHT() combined with LEN() - CHARINDEX() extracts all characters after the space.
 - LTRIM() cleans up any leading spaces.
 - Tested in SSMS with sample data; last names returned correctly.
 Source: https://learn.microsoft.com/en-us/sql/t-sql/functions/right-transact-sql
---------------------------------------------------------------------------------------------------------------*/

-- Step 5: Scalar function
ALTER FUNCTION dbo.fn_GetLastName (@ContactName NVARCHAR(100))
RETURNS NVARCHAR(50)
AS
BEGIN
    RETURN LTRIM(RIGHT(@ContactName, LEN(@ContactName) - CHARINDEX(' ', @ContactName)));
END;
GO

-- Step 6: Compare ad hoc vs scalar function results
SELECT ContactName,
       dbo.fn_GetLastName(ContactName) AS LastName_UDF,
       LTRIM(RIGHT(ContactName, LEN(ContactName) - CHARINDEX(' ', ContactName))) AS LastName_AdHoc
FROM dbo.t_w3_schools_customers;
GO

-- Step 7: 0-results expected validation
WITH ValidationCTE AS (
    SELECT ContactName
    FROM dbo.t_w3_schools_customers
    WHERE dbo.fn_GetLastName(ContactName) 
          <> LTRIM(RIGHT(ContactName, LEN(ContactName) - CHARINDEX(' ', ContactName)))
)
SELECT * 
FROM ValidationCTE;
GO

/*---------------------------------------------------------------------------------------------------------------
 Q2 (Step 8): What am I curious about now?
 A2: How to handle cases where ContactName does not contain a space (single names or null values).
---------------------------------------------------------------------------------------------------------------*/

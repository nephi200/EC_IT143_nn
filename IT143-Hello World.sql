
NAME: EC_IT143_W4.2_hello_world_s1_nn.sql
PURPOSE: Step 1 of the Hello World dataset assignment using the answer-focused method.
******************************************************************************/

-- Q1: What is the current date and time?
-- A1: This script begins my answer-focused journey by identifying how to retrieve the current system date and time using SQL Server.
--     I will use the GETDATE() function to return the current date and time.
/******************************************************************************
NAME: EC_IT143_W4.2_hello_world_s2_nn.sql
PURPOSE: Step 2 of the Hello World dataset assignment using the answer-focused method.
******************************************************************************/

-- Q1: What is the current date and time?
-- A1: Let's ask SQL Server and find out.
--     I will use the GETDATE() function to retrieve the current system date and time.
/******************************************************************************
NAME: EC_IT143_W4.2_hello_world_s3_nn.sql
PURPOSE: Step 3 of the Hello World dataset assignment using the answer-focused method.
******************************************************************************/

-- Q1: What is the current date and time?
-- A1: This query returns a static message and the current system date and time.

SELECT 
    'Hello World' AS my_message,
    GETDATE() AS current_date_time;
/******************************************************************************
NAME: EC_IT143_W4.2_hello_world_s4_nn.sql
PURPOSE: Step 4 of the Hello World dataset assignment using the answer-focused method.
******************************************************************************/

GO

CREATE VIEW vw_hello_world_message
AS
SELECT 
    'Hello World' AS my_message,
    GETDATE() AS current_date_time;
/******************************************************************************
NAME: EC_IT143_W4.2_hello_world_s5.1_nn.sql
PURPOSE: Step 5.1 of the Hello World dataset assignment using the answer-focused method.
******************************************************************************/

-- Q1: What is the current date and time?
-- A1: This script creates a table that stores the Hello World message and current date/time.

SELECT *
INTO tbl_hello_world_message
FROM vw_hello_world_message;
/******************************************************************************
NAME: EC_IT143_W4.2_hello_world_s5.2_nn.sql
PURPOSE: Step 5.2 of the Hello World dataset assignment using the answer-focused method.
******************************************************************************/

-- Q1: What is the current date and time?
-- A1: This script refines the table tbl_hello_world_message by adding a primary key and constraints.

IF OBJECT_ID('tbl_hello_world_message', 'U') IS NOT NULL
    DROP TABLE tbl_hello_world_message;

CREATE TABLE tbl_hello_world_message (
    id INT IDENTITY(1,1) PRIMARY KEY,
    my_message VARCHAR(50) NOT NULL DEFAULT 'Hello World',
    current_date_time DATETIME NOT NULL DEFAULT GETDATE()
);
/******************************************************************************
NAME: EC_IT143_W4.2_hello_world_s6_nn.sql
PURPOSE: Step 6 of the Hello World dataset assignment using the answer-focused method.
******************************************************************************/

-- Q1: What is the current date and time?
-- A1: This script refreshes the table with the latest Hello World message and current date/time.

TRUNCATE TABLE tbl_hello_world_message;

INSERT INTO tbl_hello_world_message (my_message, current_date_time)
SELECT my_message, current_date_time
FROM vw_hello_world_message;
/******************************************************************************
NAME: EC_IT143_W4.2_hello_world_s7_nn.sql
PURPOSE: Step 7 of the Hello World dataset assignment using the answer-focused method.
******************************************************************************/

GO

IF OBJECT_ID('usp_LoadHelloWorldMessage', 'P') IS NOT NULL
    DROP PROCEDURE usp_LoadHelloWorldMessage;

GO

CREATE PROCEDURE usp_LoadHelloWorldMessage
AS
BEGIN
    TRUNCATE TABLE tbl_hello_world_message;

    INSERT INTO tbl_hello_world_message (my_message, current_date_time)
    SELECT my_message, current_date_time
    FROM vw_hello_world_message;
END;
/******************************************************************************
NAME: EC_IT143_W4.2_hello_world_s8_nn.sql
PURPOSE: Step 8 of the Hello World dataset assignment using the answer-focused method.
******************************************************************************/

-- Q1: What is the current date and time?
-- A1: This script executes the stored procedure to load the Hello World message and current date/time into the table.

EXEC usp_LoadHelloWorldMessage;

NAME:        EC_IT143_W4.2_fastfoodnutrition_s1_nn.sql
PURPOSE:     Step 1 of the My Community dataset assignment using Fast Food Nutrition dataset.
MODIFICATION LOG:
Ver   Date        Author           Description
1.0   09/20/2025  Nephi Nyegonum   Initial version for IT143 Week 4 assignment
RUNTIME:     ~1s
NOTES:       This script documents the question I want to answer using the fastfood dataset.
******************************************************************************/

-- Q1: What is the highest calorie item on the fast food menu?
-- A1: This script begins my answer-focused journey by identifying the most calorie-dense item.
--     I will use the fastfood table to find the item with the maximum calorie value.
/******************************************************************************
NAME:        EC_IT143_W4.2_fastfoodnutrition_s2_nn.sql
PURPOSE:     Step 2 of the My Community dataset assignment using Fast Food Nutrition dataset.
MODIFICATION LOG:
Ver   Date        Author           Description
1.0   09/20/2025  Nephi Nyegonum   Initial version for IT143 Week 4 assignment
RUNTIME:     ~1s
NOTES:       This script outlines my approach to answering the question about the highest calorie item.
******************************************************************************/

-- Q1: What is the highest calorie item on the fast food menu?
-- A1: To answer this, I need to examine the 'calories' column in the fastfood table.
--     My first step will be to sort the data by calories in descending order.
--     Then I will select the top item to find the one with the highest calorie count.
--     This will give me a clear and direct answer to my question.
/******************************************************************************
NAME: EC_IT143_W4.2_fastfoodnutrition_s3_nn.sql
PURPOSE: Step 3 of the My Community dataset assignment using Fast Food Nutrition dataset.
******************************************************************************/

-- Q1: What is the highest calorie item on the fast food menu?
-- A1: This query returns the item with the maximum calorie value from the fastfood dataset.
SELECT TOP 1 item, restaurant, calories
FROM fastfood
ORDER BY calories DESC;
GO

/******************************************************************************
NAME: EC_IT143_W4.2_fastfoodnutrition_s4_nn.sql
PURPOSE: Step 4 - Create a view that returns the highest calorie item.
******************************************************************************/

-- Drop the view if it already exists
IF OBJECT_ID('vw_highest_calorie_item', 'V') IS NOT NULL
    DROP VIEW vw_highest_calorie_item;
GO

-- Create the view
CREATE VIEW vw_highest_calorie_item
AS
SELECT TOP 1 item, restaurant, calories
FROM fastfood
ORDER BY calories DESC;
GO

/******************************************************************************
NAME: EC_IT143_W4.2_fastfoodnutrition_s5.1_nn.sql
PURPOSE: Step 5.1 - Create a table from the view using SELECT INTO.
******************************************************************************/

-- Drop the table if it already exists (in case you re-run this)
IF OBJECT_ID('tbl_highest_calorie_item', 'U') IS NOT NULL
    DROP TABLE tbl_highest_calorie_item;
GO

-- Create table from view
SELECT *
INTO tbl_highest_calorie_item
FROM vw_highest_calorie_item;
GO

/******************************************************************************
NAME: EC_IT143_W4.2_fastfoodnutrition_s5.2_nn.sql
PURPOSE: Step 5.2 - Refine the table structure.
******************************************************************************/

-- Drop the table if it already exists
IF OBJECT_ID('tbl_highest_calorie_item', 'U') IS NOT NULL
    DROP TABLE tbl_highest_calorie_item;
GO

-- Recreate the table with constraints
CREATE TABLE tbl_highest_calorie_item (
    item NVARCHAR(255) NOT NULL,
    restaurant NVARCHAR(255) NOT NULL,
    calories INT NOT NULL,
    CONSTRAINT PK_highest_calorie_item PRIMARY KEY (item, restaurant)
);
GO

/******************************************************************************
NAME: EC_IT143_W4.2_fastfoodnutrition_s6_nn.sql
PURPOSE: Step 6 - Load data from the view into the refined table.
******************************************************************************/

-- Clear the table before inserting
TRUNCATE TABLE tbl_highest_calorie_item;

-- Insert from view
INSERT INTO tbl_highest_calorie_item (item, restaurant, calories)
SELECT item, restaurant, calories
FROM vw_highest_calorie_item;
GO

/******************************************************************************
NAME: EC_IT143_W4.2_fastfoodnutrition_s7_nn.sql
PURPOSE: Step 7 - Create stored procedure to refresh the table.
******************************************************************************/

-- Drop procedure if it already exists
IF OBJECT_ID('usp_LoadHighestCalorieItem', 'P') IS NOT NULL
    DROP PROCEDURE usp_LoadHighestCalorieItem;
GO

-- Create procedure
CREATE PROCEDURE usp_LoadHighestCalorieItem
AS
BEGIN
    SET NOCOUNT ON;

    -- Clear existing data
    TRUNCATE TABLE tbl_highest_calorie_item;

    -- Insert new data from the view
    INSERT INTO tbl_highest_calorie_item (item, restaurant, calories)
    SELECT item, restaurant, calories
    FROM vw_highest_calorie_item;
END;
GO

/******************************************************************************
NAME: EC_IT143_W4.2_fastfoodnutrition_s8_nn.sql
PURPOSE: Step 8 - Call the stored procedure.
******************************************************************************/

EXEC usp_LoadHighestCalorieItem;
GO

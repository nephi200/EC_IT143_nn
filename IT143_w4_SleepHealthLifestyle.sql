
NAME: EC_IT143_W4.2_sleephealth_s1_nn.sql
PURPOSE: Step 1 of the My Community dataset assignment using Sleep Health and Lifestyle dataset.
MODIFICATION LOG:
Ver     Date        Author               Description
1.0     09/20/2025  Nephi Nyegonum       Initial version for IT143 Week 4 assignment
RUNTIME: ~1s
NOTES: This script documents the question I want to answer using the SleepHealth dataset.
-- Q1: How many individuals have sleep disorders?
-- A1: This script begins my answer-focused journey by identifying how many people in the dataset report having a sleep disorder.
--     I will use the SleepHealth table to count all rows where Sleep_Disorder is not 'None'.
/******************************************************************************
NAME: EC_IT143_W4.2_sleephealth_s2_nn.sql
PURPOSE: Step 2 of the My Community dataset assignment using Sleep Health and Lifestyle dataset.
MODIFICATION LOG:
Ver     Date        Author               Description
1.0     09/20/2025  Nephi Nyegonum       Initial version for IT143 Week 4 assignment
RUNTIME: ~1s
NOTES: This script outlines my approach to answering the question about how many individuals have sleep disorders.
******************************************************************************/

-- Q1: How many individuals have sleep disorders?
-- A1: To answer this, I need to examine the 'Sleep_Disorder' column in the SleepHealth table.
--     My first step will be to count all rows where Sleep_Disorder is not equal to 'None'.
--     This will give me a total number of individuals who report having either Insomnia or Sleep Apnea.
/******************************************************************************
NAME: EC_IT143_W4.2_sleephealth_s3_nn.sql
PURPOSE: Step 3 of the My Community dataset assignment using Sleep Health and Lifestyle dataset.
MODIFICATION LOG:
Ver     Date        Author               Description
1.0     09/20/2025  Nephi Nyegonum       Initial version for IT143 Week 4 assignment
RUNTIME: ~1s
NOTES: This script executes an ad hoc SQL query to count individuals with sleep disorders.
******************************************************************************/

-- Q1: How many individuals have sleep disorders?
-- A1: This query counts all rows in the SleepHealth table where Sleep_Disorder is not 'None'.

SELECT COUNT(*) AS DisorderCount
FROM SleepHealth
WHERE Sleep_Disorder <> 'None';
/******************************************************************************
NAME: EC_IT143_W4.2_sleephealth_s4_nn.sql
PURPOSE: Step 4 of the My Community dataset assignment using Sleep Health and Lifestyle dataset.
MODIFICATION LOG:
Ver     Date        Author               Description
1.0     09/20/2025  Nephi Nyegonum       Initial version for IT143 Week 4 assignment
RUNTIME: ~1s
NOTES: This script creates a view that returns the count of individuals with sleep disorders.
******************************************************************************/

-- Q1: How many individuals have sleep disorders?
-- A1: This view encapsulates the query that counts all individuals whose Sleep_Disorder is not 'None'.
-- Drop the view if it already exists
IF OBJECT_ID('vw_sleep_disorder_rows', 'V') IS NOT NULL
    DROP VIEW vw_sleep_disorder_rows;
GO   -- 👈 this batch separator must be respected

-- Create the view cleanly
CREATE VIEW vw_sleep_disorder_rows
AS
SELECT *
FROM dbo.SleepHealth
WHERE Sleep_Disorder <> 'None';
GO
/******************************************************************************
NAME: EC_IT143_W4.2_sleephealth_s5.1_nn.sql
PURPOSE: Step 5.1 of the My Community dataset assignment using Sleep Health and Lifestyle dataset.
MODIFICATION LOG:
Ver     Date        Author               Description
1.0     09/20/2025  Nephi Nyegonum       Initial version for IT143 Week 4 assignment
RUNTIME: ~1s
NOTES: This script creates a table from the view vw_sleep_disorder_count using SELECT INTO.
******************************************************************************/

-- Q1: How many individuals have sleep disorders?
-- A1: This script creates a table that stores the result of the view vw_sleep_disorder_count.
SELECT COUNT(*) AS DisorderCount
INTO tbl_sleep_disorder_count
FROM vw_sleep_disorder_rows;

/******************************************************************************
NAME: EC_IT143_W4.2_sleephealth_s5.2_nn.sql
PURPOSE: Step 5.2 of the My Community dataset assignment using Sleep Health and Lifestyle dataset.
MODIFICATION LOG:
Ver     Date        Author               Description
1.0     09/20/2025  Nephi Nyegonum       Initial version for IT143 Week 4 assignment
RUNTIME: ~1s
NOTES: This script refines the table tbl_sleep_disorder_count by adding a primary key and refined column definitions.
******************************************************************************/

-- Q1: How many individuals have sleep disorders?
-- A1: This script drops and recreates the table with a primary key and refined column definitions.

-- Drop the table if it already exists
IF OBJECT_ID('tbl_sleep_disorder_count', 'U') IS NOT NULL
    DROP TABLE tbl_sleep_disorder_count;

CREATE TABLE tbl_sleep_disorder_count (
    DisorderCount INT NOT NULL,
    CONSTRAINT PK_sleep_disorder_count PRIMARY KEY (DisorderCount)
);
/******************************************************************************
NAME: EC_IT143_W4.2_sleephealth_s6_nn.sql
PURPOSE: Step 6 of the My Community dataset assignment using Sleep Health and Lifestyle dataset.
MODIFICATION LOG:
Ver     Date        Author               Description
1.0     09/20/2025  Nephi Nyegonum       Initial version for IT143 Week 4 assignment
RUNTIME: ~1s
NOTES: This script loads data from the view vw_sleep_disorder_count into the table tbl_sleep_disorder_count.
******************************************************************************/

-- Q1: How many individuals have sleep disorders?
-- A1: This script inserts the result from the view into the refined table.

-- Clear the table before inserting new data
TRUNCATE TABLE tbl_sleep_disorder_count;

INSERT INTO tbl_sleep_disorder_count (DisorderCount)
SELECT COUNT(*) FROM vw_sleep_disorder_rows;
/******************************************************************************
NAME: EC_IT143_W4.2_sleephealth_s7_nn.sql
PURPOSE: Step 7 of the My Community dataset assignment using Sleep Health and Lifestyle dataset.
MODIFICATION LOG:
Ver     Date        Author               Description
1.0     09/20/2025  Nephi Nyegonum       Initial version for IT143 Week 4 assignment
RUNTIME: ~1s
NOTES: This script creates a stored procedure that loads the sleep disorder count into a table.
******************************************************************************/

-- Q1: How many individuals have sleep disorders?
-- A1: This stored procedure truncates the target table and inserts the result from the view.
-- Drop the procedure if it exists
IF OBJECT_ID('usp_LoadSleepDisorderCount', 'P') IS NOT NULL
    DROP PROCEDURE usp_LoadSleepDisorderCount;
GO   -- 👈 separate batch

-- Recreate the procedure
CREATE PROCEDURE usp_LoadSleepDisorderCount
AS
BEGIN
    SET NOCOUNT ON;

    TRUNCATE TABLE tbl_sleep_disorder_count;

    INSERT INTO tbl_sleep_disorder_count (DisorderCount)
    SELECT COUNT(*) FROM vw_sleep_disorder_rows;
END;
GO
/******************************************************************************
NAME: EC_IT143_W4.2_sleephealth_s8_nn.sql
PURPOSE: Step 8 of the My Community dataset assignment using Sleep Health and Lifestyle dataset.
MODIFICATION LOG:
Ver     Date        Author               Description
1.0     09/20/2025  Nephi Nyegonum       Initial version for IT143 Week 4 assignment
RUNTIME: ~1s
NOTES: This script calls the stored procedure usp_LoadSleepDisorderCount to refresh the table.
******************************************************************************/

-- Q1: How many individuals have sleep disorders?
-- A1: This script executes the stored procedure to load the sleep disorder count into the table.
EXEC usp_LoadSleepDisorderCount;
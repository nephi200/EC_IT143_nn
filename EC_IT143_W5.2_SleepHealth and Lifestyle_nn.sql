/*****************************************************************************************************************
NAME:    SleepHealth and Lifestyle
PURPOSE: Analyze sleep, stress, and lifestyle patterns from the SleepHealth and Lifestyle dataset.

MODIFICATION LOG:
Ver      Date        Author           Description
-----   ----------   -----------      -------------------------------------------------------------------------------
1.0     09/28/2025   Nephi Nyegonum    1. Built this script for EC IT143 - My Communities Analysis

RUNTIME: 
Xm Xs

NOTES: 
This script answers four questions about the SleepHealth and Lifestyle dataset using SQL queries. It explores relationships between age, physical activity, stress, sleep quality, and cardiovascular indicators.
******************************************************************************************************************/

-- Q1: Are younger participants with high physical activity levels reporting better sleep quality compared to older participants with lower activity levels?
-- A1: This query compares sleep quality across age and physical activity levels.
-- Author: Shane
SELECT Age, Physical_Activity_Level, Quality_of_Sleep
FROM sleephealth
WHERE (Age < 30 AND Physical_Activity_Level >= 7)
   OR (Age >= 30 AND Physical_Activity_Level <= 4);

-- Q2: Which occupations have the highest stress levels?
-- A2: This query returns occupations with the highest average stress levels and includes sleep duration for wellness insights.
-- Author: David

SELECT Occupation, AVG(Stress_Level) AS Avg_Stress_Level, AVG(Sleep_Duration) AS Avg_Sleep_Duration
FROM sleephealth
GROUP BY Occupation
ORDER BY Avg_Stress_Level DESC;

-- Q3: What is the average sleep duration for people with high stress levels and poor sleep quality?
-- A3: This query calculates average sleep duration for individuals with high stress and poor sleep quality.
-- Author: Nephi

SELECT AVG(Sleep_Duration) AS Avg_Sleep_Duration
FROM sleephealth
WHERE Stress_Level >= 5 AND Quality_of_Sleep <= 5;

-- Q4: What is the average number of daily steps taken by individuals with normal blood pressure and no sleep disorder?
-- A4: This query calculates average daily steps for individuals with healthy cardiovascular and sleep profiles.
-- Author: Nephi

SELECT AVG(Daily_Steps) AS Avg_Daily_Steps
FROM sleephealth
WHERE Blood_Pressure = 'Normal' AND Sleep_Disorder = 'No';


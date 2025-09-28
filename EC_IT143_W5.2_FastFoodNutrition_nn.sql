/*****************************************************************************************************************
NAME:    FastFoodNutrition.sql
PURPOSE: Analyze nutritional patterns in fast food items to support health-conscious decision-making.

MODIFICATION LOG:
Ver      Date        Author           Description
-----   ----------   -----------      -------------------------------------------------------------------------------
1.0     09/28/2025   Nephi Nyegonum   1. Built this script for EC IT143 - My Communities Analysis

RUNTIME: 
Xm Xs

NOTES: 
This script answers four questions about the FastFoodNutrition dataset using SQL queries. It explores sodium, calorie, sugar, and protein content across menu items and restaurant chains.
******************************************************************************************************************/
-- Q1: Which fast food items contain trans-fat but are marketed as healthy options (e.g., salads)?
-- A1: This query identifies salad items that contain trans-fat, helping health officials flag misleading “healthy” menu labels.
-- Author: Nephi

SELECT item, restaurant, TRY_CAST(trans_fat AS FLOAT) AS trans_fat, salad
FROM fastfood
WHERE TRY_CAST(trans_fat AS FLOAT) > 0 AND salad = 'Salad';

-- Q2: Which fast food items have more than 500 calories but less than 5 grams of sugar?
-- A2: This query finds high-calorie, low-sugar items for health-conscious customers.
-- Author: Nephi

SELECT item, restaurant, calories, sugar
FROM fastfood
WHERE calories > 500 AND sugar < 5;

-- Q3: Which restaurants offer items with less than 300 calories and more than 10 grams of protein?
-- A3: This query highlights low-calorie, high-protein options across restaurants.
-- Author: Nephi

SELECT restaurant, item, calories, protein
FROM fastfood
WHERE calories < 300 AND protein > 10;

-- Q4: Which restaurants have the highest average sodium levels in their salads compared to their non-salad items?
-- A4: This query compares average sodium levels between salad and non-salad items per restaurant.
-- Author: Ethan
SELECT restaurant,
       AVG(CASE WHEN salad = 'Yes' THEN TRY_CAST(sodium AS FLOAT) ELSE NULL END) AS avg_salad_sodium,
       AVG(CASE WHEN salad = 'No' THEN TRY_CAST(sodium AS FLOAT) ELSE NULL END) AS avg_non_salad_sodium
FROM fastfood
GROUP BY restaurant
ORDER BY avg_salad_sodium DESC;

/*
Data exploration
*/

-- Visualizing data
SELECT *
FROM [COVID Project]..CovidDeaths;

-- List of continents: 
-- 7 distinct values, 6 continents and some null values
SELECT DISTINCT(continent)
FROM [COVID Project]..CovidDeaths;

-- Understand null continents:
-- Data contains information of some regions and group of people such as 
-- income level and continents aggrupations
SELECT DISTINCT(location)
FROM [COVID Project]..CovidDeaths
WHERE continent IS NULL;

-- Create new cases per million
SELECT location, date, total_cases, new_cases,
total_cases / (population / 1000000) AS cases_per_m
FROM [COVID Project]..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;

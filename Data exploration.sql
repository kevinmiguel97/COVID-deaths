/*
Exploratory data analysis of COVID deaths and 
COVID Vaccination databases
*/

-- Checking data uploaded Vaccinations
SELECT *
FROM [COVID Project]..CovidVaccinations
ORDER BY location, date;

-- Checking data uploaded Deaths
SELECT *
FROM [COVID Project]..CovidDeaths
ORDER BY location, date;

-- Calculatin death ratio
SELECT location, date, total_cases, total_deaths,
(total_deaths / total_cases) * 100 AS death_ratio
FROM [COVID Project]..CovidDeaths
WHERE location = 'Mexico'
ORDER BY location, date;

-- Total cases vs Population by country
SELECT location, MAX(total_cases / population) * 100 AS infection_ratio
FROM [COVID Project]..CovidDeaths 
GROUP BY location
ORDER BY infection_ratio DESC; 

-- Ranking countries by death
SELECT location, MAX(total_deaths) AS max_deaths
FROM [COVID Project]..CovidDeaths 
GROUP BY location
ORDER BY max_deaths DESC; 
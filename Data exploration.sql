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

SELECT location, date, total_cases, new_cases, 
total_deaths, population
FROM [COVID Project]..CovidDeaths
ORDER BY location, date; 

-- Total cases vs total deaths
SELECT location, SUM(new_cases)
FROM [COVID Project]..CovidDeaths


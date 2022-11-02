/*
Exploratory data analysis of COVID deaths and 
COVID Vaccination databases
*/

-- Select relevant data
SELECT location, date, population, total_cases, 
new_cases, total_deaths
FROM [COVID Project]..CovidDeaths
ORDER BY location, date

-- Create death rate
SELECT *
FROM [COVID Project]..CovidDeaths


SELECT SUM(total_deaths)
FROM [COVID Project]..CovidDeaths


/*
This file contains the queries used to obtain the data that will be used
to create Tableau Dashboard of COVID
*/

-- Visualization 1: World cases, deaths and mortality
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, (SUM(new_deaths) / SUM(new_cases)) * 100 AS mortality_pct
FROM [Covid Project]..CovidDeaths
WHERE continent IS NOT NULL

-- Visualization 2: Total deaths by continent
SELECT continent, SUM(new_deaths) AS total_deaths
FROM [COVID Project]..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_deaths DESC

-- Visualization 3: Population infection % 
SELECT location, ISNULL(MAX(population), 0) AS Population, ISNULL(MAX(total_cases), 0) as Total_cases,
ISNULL((MAX(total_cases) / MAX(population)) * 100, 0) AS Population_infected_pct
FROM [COVID Project]..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Population_infected_pct DESC  

-- Visualization 4 - Evolution of cases
SELECT location, AVG(population) AS population, date, ISNULL(MAX(total_cases), 0) AS total_cases, 
ISNULL((MAX(total_cases / population)) * 100, 0) AS Population_infected_pct
FROM [COVID Project]..CovidDeaths
GROUP BY location, date
ORDER BY location, date
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
/*
Data contains regions such as World, Afric, etc. 
To deal with this, we are going to filter where 
continent is null
*/
SELECT location, MAX(total_deaths) AS max_deaths
FROM [COVID Project]..CovidDeaths 
WHERE continent is not NULL
GROUP BY location
ORDER BY max_deaths DESC; 

-- Summarizing regions by filtering where continent is null
SELECT continent, MAX(total_deaths) AS max_deaths
FROM [COVID Project]..CovidDeaths 
WHERE continent is not NULL
GROUP BY continent
ORDER BY max_deaths DESC;

-------------------------------------------------------------------------------

-- Joining deaths and vaccinations tables
-- and 
-- Generating cumulative vaccinations in countries by date 
SELECT deaths.continent, deaths.location, deaths.date, deaths.population,
vax.new_vaccinations,
SUM(vax.new_vaccinations) OVER (PARTITION BY deaths.location ORDER BY deaths.date) AS cumulative_vaccinations
FROM [COVID Project]..CovidDeaths as deaths
JOIN [COVID Project]..CovidVaccinations as vax
    ON deaths.location = vax.location 
    AND deaths.date = vax.date
WHERE deaths.continent IS NOT NULL
ORDER BY deaths.location, deaths.date;

/*
We cannot perform a calculation on a column created. To obtain % of population vaccinated we use a CTE 
*/
WITH CTE_Pop_Vax (continent, location, date, population, new_vaccinations, cumulative_vaccinations)
AS
(
    SELECT deaths.continent, deaths.location, deaths.date, deaths.population,
    vax.new_vaccinations,
    SUM(vax.new_vaccinations) OVER (PARTITION BY deaths.location ORDER BY deaths.date) AS cumulative_vaccinations
    FROM [COVID Project]..CovidDeaths as deaths
    JOIN [COVID Project]..CovidVaccinations as vax
        ON deaths.location = vax.location 
        AND deaths.date = vax.date
    WHERE deaths.continent IS NOT NULL
)
SELECT *, (cumulative_vaccinations / population) * 100 AS pct_vaccinations
FROM CTE_Pop_Vax
ORDER BY location, date
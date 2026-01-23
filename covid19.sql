CREATE TABLE covid19 (
    iso_code TEXT,
    continent TEXT,
    location TEXT,
    date DATE,
    total_cases NUMERIC,
    new_cases NUMERIC,
    new_cases_smoothed REAL,
    total_deaths NUMERIC,
    new_deaths NUMERIC,
    new_deaths_smoothed REAL,
    total_cases_per_million REAL,
    new_cases_per_million REAL,
    new_cases_smoothed_per_million REAL,
    total_deaths_per_million REAL,
    new_deaths_per_million REAL,
    new_deaths_smoothed_per_million REAL,
    reproduction_rate REAL,
    icu_patients NUMERIC,
    icu_patients_per_million REAL,
    hosp_patients NUMERIC,
    hosp_patients_per_million REAL, 
    weekly_icu_admissions NUMERIC,
    weekly_icu_admissions_per_million REAL,
    weekly_hosp_admissions NUMERIC,
    weekly_hosp_admissions_per_million REAL,
    total_tests NUMERIC,
    new_tests NUMERIC,
    total_tests_per_thousand REAL,
    new_tests_per_thousand REAL,
    new_tests_smoothed REAL,
    new_tests_smoothed_per_thousand REAL,
    positive_rate REAL,
    tests_per_case REAL,
    tests_units TEXT,
    total_vaccinations NUMERIC,
    people_vaccinated NUMERIC,
    people_fully_vaccinated NUMERIC,
    total_boosters NUMERIC,
    new_vaccinations NUMERIC,
    new_vaccinations_smoothed REAL, 
    total_vaccinations_per_hundred REAL,
    people_vaccinated_per_hundred REAL,
    people_fully_vaccinated_per_hundred REAL,
    total_boosters_per_hundred REAL,
    new_vaccinations_smoothed_per_million REAL,
    new_people_vaccinated_smoothed REAL,
    new_people_vaccinated_smoothed_per_hundred REAL,    
    stringency_index REAL,
    population_density REAL,
    median_age  REAL,
    aged_65_older REAL, 
    aged_70_older REAL,
    gdp_per_capita REAL,
    extreme_poverty REAL,
    cardiovasc_death_rate REAL,
    diabetes_prevalence REAL,
    female_smokers REAL,
    male_smokers REAL,
    handwashing_facilities REAL,
    hospital_beds_per_thousand REAL,
    life_expectancy REAL,
    human_development_index REAL,
    population NUMERIC,
    excess_mortality_cumulative_absolute REAL,
    excess_mortality_cumulative REAL,
    excess_mortality REAL,
    excess_mortality_cumulative_per_million REAL
);

SELECT * FROM covid19;

-- 
SELECT COUNT(*)
FROM covid19;

-- 
SELECT MIN(date), MAX(date)
FROM covid19;

-- 
SELECT continent, location, date, total_cases, new_cases, total_deaths, new_deaths, total_vaccinations, new_vaccinations, population, life_expectancy
FROM covid19;

-- 
SELECT location, SUM(new_cases) AS "total_infected"
FROM covid19
GROUP BY location;

SELECT location, MAX(total_cases) AS "total_infected"
FROM covid19
GROUP BY location;

-- 
SELECT location, SUM(new_cases) AS "total_infected"
FROM covid19
GROUP BY location
HAVING location LIKE '%stan';

-- 
SELECT 
	location, 
	SUM(new_cases) AS "total_infected",
	SUM(new_deaths) AS "total_deaths",
	SUM(new_vaccinations) AS "total_vaccinations"
FROM covid19
GROUP BY location
HAVING location LIKE '%stan';

-- 
SELECT 
	location, 
	SUM(new_cases) AS "total_infected",
	SUM(new_deaths) AS "total_deaths",
	SUM(new_vaccinations) AS "total_vaccinations",
	ROUND((SUM(new_vaccinations) / population) * 100, 2) AS "vaccination_percentage",
	population
FROM covid19
GROUP BY location, population
HAVING location LIKE '%stan';

-- 
SELECT 
	location, 
	SUM(new_cases) AS "total_infected",
	SUM(new_deaths) AS "total_deaths",
	SUM(new_vaccinations) AS "total_vaccinations",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	ROUND((SUM(new_vaccinations) / population) * 100, 2) AS "vaccination_percentage",
	population
FROM covid19
GROUP BY location, population
HAVING location LIKE '%stan';

-- 
SELECT 
	location, 
	SUM(new_cases) AS "total_infected",
	SUM(new_deaths) AS "total_deaths",
	SUM(new_vaccinations) AS "total_vaccinations",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	ROUND((SUM(new_vaccinations) / population) * 100, 2) AS "vaccination_percentage",
	population
FROM covid19
GROUP BY location, population
ORDER BY infection_percentage DESC;

-- 
SELECT 
	location, 
	SUM(new_cases) AS "total_infected",
	SUM(new_deaths) AS "total_deaths",
	SUM(new_vaccinations) AS "total_vaccinations",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	ROUND((SUM(new_deaths) / population) * 100, 2) AS "death_percentage",
	ROUND((SUM(new_vaccinations) / population) * 100, 2) AS "vaccination_percentage",
	population
FROM covid19
GROUP BY location, population
ORDER BY death_percentage DESC;

-- 
SELECT 
	location, 
	SUM(new_cases) AS "total_infected",
	SUM(new_deaths) AS "total_deaths",
	SUM(new_vaccinations) AS "total_vaccinations",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	ROUND((SUM(new_deaths) / population) * 100, 4) AS "death_percentage",
	ROUND((SUM(new_vaccinations) / population) * 100, 2) AS "vaccination_percentage",
	population
FROM covid19
GROUP BY location, population
ORDER BY death_percentage DESC;

-- 
-- 
SELECT 
	location, 
	COALESCE(SUM(new_cases), 0) AS "total_infected",
	COALESCE(SUM(new_deaths), 0) AS "total_deaths",
	COALESCE(SUM(new_vaccinations), 0) AS "total_vaccinations",
	ROUND((COALESCE(SUM(new_cases), 0) / population) * 100, 2) AS "infection_percentage",
	ROUND((COALESCE(SUM(new_deaths), 0) / population) * 100, 4) AS "death_percentage",
	ROUND((COALESCE(SUM(new_vaccinations), 0) / population) * 100, 2) AS "vaccination_percentage",
	population
FROM covid19
GROUP BY location, population
ORDER BY death_percentage DESC;

-- 
SELECT 
	location, 
	COALESCE(SUM(new_cases), 0) AS "total_infected",
	COALESCE(SUM(new_deaths), 0) AS "total_deaths",
	COALESCE(SUM(new_vaccinations), 0) AS "total_vaccinations",
	ROUND((COALESCE(SUM(new_cases), 0) / population) * 100, 2) AS "infection_percentage",
	ROUND((COALESCE(SUM(new_deaths), 0) / population) * 100, 4) AS "death_percentage",
	ROUND((COALESCE(SUM(new_vaccinations), 0) / population) * 100, 2) AS "vaccination_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases), 0)=0 THEN NULL
		ELSE ROUND((COALESCE(SUM(new_deaths), 0) / COALESCE(SUM(new_cases), 0))*100, 2)
	END AS "death_percentage_total_infected",
	population
FROM covid19
GROUP BY location, population
ORDER BY death_percentage DESC;

-- 
CREATE VIEW covidView AS 
	SELECT continent, location, date, total_cases, new_cases, total_deaths, new_deaths, total_vaccinations, new_vaccinations, population, life_expectancy
	FROM covid19;

-- 
SELECT * FROM covidView;

-- 
SELECT 
	location, 
	COALESCE(SUM(new_cases), 0) AS "total_infected",
	COALESCE(SUM(new_deaths), 0) AS "total_deaths",
	COALESCE(SUM(new_vaccinations), 0) AS "total_vaccinations",
	ROUND((COALESCE(SUM(new_cases), 0) / population) * 100, 2) AS "infection_percentage",
	ROUND((COALESCE(SUM(new_deaths), 0) / population) * 100, 4) AS "death_percentage",
	ROUND((COALESCE(SUM(new_vaccinations), 0) / population) * 100, 2) AS "vaccination_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases), 0)=0 THEN NULL
		ELSE ROUND((COALESCE(SUM(new_deaths), 0) / COALESCE(SUM(new_cases), 0))*100, 2)
	END AS "death_percentage_total_infected",
	population,
	life_expectancy
FROM covid19
GROUP BY location, population, life_expectancy
ORDER BY life_expectancy DESC;

-- 
SELECT 
	location, 
	COALESCE(SUM(new_cases), 0) AS "total_infected",
	COALESCE(SUM(new_deaths), 0) AS "total_deaths",
	COALESCE(SUM(new_vaccinations), 0) AS "total_vaccinations",
	ROUND((COALESCE(SUM(new_cases), 0) / population) * 100, 2) AS "infection_percentage",
	ROUND((COALESCE(SUM(new_deaths), 0) / population) * 100, 4) AS "death_percentage",
	ROUND((COALESCE(SUM(new_vaccinations), 0) / population) * 100, 2) AS "vaccination_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases), 0)=0 THEN NULL
		ELSE ROUND((COALESCE(SUM(new_deaths), 0) / COALESCE(SUM(new_cases), 0))*100, 2)
	END AS "death_percentage_total_infected",
	population,
	life_expectancy
FROM covid19
GROUP BY location, population, life_expectancy
HAVING location IN ('Asia', 'Africa', 'Europe', 'North America', 'South America', 'Oceania')
ORDER BY total_infected DESC;

-- 
SELECT 
	location, 
	COALESCE(SUM(new_cases), 0) AS "total_infected",
	COALESCE(SUM(new_deaths), 0) AS "total_deaths",
	COALESCE(SUM(new_vaccinations), 0) AS "total_vaccinations",
	ROUND((COALESCE(SUM(new_cases), 0) / population) * 100, 2) AS "infection_percentage",
	ROUND((COALESCE(SUM(new_deaths), 0) / population) * 100, 4) AS "death_percentage",
	ROUND((COALESCE(SUM(new_vaccinations), 0) / population) * 100, 2) AS "vaccination_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases), 0)=0 THEN NULL
		ELSE ROUND((COALESCE(SUM(new_deaths), 0) / COALESCE(SUM(new_cases), 0))*100, 2)
	END AS "death_percentage_total_infected",
	population,
	life_expectancy
FROM covid19
GROUP BY location, population, life_expectancy, continent
HAVING continent IS NULL
ORDER BY life_expectancy DESC;

-- 
SELECT 
	location, 
	COALESCE(SUM(new_cases), 0) AS "total_infected",
	COALESCE(SUM(new_deaths), 0) AS "total_deaths",
	COALESCE(SUM(new_vaccinations), 0) AS "total_vaccinations",
	ROUND((COALESCE(SUM(new_cases), 0) / population) * 100, 2) AS "infection_percentage",
	ROUND((COALESCE(SUM(new_deaths), 0) / population) * 100, 4) AS "death_percentage",
	ROUND((COALESCE(SUM(new_vaccinations), 0) / population) * 100, 2) AS "vaccination_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases), 0)=0 THEN NULL
		ELSE ROUND((COALESCE(SUM(new_deaths), 0) / COALESCE(SUM(new_cases), 0))*100, 2)
	END AS "death_percentage_total_infected",
	population,
	life_expectancy
FROM covid19
GROUP BY location, population, life_expectancy, continent
HAVING continent IS NULL AND location='World'
ORDER BY life_expectancy DESC;

-- Data per continent using CTE
WITH countries AS (
	SELECT 
		continent,
		location, 
		COALESCE(SUM(new_cases), 0) AS "total_infected",
		COALESCE(SUM(new_deaths), 0) AS "total_deaths",
		COALESCE(SUM(new_vaccinations), 0) AS "total_vaccinations",
		ROUND((COALESCE(SUM(new_cases), 0) / population) * 100, 2) AS "infection_percentage",
		ROUND((COALESCE(SUM(new_deaths), 0) / population) * 100, 4) AS "death_percentage",
		ROUND((COALESCE(SUM(new_vaccinations), 0) / population) * 100, 2) AS "vaccination_percentage",
		CASE
			WHEN COALESCE(SUM(new_cases), 0)=0 THEN NULL
			ELSE ROUND((COALESCE(SUM(new_deaths), 0) / COALESCE(SUM(new_cases), 0))*100, 2)
		END AS "death_percentage_total_infected",
		population,
		life_expectancy
	FROM covid19
	GROUP BY location, population, life_expectancy, continent
	HAVING continent IS NOT NULL
	ORDER BY location
)
SELECT 
	continent,
	SUM(total_infected) AS "total_infected",
	SUM(total_deaths) AS "total_deaths",
	SUM(total_vaccinations) AS "total_vaccinations",
	SUM(population) AS "total_population",
	ROUND(AVG(infection_percentage), 2) AS "infection_percentage",
	ROUND(AVG(death_percentage), 2) AS "death_percentage",
	ROUND(AVG(vaccination_percentage), 2) AS "vaccination_percentage",
	ROUND(AVG(life_expectancy)::numeric, 2) AS "life_expectancy"
FROM countries
GROUP BY continent
ORDER BY total_infected DESC;

CREATE TABLE covid (
	iso_code TEXT,
	continent TEXT,
	location TEXT,
	date DATE,
	total_case NUMERIC,
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
	weekly_icu_admissions REAL,
	weekly_icu_admissions_per_million REAL,
	weekly_hosp_admissions REAL,
	weekly_hosp_admissions_per_million REAL,
	new_tests NUMERIC,
	total_tests NUMERIC,
	total_tests_per_thousand REAL,
	new_tests_per_thousand REAL,
	new_tests_smoothed NUMERIC,
	new_tests_smoothed_per_thousand REAL,
	positive_rate REAL,
	tests_per_case REAL,
	tests_units TEXT,
	total_vaccinations NUMERIC,
	people_vaccinated NUMERIC,
	people_fully_vaccinated NUMERIC,
	new_vaccinations NUMERIC,
	new_vaccinations_smoothed NUMERIC,
	total_vaccinations_per_hundred REAL,
	people_vaccinated_per_hundred REAL,
	people_fully_vaccinated_per_hundred REAL,
	new_vaccinations_smoothed_per_million NUMERIC,
	stringency_index REAL,
	population NUMERIC,
	population_density REAL,
	median_age REAL,
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
	human_development_index REAL
);


SELECT * 
FROM covid;

-- 1. 
SELECT COUNT(*)
FROM covid;

-- 2. 
SELECT continent, location, date, total_case, new_cases, total_deaths, new_deaths, population
FROM covid;

-- 
SELECT continent, location, date, total_case, new_cases, total_deaths, new_deaths, population
FROM covid
WHERE location='Kyrgyzstan';

-- 
SELECT MIN(date), MAX(date)
FROM covid;

-- 
SELECT MAX(total_case) AS "total_case"
FROM covid
WHERE location='Kyrgyzstan';

SELECT SUM(new_cases) AS "total_case"
FROM covid
WHERE location='Kyrgyzstan';

-- 
SELECT MAX(total_case) AS "total_case", MAX(total_deaths) AS "total_deaths"
FROM covid
WHERE location='Kyrgyzstan';

SELECT SUM(new_cases) AS "total_case", SUM(new_deaths) AS "total_deaths"
FROM covid
WHERE location='Kyrgyzstan';

-- 
SELECT location, MAX(total_case) AS "total_case", MAX(total_deaths) AS "total_deaths", (MAX(total_deaths)/MAX(total_case))*100 AS "death_percentage"
FROM covid
GROUP BY location
HAVING location='Kyrgyzstan';

SELECT location, MAX(total_case) AS "total_case", MAX(total_deaths) AS "total_deaths", (MAX(total_deaths)/MAX(total_case))*100 AS "death_percentage"
FROM covid
GROUP BY location
ORDER BY total_deaths DESC;

-- 
SELECT location, date, total_case, COALESCE(total_deaths, 0) AS "total_deaths"
FROM covid
WHERE location='Kyrgyzstan';

SELECT location, date, total_case, total_deaths
FROM covid
WHERE location='Kyrgyzstan';

-- 
SELECT location, MAX(total_case) AS "total_case", MAX(total_deaths) AS "total_deaths", (MAX(total_deaths)/MAX(total_case))*100 AS "death_percentage"
FROM covid
GROUP BY location
HAVING location IN ('Kazakhstan', 'Kyrgyzstan', 'Uzbekistan', 'Tajikistan')
ORDER BY total_deaths DESC;

-- 
SELECT continent, MAX(total_case), MAX(total_deaths)
FROM covid
GROUP BY continent
HAVING continent IS NOT NULL
ORDER BY MAX(total_case) DESC;

-- 
SELECT continent, location, date, total_case, new_cases, total_deaths, new_deaths, population
FROM covid

WHERE location='World';

SHOW DateStyle;
-- SET DateStyle = 'ISO, DMY';

-- vaccinations table
CREATE TABLE vaccinations (
	iso_code TEXT,
	continent TEXT,
	location TEXT,
	date DATE,
	new_tests NUMERIC,	
	total_tests	NUMERIC,
	total_tests_per_thousand REAL,	
	new_tests_per_thousand REAL,
	new_tests_smoothed NUMERIC,
	new_tests_smoothed_per_thousand	REAL,
	positive_rate REAL,
	tests_per_case REAL,
	tests_units TEXT,
	total_vaccinations NUMERIC, 
	people_vaccinated NUMERIC,
	people_fully_vaccinated	NUMERIC,
	new_vaccinations NUMERIC,
	new_vaccinations_smoothed NUMERIC,
	total_vaccinations_per_hundred REAL,
	people_vaccinated_per_hundred REAL,
	people_fully_vaccinated_per_hundred	REAL,
	new_vaccinations_smoothed_per_million NUMERIC,
	stringency_index REAL,
	population_density REAL,
	median_age NUMERIC,
	aged_65_older REAL,
	aged_70_older REAL,
	gdp_per_capita	REAL,
	extreme_poverty REAL,
	cardiovasc_death_rate REAL,
	diabetes_prevalence REAL,
	female_smokers REAL,
	male_smokers REAL,
	handwashing_facilities REAL,
	hospital_beds_per_thousand REAL,
	life_expectancy REAL,
	human_development_index REAL
);

SELECT continent, location, date, new_vaccinations, total_vaccinations 
FROM vaccinations;

SELECT continent, location, date, new_vaccinations, total_vaccinations 
FROM vaccinations
WHERE location LIKE 'United States%';

-- 
SELECT continent, location, SUM(COALESCE(new_vaccinations, 0)) AS "total_vaccination"
FROM vaccinations
GROUP BY location, continent
HAVING continent IS NOT NULL
ORDER BY total_vaccination DESC;

-- 
SELECT location, SUM(new_vaccinations) AS "total_vaccinations"
FROM vaccinations
WHERE continent IS NULL
GROUP BY location
ORDER BY total_vaccinations DESC;

-- 
SELECT continent, location, date, total_case, new_cases, total_deaths, new_deaths, population
FROM covid;

CREATE VIEW covid19 AS (
	SELECT v.continent, v.location, v.date, v.new_vaccinations, v.total_vaccinations, c.new_cases, c.total_case, c.new_deaths, c.total_deaths, c.population
	FROM vaccinations v
	JOIN covid c ON v.location=c.location AND v.date=c.date
	ORDER BY v.location
);

SELECT * FROM covid19;

-- 
SELECT 
	location, 
	SUM(COALESCE(new_vaccinations, 0)) AS "total_vacc", 
	population, 
	COALESCE(ROUND((SUM(new_vaccinations)/population)*100, 2), 0) AS "vaccination_percentage"
FROM covid19
GROUP BY location, population, continent
HAVING continent IS NOT NULL
ORDER BY vaccination_percentage DESC
LIMIT 5;

-- 
SELECT location, SUM(new_vaccinations) AS "total_vaccination", population, ROUND((SUM(new_vaccinations)/population)*100, 2)
FROM covid19
WHERE continent IS NULL
GROUP BY location, population
ORDER BY location;


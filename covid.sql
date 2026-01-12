SELECT *
FROM covid;

-- 
SELECT 
	continent, location, date, 
	total_cases, new_cases, 
	total_deaths, new_deaths, 
	total_vaccinations, new_vaccinations, 
	population, 
	life_expectancy, human_development_index
FROM covid;

-- 
SELECT
	continent, location, date, 
	total_cases, new_cases, 
	total_deaths, new_deaths, 
	total_vaccinations, new_vaccinations, 
	population, 
	life_expectancy, human_development_index
FROM covid
WHERE location LIKE 'Kyrgyz%';


-- 
SELECT location, SUM(new_cases) AS "total_cases"
FROM covid
GROUP BY location
ORDER BY total_cases DESC;

-- 
CREATE VIEW cov AS (
	SELECT 
		continent, location, date, 
		total_cases, new_cases, 
		total_deaths, new_deaths, 
		total_vaccinations, new_vaccinations, 
		population, 
		life_expectancy, human_development_index
	FROM covid
);

SELECT * FROM cov;

-- 
SELECT continent, location, SUM(new_cases) AS "total_cases"
FROM covid
GROUP BY location, continent
HAVING location IN ('Africa', 'Asia', 'Europe', 'North America', 'South America', 'Oceania')
ORDER BY total_cases DESC;

-- 
SELECT continent, location, SUM(new_cases) AS "total_cases"
FROM covid
GROUP BY location, continent
HAVING continent IS NOT NULL
ORDER BY total_cases DESC;

-- 
SELECT location, population, SUM(new_cases) AS "total_cases", ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage"
FROM covid
GROUP BY location, continent, population
HAVING continent IS NOT NULL
ORDER BY total_cases DESC;

-- 
SELECT location, population, SUM(new_cases) AS "total_cases", ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage"
FROM covid
GROUP BY location, continent, population
HAVING continent IS NOT NULL AND location='Kyrgyzstan'
ORDER BY total_cases DESC;

-- 
SELECT COUNT(*)
FROM covid;

-- 
SELECT MIN(date), MAX(date)
FROM covid;

-- 
SELECT 
	location, population, 
	SUM(new_cases) AS "total_cases",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	SUM(new_deaths) AS "total_deaths",
	ROUND((SUM(new_deaths) / population) * 100, 2) AS "death_percentage"
FROM covid
GROUP BY location, continent, population
HAVING continent IS NOT NULL
ORDER BY total_cases DESC;

-- 
SELECT 
	location, population, 
	SUM(new_cases) AS "total_cases",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	SUM(new_deaths) AS "total_deaths",
	ROUND((SUM(new_deaths) / population) * 100, 2) AS "death_percentage"
FROM covid
GROUP BY location, continent, population
HAVING continent IS NOT NULL AND location='Kyrgyzstan'
ORDER BY total_cases DESC;

-- 
SELECT 
	location, population, 
	SUM(new_cases) AS "total_cases",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	SUM(new_deaths) AS "total_deaths",
	ROUND((SUM(new_deaths) / population) * 100, 2) AS "death_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases),0)=0 THEN ROUND((SUM(new_deaths) / (COALESCE(SUM(new_cases),0)+1) ) * 100, 2)
		ELSE ROUND((SUM(new_deaths) / COALESCE(SUM(new_cases),0)) * 100, 2)
	END AS "death_cases_percentage"
FROM covid
GROUP BY location, continent, population
HAVING continent IS NOT NULL
ORDER BY total_cases DESC;

-- 
SELECT 
	location, population, 
	SUM(new_cases) AS "total_cases",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	SUM(new_deaths) AS "total_deaths",
	ROUND((SUM(new_deaths) / population) * 100, 2) AS "death_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases),0)=0 THEN ROUND((SUM(new_deaths) / (COALESCE(SUM(new_cases),0)+1) ) * 100, 2)
		ELSE ROUND((SUM(new_deaths) / COALESCE(SUM(new_cases),0)) * 100, 2)
	END AS "death_cases_percentage",
	SUM(new_vaccinations) AS "total_vaccinations",
	ROUND((SUM(new_vaccinations) / population) * 100, 2) AS "vaccination_percentage"
FROM covid
GROUP BY location, continent, population
HAVING continent IS NOT NULL
ORDER BY total_cases DESC;

-- 
SELECT * FROM cov;

-- 
SELECT 
	location, population, 
	SUM(new_cases) AS "total_cases",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	SUM(new_deaths) AS "total_deaths",
	ROUND((SUM(new_deaths) / population) * 100, 2) AS "death_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases),0)=0 THEN ROUND((SUM(new_deaths) / (COALESCE(SUM(new_cases),0)+1) ) * 100, 2)
		ELSE ROUND((SUM(new_deaths) / COALESCE(SUM(new_cases),0)) * 100, 2)
	END AS "death_cases_percentage",
	SUM(new_vaccinations) AS "total_vaccinations",
	ROUND((SUM(new_vaccinations) / population) * 100, 2) AS "vaccination_percentage"
FROM covid
GROUP BY location, continent, population
HAVING continent IS NOT NULL AND location='Kyrgyzstan'
ORDER BY total_cases DESC;

-- 
SELECT 
	location, population, 
	SUM(new_cases) AS "total_cases",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	SUM(new_deaths) AS "total_deaths",
	ROUND((SUM(new_deaths) / population) * 100, 2) AS "death_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases),0)=0 THEN ROUND((SUM(new_deaths) / (COALESCE(SUM(new_cases),0)+1) ) * 100, 2)
		ELSE ROUND((SUM(new_deaths) / COALESCE(SUM(new_cases),0)) * 100, 2)
	END AS "death_cases_percentage",
	SUM(new_vaccinations) AS "total_vaccinations",
	ROUND((SUM(new_vaccinations) / population) * 100, 2) AS "vaccination_percentage"
FROM covid
GROUP BY location, continent, population
HAVING continent IS NOT NULL
ORDER BY total_cases DESC;

-- 
SELECT 
	location,
	SUM(new_cases) AS "total_cases",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	SUM(new_deaths) AS "total_deaths",
	ROUND((SUM(new_deaths) / population) * 100, 2) AS "death_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases),0)=0 THEN ROUND((SUM(new_deaths) / (COALESCE(SUM(new_cases),0)+1) ) * 100, 2)
		ELSE ROUND((SUM(new_deaths) / COALESCE(SUM(new_cases),0)) * 100, 2)
	END AS "death_cases_percentage",
	SUM(new_vaccinations) AS "total_vaccinations",
	ROUND((SUM(new_vaccinations) / population) * 100, 2) AS "vaccination_percentage",
	life_expectancy,
	human_development_index
FROM covid
GROUP BY location, continent, population, life_expectancy, human_development_index
HAVING continent IS NOT NULL
ORDER BY total_cases DESC;

-- 
SELECT 
	location, population,
	SUM(new_cases) AS "total_cases",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	SUM(new_deaths) AS "total_deaths",
	ROUND((SUM(new_deaths) / population) * 100, 2) AS "death_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases),0)=0 THEN ROUND((SUM(new_deaths) / (COALESCE(SUM(new_cases),0)+1) ) * 100, 2)
		ELSE ROUND((SUM(new_deaths) / COALESCE(SUM(new_cases),0)) * 100, 2)
	END AS "death_cases_percentage",
	SUM(new_vaccinations) AS "total_vaccinations",
	ROUND((SUM(new_vaccinations) / population) * 100, 2) AS "vaccination_percentage",
	life_expectancy,
	human_development_index
FROM covid
GROUP BY location, continent, population, life_expectancy, human_development_index
HAVING continent IS NOT NULL AND location IN ('Kyrgyzstan', 'Tajikistan', 'Kazakhstan', 'Uzbekistan')
ORDER BY total_cases DESC;

-- 
SELECT 
	location, population,
	SUM(new_cases) AS "total_cases",
	ROUND((SUM(new_cases) / population) * 100, 2) AS "infection_percentage",
	SUM(new_deaths) AS "total_deaths",
	ROUND((SUM(new_deaths) / population) * 100, 2) AS "death_percentage",
	CASE
		WHEN COALESCE(SUM(new_cases),0)=0 THEN ROUND((SUM(new_deaths) / (COALESCE(SUM(new_cases),0)+1) ) * 100, 2)
		ELSE ROUND((SUM(new_deaths) / COALESCE(SUM(new_cases),0)) * 100, 2)
	END AS "death_cases_percentage",
	SUM(new_vaccinations) AS "total_vaccinations",
	ROUND((SUM(new_vaccinations) / population) * 100, 2) AS "vaccination_percentage",
	life_expectancy,
	human_development_index
FROM covid
GROUP BY location, continent, population, life_expectancy, human_development_index
HAVING continent IS NULL AND location IN ('Asia', 'Africa', 'Europe', 'South America', 'North America', 'Oceania', 'World')
ORDER BY total_cases DESC;
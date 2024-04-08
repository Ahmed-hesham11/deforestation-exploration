--  a. Which 5 countries saw the largest amount decrease in forest area from 1990 to 2016? What was the difference in forest area for each?
SELECT 
  top(5)  f1.country_name,
    f1.region,
    ROUND(f1.forest_area_sqkm, 2) - ROUND(f2.forest_area_sqkm, 2) AS difference
FROM 
    (
        SELECT 
            country_name,
            region,
            forest_area_sqkm
        FROM 
            forestation
        WHERE 
            year = 1990
            
            AND country_name != 'World'
    ) AS f1
JOIN 
    (
        SELECT 
            country_name,
            region,
            forest_area_sqkm
        FROM 
            forestation
        WHERE 
            year = 2016
           
            AND country_name != 'World'
    ) AS f2 ON f1.country_name = f2.country_name
ORDER BY 
    difference DESC


-- b. Which 5 countries saw the largest percent decrease in forest area from 1990 to 2016? What was the percent change to 2 decimal places for each?
SELECT 
  top(5)  f1.country_name,
           f1. region,
    
   ROUND(((f1.forest_area_sqkm - f2.forest_area_sqkm) / f1.forest_area_sqkm) * 100, 2) AS percent_change
FROM 
    (
        SELECT 
            country_name,
            region,
            forest_area_sqkm
        FROM 
            forestation
        WHERE 
            year = 1990
            
            AND country_name != 'World'
    ) AS f1
JOIN 
    (
        SELECT 
            country_name,
            region,
            forest_area_sqkm
        FROM 
            forestation
        WHERE 
            year = 2016
           
            AND country_name != 'World'
    ) AS f2 ON f1.country_name = f2.country_name
ORDER BY 
    percent_change DESC

-- c. If countries were grouped by percent forestation in quartiles, which group had the most countries in it in 2016?

	SELECT 
    DISTINCT quartile,
    COUNT(country_name) OVER (PARTITION BY quartile) AS num_countries
FROM (
    SELECT 
        country_name,
        CASE
            WHEN forest_percentage < 25 THEN '1'
            WHEN forest_percentage < 50 THEN '2'
            WHEN forest_percentage < 75 THEN '3'
            ELSE '4'
        END AS quartile
    FROM 
        forestation
    WHERE 
        year = 2016
        AND region != 'World'
        AND forest_percentage IS NOT NULL
) AS sub
ORDER BY 
    quartile;

--d. List all of the countries that were in the 4th quartile (percent forest > 75%) in 2016
SELECT country_name, region, forest_percentage
from forestation
WHERE year = 2016
  and forest_percentage > 75
  order by forest_percentage desc

  -- e. How many countries had a percent forestation higher than the United States in 2016?
SELECT count(*)
from forestation f1
WHERE year = 2016
and  f1 .forest_percentage > (select forest_percentage 
from forestation 
where country_name = 'United States' and year=2016)
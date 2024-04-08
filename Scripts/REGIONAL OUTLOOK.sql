--REGIONAL OUTLOOK
--a.What was the percent forest of the entire world in 2016?
SELECT 
    ROUND(forest_percentage, 2) 
FROM 
    forestation
WHERE 
    year = 2016 
    AND region = 'world';

--2 a.Which region had the HIGHEST percent forest in 2016
SELECT TOP(1) 
	region ,ROUND(forest_percentage, 2)
FROM 
	forestation
WHERE 
	year = 2016
ORDER BY 
	forest_percentage DESC;

--3.a .Which region had the lowest percent forest in 2016
SELECT	
	TOP(1) region ,ROUND(forest_percentage, 2)
FROM 
	forestation
WHERE
	year = 2016
ORDER BY
	forest_percentage 
-- b. What was the percent forest of the entire world in 1990?

	SELECT 
    ROUND(forest_percentage, 2) 
FROM 
    forestation
WHERE 
    year = 1990 
    AND region = 'world';

-- 2 b. Which region had the HIGHEST percent forest in 1990
SELECT TOP(1) 
	region ,ROUND(forest_percentage, 2)
FROM 
	forestation
WHERE 
	year = 1990
ORDER BY 
	forest_percentage DESC;

	-- 3 b. Which region had the lowest percent forest in 1990, to 2 decimal places?
	SELECT	
	TOP(1) region ,ROUND(forest_percentage, 2)
FROM 
	forestation
WHERE
	year =1990
ORDER BY
	forest_percentage 


	-- c. Based on the table you created, which regions of the world DECREASED in forest area from 1990 to 2016?
SELECT 
    f1.region
FROM 
    forestation AS f1
WHERE 
    (
        (SELECT 
            forest_area_sqkm 
        FROM 
            forestation AS f2
        WHERE 
            f2.year = 2016 AND 
            f2.region = f1.region
        ) 
         >
        (SELECT 
            forest_area_sqkm 
        FROM 
            forestation AS f3
        WHERE 
            f3.year = 1990 AND 
            f3.region = f1.region
        )
    );
	

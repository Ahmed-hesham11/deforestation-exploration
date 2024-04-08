--Global Situation
--a. What was the total forest area (in sq km) of the world in 1990? 
select forest_area_sqkm
from forestation
where year= 1990 and region= 'world'


--b. What was the total forest area (in sq km) of the world in 2016? 
select forest_area_sqkm
from forestation
where year= 2016 and region= 'world'


--c. What was the change (in sq km) in the forest area of the world from 1990 to 2016?
select 
(select forest_area_sqkm from forestation where year= 1990 and region= 'world')
-
(select forest_area_sqkm from forestation where year= 2016 and region= 'world' )
as 'change in forest area '


--d. What was the percent change in forest area of the world between 1990 and 2016?
SELECT 
    (
        (
            (SELECT forest_area_sqkm FROM forestation WHERE year = 1990 AND region = 'World') -
            (SELECT forest_area_sqkm FROM forestation WHERE year = 2016 AND region = 'World')
        ) /
        (SELECT forest_area_sqkm FROM forestation WHERE year = 2016 AND region = 'World')
    ) * 100 
AS 'change in forest area in percent';



-- e. If you compare the amount of forest area lost between 1990 and 2016, to which country's total area in 2016 is it closest to?
SELECT 
    fview.country_name, 
    fview.total_area_sq_mi
FROM 
    forestation fview
WHERE 
    fview.total_area_sq_mi <= (
        (SELECT 
            (f2016.forest_area_sqkm - f1990.forest_area_sqkm) / 2.59 AS total_area_sq_mi
        FROM 
            forestation f2016
        JOIN 
            forestation f1990 ON f2016.region = f1990.region
        WHERE 
            f2016.year = 2016 AND f1990.year = 1990 AND f2016.region = 'World' AND f1990.region = 'World'
    ))
ORDER BY 
    fview.total_area_sq_mi DESC;
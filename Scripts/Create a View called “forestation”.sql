create view forestation
as
SELECT f.country_code,
       f.country_name,
       f.year,
       f.forest_area_sqkm,
	   l.total_area_sq_mi,
	   (f.forest_area_sqkm / (l.total_area_sq_mi * 2.59)) * 100 AS  percent_forest_area,
	   r.region ,
	   r.income_group

	   from forest_area f 
	   join land_area l 
	   on f.country_code=l.country_code and f.year=l.year
	   join regions_table r 
	  on r.country_code=f.country_code



INSERT INTO silver.erp_px_cat_g1v2 (
	id,
	cat,
	subcat,
	maintenance
)
SELECT 
	id,
	cat,
	subcat,
	maintenance
FROM bronze.erp_px_cat_g1v2;



-------- quality check for bronze layer ---

/*
select * from bronze.erp_px_cat_g1v2
where TRIM(maintenance) != maintenance;

select distinct(subcat) from bronze.erp_px_cat_g1v2;

select subcat , count(*) as cnt from bronze.erp_px_cat_g1v2 group by subcat having count(*) = 1;

select * from silver.erp_px_cat_g1v2;

*/
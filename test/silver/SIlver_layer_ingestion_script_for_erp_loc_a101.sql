INSERT INTO silver.erp_loc_a101(
	cid,
	cntry
)
select 
	REPLACE(cid,'-','') as cid,
	CASE 
		WHEN UPPER(TRIM(cntry)) in ('DE','GERMANY') THEN 'Germany'
		WHEN UPPER(TRIM(cntry)) in ('US','USA') THEN 'United States'
		WHEN cntry is null or cntry = '' THEN 'NA'
		else cntry
	End AS cntry
from bronze.erp_loc_a101 ;


-- where REPLACE(cid,'-','') not in (select cst_key from silver.crm_cust_info);

----- quality checks for bronze layer---------

/*
select 
	REPLACE(cid,'-','') as cid,
	cntry
from  bronze.erp_loc_a101 ;

select distinct(cntry),
CASE 
		WHEN UPPER(TRIM(cntry)) in ('DE','GERMANY') THEN 'Germany'
		WHEN UPPER(TRIM(cntry)) in ('US','USA') THEN 'United States'
		WHEN cntry is null or cntry = '' THEN 'NA'
		else cntry
	End AS cntry
from  bronze.erp_loc_a101 ;

*/
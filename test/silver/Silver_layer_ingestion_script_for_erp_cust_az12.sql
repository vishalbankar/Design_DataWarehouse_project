INSERT INTO silver.erp_cust_az12 (
	cid,
	bdate,
	gen
)
Select 
	CASE 
		WHEN cid like 'NAS%' THEN SUBSTRING(cid,4,len(cid))
		ELSE cid
	END cid,
	CASE 
		WHEN bdate > GETDATE() THEN NULL
		ELSE bdate
	End AS bdate,
	CASE 
		WHEN UPPER(TRIM(gen)) in ('M','MALE') Then 'Male'
		WHEN UPPER(TRIM(gen)) in ('F','FEMALE') Then 'Female'
		ELSE 'NA'
	END AS gen
from bronze.erp_cust_az12;


-- where cid not in (select distinct(cst_key) from silver.crm_cust_info);


/*
select 
   CASE 
		WHEN bdate > GETDATE() THEN NULL
		ELSE bdate
	End bdate
from bronze.erp_cust_az12
where bdate>getdate();


select Distinct gen,
CASE 
		WHEN UPPER(TRIM(gen)) in ('M','MALE') Then 'Male'
		WHEN UPPER(TRIM(gen)) in ('F','FEMALE') Then 'Female'
		ELSE 'NA'
	END AS gen
from bronze.erp_cust_az12

*/

---------- qulity check for silver layer table--------------

/*
select 
   CASE 
		WHEN bdate > GETDATE() THEN NULL
		ELSE bdate
	End bdate
from silver.erp_cust_az12
where bdate>getdate() ;

select Distinct gen
from silver.erp_cust_az12

select * from silver.erp_cust_az12;
*/
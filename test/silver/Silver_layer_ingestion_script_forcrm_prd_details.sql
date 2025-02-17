/*
==================================================================================================

   This script help to insert cleaned and tranformed data from bronze layer to silver layer 
   silver.crm_prd_details

==================================================================================================
*/


INSERT INTO silver.crm_prd_details (
	prd_id,
	cat_id,
	prd_key,
	prd_nm,
	prd_cost,
	prd_line,
	prd_start_dt,
	prd_end_dt
)
Select 
	prd_id,
	REPLACE(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,  -- EXtract Category id
	SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,       -- Extract product key
	prd_nm,
	COALESCE(prd_cost,0) as prd_cost,                   -- hadling missing value
	CASE UPPER(TRIM(prd_line))
		WHEN 'R' THEN 'Road'
		WHEN 'S' THEN 'Other Sales'
		WHEN 'M' THEN 'Mountain'
		WHEN 'T' THEN 'Touring'
		ELSE 'NA'
	END AS prd_line,                  -- Map product line code to descriptive values
	CAST(prd_start_dt AS DATE) AS prd_start_dt,
	CAST(
		LEAD(prd_start_dt) over(partition by prd_key order by prd_start_dt ASC)-1 AS DATE
		) as prd_end_dt               -- Calcualted end date as one day before start date
from bronze.crm_prd_details;


-----------------------------------------------------------------------------------------------

-- where (SUBSTRING(prd_key,7,LEN(prd_key)) in (select distinct sls_prd_key from bronze.crm_sales_details));

-- select * from bronze.crm_sales_details where sls_prd_key LIKE 'BK%';

-- where (REPLACE(SUBSTRING(prd_key,1,5),'-','_') not in (select distinct id from bronze.erp_px_cat_g1v2));


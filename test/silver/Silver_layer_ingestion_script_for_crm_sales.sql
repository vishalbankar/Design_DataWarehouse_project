
/*
==================================================================================================

   This script help to insert cleaned and tranformed data from bronze layer to silver layer 
   silver.crm_sales_details

==================================================================================================
*/


INSERT INTO silver.crm_sales_details(
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_quantity,
	sls_sales,
	sls_price
)
select 
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	-- NULLIF(sls_order_dt,0) AS sls_order_dt, -- if both values are Same then cahnge value to NULL
	CASE 
		WHEN sls_order_dt <=0 OR LEN(sls_order_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_order_dt AS VARCHAR)  AS DATE)
	END sls_order_dt,
	CASE 
		WHEN sls_ship_dt <=0 OR LEN(sls_ship_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_ship_dt AS VARCHAR)  AS DATE)
	END sls_ship_dt,
	CASE 
		WHEN sls_due_dt <=0 OR LEN(sls_due_dt) != 8 THEN NULL
		ELSE CAST(CAST(sls_due_dt AS VARCHAR)  AS DATE)
	END sls_due_dt,
	--sls_sales,
	sls_quantity,
	
	CASE 
		when sls_sales IS NULL OR sls_sales <=0 OR sls_sales != sls_quantity * abs(sls_price)
		     THEN sls_quantity * abs(sls_price)
		ELSE sls_sales
	END AS sls_sales,
	
	CASE 
		when sls_price IS NULL OR sls_price <=0 
		     THEN sls_sales / NULLIF(sls_quantity,0)
		ELSE sls_price
	END AS sls_price
	
from bronze.crm_sales_details;



-- where sls_prd_key not in (select prd_key from silver.crm_prd_details) 
-- where sls_cust_id not in (select cst_id from silver.crm_cust_info) 

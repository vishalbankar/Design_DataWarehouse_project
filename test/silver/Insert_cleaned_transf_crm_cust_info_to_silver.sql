/*
==================================================================================================

   This script help to insert cleaned and tranformed data from bronze layer to silver layer 
   silver.crm_cust_info

==================================================================================================
*/

With dedup_duplicate_customers AS(
	select *,
		row_number() over(partition by cst_id order by cst_create_date DESC) as rnk
	from bronze.crm_cust_info
	where cst_id is NOT NULL
)
INSERT INTO silver.crm_cust_info(
	cst_id,
	cst_key,
	cst_firstname,
	cst_lastname,
	cst_marital_status,
	cst_gndr,
	cst_create_date
)
select 
	cst_id,
	cst_key,
	TRIM(cst_firstname) as cst_firstname ,
	TRIM(cst_lastname) as cst_lastname ,
	CASE 
		WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
		WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		ELSE 'NA'
	END cst_marital_status,  -- Data Standardisation as per the business requrirements 
	CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		ELSE 'NA'
	END cst_gndr, -- Normalise gender values to readable format
	cst_create_date
from dedup_duplicate_customers
where rnk=1 ;
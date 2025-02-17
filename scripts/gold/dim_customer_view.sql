
CREATE VIEW gold.dim_customers AS
SELECT 
	ROW_NUMBER() OVER(order by ci.cst_id) as customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number, 
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	cl.cntry AS country,
	ci.cst_marital_status AS maritial_status,
	ca.bdate AS birth_date,
	CASE 
		WHEN ci.cst_gndr !='NA'  THEN  ci.cst_gndr
		--WHEN ci.cst_gndr = 'NA' THEN  ca.gen
		ELSE coalesce(ca.gen,'NA')
	END AS gender,
	ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
	LEFT JOIN silver.erp_cust_az12 ca
		on ci.cst_key = ca.cid
	LEFT JOIN silver.erp_loc_a101 cl
		on ci.cst_key = cl.cid ;


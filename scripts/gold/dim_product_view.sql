
CREATE VIEW gold.dim_products AS
SELECT 
	ROW_NUMBER() OVER( ORDER BY pd.prd_start_dt , pd.prd_key) AS product_key,
	pd.prd_id AS product_id,
	pd.prd_key AS product_number,
	pd.prd_nm AS product_name,
	pd.cat_id AS category_id,
	psd.cat AS category,
	psd.subcat AS sub_category,
	psd.maintenance,
	pd.prd_cost AS product_cost,
	pd.prd_line AS product_line,
	pd.prd_start_dt AS start_date
	
 from silver.crm_prd_details AS pd
	LEFT JOIN silver.erp_px_cat_g1v2 AS psd
	ON pd.cat_id = psd.id
	where prd_end_dt is null ; --- making sure we get the current info filter out all historical data



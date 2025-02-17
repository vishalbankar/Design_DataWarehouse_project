
CREATE VIEW gold.fact_sales AS
SELECT	
	ssd.sls_ord_num AS order_number,
	gp.product_key,
	gc.customer_key,
	ssd.sls_order_dt AS order_date,
	ssd.sls_ship_dt AS ship_date,
	ssd.sls_due_dt AS due_date,
	ssd.sls_sales AS sales_amount,
	ssd.sls_quantity AS quantity,
	ssd.sls_price AS price
FROM silver.crm_sales_details AS ssd
left join gold.dim_products as gp
	on ssd.sls_prd_key = gp.product_number
left join gold.dim_customers as gc
	on ssd.sls_cust_id = gc.customer_id ;




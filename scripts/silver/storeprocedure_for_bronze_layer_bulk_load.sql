


CREATE OR ALTER PROCEDURE bronze.load_bronze as
BEGIN
	DECLARE @start_time DATETIME , @end_time DATETIME ,@batch_start_time DATETIME ,@batch_end_time DATETIME;
	BEGIN TRY

		SET @batch_start_time = GETDATE();

		Print '=================================';
		Print 'Loading Bronze layer';
		Print '=================================';

		Print '=================================';
		Print 'Loading tables from CRM';
		Print '=================================';

		SET @start_time= GETDATE();
		print ' >> TRUNCATE TABLE bronze.crm_cust_info ';
		TRUNCATE TABLE bronze.crm_cust_info;
		print ' >> INSERT data in bronze.crm_cust_info ';
		BULK INSERT bronze.crm_cust_info
		From 'D:\Azure\SQL_server_project\datasets\source_crm\cust_info.csv'
		 WITH(
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		 );
		 SET @end_time= GETDATE();
		 print '>> load time: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';

		SET @start_time= GETDATE();
		print ' >> TRUNCATE TABLE bronze.crm_prd_details ';
		TRUNCATE TABLE bronze.crm_prd_details;
		print ' >> INSERT data in bronze.crm_prd_details ';
		BULK INSERT bronze.crm_prd_details
		From 'D:\Azure\SQL_server_project\datasets\source_crm\prd_info.csv'
		 WITH(
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time= GETDATE();
		print '>> load time: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		print '>>--------------------------';

		SET @start_time= GETDATE();
		print ' >> TRUNCATE TABLE bronze.crm_sales_details ';
		TRUNCATE TABLE bronze.crm_sales_details;
		print ' >> INSERT data in bronze.crm_sales_details ';
		BULK INSERT bronze.crm_sales_details
		From 'D:\Azure\SQL_server_project\datasets\source_crm\sales_details.csv'
		 WITH(
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time= GETDATE();
		print '>> load time: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		print '>>--------------------------';

		Print '=================================';
		Print 'Loading tables from ERP';
		Print '=================================';

		SET @start_time= GETDATE();
		print ' >> TRUNCATE TABLE bronze.erp_cust_az12 ';
		TRUNCATE TABLE bronze.erp_cust_az12;
		print ' >> INSERT data in bronze.erp_cust_az12 ';
		BULK INSERT bronze.erp_cust_az12
		From 'D:\Azure\SQL_server_project\datasets\source_erp\CUST_AZ12.csv'
		 WITH(
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time= GETDATE();
		print '>> load time: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		print '>>--------------------------';

		print ' >> TRUNCATE TABLE bronze.erp_loc_a101 ';
		TRUNCATE TABLE bronze.erp_loc_a101;
		print ' >> INSERT data in bronze.erp_loc_a101 ';
		BULK INSERT bronze.erp_loc_a101
		From 'D:\Azure\SQL_server_project\datasets\source_erp\LOC_A101.csv'
		 WITH(
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time= GETDATE();
		print '>> load time: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		print '>>--------------------------';

		SET @start_time= GETDATE();
		print ' >> TRUNCATE TABLE bronze.erp_px_cat_g1v2 ';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		print ' >> INSERT data in bronze.erp_px_cat_g1v2 ';
		BULK INSERT bronze.erp_px_cat_g1v2
		From 'D:\Azure\SQL_server_project\datasets\source_erp\PX_CAT_G1V2.csv'
		 WITH(
			FIRSTROW=2,
			FIELDTERMINATOR = ',',
			TABLOCK  
		);
		SET @end_time= GETDATE();
		print '>> load time: ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + ' seconds';
		print '>>--------------------------';

		SET @batch_end_time = GETDATE();
		Print '=================================';
		Print ' Loading Bronze layer is completed';
		Print ' Total Load Duration : ' + CAST(DATEDIFF(second,@batch_start_time , @batch_end_time) AS NVARCHAR) + ' seconds';

		Print '=================================';

	END TRY

	BEGIN CATCH
		PRINT '----------------------------------------------------------';
		PRINT ' ERROR OCCURED DURING LOADING BRONZE LAYER ';
		PRINT ' ERROR Message ' + ERROR_MESSAGE();
		PRINT ' ERROR Message ' + CAST(ERROR_NUMBER() as NVARCHAR);
		PRINT ' ERROR Message ' + CAST(ERROR_STATE() as NVARCHAR);
		PRINT '----------------------------------------------------------';
	END CATCH
END;


-- EXEC bronze.load_bronze;
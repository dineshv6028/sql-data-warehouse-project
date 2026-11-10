/*
Description:
    This stored procedure loads CRM and ERP CSV files into the SALES_DW bronze staging tables using BULK INSERT.

NOTE: 
    BULK INSERT file paths are hard-coded. Update them for your environment before running; SQL Server must be able to access the files.

WARNING:
    This stored procedure truncates each target table before loading it. Existing table data will be removed.
*/

CREATE OR ALTER PROCEDURE bronze.usp_load_bronze_tables
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @start_time DATETIME;
    DECLARE @end_time DATETIME;
    DECLARE @batch_start_time DATETIME;
    DECLARE @batch_end_time DATETIME;
    DECLARE @row_count INT;

    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '==================================================';
        PRINT 'Starting bronze table load...';
        PRINT '==================================================';

        SET @start_time = GETDATE();
        PRINT N'Truncating and loading bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        FROM 'C:\Projects\SQL\Sales DW\datasets\source_crm\cust_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        
        SET @row_count = @@ROWCOUNT;
        SET @end_time = GETDATE();
        
        PRINT 'Finished loading bronze.crm_cust_info';
        PRINT 'ROW COUNT: ' + CAST(@row_count AS NVARCHAR);
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '--------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT N'Truncating and loading bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        BULK INSERT bronze.crm_prd_info
        FROM 'C:\Projects\SQL\Sales DW\datasets\source_crm\prd_info.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @row_count = @@ROWCOUNT;
        SET @end_time = GETDATE();

        PRINT 'Finished loading bronze.crm_prd_info';
        PRINT 'ROW COUNT: ' + CAST(@row_count AS NVARCHAR);
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '--------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT N'Truncating and loading bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        FROM 'C:\Projects\SQL\Sales DW\datasets\source_crm\sales_details.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @row_count = @@ROWCOUNT;
        SET @end_time = GETDATE();

        PRINT 'Finished loading bronze.crm_sales_details';
        PRINT 'ROW COUNT: ' + CAST(@row_count AS NVARCHAR);
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '--------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT N'Truncating and loading bronze.erp_cust_az12';
        TRUNCATE TABLE bronze.erp_cust_az12;

        BULK INSERT bronze.erp_cust_az12
        FROM 'C:\Projects\SQL\Sales DW\datasets\source_erp\CUST_AZ12.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @row_count = @@ROWCOUNT;
        SET @end_time = GETDATE();

        PRINT 'Finished loading bronze.erp_cust_az12';
        PRINT 'ROW COUNT: ' + CAST(@row_count AS NVARCHAR);
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '--------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT N'Truncating and loading bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        BULK INSERT bronze.erp_loc_a101
        FROM 'C:\Projects\SQL\Sales DW\datasets\source_erp\LOC_A101.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @row_count = @@ROWCOUNT;
        SET @end_time = GETDATE();

        PRINT 'Finished loading bronze.erp_loc_a101';
        PRINT 'ROW COUNT: ' + CAST(@row_count AS NVARCHAR);
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '--------------------------------------------------';

        SET @start_time = GETDATE();
        PRINT N'Truncating and loading bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'C:\Projects\SQL\Sales DW\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH
        (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @row_count = @@ROWCOUNT;
        SET @end_time = GETDATE();

        PRINT 'Finished loading bronze.erp_px_cat_g1v2';
        PRINT 'ROW COUNT: ' + CAST(@row_count AS NVARCHAR);
        PRINT 'Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' Seconds';
        PRINT '--------------------------------------------------';

        SET @batch_end_time = GETDATE();
        PRINT '==================================================';
        PRINT N'Bronze table load completed successfully';
         PRINT 'Total Bronze Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' Seconds';
        PRINT '==================================================';
    END TRY
    BEGIN CATCH
        PRINT '==================================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '==================================================';
        THROW;
    END CATCH;
END;

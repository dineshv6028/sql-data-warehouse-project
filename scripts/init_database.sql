/*
Description:
    Recreates the SALES_DW database and creates the bronze, silver,
    and gold schemas.

WARNING:
    If SALES_DW already exists, it will be
    set to SINGLE_USER, active connections will be rolled back, and the
    database will be dropped. All data and objects in SALES_DW will be
    permanently deleted before the database is recreated.
*/


USE master;

--Drop and Recreate the 'Sales_DW' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'SALES_DW')
BEGIN
	ALTER DATABASE SALES_DW SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE SALES_DW;
END
GO
--Create the 'SALES_DW' database
CREATE DATABASE SALES_DW;
GO

USE SALES_DW;
GO

--Create 'bronze' schema
CREATE SCHEMA bronze;
GO

--Create 'silver' schema
CREATE SCHEMA silver;
GO

--Create 'gold' schema
CREATE SCHEMA gold;
GO

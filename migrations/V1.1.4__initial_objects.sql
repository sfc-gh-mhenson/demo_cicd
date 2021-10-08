-- ***************************************************************************************
--  Name:         V1.1.4__initial_objects.sql  
--  Author:       Michael Henson - Snowflake  
--  Created Date: 08-Oct-2021
--  Description:  Initial create of customer table, csv_header_ff file format and bi_wh warehouse
-- ***************************************************************************************

--
-- Create a clone (backup)
--
CREATE DATABASE clone_211008_demo_db CLONE demo_db;

USE DATABASE demo_db; 
USE SCHEMA DEMO;

CREATE TABLE customers (
	personid VARCHAR
	,firstname VARCHAR
	,lastname VARCHAR
	,dob VARCHAR
	,ssn VARCHAR
	,gender VARCHAR
	,email VARCHAR
	,ip_address VARCHAR
	,icd9dx VARCHAR
	,icd10dx VARCHAR
	,streetno VARCHAR
	,streetname VARCHAR
	,city VARCHAR
	,state VARCHAR
	,zip VARCHAR
	,phone VARCHAR
	);

CREATE OR REPLACE FILE FORMAT csv_header_ff
    TYPE = CSV
    SKIP_HEADER = 1
    FIELD_OPTIONALLY_ENCLOSED_BY = '"'
    ;

COPY INTO demo.customers
    FROM @~/test_data.csv.gz
    FILE_FORMAT = csv_header_ff
    ON_ERROR = CONTINUE
    ;

CREATE WAREHOUSE bi_wh
    WAREHOUSE_SIZE = 'XSMALL' 
    AUTO_SUSPEND = 60 
    AUTO_RESUME = TRUE 
    MIN_CLUSTER_COUNT = 1 
    MAX_CLUSTER_COUNT = 1 
    COMMENT = 'BI Warehouse';
-- 1️⃣ In Athena, create curated database
CREATE DATABASE IF NOT EXISTS library_curated;

USE library_curated;

-- 2️⃣ Create dim_date using CTAS (Create Table As Select)
CREATE TABLE library_curated.dim_date
WITH (
    format = 'PARQUET',
    external_location = 's3://library-data-lake-sayali/curated/dim_date/'
) AS
SELECT DISTINCT
    CAST(issue_date AS DATE)       AS date_id,
    year(CAST(issue_date AS DATE))  AS year,
    month(CAST(issue_date AS DATE)) AS month,
    day(CAST(issue_date AS DATE))   AS day,
    date_format(CAST(issue_date AS DATE), '%W') AS day_name,
    date_format(CAST(issue_date AS DATE), '%M') AS month_name
FROM library_raw.transactions;

-- 3️⃣ Validate
SELECT * 
FROM library_curated.dim_date
ORDER BY date_id;
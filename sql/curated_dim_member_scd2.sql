-- 1️⃣ Create curated SCD2 table
-- Run in Athena:

CREATE TABLE library_curated.dim_member
WITH (
    format = 'PARQUET',
    external_location = 's3://library-data-lake-sayali/curated/dim_member/'
) AS
SELECT
    member_id,
    member_name,
    membership_type,
    city,
    CAST(
        date_parse(created_at, '%Y-%m-%d %H:%i:%s.%f')
        AS DATE
    ) AS start_date,
    DATE '9999-12-31' AS end_date,
    true AS is_active
FROM library_raw.members;



-- 2️⃣ Validate
SELECT *
FROM library_curated.dim_member;
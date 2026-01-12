-- 1️⃣ Create with STRING for timestamps
CREATE EXTERNAL TABLE IF NOT EXISTS library_raw.members (
    member_id INT,
    member_name STRING,
    membership_type STRING,
    city STRING,
    created_at STRING,
    updated_at STRING
)
PARTITIONED BY (
    extraction_date STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
WITH SERDEPROPERTIES (
    "separatorChar" = ",",
    "quoteChar" = "\",
    "escapeChar" = "\\"
)
STORED AS TEXTFILE
LOCATION 's3://library-data-lake-sayali/raw/members/';

-- 2️⃣ Skip header
ALTER TABLE library_raw.members 
SET TBLPROPERTIES ('skip.header.line.count'='1');

-- 3️⃣ Load partitions
MSCK REPAIR TABLE library_raw.members;

-- 4️⃣ Validate
SELECT *
FROM library_raw.members
ORDER BY updated_at DESC
LIMIT 10;


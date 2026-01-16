--  Run in Athena

CREATE EXTERNAL TABLE library_curated.rejected_fact_book_issues (
    issue_id INT,
    book_id INT,
    member_id INT,
    date_id DATE,
    issue_count INT,
    late_days INT,
    fine_amount DOUBLE,
    rejection_reason STRING,
    load_date DATE
)
STORED AS PARQUET
LOCATION 's3://library-data-lake-sayali/curated/rejected_fact_book_issues/';

-- Validate
SELECT COUNT(*) AS total_rows FROM library_curated.fact_book_issues;
SELECT COUNT(*) AS rejected_rows FROM library_curated.rejected_fact_book_issues;

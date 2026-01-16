-- 1️⃣ Create fact_book_issues using CTAS
-- Run in Athena:

CREATE TABLE library_curated.fact_book_issues
WITH (
    format = 'PARQUET',
    external_location = 's3://library-data-lake-sayali/curated/fact_book_issues/'
) AS
SELECT
    t.transaction_id                        AS issue_id,
    b.book_id                               AS book_id,
    m.member_id                             AS member_id,
    CAST(date_parse(t.issue_date, '%Y-%m-%d') AS DATE) AS date_id,
    1                                       AS issue_count,
    CASE 
        WHEN t.return_date IS NOT NULL THEN
            date_diff(
                'day',
                CAST(date_parse(t.issue_date, '%Y-%m-%d') AS DATE),
                CAST(date_parse(t.return_date, '%Y-%m-%d') AS DATE)
            )
        ELSE 0
    END                                     AS late_days,
    t.fine_amount                           AS fine_amount
FROM library_raw.transactions t
JOIN library_curated.dim_book b
    ON t.book_id = b.book_id
JOIN library_curated.dim_member m
    ON t.member_id = m.member_id;

-- 2️⃣ Validate
SELECT *
FROM library_curated.fact_book_issues;

-- DIMENSION TABLES

-- Date dimension (time analysis)
CREATE TABLE dim_date (
    date_id DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    day_name STRING,
    month_name STRING
);

-- Member dimension (SCD Type 2)
CREATE TABLE dim_member (
    member_key BIGINT IDENTITY,
    member_id INT,
    member_name STRING,
    membership_type STRING,
    city STRING,
    start_date DATE,
    end_date DATE,
    is_active BOOLEAN
);

-- Book dimension (denormalized)
CREATE TABLE dim_book (
    book_key BIGINT IDENTITY,
    book_id INT,
    title STRING,
    author_name STRING,
    category_name STRING
);

-- FACT TABLE

CREATE TABLE fact_book_issues (
    issue_id BIGINT IDENTITY,
    book_key BIGINT,
    member_key BIGINT,
    date_id DATE,
    issue_count INT,
    late_days INT,
    fine_amount DOUBLE
);

-- 📚 authors
CREATE EXTERNAL TABLE IF NOT EXISTS library_raw.authors (
    author_id INT,
    author_name STRING,
    created_at STRING,
    updated_at STRING
)
PARTITIONED BY (extraction_date STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
LOCATION 's3://library-data-lake-sayali/raw/authors/';

ALTER TABLE library_raw.authors 
SET TBLPROPERTIES ('skip.header.line.count'='1');

MSCK REPAIR TABLE library_raw.authors;

-- 🗂 categories
CREATE EXTERNAL TABLE IF NOT EXISTS library_raw.categories (
    category_id INT,
    category_name STRING,
    created_at STRING,
    updated_at STRING
)
PARTITIONED BY (extraction_date STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
LOCATION 's3://library-data-lake-sayali/raw/categories/';

ALTER TABLE library_raw.categories 
SET TBLPROPERTIES ('skip.header.line.count'='1');

MSCK REPAIR TABLE library_raw.categories;

-- 📖 books
CREATE EXTERNAL TABLE IF NOT EXISTS library_raw.books (
    book_id INT,
    title STRING,
    author_id INT,
    category_id INT,
    isbn STRING,
    created_at STRING,
    updated_at STRING
)
PARTITIONED BY (extraction_date STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
LOCATION 's3://library-data-lake-sayali/raw/books/';

ALTER TABLE library_raw.books 
SET TBLPROPERTIES ('skip.header.line.count'='1');

MSCK REPAIR TABLE library_raw.books;

-- 🔁 transactions (FACT SOURCE)
CREATE EXTERNAL TABLE IF NOT EXISTS library_raw.transactions (
    transaction_id INT,
    book_id INT,
    member_id INT,
    issue_date STRING,
    return_date STRING,
    fine_amount DOUBLE,
    created_at STRING,
    updated_at STRING
)
PARTITIONED BY (extraction_date STRING)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
LOCATION 's3://library-data-lake-sayali/raw/transactions/';

ALTER TABLE library_raw.transactions 
SET TBLPROPERTIES ('skip.header.line.count'='1');

MSCK REPAIR TABLE library_raw.transactions;

-- 🔍 Validate Each

SELECT COUNT(*) FROM library_raw.authors;
SELECT COUNT(*) FROM library_raw.categories;
SELECT COUNT(*) FROM library_raw.books;
SELECT COUNT(*) FROM library_raw.transactions;
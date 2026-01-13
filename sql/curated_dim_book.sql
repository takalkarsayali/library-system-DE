-- 1️⃣ Create dim_book using CTAS
-- Run this in Athena:

CREATE TABLE library_curated.dim_book
WITH (
    format = 'PARQUET',
    external_location = 's3://library-data-lake-sayali/curated/dim_book/'
) AS
SELECT
    b.book_id,
    b.title,
    a.author_name,
    c.category_name
FROM library_raw.books b
JOIN library_raw.authors a
    ON b.author_id = a.author_id
JOIN library_raw.categories c
    ON b.category_id = c.category_id;

-- 2️⃣ Validate
SELECT * 
FROM library_curated.dim_book;
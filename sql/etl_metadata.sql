-- Tracks last successful extraction time per table
CREATE TABLE IF NOT EXISTS etl_metadata (
    table_name TEXT PRIMARY KEY,
    last_extracted_at TIMESTAMP NOT NULL
);

-- Initialize watermarks
INSERT INTO etl_metadata (table_name, last_extracted_at)
VALUES
('authors', '1970-01-01'),
('categories', '1970-01-01'),
('books', '1970-01-01'),
('members', '1970-01-01'),
('transactions', '1970-01-01')
ON CONFLICT (table_name) DO NOTHING;

UPDATE members
SET city = 'Bangalore',
    updated_at = CURRENT_TIMESTAMP
WHERE member_id = 1;

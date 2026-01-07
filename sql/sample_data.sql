INSERT INTO authors (author_name) VALUES
('J K Rowling'), ('George Orwell');

INSERT INTO categories (category_name) VALUES
('Fiction'), ('Science');

INSERT INTO books (title, author_id, category_id, isbn) VALUES
('Harry Potter', 1, 1, 'ISBN001'),
('1984', 2, 1, 'ISBN002');

INSERT INTO members (member_name, membership_type, city) VALUES
('Alice', 'Premium', 'Mumbai'),
('Bob', 'Standard', 'Pune');

INSERT INTO transactions (book_id, member_id, issue_date, return_date, fine_amount)
VALUES
(1, 1, '2025-01-01', '2025-01-10', 0),
(2, 2, '2025-01-05', NULL, 0);

SELECT * FROM members;
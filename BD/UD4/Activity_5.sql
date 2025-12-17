USE blogdb;

SET SQL_SAFE_UPDATES = 0;

-- 1
CREATE TABLE user_test_blog (
	user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100),
    role VARCHAR(20),
    phone VARCHAR(20),
    registration_date DATE
);

-- 2
INSERT INTO user_test_blog (name, email, role, phone, registration_date) 
VALUES
('Maria', 'maria@example.com', 'admin', '600111222', '2024-01-10'),
('Luis', 'luis@hotmail.com', 'guest', NULL, '2023-05-15'),
('Ana', 'ana@example.com', 'external', NULL, '2022-11-20'),
('Pedro', 'pedro@example.com', 'normal', '600333444', '2025-02-01'),
('Marta', 'marta@hotmail.com', 'pending', NULL, '2023-03-05'),
('Jorge', 'jorge@example.com', 'blocked', NULL, '2022-12-12'),
('Miguel', 'miguel@example.com', 'moderator', '600555666', '2024-06-01'),
('Lucia', 'lucia@example.com', 'external', '600777888', '2021-09-09'),
('Sergio', 'sergio@example.com', 'guest', NULL, '2020-10-10'),
('Manuel', 'manuel@example.com', 'normal', NULL, '2023-08-08'),
('Raul', 'raul@hotmail.com', 'external', NULL, '2020-01-01'),
('Laura', 'laura@example.com', 'verified', '600999000', '2024-03-03');

-- 3
DELETE FROM user_test_blog
WHERE user_id = 4;

-- 4
DELETE FROM user_test_blog
WHERE role = 'guest';

ALTER TABLE post
MODIFY post_id INT NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (post_id);

-- 5
DELETE FROM post
WHERE post_id > 2;

-- 6
INSERT INTO user_test_blog (name, email, role, phone, registration_date)
VALUES
('Carlos', 'carlos@example.com', 'admin', '600101010', '2024-02-10'), 
('Elena', 'elena@hotmail.com', 'guest', NULL, '2023-07-15'), 
('Rosa', 'rosa@example.com', 'external', NULL, '2022-05-20'), 
('David', 'david@example.com', 'normal', '600202020', '2025-01-02'), 
('Luciana', 'luciana@hotmail.com', 'pending', NULL, '2023-09-05'), 
('Samuel', 'samuel@example.com', 'blocked', NULL, '2022-12-20'), 
('Paula', 'paula@example.com', 'moderator', '600303030', '2024-06-21'), 
('Hector', 'hector@example.com', 'external', '600404040', '2021-11-11'), 
('Noelia', 'noelia@example.com', 'guest', NULL, '2020-02-12'), 
('German', 'german@example.com', 'normal', NULL, '2023-10-18'), 
('Roberto', 'roberto@hotmail.com', 'external', NULL, '2020-01-22'), 
('Sonia', 'sonia@example.com', 'verified', '600505050', '2024-04-04');

-- 7
DELETE FROM user_test_blog
WHERE role <> 'admin';

-- 8
DELETE FROM user_test_blog
WHERE role = 'external'
AND phone IS NULL;

-- 9
DELETE FROM user_test_blog
WHERE role = 'blocked'
OR role = 'pending';

-- 10
DELETE FROM comment
WHERE comment_text IS NULL;

-- 11
DELETE FROM user_test_blog
WHERE user_id IN (2, 5, 8, 20, 25, 36, 38, 41);

-- 12
DELETE FROM user_test_blog
WHERE role NOT IN ('admin', 'external',  'verified');

-- 13
DELETE FROM post
WHERE post_id BETWEEN 3 AND 6;

-- 14
DELETE FROM user_test_blog
WHERE email LIKE '%@hotmail.com';

-- 15
CREATE TABLE category (
	name VARCHAR(50),
    code VARCHAR(10)
);

INSERT INTO category(name, code)
VALUES
('Technology', 'A1'), 
('Cooking', 'A2'), 
('Travel', 'AB'), 
('Education', 'A_BX'), 
('Sports', 'X1'), 
('Science', 'A12'), 
('Art', 'B_'); 

-- 16
DELETE FROM category
WHERE code LIKE 'A_';

-- 17
DELETE FROM user_test_blog
WHERE name NOT LIKE '%M';

-- 18
TRUNCATE TABLE category;

-- 19
DROP TABLE category;

-- 20
DELETE FROM user_test_blog
WHERE role IN ('external', 'guest')
AND user_id > 5;

-- 21
DELETE FROM user_test_blog
WHERE role NOT IN ('admin', 'guest')
AND phone IS NULL;

-- 22
DELETE FROM post
WHERE title LIKE '%A'
AND post_id BETWEEN 3 AND 6;

-- 23
DELETE FROM user_test_blog
WHERE IF (role = 'admin', 0, user_id > 10);

-- 24
DELETE FROM comment
WHERE user_id = 1 OR user_id = 2 OR user_id = 3
AND comment_text LIKE '%Comment';

-- 25
DELETE FROM user_test_blog
WHERE role IN('external', 'guest')
AND registration_date < '2024-01-01';

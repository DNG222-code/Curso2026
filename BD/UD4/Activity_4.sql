USE blogdb;

SET SQL_SAFE_UPDATES = 0;

-- 1
UPDATE user
SET phone = 64736473
WHERE user_id = 2; 

-- 2
UPDATE user
SET role = 'external'
WHERE role <> 'admin';

-- 3
UPDATE post
SET title = 'CHANGED'
WHERE post_id > 1;

-- 4
UPDATE post
SET content = 'changed the content'
WHERE post_id < 3;

-- 5
UPDATE post
SET post_date = NOW()
WHERE post_id >= 2;

-- 6
UPDATE post
SET title = 'Archived'
WHERE post_id <= 4;

-- 7
UPDATE user
SET role = 'Verified'
WHERE role = 'external' 
AND register_date < '2025-01-01';

-- 8
UPDATE user
SET role = 'admin'
WHERE user_id = 1 
OR user_id = 3;

-- Añadir una clave primaria.
ALTER TABLE comment
ADD COLUMN comment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;

-- 9
UPDATE comment
SET comment_text = 'change the content'
WHERE comment_id > 1
AND user_id = 2;

-- 10
UPDATE user
SET role = 'pending'
WHERE role <> 'admin';

-- 11
UPDATE user
SET register_date = CURRENT_DATE()
WHERE phone IS NOT NULL;

-- 12
UPDATE user
SET phone = 999111222
WHERE phone IS NULL;

-- 13
UPDATE user
SET role = 'verified'
WHERE phone IS NOT NULL;

-- 14
UPDATE user
SET name = 'Unknown user'
WHERE name IS NULL;

-- 15
UPDATE post
SET post_date = NOW()
WHERE post_date IS NULL;

-- 16
UPDATE user
SET role = 'premium'
WHERE email IS NOT NULL
AND user_id > 2;

-- 17
UPDATE post
SET title = 'Change the title'
WHERE post_id < 3
OR post_id > 10;

-- 18
UPDATE comment
SET comment_text = 'change the content'
WHERE user_id = 1
OR user_id = 3
AND comment_id > 2;

-- 19
UPDATE user
SET email = 'change@email.com'
WHERE user_id = 4
AND phone IS NULL
AND register_date IS NULL;

-- 20
UPDATE user
SET role = 'archived'
WHERE user_id <= 3
AND phone IS NULL;

-- 21
UPDATE post
SET content = 'change content'
WHERE post_id >= 2 AND post_id <= 4;

-- 22
UPDATE user
SET phone = 000000000
WHERE role <> 'admin'
AND user_id <> 1;

-- 23
UPDATE user
SET email = LOWER(email);

-- 24
UPDATE user
SET role = UPPER(role)
WHERE user_id > 3;

-- 25
UPDATE user
SET phone = CONCAT('+34-', ' ')
WHERE phone IS NOT NULL;

-- 26
UPDATE post
SET simple_date = CURDATE()
WHERE post_id < 5;

-- 27
UPDATE user
SET name = TRIM(name);

-- 28
UPDATE post
SET content = REPLACE(content, '-', ' ');

-- 29
UPDATE user
SET name = LEFT(name, 5);

ALTER TABLE user
ADD COLUMN surname VARCHAR(50);

-- 30
UPDATE user
SET surname = RIGHT(surname, 4);

-- 31
UPDATE user
SET role = 'LONG'
WHERE LENGTH(role) > 6;

-- 32
UPDATE user
SET role = IF (role = 'admin', 'vip', 'normal');

-- 33
UPDATE user
SET register_date = IF(role = 'admin', NOW(), register_date);

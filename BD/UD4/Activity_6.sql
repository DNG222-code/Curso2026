USE blogdb;

-- 1
SELECT * FROM user;

-- 2
SELECT name, email, role FROM user;

-- 3
SELECT * FROM user
WHERE role = 'admin';

-- 4
SELECT * FROM user
WHERE phone IS NULL;

-- 5
SELECT * FROM post
WHERE LEFT(title, 1) = 'A';

-- 6
INSERT INTO comment (comment_text, comment_date, user_ID, post_ID)  
VALUES 
('Se ha producido un error al guardar los datos.', '2024-03-20', 1, 1), 
('ERROR grave en  el sistema de autenticación.', '2024-03-21', 2, 1), 
('No entiendo este ErRoR que aparece al  ejecutar la consulta.', '2024-03-22', 3, 2);

-- 6.b
SELECT * FROM comment
WHERE LOWER(comment_text) LIKE '%error';

-- 7
SELECT * FROM post
WHERE post_id IN(3 AND 7);

-- 8
SELECT * FROM user
WHERE RIGHT(email, 10) = '@gmail.com';

-- 9
SELECT * FROM user
WHERE role = ('admin' OR 'external' OR 'moderator');

-- 10
SELECT * FROM post
ORDER BY post_date DESC;

-- 11
SELECT * FROM user
ORDER BY register_date ASC
LIMIT 5;

-- 12
SELECT * FROM post
ORDER BY post_date DESC
LIMIT 3;

-- 13
SELECT role FROM user
ORDER BY role ASC;

SELECT name FROM user
ORDER BY name ASC;

-- 14
SELECT name AS 'UserName' FROM user;

SELECT register_date AS 'JoinDate' FROM user;

-- 15
SELECT * FROM user
WHERE name LIKE '%o';

-- 16
SELECT * FROM user
WHERE name LIKE '% ';

-- 17
SELECT * FROM user
ORDER BY register_date DESC
LIMIT 8;

-- 18
SELECT * FROM post
WHERE LENGTH(title) = 5;

-- 19
SELECT * FROM user
WHERE phone IS NOT NULL
ORDER BY phone DESC;

-- 20
SELECT name, email, role FROM user
WHERE (
	role <> 'admin'
    AND name LIKE '%a'
    AND phone IS NOT NULL OR RIGHT(email, 10) = '@gmail.com'
)
ORDER BY register_date DESC
LIMIT 6;

ALTER TABLE post
ADD COLUMN user_id int; 

-- 21
SELECT post_date, user_id FROM post
WHERE (
	title LIKE '%SQL' OR title LIKE '%Docker'
)
AND 
(
	(post_date BETWEEN '2024-01-01' AND '2024-12-31')
    OR post_date IS NULL
)
ORDER BY post_date DESC
LIMIT 10;

-- 22
SELECT comment_id, comment_text, user_id FROM comment
WHERE (
	LEFT(comment_text, 5) = 'Error'
    OR comment_text LIKE '%falló'
)
AND
(
	user_id IN (1, 2, 3, 4)
)
AND 
(
	comment_text IS NOT NULL
)
ORDER BY comment_id ASC;

-- 23
SELECT name, email, role FROM user
WHERE (
	role IN('extern' AND 'guest')
    OR phone IS NULL
)
OR
(
	role = 'verified' 
    AND RIGHT(email, 10) = '@gmail.com'
)
ORDER BY role ASC, name ASC
LIMIT 15;

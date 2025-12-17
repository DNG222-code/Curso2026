USE blogdb;

-- 1
INSERT INTO user (user_id, name, email, register_date)
VALUES ('1', 'user1', 'user1@gmail.com', NOW());

-- 2
INSERT INTO user (email)
VALUES ('user1@gmail.com');

-- 3
INSERT INTO user (user_id, name, email, register_date)
VALUES 
	(1, "user1", "user1@gmail.com", NOW()),
    (2, "user2", "user2@gmail.com", NOW()),
    (3, "user3", "user3@gmail.com", NOW()),
    (4, "user4", "user4@gmail.com", NOW()),
    (5, "user5", "user5@gmail.com", NOW());
    
SELECT * FROM user;

-- 4
INSERT INTO post (post_id, title, content, post_date)
VALUES 
	(1, "post1", "content long 1", NOW()),
    (2, "post2", "content long 2", NOW()),
	(3, "post3", "content long 3", NOW());

SELECT * FROM post;

-- 5
INSERT INTO post (post_id, title, content, post_date)
VALUES ("POST1", "post1", "content long 1", NULL);

SELECT * FROM post;


-- 6
ALTER TABLE post
ADD COLUMN simple_date DATE;

SELECT * FROM post;


-- 7
INSERT INTO post (post_id, simple_date)
VALUES ("POST1.1", CURDATE());

SELECT simple_date FROM post;


-- 8
INSERT INTO user (name, email, register_date)
VALUES (CONCAT("David", " ", "Nagy"), ("dnagy@iesjoanramis.org"), NOW());

SELECT * FROM user;

ALTER TABLE user
ADD COLUMN phone INT;

ALTER TABLE user
MODIFY COLUMN phone VARCHAR(50);

-- 9
INSERT INTO user (name, email, register_date, phone)
VALUES ("user6", "user6@gmail.com", NOW(), CONCAT("+34-", "63275632"));

SELECT phone FROM user;

-- 10
INSERT INTO post (post_id, title, content, post_date, simple_date)
VALUES (1, 'Nuevo titulo', 'Nuevo contenido', NOW(), NOW());

SELECT * FROM post;

CREATE TABLE comment (
	post_ID VARCHAR(10), 
	user_ID VARCHAR(10), 
	comment_text VARCHAR(100), 
	comment_date VARCHAR(100)
);


INSERT INTO comment (post_ID, user_ID, comment_text, comment_date)
VALUES (LAST_INSERT_ID(), 1, 'Este es un comentario sobre el nuevo post.', NOW());

SELECT * FROM comment;

-- 11
ALTER TABLE user
ADD COLUMN post_id VARCHAR(10);

INSERT INTO user (user_id, post_id)
VALUES (LAST_INSERT_ID(), 1);

SELECT * FROM user;

ALTER TABLE user
ADD COLUMN role VARCHAR(100);

-- 12
INSERT INTO user (user_id, name, email, role)
VALUES (18, 'Pablo Sanchez', LOWER('PABLO.S@MAIL.COM'), UPPER('guest'));

SELECT user_id, name, email, role FROM user;

-- 13
ALTER TABLE comment
MODIFY user_id VARCHAR(10),
MODIFY post_id VARCHAR(10);

-- 14
INSERT INTO comment (comment_text)
VALUES ('Cambio de comentario');

SELECT comment_text FROM comment;

-- 15
ALTER TABLE comment
MODIFY comment_date DATETIME DEFAULT NOW();

INSERT INTO comment (user_id, post_id, comment_text)
VALUES (1, 1, 'Ejercicio 15');

SELECT * FROM comment;

-- 16
INSERT INTO comment (post_id, user_id, comment_text)
VALUES
(1, 1, 'Primer comentario de prueba'),
(1, 2, 'Segundo comentario de prueba'),
(2, 1, 'Tercer comentario de prueba');

SELECT * FROM comment
ORDER BY post_id ASC;

-- 17
INSERT INTO comment (user_ID, comment_text, post_ID) VALUES (99, 'Comment test', 1);


-- 19
INSERT INTO comment (comment_text, user_ID, post_ID) 
VALUES ('Testing invalid post', 1, 999);

-- 21
ALTER TABLE user
ADD CONSTRAINT email_uq UNIQUE (email);

-- 22
INSERT INTO user (name, email) 
VALUES ('Ana Ruiz', 'ana@example.com'); 

INSERT INTO user (name, email) 
VALUES ('Pedro López', 'ana@example.com');
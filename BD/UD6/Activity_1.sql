USE cinema;

-- PARTE
	-- 1
SELECT p.projection_ID, p.projection_Datetime, m.title 
FROM Projection p 
INNER JOIN Movie m ON m.id_movie = p.id_movie;

	-- 2
SELECT m.title, p.projection_Datetime, r.room_number
FROM Movie m
INNER JOIN Projection p ON m.id_movie = p.id_movie
INNER JOIN Room r ON p.id_room = r.id_room;

	-- 3
SELECT p.projection_ID, m.title, c.cine_name 
FROM Projection p INNER JOIN Movie m ON p.id_movie = m.id_movie
INNER JOIN Cine c ON p.id_cine = c.id_cine;

	-- 4
SELECT m.title, m.genre, c.cine_name, r.room_number, p.projection_Datetime
FROM Projection p INNER JOIN Movie m ON p.id_movie = m.id_movie
INNER JOIN Cine c ON p.id_cine = c.id_cine
INNER JOIN Room r ON p.id_room = r.id_room;

	-- 5
SELECT m.title, d.director_name, c.cine_name
FROM Projection p INNER JOIN Movie m ON p.id_movie = m.id_movie
INNER JOIN Director d ON p.id_director = d.id_director
INNER JOIN Cine c ON p.id_cine = c.id_cine
ORDER BY projection_Datetime;

	-- 6
SELECT m.title, p.projection_Datetime, r.room_number
FROM Projection p INNER JOIN Movie m ON p.id_movie = m.id_movie
INNER JOIN Room r ON p.id_room = r.id_room
INNER JOIN Cine c ON p.id_cine = c.id_cine
WHERE cine_name = 'Cine Centro';

	-- 7
SELECT p.projection_id, m.title, m.genre, d.id_director, c.cine_name, c.cine_address, r.room_number, p.projection_Datetime
FROM Projection p INNER JOIN Movie m ON p.id_movie = m.id_movie
INNER JOIN Director d ON p.id_director = d.id_director
INNER JOIN Cine c ON p.id_cine = c.id_cine
INNER JOIN Room r ON p.id_room = r.id_room;

	-- 8
SELECT m.title, p.projection_Datetime, c.cine_name
FROM Projection p INNER JOIN Movie m ON p.id_movie = m.id_movie
INNER JOIN Cine c ON p.id_cine = c.id_cine
INNER JOIN Director d ON p.id_director = d.id_director
WHERE director_name = 'Christopher Nolan';

	-- 9
SELECT p.projection_Datetime, c.cine_name, r.room_number
FROM Projection p INNER JOIN Cine c ON p.id_cine = c.id_cine
INNER JOIN Room r ON p.id_room = r.id_room
INNER JOIN Movie m ON p.id_movie = m.id_movie
WHERE m.title = 'Viernes 13';

	-- 10
SELECT m.title, c.cine_name, r.room_number, p.projection_Datetime
FROM Projection p INNER JOIN Movie m ON p.id_movie = m.id_movie
INNER JOIN Cine c ON p.id_cine = c.id_cine
INNER JOIN Room r ON p.id_room = r.id_room
WHERE c.cine_name = 'Cine Plaza';

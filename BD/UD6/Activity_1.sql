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


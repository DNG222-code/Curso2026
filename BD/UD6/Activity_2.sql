USE cinema;

	-- INSERT's
INSERT INTO Cine (id_cine, cine_name, cine_address)
VALUES (3, 'Ocimax', 'C/Menorca'), (4, 'Ocimax2', 'C/Mahón'), (5, 'Ocimax3', 'C/Ciudadela');

INSERT INTO Director (id_director, director_name)
VALUES (3, 'Marlon'), (4, 'Dandy'), (5, 'Emilio');

INSERT INTO Movie (id_movie, title, genre)
VALUES (5, 'Titanic', 'Drama'), (6, 'Spider-man', 'Adventure'), (7, 'Hulk', 'Comedia');

INSERT INTO Room (id_room, room_number)
VALUES (3, 3), (4, 4), (5, 5);

INSERT INTO Projection (projection_ID, projection_Datetime, id_movie, id_room, id_cine, id_director)
VALUES (3, '2026-01-01 22:00:00', 3, 3, 3, 3), (4, '2025-02-02 12:00:00', 4, 4, 4, 4), (5, '2025-02-01 12:00:20', 5, 5, 5, 5);

-- JOIN's
	-- PART A
    
    -- 1
SELECT COUNT(*) AS 'Total_Projections' FROM Projection;

	-- 2
SELECT m.title, COUNT(*) FROM Projection p
INNER JOIN Movie m ON p.id_movie = m.id_movie; 

	-- 3
SELECT c.cine_name, COUNT(*) AS 'Total_Projections' FROM Projection p
INNER JOIN Cine c ON p.id_cine = c.id_cine;

	-- PART B

	-- 4
SELECT c.cine_name, COUNT(*) AS 'Total_Projections' 
FROM Projection p INNER JOIN Cine c
ON p.id_cine = c.id_cine
WHERE c.cine_name = 'Cine Centro';

	-- 5
SELECT d.director_name, COUNT(*) AS 'Total_Projections', m.title
FROM Projection p INNER JOIN Director d
ON p.id_director = d.id_director
INNER JOIN Movie m ON p.id_movie = m.id_movie
GROUP BY d.director_name;

	-- 6
SELECT m.genre, COUNT(*) AS 'Total_Projections'
FROM Projection p INNER JOIN Movie m
ON p.id_movie = m.id_movie
GROUP BY m.genre
ORDER BY 'Total_Projections' desc;

	-- 7
SELECT m.title, COUNT(*) AS 'Total_Projections'
FROM Projection p INNER JOIN Movie m 
ON p.id_movie = m.id_movie
GROUP BY m.title
ORDER BY 'Total_Projections' desc
LIMIT 1;

	-- 8
SELECT c.cine_name, COUNT(*) AS 'Total_Projections'
FROM Projection p INNER JOIN Cine c
ON p.id_cine = c.id_cine
GROUP BY c.cine_name
ORDER BY 'Total_Projections' DESC
LIMIT 3;

	-- 9
SELECT m.title, MAX(p.projection_Datetime) AS 'Last_Screenings', MAX(p.projection_Datetime) AS 'First_Screenings'

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
VALUES (3, );

	-- JOIN's
SELECT * FROM Cine;

SELECT * FROM Movie;
CREATE DATABASE cinema;

USE cinema;

-- Create tables.
CREATE TABLE Projection (
	projection_ID VARCHAR(10) PRIMARY KEY,
    projection_Datetime DATETIME NOT NULL,
    id_movie INT NOT NULL,
    id_room INT NOT NULL,
    id_cine INT NOT NULL,
    id_director INT NOT NULL,
    
    CONSTRAINT fk_projection_movie
        FOREIGN KEY (id_movie)
        REFERENCES Movie (id_movie),

    CONSTRAINT fk_projection_room
        FOREIGN KEY (id_room)
        REFERENCES Room (id_room),
        
	CONSTRAINT fk_projection_cine
		FOREIGN KEY (id_cine)
        REFERENCES Cine (id_cine),
        
	CONSTRAINT fk_projection_director
		FOREIGN KEY (id_director)
        REFERENCES Director (id_director)
);

DROP TABLE Projection;

CREATE TABLE Director (
	id_director INT PRIMARY KEY,
    director_name VARCHAR(20)
);

ALTER TABLE Director
MODIFY id_director INT NOT NULL;

CREATE TABLE Movie (
	id_movie INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(20)
);

-- ADD COLUMN genre.
ALTER TABLE Movie 
ADD COLUMN genre VARCHAR(20);

CREATE TABLE Room (
	id_room INT PRIMARY KEY,
    room_number INT
);

CREATE TABLE Cine (
	id_cine INT PRIMARY KEY,
    cine_name VARCHAR(20),
    cine_address VARCHAR(50)
);

-- AUTO_INCREMENT
ALTER TABLE Projection
MODIFY COLUMN projection_id INT NOT NULL AUTO_INCREMENT;

-- INSERT'S
INSERT INTO Movie (id_movie, title)
VALUES (1, "Viernes 13"),(2, "Torrente");

INSERT INTO Movie (genre)
VALUES ('Terror'), ('Comedia');

INSERT INTO Room (id_room, room_number)
VALUES (1, 1), (2, 2);

INSERT INTO Cine (id_cine, cine_name, cine_address)
VALUES (1, 'Cine Centro', 'C/ Centro de Mahón'), (2, 'Cine Grande', 'C/ Calle Grande');

INSERT INTO Projection (projection_ID, projection_Datetime, id_movie, id_room, id_cine, id_director)
VALUES (1, '2024-01-01 19:00:00', 1, 1, 1, 1), (2, '2025-04-01 22:00:00', 2, 2, 2, 2);

INSERT INTO Director (id_director, director_name)
VALUES (1, 'Santiago Segura'), (2, 'William Shakespeare');

-- INNER JOIN's
SELECT p.projection_ID, m.title, c.cine_name 
FROM Projection p INNER JOIN Movie m ON p.id_movie = m.id_movie
INNER JOIN Cine c ON p.id_cine = c.id_cine;

SELECT m.title, m.genre, c.cine_name, r.room_number, p.projection_Datetime
FROM Projection p INNER JOIN Movie m ON p.id_movie = m.id_movie
INNER JOIN Cine c ON p.id_cine = c.id_cine
INNER JOIN Room r ON p.id_room = r.id_room;

SELECT m.title, d.director_name, c.cine_name
FROM Projection p INNER JOIN Movie m ON p.id_movie = m.id_movie
INNER JOIN Director d ON p.id_director = d.id_director
INNER JOIN Cine c ON p.id_cine = c.id_cine
ORDER BY projection_Datetime;

SELECT m.title, p.projection_Datetime, r.room_number
FROM Projection p INNER JOIN Movie m ON p.id_movie = m.id_movie
INNER JOIN Room r ON p.id_room = r.id_room
INNER JOIN Cine c ON p.id_cine = c.id_cine
WHERE cine_name = 'Cine Centro';

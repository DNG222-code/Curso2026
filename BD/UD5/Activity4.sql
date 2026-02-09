CREATE DATABASE cinema;

USE cinema;

-- Create tables.
CREATE TABLE Projection (
	projection_ID VARCHAR(10) PRIMARY KEY,
    projection_Datetime DATETIME NOT NULL,
    id_movie INT NOT NULL,
    id_room INT NOT NULL,
    
    CONSTRAINT fk_projection_movie
        FOREIGN KEY (id_movie)
        REFERENCES Movie (id_movie),

    CONSTRAINT fk_projection_room
        FOREIGN KEY (id_room)
        REFERENCES Room (id_room)
);

CREATE TABLE Movie (
	id_movie INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100)
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
    cine_name VARCHAR(20)
);

-- AUTO_INCREMENT
ALTER TABLE Projection
MODIFY COLUMN projection_id INT NOT NULL AUTO_INCREMENT;

-- INSERT'S
INSERT INTO Movie(id_movie, title)
VALUES (1, "Viernes 13"),(2, "Torrente");

INSERT INTO Room(id_room, room_number)
VALUES (1, 1), (2, 2);

INSERT INTO Projection (projection_ID, projection_Datetime, id_movie, id_room)
VALUES (1, '2024-01-01 19:00:00', 1, 1), (2, '2025-04-01 22:00:00', 2, 2);

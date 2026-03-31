CREATE DATABASE movie_platform;
USE movie_platform;

CREATE TABLE country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50) NOT NULL
);

CREATE TABLE genre (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
);

CREATE TABLE director (
    director_id INT AUTO_INCREMENT PRIMARY KEY,
    director_name VARCHAR(100) NOT NULL,
    director_age INT,
    country_id INT NOT NULL,
    director_salary DECIMAL(10,2),
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE actor (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    actor_name VARCHAR(100) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE movie (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_title VARCHAR(150) NOT NULL,
    director_id INT NOT NULL,
    genre_id INT NOT NULL,
    release_year INT NOT NULL,
    duration_minutes INT NOT NULL,
    FOREIGN KEY (director_id) REFERENCES director(director_id),
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

CREATE TABLE casting (
    actor_id INT NOT NULL,
    movie_id INT NOT NULL,
    character_name VARCHAR(100) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (actor_id, movie_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);

INSERT INTO country (country_name) VALUES
('United States'),
('England'),
('Wales'),
('Scotland');

INSERT INTO genre (genre_name) VALUES
('Science Fiction');

INSERT INTO director (director_name, director_age, country_id, director_salary) VALUES
('George Lucas', 79, 1, 0.00),
('Irvin Kershner', 87, 1, 0.00),
('Richard Marquand', 49, 3, 0.00);

INSERT INTO director (director_name, director_age, country_id, director_salary) VALUES
('George Lucas', 79, 1, 2500000.00),
('Irvin Kershner', 87, 1, 1200000.00),
('Richard Marquand', 49, 3, 900000.00);

INSERT INTO actor (actor_name, country_id) VALUES
('Mark Hamill', 1),
('Harrison Ford', 1),
('Carrie Fisher', 1),
('Peter Cushing', 2),
('Alec Guinness', 2),
('Anthony Daniels', 2),
('Kenny Baker', 2),
('Peter Mayhew', 2),
('David Prowse', 2),
('Frank Oz', 2),
('Billy Dee Williams', 1),
('Sebastian Shaw', 2),
('Ian McDiarmid', 4),
('Tom Hardy', 1);

INSERT INTO movie (movie_title, director_id, genre_id, release_year, duration_minutes) VALUES
('Star Wars: Episode IV - A New Hope', 1, 1, 1977, 121),
('Star Wars: Episode V - The Empire Strikes Back', 2, 1, 1980, 124),
('Star Wars: Episode VI - Return of the Jedi', 3, 1, 1983, 131),
('Star Wars: Episode I - The Phantom Menace', 1, 1, 1999, 136),
('Star Wars: Episode II - Attack of the Clones', 1, 1, 2002, 142),
('Star Wars: Episode III - Revenge of the Sith', 1, 1, 2005, 139);

INSERT INTO casting (actor_id, movie_id, character_name, salary) VALUES
(1, 1, 'Luke Skywalker', 50000.00),
(1, 2, 'Luke Skywalker', 100000.00),
(1, 3, 'Luke Skywalker', 100000.00),

(2, 1, 'Han Solo', 60000.00),
(2, 2, 'Han Solo', 100000.00),
(2, 3, 'Han Solo', 100000.00),

(3, 1, 'Princess Leia', 55000.00),
(3, 2, 'Princess Leia', 100000.00),
(3, 3, 'Princess Leia', 100000.00),

(4, 1, 'Grand Moff Tarkin', 80000.00),

(5, 1, 'Obi-Wan Kenobi', 90000.00),
(5, 2, 'Obi-Wan Kenobi', 100000.00),
(5, 3, 'Obi-Wan Kenobi', 100000.00),

(6, 1, 'C-3PO', 40000.00),
(6, 2, 'C-3PO', 40000.00),
(6, 3, 'C-3PO', 40000.00),

(7, 1, 'R2-D2', 40000.00),
(7, 2, 'R2-D2', 50000.00),
(7, 3, 'R2-D2', 60000.00),

(8, 1, 'Chewbacca', 35000.00),
(8, 2, 'Chewbacca', 60000.00),
(8, 3, 'Chewbacca', 50000.00),

(9, 1, 'Darth Vader', 54000.00),
(9, 2, 'Darth Vader', 80000.00),
(9, 3, 'Darth Vader', 100000.00),

(10, 2, 'Yoda', 35000.00),
(10, 3, 'Yoda', 80000.00),

(11, 2, 'Lando Calrissian', 70000.00),
(11, 3, 'Lando Calrissian', 80000.00),

(12, 3, 'Anakin Skywalker', 25000.00),
(13, 3, 'The Emperor', 33000.00);
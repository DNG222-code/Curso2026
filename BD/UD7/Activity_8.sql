CREATE DATABASE music_platform;
USE music_platform;

-- =========================
-- TABLE: artists
-- =========================
CREATE TABLE artists (
    artist_id INT AUTO_INCREMENT PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    debut_year INT
);

-- =========================
-- TABLE: albums
-- =========================
CREATE TABLE albums (
    album_id INT AUTO_INCREMENT PRIMARY KEY,
    album_title VARCHAR(100) NOT NULL,
    release_year INT,
    artist_id INT NOT NULL,
    FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

-- =========================
-- TABLE: songs
-- =========================
CREATE TABLE songs (
    song_id INT AUTO_INCREMENT PRIMARY KEY,
    song_title VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    duration_seconds INT,
    album_id INT NOT NULL,
    FOREIGN KEY (album_id) REFERENCES albums(album_id)
);

-- =========================
-- TABLE: users
-- =========================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    country VARCHAR(50),
    registration_date DATE
);

-- =========================
-- TABLE: plays
-- =========================
CREATE TABLE plays (
    play_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    play_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

-- =========================
-- TABLE: logs
-- =========================

CREATE TABLE song_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    message VARCHAR(255) NOT NULL,
    log_date DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- =========================
-- INSERTS: artists
-- =========================
INSERT INTO artists (artist_name, country, debut_year) VALUES
('Adele', 'United Kingdom', 2006),
('Coldplay', 'United Kingdom', 1997),
('Shakira', 'Colombia', 1990),
('Ed Sheeran', 'United Kingdom', 2011),
('Imagine Dragons', 'United States', 2008);

-- =========================
-- INSERTS: albums
-- =========================
INSERT INTO albums (album_title, release_year, artist_id) VALUES
('21', 2011, 1),
('25', 2015, 1),
('A Rush of Blood to the Head', 2002, 2),
('Parachutes', 2000, 2),
('Laundry Service', 2001, 3),
('Divide', 2017, 4),
('Night Visions', 2012, 5);

-- =========================
-- INSERTS: songs
-- =========================
INSERT INTO songs (song_title, genre, duration_seconds, album_id) VALUES
('Rolling in the Deep', 'Pop', 228, 1),
('Someone Like You', 'Pop', 285, 1),
('Hello', 'Soul', 295, 2),
('Clocks', 'Alternative Rock', 307, 3),
('The Scientist', 'Alternative Rock', 309, 3),
('Yellow', 'Alternative Rock', 269, 4),
('Whenever, Wherever', 'Latin Pop', 196, 5),
('Shape of You', 'Pop', 233, 6),
('Perfect', 'Pop', 263, 6),
('Radioactive', 'Alternative Rock', 186, 7);

-- =========================
-- INSERTS: users
-- =========================
INSERT INTO users (username, email, country, registration_date) VALUES
('alice01', 'alice@example.com', 'Spain', '2024-01-15'),
('bob22', 'bob@example.com', 'France', '2024-02-10'),
('charlie88', 'charlie@example.com', 'Italy', '2024-03-05'),
('diana_music', 'diana@example.com', 'Germany', '2024-03-20'),
('eva_stream', 'eva@example.com', 'Portugal', '2024-04-01');

-- =========================
-- INSERTS: plays
-- =========================
INSERT INTO plays (user_id, song_id, play_date) VALUES
(1, 1, '2024-05-01'),
(1, 4, '2024-05-02'),
(2, 2, '2024-05-02'),
(2, 8, '2024-05-03'),
(3, 7, '2024-05-03'),
(3, 10, '2024-05-04'),
(4, 3, '2024-05-04'),
(4, 9, '2024-05-05'),
(5, 5, '2024-05-05'),
(5, 6, '2024-05-06');


-- EXERCICES:

-- 1. Correct duration if too short (On Insert)
DELIMITER //

CREATE TRIGGER correct_duration_on_insert BEFORE INSERT ON songs
FOR EACH ROW
BEGIN
	IF NEW.duration_seconds < 90 THEN
		SET NEW.duration_seconds = 90;
	END IF;
END //

DELIMITER ;

INSERT INTO songs('Song1', 'Pop', 200, 8);
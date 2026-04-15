-- Script SQL. Ejercicio en clase 18/03/2026

DROP DATABASE IF EXISTS bd_videojuegos;
CREATE DATABASE bd_videojuegos;
USE bd_videojuegos;

-- =========================================
-- TABLA: jugador
-- =========================================
CREATE TABLE jugador (
    id_jugador INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    fecha_registro DATE NOT NULL
);

-- =========================================
-- TABLA: videojuego
-- =========================================
CREATE TABLE videojuego (
    id_juego INT AUTO_INCREMENT PRIMARY KEY,
    nombre_juego VARCHAR(100) NOT NULL,
    genero VARCHAR(50) NOT NULL,
    anio_lanzamiento INT NOT NULL
);

-- =========================================
-- TABLA: partida
-- =========================================
CREATE TABLE partida (
    id_partida INT AUTO_INCREMENT PRIMARY KEY,
    id_jugador INT NOT NULL,
    id_juego INT NOT NULL,
    fecha_partida DATE NOT NULL,
    puntuacion INT NOT NULL,
    CONSTRAINT fk_partida_jugador
        FOREIGN KEY (id_jugador) REFERENCES jugador(id_jugador),
    CONSTRAINT fk_partida_videojuego
        FOREIGN KEY (id_juego) REFERENCES videojuego(id_juego)
);

-- =========================================
-- INSERTS EN jugador
-- =========================================
INSERT INTO jugador (nombre, pais, fecha_registro) VALUES
('Carlos', 'España', '2023-01-15'),
('Lucia', 'Mexico', '2023-03-10'),
('Andres', 'Argentina', '2024-02-05');

-- =========================================
-- INSERTS EN videojuego
-- =========================================
INSERT INTO videojuego (nombre_juego, genero, anio_lanzamiento) VALUES
('Dragon Quest World', 'RPG', 2021),
('Speed Racers', 'Carreras', 2019),
('Battle Zone X', 'Shooter', 2023),
('Galaxy Chess', 'Estrategia', 2020),
('Mystery Island', 'Aventura', 2024);


-- =========================================
-- INSERTS EN partida
-- =========================================
INSERT INTO partida (id_jugador, id_juego, fecha_partida, puntuacion) VALUES
(1, 1, '2024-05-01', 720),
(1, 3, '2024-05-03', 910),
(2, 1, '2024-05-04', 650),
(2, 2, '2024-05-06', 780),
(3, 3, '2024-05-08', 950),
(3, 2, '2024-05-10', 600),
(2, 1, '2024-05-12', 950),
(3, 1, '2024-05-13', 900),
(1, 2, '2024-05-14', 920),
(3, 2, '2024-05-15', 910),
(1, 4, '2024-05-16', 940),
(2, 4, '2024-05-17', 930);

-- =========================================
-- CONSULTAS DE COMPROBACIÓN
-- =========================================
SELECT * FROM jugador;
SELECT * FROM videojuego;
SELECT * FROM partida;

-- =========================================
-- Solución ejercicios
-- =========================================


-- Ejercicio 1 — Partidas con puntuación superior a la media
SELECT j.nombre, v.nombre_juego, p.puntuacion
FROM partida p
INNER JOIN jugador j
		ON p.id_jugador = j.id_jugador
INNER JOIN videojuego v
	ON p.id_juego = v.id_juego
WHERE p.puntuacion > (
    SELECT AVG(puntuacion)
    FROM partida
);

-- Ejercicio 2 — Jugadores que han jugado a videojuegos RPG
SELECT nombre
FROM jugador
WHERE id_jugador IN (
    SELECT p.id_jugador
    FROM partida p
    INNER JOIN videojuego v
		ON p.id_juego = v.id_juego
    WHERE v.genero = 'RPG'
);

-- Ejercicio 3 — Videojuegos nunca jugados
SELECT nombre_juego
FROM videojuego
WHERE id_juego NOT IN (
    SELECT id_juego
    FROM partida
);

-- Otra opción para evitar problemas típicos de NOT IN cuando hay valores NULL, también podríamos usar esta versión:

SELECT nombre_juego
FROM videojuego v
WHERE NOT EXISTS (
    SELECT *
    FROM partida p
    WHERE p.id_juego = v.id_juego
);

-- Ejercicio 4 — Jugadores con puntuaciones muy altas
SELECT nombre, pais
FROM jugador
WHERE id_jugador IN (
    SELECT id_jugador
    FROM partida
    WHERE puntuacion > (
        SELECT AVG(puntuacion)
        FROM partida
    )
);

-- Ejercicio 5 — Videojuegos con puntuación media superior a la media global
-- Muestra el nombre del videojuego y su puntuación media para aquellos videojuegos cuya puntuación media sea mayor que la puntuación media de todas las partidas del sistema.


-- “Quiero los videojuegos cuya media de puntuaciones sea mayor que la media de TODAS las partidas del sistema”
-- Pasos:
-- 1 Calcular la media global (todas las partidas)
-- 2 Calcular la media por cada videojuego
-- 3 Compararlas
-- 4 Mostrar solo los videojuegos que estén por encima

SELECT v.nombre_juego,
	AVG(p.puntuacion) AS media_puntuacion
FROM videojuego v
INNER JOIN partida p
	ON v.id_juego = p.id_juego
GROUP BY v.nombre_juego
HAVING AVG(p.puntuacion) > (
    SELECT AVG(puntuacion)
    FROM partida
);

-- Ejercicio 6 — Partidas con puntuación superior a la media del videojuego
-- “Quiero las partidas cuya puntuación sea mayor que la media de su propio videojuego”
-- 1 Recorrer todas las partidas
-- 2 Calcular la media de su videojuego
-- 3 Comparar puntuación con esa media
-- 4 Mostrar solo las que estén por encima

SELECT j.nombre, v.nombre_juego, p.puntuacion
FROM partida p
INNER JOIN jugador j
	ON p.id_jugador = j.id_jugador
INNER JOIN videojuego v
	ON p.id_juego = v.id_juego
WHERE p.puntuacion > (
    SELECT AVG(p2.puntuacion)
    FROM partida p2
    WHERE p2.id_juego = p.id_juego
);

-- Ejercicio 7 — Crear una vista de partidas completas

-- Crear la vista
CREATE VIEW vista_partidas_completas AS
SELECT j.nombre, j.pais, v.nombre_juego, v.genero, p.fecha_partida, p.puntuacion
FROM partida p
INNER JOIN jugador j
	ON p.id_jugador = j.id_jugador
INNER JOIN videojuego v
	ON p.id_juego = v.id_juego;

-- 1. Partidas realizadas por jugadores de España
SELECT *
FROM vista_partidas_completas
WHERE pais = 'España';

-- 2. Partidas con puntuación superior a 800
SELECT *
FROM vista_partidas_completas
WHERE puntuacion > 800;


-- 3. Ordenar por puntuación de mayor a menor
SELECT *
FROM vista_partidas_completas
ORDER BY puntuacion DESC;

-- Ejercicio 8 — Crear una vista de estadísticas por videojuego
-- Crear la vista
CREATE VIEW vista_estadisticas_videojuego AS
SELECT v.nombre_juego, v.genero,
       COUNT(p.id_partida) AS total_partidas,
       AVG(p.puntuacion) AS puntuacion_media
FROM videojuego v
INNER JOIN partida p
	ON v.id_juego = p.id_juego
GROUP BY v.nombre_juego, v.genero;

-- 1. Videojuegos con puntuación media superior a 700
SELECT *
FROM vista_estadisticas_videojuego
WHERE puntuacion_media > 700;

-- 2. Videojuegos con más de 3 partidas
SELECT *
FROM vista_estadisticas_videojuego
WHERE total_partidas > 3;

-- Ejercicio 9 — Crear una vista de estadísticas por jugador
-- Crear la vista
CREATE VIEW vista_estadisticas_jugador AS
SELECT j.nombre, j.pais,
       COUNT(p.id_partida) AS total_partidas,
       AVG(p.puntuacion) AS puntuacion_media,
       MAX(p.puntuacion) AS mejor_puntuacion
FROM jugador j
INNER JOIN partida p
	ON j.id_jugador = p.id_jugador
GROUP BY j.nombre, j.pais;

-- 1. Jugadores que hayan jugado más de 2 partidas
SELECT *
FROM vista_estadisticas_jugador
WHERE total_partidas > 2;

-- 2. Jugadores cuya mejor puntuación sea superior a 900
SELECT *
FROM vista_estadisticas_jugador
WHERE mejor_puntuacion > 900;


-- Ejercicio 10 — Videojuegos con jugadores de alto rendimiento

SELECT nombre_juego,
       AVG(puntuacion) AS media_puntuacion,
       COUNT(*) AS total_partidas
FROM vista_partidas_completas
GROUP BY nombre_juego
HAVING AVG(puntuacion) > (
    SELECT AVG(puntuacion)
    FROM partida
)
AND COUNT(*) > 1
ORDER BY media_puntuacion DESC;


-- o también:
-- Podemos calcular la media desde la tabla partida o desde la vista, porque la vista solo añade información con JOIN y no cambia los datos,
-- así que al final calcula lo mismo.

SELECT nombre_juego,
       AVG(puntuacion) AS puntuacion_media,
       COUNT(*) AS total_partidas
FROM vista_partidas_completas
GROUP BY nombre_juego
HAVING AVG(puntuacion) > (
    SELECT AVG(puntuacion)
    FROM vista_partidas_completas
)
AND COUNT(*) > 1
ORDER BY puntuacion_media DESC;
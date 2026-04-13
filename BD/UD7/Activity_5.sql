-- Exercise 1 – Accumulate total duration of a director's movies
DELIMITER //

CREATE PROCEDURE accumulate_total_duration_director (
    IN p_director_id INT,
    INOUT p_total_minutes INT
)
BEGIN
    DECLARE v_total_minutes INT;

    SET v_total_minutes = (SELECT SUM(duration_minutes) AS 'total_minutes' FROM movie
        WHERE director_id = p_director_id);
END //

// DELIMITER ;

CALL accumulate_total_duration_director(1, @p_total_minutes);
SELECT @p_total_minutes;

-- Exercise 2 – Accumulate total salaries of actors in a movie
DELIMITER //

CREATE PROCEDURE accumulate_actor_salaries (
    IN p_movie_id INT,
    INOUT p_total_salaries DECIMAL(10,2)
)
BEGIN
    DECLARE v_total_salaries DECIMAL(10,2);

    SET v_total_salaries = (SELECT SUM(c.salary) AS 'total_salaries' FROM casting c
                            INNER JOIN actor a ON c.actor_id = a.actor_id);

    SET p_total_salaries = p_total_salaries + v_total_salaries;
END;

// DELIMITER ;

CALL accumulate_actor_salaries(1, @total_salaries);
SELECT @total_salaries;

-- Exercise 3 – Accumulate movies released from a given year
DELIMITER //

CREATE PROCEDURE accumulate_movies_from_year (
    IN p_year YEAR,
    INOUT p_total DOUBLE
)
BEGIN
    DECLARE v_total DOUBLE;

    SET v_total = (SELECT COUNT(*) AS 'total'
                   FROM movie
                   WHERE release_year = p_year);

    SET p_total = p_total + v_total;
END //

// DELIMITER ;

CALL accumulate_movies_from_year(2, @total);
SELECT @total;

-- Exercise 4 – Accumulate highest-paid actor salary in a movie
DELIMITER //

CREATE PROCEDURE accumulate_max_actor_salary (
    IN p_movie_id INT,
    INOUT p_total DECIMAL(10,2)
)
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SET v_total = (SELECT MAX(c.salary) AS 'total' FROM casting c);

    SET p_total = p_total + v_total;
END //

// DELIMITER ;

CALL accumulate_max_actor_salary(1, @total);
SELECT @total;

-- Exercise 5 – Accumulate longest movie duration in a genre
DELIMITER //

CREATE PROCEDURE accumulate_max_duration_genre (
    IN p_genre_id INT,
    INOUT p_total_duration INT
)
BEGIN
    DECLARE v_total_duration INT;

    SET v_total_duration = (SELECT MAX(duration_minutes) AS 'total_duration' FROM movie
                            WHERE genre_id = p_genre_id);

    SET p_total_duration = p_total_duration + v_total_duration;
END //

// DELIMITER ;

CALL accumulate_max_duration_genre(2, @total_duration);
SELECT @total_duration;

-- Exercise 6 – Accumulate oldest release year of a director
DELIMITER //

CREATE PROCEDURE accumulate_min_year_director (
    IN p_director_id INT,
    INOUT p_total_years INT
)
BEGIN
    DECLARE v_total_years INT;

    SET v_total_years = (SELECT MIN(release_year) AS 'total_years' FROM movie
                        WHERE director_id = p_director_id);

    SET p_total_years = p_total_years + v_total_years;
END //

DELIMITER ;

CALL accumulate_min_year_director(3, @total_years);
SELECT @total_years;

-- Exercise 7 – Accumulate number of movies from a country
DELIMITER //

CREATE PROCEDURE accumulate_movies_country (
    IN p_country_id INT,
    INOUT p_total_movies INT
)
BEGIN
    DECLARE v_total_movies INT;

    SET v_total_movies = (SELECT COUNT(m.movie_id) AS 'total_movies' FROM movie m
                            INNER JOIN director d ON m.director_id = d.director_id
                            INNER JOIN country c ON d.country_id = c.country_id
                                WHERE c.country_id = p_country_id);

    SET p_total_movies = p_total_movies + v_total_movies;
END //

// DELIMITER ;

CALL accumulate_movies_country(2, @total_movies);
SELECT @total_movies;

-- Exercise 8 – Accumulate movies with duration above the director’s average
DELIMITER //

CREATE PROCEDURE accumulate_movies_above_avg_duration_director (
    IN p_director_id INT,
    INOUT p_total INT
)
BEGIN
    DECLARE v_total INT;

    SET v_total = (SELECT COUNT(*) AS 'total' FROM movie m
                    INNER JOIN director d ON m.director_id = d.director_id
                    WHERE m.duration_minutes > (SELECT AVG(duration_minutes)
                                                    FROM movie
                                                    WHERE director_id = p_director_id));

    SET p_total = p_total + v_total;
END //

// DELIMITER ;

CALL accumulate_movies_above_avg_duration_director(1, @total);
SELECT @total;

-- Exercise 9 – Accumulate directors with salary above their country’s average
DELIMITER //

CREATE PROCEDURE accumulate_directors_above_avg_salary_country (
    INOUT p_total DECIMAL(10,2)
)
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SET v_total = (SELECT COUNT(d.director_id) AS 'total' FROM director d
                      INNER JOIN country c ON d.country_id = c.country_id
                      WHERE d.director_salary > (SELECT AVG(d.director_salary)
                                                    FROM director d));

    SET p_total = p_total + v_total;
END //

// DELIMITER ;

CALL accumulate_directors_above_avg_salary_country(@total);
SELECT @total;

-- Exercise 10 – Accumulate directors with many movies
DELIMITER //

CREATE PROCEDURE accumulate_directors_many_movies (
    INOUT p_total INT
)
BEGIN
    DECLARE v_total INT;

    SET v_total = (SELECT COUNT(d.director_id) AS 'total' FROM director d
                  INNER JOIN movie m ON d.director_id = m.director_id
                      GROUP BY d.director_id
                      HAVING COUNT(m.movie_id) > 2);

    SET p_total = p_total + v_total;
END //

// DELIMITER ;

CALL accumulate_directors_many_movies(@total);
SELECT @total;
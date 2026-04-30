-- Exercise 1 – IFNULL (total duration)

DELIMITER //

CREATE PROCEDURE total_duration_director (
    IN p_id_director INT,
    OUT p_total_duration INT
)
BEGIN
    DECLARE v_total_duration INT;

    SELECT IFNULL(SUM(duration_minutes), 0) AS 'total_duration'
    INTO v_total_duration
    FROM movie
    WHERE director_id = p_id_director;

    SET p_total_duration = v_total_duration;
END //

DELIMITER ;

CALL total_duration_director(2, @total_duration);
SELECT @total_duration;

-- Exercise 2 – COALESCE (maximum salary)

DELIMITER //

CREATE PROCEDURE max_salary_movie (
    IN p_id_movie INT,
    OUT p_salary DECIMAL(10,2)
)
BEGIN
    DECLARE v_max_salary DECIMAL(10,2);

    SELECT COALESCE(MAX(salary), 0) AS 'max_salary'
    INTO v_max_salary
    FROM casting c
    INNER JOIN movie m ON c.movie_id = m.movie_id
    WHERE m.movie_id = p_id_movie;

    SET p_salary = v_max_salary;
END //

DELIMITER ;

CALL max_salary_movie(2, @salary);
SELECT @salary;

-- Exercise 3 – COALESCE + INOUT

DELIMITER //

CREATE PROCEDURE accumulate_salary_movie (
    IN p_id_movie INT,
    INOUT p_total DECIMAL(10,2)
)
BEGIN
    DECLARE v_max_salary DECIMAL(10,2);
    DECLARE v_avg_salary DECIMAL(10,2);

    SELECT MAX(salary) AS 'max_salary'
    INTO v_max_salary
    FROM casting c
    INNER JOIN movie m ON c.movie_id = m.movie_id
    WHERE m.movie_id = p_id_movie;

    SELECT AVG(salary) AS 'avg_salary'
    INTO v_avg_salary
    FROM casting c
    INNER JOIN movie m ON c.movie_id = m.movie_id
    WHERE m.movie_id = p_id_movie;

    SET p_total = COALESCE(v_max_salary, v_avg_salary, 100, 0);

END //

DELIMITER ;

CALL accumulate_salary_movie(2, @total);
SELECT @total;

-- Exercise 4 – DISTINCT (genres of a director)

DELIMITER //

CREATE PROCEDURE distinct_genres_director (
    IN p_id_director INT,
    OUT p_total_genres DECIMAL(10,2)
)
BEGIN
    DECLARE v_distinct_genres VARCHAR(20);

    SELECT COUNT(DISTINCT genre_id) AS 'genres'
    INTO v_distinct_genres
    FROM movie
    WHERE director_id = p_id_director;

    SET p_total_genres = COALESCE(v_distinct_genres, 0);
END //

DELIMITER ;

CALL distinct_genres_director(2, @total_genres);
SELECT @total_genres;

-- Exercise 5 – WHILE
DELIMITER //

CREATE PROCEDURE bonus_director_while (
    IN p_id_director INT,
    OUT p_bonus DOUBLE
)
BEGIN
    DECLARE v_total_movies INT;

    SELECT COUNT(director_id) AS 'director_movies'
    INTO v_total_movies
    FROM movie
    WHERE director_id = p_id_director;


END //

DELIMITER ;
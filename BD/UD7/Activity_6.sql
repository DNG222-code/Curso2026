-- Exercise 1 – Check if a director has movies
DELIMITER //

CREATE PROCEDURE check_director_has_movies (
    IN p_director_id INT,
    OUT p_message VARCHAR(255)
)
BEGIN
    SELECT COUNT(m.movie_id) AS 'total_movies'
        FROM director d
        INNER JOIN movie m ON d.director_id = m.director_id
        WHERE d.director_id = p_director_id;

        IF 'total_movies' >= 1 THEN
            SET p_message = 'Has movies';
        ELSE
            SET p_message = 'No movies';
        END IF;
END;

// DELIMITER ;

CALL check_director_has_movies(2, @message);
SELECT @message;

-- Exercise 2 – Classify a director by salary
DELIMITER //

CREATE PROCEDURE classify_director_salary (
    IN p_director_id INT,
    OUT p_category VARCHAR(255)
)
BEGIN
    DECLARE v_salary DECIMAL;

    -- Obtener el salario del director
    SELECT director_salary
    INTO v_salary
    FROM director
    WHERE director_id = p_director_id;

    -- Clasificar el salario
    IF v_salary < 3000 THEN
        SET p_category = 'Low salary';
    ELSEIF v_salary BETWEEN 3000 AND 6000 THEN
        SET p_category = 'Medium salary';
    ELSE
        SET p_category = 'High salary';
    END IF;

END //

DELIMITER ;

CALL classify_director_salary(2, @category);
SELECT @category;

-- Exercise 3 – Classify a movie by its duration
DELIMITER //

CREATE PROCEDURE classify_movie_duration (
    IN p_movie_id INT,
    OUT p_classification VARCHAR(50)
)
BEGIN
    DECLARE total_minutes INT;

    SELECT duration_minutes INTO total_minutes FROM movie
        WHERE p_movie_id = movie_id;

    IF total_minutes < 90 THEN
        SET p_classification = 'Short';
    ELSEIF total_minutes BETWEEN 90 AND 119 THEN
        SET p_classification = 'Medium';
    ELSEIF total_minutes BETWEEN 120 AND 149 THEN
        SET p_classification = 'Long';
    ELSE
        SET p_classification = 'Very long';
    END IF;
END //

// DELIMITER ;
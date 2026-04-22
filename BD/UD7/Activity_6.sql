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

CALL classify_movie_duration(2, @classification);
SELECT @classification;

-- Exercise 4 – Check if a director's salary is above the average of their country
DELIMITER //

CREATE PROCEDURE check_director_above_country_average (
    IN p_director_id INT,
    OUT p_result VARCHAR(50)
)
BEGIN
        DECLARE v_salary DECIMAL;
END //

// DELIMITER ;

-- Exercise 4 – Check if a director's salary is above the average of their country
DELIMITER //

CREATE PROCEDURE check_director_above_country_average (
    IN p_director_id INT,
    OUT p_result VARCHAR(50)
)
BEGIN
    DECLARE v_salary DECIMAL;
    DECLARE v_country VARCHAR(50);
    DECLARE v_avg_salary DECIMAL;

    SET v_salary = (SELECT director_salary FROM director
                   WHERE p_director_id = director_id);
    SET v_country = (SELECT c.country_name FROM country c
                   INNER JOIN director d ON c.country_id = d.country_id
                     WHERE p_director_id = director_id);
    SET v_avg_salary = (SELECT AVG(director_salary) AS 'average_salary' FROM director
                        WHERE p_director_id = director_id);

    IF v_salary > v_avg_salary THEN
        SET p_result = 'Above country average';
    ELSE
        SET p_result = 'Below country average';
    END IF;
END //

// DELIMITER ;

CALL check_director_above_country_average(2, @result);
SELECT @result;

-- Exercise 5 – Classify the age of a movie
DELIMITER //

CREATE PROCEDURE classify_movie_age (
    IN p_movie_id INT,
    OUT p_category VARCHAR(20)
)
BEGIN
    DECLARE v_release_year YEAR;

    SET v_release_year = (SELECT release_year FROM movie);

    IF v_release_year < 2000 THEN
        SET p_category = 'Old movie';
        ELSE IF v_release_year BETWEEN 2000 AND 2015 THEN
            SET p_category = 'Middle-aged movie';
        ELSE
            SET p_category = 'Recent movie';
        END IF;
    END IF;
END //

// DELIMITER ;

CALL classify_movie_age(1, @category);
SELECT @category;

-- Exercise 6
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

END //

// DELIMITER ;
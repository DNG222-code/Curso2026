-- Exercise 1 – Get the salary of a director
DELIMITER //

CREATE PROCEDURE get_director_salary(IN p_director_id INT, OUT p_salary decimal)
BEGIN
    SELECT director_salary INTO p_salary FROM director
        WHERE director_id = p_director_id;
END //

DELIMITER ;

CALL get_director_salary(2, @salary);
SELECT @salary;

-- Exercise 2 – Get the title of a movie from its id
DELIMITER //

CREATE PROCEDURE get_movie_title(
    IN p_movie_id int,
    OUT p_title varchar(150)
)
BEGIN
    SELECT movie_title INTO p_title FROM movie
        WHERE movie_id = p_movie_id;
END //

DELIMITER ;

CALL get_movie_title(1, @title);
SELECT @title;

-- Exercise 3 - Count how many actors participate in a movie
DELIMITER //

CREATE PROCEDURE count_movie_actors(
    IN p_movie_id int,
    OUT p_total_actors int
)
BEGIN
    SELECT COUNT(actor_id) AS total_actors INTO p_total_actors FROM casting
    WHERE movie_id = p_movie_id;
END //

CALL count_movie_actors(2, @total_actors);
SELECT @total_actors;

-- Exercise 4 – Get how many movies belong to a genre
DELIMITER //

CREATE PROCEDURE count_movies_by_genre(
    IN p_genre_id INT,
    OUT p_total INT
)
BEGIN
    SELECT COUNT(movie_id) AS total_movies INTO p_total FROM movie
        WHERE genre_id = p_genre_id;
END //

DELIMITER ;

CALL count_movie_actors(2, @total_actors);
SELECT @total_actors;

-- Exercise 5 – Calculate the total salary paid to the actors of a movie
DELIMITER //

CREATE PROCEDURE get_total_actor_salary_by_movie(
    IN p_movie_id INT,
    OUT p_total_salary DECIMAL
)
BEGIN
    SELECT SUM(salary) AS total_salary INTO p_total_salary FROM casting
        WHERE movie_id = p_movie_id;
END //

DELIMITER ;

CALL get_total_actor_salary_by_movie(2, @total_salary);
SELECT @total_salary;

-- Exercise 6 – Get the country of an actor
DELIMITER //

CREATE PROCEDURE get_actor_country(
    IN p_actor_id INT,
    OUT p_country_name VARCHAR(50)
)
BEGIN
    SELECT country_name INTO p_country_name FROM country
        WHERE country_id = (SELECT country_id FROM actor WHERE actor_id = p_actor_id);
END //

DELIMITER ;

CALL get_actor_country(2, @country_name);
SELECT @country_name;

-- Exercise 7 – Longest movie of a director
DELIMITER //

CREATE PROCEDURE get_max_duration_by_director(
    IN p_director_id INT,
    OUT p_max_duration INT
)
BEGIN
    SELECT MAX(duration_minutes) AS max_duration INTO p_max_duration FROM movie
        WHERE director_id = p_director_id;
END //

DELIMITER ;

CALL get_max_duration_by_director(2, @max_duration);
SELECT @max_duration;

-- Exercise 8 – Year of the oldest movie in a genre
DELIMITER //

CREATE PROCEDURE get_oldest_year_by_genre(
    IN p_genre_id INT,
    OUT p_oldest_year INT
)
BEGIN
    SELECT MAX(release_year) AS oldest_year INTO p_oldest_year FROM movie
        WHERE genre_id = p_genre_id
        GROUP BY genre_id;
END //

DELIMITER ;

CALL get_oldest_year_by_genre(2, @oldest_year);
SELECT @oldest_year;

-- Exercise 9 – Sum salaries of actors from a country in a movie
DELIMITER //

CREATE PROCEDURE get_actor_salary_by_country_and_movie(
    IN p_movie_id INT,
    IN p_country_id INT,
    OUT p_total_salary DECIMAL
)
BEGIN
    SELECT SUM(salary) AS total_salary INTO p_total_salary FROM casting c
       INNER JOIN actor a ON c.actor_id = a.actor_id
            WHERE a.country_id = p_country_id AND movie_id = p_movie_id
    GROUP BY c.actor_id;
END //

DELIMITER ;

CALL get_actor_salary_by_country_and_movie(2, 1, @total_salary);
SELECT @total_salary;

-- Exercise 10 – Count movies of a genre with at least a minimum number of actors
DELIMITER //

CREATE PROCEDURE count_movies_by_genre_min_actors(
    IN p_genre_id INT,
    IN p_min_actors INT,
    OUT p_total_movies INT
)
BEGIN
    SELECT COUNT(movie_id) AS total_movies INTO p_total_movies FROM movie m
        WHERE genre_id = p_genre_id AND (SELECT COUNT(actor_id) FROM casting c WHERE m.movie_id = c.movie_id) >= p_min_actors;
END //

DELIMITER ;

CALL count_movies_by_genre_min_actors(1, 1, @total_movies);
SELECT @total_movies;
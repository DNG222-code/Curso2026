-- Exercise 1 – View all directors
DELIMITER //

CREATE PROCEDURE show_directors()
BEGIN
    SELECT * FROM director;
END //

DELIMITER ;

CALL show_directors();

-- Exercise 2 - View all movies
DELIMITER //

CREATE PROCEDURE show_movies()
BEGIN
    SELECT * FROM movie;
END //

DELIMITER ;

CALL show_movies();

-- Exercise 3 - View all actors
DELIMITER //

CREATE PROCEDURE show_actors()
BEGIN
    SELECT * FROM actor;
END //

DELIMITER ;

CALL show_actors();

-- Exercise 4 – Movies from a specific year
DELIMITER //

CREATE PROCEDURE movies_by_year(p_year int)
BEGIN
    SELECT * FROM movie
        WHERE release_year = p_year;
END //

DELIMITER ;

CALL movies_by_year(1977);

-- Exercise 5 – Directors with a salary greater than a given amount
DELIMITER //

CREATE PROCEDURE directors_salary_greater(p_salary decimal)
BEGIN
    SELECT * FROM director
        WHERE director_salary > p_salary;
END //

DELIMITER ;

CALL directors_salary_greater(100000);

-- Exercise 6 – Movies by a specific director
DELIMITER //

CREATE PROCEDURE movies_by_director(p_director_id int)
BEGIN
    SELECT * FROM movie
        WHERE director_id = p_director_id;
END //

DELIMITER ;

CALL movies_by_director(1);

-- Exercise 7 – Movies by a specific genre
DELIMITER //

CREATE PROCEDURE movies_by_genre(p_genre_id int)
BEGIN
    SELECT * FROM movie
        WHERE genre_id = p_genre_id;
END //

DELIMITER ;

CALL movies_by_genre(1);

-- Exercise 8 – Actors in a movie
DELIMITER //

CREATE PROCEDURE actors_by_movie(p_movie_id int)
BEGIN
    SELECT * FROM actor
        WHERE actor_id = p_movie_id;
END //

DELIMITER ;

CALL actors_by_movie(1);

-- Exercise 9 – View the created procedures
DELIMITER //

SHOW PROCEDURE STATUS;

DELIMITER ;

-- Exercise 10 – Delete a procedure
DELIMITER //

DROP PROCEDURE show_actors;

DELIMITER ;

SHOW PROCEDURE STATUS LIKE 'show_actors';

-- Exercise 11 – Number of movies directed by a director
DELIMITER //

CREATE PROCEDURE count_movies_by_director(p_director_id int)
BEGIN
    SELECT movie_title, COUNT(*) AS 'total_movies' FROM movie
        WHERE director_id = p_director_id
        GROUP BY movie_title;
END //

DELIMITER ;

CALL count_movies_by_director(2);

-- Exercise 12 – Number of movies between two years
DELIMITER //

CREATE PROCEDURE count_movies_between_years(p_start_year int, p_end_year int)
BEGIN
    SELECT movie_title, COUNT(*) AS 'total_movies' FROM movie
        WHERE release_year BETWEEN p_start_year AND p_end_year
        GROUP BY movie_title;
END //

DELIMITER ;

CALL count_movies_between_years(1970, 1980);
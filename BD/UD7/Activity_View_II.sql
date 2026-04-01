-- movie_details_view
CREATE VIEW movie_details_view AS
    SELECT m.movie_title, m.release_year, m.duration_minutes, d.director_name,
        g.genre_name
    FROM movie m
    INNER JOIN director d ON m.director_id = d.director_id
    INNER JOIN genre g ON m.genre_id = g.genre_id;

-- 1
SELECT * FROM movie_details_view;

-- 2
SELECT movie_title, release_year
FROM movie_details_view
WHERE release_year > 1990;

-- 3
SELECT movie_title, duration_minutes
FROM movie_details_view
ORDER BY duration_minutes DESC;

-- actor_movies_view
CREATE VIEW actor_movies_view AS
    SELECT a.actor_name, m.movie_title, c.character_name, c.salary
    FROM actor a
    INNER JOIN casting c ON a.actor_id = c.actor_id
    INNER JOIN movie m ON c.movie_id = m.movie_id;

-- 1
SELECT actor_name
FROM actor_movies_view;

-- 2
SELECT actor_name, salary
FROM actor_movies_view
WHERE salary > 80000;

-- 3
SELECT actor_name, salary
FROM actor_movies_view
ORDER BY salary DESC;

-- long_movies_view
CREATE VIEW long_movies_view AS
    SELECT movie_title, duration_minutes
    FROM movie_details_view
    WHERE duration_minutes > 130;

-- 1
SELECT *
FROM long_movies_view;

-- 2
SELECT *
FROM long_movies_view
ORDER BY duration_minutes DESC;

-- actor_movie_count_view
CREATE VIEW actor_movie_count_view AS
    SELECT actor_name, COUNT(movie_title) AS number_of_movies
    FROM actor_movies_view
    GROUP BY actor_name;

-- 1
SELECT *
FROM actor_movie_count_view;

-- 2
SELECT *
FROM actor_movie_count_view
WHERE number_of_movies > 2;

-- 3
SELECT *
FROM actor_movie_count_view
ORDER BY number_of_movies DESC;

-- actor_total_salary_view
CREATE VIEW actor_total_salary_view AS
    SELECT actor_name, SUM(salary) AS total_salary
    FROM actor_movies_view
    GROUP BY actor_name;

-- 1
SELECT *
FROM actor_total_salary_view;

-- 2
SELECT *
FROM actor_total_salary_view
ORDER BY total_salary DESC;

-- 3
SELECT *
FROM actor_total_salary_view
WHERE total_salary > 200000;

-- movie_actor_cost_view
CREATE VIEW movie_actor_cost_view AS
    SELECT movie_title, SUM(salary) AS total_actor_salary
    FROM actor_movies_view
    GROUP BY movie_title;

-- 1
SELECT *
FROM movie_actor_cost_view;

-- 2
SELECT *
FROM movie_actor_cost_view
WHERE total_actor_salary > 200000;

-- 3
SELECT *
FROM movie_actor_cost_view
ORDER BY total_actor_salary DESC;

-- movie_duration_category_view
CREATE VIEW movie_duration_category_view AS
    SELECT movie_title, duration_minutes, CASE
        WHEN duration_minutes <= 120 THEN 'Short'
        WHEN duration_minutes > 120 AND duration_minutes <= 130 THEN 'Medium'
        ELSE 'Long'
    END AS duration_category
    FROM movie_details_view;

-- 1
SELECT *
FROM movie_duration_category_view;

-- 2
SELECT *
FROM movie_duration_category_view
WHERE duration_category = 'Long';

-- actor_country_view
CREATE VIEW actor_country_view AS
    SELECT a.actor_name, c.country_name
    FROM actor a
    INNER JOIN country c ON a.country_id = c.country_id;

-- 1
SELECT *
FROM actor_country_view;

-- 2
SELECT *
FROM actor_country_view
WHERE country_name = 'USA';

-- 3
SELECT *
FROM actor_country_view
ORDER BY actor_name;

-- movie_actor_count_view
CREATE VIEW movie_actor_count_view AS
    SELECT m.movie_title, COUNT(a.actor_name) AS number_of_actors
    FROM movie m
    INNER JOIN casting c ON m.movie_id = c.movie_id
    INNER JOIN actor a ON c.actor_id = a.actor_id
    GROUP BY m.movie_title;

-- 1
SELECT *
FROM movie_actor_count_view;

-- 2
SELECT *
FROM movie_actor_count_view
WHERE number_of_actors > 5;

-- 3
SELECT *
FROM movie_actor_count_view
ORDER BY number_of_actors DESC;

-- actors_without_movies_view
CREATE OR REPLACE VIEW actors_without_movies_view AS
    SELECT a.actor_name, m.movie_title
    FROM actor a
    INNER JOIN casting c ON a.actor_id = c.actor_id
    INNER JOIN movie m ON c.movie_id = m.movie_id
    WHERE m.movie_title IS NULL;

-- 1
SELECT *
FROM actors_without_movies_view;

-- 2
SELECT *
FROM actors_without_movies_view
WHERE movie_title IS NULL;

-- top_paid_actors_view
CREATE VIEW top_paid_actors_view AS
    SELECT actor_name, total_salary
    FROM actor_total_salary_view
    WHERE total_salary > 200000
    GROUP BY actor_name;

-- 1
SELECT *
FROM top_paid_actors_view;

-- 2
SELECT *
FROM top_paid_actors_view
ORDER BY total_salary DESC;

-- simple_actor_view
CREATE VIEW simple_actor_view AS
    SELECT a.actor_name, a.country_id
    FROM actor a;

-- 1
SELECT *
FROM simple_actor_view;

-- 2
UPDATE simple_actor_view
SET actor_name = 'Thomas Hardy'
WHERE actor_name = 'Tom Hardy';

-- 3
SELECT *
FROM simple_actor_view;

-- Delete data.

-- 1
DELETE
FROM simple_actor_view
WHERE actor_name = 'Thomas Hardy';

-- 2
SELECT *
FROM simple_actor_view
WHERE actor_name = 'Thomas Hardy';

-- Inserting data.
-- 1
INSERT INTO simple_actor_view (actor_name, country_id)
VALUES ('Emma Stone', 1);

-- 2
SELECT *
FROM simple_actor_view
WHERE actor_name = 'Emma Stone';

-- actor_most_movies_view
CREATE VIEW actor_most_movies_view AS
    SELECT sav.actor_name, COUNT(m.movie_title) AS number_of_movies
    FROM simple_actor_view sav
    INNER JOIN movie m ON sav.country_id = m.director_id
    GROUP BY sav.actor_name;

-- 1
SELECT *
FROM actor_most_movies_view
ORDER BY number_of_movies DESC
LIMIT 1;

-- 2
SELECT *
FROM actor_most_movies_view
ORDER BY number_of_movies DESC;

-- movie_highest_salary_view
CREATE VIEW movie_highest_salary_view AS
    SELECT m.movie_title, a.actor_name, MAX(c.salary) AS highest_actor_salary
    FROM movie m
    INNER JOIN casting c ON m.movie_id = c.movie_id
    INNER JOIN actor a ON c.actor_id = a.actor_id
    GROUP BY m.movie_title, a.actor_name
    ORDER BY highest_actor_salary DESC
    LIMIT 1;

-- 1
SELECT *
FROM movie_highest_salary_view;

-- 2
SELECT *
FROM movie_highest_salary_view
ORDER BY highest_actor_salary DESC;
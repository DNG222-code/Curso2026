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
--Процедура insert_movies(varchar, integer, integer, integer) додає в таблицю movies новий рядок із вказаними аргументами
DROP PROCEDURE IF EXISTS insert_channel(varchar, integer, integer, integer);
CREATE OR REPLACE PROCEDURE insert_movies(name_m varchar, genre_m integer, rating_m integer, runtime_m integer)
LANGUAGE 'plpgsql'
AS $$
BEGIN
    INSERT INTO movies(m_name, id_genre,   id_rating, id_runtime) VALUES (name_m, genre_m, rating_m, runtime_m);
END;
$$;

SELECT * FROM movies
-- ТЕСТИ
CALL insert_movies('Ukraine war', 1, 3, 4);
CALL insert_movies('Baby Shark',6, 2, 3);

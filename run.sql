
--Функцію get_movies(genre_arg) виводить всі фільми із заданим жанром
DROP FUNCTION IF EXISTS get_movies(varchar); 

CREATE OR REPLACE FUNCTION get_movies(genre_arg varchar) RETURNS TABLE (genre_name varchar, genre varchar)
    LANGUAGE 'plpgsql'
AS $$
BEGIN
    RETURN QUERY
        SELECT m_name::varchar, genre.genre_name::varchar
		FROM movies JOIN genre USING(id_genre)
		WHERE  genre.genre_name = genre_arg;
END;
$$

--ТЕСТИ
SELECT * FROM get_movies('Action');
SELECT * FROM get_movies('Adventure');


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

--тригер при додавані рядка записує назву фільму у верхньому регістрі
DROP TRIGGER IF EXISTS movies_m_name_insert ON movies;

CREATE OR REPLACE FUNCTION upper_m_name() RETURNS trigger 
LANGUAGE 'plpgsql'
AS
$$
     BEGIN
          UPDATE movies
          SET m_name = upper(m_name)
		  WHERE movies.m_name = NEW.m_name; 
		  RETURN NULL; -- result is ignored since this is an AFTER trigger
     END;
$$;

CREATE TRIGGER movies_m_name_insert
AFTER INSERT ON movies
FOR EACH ROW EXECUTE FUNCTION upper_m_name()

select * from  movies
INSERT INTO movies(m_name, id_genre,   id_rating, id_runtime) VALUES ('Ukraine war 4', 1, 3, 4);
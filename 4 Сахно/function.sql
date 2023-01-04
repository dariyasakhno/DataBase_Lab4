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
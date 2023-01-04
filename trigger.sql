
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
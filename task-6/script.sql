--1. Создать функцию, которая по идентификатору пользователя ищет того,
-- кто написал пользователю наибольшее количество сообщений.
-- В результат нужно вывести идентификатор искомого пользователя.
DROP FUNCTION IF EXISTS user_messages_sent_most_to_user_id;
CREATE FUNCTION user_messages_sent_most_to_user_id(user_id INTEGER)
    RETURNS INTEGER AS
$$
SELECT from_user_id
FROM messages
WHERE to_user_id = user_id
GROUP BY from_user_id
ORDER BY count(*) DESC
LIMIT 1;
$$
    LANGUAGE SQL;

SELECT user_messages_sent_most_to_user_id(1);
/*
vk=# SELECT user_messages_sent_most_to_user_id(1);
 user_messages_sent_most_to_user_id
------------------------------------
                                  3
(1 row)
*/
-- 2. Создать процедуру, которая проверяет владельца фотографий,
-- которые указаны в качестве основных фотографий пользователей в таблице профилей.
-- Если пользователь в профилях не является владельцем своей основной фотографии,
-- тогда для него нужно записать NULL в столбце main_photo_id.
CREATE OR REPLACE PROCEDURE check_owner_main_photo()
    LANGUAGE plpgsql AS
$$
DECLARE
    real_owner RECORD;
BEGIN
    FOR real_owner IN
        SELECT profiles.user_id
        FROM profiles
                 JOIN photo
                      ON profiles.main_photo_id = photo.id
        WHERE photo.owner_id != profiles.user_id
        LOOP
            UPDATE profiles SET main_photo_id = NULL WHERE user_id = real_owner.user_id;
        END LOOP;
    COMMIT;
END;
$$;
CALL check_owner_main_photo();

--test
UPDATE profiles
SET main_photo_id = floor(1 + random() + 100);

SELECT *
FROM profiles
WHERE main_photo_id IS NOT NULL;

-- 3. Создать триггер на обновление для таблицы профилей,
-- который не разрешает внести в столбец main_photo_id идентификатор фотографии,
-- если данный пользователь не является ее владельцем.
-- Проверить работу триггера вставкой записей с корректными и некорректными значениями.
CREATE OR REPLACE FUNCTION update_profiles_main_photo_trigger()
    RETURNS TRIGGER AS
$$
DECLARE
    real_owner_id INTEGER;
BEGIN
    real_owner_id := (SELECT owner_id FROM photo WHERE id = NEW.main_photo_id);
    IF NEW.user_id != real_owner_id THEN
        RAISE EXCEPTION 'user with id % has no photo from id %', NEW.user_id, NEW.main_photo_id;
    END IF;
    RETURN NEW;
END;
$$
    LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_profiles_on_update on profiles;
CREATE TRIGGER check_profiles_on_update
    BEFORE UPDATE
    ON profiles
    FOR EACH ROW
EXECUTE FUNCTION update_profiles_main_photo_trigger();

SELECT id
FROM photo
WHERE owner_id = 12;

UPDATE profiles
SET main_photo_id = 15
WHERE user_id = 12; --OK

UPDATE profiles
SET main_photo_id = 12
WHERE user_id = 12; --ERROR

-- 4. Создать два представления для таблицы видео.
-- Одно представление должно быть неизменяемым, другое - изменяемым.
-- Проверить изменяемость второго представления.
CREATE OR REPLACE VIEW mutable_video_view AS
SELECT *
FROM video;

CREATE OR REPLACE VIEW immutable_video_view AS
SELECT *
FROM video
GROUP BY id
ORDER BY id;

UPDATE mutable_video_view SET description = 'check mutable_video_view'
WHERE id = 1;
UPDATE immutable_video_view SET description = 'check immutable_video_view'
WHERE id = 1; --ERROR: cannot update view "immutable_video_view"
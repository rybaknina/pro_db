-- 1. Работаем с базой данных vk. Найти, кому принадлежат 10 самых больших видеофайлов. В
-- отчёт вывести идентификатор видеофайла, имя владельца, фамилию владельца, URL
-- основной фотографии пользователя, URL видеофайла, размер видеофайла.

--Найти решение только на вложенных запросах
SELECT v.id                                                 as video_id,
       (SELECT first_name FROM users WHERE id = v.owner_id) AS owner_first_name,
       (SELECT last_name FROM users WHERE id = v.owner_id)  AS owner_last_name,
       (SELECT ph.url
        FROM photo ph
                 join users usr on usr.main_photo_id = ph.id
        where usr.id = v.owner_id)                          AS photo_url,
       v.url                                                AS video_url,
       v.size                                               AS video_size
FROM video v
ORDER BY v.size DESC
LIMIT 10;

--Найти решение с использованием временной таблицы
CREATE TEMPORARY TABLE big_video
(
    id       INT,
    url      VARCHAR(250),
    size     INT,
    owner_id INT
);
INSERT INTO big_video
SELECT id, url, size, owner_id
FROM video
ORDER BY size DESC
LIMIT 10;

SELECT big_video.id AS video_id,
       first_name   AS owner_first_name,
       last_name    AS owner_last_name,
       photo.url    AS photo_url,
       big_video.url   video_url,
       big_video.size  video_size
FROM users
         JOIN big_video
              ON big_video.owner_id = users.id
         JOIN photo ON photo.id = users.main_photo_id
ORDER BY video_size DESC;

--Найти решение с использованием общего табличного выражения
WITH big_video AS (
    SELECT id, url, size, owner_id
    FROM video
    ORDER BY size DESC
    LIMIT 10
)
SELECT big_video.id AS video_id,
       first_name   AS owner_first_name,
       last_name    AS owner_last_name,
       photo.url    AS photo_url,
       big_video.url   video_url,
       big_video.size  video_size
FROM users
         JOIN big_video
              ON big_video.owner_id = users.id
         JOIN photo ON photo.id = users.main_photo_id
ORDER BY video_size DESC;

--Найти решение с помощью объединения JOIN
SELECT video.id AS video_id,
       first_name   AS owner_first_name,
       last_name    AS owner_last_name,
       photo.url    AS photo_url,
       video.url   video_url,
       video.size  video_size
FROM users
         JOIN video
              ON video.owner_id = users.id
         JOIN photo ON photo.id = users.main_photo_id
ORDER BY video_size DESC
LIMIT 10;
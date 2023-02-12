--Создать в таблице фотографий столбец metadata типа JSON
ALTER TABLE photo
    ADD COLUMN metadata jsonb;

--Для сообщества с id = 3 поместить в ячейку members идентификаторы всех пользователей, являющихся членами данной группы.
UPDATE photo
SET metadata = jsonb_build_object(
        'id', id,
        'url', url,
        'size', size
    );
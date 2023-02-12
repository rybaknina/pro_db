--В таблице сообществ создать столбец members типа массив
ALTER TABLE communities ADD COLUMN members INT[];

--Для сообщества с id = 3 поместить в ячейку members идентификаторы всех пользователей, являющихся членами данной группы.
UPDATE communities c
SET members = (select ARRAY_AGG(user_id) from communities_users cu where c.id = cu.community_id)
where c.id = 3;
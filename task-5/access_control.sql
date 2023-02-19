--1. Создать роли для пользователей Федор Серов и Роман Белов.
CREATE ROLE serovf WITH LOGIN PASSWORD 'serovf';
CREATE ROLE belovr WITH LOGIN PASSWORD 'belovr';

-- Создать роли для групп аналитиков и тестировщиков.
CREATE ROLE testers;
CREATE ROLE analysts;

-- Поместить пользователя Федор Серов в группу аналитиков,
GRANT analysts TO serovf;

-- а пользователя Роман Белов в группу тестировщиков.
GRANT testers TO belovr;
/*
vk=# \du
                                    List of roles
 Role name |                         Attributes                         | Member of
-----------+------------------------------------------------------------+------------
 analysts  | Cannot login                                               | {}
 belovr    |                                                            | {testers}
 gb_user   |                                                            | {}
 postgres  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
 serovf    |                                                            | {analysts}
 testers   | Cannot login                                               | {}

*/
\c vk
-- Дать группе аналитиков право только на чтение данных в БД vk.
GRANT SELECT ON ALL TABLES IN SCHEMA public TO analysts;

-- Дать группе тестировщиков все права в БД vk.
GRANT ALL ON ALL TABLES IN SCHEMA public TO testers;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO testers;

-- Подключиться к БД vk под обоими пользователями и
-- проверить права выполнив простые операции SQL.
psql -h 127.0.0.1 -d vk -U belovr -W
UPDATE users
set first_name = 'Change by belovr'
where id = 1;
/*
vk=> UPDATE users
set first_name = 'Change by belovr'
where id = 1;
UPDATE 1
*/

psql -h 127.0.0.1 -d vk -U serovf -W
UPDATE users
set first_name = 'Change by serovf'
where id = 1;
/*
vk=> UPDATE users
set first_name = 'Change by serovf'
where id = 1;
ERROR:  permission denied for table users
*/

-- 2. Установить любое расширение PostgreSQL на ваш выбор.
CREATE EXTENSION "hstore";
SELECT *
FROM pg_extension
WHERE extname = 'hstore';
/*-[ RECORD 1 ]--+-------
oid            | 17088
extname        | hstore
extowner       | 10
extnamespace   | 2200
extrelocatable | t
extversion     | 1.8
extconfig      |
extcondition   |
*/
SELECT hstore(first_name, last_name)
FROM users;
/*
vk=> SELECT hstore(first_name, last_name)
FROM users limit 3;
       hstore
--------------------
 "Vera"=>"Graves"
 "Ethan"=>"Park"
 "Sasha"=>"Hickman"
*/

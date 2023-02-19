-- 3. Выполнить вертикальное разделение таблицы пользователей
-- на таблицу пользователей (users) и таблицу профилей (profiles).
-- В таблице пользователей оставить только столбцы идентификатора, имени, фамилии,
-- электронной почты и телефона.
-- Все остальные столбцы вместе с данными необходимо перенести в таблицу профилей.
CREATE TABLE profiles
(
    user_id       INT NOT NULL,
    main_photo_id INT,
    user_contacts contacts,
    created_at    TIMESTAMP,
    PRIMARY KEY (user_id)
);

ALTER TABLE profiles
    ADD CONSTRAINT profiles_user_id_fk
        FOREIGN KEY (user_id) REFERENCES users (id);
ALTER TABLE profiles
    ADD CONSTRAINT profiles_main_photo_id_fk
        FOREIGN KEY (main_photo_id) REFERENCES photo (id);

INSERT INTO profiles(user_id, main_photo_id, user_contacts, created_at)
SELECT id, main_photo_id, user_contacts, created_at
FROM users;

ALTER TABLE users
    DROP COLUMN main_photo_id,
    DROP COLUMN user_contacts,
    DROP COLUMN created_at;
/*
vk=> select * from profiles limit 3;
 user_id | main_photo_id |                     user_contacts                      |     created_at
---------+---------------+--------------------------------------------------------+---------------------
       2 |             4 | (1-247-716-8816,nec.quam@outlook.couk)                 | 2022-12-29 19:20:21
       3 |            15 | (1-655-811-2062,fermentum.convallis.ligula@icloud.net) | 2023-02-25 04:35:57
       4 |             6 | (428-4349,fermentum.risus.at@yahoo.org)                | 2023-01-02 01:50:20
(3 rows)

vk=> select * from users limit 3;
 id | first_name | last_name |                 email                 |     phone
----+------------+-----------+---------------------------------------+----------------
  2 | Vera       | Graves    | nec.quam@outlook.couk                 | 1-247-716-8816
  3 | Ethan      | Park      | fermentum.convallis.ligula@icloud.net | 1-655-811-2062
  4 | Sasha      | Hickman   | fermentum.risus.at@yahoo.org          | 428-4349
(3 rows)

*/

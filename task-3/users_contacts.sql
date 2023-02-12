--Создать пользовательский составной тип данных contacts c полями phone и email.
CREATE TYPE contacts AS (phone VARCHAR(15), email VARCHAR(120));

--В таблице пользователей добавить столбец user_contacts типа contacts.
ALTER TABLE users ADD column user_contacts contacts;

--Заполнить столбец значениями из соответствующих строк.
UPDATE users SET user_contacts.phone = users.phone,
                 user_contacts.email = users.email;

--Для пользователя с id = 12 изменить email в столбце user_contacts на test@somemail.ru.
UPDATE users SET user_contacts.email = 'test@somemail.ru' where id = 12;
-- Таблица пользователей
ALTER TABLE users
    ADD CONSTRAINT users_main_photo_id_fk
        FOREIGN KEY (main_photo_id)
            REFERENCES photo (id)
            ON DELETE SET NULL;

-- Таблица сообщений
ALTER TABLE messages
    ADD CONSTRAINT messages_from_user_id_fk
        FOREIGN KEY (from_user_id)
            REFERENCES users (id) ON DELETE CASCADE,
    ADD CONSTRAINT messages_to_user_id_fk
        FOREIGN KEY (to_user_id)
            REFERENCES users (id) ON DELETE CASCADE;

-- Таблица дружбы
ALTER TABLE friendship
    ADD CONSTRAINT friendship_requested_by_user_id_fk
        FOREIGN KEY (requested_by_user_id)
            REFERENCES users (id) ON DELETE CASCADE,
    ADD CONSTRAINT friendship_requested_to_user_id_fk
        FOREIGN KEY (requested_to_user_id)
            REFERENCES users (id) ON DELETE CASCADE,
    ADD CONSTRAINT friendship_status_id_fk
        FOREIGN KEY (status_id)
            REFERENCES friendship_statuses (id);

-- Таблица сообществ
ALTER TABLE communities
    ADD CONSTRAINT communities_creator_id_fk
        FOREIGN KEY (creator_id)
            REFERENCES users (id);

-- Таблица связи сообщества - пользователи
ALTER TABLE communities_users
    ADD CONSTRAINT communities_users_community_id_fk
        FOREIGN KEY (community_id)
            REFERENCES communities (id),
    ADD CONSTRAINT communities_users_user_id_fk
        FOREIGN KEY (user_id)
            REFERENCES users (id) ON DELETE CASCADE;

-- Таблица фотографий
ALTER TABLE photo
    ADD CONSTRAINT photo_owner_id_fk
        FOREIGN KEY (owner_id)
            REFERENCES users (id) ON DELETE CASCADE;

-- Таблица видео
ALTER TABLE video
    ADD CONSTRAINT video_owner_id_fk
        FOREIGN KEY (owner_id)
            REFERENCES users (id) ON DELETE CASCADE;

-- Таблица подписки
ALTER TABLE subscription
    ADD CONSTRAINT subscription_user_id_fk
        FOREIGN KEY (user_id)
            REFERENCES users (id) ON DELETE CASCADE,
    ADD CONSTRAINT subscription_type_id_fk
        FOREIGN KEY (type_id)
            REFERENCES subscription_types (id);

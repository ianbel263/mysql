-- ДЗ к 6 уроку

-- 1. Создать и заполнить таблицы лайков и постов.
USE vk;

CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type ENUM('messages', 'users', 'posts', 'media') NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TEMPORARY TABLE target_types (
  name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');

 INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    (SELECT name FROM target_types ORDER BY RAND() LIMIT 1),
    CURRENT_TIMESTAMP 
  FROM messages;

 SELECT * FROM likes LIMIT 10;

DROP TABLE IF EXISTS posts;

CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  is_public BOOLEAN DEFAULT TRUE,
  is_archived BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Далее с помощью сайта filldb.info создаем дамп фейковых данных для таблицы posts
-- файл fulldb11-05-2021 08-09.sql также выложен на гитхабе


-- Затем заполняем с помощью дампа фейковыми данными таблицу posts
-- mysql vk < fulldb11-05-2021\ 08-09.sql
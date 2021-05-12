-- ДЗ к 6 уроку

-- 4. Вывести для каждого пользователя количество созданных сообщений, постов, загруженных медиафайлов и поставленных лайков.


USE vk;

SELECT last_name, first_name,
(SELECT COUNT(*) FROM messages WHERE from_user_id = users.id GROUP BY from_user_id) AS messages_count,
(SELECT COUNT(*) FROM posts WHERE user_id = users.id GROUP BY user_id) AS posts_count,
(SELECT COUNT(*) FROM media WHERE user_id = users.id GROUP BY user_id) AS media_files_count,
(SELECT COUNT(*) FROM likes WHERE user_id = users.id GROUP BY user_id) AS likes_count
FROM users
ORDER BY last_name, first_name;

SELECT * FROM messages;

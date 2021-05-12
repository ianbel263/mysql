-- ДЗ к 6 уроку

-- 5. Подсчитать количество лайков которые получили 10 самых последних сообщений.


USE vk;

SELECT id, created_at, (
	SELECT COUNT(*) FROM likes l
	WHERE m.id = l.target_id 
	GROUP BY l.target_id, l.target_type 
	HAVING l.target_type LIKE 'messages'
) AS likes_total 
FROM messages m
ORDER BY created_at DESC LIMIT 10;


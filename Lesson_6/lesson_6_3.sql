-- ДЗ к 6 уроку

-- 3. Определить кто больше поставил лайков (всего) - мужчины или женщины?.

USE vk;


SELECT CONCAT('Всего лайков женщин: ', 
(
	SELECT COUNT(*) 
	FROM likes l 
	JOIN profiles p 
	WHERE l.user_id = p.user_id
	GROUP BY p.gender 
	HAVING p.gender = 'f'
), ' Всего лайков мужчин: ', 
(
	SELECT COUNT(*) 
	FROM likes l 
	JOIN profiles p 
	WHERE l.user_id = p.user_id
	GROUP BY p.gender 
	HAVING p.gender = 'm'
));

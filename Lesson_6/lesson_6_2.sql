-- ДЗ к 6 уроку

-- 2. Создать все необходимые внешние ключи и диаграмму отношений.

USE vk;

DESC cities;
ALTER TABLE cities 
	ADD CONSTRAINT cities_country_id_fk
		FOREIGN KEY (country_id) REFERENCES countries(id)
			ON DELETE SET NULL;
			
DESC communities_users;
ALTER TABLE communities_users 
	ADD CONSTRAINT communities_users_community_id_fk
		FOREIGN KEY (community_id) REFERENCES communities(id)
			ON DELETE CASCADE;

ALTER TABLE communities_users 
	ADD CONSTRAINT communities_users_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE;
	
DESC friendship;
ALTER TABLE friendship 
	ADD CONSTRAINT friendship_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE;
			
ALTER TABLE friendship 
	ADD CONSTRAINT friendship_friend_id_fk
		FOREIGN KEY (friend_id) REFERENCES users(id)
			ON DELETE CASCADE;
		
UPDATE friendship 
SET friendship_status_id = FLOOR(1 + RAND() * 3);
			
ALTER TABLE friendship 
	ADD CONSTRAINT friendship_friendship_status_id_fk
		FOREIGN KEY (friendship_status_id) REFERENCES friendship_statuses(id)
			ON DELETE CASCADE;
			
DESC likes;
ALTER TABLE likes MODIFY user_id INT UNSIGNED;

ALTER TABLE likes 
	ADD CONSTRAINT likes_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE SET NULL;

ALTER TABLE likes 
	ADD CONSTRAINT likes_message_id_fk
		FOREIGN KEY (target_id) REFERENCES messages(id)
			ON DELETE CASCADE;
				
ALTER TABLE likes 
	ADD CONSTRAINT likes_media_id_fk
		FOREIGN KEY (target_id) REFERENCES media(id)
			ON DELETE CASCADE;

ALTER TABLE likes 
	ADD CONSTRAINT likes_user_like_id_fk
		FOREIGN KEY (target_id) REFERENCES users(id)
			ON DELETE CASCADE;

ALTER TABLE likes 
	ADD CONSTRAINT likes_post_id_fk
		FOREIGN KEY (target_id) REFERENCES posts(id)
			ON DELETE CASCADE;
		
DESC media;

ALTER TABLE media 
	ADD CONSTRAINT media_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE;
		
ALTER TABLE media 
	ADD CONSTRAINT media_media_type_id_fk
		FOREIGN KEY (media_type_id) REFERENCES media_types(id)
			ON DELETE CASCADE;
		
DESC messages;
ALTER TABLE messages 
	ADD CONSTRAINT messages_from_user_id_fk
		FOREIGN KEY (from_user_id) REFERENCES users(id)
			ON DELETE CASCADE;

ALTER TABLE messages 
	ADD CONSTRAINT messages_to_user_id_fk
		FOREIGN KEY (to_user_id) REFERENCES users(id)
			ON DELETE CASCADE;
		
ALTER TABLE messages 
	ADD CONSTRAINT messages_media_id_fk
		FOREIGN KEY (media_id) REFERENCES media(id)
			ON DELETE CASCADE;

DESC posts;
ALTER TABLE posts 
	ADD CONSTRAINT posts_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE;
		
UPDATE posts 
SET community_id = FLOOR(1 + RAND() * 30);
		
ALTER TABLE posts 
	ADD CONSTRAINT posts_community_id_fk
		FOREIGN KEY (community_id) REFERENCES communities(id)
			ON DELETE CASCADE;
		

ALTER TABLE posts 
	ADD CONSTRAINT posts_media_id_fk
		FOREIGN KEY (media_id) REFERENCES media(id)
			ON DELETE CASCADE;
		
DESC profiles;
ALTER TABLE profiles 
	ADD CONSTRAINT profiles_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE;
		
ALTER TABLE profiles 
	ADD CONSTRAINT profiles_city_id_fk
		FOREIGN KEY (city_id) REFERENCES cities(id)
			ON DELETE SET NULL;
		

		







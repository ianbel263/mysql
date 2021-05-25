-- Обновление фейковых данных

DESC bonuses;
SELECT * FROM bonuses;

ALTER TABLE bonuses 
MODIFY COLUMN bonus_count INT UNSIGNED NOT NULL DEFAULT 0,
MODIFY COLUMN expired_at DATE;

UPDATE bonuses 
SET updated_at = NOW()
WHERE updated_at < created_at;

UPDATE bonuses 
SET expired_at = DATE_ADD(created_at, INTERVAL 100 DAY);

UPDATE bonuses 
SET bonus_count = RAND() * 100000;

UPDATE bonuses 
SET bonus_count = 0
WHERE id % 5 = 0;

-- --------------------------------

DESC brands;
SELECT * FROM brands ORDER BY id;

-- --------------------------------

DESC catalogs;
SELECT * FROM catalogs ORDER BY id;
TRUNCATE catalogs; 

INSERT INTO catalogs VALUES
	(NULL, 'Смартфоны и гаджеты', 'phones'),
	(NULL, 'Телевизоры, аудио, HI-FI', 'tv'),
	(NULL, 'Ноутбуки и компьютеры', 'pc'),
	(NULL, 'Техника для кухни', 'kitchen'),
	(NULL, 'Техника для дома', 'house'),
	(NULL, 'Игры и софт, развлечения', 'games'),
	(NULL, 'Красота и здоровье', 'beauty'),
	(NULL, 'Фото и видео', 'photo_video'),
	(NULL, 'Автоэлектроника', 'auto'),
	(NULL, 'Аксессуары', 'accessories'),
	(NULL, 'Premium', 'premium');
	
-- --------------------------------

DESC categories;
SELECT * FROM categories;

UPDATE categories 
SET catalog_id = FLOOR(RAND() * 11) + 1;

-- --------------------------------

DESC cities;
SELECT * FROM cities;

-- --------------------------------

DESC comments;
SELECT * FROM comments;

ALTER TABLE comments ADD COLUMN user_id INT UNSIGNED NOT NULL AFTER id;

UPDATE comments 
SET user_id = FLOOR(RAND() * 500 + 1);

-- --------------------------------

DESC discounts;
SELECT * FROM discounts;

ALTER TABLE discounts 
MODIFY COLUMN started_at DATE,
MODIFY COLUMN finished_at DATE;

UPDATE discounts 
SET updated_at = NOW()
WHERE updated_at < created_at;

UPDATE discounts 
SET started_at = DATE_ADD(created_at, INTERVAL 1 DAY); 

UPDATE discounts 
SET finished_at = DATE_ADD(started_at, INTERVAL 30 DAY); 

UPDATE discounts 
SET discount = FORMAT(RAND(), 1);

UPDATE discounts 
SET discount = 0.9
WHERE discount = 0 OR discount = 1;

-- --------------------------------

DESC likes;
SELECT * FROM likes;

-- --------------------------------

DESC orders;
SELECT * FROM orders;

UPDATE orders 
SET updated_at = NOW()
WHERE updated_at < created_at;

-- --------------------------------

DESC orders_products;
SELECT * FROM orders_products;

ALTER TABLE orders_products 
DROP COLUMN id;

ALTER TABLE orders_products 
ADD PRIMARY KEY (order_id, product_id) COMMENT 'Составной первичный ключ';

UPDATE orders_products 
SET order_id = RAND() * 100
WHERE product_id = 565;

UPDATE orders_products 
SET updated_at = NOW()
WHERE updated_at < created_at;

-- --------------------------------

DESC product_images;
SELECT * FROM product_images;

UPDATE product_images 
SET img_url = ROUND(RAND() * 80);

UPDATE product_images 
SET img_url = CONCAT(
	'/images/', 
	(SELECT name FROM brands ORDER BY RAND() LIMIT 1),
	'/',
	(SELECT name FROM brands ORDER BY RAND() LIMIT 1),
	'.jpg'
);

-- --------------------------------

DESC products;
SELECT * FROM products;

UPDATE products
SET updated_at = NOW()
WHERE updated_at < created_at;

UPDATE products
SET price = 1000
WHERE price = 0;

UPDATE products
SET updated_at = NOW()
WHERE updated_at < created_at;

ALTER TABLE products 
MODIFY COLUMN specifications JSON;

UPDATE products 
SET specifications = '{}';

-- --------------------------------

DESC users;
SELECT * FROM users;

-- --------------------------------

DESC profiles;
SELECT * FROM profiles;

UPDATE profiles 
SET updated_at = NOW()
WHERE updated_at < created_at;

-- --------------------------------

DESC promotions;
SELECT * FROM promotions;

ALTER TABLE promotions
MODIFY COLUMN started_at DATE,
MODIFY COLUMN finished_at DATE;

UPDATE promotions 
SET updated_at = NOW()
WHERE updated_at < created_at;

UPDATE promotions 
SET started_at = DATE_ADD(created_at, INTERVAL 1 DAY); 

UPDATE promotions 
SET finished_at = DATE_ADD(started_at, INTERVAL 30 DAY); 

UPDATE promotions 
SET discount = FORMAT(RAND(), 1);

UPDATE promotions 
SET discount = 0.9
WHERE discount = 0 OR discount = 1;

-- --------------------------------

DESC requests;
SELECT * FROM requests;

UPDATE requests 
SET updated_at = NOW()
WHERE updated_at < created_at;

-- --------------------------------

DESC reviews;
SELECT * FROM reviews;

UPDATE reviews 
SET updated_at = NOW()
WHERE updated_at < created_at;

-- --------------------------------

DESC shops;
SELECT * FROM shops;

UPDATE shops 
SET updated_at = NOW()
WHERE updated_at < created_at;

-- --------------------------------

DESC shops_products;
SELECT * FROM shops_products;

UPDATE shops_products 
SET updated_at = NOW()
WHERE updated_at < created_at;

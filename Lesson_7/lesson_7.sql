CREATE DATABASE shop
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

USE shop;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	phone INT UNSIGNED NOT NULL UNIQUE,
	pwd CHAR(128) NOT NULL,
	birthday_at DATE,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO
  users (first_name, last_name, email, phone, pwd, birthday_at)
VALUES
  ('Александр', 'Петров', 'test@test.com', (RAND() * 10000000), 'secret', '1980-01-04'),
  ('Андрей', 'Красин', 'test@test.com', (RAND() * 10000000), 'secret', '1983-06-06'),
  ('Ирина', 'Васильева', 'test@test.com', (RAND() * 10000000), 'secret', '1977-05-19'),
  ('Владимир', 'Ульянов', 'test@test.com', (RAND() * 10000000), 'secret', '1987-03-12'),
  ('Сергей', 'Гончаров', 'test@test.com', (RAND() * 10000000), 'secret', '1990-11-20'),
  ('Мария', 'Светлова', 'test@test.com', (RAND() * 10000000), 'secret', '2004-04-22'),
  ('Дарья', 'Иванова', 'test@test.com', (RAND() * 10000000), 'secret', '1993-05-29'),
  ('Наталья', 'Петренко', 'test@test.com', (RAND() * 10000000), 'secret', '1993-03-29'),
  ('Елена', 'Трифонова', 'test@test.com', (RAND() * 10000000), 'secret', '1993-08-28'),
  ('Степан', 'Ильин', 'test@test.com', (RAND() * 10000000), 'secret', '1978-06-12');

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs (name) VALUES
  ('Процессоры'),
  ('Материнские платы'),
  ('Видеокарты'),
  ('Жесткие диски'),
  ('Оперативная память');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  desсription TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

DESC products;

INSERT INTO products
  (name, desсription, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);
 
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO orders (user_id) VALUES
	(1 + RAND() * 10),
	(1 + RAND() * 10),
	(1 + RAND() * 10),
	(1 + RAND() * 10),
	(1 + RAND() * 10),
	(1 + RAND() * 10);

SELECT * FROM orders;

INSERT INTO orders_products (order_id, product_id, total)
SELECT 1, id, 2 FROM products
WHERE name = 'Intel Core i5-7400';

INSERT INTO orders_products (order_id, product_id, total)
SELECT 2, id, 1 FROM products
WHERE name IN ('Intel Core i5-7400', 'Gigabyte H310M S2H');

INSERT INTO orders_products (order_id, product_id, total)
SELECT 3, id, 1 FROM products
WHERE name IN ('AMD FX-8320', 'ASUS ROG MAXIMUS X HERO');

INSERT INTO orders_products (order_id, product_id, total)
SELECT 4, id, 5 FROM products
WHERE name = 'ASUS ROG MAXIMUS X HERO';

INSERT INTO orders_products (order_id, product_id, total)
SELECT 5, id, 2 FROM products
WHERE id = 7;

INSERT INTO orders_products (order_id, product_id, total)
SELECT 6, id, 3 FROM products
WHERE id IN (2, 6);

INSERT INTO orders_products (order_id, product_id, total)
SELECT 6, id, 1 FROM products
WHERE id = 5;

-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине

SELECT * FROM users;
SELECT * FROM orders;

SELECT CONCAT(last_name, ' ', first_name) AS user_name 
FROM users u
JOIN orders o 
ON u.id = o.user_id
GROUP BY user_name;

-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару

SELECT * FROM products;
SELECT * FROM catalogs;

SELECT p.name, p.desсription, p.price, c.name AS catalog_name
FROM products p 
JOIN catalogs c 
ON p.catalog_id = c.id;

-- 3. Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов

CREATE DATABASE test
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

USE test;

CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	from_city VARCHAR(64) NOT NULL,
	to_city VARCHAR(64) NOT NULL
);

CREATE TABLE cities (
	id SERIAL PRIMARY KEY,
	label VARCHAR(64) NOT NULL,
	name VARCHAR(64) NOT NULL
);

INSERT INTO flights (from_city, to_city) VALUES
	('moscow', 'omsk'),
	('novgorod', 'kazan'),
	('irkutsk', 'moscow'),
	('omsk', 'irkutsk'),
	('moscow', 'kazan');

INSERT INTO cities (label, name) VALUES
	('moscow', 'Москва'),
	('irkutsk', 'Иркутск'),
	('kazan', 'Казань'),
	('omsk', 'Омск'),
	('novgorod', 'Новгород');

SELECT f.id, c1.name AS from_city, c2.name AS to_city
FROM flights f
JOIN cities c1
ON f.from_city = c1.label
JOIN cities c2
ON f.to_city = c2.label
ORDER BY 1;

 
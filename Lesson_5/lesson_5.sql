-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

CREATE DATABASE lesson5
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

USE lesson5;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	phone INT UNSIGNED NOT NULL UNIQUE,
	pwd CHAR(128) NOT NULL,
	birthday_at TIMESTAMP,
	created_at TIMESTAMP,
	updated_at TIMESTAMP
);

INSERT INTO
  users (name, email, phone, pwd, birthday_at, created_at, updated_at)
VALUES
  ('Александр', 'test@test.com', (RAND() * 10000000), 'secret', '1980-01-04', NULL, NULL),
  ('Андрей', 'test@test.com', (RAND() * 10000000), 'secret', '1983-06-06', NULL, NULL),
  ('Ирина', 'test@test.com', (RAND() * 10000000), 'secret', '1977-05-19', NULL, NULL),
  ('Владимир', 'test@test.com', (RAND() * 10000000), 'secret', '1987-03-12', NULL, NULL),
  ('Сергей', 'test@test.com', (RAND() * 10000000), 'secret', '1990-11-20', NULL, NULL),
  ('Мария', 'test@test.com', (RAND() * 10000000), 'secret', '2004-04-22', NULL, NULL),
  ('Дарья', 'test@test.com', (RAND() * 10000000), 'secret', '1993-05-29', NULL, NULL),
  ('Степан', 'test@test.com', (RAND() * 10000000), 'secret', '1978-06-12', NULL, NULL);

SELECT * FROM users;

UPDATE users 
SET created_at = CURRENT_TIMESTAMP(),
	updated_at = CURRENT_TIMESTAMP();


-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR 
-- и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля 
-- к типу DATETIME, сохранив введённые ранее значения.

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL,
	phone INT UNSIGNED NOT NULL UNIQUE,
	pwd CHAR(128) NOT NULL,
	birthday_at TIMESTAMP,
	created_at VARCHAR(255),
	updated_at VARCHAR(255)
);

INSERT INTO
  users (name, email, phone, pwd, birthday_at, created_at, updated_at)
VALUES
  ('Александр', 'test@test.com', (RAND() * 10000000), 'secret', '1980-01-04', '12.05.2021 11:10', '12.05.2021 11:10'),
  ('Андрей', 'test@test.com', (RAND() * 10000000), 'secret', '1983-06-06', '12.05.2021 11:10', '12.05.2021 11:10'),
  ('Ирина', 'test@test.com', (RAND() * 10000000), 'secret', '1977-05-19', '12.05.2021 11:10', '12.05.2021 11:10'),
  ('Владимир', 'test@test.com', (RAND() * 10000000), 'secret', '1987-03-12', '12.05.2021 11:10', '12.05.2021 11:10'),
  ('Сергей', 'test@test.com', (RAND() * 10000000), 'secret', '1990-11-20', '12.05.2021 11:10', '12.05.2021 11:10'),
  ('Мария', 'test@test.com', (RAND() * 10000000), 'secret', '2004-04-22', '12.05.2021 11:10', '12.05.2021 11:10'),
  ('Дарья', 'test@test.com', (RAND() * 10000000), 'secret', '1993-05-29', '12.05.2021 11:10', '12.05.2021 11:10'),
  ('Степан', 'test@test.com', (RAND() * 10000000), 'secret', '1978-06-12', '12.05.2021 11:10', '12.05.2021 11:10');

SELECT * FROM users;

UPDATE
  users
SET
  created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
  updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');

ALTER TABLE
  users
CHANGE
  created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE
  users
CHANGE
  updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

DESC users;


-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, 
-- если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
-- чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, 
-- после всех записей.


DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED
);

INSERT INTO
  storehouses_products (storehouse_id, product_id, value)
VALUES
  (1, RAND() * 1000, 32),
  (1, RAND() * 1000, 2321),
  (1, RAND() * 1000, 0),
  (1, RAND() * 1000, 3120),
  (1, RAND() * 1000, 0),
  (1, RAND() * 1000, 0),
  (1, RAND() * 1000, 3230),
  (1, RAND() * 1000, 0),
  (1, RAND() * 1000, 231);
 
 SELECT * FROM storehouses_products
 ORDER BY value = 0, value;


-- 4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
-- Месяцы заданы в виде списка английских названий (may, august)

SELECT * FROM users;

UPDATE users 
SET birthday_at = '1983-08-03'
WHERE id = 2;

SELECT id, name, birthday_at  
FROM users
WHERE DATE_FORMAT(birthday_at, '%M') IN ('may', 'august');


-- 5. Из таблицы catalogs извлекаются записи при помощи запроса. 
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
	id SERIAL PRIMARY KEY,
	name VARCHAR(128) NOT NULL UNIQUE
);

INSERT INTO catalogs (name) VALUES
	('Материнские платы'),
	('Процессоры'),
	('Видеокарты'),
	('Оперативная память'),
	('Жесткие диски'),
	('Мониторы'),
	('Принтеры'),
	('Сканеры');

SELECT * FROM catalogs
WHERE
  id IN (5, 1, 2)
ORDER BY
  FIELD(id, 5, 1, 2);


 
-- 6. Подсчитайте средний возраст пользователей в таблице users
 SELECT
  FLOOR(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW()))) AS average_age
FROM
  users;

 
-- 7. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения

SELECT
  DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
  COUNT(*) AS total
FROM
  users
GROUP BY
  day
ORDER BY
  total DESC;

 
-- 8. Подсчитайте произведение чисел в столбце таблицы
  
 SELECT ROUND(EXP(SUM(LN(id)))) FROM catalogs;

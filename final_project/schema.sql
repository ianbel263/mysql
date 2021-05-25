-- БД интернет-магазина МВИДЕО
-- Решаемые задачи:
-- хранение данных о товарах, их категориях, количестве в конкретных магазинах сети в различных городах
-- хранение данных о покупателях, их заказах, сообщений, отзывов, бонусах
-- хранение данных о скидках покупателей, проводимых акциях
-- хранение данных об отзывах покупателей о товарах, комментариев и лайков отзывов, запросах в службу поддержки



DROP DATABASE IF EXISTS mvideo;
CREATE DATABASE mvideo
  DEFAULT CHARACTER SET utf8
  DEFAULT COLLATE utf8_general_ci;

USE mvideo;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  code VARCHAR(64) NOT NULL UNIQUE COMMENT 'Код раздела латиницей'
) COMMENT = 'Разделы интернет-магазина';


DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
	id SERIAL PRIMARY KEY,
	catalog_id INT UNSIGNED NOT NULL,
	name VARCHAR(255) NOT NULL UNIQUE,
	code VARCHAR(64) NOT NULL UNIQUE COMMENT 'Код категории латиницей'
) COMMENT = 'Категории товаров';


DROP TABLE IF EXISTS brands;
CREATE TABLE brands (
	id SERIAL PRIMARY KEY,
	name VARCHAR(128) NOT NULL UNIQUE
) COMMENT = 'Бренды товаров';



DROP TABLE IF EXISTS products;
CREATE TABLE products (
	id SERIAL PRIMARY KEY,
	category_id INT UNSIGNED NOT NULL,
	brand_id INT UNSIGNED NOT NULL,
	name VARCHAR(255) NOT NULL,
	price DECIMAL (11,2) NOT NULL,
	bonus_count SMALLINT UNSIGNED COMMENT 'Количество начисляемых бонусов при покупке',
	description TEXT COMMENT 'Описание товара',
	specifications JSON COMMENT 'Характеристики товара в JSON-формате',
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Товары интернет-магазина';


DROP TABLE IF EXISTS product_images;
CREATE TABLE product_images (
	id SERIAL PRIMARY KEY,
	product_id INT UNSIGNED NOT NULL,
	img_url VARCHAR(255) NOT NULL
) COMMENT = 'Фотографии товаров';


DROP TABLE IF EXISTS product_price_history;
CREATE TABLE product_price_history (
	id SERIAL PRIMARY KEY,
	product_id BIGINT UNSIGNED NOT NULL,
	old_price DECIMAL (11,2) NOT NULL,
	new_price DECIMAL (11,2) NOT NULL,
	changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (product_id) REFERENCES products(id)
) COMMENT = 'История цен на товары';


DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	phone_number VARCHAR(20) NOT NULL UNIQUE,
	pwd VARCHAR(20) NOT NULL COMMENT 'Пароль пользователя',
	first_name VARCHAR(64) NOT NULL,
	last_name VARCHAR(64) NOT NULL,
	patronymic VARCHAR(64)
) COMMENT = 'Покупатели интернет-магазина';


DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id INT UNSIGNED NOT NULL PRIMARY KEY,
	email VARCHAR(128) NOT NULL UNIQUE,
	additional_phone_number VARCHAR(20),
	gender ENUM('m', 'f') NOT NULL,
	birthday DATE NOT NULL,
	bonus_pin CHAR(4) COMMENT 'Пин-код для списания бонусов',
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Профили покупателей';


DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
	id SERIAL PRIMARY KEY,
	user_id INT UNSIGNED NOT NULL,
	product_id INT UNSIGNED NOT NULL,
	score ENUM('1', '2', '3', '4', '5') COMMENT 'Оценка',
	positive TEXT COMMENT 'Плюсы',
	negative TEXT COMMENT 'Минусы',
	body TEXT COMMENT 'Текст отзыва',
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Отзывы о товарах';


DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
	id SERIAL PRIMARY KEY,
	review_id INT UNSIGNED NOT NULL,
	body TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Комментарии пользователей к отзывам';


DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
	id SERIAL PRIMARY KEY,
	review_id INT UNSIGNED NOT NULL,
	is_negative BOOL DEFAULT FALSE NOT NULL
) COMMENT = 'Лайки отзывов';


DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Заказы пользователей';


DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  total SMALLINT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанного товара',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';


DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  finished_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Скидки покупателей';


DROP TABLE IF EXISTS promotions;
CREATE TABLE promotions (
  id SERIAL PRIMARY KEY,
  name VARCHAR(128) NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  finished_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT 'Акции интернет-магазина';

DROP TABLE IF EXISTS bonuses;
CREATE TABLE bonuses (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  bonus_count INT UNSIGNED DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  expired_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) COMMENT = 'Бонусы покупателей';


DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  id SERIAL PRIMARY KEY,
  name VARCHAR(128) NOT NULL UNIQUE
) COMMENT = 'Справочник городов';


DROP TABLE IF EXISTS shops;
CREATE TABLE shops (
  id SERIAL PRIMARY KEY,
  city_id INT UNSIGNED NOT NULL,
  name VARCHAR(255) NOT NULL,
  address TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Справочник розничных магазинов';


DROP TABLE IF EXISTS shops_products;
CREATE TABLE shops_products (
  id SERIAL PRIMARY KEY,
  shop_id INT UNSIGNED NOT NULL,
  product_id INT UNSIGNED NOT NULL,
  value INT UNSIGNED COMMENT 'Количество товара',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Наличие товара в розничных магазинах';


DROP TABLE IF EXISTS requests;
CREATE TABLE requests (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  order_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  answer TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запросы покупателей в службу поддержки';


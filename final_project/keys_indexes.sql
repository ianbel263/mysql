-- добавление внешних ключей и индексов


DESC bonuses;
ALTER TABLE bonuses MODIFY COLUMN user_id BIGINT UNSIGNED NOT NULL;

ALTER TABLE bonuses 
	ADD CONSTRAINT bonuses_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE;

-- ------------------------------------
		
DESC catalogs;
CREATE INDEX catalogs_name_idx ON catalogs(name);

-- ------------------------------------
	
DESC categories;
ALTER TABLE categories MODIFY COLUMN catalog_id BIGINT UNSIGNED NOT NULL;

ALTER TABLE categories 
  ADD CONSTRAINT categories_catalog_id_fk 
    FOREIGN KEY (catalog_id) REFERENCES catalogs(id)
      ON DELETE CASCADE;
     
CREATE INDEX categories_name_idx ON categories(name);
     
-- ------------------------------------

DESC comments;
ALTER TABLE comments 
	MODIFY COLUMN user_id BIGINT UNSIGNED NOT NULL,
	MODIFY COLUMN review_id BIGINT UNSIGNED NOT NULL,
	ADD CONSTRAINT comments_user_id_fk 
  	  FOREIGN KEY (user_id) REFERENCES users(id)
  	    ON DELETE CASCADE,
	ADD CONSTRAINT comments_review_id_fk 
   	  FOREIGN KEY (review_id) REFERENCES reviews(id)
   	   ON DELETE CASCADE;

-- ------------------------------------

DESC discounts;
ALTER TABLE discounts 
	MODIFY COLUMN user_id BIGINT UNSIGNED NOT NULL,
	MODIFY COLUMN product_id BIGINT UNSIGNED NOT NULL,
	ADD CONSTRAINT discounts_user_id_fk 
  	  FOREIGN KEY (user_id) REFERENCES users(id)
  	    ON DELETE CASCADE,
	ADD CONSTRAINT discounts_review_id_fk 
   	  FOREIGN KEY (product_id) REFERENCES products(id)
   	   ON DELETE CASCADE;

-- ------------------------------------

DESC likes;
ALTER TABLE likes 
	ADD COLUMN user_id BIGINT UNSIGNED AFTER id,
	MODIFY COLUMN review_id BIGINT UNSIGNED NOT NULL,
	ADD CONSTRAINT likes_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE SET NULL,
	ADD CONSTRAINT likes_review_id_fk
		FOREIGN KEY (review_id) REFERENCES reviews(id)
			ON DELETE CASCADE;
		
-- ------------------------------------

DESC orders;
ALTER TABLE orders 
	MODIFY COLUMN user_id BIGINT UNSIGNED,
	ADD CONSTRAINT orders_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE SET NULL;
		
-- ------------------------------------

DESC orders_products;
ALTER TABLE orders_products 
	MODIFY COLUMN order_id BIGINT UNSIGNED NOT NULL,
	ADD CONSTRAINT orders_products_order_id_fk
		FOREIGN KEY (order_id) REFERENCES orders(id)
			ON DELETE CASCADE;

ALTER TABLE orders_products 
	MODIFY COLUMN product_id BIGINT UNSIGNED NOT NULL,
	ADD CONSTRAINT orders_products_product_id_fk
		FOREIGN KEY (product_id) REFERENCES products(id)
			ON DELETE CASCADE;

-- ------------------------------------

DESC product_images;
ALTER TABLE product_images 
	MODIFY COLUMN product_id BIGINT UNSIGNED NOT NULL,
	ADD CONSTRAINT product_images_product_id_fk
		FOREIGN KEY (product_id) REFERENCES products(id)
			ON DELETE CASCADE;
		
-- ------------------------------------

DESC products;
ALTER TABLE products
	MODIFY COLUMN category_id BIGINT UNSIGNED,
	MODIFY COLUMN brand_id BIGINT UNSIGNED,
	ADD CONSTRAINT products_category_id_fk
		FOREIGN KEY (category_id) REFERENCES categories(id)
			ON DELETE SET NULL,
	ADD CONSTRAINT products_brand_id_fk
		FOREIGN KEY (brand_id) REFERENCES brands(id)
			ON DELETE SET NULL;
		
CREATE INDEX products_name_idx ON products(name);
CREATE INDEX products_price_idx ON products(price);

-- ------------------------------------

DESC profiles;
ALTER TABLE profiles 
	MODIFY COLUMN user_id BIGINT UNSIGNED NOT NULL,
	ADD CONSTRAINT profiles_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE CASCADE;
		
CREATE INDEX profiles_email_idx ON profiles(email);
		
-- ------------------------------------

DESC promotions;
ALTER TABLE promotions 
	MODIFY COLUMN product_id BIGINT UNSIGNED NOT NULL,
	ADD CONSTRAINT promotions_product_id_fk
		FOREIGN KEY (product_id) REFERENCES products(id)
			ON DELETE CASCADE;

-- ------------------------------------

DESC requests;
ALTER TABLE requests
	MODIFY COLUMN user_id BIGINT UNSIGNED,
	MODIFY COLUMN order_id BIGINT UNSIGNED NOT NULL,
	ADD CONSTRAINT requests_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE SET NULL,
	ADD CONSTRAINT requests_order_id_fk
		FOREIGN KEY (order_id) REFERENCES orders(id)
			ON DELETE CASCADE;
		
-- ------------------------------------

DESC reviews;
ALTER TABLE reviews
	MODIFY COLUMN user_id BIGINT UNSIGNED,
	MODIFY COLUMN product_id BIGINT UNSIGNED NOT NULL,
	ADD CONSTRAINT reviews_user_id_fk
		FOREIGN KEY (user_id) REFERENCES users(id)
			ON DELETE SET NULL,
	ADD CONSTRAINT reviews_product_id_fk
		FOREIGN KEY (product_id) REFERENCES products(id)
			ON DELETE CASCADE;
		
-- ------------------------------------

DESC shops;
ALTER TABLE shops 
	MODIFY COLUMN city_id BIGINT UNSIGNED NOT NULL,
	ADD CONSTRAINT shops_city_id_fk
		FOREIGN KEY (city_id) REFERENCES cities(id)
			ON DELETE CASCADE;
		
-- ------------------------------------

DESC shops_products;
ALTER TABLE shops_products 
	DROP COLUMN id,
	ADD PRIMARY KEY (shop_id, product_id),
	MODIFY COLUMN shop_id BIGINT UNSIGNED NOT NULL,
	MODIFY COLUMN product_id BIGINT UNSIGNED NOT NULL,
		ADD CONSTRAINT shops_products_shop_id_fk
		FOREIGN KEY (shop_id) REFERENCES shops(id)
			ON DELETE CASCADE,
		ADD CONSTRAINT shops_products_product_id_fk
		FOREIGN KEY (product_id) REFERENCES products(id)
			ON DELETE CASCADE;

-- ------------------------------------
		
DESC users;
CREATE INDEX users_first_name_last_name_idx ON users(first_name, last_name);





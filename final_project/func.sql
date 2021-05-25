-- Процедуры и триггеры



-- Получить все заказы за месяц-год

DELIMITER //

CREATE PROCEDURE get_orders (IN order_month INT, IN order_year INT)
BEGIN 
	SELECT * FROM orders WHERE MONTH(created_at) = order_month AND YEAR(created_at) = order_year;
END//

DELIMITER ;

CALL get_orders('03', '2019');



-- Добавить записи в таблицу истории цен на товары при обновлении цены товара


DELIMITER //

CREATE TRIGGER price_history AFTER UPDATE ON products 
FOR EACH ROW
BEGIN
	IF NEW.price != OLD.price THEN
		INSERT INTO product_price_history (product_id, old_price, new_price) 
			VALUES (OLD.id, OLD.price, NEW.price);
	END IF;
END//

DELIMITER ;


SELECT * FROM products;
SELECT * FROM product_price_history;

UPDATE products 
SET price = 999.98
WHERE id =3;

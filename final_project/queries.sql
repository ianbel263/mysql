-- запросы

-- получить все отзывы о товаре

SELECT p.id, p.name, r.positive, r.negative, r.body,
	COUNT(p.id) OVER(PARTITION BY p.id) AS reviews_total
FROM reviews r 
RIGHT JOIN products p 
ON p.id = r.product_id 
WHERE p.id = 282;


-- получить последние три заказа пользователя

SELECT u.id,
	CONCAT_WS(' ', last_name, first_name) 
FROM users u 
JOIN orders o 
ON u.id = o.user_id
WHERE u.id = 333
ORDER BY o.created_at DESC
LIMIT 3;


-- получить пользователей, которые не имеют заказов

SELECT u.id,
	CONCAT_WS(' ', last_name, first_name),
	o.id,
	p.created_at 
FROM users u 
LEFT JOIN orders o 
ON u.id = o.user_id
LEFT JOIN profiles p 
ON u.id = p.user_id 
WHERE o.id IS NULL
ORDER BY p.created_at DESC;

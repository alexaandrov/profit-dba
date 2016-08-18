-- Запрос, который выберет категории и
-- среднюю цену товаров в каждой категории,
-- при условии, что эта средняя цена менее
-- 1000 рублей (выбираем "бюджетные" категории товаров)
SELECT category.name as category,
       AVG(product.price) as avg_price
FROM category
INNER JOIN product
ON category_id = category.id
GROUP BY category.name
HAVING AVG(product.price) < 1000;

SELECT *
FROM category
INNER JOIN product
ON category_id = category.id;

INSERT INTO product
(ID, ARTICLE, NAME, PRICE, OLD_PRICE, IMAGE, COUNT, CATEGORY_ID, BRAND_ID)
VALUES
(product_seq.nextval, 'RDFFRE#D21', 'Pizza', 599.49, 320.89, 'img', 30, 1, 3);

-- Добавьте к таблице брендов класс бренда (A, B, C).
ALTER TABLE brand
ADD class CHAR(1);

UPDATE brand
SET class = 'A'
WHERE id = 1;

UPDATE brand
SET class = 'C'
WHERE id = 2;

UPDATE brand
SET class = 'B'
WHERE id = 3;

UPDATE brand
SET class = 'A'
WHERE id = 4;

SELECT * FROM brand;

SELECT * FROM category;

SELECT name,
       category_id,
       brand_id
FROM product;

-- Напишите запрос,
-- который для каждой категории и класса брендов,
-- представленных в категории выберет среднюю цену товаров.
SELECT category.name as category,
      brand.class as brand_class,
      AVG(product.price) as avg_price
FROM product
LEFT JOIN category
ON category.id = category_id
LEFT JOIN brand
ON brand.id = brand_id
GROUP BY category.name, brand.class
ORDER BY category;

-- Добавьте к своей базе данных таблицу заказов.
-- Простейший вариант - номер заказа, дата и время, ID товара.
CREATE TABLE "ORDER"(
  "ID" INT PRIMARY KEY,
  "ARTICLE" INT CHECK(article > 0) NOT NULL UNIQUE,
  "DATE" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE order_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

-- Напишите запрос, который выведет таблицу с полями:
-- "дата", "число заказов за дату", "сумма заказов за дату".
SELECT product.name,
       "ORDER"."DATE",
       COUNT(product.id),
       SUM(product.price)
FROM product, "ORDER"
WHERE TRUNC(product.delivery_date)= TO_DATE("ORDER"."DATE",'dd.mm.yyyy')
GROUP BY product.name, "ORDER"."DATE";
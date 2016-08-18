-- Создайте таблицу "История изменений товаров".
DROP TABLE IF EXISTS product_history;
CREATE TABLE product_history (
  id SERIAL,
  events ENUM('delete', 'change_price', 'create'),
  old_price BIGINT UNSIGNED DEFAULT NULL,
  new_price BIGINT UNSIGNED DEFAULT NULL,
  change_date TIMESTAMP NOT NULL
              DEFAULT CURRENT_TIMESTAMP
);

-- Создайте триггеры на таблицу товаров,
-- которые будут при создании товара,
-- изменении его цены или удалении заполнять
-- таблицу product_history
DELIMITER $$
DROP TRIGGER IF EXISTS before_insert_product;
CREATE TRIGGER before_insert_product
BEFORE INSERT ON product
FOR EACH ROW
BEGIN
  INSERT INTO product_history
  (events)
  VALUES
  ('create');
END
$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS before_delete_product;
CREATE TRIGGER before_delete_product
BEFORE DELETE ON product
FOR EACH ROW
BEGIN
  INSERT INTO product_history
  (events)
  VALUES
  ('delete');
END
$$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS before_update_product;
CREATE TRIGGER before_update_product
BEFORE UPDATE ON product
FOR EACH ROW
BEGIN
  INSERT INTO product_history
  (events, new_price)
  VALUES
  ('change_price', product.price);
END
$$
DELIMITER ;

INSERT INTO product
(article, name, price, old_price, image, count)
VALUES
('A4SDDSSWFDD', 'A5TECH', 499.99, 359.99, 'IMG/36', 7);

UPDATE product
SET
  price = 499.90 + 500, old_price = 499.90
WHERE id = 2;

DELETE FROM product
WHERE id = 5;
-- Creating table for products --
DROP TABLE IF EXISTS product;
CREATE TABLE product (
  id SERIAL,
  article VARCHAR(255) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(15, 2) UNSIGNED NOT NULL,
  old_price DECIMAL(10, 2) UNSIGNED DEFAULT NULL,
  image VARCHAR(255) DEFAULT NULL,
  delivery_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  count INTEGER NOT NULL,
  CONSTRAINT product_id_pk PRIMARY KEY (id)
);

-- Writing 1000 different products in the database --
DELIMITER //
CREATE PROCEDURE create_test_products ()
  BEGIN
    DECLARE i INT DEFAULT 1000;
    DECLARE price_incr FLOAT DEFAULT 0.79;
  WHILE i > 0 DO
    INSERT INTO product
    (article, name, price, old_price, image, count)
    VALUES
    (
      CONCAT('PSR', i),
      CONCAT('Product', i),
      price_incr,
      price_incr - 0.79,
      CONCAT('https:\/\/shop.ru/products/?id=', i),
      3 + i
    );

    SET i = i - 1;
    SET price_incr = price_incr + 0.79;
  END WHILE;
END;

-- Calling the procedure --
CALL create_test_products()//

-- Inserting the data to the database with 'TEST' word --
INSERT INTO product
(article, name, price, old_price, image, count)
VALUES
(
  'PR4212ME1',
  'productTEST',
  4500.90,
  9833.90,
  'https:\/\/shop.ru/products/?id=903',
  4
);

INSERT INTO product
(article, name, price, old_price, image, count)
VALUES
(
  'PR422DME1',
  'productTEST',
  4500.90,
  9833.90,
  'https:\/\/shop.ru/products/?id=903',
  4
);

INSERT INTO product
(article, name, price, old_price, image, count)
VALUES
(
  'PR42A2MEE1',
  'TestproductTEST',
  45001.90,
  983.90,
  'https:\/\/shop.ru/products/?id=903',
  4
);

-- Fetching data --
SELECT *
FROM product
ORDER BY delivery_date
LIMIT 10;

SELECT *
FROM product
ORDER BY price
LIMIT 10;

SELECT *
FROM product
WHERE name LIKE '%TEST%'
LIMIT 10;
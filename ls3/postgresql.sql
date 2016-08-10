-- Creating table for products --
DROP TABLE IF EXISTS "product";
CREATE TABLE product (
  id INTEGER,
  article VARCHAR(255) NOT NULL UNIQUE,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(15, 2) NOT NULL CHECK(price > 0),
  old_price DECIMAL(10, 2) DEFAULT NULL CHECK(old_price > 0),
  image VARCHAR(255) DEFAULT NULL,
  delivery_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  count INTEGER NOT NULL,
  CONSTRAINT product_id_pk PRIMARY KEY (id)
);

-- Creating a sequence for product id --
DROP SEQUENCE IF EXISTS product_id_seq;
CREATE SEQUENCE product_id_seq
INCREMENT 1
START 1
NO MAXVALUE;

-- Creating the function that writes 1000 different products in the database --
CREATE FUNCTION create_test_products() RETURNS VOID AS $$
DECLARE i INT := 0; price_incr DECIMAL(15, 2) := 1590; BEGIN
  LOOP
    i := i + 1;
    price_incr := price_incr + 0.79;

    IF (i <= 1000) THEN
      INSERT INTO product
      (id, article, name, price, old_price, image, count)
      VALUES
      (
        nextval('product_id_seq'),
        CONCAT('PR', currval('product_id_seq')),
        CONCAT('Product ', currval('product_id_seq')),
        price_incr,
        price_incr - 0.79,
        CONCAT('https://shop.ru/products/?id=', currval('product_id_seq')),
        4 + i
      );
    ELSE
      EXIT;
    END IF;
  END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Calling the function --
SELECT create_test_products();

-- Inserting the data to the database with 'TEST' word --
INSERT INTO product
(id, article, name, price, old_price, image, count)
VALUES
(
  nextval('product_id_seq'),
  'PR4212ME1',
  'productTEST',
  4500.90,
  9833.90,
  'https://shop.ru/products/?id=903',
  4
);

INSERT INTO product
(id, article, name, price, old_price, image, count)
VALUES
(
  nextval('product_id_seq'),
  'PR422DME1',
  'productTEST',
  4500.90,
  9833.90,
  'https://shop.ru/products/?id=903',
  4
);

INSERT INTO product
(id, article, name, price, old_price, image, count)
VALUES
(
  nextval('product_id_seq'),
  'PR42A2MEE1',
  'TestproductTEST',
  45001.90,
  983.90,
  'https://shop.ru/products/?id=903',
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
LIMIT 10;;
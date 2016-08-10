-- Creating table for products --
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
CREATE SEQUENCE product_id_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

-- Writting 1000 different products in the database --
DECLARE i NUMBER := 0; price_incr DECIMAL(15, 2) := 1590; BEGIN
  LOOP
    i := i + 1;
    price_incr := price_incr + 0.79;

    IF (i <= 1000) THEN
      INSERT INTO product
      (id, article, name, price, old_price, image, count)
      VALUES
      (
        product_id_seq.nextval,
        CONCAT('PR', product_id_seq.currval),
        CONCAT('Product ', product_id_seq.currval),
        price_incr,
        price_incr - 0.79,
        CONCAT('https://shop.ru/products/?id=', product_id_seq.currval),
        4 + i
      );
    ELSE
      EXIT;
    END IF;
  END LOOP;
END;

-- Inserting the data to the databaset with 'TEST' word --
INSERT INTO product
(id, article, name, price, old_price, image, count)
VALUES
(
  product_id_seq.nextval,
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
  product_id_seq.nextval,
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
  product_id_seq.nextval,
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
ORDER BY delivery_date;

SELECT *
FROM product
ORDER BY price;

SELECT *
FROM product
WHERE name LIKE '%TEST%';
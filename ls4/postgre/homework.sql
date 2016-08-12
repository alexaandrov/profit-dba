-- Creating table for products
DROP TABLE IF EXISTS product;
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

-- Creating additional tables for the product
DROP TABLE IF EXISTS category;
CREATE TABLE category (
  id INTEGER,
  name VARCHAR(100) UNIQUE,
  CONSTRAINT category_id_pk PRIMARY KEY (id)
);

DROP TABLE IF EXISTS brand;
CREATE TABLE brand (
  id INTEGER,
  name VARCHAR(100) UNIQUE,
  CONSTRAINT brand_id_pk PRIMARY KEY (id)
);

-- Creating a sequence for products
DROP SEQUENCE IF EXISTS product_seq;
CREATE SEQUENCE product_seq
INCREMENT 1
START 1
NO MAXVALUE;

-- Creating sequences for categories
DROP SEQUENCE IF EXISTS category_seq;
CREATE SEQUENCE category_seq
INCREMENT 1
START 1
NO MAXVALUE;

-- Creating sequnce for brands
DROP SEQUENCE IF EXISTS brand_seq;
CREATE SEQUENCE brand_seq
INCREMENT 1
START 1
NO MAXVALUE;

-- Adding additional fields for the dependent tables
ALTER TABLE product
ADD category_id INTEGER DEFAULT NULL;

ALTER TABLE product
ADD brand_id INTEGER DEFAULT NULL;

-- Adding foreign key for the dependent tables
ALTER TABLE product
ADD CONSTRAINT category
FOREIGN KEY (category_id)
REFERENCES category (id)
ON DELETE CASCADE;

ALTER TABLE product
ADD CONSTRAINT brand
FOREIGN KEY (brand_id)
REFERENCES brand (id)
ON DELETE CASCADE;

-- Inserting test data
INSERT INTO brand
(id, name)
VALUES
(nextval('brand_seq'), 'Oliver King');

INSERT INTO brand
(id, name)
VALUES
(nextval('brand_seq'), 'Risotto');

INSERT INTO brand
(id, name)
VALUES
(nextval('brand_seq'), 'K&B');

INSERT INTO brand
(id, name)
VALUES
(nextval('brand_seq'), 'BRW');

INSERT INTO category
(id, name)
VALUES
(nextval('category_seq'), 'Food');

INSERT INTO category
(id, name)
VALUES
(nextval('category_seq'), 'Shoes');

INSERT INTO category
(id, name)
VALUES
(nextval('category_seq'), 'Cars');

INSERT INTO product
(ID, ARTICLE, NAME, PRICE, OLD_PRICE, IMAGE, COUNT, BRAND_ID, CATEGORY_ID)
VALUES
(
  nextval('product_seq'),
  '48349FGHE',
  'Tomato',
  4.34,
  3.76,
  'http://img.com/?id=43',
  140,
  2,
  1
);

INSERT INTO product
(ID, ARTICLE, NAME, PRICE, OLD_PRICE, IMAGE, COUNT, BRAND_ID, CATEGORY_ID)
VALUES
(
  nextval('product_seq'),
  '8349FGHE',
  'Z-Rated',
  299.34,
  289.76,
  'http://img.com/?id=30',
  140,
  3,
  2
);

INSERT INTO product
(ID, ARTICLE, NAME, PRICE, IMAGE, COUNT, BRAND_ID, CATEGORY_ID)
VALUES
(
  nextval('product_seq'),
  '8349FGHESASC12',
  'X7',
  390922.34,
  'http://img.com/?id=921',
  3,
  1,
  3
);

INSERT INTO product
(ID, ARTICLE, NAME, PRICE, IMAGE, COUNT, BRAND_ID, CATEGORY_ID)
VALUES
(
  nextval('product_seq'),
  'KASJ2M7',
  'M7',
  390922.34,
  'http://img.com/?id=922',
  3,
  3,
  3
);

-- Selecting all products with category and brands
SELECT p.id,
       p.name,
       p.price,
       b.name as Brand,
       c.name as Category
FROM product p
LEFT OUTER JOIN brand b
ON b.id = p.brand_id
LEFT OUTER JOIN category c
ON c.id = p.category_id;

-- Selecting all products with brand when started with "R"
SELECT p.id,
       p.name,
       p.price,
       b.name as Brand,
       c.name as Category
FROM product p
LEFT OUTER JOIN brand b
ON b.id = p.brand_id
LEFT OUTER JOIN category c
ON c.id = p.category_id
WHERE b.name LIKE 'R%';

-- Selecting list of the category
-- and count of the products in the category
SELECT name,
       (SELECT count(p.id) FROM product p
        LEFT OUTER JOIN category c
        ON p.category_id = c.id
        WHERE c.name = category.name
        ) as "Product Count"
FROM category;
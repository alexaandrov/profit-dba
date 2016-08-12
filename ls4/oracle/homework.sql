-- Creating additional tables for the product
CREATE TABLE category (
  id INTEGER,
  name VARCHAR(100) UNIQUE,
  CONSTRAINT category_id_pk PRIMARY KEY (id)
);

CREATE TABLE brand (
  id INTEGER,
  name VARCHAR(100) UNIQUE,
  CONSTRAINT brand_id_pk PRIMARY KEY (id)
);

-- Creating sequences
CREATE SEQUENCE category_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

CREATE SEQUENCE brand_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE;

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
(brand_seq.nextval, 'Oliver King');

INSERT INTO brand
(id, name)
VALUES
(brand_seq.nextval, 'Risotto');

INSERT INTO brand
(id, name)
VALUES
(brand_seq.nextval, 'K&B');

INSERT INTO brand
(id, name)
VALUES
(brand_seq.nextval, 'BRW');

INSERT INTO category
(id, name)
VALUES
(category_seq.nextval, 'Food');

INSERT INTO category
(id, name)
VALUES
(category_seq.nextval, 'Shoes');

INSERT INTO category
(id, name)
VALUES
(category_seq.nextval, 'Cars');

INSERT INTO product
(ID, ARTICLE, NAME, PRICE, OLD_PRICE, IMAGE, COUNT, BRAND_ID, CATEGORY_ID)
VALUES
(
  product_seq.nextval,
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
  product_seq.nextval,
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
  product_seq.nextval,
  '8349FGHESASC12',
  'X7',
  390922.34,
  'http://img.com/?id=921',
  3,
  5,
  4
);

INSERT INTO product
(ID, ARTICLE, NAME, PRICE, IMAGE, COUNT, BRAND_ID, CATEGORY_ID)
VALUES
(
  product_seq.nextval,
  'KASJ2M7',
  'M7',
  390922.34,
  'http://img.com/?id=922',
  3,
  5,
  4
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
-- Deleting tables if exists
DROP TABLE IF EXISTS `product`;
DROP TABLE IF EXISTS `category`;
DROP TABLE IF EXISTS `brand`;

-- Creating additional tables for the product
CREATE TABLE `category` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) UNIQUE,
  CONSTRAINT category_id_pk PRIMARY KEY (id)
) ENGINE InnoDB;

CREATE TABLE `brand` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) UNIQUE,
  CONSTRAINT brand_id_pk PRIMARY KEY (id)
) ENGINE = InnoDB;

-- Creating table for products
CREATE TABLE `product` (
  `id` SERIAL,
  `article` VARCHAR(255) NOT NULL UNIQUE,
  `name` VARCHAR(255) NOT NULL,
  `price` DECIMAL(15, 2) UNSIGNED NOT NULL ,
  `old_price` DECIMAL(10, 2) UNSIGNED DEFAULT NULL,
  `image` VARCHAR(255) DEFAULT NULL,
  `delivery_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `count` INTEGER NOT NULL,
  `category_id` BIGINT NOT NULL,
  `brand_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`, `brand_id`, `category_id`),
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `category`(`id`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT `fk_product_brand`
    FOREIGN KEY (`brand_id`)
    REFERENCES `brand`(`id`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE = InnoDB;

-- Inserting test data
INSERT INTO brand
(name)
VALUES
('Oliver King');

INSERT INTO brand
(name)
VALUES
('Risotto');

INSERT INTO brand
(name)
VALUES
('K&B');

INSERT INTO brand
(name)
VALUES
('BRW');

INSERT INTO category
(name)
VALUES
('Food');

INSERT INTO category
(name)
VALUES
('Shoes');

INSERT INTO category
(name)
VALUES
('Cars');

INSERT INTO product
(ARTICLE, NAME, PRICE, OLD_PRICE, IMAGE, COUNT, BRAND_ID, CATEGORY_ID)
VALUES
(
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
(ARTICLE, NAME, PRICE, OLD_PRICE, IMAGE, COUNT, BRAND_ID, CATEGORY_ID)
VALUES
(
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
(ARTICLE, NAME, PRICE, IMAGE, COUNT, BRAND_ID, CATEGORY_ID)
VALUES
(
  '8349FGHESASC12',
  'X7',
  390922.34,
  'http://img.com/?id=921',
  3,
  1,
  3
);

INSERT INTO product
(ARTICLE, NAME, PRICE, IMAGE, COUNT, BRAND_ID, CATEGORY_ID)
VALUES
(
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
DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id BIGINT,
  name VARCHAR(255),
  code VARCHAR(255) NOT NULL,
  image VARCHAR(255),
  price DECIMAL(15, 2) NOT NULL,
  bring_date TIMESTAMP NOT NULL,
  count INT NOT NULL,
  CONSTRAINT product_id_pk PRIMARY KEY (id)
);

CREATE SEQUENCE product_seq
INCREMENT 1
START 1
NO MAXVALUE;

INSERT INTO products
(id, name, code, image, price, bring_date, count)
VALUES (
  nextval('product_seq'),
  'Kingston SSD',
  '847FE8320',
  'htttp://image/2',
  3499.90,
  current_timestamp,
  5
);

INSERT INTO products
(id, name, code, image, price, bring_date, count)
VALUES (
  nextval('product_seq'),
  'Scarlett',
  'JF84003212434',
  'htttp://image/3',
  1000,
  current_timestamp,
  15
);

INSERT INTO products
(id, name, code, image, price, bring_date, count)
VALUES (
  nextval('product_seq'),
  'Toshiba',
  'TJS93201',
  'htttp://image/5',
  11499,
  current_timestamp,
  25
);

INSERT INTO products
(id, name, code, image, price, bring_date, count)
VALUES (
  nextval('product_seq'),
  'Samsung SyncMaster 2243sn',
  'JJ329001AQ',
  'htttp://image/9',
  15999,
  current_timestamp,
  8
);

SELECT * FROM products;
CREATE TABLE products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  code TEXT NOT NULL,
  image TEXT,
  price REAL NOT NULL,
  bring_date TEXT NOT NULL,
  count INTEGER NOT NULL
);

INSERT INTO products
(name, code, image, price, bring_date, count)
VALUES (
  'Kingston SSD',
  '847FE8320',
  'htttp://image/2',
  3499.90,
  current_timestamp,
  5
);

INSERT INTO products
(name, code, image, price, bring_date, count)
VALUES (
  'Scarlett',
  'JF84003212434',
  'htttp://image/3',
  1000,
  current_timestamp,
  15
);

INSERT INTO products
(name, code, image, price, bring_date, count)
VALUES (
  'Toshiba',
  'TJS93201',
  'htttp://image/5',
  11499,
  current_timestamp,
  25
);

INSERT INTO products
(name, code, image, price, bring_date, count)
VALUES (
  'Samsung SyncMaster 2243sn',
  'JJ329001AQ',
  'htttp://image/9',
  15999,
  current_timestamp,
  8
);

SELECT * FROM products;
DROP TABLE IF EXISTS department;
CREATE TABLE department (
  id INTEGER,
  title VARCHAR(255),
  CONSTRAINT dep_id_pk PRIMARY KEY (id)
);

DROP TABLE IF EXISTS person;
CREATE TABLE person (
  id INTEGER,
  name VARCHAR(255),
  dep_id INTEGER NOT NULL,
  CONSTRAINT person_id_pk PRIMARY KEY (id)
);

ALTER TABLE person
ADD CONSTRAINT department
    FOREIGN KEY (dep_id)
    REFERENCES department (id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE;

CREATE SEQUENCE person_seq
INCREMENT 1
START 1
NO MAXVALUE;

CREATE SEQUENCE dep_seq
INCREMENT 1
START 1
NO MAXVALUE;

INSERT INTO department
(id, title)
VALUES
(nextval('dep_seq'), 'Москва');

INSERT INTO department
(id, title)
VALUES
(nextval('dep_seq'), 'Тверь');

INSERT INTO department
(id, title)
VALUES
(nextval('dep_seq'), 'Оренбург');

INSERT INTO person
  (id, name, dep_id)
VALUES
(
  nextval('person_seq'),
  'Петров',
  1
);

INSERT INTO person
  (id, name, dep_id)
VALUES
(
  nextval('person_seq'),
  'Лукъяшев',
  2
);

-- Testing that foreign key works
UPDATE department
SET id = 10
WHERE id = 1;

COMMIT;
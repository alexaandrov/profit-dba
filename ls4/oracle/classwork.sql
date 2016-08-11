DROP TABLE department;
CREATE TABLE department (
  id INTEGER,
  title VARCHAR(255),
  CONSTRAINT dep_id_pk PRIMARY KEY (id)
);

DROP TABLE person;
CREATE TABLE person (
  id INTEGER,
  name VARCHAR(255),
  department_id INTEGER NOT NULL,
  CONSTRAINT person_id_pk PRIMARY KEY (id),
  CONSTRAINT person_dep_fk
    FOREIGN KEY (department_id)
    REFERENCES department (id)
    ON DELETE CASCADE
);
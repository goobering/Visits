DROP TABLE visits;
DROP TABLE users;
DROP TABLE locations;

CREATE TABLE users (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE locations (
  id SERIAL8 PRIMARY KEY,
  category VARCHAR(255),
  name VARCHAR(255)
);

CREATE TABLE visits (
  id SERIAL8 PRIMARY KEY,
  user_id INT8 REFERENCES users(id) ON DELETE CASCADE,
  location_id INT8 REFERENCES locations(id) ON DELETE CASCADE,
  review VARCHAR(255)
);
DROP DATABASE IF EXISTS inventory;

CREATE DATABASE inventory;

\c inventory

CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  username VARCHAR(128),
  password_digest VARCHAR(256)
);

CREATE TABLE products(
  id SERIAL PRIMARY KEY,
  name VARCHAR(128),
  price integer,
  stock boolean,
  total integer
);

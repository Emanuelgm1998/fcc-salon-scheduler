DROP DATABASE IF EXISTS salon;
CREATE DATABASE salon;

\c salon

CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  phone VARCHAR(15) UNIQUE NOT NULL,
  name VARCHAR(50)
);

CREATE TABLE services (
  service_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE appointments (
  appointment_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  service_id INT REFERENCES services(service_id),
  time VARCHAR(50) NOT NULL
);

INSERT INTO services (name)
SELECT name FROM (VALUES
  ('Cut'),
  ('Color'),
  ('Wash')
) AS s(name)
WHERE NOT EXISTS (SELECT 1 FROM services);

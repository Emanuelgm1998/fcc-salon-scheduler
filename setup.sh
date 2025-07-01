#!/bin/bash

# Crear base de datos y tablas
psql -U postgres -c "DROP DATABASE IF EXISTS salon;"
psql -U postgres -c "CREATE DATABASE salon;"

psql -U postgres -d salon -c "
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  phone VARCHAR(15) UNIQUE NOT NULL,
  name VARCHAR(50)
);
"

psql -U postgres -d salon -c "
CREATE TABLE services (
  service_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);
"

psql -U postgres -d salon -c "
CREATE TABLE appointments (
  appointment_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id),
  service_id INT REFERENCES services(service_id),
  time VARCHAR(50) NOT NULL
);
"

psql -U postgres -d salon -c "
INSERT INTO services (name)
SELECT name FROM (VALUES
  ('Cut'),
  ('Color'),
  ('Wash')
) AS s(name)
WHERE NOT EXISTS (SELECT 1 FROM services);
"

echo "✅ Base de datos y tablas creadas con éxito."

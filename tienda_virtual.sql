-- tienda_virtual_simplificada.sql
-- Versión simplificada y normalizada (3FN) de la base de datos para Gestión de entregas y domicilios

CREATE DATABASE IF NOT EXISTS tienda_virtual_simplificada;
USE tienda_virtual_simplificada;

-- Clientes
CREATE TABLE Customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(50)
);

-- Direcciones
CREATE TABLE Addresses (
  address_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  city VARCHAR(100),
  street VARCHAR(150),
  reference TEXT,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Productos
CREATE TABLE Products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  price DECIMAL(10,2)
);

-- Pedidos
CREATE TABLE Orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  address_id INT,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  total DECIMAL(10,2),
  status VARCHAR(50) DEFAULT 'PENDIENTE',
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
  FOREIGN KEY (address_id) REFERENCES Addresses(address_id)
);

-- Detalle de pedidos
CREATE TABLE OrderItems (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  product_id INT,
  quantity INT,
  price DECIMAL(10,2),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Repartidores
CREATE TABLE Couriers (
  courier_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  phone VARCHAR(50)
);

-- Entregas
CREATE TABLE Deliveries (
  delivery_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT,
  courier_id INT,
  delivery_date DATETIME,
  status VARCHAR(50) DEFAULT 'EN CAMINO',
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (courier_id) REFERENCES Couriers(courier_id)
);

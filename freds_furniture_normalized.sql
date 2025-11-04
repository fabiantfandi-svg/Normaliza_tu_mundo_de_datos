-- freds_furniture_normalized.sql
-- Esquema normalizado a 3FN para el caso Fred's Furniture

SET @@foreign_key_checks = 0;

CREATE TABLE IF NOT EXISTS Customers (
  customer_id INT PRIMARY KEY,
  phone VARCHAR(50),
  email VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Orders (
  order_id INT PRIMARY KEY,
  order_date DATE,
  customer_id INT,
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE IF NOT EXISTS Products (
  product_id INT PRIMARY KEY,
  name VARCHAR(255),
  default_price DECIMAL(10,2)
);

CREATE TABLE IF NOT EXISTS OrderItems (
  order_item_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  unit_price DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_orderitems_order FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  CONSTRAINT fk_orderitems_product FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

SET @@foreign_key_checks = 1;

-- Población de tablas
INSERT INTO Customers (customer_id, phone, email)
SELECT DISTINCT customer_id, customer_phone, customer_email
FROM forniture_sales;

INSERT INTO Orders (order_id, order_date, customer_id)
SELECT DISTINCT order_id, order_date, customer_id
FROM forniture_sales;

INSERT INTO Products (product_id, name, default_price)
SELECT DISTINCT item_1_id, item_1_name, item_1_price FROM forniture_sales WHERE item_1_id IS NOT NULL
UNION
SELECT DISTINCT item_2_id, item_2_name, item_2_price FROM forniture_sales WHERE item_2_id IS NOT NULL
UNION
SELECT DISTINCT item_3_id, item_3_name, item_3_price FROM forniture_sales WHERE item_3_id IS NOT NULL;

INSERT INTO OrderItems (order_id, product_id, quantity, unit_price)
SELECT order_id, item_1_id, 1, item_1_price FROM forniture_sales WHERE item_1_id IS NOT NULL
UNION ALL
SELECT order_id, item_2_id, 1, item_2_price FROM forniture_sales WHERE item_2_id IS NOT NULL
UNION ALL
SELECT order_id, item_3_id, 1, item_3_price FROM forniture_sales WHERE item_3_id IS NOT NULL;

-- =====================================
-- CREATE DATABASE
-- =====================================
DROP DATABASE IF EXISTS db_orders;
CREATE DATABASE db_orders;
USE db_orders;


-- =====================================
-- CREATE TABLES
-- =====================================

-- Table customers
CREATE TABLE customers (
    id_customer INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Table products
CREATE TABLE products (
    id_product INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL
);

-- Table orders
CREATE TABLE orders (
    id_order INT AUTO_INCREMENT PRIMARY KEY,
    id_customer INT,
    id_product INT,
    quantity INT,
    order_date DATE,
    total DECIMAL(10,2),

    FOREIGN KEY (id_customer) REFERENCES customers(id_customer),
    FOREIGN KEY (id_product) REFERENCES products(id_product)
);


-- =====================================
-- INSERT DATA
-- =====================================

-- Customers
INSERT INTO customers (name) VALUES
('Ana'),
('Luis'),
('Carlos');

-- Products
INSERT INTO products (name, price, stock) VALUES
('Ratón', 10.00, 20),
('Teclado', 25.00, 15),
('Monitor', 120.00, 5),
('Portátil', 800.00, 3);

-- Initial orders
INSERT INTO orders (id_customer, id_product, quantity, order_date, total) VALUES
(1, 1, 2, CURDATE(), 20.00),
(2, 2, 1, CURDATE(), 25.00);


-- =====================================
-- CHECK QUERIES
-- =====================================

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

-- EXERCISES:

-- 1. Validate order quantity
DELIMITER //

CREATE TRIGGER validate_order_quantity BEFORE INSERT ON orders
    FOR EACH ROW
    BEGIN
        IF quantity <= 0 THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid quantity';
        END IF;

    END //

DELIMITER ;

-- 2. Check available stock
DELIMITER //

CREATE TRIGGER check_available_stock BEFORE INSERT ON orders
    FOR EACH ROW
    BEGIN
        DECLARE stock INT;
        SELECT stock INTO stock FROM products WHERE id_product = NEW.id_product;

        IF stock < NEW.quantity THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient stock';
        END IF;
    END //

DELIMITER ;

-- 3. Calculate total automatically
DELIMITER //

CREATE TRIGGER total_automatically BEFORE INSERT ON orders
    FOR EACH ROW
    BEGIN
        DECLARE total DECIMAL(10,2);

        SELECT price INTO total FROM products WHERE id_product = NEW.id_product;
        SET NEW.total = NEW.quantity * total;
    END //

DELIMITER ;
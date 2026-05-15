CREATE DATABASE bank_practice;
USE bank_practice;

CREATE TABLE accounts (
 id INT PRIMARY KEY AUTO_INCREMENT,
 name VARCHAR(50),
 balance DECIMAL(10,2)
);

CREATE TABLE transactions (
 id INT PRIMARY KEY AUTO_INCREMENT,
 origin VARCHAR(50),
 destination VARCHAR(50),
 amount DECIMAL(10,2),
 date DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO accounts (name, balance) VALUES
('Ana', 100.00),
('Luis', 50.00),
('Marta', 200.00);

-- Exercise 1. Initial state
SELECT * FROM accounts;

SELECT * FROM transactions;

-- Exercise 2. Correct transfer
START TRANSACTION;

UPDATE accounts
SET balance = balance - 30
WHERE name = 'Ana';

UPDATE accounts
SET balance = balance + 30
WHERE name = 'Luis';

INSERT INTO transactions (origin, destination, amount)
VALUES ('Ana', 'Luis', 30);

COMMIT;

-- Exercise 3. Cancel an operation
START TRANSACTION;


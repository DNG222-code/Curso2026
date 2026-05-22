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

UPDATE accounts
SET balance = balance - 70
WHERE name = 'Luis';

UPDATE accounts
SET balance = balance + 70
WHERE name = 'Ana';

INSERT INTO transactions (origin, destination, amount)
VALUES ('Luis', 'Ana', 70);

ROLLBACK;

SELECT * FROM accounts;
SELECT * FROM transactions;

-- Exercise 4. Insufficient balance error
SELECT balance FROM accounts
WHERE name = 'Luis';

START TRANSACTION;

UPDATE accounts
SET balance = balance - 500
WHERE name = 'Luis'
AND balance >= 500;

UPDATE accounts
SET balance = balance + 500
WHERE name = 'Ana';

COMMIT;

-- Exercise 5. Incomplete operation
START TRANSACTION;

UPDATE accounts
SET balance = balance - 20
WHERE name = 'Ana';

INSERT INTO transactions (origin, destination, amount)
VALUES ('Ana', 'Luis', 20);


SELECT * FROM accounts;
SELECT * FROM transactions;

ROLLBACK;

SELECT * FROM accounts;
SELECT * FROM transactions;

-- Exercise 6. Relation with ACID
START TRANSACTION;

UPDATE accounts
SET balance = balance - 40
WHERE name = 'Ana';

UPDATE accounts
SET balance = balance + 40
WHERE name = 'Marta';

COMMIT;

INSERT INTO transactions (origin, destination, amount)
VALUES ('Ana', 'Marta', 40);

-- Exercise 7. Prevent negative balances
ALTER TABLE accounts
ADD CONSTRAINT chk_positive_balance CHECK (balance >= 0);

START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE name = 'Luis';

UPDATE accounts
SET balance = balance + 1000
WHERE name = 'Ana';

INSERT INTO transactions (origin, destination, amount)
VALUES ('Luis', 'Ana', 1000);

COMMIT;

-- Exercise 8. Final challenge
START TRANSACTION;

UPDATE accounts
SET balance = balance - 60
WHERE name = 'Ana';

UPDATE accounts
SET balance = balance + 60
WHERE name = 'Luis';

ROLLBACK ;

INSERT INTO transactions (origin, destination, amount)
VALUES ('Ana', 'Luis', 60);

COMMIT;
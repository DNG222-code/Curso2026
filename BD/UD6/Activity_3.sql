CREATE DATABASE car_rental;

USE car_rental;

-- CUSTOMER TABLE
CREATE TABLE Customer (
  id_customer INT AUTO_INCREMENT,
  customer_code VARCHAR(20) NOT NULL,
  dni VARCHAR(15) NOT NULL,
  nombre VARCHAR(100) NOT NULL,
  direction VARCHAR(150),
  phone_number VARCHAR(20),
  id_avalista INT,

  PRIMARY KEY (id_customer),
  UNIQUE (customer_code),
  FOREIGN KEY (id_avalista) REFERENCES Customer(id_customer)
);

-- AGENCY TABLE
CREATE TABLE Agency (
  id_agency INT AUTO_INCREMENT,
  name_agency VARCHAR(100) NOT NULL,
  direction_agency VARCHAR(150),

  PRIMARY KEY (id_agency)
);

-- GARAGE TABLE
CREATE TABLE Garage (
  id_garage INT AUTO_INCREMENT,
  name_garage VARCHAR(100) NOT NULL,
  direction_garage VARCHAR(150),

  PRIMARY KEY (id_garage)
);

-- CAR TABLE
CREATE TABLE Car (
  id_coche INT AUTO_INCREMENT,
  license_plate VARCHAR(15) NOT NULL,
  brand VARCHAR(50),
  model VARCHAR(50),
  color VARCHAR(30),
  id_garage INT NOT NULL,

  PRIMARY KEY (id_coche),
  UNIQUE (license_plate),
  FOREIGN KEY (id_garage) REFERENCES Garage(id_garage)
);

-- RESERVATION TABLE
CREATE TABLE Reservation (
  id_reservation INT AUTO_INCREMENT,
  start_reservation DATE NOT NULL,
  end_reservation DATE NOT NULL,
  total_price DECIMAL(10,2) NOT NULL,
  car_delivered INT DEFAULT 0,
  id_customer INT NOT NULL,
  id_agency INT NOT NULL,

  PRIMARY KEY (id_reservation),
  FOREIGN KEY (id_customer) REFERENCES Customer(id_customer),
  FOREIGN KEY (id_agency) REFERENCES Agency(id_agency)
);

-- RESERVATION_CAR TABLE
CREATE TABLE Reservation_car (
  id_reservation INT NOT NULL,
  id_coche INT NOT NULL,
  rental_price DECIMAL(10,2) NOT NULL,
  liters_gasoline DECIMAL(5,2),
  car_delivered INT DEFAULT 0,

  PRIMARY KEY (id_reservation, id_coche),
  FOREIGN KEY (id_reservation) REFERENCES Reservation(id_reservation),
  FOREIGN KEY (id_coche) REFERENCES Car(id_coche)
);

-- INSERT's
INSERT INTO Customer (customer_code, dni, nombre, direction, phone_number, id_avalista)
VALUES
('C001', '12345678A', 'Alice Brown', 'Main Street 10', '600111111', NULL),
('C002', '23456789B', 'Bob Smith', 'Main Street 10', '600222222', 1),
('C003', '34567890C', 'Charlie Green', 'Oak Avenue 5', '611333333', NULL),
('C004', '45678901D', 'Diana White', 'Pine Road 8', '622444444', 1);


INSERT INTO Agency (name_agency, direction_agency)
VALUES
('Central Agency', 'Downtown'),
('Airport Agency', 'Airport Area');

INSERT INTO Garage (name_garage, direction_garage)
VALUES
('Central Garage', 'Garage Street 1'),
('Airport Garage', 'Airport Road 20');

INSERT INTO Car (license_plate, brand, model, color, id_garage)
VALUES
('1234ABC', 'Toyota', 'Corolla', 'White', 1),
('2345BCD', 'Ford', 'Focus', 'Blue', 1),
('3456CDE', 'Volkswagen', 'Golf', 'Black', 2),
('4567DEF', 'Seat', 'Ibiza', 'Red', 2),
('5678EFG', 'Peugeot', '208', 'Grey', 1);

INSERT INTO Reservation (start_reservation, end_reservation, total_price, car_delivered, id_customer, id_agency)
VALUES
('2026-01-10', '2026-01-15', 500.00, 1, 1, 1),
('2026-02-01', '2026-02-05', 300.00, 0, 2, 1),
('2026-03-10', '2026-03-12', 620.00, 1, 3, 2);

INSERT INTO Reservation_car (id_reservation, id_coche, rental_price, liters_gasoline)
VALUES
-- Reservation 1 (2 cars)
(1, 1, 250.00, 40.00),
(1, 2, 250.00, 35.00),

-- Reservation 2 (1 car)
(2, 3, 300.00, 50.00),

-- Reservation 3 (2 cars)
(3, 4, 320.00, 45.00),
(3, 5, 300.00, 42.00);

-- Queries

-- 1
SELECT r.id_reservation, r.start_reservation, r.end_reservation, r.total_price, r.car_delivered, c.nombre, a.name_agency
FROM Reservation r INNER JOIN Customer c ON r.id_customer = c.id_customer
INNER JOIN Agency a ON r.id_agency = a.id_agency
ORDER BY r.start_reservation DESC;

-- 2
SELECT r.id_reservation, r.start_reservation, r.total_price, c.nombre
FROM Reservation r 
INNER JOIN Customer c ON r.id_customer = c.id_customer
WHERE c.nombre LIKE '%Al%';

-- 8
SELECT a.name_agency, COUNT(r.total_price) AS 'total_revenue', COUNT(r.id_reservation) AS 'total_amount'
FROM Agency a
INNER JOIN Reservation r ON a.id_agency = r.id_agency
WHERE r.car_delivered IS NOT NULL
ORDER BY total_revenue, total_amount;

-- 9
SELECT r.id_reservation,
       cu.nombre,
       r.total_price,
       IF(r.car_delivered > 0, 'Delivered', 'Pending') AS delivery_status
FROM Reservation r
INNER JOIN Customer cu ON r.id_customer = cu.id_customer
INNER JOIN Reservation_car rc ON r.id_reservation = rc.id_reservation;
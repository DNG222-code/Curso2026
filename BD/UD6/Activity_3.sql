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



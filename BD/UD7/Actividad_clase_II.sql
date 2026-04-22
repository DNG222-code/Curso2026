CREATE DATABASE hotel_sp;
USE hotel_sp;

-- =========================
-- TABLAS
-- =========================

CREATE TABLE hotel (
    id_hotel INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL
);

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE reserva (
    id_reserva INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_hotel INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_hotel) REFERENCES hotel(id_hotel)
);

-- =========================
-- INSERTS HOTEL
-- =========================

INSERT INTO hotel (id_hotel, nombre, ciudad) VALUES
(1, 'Hotel Sol', 'Madrid'),
(2, 'Hotel Mar', 'Barcelona'),
(3, 'Hotel Sierra', 'Sevilla'),
(4, 'Hotel Luna', 'Valencia'),
(5, 'Hotel Bosque', 'Bilbao'); -- este hotel no tendrá reservas

-- =========================
-- INSERTS CLIENTE
-- =========================

INSERT INTO cliente (id_cliente, nombre) VALUES
(1, 'Ana'),
(2, 'Luis'),
(3, 'Marta'),
(4, 'Carlos'),
(5, 'Elena'),
(6, 'Pablo'); -- este cliente no tendrá reservas

-- =========================
-- INSERTS RESERVA
-- =========================

INSERT INTO reserva (id_reserva, id_cliente, id_hotel, precio) VALUES
(1, 1, 1, 120.00),
(2, 1, 2, 180.00),
(3, 1, 3, 90.00),

(4, 2, 1, 200.00),
(5, 2, 1, 150.00),

(6, 3, 2, 300.00),
(7, 3, 3, 250.00),
(8, 3, 4, 400.00),
(9, 3, 2, 100.00),

(10, 4, 4, 80.00),

(11, 5, 3, 500.00),
(12, 5, 3, 220.00),
(13, 5, 1, 130.00);
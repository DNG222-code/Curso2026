CREATE DATABASE tienda_menorca;

USE tienda_menorca;

CREATE TABLE cliente
(
    id_cliente INT PRIMARY KEY,
    dni VARCHAR(8),
    nombre VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    telefono INT
);

CREATE TABLE pedido
(
    id_pedido INT PRIMARY KEY,
    fecha_pedido DATE,
    importe_total DOUBLE,
    id_cliente INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE pago
(
    id_pago INT PRIMARY KEY,
    fecha_pago DATE,
    importe_pagado DOUBLE,
    id_pedido INT NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);


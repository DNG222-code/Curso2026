/* =========================================
   BASE DE DATOS
   ========================================= */
CREATE DATABASE tienda_menorca;
USE tienda_menorca;

/* =========================================
   TABLA: cliente
   ========================================= */
CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT,
    dni VARCHAR(9),
    nombre VARCHAR(80),
    email VARCHAR(120),
    telefono VARCHAR(15),
    PRIMARY KEY (id_cliente),
    UNIQUE (email)
);

/* =========================================
   TABLA: pedido
   ========================================= */
CREATE TABLE pedido (
    id_pedido INT AUTO_INCREMENT,
    fecha_pedido DATE,
    importe_total DECIMAL(10,2),
    id_cliente INT,
    PRIMARY KEY (id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

/* =========================================
   TABLA: pago
   (incluye metodo_pago para poder eliminarlo luego)
   ========================================= */
CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT,
    fecha_pago DATETIME ,
    importe_pagado DECIMAL(10,2) ,
    metodo_pago VARCHAR(30) ,
    id_pedido INT,
    PRIMARY KEY (id_pago),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

/* =========================================
   TABLA DE PRUEBA
   ========================================= */
CREATE TABLE cliente_prueba (
    id_cliente INT AUTO_INCREMENT,
    nombre VARCHAR(80),
    PRIMARY KEY (id_cliente)
);

/* =========================================
   DATOS DE EJEMPLO
   ========================================= */

/* CLIENTES */
INSERT INTO cliente (dni, nombre, email, telefono) VALUES
('11111111A', 'Laura Pons', 'laura.pons@gmail.com', '600111222'),
('22222222B', 'Miguel Serra', 'miguel.serra@HOTMAIL.com', '600222333'),
('33333333C', 'Ana Riera', 'ana.riera@gmail.com', '600333444'),
('44444444D', 'Joan Fuster', 'joan.fuster@hotmail.com', '600444555'),
('55555555E', 'Maria Vila', 'maria.vila@gmail.com', '600555666'),
('66666666F', 'Pau Costa', 'pau.costa@yahoo.es', '600666777'),
('77777777G', 'Nuria Roca', 'nuria.roca@gmail.com', '600777888'),
('88888888H', 'Toni Febrer', 'toni.febrer@hotmail.com', '600888999'),
('99999999J', 'Carme Pons', 'carme.pons@gmail.com', '600999000'),
('12121212K', 'Biel Mas', 'biel.mas@gmail.com', '601000111'),
('13131313L', 'Aina Torres', 'aina.torres@outlook.com', '601111222'),
('14141414M', 'Marc Coll', 'marc.coll@gmail.com', '601222333');

/* PEDIDOS */
INSERT INTO pedido (fecha_pedido, importe_total, id_cliente) VALUES
('2023-12-15', 15.00, 1),
('2024-01-10', 19.99, 2),
(NULL, 49.90, 3),
('2024-02-05', 120.00, 1),
('2024-03-01', NULL, 4),
('2024-01-20', 25.00, 1),
('2024-04-12', 75.50, 5),
('2024-05-30', 10.00, 6),
('2024-06-10', 200.00, 7),
('2024-07-01', 18.00, 8),
('2024-08-15', 55.00, 9),
('2024-09-01', 12.00, 10),
(NULL, 35.00, 11),
('2024-10-10', 5.00, 12);

/* PAGOS */
INSERT INTO pago (fecha_pago, importe_pagado, metodo_pago, id_pedido) VALUES
(NOW(), 20.00, 'tarjeta', 1),
(NOW(), 15.00, 'bizum', 1),
(NOW(), NULL, 'tarjeta', 2),
(NOW(), 50.00, 'efectivo', 4),
(NOW(), 10.00, 'tarjeta', 6),
(NOW(), 55.00, 'tarjeta', 11),
(NOW(), 12.00, 'bizum', 12);
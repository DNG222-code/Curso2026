USE tienda_menorca;

-- DDL
-- 1.
ALTER TABLE cliente
ADD CONSTRAINT uq_dni
UNIQUE (dni);

-- 2.
ALTER TABLE cliente
MODIFY telefono VARCHAR(20) NULL;

-- 3.
ALTER TABLE pedido
MODIFY id_cliente INT NOT NULL;

-- 4.
ALTER TABLE pago
DROP metodo_pago;

-- INSERTS

-- 5
INSERT INTO cliente
VALUES (1, 'Juan', 'Perez', '', '123456789');

-- 6
INSERT INTO pedido (id_pedido, fecha_pedido)
VALUES (2, NOW()),
       (3, '2024-01-10');

-- 7
INSERT INTO pago (id_pago, fecha_pago)
VALUES (4, NOW()),
       (5, NOW());

-- 8
INSERT INTO cliente (id_cliente, email)
VALUES (1, LOWER('@Gmail.Com'));

-- 9
INSERT INTO cliente (id_cliente, telefono)
VALUES (1, CONCAT('+34-', 600111222));

-- 10
INSERT INTO pedido (id_pedido, fecha_pedido, importe_total, id_cliente)
VALUES (6, NOW(), 1000, 1);

INSERT INTO pago (id_pago, fecha_pago, importe_pagado, metodo_pago, id_pedido)
VALUES (7, NOW(), 71000, 'Efectivo', LAST_INSERT_ID());

-- UPDATES

-- 11
UPDATE cliente
SET nombre = 'VIP'
WHERE id_cliente = 1;

-- 12
UPDATE cliente
SET email = LOWER('@HOtmail.com')
WHERE email IS NOT NULL;

-- 13
UPDATE pedido
SET importe_total = 0
WHERE importe_total IS NULL;

-- 14
UPDATE pedido
SET importe_total = importe_total + 10
WHERE importe_total < 20 OR fecha_pedido = '2024-01-01';

-- 15
UPDATE pedido
SET importe_total =
        IF (importe_total < 30 AND id_cliente = 1,
            30,
            IF (importe_total > 100 OR fecha_pedido = '2024-02-01', 100),
            importe_total
        );

-- DELETES

-- 16
DELETE FROM cliente
WHERE id_cliente = 4;

-- 17
DELETE FROM pago
WHERE importe_pagado IS NULL;

-- 18
DELETE FROM pedido
WHERE id_pedido > 10;

-- 19
DELETE FROM cliente
WHERE email LIKE '%hotmail.com';

-- 20
TRUNCATE TABLE cliente_prueba;

-- 21
DROP TABLE cliente_prueba;

-- BLOQUE E - SELECT

-- 22.
SELECT * FROM cliente;

-- 23.
SELECT nombre, email, telefono FROM cliente
WHERE telefono IS NULL;

-- 24.
SELECT nombre FROM cliente
WHERE nombre LIKE '% %';

-- 25.
SELECT nombre, email FROM cliente
WHERE email LIKE '%@gmail.com%';

-- 26.
SELECT * FROM pedido
WHERE id_pedido >= 3 AND pedido.id_pedido <= 7;

-- 27.
SELECT * FROM pedido
ORDER BY fecha_pedido DESC
LIMIT 5;

-- 28.
ALTER TABLE cliente
ADD COLUMN fecha_registro DATETIME;

-- 29.
SELECT nombre, fecha_registro FROM cliente
ORDER BY fecha_registro DESC
LIMIT 8;

-- 30.
SELECT id_pedido, fecha_pedido FROM pedido
WHERE LENGTH(fecha_pedido) = 10
AND fecha_pedido >= '2024-01-01';

-- 31.
SELECT id_pedido, fecha_pedido,
       IF (
           fecha_pedido IS NOT NULL,
           'Tiene fecha',
           'No tiene fecha',

           IF (
               fecha_pedido IS NULL,
               'INASIGNADO',
               'ASIGNADO'
           ) AS 'estado'
       )
FROM pedido;

-- 32.
SELECT
    id_cliente,
    nombre,
    email,
    telefono,
    IF (
        email IS NOT NULL AND email <> ''
            AND telefono IS NOT NULL AND telefono <> '',
        'COMPLETO',
        IF (
            email IS NOT NULL AND email <> ''
                OR telefono IS NOT NULL AND telefono <> '',
            'PARCIAL',
            'INCOMPLETO'
        )
    ) AS perfil_contacto
FROM cliente
ORDER BY perfil_contacto, nombre
LIMIT 10;

-- 33.
SELECT id_pedido, fecha_pedido, CURRENT_DATE, DATEDIFF(CURRENT_DATE, fecha_pedido) AS 'Dias trascuridos'
FROM pedido
WHERE fecha_pedido IS NOT NULL
ORDER BY fecha_pedido
LIMIT 1;
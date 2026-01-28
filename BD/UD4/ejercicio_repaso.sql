USE tienda_menorca;

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

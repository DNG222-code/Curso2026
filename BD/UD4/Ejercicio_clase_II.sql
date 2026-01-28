USE tienda_menorca;

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
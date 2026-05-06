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

-- =========================
-- CONSULTAS DE COMPROBACIÓN
-- =========================

SELECT * FROM hotel;
SELECT * FROM cliente;
SELECT * FROM reserva;





-- Ejercicio en clase

-- 1. bonus_cliente_while
-- Este procedimiento calcula un bonus para un cliente en función del número de reservas que ha realizado.
-- Crea un procedimiento llamado bonus_cliente_while que:
-- •	reciba el identificador de un cliente
-- •	devuelva un valor numérico como resultado
-- El procedimiento debe:
-- •	contar cuántas reservas tiene el cliente
-- •	recorrer ese número mediante un bucle
-- •	sumar 10 puntos por cada reserva


DELIMITER //

CREATE PROCEDURE bonus_cliente_while(
    IN p_id_cliente INT,     -- Parámetro de entrada: ID del cliente
    OUT p_bonus INT          -- Parámetro de salida: bonus total calculado
)
BEGIN
    -- Variables internas
    DECLARE v_total_reservas INT;      -- Número total de reservas del cliente
    DECLARE v_contador INT DEFAULT 1;  -- Contador para el bucle WHILE

    -- Obtener el número de reservas del cliente
    SELECT COUNT(*)
    INTO v_total_reservas
    FROM reserva
    WHERE id_cliente = p_id_cliente;

    -- Inicializar el bonus
    SET p_bonus = 0;

    -- Bucle WHILE: se ejecuta una vez por cada reserva
    WHILE v_contador <= v_total_reservas DO

            -- Sumar 10 puntos de bonus por cada reserva
            SET p_bonus = p_bonus + 10;

            -- Incrementar el contador
            SET v_contador = v_contador + 1;

        END WHILE;

END //

DELIMITER ;

-- Ejemplo de uso:
-- Inicializamos variable de salida
SET @bonus = 0;

-- Llamamos al procedimiento para el cliente con ID = 1
CALL bonus_cliente_while(1, @bonus);

-- Consultamos el resultado
SELECT @bonus;

-- 2. contar_reservas_cliente
-- Este procedimiento obtiene cuántas reservas ha realizado un cliente.
-- Crea un procedimiento llamado contar_reservas_cliente que:
-- •	reciba el identificador de un cliente
-- •	devuelva el número total de reservas realizadas por ese cliente

DELIMITER //

CREATE PROCEDURE contar_reservas_cliente(
    IN p_id_cliente INT,   -- Parámetro de entrada: ID del cliente
    OUT p_total INT        -- Parámetro de salida: número total de reservas
)
BEGIN
    -- Calcula el total de reservas del cliente
    SELECT COUNT(*)
    INTO p_total           -- Guardamos el resultado en la variable de salida
    FROM reserva
    WHERE id_cliente = p_id_cliente;  -- Filtramos por el cliente indicado
END //

DELIMITER ;

-- Ejemplo de uso

-- Inicializamos la variable donde se guardará el resultado
SET @total = 0;

-- Llamamos al procedimiento pasando el ID del cliente (ej: 1)
CALL contar_reservas_cliente(1, @total);

-- Mostramos el resultado obtenido
SELECT @total;

-- 3. total_gastado_cliente

-- Este procedimiento calcula el dinero total gastado por un cliente.
-- Crea un procedimiento llamado total_gastado_cliente que:
-- •	reciba el identificador de un cliente
-- •	devuelva el importe total de sus reservas
-- Importante:
-- •	si el cliente no tiene reservas, el resultado debe ser 0


DELIMITER //

CREATE PROCEDURE total_gastado_cliente(
    IN p_id_cliente INT,          -- Parámetro de entrada: ID del cliente
    OUT p_total DECIMAL(10,2)     -- Parámetro de salida: total gastado (con decimales)
)
BEGIN
    -- Sumamos el precio de todas las reservas del cliente
    -- IFNULL evita que el resultado sea NULL si no tiene reservas
    SELECT IFNULL(SUM(precio), 0)
    INTO p_total                 -- Guardamos el resultado en la variable de salida
    FROM reserva
    WHERE id_cliente = p_id_cliente;  -- Filtramos por el cliente indicado
END //

DELIMITER ;

-- Ejemplo de uso

-- Inicializamos la variable donde se guardará el resultado
SET @gasto = 0;

-- Llamamos al procedimiento para el cliente con ID = 1
CALL total_gastado_cliente(1, @gasto);

-- Mostramos el total gastado
SELECT @gasto;

-- 4. acumular_gasto_cliente
-- Este procedimiento acumula el gasto de un cliente en una variable.
-- Crea un procedimiento llamado acumular_gasto_cliente que:
-- •	reciba el identificador de un cliente
-- •	reciba un valor acumulado
-- •	devuelva el valor actualizado
-- El procedimiento debe:
-- •	calcular el gasto total del cliente
-- •	sumarlo al valor acumulado recibido

DELIMITER //

CREATE PROCEDURE acumular_gasto_cliente(
    IN p_id_cliente INT,           -- Parámetro de entrada: ID del cliente
    INOUT p_total DECIMAL(10,2)    -- Parámetro de entrada/salida: valor acumulado
)
BEGIN
    -- Variable interna para guardar el gasto del cliente
    DECLARE v_gasto DECIMAL(10,2);

    -- Calculamos el gasto total del cliente
    -- IFNULL evita NULL si no tiene reservas
    SELECT IFNULL(SUM(precio), 0)
    INTO v_gasto
    FROM reserva
    WHERE id_cliente = p_id_cliente;

    -- Sumamos el gasto del cliente al valor acumulado recibido
    SET p_total = p_total + v_gasto;

END //

DELIMITER ;

-- Ejemplo de uso

-- Inicializamos el acumulador
SET @total = 0;

-- Llamamos al procedimiento (se irá acumulando el gasto)
CALL acumular_gasto_cliente(1, @total);

-- Mostramos el resultado
SELECT @total;


-- 5. clientes_con_muchas_reservas
-- Este procedimiento cuenta los clientes con muchas reservas.
-- Crea un procedimiento llamado clientes_con_muchas_reservas que:
-- •	devuelva cuántos clientes han realizado más de 2 reservas

DELIMITER //

CREATE PROCEDURE clientes_con_muchas_reservas(
    OUT p_total INT    -- Parámetro de salida: número de clientes que cumplen la condición
)
BEGIN
    -- Contamos cuántos clientes tienen más de 2 reservas
    SELECT COUNT(*)
    INTO p_total
    FROM (
             -- Subconsulta: obtenemos clientes agrupados por ID
             SELECT id_cliente
             FROM reserva
             GROUP BY id_cliente

             -- Filtramos solo los clientes con más de 2 reservas
             HAVING COUNT(*) > 2
         ) AS sub;  -- Alias obligatorio para la subconsulta
END //

DELIMITER ;

-- Ejemplo de uso

-- Inicializamos variable de salida
SET @resultado = 0;

-- Llamamos al procedimiento
CALL clientes_con_muchas_reservas(@resultado);

-- Mostramos el resultado
SELECT @resultado;


-- 6. clientes_gastan_mas_media
-- Este procedimiento detecta clientes con gasto superior a la media.
-- Crea un procedimiento llamado clientes_gastan_mas_media que:
-- •	devuelva cuántos clientes tienen un gasto total superior al precio medio de todas las reservas


DELIMITER //

CREATE PROCEDURE clientes_gastan_mas_media(
    OUT p_total INT   -- Parámetro de salida: número de clientes que cumplen la condición
)
BEGIN
    -- Contamos los clientes cuyo gasto total supera la media global
    SELECT COUNT(*)
    INTO p_total
    FROM (
             -- Subconsulta: calculamos el gasto total por cliente
             SELECT id_cliente, SUM(precio) AS gasto_total
             FROM reserva
             GROUP BY id_cliente

             -- Filtramos clientes cuyo gasto total es mayor que la media de todas las reservas
             HAVING SUM(precio) > (
                 -- Subconsulta interna: calcula el precio medio de todas las reservas
                 SELECT AVG(precio)
                 FROM reserva
             )
         ) AS sub;  -- Alias obligatorio para la subconsulta
END //

DELIMITER ;

-- Ejemplo de uso

-- Inicializamos variable de salida
SET @resultado = 0;

-- Llamamos al procedimiento
CALL clientes_gastan_mas_media(@resultado);

-- Mostramos el resultado
SELECT @resultado;

-- 7. hoteles_distintos_cliente
-- Este procedimiento calcula en cuántos hoteles distintos ha reservado un cliente.
-- Crea un procedimiento llamado hoteles_distintos_cliente que:
-- •	reciba el identificador de un cliente
-- •	devuelva el número de hoteles diferentes en los que ha hecho reservas
-- Importante:
-- •	si no tiene reservas, debe devolver 0
-- •	solo se deben contar hoteles distintos


DELIMITER //

CREATE PROCEDURE hoteles_distintos_cliente(
    IN p_id_cliente INT,          -- Parámetro de entrada: ID del cliente
    OUT p_total_hoteles INT       -- Parámetro de salida: número de hoteles distintos
)
BEGIN
    -- Contamos los hoteles diferentes en los que ha reservado el cliente
    SELECT COALESCE(COUNT(DISTINCT id_hotel), 0)
    INTO p_total_hoteles
    FROM reserva
    WHERE id_cliente = p_id_cliente;  -- Filtramos por el cliente indicado

END //

DELIMITER ;

-- Ejemplo de uso

-- Inicializamos variable de salida
SET @hoteles = 0;

-- Llamamos al procedimiento
CALL hoteles_distintos_cliente(1, @hoteles);

-- Mostramos el resultado
SELECT @hoteles;


-- 8. bonus_cliente_loop_limitado

-- Este procedimiento calcula un bonus limitado según las primeras reservas.
-- Crea un procedimiento llamado bonus_cliente_loop_limitado que:
-- •	reciba el identificador de un cliente
-- •	devuelva un valor numérico
-- El procedimiento debe:
-- •	contar las reservas del cliente
-- •	recorrerlas con un bucle
-- •	aplicar estas reglas:
-- o	reserva 1 → +10 puntos
-- o	reserva 2 → +10 puntos
-- o	reserva 3 → +20 puntos
-- •	dejar de procesar reservas a partir de la tercera


DELIMITER //

CREATE PROCEDURE bonus_cliente_loop_limitado(
    IN p_id_cliente INT,   -- Parámetro de entrada: ID del cliente
    OUT p_bonus INT        -- Parámetro de salida: bonus calculado
)
BEGIN
    -- Variables internas
    DECLARE v_total_reservas INT;      -- Total de reservas del cliente
    DECLARE v_contador INT DEFAULT 1;  -- Contador del bucle

    -- Obtenemos el número de reservas del cliente
    SELECT COUNT(*)
    INTO v_total_reservas
    FROM reserva
    WHERE id_cliente = p_id_cliente;

    -- Inicializamos el bonus
    SET p_bonus = 0;

    -- Bucle LOOP con etiqueta (permite salir con LEAVE)
    bucle: LOOP

        -- Condición de salida:
        -- 1. Si ya no hay más reservas
        -- 2. Si ya hemos procesado 3 reservas
        IF v_contador > v_total_reservas OR v_contador > 3 THEN
            LEAVE bucle;
        END IF;

        -- Reglas de negocio:
        -- Reserva 1 y 2 → +10 puntos
        -- Reserva 3 → +20 puntos
        IF v_contador = 1 OR v_contador = 2 THEN
            SET p_bonus = p_bonus + 10;

        ELSEIF v_contador = 3 THEN
            SET p_bonus = p_bonus + 20;
        END IF;

        -- Incrementamos el contador
        SET v_contador = v_contador + 1;

    END LOOP;

END //

DELIMITER ;

-- Ejemplo de uso

-- Inicializamos variable
SET @bonus = 0;

-- Llamamos al procedimiento
CALL bonus_cliente_loop_limitado(3, @bonus);

-- Mostramos el resultado
SELECT @bonus;


-- 9. bonus_cliente_iterate
-- Este procedimiento calcula un bonus considerando solo algunas reservas.
-- Crea un procedimiento llamado bonus_cliente_iterate que:
-- •	reciba el identificador de un cliente
-- •	devuelva un valor numérico
-- El procedimiento debe:
-- •	recorrer las reservas del cliente
-- •	sumar 10 puntos solo en las reservas pares (2, 4, 6, …)
-- •	ignorar las reservas impares

DELIMITER //

CREATE PROCEDURE bonus_cliente_iterate(
    IN p_id_cliente INT,   -- Parámetro de entrada: ID del cliente
    OUT p_bonus INT        -- Parámetro de salida: bonus calculado
)
BEGIN
    -- Variables internas
    DECLARE v_total_reservas INT;      -- Total de reservas del cliente
    DECLARE v_contador INT DEFAULT 0;  -- Contador del bucle

    -- Obtenemos el número de reservas del cliente
    SELECT COUNT(*)
    INTO v_total_reservas
    FROM reserva
    WHERE id_cliente = p_id_cliente;

    -- Inicializamos el bonus
    SET p_bonus = 0;

    -- Bucle WHILE con etiqueta (necesaria para usar ITERATE)
    bucle: WHILE v_contador < v_total_reservas DO

            -- Incrementamos el contador (simula recorrer reservas)
            SET v_contador = v_contador + 1;

            -- Si la reserva es impar, saltamos a la siguiente iteración
            IF MOD(v_contador, 2) <> 0 THEN
                ITERATE bucle;  -- equivalente a "continue"
            END IF;

            -- Solo se ejecuta en reservas pares → sumamos bonus
            SET p_bonus = p_bonus + 10;

        END WHILE;

END //

DELIMITER ;

-- Ejemplo de uso

SET @bonus = 0;
CALL bonus_cliente_iterate(3, @bonus);
SELECT @bonus;


-- 10. gasto_hotel_join_nulos

-- Este procedimiento calcula el dinero generado por un hotel.
-- Crea un procedimiento llamado gasto_hotel_join_nulos que:
-- •	reciba el identificador de un hotel
-- •	devuelva el total de dinero generado por sus reservas
-- El procedimiento debe:
-- •	calcular la suma de los precios de las reservas de ese hotel
-- •	tener en cuenta que puede haber hoteles sin reservas
-- •	en ese caso, debe devolver 0


DELIMITER //

CREATE PROCEDURE gasto_hotel_join_nulos(
    IN p_id_hotel INT,          -- Parámetro de entrada: ID del hotel
    OUT p_total DECIMAL(10,2)   -- Parámetro de salida: total generado (dinero)
)
BEGIN
    -- Sumamos el precio de todas las reservas del hotel
    -- LEFT JOIN permite incluir hoteles sin reservas
    -- COALESCE evita NULL y devuelve 0 en ese caso
    SELECT COALESCE(SUM(r.precio), 0)
    INTO p_total
    FROM hotel h
             LEFT JOIN reserva r
                       ON h.id_hotel = r.id_hotel   -- Relación entre hotel y reservas
    WHERE h.id_hotel = p_id_hotel;   -- Filtramos el hotel indicado

END //

DELIMITER ;

-- Ejemplo de uso

-- Inicializamos variable
SET @total = 0;

-- Llamamos al procedimiento
CALL gasto_hotel_join_nulos(1, @total);

-- Mostramos el resultado
SELECT @total;
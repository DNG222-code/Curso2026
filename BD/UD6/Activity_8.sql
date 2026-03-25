-- 1
SELECT *
FROM Reservation
WHERE total_price < (
    SELECT MAX(total_price)
    FROM Reservation
    WHERE id_customer = 1
);

-- 3
SELECT *
FROM Agency a
WHERE a.id_agency IN (
    SELECT r.id_agency
    FROM Reservation r
    WHERE r.total_price > (
        SELECT MIN(total_price)
        FROM Reservation
    )
);

-- 4
SELECT *
FROM Customer
WHERE id_customer IN (
    SELECT r.id_customer
    FROM Reservation r
    WHERE r.id_agency IN (
        SELECT a.id_agency
        FROM Agency a
        WHERE a.name_agency LIKE '%Central%'
    )
);

-- 5
SELECT *
FROM Car c
WHERE NOT EXISTS (
    SELECT 1
    FROM Reservation_car rc
    WHERE rc.id_coche = c.id_coche
);

-- 6
SELECT *
FROM Reservation
WHERE total_price > ANY (
    SELECT total_price
    FROM Reservation
    WHERE id_customer = 2
);

-- 7
SELECT *
FROM Reservation
WHERE total_price > ALL (
    SELECT total_price
    FROM Reservation
    WHERE id_customer = 2
);

-- 8
SELECT *
FROM Garage g
WHERE NOT EXISTS (
    SELECT id_garage
    FROM Car c
    WHERE c.id_garage = g.id_garage
);
USE car_rental;

-- 1

-- SUBQUERY
SELECT *
FROM Agency a
WHERE EXISTS (
    SELECT a.id_agency
    FROM Reservation r
    WHERE a.id_agency = r.id_agency
);

-- INNER JOIN
SELECT * FROM Agency a
INNER JOIN Reservation r ON a.id_agency = r.id_agency;

-- 2

-- SUBQUERY
SELECT * FROM Customer c
WHERE EXISTS (
    SELECT c.id_customer
    FROM Reservation r
    WHERE r.id_customer = c.id_customer
      AND r.car_delivered = 'delivered'
);

-- INNER JOIN
SELECT * FROM Customer c
INNER JOIN Reservation r ON c.id_customer = r.id_customer
WHERE r.car_delivered = 'delivered';

-- 3

-- SUBQUERY
SELECT * FROM Customer c
WHERE NOT EXISTS(
    SELECT c.id_customer
    FROM Reservation r
    WHERE c.id_customer = r.id_customer
);

-- INNER JOIN
SELECT * FROM Customer c
LEFT JOIN Reservation r ON c.id_customer = r.id_customer
WHERE r.id_reservation IS NULL;

-- 4

-- SUBQUERY
SELECT * FROM Customer c
WHERE EXISTS(
    SELECT c.id_customer
    FROM Reservation r
    WHERE c.id_customer = r.id_customer
      AND r.total_price > 500
);

-- JOIN
SELECT * FROM Customer c
JOIN Reservation r ON c.id_customer = r.id_customer
WHERE r.total_price > 500;

-- 5

-- SUBQUERY
SELECT * FROM Garage g
WHERE EXISTS(
    SELECT g.id_garage
    FROM Car c
    WHERE c.id_garage = g.id_garage
);

-- JOIN
SELECT * FROM Garage g
JOIN Car c ON g.id_garage = c.id_garage;
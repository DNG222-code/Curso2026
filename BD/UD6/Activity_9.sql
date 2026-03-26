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
    FROM
)
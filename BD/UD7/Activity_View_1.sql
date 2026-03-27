-- 1
CREATE VIEW customer_reservations_view AS
    SELECT r.id_reservation, r.start_reservation, r.end_reservation,
           r.total_price, c.nombre
    FROM Reservation r
    INNER JOIN Customer c ON r.id_customer = c.id_customer;

-- 1.1
SELECT * FROM customer_reservations_view;

-- 1.2
SELECT crv.total_price
FROM customer_reservations_view crv
ORDER BY crv.total_price DESC;

-- 1.3
SELECT crv.id_reservation, crv.total_price
FROM customer_reservations_view crv
WHERE crv.total_price > 300;

-- 2
CREATE VIEW complete_reservations_view AS
    SELECT r.id_reservation, c.nombre,
           a.name_agency, r.total_price
    FROM Reservation r
    INNER JOIN Customer c ON r.id_customer = c.id_customer
    INNER JOIN Agency a ON r.id_agency = a.id_agency;

-- 2.1
SELECT crv.name_agency
FROM complete_reservations_view crv
WHERE crv.name_agency = 'Centro';

-- 2.2
SELECT crv.nombre
FROM complete_reservations_view crv
ORDER BY crv.nombre;

-- 2.3
SELECT crv.id_reservation, crv.total_price
FROM complete_reservations_view crv
WHERE crv.total_price BETWEEN 100 AND 400;

-- 3
-- complete_reservation_view.

-- 3.1
SELECT crv.nombre
FROM complete_reservations_view crv
WHERE crv.nombre LIKE 'A%';

-- 3.2
SELECT crv.id_reservation, crv.total_price, crv.name_agency
FROM complete_reservations_view crv
WHERE crv.total_price > 200 AND crv.name_agency = 'Norte';

-- 3.3
SELECT crv.id_reservation, crv.name_agency, crv.total_price
FROM complete_reservations_view crv
WHERE crv.name_agency = 'Sur' OR crv.total_price > 500;

-- 4
CREATE VIEW customer_total_view AS
    SELECT c.nombre, SUM(r.total_price) AS 'total_spent',
           COUNT(r.id_reservation) AS 'number_of_reservations'
    FROM Customer c
    INNER JOIN Reservation r ON c.id_customer = r.id_customer;

-- 4.1
SELECT nombre FROM customer_total_view;

-- 4.2
SELECT ctv.total_spent
FROM customer_total_view ctv
ORDER BY ctv.total_spent DESC;

-- 4.3
SELECT ctv.nombre, ctv.number_of_reservations
FROM customer_total_view ctv
WHERE ctv.number_of_reservations > 2;

-- 4.4
SELECT ctv.nombre, ctv.total_spent
FROM customer_total_view ctv
WHERE ctv.total_spent > 600;

-- 5
CREATE VIEW agency_summary_view AS
    SELECT a.name_agency, SUM(r.total_price) AS 'total_income',
           AVG(r.total_price) AS 'average_reservation'
    FROM Agency a
    INNER JOIN Reservation r ON a.id_agency = r.id_agency;

-- 5.1
SELECT asv.total_income
FROM agency_summary_view asv
ORDER BY asv.total_income;

-- 5.2
SELECT asv.name_agency, asv.total_income
FROM agency_summary_view asv
WHERE asv.total_income > 1000;

-- 6
SELECT ctv.nombre, ctv.total_spent, crv.start_reservation
FROM customer_total_view ctv
INNER JOIN customer_reservations_view crv ON ctv.nombre = crv.nombre
WHERE ctv.total_spent > 500;

-- 7
-- customer_total_view
-- customer_reservations_view

-- 7.1
SELECT ctv.nombre, MAX(ctv.total_spent) AS 'most_spent'
FROM customer_total_view ctv
GROUP BY ctv.nombre;

-- 7.2
SELECT crv.id_reservation,  MAX(crv.total_price) AS 'most_expensive'
FROM customer_reservations_view crv
GROUP BY crv.id_reservation;

-- 8
CREATE OR REPLACE VIEW customer_reservations_view AS
    SELECT r.id_reservation, r.start_reservation, r.end_reservation,
           r.total_price, c.nombre, a.name_agency
    FROM Reservation r
    INNER JOIN Customer c ON r.id_customer = c.id_customer
    INNER JOIN Agency a ON r.id_agency = a.id_agency;

-- 8.1
SELECT crv.id_reservation, crv.start_reservation
FROM customer_reservations_view crv
ORDER BY crv.start_reservation;

-- 9
CREATE OR REPLACE VIEW customer_reservations_view AS
    SELECT r.id_reservation, r.start_reservation, r.end_reservation,
           r.total_price, c.nombre, a.name_agency
    FROM Reservation r
    INNER JOIN Customer c ON r.id_customer = c.id_customer
    INNER JOIN Agency a ON r.id_agency = a.id_agency
    WHERE r.total_price > 100;

-- 9.1
SELECT * FROM customer_reservations_view;

-- 10
-- agency_summary_view

-- 10.1
DROP VIEW agency_summary_view;

-- 10.2
SELECT * FROM agency_summary_view;

-- 10.3
CREATE VIEW agency_summary_view AS
    SELECT a.name_agency, SUM(r.total_price) AS 'total_income',
           AVG(r.total_price) AS 'average_reservation'
    FROM Agency a
    INNER JOIN Reservation r ON a.id_agency = r.id_agency;

-- 11
-- customer_total_view

-- 11.1
SELECT ctv.nombre, AVG(ctv.total_spent) AS 'average_spending'
FROM customer_total_view ctv
GROUP BY ctv.nombre;

-- 11.2
SELECT ctv.nombre, AVG(ctv.total_spent) AS 'average_spending'
FROM customer_total_view ctv
GROUP BY ctv.nombre
HAVING average_spending > 800;
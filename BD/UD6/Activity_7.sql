USE car_rental;

-- 1
SELECT cu.id_customer, cu.nombre, COUNT(r.id_reservation) AS total_reservations
FROM Customer cu
INNER JOIN Reservation r ON cu.id_customer = r.id_customer
GROUP BY cu.id_customer
HAVING total_reservations > 2;

-- 2
SELECT a.name_agency, COUNT(r.id_reservation) AS 'total_reservations',
       CASE
           WHEN COUNT(r.id_reservation) > 100 THEN 'High'
           WHEN COUNT(r.id_reservation) < 2 THEN 'Low'
           ELSE 'Medium'
        END AS 'activity_level'
FROM Agency a
LEFT JOIN Reservation r ON a.id_agency = r.id_agency;

-- 3
SELECT g.name_garage, COUNT(c.id_coche) AS 'total_cars',
       CASE
           WHEN c.id_coche <= 0 THEN 'Empty'
           WHEN c.id_coche > 10 THEN 'Full'
           ELSE 'Normal'
       END
FROM Garage g
LEFT JOIN Car c ON g.id_garage = c.id_garage;

-- 4
SELECT a.name_agency,
       COUNT(r.id_reservation) AS total_reservations,
       CASE
           WHEN COUNT(r.id_reservation) > 100 THEN 'High'
           WHEN COUNT(r.id_reservation) < 2 THEN 'Low'
           ELSE 'Medium'
       END AS activity_level
FROM Agency a
INNER JOIN Reservation r ON a.id_agency = r.id_agency
GROUP BY a.name_agency
HAVING activity_level IN ('High', 'Medium');

-- 5
SELECT c.nombre, a.name_agency, r.total_price,
       CASE
           WHEN total_price > 200 THEN 'Expensive'
           WHEN total_price < 50 THEN 'Cheap'
           ELSE 'Normal'
        END
FROM Customer c
INNER JOIN Reservation r ON c.id_customer = r.id_customer
INNER JOIN Agency a ON r.id_agency = a.id_agency
WHERE start_reservation

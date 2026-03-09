-- 1
SELECT r.id_reservation, r.start_reservation, cu.nombre
FROM Reservation r
LEFT JOIN Customer cu ON r.id_customer = cu.id_customer;

-- 2
SELECT a.name_agency, r.id_reservation
FROM Agency a
RIGHT JOIN Reservation r ON a.id_agency = r.id_agency;

-- 3
SELECT a.name_agency, r.id_reservation, cu.nombre
FROM Agency a
INNER JOIN Reservation r ON a.id_agency = r.id_agency
RIGHT JOIN Customer cu ON r.id_customer = cu.id_customer;

-- 4
SELECT r.id_reservation, cu.nombre, COUNT(rc.id_coche) AS 'total_cars'
FROM Reservation r
LEFT JOIN Customer cu ON r.id_customer = cu.id_customer
LEFT JOIN Reservation_car rc ON rc.id_reservation = r.id_reservation
GROUP BY r.id_reservation, cu.nombre
ORDER BY 'total_cars' DESC;

-- 5
SELECT a.name_agency, SUM(r.total_price) AS 'total_price'
FROM Reservation r
RIGHT JOIN Agency a ON r.id_agency = a.id_agency
AND r.car_delivered = 1
GROUP BY a.id_agency, a.name_agency
ORDER BY 'total_price' DESC;
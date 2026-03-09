-- 1
SELECT cu.nombre, r.id_reservation
FROM Customer cu
LEFT JOIN Reservation r ON cu.id_customer = r.id_customer;

-- 2
SELECT r.id_reservation, r.start_reservation, cu.nombre
FROM Reservation r
INNER JOIN Customer cu ON r.id_customer = cu.id_customer;

-- 3
SELECT cu.nombre, cu.id_avalista
FROM Customer cu
LEFT JOIN Customer a ON cu.id_customer = a.id_avalista
ORDER BY cu.nombre;

-- 4
SELECT a.name_agency, COUNT(r.id_reservation) AS 'total_reservations'
FROM Agency a
LEFT JOIN Reservation r ON a.id_agency = r.id_agency;

-- 5
SELECT rc.id_reservation, c.license_plate
FROM Reservation_car rc
INNER JOIN Car c ON c.id_coche = rc.id_coche;

-- 6
SELECT g.name_garage, c.license_plate
FROM Garage g
LEFT JOIN Car c ON g.id_garage = c.id_garage;
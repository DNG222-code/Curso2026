-- 1
SELECT a.name_agency, r.id_reservation
FROM Agency a
LEFT JOIN Reservation r ON a.id_agency = r.id_agency
WHERE r.start_reservation >= '2024-01-01';

-- 2
SELECT cu.nombre, r.id_reservation
FROM Customer cu
LEFT JOIN Reservation r ON cu.id_customer = r.id_customer
AND r.total_price > 300;

-- 3
SELECT c.id_coche, c.license_plate, rc.id_reservation
FROM Car c
LEFT JOIN Reservation_car rc ON c.id_coche = rc.id_coche
AND rc.car_delivered = 1;

-- 4
SELECT a.id_agency, a.name_agency, r.id_reservation
FROM Agency a
LEFT JOIN Reservation r ON a.id_agency = r.id_agency
AND r.start_reservation >= '2025-01-01'
AND r.start_reservation <= '2026-01-01'
WHERE a.id_agency > 2
ORDER BY a.id_agency, r.start_reservation;

-- 5
SELECT a.name_agency, r.id_reservation
FROM Agency a
LEFT JOIN Reservation r ON a.id_agency = r.id_agency
AND r.start_reservation >= '2024-01-01'
AND r.start_reservation < '2025-01-01';
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
INNER JOIN Reservation r ON a.id_agency = r.id_agency
WHERE a.id_agency IS NOT NULL

-- 2

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


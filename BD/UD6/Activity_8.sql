-- 1
SELECT *
FROM Reservation
WHERE total_price < (
    SELECT MAX(total_price)
    FROM Reservation
    WHERE id_customer = 1
);

-- 3
SELECT * FROM Reservation
WHERE total_price < (

)
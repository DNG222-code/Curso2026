-- Exercise 1 – Get the salary of a director
DELIMITER //

CREATE PROCEDURE get_director_salary(IN p_director_id INT, OUT p_salary decimal)
BEGIN
    SELECT director_salary INTO p_salary FROM director
        WHERE director_id = p_director_id;
END //

DELIMITER ;

CALL get_director_salary(2, @salary);
SELECT @salary;
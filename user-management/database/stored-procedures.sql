USE demo;

DROP PROCEDURE IF EXISTS get_user_by_id;
DROP PROCEDURE IF EXISTS insert_user;

DELIMITER $$
CREATE PROCEDURE get_user_by_id(IN user_id INT)
BEGIN
    SELECT users.name, users.email, users.country
    FROM users
    WHERE users.id = user_id;
END$$

CREATE PROCEDURE insert_user(
    IN user_name VARCHAR(120),
    IN user_email VARCHAR(220),
    IN user_country VARCHAR(120)
)
BEGIN
    INSERT INTO users (name, email, country)
    VALUES (user_name, user_email, user_country);
END$$
DELIMITER ;

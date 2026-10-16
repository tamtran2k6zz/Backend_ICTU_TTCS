USE demo;

DROP PROCEDURE IF EXISTS get_user_by_id;
DROP PROCEDURE IF EXISTS insert_user;
DROP PROCEDURE IF EXISTS list_users;
DROP PROCEDURE IF EXISTS update_user;
DROP PROCEDURE IF EXISTS delete_user;

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

CREATE PROCEDURE list_users(
    IN filter_country VARCHAR(120),
    IN sort_order VARCHAR(4)
)
BEGIN
    SELECT id, name, email, country
    FROM users
    WHERE filter_country IS NULL
       OR filter_country = ''
       OR country LIKE CONCAT('%', filter_country, '%')
    ORDER BY
        CASE WHEN UPPER(sort_order) = 'DESC' THEN name END DESC,
        CASE WHEN UPPER(sort_order) <> 'DESC' THEN name END ASC,
        id ASC;
END$$

CREATE PROCEDURE update_user(
    IN user_id INT,
    IN user_name VARCHAR(120),
    IN user_email VARCHAR(220),
    IN user_country VARCHAR(120),
    OUT affected_rows INT
)
BEGIN
    UPDATE users
    SET name = user_name,
        email = user_email,
        country = user_country
    WHERE id = user_id;
    SET affected_rows = ROW_COUNT();
END$$

CREATE PROCEDURE delete_user(IN user_id INT, OUT affected_rows INT)
BEGIN
    DELETE FROM users WHERE id = user_id;
    SET affected_rows = ROW_COUNT();
END$$
DELIMITER ;

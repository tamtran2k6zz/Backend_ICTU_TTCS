USE demo_products_db;

DELIMITER //
DROP PROCEDURE IF EXISTS getAllProducts//
CREATE PROCEDURE getAllProducts()
BEGIN
    SELECT * FROM Products ORDER BY Id;
END//

DROP PROCEDURE IF EXISTS addProduct//
CREATE PROCEDURE addProduct(
    IN in_productCode VARCHAR(30),
    IN in_productName VARCHAR(100),
    IN in_productPrice DECIMAL(10,2),
    IN in_productAmount INT,
    IN in_productDescription TEXT,
    IN in_productStatus TINYINT
)
BEGIN
    INSERT INTO Products
        (productCode, productName, productPrice, productAmount, productDescription, productStatus)
    VALUES
        (in_productCode, in_productName, in_productPrice, in_productAmount,
         in_productDescription, in_productStatus);
END//

DROP PROCEDURE IF EXISTS updateProduct//
CREATE PROCEDURE updateProduct(
    IN in_Id INT,
    IN in_productCode VARCHAR(30),
    IN in_productName VARCHAR(100),
    IN in_productPrice DECIMAL(10,2),
    IN in_productAmount INT,
    IN in_productDescription TEXT,
    IN in_productStatus TINYINT
)
BEGIN
    UPDATE Products
    SET productCode = in_productCode,
        productName = in_productName,
        productPrice = in_productPrice,
        productAmount = in_productAmount,
        productDescription = in_productDescription,
        productStatus = in_productStatus
    WHERE Id = in_Id;
END//

DROP PROCEDURE IF EXISTS deleteProduct//
CREATE PROCEDURE deleteProduct(IN in_Id INT)
BEGIN
    DELETE FROM Products WHERE Id = in_Id;
END//
DELIMITER ;

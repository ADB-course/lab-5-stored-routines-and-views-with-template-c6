-- (i) A Procedure called PROC_LAB5


DELIMITER //
CREATE PROCEDURE PROC_LAB5(IN product_code VARCHAR(15))
BEGIN
    SELECT 
        c.customerNumber,
        c.customerName,
        c.city,
        c.country,
        p.productCode,
        p.productName,
        p.productLine
    FROM 
        customers AS c
    JOIN 
        orders AS o ON c.customerNumber = o.customerNumber
    JOIN 
        orderdetails AS od ON o.orderNumber = od.orderNumber
    JOIN 
        products AS p ON od.productCode = p.productCode
    WHERE 
        p.productCode = product_code;
END //
DELIMITER ;


-- (ii) A Function called FUNC_LAB5

DELIMITER //
CREATE FUNCTION FUNC_LAB5(product_code VARCHAR(15)) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_quantity INT;

    SELECT 
        SUM(od.quantityOrdered) INTO total_quantity
    FROM 
        orderdetails AS od
    WHERE 
        od.productCode = product_code;

    RETURN IFNULL(total_quantity, 0); -- Returns 0 if no records found
END //
DELIMITER ;
-- (iii) A View called VIEW_LAB5

CREATE VIEW VIEW_LAB5 AS
SELECT 
    c.customerNumber,
    c.customerName,
    c.city,
    c.country,
    COUNT(o.orderNumber) AS total_orders,
    SUM(od.quantityOrdered) AS total_quantity_ordered
FROM 
    customers AS c
JOIN 
    orders AS o ON c.customerNumber = o.customerNumber
JOIN 
    orderdetails AS od ON o.orderNumber = od.orderNumber
GROUP BY 
    c.customerNumber, c.customerName, c.city, c.country;

SELECT * FROM VIEW_LAB5;
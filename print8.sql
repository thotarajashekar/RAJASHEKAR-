
USE ecommerceinvdb;

-- Task 1

-- Write a query to create a trigger that ensures the data integrity of the "order_items" table.
-- This trigger must incorporate the following functionalities It checks for negative quantities or a quantity value of 0 in the NEW row (representing the attemptedinsert) It retrieves the current stock level for the product using a SELECT statement.

-- If the quantity is negative or the stock is insufficient it throws an error message using SIGNAL, thereby preventing the insert operation
SHOW TRIGGERS;
DROP TRIGGER IF EXISTS check_order_item;
DELIMITER //
CREATE TRIGGER check_order_item BEFORE INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;

    -- Check if the quantity is negative or zero
    IF NEW.quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;

    -- Retrieve the current stock level for the product
    SELECT stock_level INTO current_stock
    FROM products
    WHERE product_id = NEW.product_id;

    -- Check if the stock level is sufficient
    IF current_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock for the product';
    END IF;
END //

DELIMITER ;

#######################################################

-- Task 1 (cont'd)

-- Write a query to insert a new record into the order_items table with order_id=1, product_id=3, and quantity=

-- Write a query to insert a new record into the order_items table with order_id=1, product_id=3, and quantity=-1

INSERT INTO order_items (order_id, product_id, quantity)
VALUES (1, 3, 5); -- Example quantity, replace with your desired positive quantity

-- Error Code: 1644. Quantity must be greater than zero

###############################################################
-- Task 2

-- Write a query to add a new column named total_amount to the Orders table with the following structure:

-- total_amount DECIMAL (10,2)

-- Write queries to update total amount value of all orders to 0



-- Adding a New Column to the Orders Table
SHOW COLUMNS FROM orders LIKE 'total_amount';
ALTER TABLE orders
MODIFY COLUMN total_amount DECIMAL(10,2);


-- Updating Total Amount Value of All Orders to 0
SET SQL_SAFE_UPDATES = 0;

-- Creating a Daily Sales Table

DROP TABLE IF EXISTS daily_sales;

CREATE TABLE daily_sales (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE,
    total_sales DECIMAL(10,2)
);






##############################################

-- Task 2 (cont'd)

-- Write a query to create a trigger which will fire after successful insertions of any new record to the order_items table.
-- This trigger should follow the following functionalities

-- Calculates the new total by adding the inserted item's product price and quantity to the existing total then updates the orders table accordingly.

-- Stores daily sales summary information by inserting a new row into the daily_sales table with the current date (CURDATE()) and the total amount from the newly updated order.

DELIMITER //

DROP TRIGGER IF EXISTS after_insert_order_item //

CREATE TRIGGER after_insert_order_item
AFTER INSERT ON order_items
FOR EACH ROW
BEGIN
    DECLARE item_total DECIMAL(10,2);
    DECLARE order_total DECIMAL(10,2);
    DECLARE existing_total DECIMAL(10,2);
    
    -- Calculate the total amount for the new order item
    SELECT price * NEW.quantity INTO item_total
    FROM products
    WHERE product_id = NEW.product_id;

    -- Retrieve the current total amount for the order
    SELECT total_amount INTO existing_total
    FROM orders
    WHERE order_id = NEW.order_id;

    -- Calculate the new total amount for the order
    SET order_total = existing_total + item_total;

    -- Update the total amount in the orders table
    UPDATE orders
    SET total_amount = order_total
    WHERE order_id = NEW.order_id;

    -- Insert the daily sales summary
    INSERT INTO daily_sales (sale_date, total_sales)
    VALUES (CURDATE(), item_total);
END //

DELIMITER ;

###########################################
-- Task 2 (cont'd)

-- Write a query to insert a new record into the order_items table with order_id=10, product_id=1 and quantity=2

INSERT INTO order_items (order_id, product_id, quantity)
VALUES (10, 1, 2);

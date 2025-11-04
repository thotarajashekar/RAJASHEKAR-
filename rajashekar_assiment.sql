-- Section- I (MCQ) [Solve any 6 Questions] 
-- 1.:Section) to filter row based on a condition


-- 2.Section
-- c.trigeer

-- 3.In a retail database, the sales manager used SQL to analyze product sales performance. The manager applied the ORDER BY clause in the SELECT query to __________.

-- d. Sort the result set based on specified columns.

-- 4.In a government agency's database, the security team used a command from DCL to remove specific access rights from a former employee, preventing unauthorized data access after their departure. Which SQL command is used to revoke access privileges from users?

-- a.REVOKE
-- 6. In a database system, which of the following SQL-related statements is true?

-- c. The TRUNCATE command is used to delete the information present in the table, but not the table structure.
-- 8. What is the purpose of the HAVING clause in SQL?

-- b. To filter the rows based on specific conditions
##########################################################################################################################################
-- Section - II (Short Answer Questions) [Solve any 6 Questions] 

-- 1. What is the difference between a primary key and a foreign key?
-- In relational databases, primary keys and foreign keys are fundamental concepts used to ensure data integrity and 
-- establish relationships between tables. Here’s a breakdown of their differences:

-- Primary Key: Ensures the uniqueness of each row within its own table and does not allow NULL values.
-- Foreign Key: Links rows between two tables, allowing for relationships and enforcing referential integrity, and can accept NULL values.


-- 3. What is the difference between a CREATE TABLE statement and an ALTER TABLE 
-- statement?

-- The CREATE TABLE and ALTER TABLE statements in SQL serve different purposes when managing database schema:

-- CREATE TABLE: Used to create a new table and define its structure, including columns, data types, and constraints.
-- ALTER TABLE: Used to modify the structure of an existing table by adding, deleting, or modifying columns and constraints.

-- 5. Differentiate between SQL INNER JOIN and SQL LEFT JOIN. Include an example for each.

--  INNER JOIN and LEFT JOIN are two types of joins used to combine rows from two or more tables based on a related column between them. 
-- Here’s a detailed comparison along with examples:
-- LEFT JOIN (or LEFT OUTER JOIN)
-- INNER JOIN:
-- LEFT JOIN

-- 6. What is the difference between a JOIN and a subquery?

-- JOINs and subqueries are both methods used to retrieve related data from multiple tables in SQL, but they serve different
--  purposes and are used in different contexts. Here’s a detailed comparison:
--  4.What is the difference between the WHERE and HAVING clauses in a SELECT statement?
--  The WHERE and HAVING clauses in SQL are both used to filter data, but they serve different purposes 
--  and are used in different contexts. Here's a detailed comparison of the two
--  
--  1. Implement a trigger to update the EmployeeCount column in the "Departments" table 
-- whenever a new employee is added. Consider the following structure of tables while writing 
-- the query –Employees (EmployeeID,FirstName, LastName, DepartmentID), Departments 
-- (DepartmentID , DepartmentName, EmployeeCount)

-- To implement a trigger that updates the EmployeeCount column in the Departments table whenever a new employee is
--  added to the Employees table, you need to define a trigger that will fire after an INSERT operation on the Employees table.
--  This trigger will then update the corresponding EmployeeCount for the department of the newly added employee.
############################################################################################################################################################

-- Section - III (Long Answer Questions)
-- 1. Explain the concept of a foreign key in SQL. Provide an example of two tables with a 
-- foreign key relationship and demonstrate how to establish this relationship

-- A foreign key is a column or a set of columns in one table that uniquely identifies a row of another table.
--  It is a key used to establish and enforce a link between the data in two tables.
-- The primary purpose of a foreign key is to maintain referential integrity between tables in a relational database.
-- Key Characteristics of Foreign Keys:
-- 1.Referential Integrity:
-- 2.forcement of Relationships:
-- 3.Cascade Actions:

-- Example of Foreign Key Relationship

-- Consider two tables: Orders and Customers.
-- 1.Customers Table:
-- 2.Orders Table:
-- ##########################################
-- 3. Explain the concept of operator precedence in SQL. How does operator precedence affect 
-- the order of operations in SQL expressions?

-- Operator precedence in SQL determines the order in which operators in an expression are evaluated. Understanding operator precedence is crucial for 
-- writing correct and efficient SQL queries, as it affects how expressions are parsed and executed.
-- ##############################################################
-- 4. Explain the advantages of using stored procedures in SQL database systems. Provide an 
-- example scenario where a stored procedure could be utilized to streamline complex data 
-- manipulation tasks

-- Stored procedures in SQL database systems offer a range of advantages for managing and manipulating data. 
-- They are precompiled SQL statements that are stored in the database and can be executed by calling their names.
--  Here’s a detailed explanation of the advantages of using stored procedures, along with an example scenario where a stored procedure 
--  can streamline complex data manipulation tasks.
--  ########################################################################
--  6. Explain the application of WHERE subqueries and how they filter results based on 
-- subquery outcomes
-- In SQL, a WHERE subquery (also known as a nested query or inner query) is used to filter results based on the results of another query. This technique allows you to refine your search criteria by using the outcome of a subquery to limit the rows processed by the main query.

-- Here’s how WHERE subqueries work:
-- ##########################################################################

USE sakila;
USE ecommercedb;
USE `modelcarsdb`;
use hr;

-- Section - IV (Scenario Based Questions) [Solve any 5 questions] Marks –
use hr;
SELECT d.DepartmentName, COUNT(e.EmployeeID) AS NumberOfEmployees
FROM Departments d
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName;
############################################################################################
DESCRIBE Departments;

SELECT e.LastName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Marketing';
########################################################################################################################
SELECT FirstName
FROM Employees
WHERE Salary > 50000;
##########################################

SELECT e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;
DELIMITER //

CREATE PROCEDURE GetEmployeeDetails(IN emp_ids TEXT)
BEGIN
    SELECT e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    WHERE FIND_IN_SET(e.EmployeeID, emp_ids);
END //

DELIMITER ;
CALL GetEmployeeDetails('1,2,3');
#############################################################
-- employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    dept_id INT
);

-- departments table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);
-- Find employees who work in departments located in 'New York'
SELECT name
FROM employees
WHERE dept_id IN (
    SELECT dept_id
    FROM departments
    WHERE city = 'New York'
);
-- Find departments with at least one employee
SELECT dept_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id
);
-- Assume there’s a salary column in employees table
SELECT name
FROM employees
WHERE salary > ANY (
    SELECT salary
    FROM employees
    WHERE dept_id = 5
);

###########################################################################################################################################################
-- Assume there’s a salary column in employees table
SELECT name
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE dept_id = 10
);
CREATE TABLE Orders (
    order_id INT PRIMARY KEY, -- Primary key
    order_date DATE,
    customer_id INT, -- Foreign key
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
-- Insert into Customers table
INSERT INTO Customers (customer_id, name, email) VALUES (1, 'Alice Johnson', 'alice@example.com');
INSERT INTO Customers (customer_id, name, email) VALUES (2, 'Bob Smith', 'bob@example.com');

-- Insert into Orders table
INSERT INTO Orders (order_id, order_date, customer_id) VALUES (1001, '2024-08-08', 1);
INSERT INTO Orders (order_id, order_date, customer_id) VALUES (1002, '2024-08-09', 2);

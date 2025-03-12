-- Section-I (MCQ) [Solve any 6 Questions] Marks – 12
-- What is the purpose of the SQL keyword "WHERE" in a query?

-- c. To filter rows based on a condition
-- In a retail database, whenever a new product is added to the "Products" table, the system automatically updates the inventory count in the "Inventory" table. Which SQL feature can be used to implement this automatic update process?

-- c. Trigger
-- In a retail database, the sales manager used SQL to analyze product sales performance. The manager applied the ORDER BY clause in the SELECT query to __________.

-- d. Sort the result set based on specified columns.
-- In a government agency's database, the security team used a command from DCL to remove specific access rights from a former employee, preventing unauthorized data access after their departure. Which SQL command is used to revoke access privileges from users?

a. Revoke
SELECT BookTitle, Author, Price FROM Books WHERE Genre = 'Science Fiction'; What does the above SQL statement do in the context of the Online Bookstore Inventory?

a. Displays the book titles, authors, and prices for all books in the "Science Fiction" genre.
In a database system, which of the following SQL-related statements is true?

c. The TRUNCATE command is used to delete the information present in the table, but not the table structure.
In SQL, which of the following statements about relationships between tables is true?

d. A foreign key is used to establish a relationship between two tables, referencing the primary key of another table.
What is the purpose of the HAVING clause in SQL?

b. To filter the rows based on specific conditions
Section - II (Short Answer Questions) [Solve any 6 Questions] Marks – 18
Implement a trigger to update the EmployeeCount column in the "Departments" table whenever a new employee is added.


CREATE TRIGGER UpdateEmployeeCount
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
  UPDATE Departments
  SET EmployeeCount = EmployeeCount + 1
  WHERE DepartmentID = NEW.DepartmentID;
END;
What is the difference between a primary key and a foreign key?

Primary Key: A primary key is a unique identifier for a record in a table. It ensures that each record is unique and not null.
Foreign Key: A foreign key is a field in one table that uniquely identifies a row in another table. It establishes a link between the two tables.
What is the difference between a CREATE TABLE statement and an ALTER TABLE statement?

CREATE TABLE: Used to create a new table in the database.
ALTER TABLE: Used to modify an existing table structure, such as adding, deleting, or modifying columns.
What is the difference between the WHERE and HAVING clauses in a SELECT statement?

WHERE: Filters rows before any groupings are made. Used with SELECT, UPDATE, DELETE.
HAVING: Filters groups after groupings are made. Used with GROUP BY.
Differentiate between SQL INNER JOIN and SQL LEFT JOIN. Include an example for each.

INNER JOIN: Returns only the rows where there is a match in both tables.


SELECT Employees.FirstName, Departments.DepartmentName
FROM Employees
INNER JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;
LEFT JOIN: Returns all rows from the left table, and the matched rows from the right table. Returns NULL if there is no match.


SELECT Employees.FirstName, Departments.DepartmentName
FROM Employees
LEFT JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID;
What is the difference between a JOIN and a subquery?

JOIN: Combines rows from two or more tables based on a related column.
Subquery: A query nested inside another query. It provides a result set that can be used by the outer query.
Provide an example of a WHERE subquery that filters the results of a main query.


SELECT EmployeeID, FirstName
FROM Employees
WHERE DepartmentID IN (
  SELECT DepartmentID
  FROM Departments
  WHERE DepartmentName = 'Sales'
);
Explain the purpose of a FROM subquery and how it's used.

A FROM subquery is used to provide a result set that can be used as a table in the main query. It allows complex queries by creating intermediate results.

SELECT DeptStats.DepartmentName, COUNT(E.EmployeeID) AS EmployeeCount
FROM (
  SELECT DepartmentID, COUNT(EmployeeID) AS EmployeeCount
  FROM Employees
  GROUP BY DepartmentID
) AS DeptStats
INNER JOIN Departments D ON DeptStats.DepartmentID = D.DepartmentID
GROUP BY DeptStats.DepartmentName;
Section - III (Long Answer Questions) [Solve any 5 questions] Marks – 20
Explain the concept of a foreign key in SQL. Provide an example of two tables with a foreign key relationship and demonstrate how to establish this relationship.

A foreign key is a column or a set of columns in one table that uniquely identifies a row in another table. It establishes a relationship between the two tables.


Copy code
CREATE TABLE Departments (
  DepartmentID INT PRIMARY KEY,
  DepartmentName VARCHAR(50)
);

CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  DepartmentID INT,
  FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);
Explain the use of SQL triggers and their significance in database management. Provide an example scenario where a trigger could be used to automate data validation or auditing tasks.

SQL triggers are special procedures that are automatically executed in response to certain events on a table or view, such as INSERT, UPDATE, or DELETE. They help enforce business rules, perform validation, and automate auditing tasks.

Example Scenario:


CREATE TRIGGER AuditEmployeeChanges
AFTER UPDATE ON Employees
FOR EACH ROW
BEGIN
  INSERT INTO EmployeeAudit (EmployeeID, OldSalary, NewSalary, ChangeDate)
  VALUES (OLD.EmployeeID, OLD.Salary, NEW.Salary, NOW());
END;
Explain the concept of operator precedence in SQL. How does operator precedence affect the order of operations in SQL expressions?

Operator precedence determines the order in which operations are performed in an SQL expression. Higher precedence operators are evaluated before lower precedence ones. For instance, multiplication and division have higher precedence than addition and subtraction. Parentheses can be used to override the default precedence.

Example:

sql
Copy code
SELECT 5 + 2 * 3; -- Evaluates as 5 + (2 * 3) = 11
Explain the advantages of using stored procedures in SQL database systems. Provide an example scenario where a stored procedure could be utilized to streamline complex data manipulation tasks.

Stored procedures offer several advantages:

Modularity: Encapsulate complex operations in reusable code.
Performance: Precompiled and optimized for efficiency.
Security: Control access to data through procedural logic.
Example Scenario:


CREATE PROCEDURE UpdateEmployeeSalary (
  IN empID INT,
  IN newSalary DECIMAL(10,2)
)
BEGIN
  UPDATE Employees
  SET Salary = newSalary
  WHERE EmployeeID = empID;
END;
Explain the difference between scalar functions and aggregate functions in SQL. Provide examples of each type of function.

Scalar Functions: Operate on a single value and return a single value. Examples include UCASE(), LCASE(), and ROUND().


SELECT UCASE(FirstName) AS UpperCaseName FROM Employees;
Aggregate Functions: Operate on a set of values and return a single value. Examples include SUM(), AVG(), COUNT().


SELECT COUNT(*) AS EmployeeCount FROM Employees;
Explain the application of WHERE subqueries and how they filter results based on subquery outcomes.

WHERE subqueries are used to filter rows in the main query based on the results of a subquery. They allow for more complex filtering conditions.


Copy code
SELECT FirstName, LastName
FROM Employees
WHERE DepartmentID = (
  SELECT DepartmentID
  FROM Departments
  WHERE DepartmentName = 'HR'
);
Section - IV (Scenario Based Questions) [Solve any 5 questions] Marks – 50
Write a SQL query to get the department names and the corresponding number of employees in each department.


SELECT D.DepartmentName, COUNT(E.EmployeeID) AS EmployeeCount
FROM Departments D
LEFT JOIN Employees E ON D.DepartmentID = E.DepartmentID
GROUP BY D.DepartmentName;
Write a SQL query to get the last names of all employees who work in the marketing department.
SELECT E.LastName
FROM Employees E



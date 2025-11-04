-- Step 1: Create the database
CREATE DATABASE techmac_db;

-- Step 2: Use the database
USE techmac_db;

-- Step 3: Create TECHHYVE_employees table
CREATE TABLE TECHHYVE_employees (
    EmployeeID VARCHAR(12) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender ENUM('Male', 'Female'),
    Age INT,
    ProficiencyLevel INT
);

-- Step 4: Insert data into TECHHYVE_employees
INSERT INTO TECHHYVE_employees (EmployeeID, FirstName, LastName, Gender, Age, ProficiencyLevel) VALUES
('TH0001', 'Eli', 'Evans', 'Male', 26, 1),
('TH0002', 'Carlos', 'Simmons', 'Male', 32, 2),
('TH0003', 'Kathie', 'Bryant', 'Female', 25, 1),
('TH0004', 'Joey', 'Hughes', 'Male', 41, 4),
('TH0005', 'Alice', 'Matthews', 'Female', 52, 4);

-- Step 5: Create TECHCLOUD_employees table
CREATE TABLE TECHCLOUD_employees (
    EmployeeID VARCHAR(11) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender ENUM('Male', 'Female'),
    Age INT,
    ProficiencyLevel INT
);

-- Step 6: Insert data into TECHCLOUD_employees
INSERT INTO TECHCLOUD_employees (EmployeeID, FirstName, LastName, Gender, Age, ProficiencyLevel) VALUES
('TC0001', 'Teresa', 'Bryant', 'Female', 39, 2),
('TC0002', 'Alexis', 'Patterson', 'Male', 48, 5),
('TC0003', 'Rose', 'Bell', 'Female', 42, 3),
('TC0004', 'Gemma', 'Watkins', 'Female', 44, 3),
('TC0005', 'Kingston', 'Martinez', 'Male', 29, 2);

-- Step 7: Create TECHSOFT_employees table
CREATE TABLE TECHSOFT_employees (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender ENUM('Male', 'Female'),
    Age INT,
    ProficiencyLevel INT
);

-- Step 8: Insert data into TECHSOFT_employees
INSERT INTO TECHSOFT_employees (EmployeeID, FirstName, LastName, Gender, Age, ProficiencyLevel) VALUES
('TS0001', 'Peter', 'Burtler', 'Male', 44, 4),
('TS0002', 'Harold', 'Simmons', 'Male', 54, 4),
('TS0003', 'Juliana', 'Sanders', 'Female', 36, 2),
('TS0004', 'Paul', 'Ward', 'Male', 29, 2),
('TS0005', 'Nicole', 'Bryant', 'Female', 30, 2);
-- tack1.1

ALTER TABLE techhyve_employees
MODIFY FirstName VARCHAR(255) NOT NULL,
MODIFY LastName VARCHAR(255) NOT NULL;

ALTER TABLE techcloud_employees
MODIFY FirstName VARCHAR(255) NOT NULL,
MODIFY LastName VARCHAR(255) NOT NULL;

ALTER TABLE techsoft_employees
MODIFY FirstName VARCHAR(255) NOT NULL,
MODIFY LastName VARCHAR(255) NOT NULL;
ALTER TABLE techhyve_employees
MODIFY Age INT DEFAULT 21;
-- task1.2
ALTER TABLE techcloud_employees
MODIFY Age INT DEFAULT 21;

ALTER TABLE techsoft_employees
MODIFY Age INT DEFAULT 21;
-- tack1.3
ALTER TABLE techhyve_employees
MODIFY Age INT DEFAULT 21,
ADD CONSTRAINT chk_age_techhyve CHECK (Age BETWEEN 21 AND 55);

ALTER TABLE techcloud_employees
MODIFY Age INT DEFAULT 21,
ADD CONSTRAINT chk_age_techcloud CHECK (Age BETWEEN 21 AND 55);

ALTER TABLE techsoft_employees
MODIFY Age INT DEFAULT 21,
ADD CONSTRAINT chk_age_techsoft CHECK (Age BETWEEN 21 AND 55);
-- tack 1.4
ALTER TABLE techhyve_employees
ADD COLUMN Username VARCHAR(255) NOT NULL UNIQUE,
ADD COLUMN Password VARCHAR(255) NOT NULL UNIQUE;

ALTER TABLE techcloud_employees
ADD COLUMN Username VARCHAR(255) NOT NULL UNIQUE,
ADD COLUMN Password VARCHAR(255) NOT NULL UNIQUE;

ALTER TABLE techsoft_employees
ADD COLUMN Username VARCHAR(255) NOT NULL UNIQUE,
ADD COLUMN Password VARCHAR(255) NOT NULL UNIQUE;
-- tack1.5
ALTER TABLE techhyve_employees
ADD CONSTRAINT chk_gender_techhyve CHECK (Gender IN ('Male', 'Female'));

ALTER TABLE techcloud_employees
ADD CONSTRAINT chk_gender_techcloud CHECK (Gender IN ('Male', 'Female'));

ALTER TABLE techsoft_employees
ADD CONSTRAINT chk_gender_techsoft CHECK (Gender IN ('Male', 'Female'));
-- tack2
ALTER TABLE techhyve_employees
ADD COLUMN Communication_Proficiency INT DEFAULT 1,
ADD CONSTRAINT chk_communication_proficiency_techhyve CHECK (Communication_Proficiency BETWEEN 1 AND 5);

ALTER TABLE techcloud_employees
ADD COLUMN Communication_Proficiency INT DEFAULT 1,
ADD CONSTRAINT chk_communication_proficiency_techcloud CHECK (Communication_Proficiency BETWEEN 1 AND 5);

ALTER TABLE techsoft_employees
ADD COLUMN Communication_Proficiency INT DEFAULT 1,
ADD CONSTRAINT chk_communication_proficiency_techsoft CHECK (Communication_Proficiency BETWEEN 1 AND 5);
-- tack3
-- Create the new table techhyvecloud_employees
CREATE TABLE techhyvecloud_employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Gender ENUM('Male', 'Female') NOT NULL,
    Age INT DEFAULT 21,
    Username VARCHAR(255) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL UNIQUE,
    Communication_Proficiency INT DEFAULT 1,
    CONSTRAINT chk_gender CHECK (Gender IN ('Male', 'Female')),
    CONSTRAINT chk_communication_proficiency CHECK (Communication_Proficiency BETWEEN 1 AND 5)
);

-- Insert data from techhyve_employees into techhyvecloud_employees
INSERT INTO techhyvecloud_employees (FirstName, LastName, Gender, Age, Username, Password, Communication_Proficiency)
SELECT FirstName, LastName, Gender, Age, Username, Password, Communication_Proficiency
FROM techhyve_employees;

-- Insert data from techcloud_employees into techhyvecloud_employees
INSERT INTO techhyvecloud_employees (FirstName, LastName, Gender, Age, Username, Password, Communication_Proficiency)
SELECT FirstName, LastName, Gender, Age, Username, Password, Communication_Proficiency
FROM techcloud_employees;

-- Backup the data from techhyve_employees
CREATE TABLE backup_techhyve_employees AS
SELECT * FROM techhyve_employees;

-- Backup the data from techcloud_employees
CREATE TABLE backup_techcloud_employees AS
SELECT * FROM techcloud_employees;

-- Delete records from techhyve_employees
DELETE FROM techhyve_employees;

-- Delete records from techcloud_employees
DELETE FROM techcloud_employees;

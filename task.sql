DROP DATABASE IF EXISTS TechSolutionDB;

-- Step 1: Create the database
CREATE DATABASE TechSolutionDB;

-- Step 2: Select the database
USE TechSolutionDB;

-- Step 3: Create DEPARTMENT table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL,
    Location VARCHAR(50)
);

-- Step 4: Create EMPLOYEE table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    Salary DECIMAL(10,2),
    HireDate DATE,
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Step 5: Create PROJECT table
CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Budget DECIMAL(12,2)
);

-- Step 6: Create WORKS_ON table
CREATE TABLE Works_On (
    EmpID INT,
    ProjectID INT,
    HoursWorked INT,
    PRIMARY KEY (EmpID, ProjectID),
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

-- Step 7: Show all tables
SHOW TABLES;

-- Step 8: Display structure of tables
DESCRIBE Department;
DESCRIBE Employee;
DESCRIBE Project;
DESCRIBE Works_On;

-- =========================
-- Part C: Basic Queries
-- =========================

-- 1. Display all employees who earn more than 50,000
SELECT *
FROM Employee
WHERE Salary > 50000;

-- 2. Display FirstName, LastName, and Salary sorted by Salary (descending)
SELECT FirstName, LastName, Salary
FROM Employee
ORDER BY Salary DESC;

-- 3. Display employees who belong to the IT department
SELECT FirstName, LastName
FROM Employee
JOIN Department ON Employee.DeptID = Department.DeptID
WHERE DeptName = 'IT';

-- 4. Show the total number of employees in each department
SELECT Department.DeptName, COUNT(Employee.EmpID) AS TotalEmployees
FROM Employee
JOIN Department ON Employee.DeptID = Department.DeptID
GROUP BY Department.DeptName;

-- 5. Display employees who were hired after January 1, 2022
SELECT *
FROM Employee
WHERE HireDate > '2022-01-01';

-- =========================
-- Part D: Join Queries
-- =========================

-- 1. Display employee names along with their department names
SELECT Employee.FirstName, Employee.LastName, Department.DeptName
FROM Employee
JOIN Department ON Employee.DeptID = Department.DeptID;

-- 2. Show employees and the projects they are working on
SELECT Employee.FirstName, Employee.LastName, Project.ProjectName
FROM Employee
JOIN Works_On ON Employee.EmpID = Works_On.EmpID
JOIN Project ON Works_On.ProjectID = Project.ProjectID;

-- 3. Display project names with the total hours worked by employees
SELECT Project.ProjectName, SUM(Works_On.HoursWorked) AS TotalHours
FROM Project
JOIN Works_On ON Project.ProjectID = Works_On.ProjectID
GROUP BY Project.ProjectName;

-- =========================
-- Part E: Aggregate and Advanced Queries
-- =========================

-- 1. Find the average salary of employees in each department
SELECT Department.DeptName, AVG(Employee.Salary) AS AverageSalary
FROM Employee
JOIN Department ON Employee.DeptID = Department.DeptID
GROUP BY Department.DeptName;

-- 2. Display the department with the highest number of employees
SELECT Department.DeptName, COUNT(Employee.EmpID) AS TotalEmployees
FROM Employee
JOIN Department ON Employee.DeptID = Department.DeptID
GROUP BY Department.DeptName
ORDER BY TotalEmployees DESC
LIMIT 1;

-- 3. Find employees whose salary is greater than the average salary of all employees
SELECT FirstName, LastName, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

CREATE VIEW HighSalaryEmployees AS
SELECT *
FROM Employee
WHERE Salary > 60000;

CREATE INDEX idx_lastname
ON Employee(LastName);
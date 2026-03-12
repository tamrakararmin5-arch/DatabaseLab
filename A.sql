DROP DATABASE TechSolutionDB;
-- Step 1: Create the database
CREATE DATABASE TechSolutionDB;

-- Step 2: Select the database
USE TechSolutionDB;

-- Step 3: Create DEPARTMENT table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,           -- Unique department ID
    DeptName VARCHAR(50) NOT NULL,    -- Department name (cannot be NULL)
    Location VARCHAR(50)              -- Department location
);

-- Step 4: Create EMPLOYEE table
CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,            -- Unique employee ID
    FirstName VARCHAR(50),            -- Employee first name
    LastName VARCHAR(50),             -- Employee last name
    Gender VARCHAR(10),               -- Employee gender
    Salary DECIMAL(10,2),             -- Salary amount
    HireDate DATE,                    -- Hiring date
    DeptID INT,                       -- Department ID

    -- Foreign key linking employee to department
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Step 5: Create PROJECT table
CREATE TABLE Project (
    ProjectID INT PRIMARY KEY,        -- Unique project ID
    ProjectName VARCHAR(100),         -- Name of project
    StartDate DATE,                   -- Project start date
    EndDate DATE,                     -- Project end date
    Budget DECIMAL(12,2)              -- Project budget
);

-- Step 6: Create WORKS_ON table
CREATE TABLE Works_On (
    EmpID INT,                        -- Employee ID
    ProjectID INT,                    -- Project ID
    HoursWorked INT,                  -- Number of hours worked

    -- Composite Primary Key
    PRIMARY KEY (EmpID, ProjectID),

    -- Foreign key linking to Employee table
    FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),

    -- Foreign key linking to Project table
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

-- Step 7: Show all tables
SHOW TABLES;

-- Step 8: Display structure of tables
DESCRIBE Department;
DESCRIBE Employee;
DESCRIBE Project;
DESCRIBE Works_On;
-- Drop existing tables if they exist
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

-- Create departments table
CREATE TABLE Departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Create employees table
CREATE TABLE Employees (
    emp_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    salary NUMERIC(10,2),
    dept_id INT REFERENCES departments(dept_id),
    manager_id INT,
    join_date DATE
);

-- Create sales table
CREATE TABLE Sales (
    sale_id SERIAL PRIMARY KEY,
    emp_id INT REFERENCES employees(emp_id),
    amount NUMERIC(10,2)
);

-- Insert departments
INSERT INTO Departments (dept_name)
VALUES 
('Engineering'),
('HR'),
('Finance'),
('Marketing');

-- Insert employees
INSERT INTO Employees (name, salary, dept_id, manager_id, join_date)
VALUES
('Alice', 120000, 1, NULL, '2020-01-15'),   -- Manager, Engineering
('Bob', 90000, 1, 1, '2021-03-10'),
('Charlie', 95000, 1, 1, '2022-06-22'),
('David', 60000, 2, NULL, '2019-09-11'),    -- Manager, HR
('Eve', 55000, 2, 4, '2023-02-14'),
('Frank', 70000, 3, NULL, '2020-05-01'),    -- Manager, Finance
('Grace', 65000, 3, 6, '2021-11-17'),
('Heidi', 110000, 4, NULL, '2020-12-25'),   -- Manager, Marketing
('Ivan', 72000, 4, 8, '2023-07-03'),
('Judy', 85000, 1, 1, '2023-04-19');

-- Insert sales
INSERT INTO Sales (emp_id, amount)
VALUES
(2, 4000),
(3, 7000),
(5, 3500),
(7, 5000),
(9, 8000);

SELECT * FROM Departments;
SELECT * FROM Employees;
SELECT * FROM Sales;

-- Write a query to find the second highest salary from the employees table without using LIMIT or OFFSET.
SELECT MAX(salary) FROM Employees
WHERE salary < (
    SELECT MAX(salary) FROM Employees
);

-- Return all employees whose salary is greater than the average salary of 
-- their department (tables: employees(emp_id, name, salary, dept_id) and 
-- departments(dept_id, dept_name)).

-- Avg salary of department
SELECT dept_id, AVG(salary) FROM Employees
GROUP BY dept_id;

SELECT e.name, e.salary, d.dept_name
FROM Employees e
LEFT JOIN Departments d
WHERE  
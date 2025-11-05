DROP TABLE Employees;

CREATE TABLE Employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary NUMERIC(10,2),
    hire_date DATE,
    manager_id INT
);

INSERT INTO Employees (employee_id, first_name, last_name, department, salary, hire_date, manager_id)
VALUES
(1, 'Alice', 'Smith', 'Sales', 50000, '2021-01-15', 5),
(2, 'Bob', 'Johnson', 'HR', 45000, '2020-06-20', 6),
(3, 'Carol', 'Williams', 'Sales', 55000, '2022-03-12', 5),
(4, 'Dan', 'Brown', 'IT', 70000, '2019-11-05', 7),
(5, 'Eve', 'Davis', 'Sales', 60000, '2018-07-30', NULL),
(6, 'Frank', 'Miller', 'HR', 47000, '2021-09-18', NULL),
(7, 'Grace', 'Wilson', 'IT', 75000, '2017-02-22', NULL),
(8, 'Heidi', 'Moore', 'IT', 72000, '2022-12-01', 7),
(9, 'Ivan', 'Taylor', 'Marketing', 48000, '2020-08-11', 10),
(10, 'Judy', 'Anderson', 'Marketing', 50000, '2021-04-25', 10);

SELECT * FROM Employees;
SELECT first_name, last_name, department FROM Employees;

SELECT * FROM Employees
WHERE department = 'Sales';

SELECT * FROM Employees
WHERE salary > 60000;

SELECT * FROM Employees
WHERE hire_date > '2021-01-01';

SELECT * FROM Employees
ORDER BY salary DESC;

SELECT * FROM Employees
ORDER BY hire_date ASC;

SELECT DISTINCT department FROM Employees;

SELECT department, COUNT(*)
FROM Employees
GROUP BY department;

SELECT department, COUNT(*)
FROM Employees
GROUP BY department
HAVING COUNT(*) > 2;

SELECT department, AVG(salary)
FROM employees
GROUP BY department;

-----------------------------

SELECT * FROM Employees
WHERE department IN ('Sales', 'IT')
AND salary > 60000;

SELECT * FROM Employees
WHERE (first_name LIKE 'A%' or first_name LIKE 'C%')
AND salary < 60000;

SELECT * FROM employees
WHERE manager_id IS NULL;

SELECT * FROM employees
WHERE hire_date >= '2021-01-01';

SELECT * FROM employees
ORDER BY salary DESC
LIMIT 3;

WITH it_department AS (
    SELECT * FROM employees
    WHERE department = 'IT'
    ORDER BY salary DESC
)
    SELECT * FROM it_department
    ORDER BY hire_date ASC;

SELECT * FROM employees
WHERE department = 'IT'
ORDER BY salary DESC, hire_date ASC;

SELECT department, SUM(salary) AS total_salary FROM employees
GROUP BY department;

SELECT department, MIN(salary), MAX(salary)
FROM employees
GROUP BY department
ORDER BY department;

SELECT department, COUNT(*)
FROM employees
WHERE salary > 50000
GROUP BY department;

SELECT * FROM employees
WHERE salary > 50000;

SELECT department, AVG(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY department;

SELECT DISTINCT (department, manager_id)
FROM employees
WHERE manager_id IS NOT NULL;

SELECT department, COUNT(*) AS total_emp
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;

SELECT first_name, last_name, salary, salary * 12 AS annual_salary
FROM employees;

SELECT first_name, salary FROM employees
WHERE salary > (
    SELECT AVG(salary) FROM Employees
);

SELECT * FROM Employees
WHERE salary BETWEEN 45000 AND 70000
AND hire_date < '2022-01-01';

SELECT COUNT(department), COUNT(DISTINCT(department))
FROM Employees;

-- Query the two cities in STATION with the shortest and longest CITY names, 
-- as well as their respective lengths (i.e.: number of characters in the name). 
-- If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
-- The STATION table is described as follows:

(
    SELECT department, LENGTH(department) FROM Employees
    ORDER BY LENGTH(department) DESC,
    department ASC
    LIMIT 1
)
UNION ALL
(
    SELECT department, LENGTH(department) FROM Employees
    ORDER BY LENGTH(department) ASC,
    department ASC
    LIMIT 1 
)

-- Find highest salary in each department
SELECT department, MAX(salary) as highest_salary
FROM Employees
GROUP BY department;

-- Display all employees whose salary is greater than the average salary.
SELECT first_name, salary
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- List employees hired after 2020, ordered by hire date (newest first).
SELECT first_name, hire_date
FROM Employees
WHERE hire_date > '01-01-2020'
ORDER BY hire_date DESC;

-- Find the total salary paid to all employees who do not have a manager.
SELECT first_name, salary, (SELECT SUM(salary) as sum FROM Employees WHERE manager_id IS NULL)
FROM Employees
WHERE manager_id IS NULL;

-- List departments having more than 2 employees.
SELECT department, COUNT(*)
FROM Employees
GROUP BY department
HAVING COUNT(*) > 2;

-- Show the employee(s) with the second highest salary.
SELECT first_name, salary
FROM Employees
WHERE salary = (
    SELECT MAX(salary)
    FROM Employees
    WHERE salary < (SELECT MAX(salary) FROM Employees)
);

-- List all employees whose names start and end with the same letter.
SELECT first_name
FROM Employees
WHERE LOWER(LEFT(first_name, 1)) = LOWER(RIGHT(first_name, 1));

-- Display the average salary of employees who joined before 2021.
SELECT AVG(salary)
FROM Employees
WHERE hire_date < '2021-01-01'
GROUP BY department;

-- Find the department(s) where the minimum salary is greater than 50,000.
SELECT department, MIN(salary) AS min_salary
FROM Employees
GROUP BY department
HAVING MIN(salary) > 50000;

----- JOINS -----

-- Show each employee’s name along with their manager’s ID.
SELECT employee_id, manager_id
FROM Employees;

-- Show each employee’s name and their manager’s name (using self join).
SELECT 
    E.first_name || ' ' || E.last_name,
    M.first_name || ' ' || M.last_name
FROM Employees E
LEFT JOIN Employees M
ON E.manager_id = M.employee_id;

-- List all employees who are managers (i.e., whose ID appears as someone’s manager_id).
SELECT M.first_name || ' ' || M.last_name, M.employee_id
FROM Employees E
JOIN Employees M
ON E.manager_id = M.employee_id;

-- Find all employees who do not have a manager.
SELECT DISTINCT E.employee_id, E.manager_id, E.first_name
FROM Employees E
LEFT JOIN Employees M
ON E.employee_id = M.manager_id
WHERE E.manager_id IS NULL;

-- Show employees whose salary is greater than their manager’s salary.
SELECT E.employee_id, E.first_name, M.first_name, M.salary
FROM Employees E
LEFT JOIN Employees M
ON E.manager_id = M.employee_id
WHERE E.salary >= M.salary;

SELECT * FROM Employees;

-- Show employees who work in the same department as their manager.
SELECT E.employee_id, E.first_name, E.department, M.first_name AS manager, M.department as manager_dept
FROM Employees E
JOIN Employees M
ON E.manager_id = M.employee_id
WHERE E.department = M.department;

-- Find all managers who have more than one direct report.
SELECT manager_id, COUNT(*) AS count
FROM Employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING COUNT(*) > 1;

-- Display each manager along with the number of employees they manage.
SELECT M.employee_id, COUNT(E.employee_id)
FROM Employees M
LEFT JOIN Employees E
ON M.employee_id = E.manager_id
GROUP BY  M.employee_id
ORDER BY M.employee_id;

-- Find all employees whose manager was hired before them.
SELECT
    E.employee_id,
    E.first_name,
    E.hire_date,
    M.first_name AS manager,
    M.hire_date AS manager_hire_date
FROM Employees E
LEFT JOIN Employees M
ON E.manager_id = M.employee_id
WHERE E.hire_date < M.hire_date;

-- Find all employees who have the same last name as their manager.
SELECT
    E.first_name AS emp_fname,
    E.last_name AS emp_lname,
    M.first_name AS mng_fname,
    M.last_name AS mng_lname
FROM Employees E
JOIN Employees M
ON E.manager_id = M.employee_id
WHERE E.last_name = M.last_name;

-- Find all manager–employee pairs working in different departments.
SELECT
    E.first_name AS emp_fname,
    M.first_name AS mng_fname,
    E.department AS emp_dept,
    M.department AS mng_dept
FROM Employees E
JOIN Employees M
ON E.manager_id = M.employee_id
WHERE E.department = M.department;

-- Find all employees whose salary difference from their manager is more than 5000.
SELECT 
    E.employee_id,
    E.first_name,
    E.salary AS emp_salary,
    M.salary AS mng_salary
FROM Employees AS E
JOIN Employees AS M
ON E.manager_id = M.employee_id
WHERE (M.salary - E.salary) > 5000 ;



------ SUBQUERIES ------

-- Find all emp having highest salary in each department
SELECT * FROM Employees
WHERE (department, salary) IN (
    SELECT department, MAX(salary) FROM Employees
    GROUP BY department
);

-- Find department with more than 2 employees.
SELECT department, COUNT(*)
FROM Employees
GROUP BY department
HAVING COUNT(*) > 2;

-- AVG salary in each department.
SELECT department, AVG(salary)
FROM Employees
GROUP BY department;

-- Find employees in each department earning more than avg of that dept.
SELECT employee_id, first_name, department, salary FROM Employees AS e
WHERE salary >= (
    SELECT AVG(salary) FROM Employees WHERE department = e.department
);

SELECT * FROM Employees ORDER BY department;

-- Find employees in each department earning more than avg of that dept USIING JOINS.
SELECT 
    employee_id, 
    first_name, 
    department, 
    salary 
FROM Employees AS e
LEFT JOIN (
    SELECT department as dept, AVG(salary) AS avg_salary
    FROM Employees
    GROUP BY department
) AS d
ON e.department = d.dept
WHERE e.salary >= d.avg_salary;

-- Write a query to find the second highest salary from the employees table without using LIMIT or OFFSET.
SELECT * FROM Employees
WHERE salary = (
    SELECT MAX(salary) AS second_highest_salary
    FROM Employees
    WHERE salary < (SELECT MAX(salary) FROM Employees)
);

SELECT * FROM Employees;

ANALYZE employees;

EXPLAIN SELECT * FROM Employees
WHERE salary < 80000 AND name LIKE '%e';

CREATE INDEX idx_salary ON employees(salary);

EXPLAIN SELECT * FROM Employees
WHERE salary < 80000 AND name LIKE '%e';

EXPLAIN ANALYZE SELECT * FROM employees WHERE dept_id = 2;
EXPLAIN SELECT * FROM employees WHERE dept_id = 2;

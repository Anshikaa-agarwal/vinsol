DROP TABLE IF EXISTS Departments;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Commissions;

CREATE TABLE Departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30)
);

CREATE TABLE Employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    salary NUMERIC CHECK (salary >= 0),
    department_id INT,

    CONSTRAINT fk_departments
        FOREIGN KEY (department_id) REFERENCES Departments(id)
        ON DELETE CASCADE
);

CREATE TABLE Commissions (
    id SERIAL PRIMARY KEY,
    employee_id INT,
    commission_amt NUMERIC,

    CONSTRAINT fk_employees
     FOREIGN KEY (employee_id) REFERENCES Employees(id)
     ON DELETE CASCADE
);

CREATE INDEX commission_idx ON Commissions(commission_amt);

INSERT INTO Departments (name)
VALUES
    ('Banking'),
    ('Insurance'),
    ('Services');

INSERT INTO Employees (name, salary, department_id)
VALUES
    ('Chris Gayle', 1000000, 1),
    ('Michael Clarke', 800000, 2),
    ('Rahul Dravid', 700000, 1),
    ('Ricky Pointing', 600000, 2),
    ('Albie Morkel', 650000, 2),
    ('Wasim Akram', 750000, 3);


INSERT INTO Commissions (employee_id, commission_amt)
VALUES
    (1, 5000),
    (2, 3000),
    (3, 4000),
    (1, 4000),
    (2, 3000),
    (4, 2000),
    (5, 1000),
    (6, 5000);

-- i. Find the employee who gets the highest total commission.
WITH total_commissions AS (
    SELECT 
        e.id,
        e.name,
        SUM(c.commission_amt) AS total_commission
    FROM Employees e
    LEFT JOIN Commissions c
    ON e.id = c.employee_id
    GROUP BY e.id
)
SELECT e.*, tc.total_commission
FROM Employees e
LEFT JOIN total_commissions tc
ON e.id = tc.id
WHERE tc.total_commission = (
    SELECT MAX(total_commission) 
    FROM total_commissions
);

-- ii. Find employee with 4th Highest salary from employee table.
SELECT * FROM Employees e1
WHERE 3 = (
    SELECT COUNT(*)
    FROM Employees e2
    WHERE e2.salary > e1.salary
);

SELECT *
FROM Employees
ORDER BY salary DESC
OFFSET 3
LIMIT 1;

-- iii. Find department that is giving highest commission.
WITH dept_commission AS (
    SELECT 
        e.department_id,
        SUM(c.commission_amt) AS sum
    FROM Employees e
    LEFT JOIN Commissions c
    ON e.id = c.employee_id
    GROUP BY e.department_id
)
SELECT * FROM Departments d
WHERE d.id = (
    SELECT department_id FROM dept_commission
    WHERE sum = (
        SELECT MAX(sum) FROM dept_commission
    )
);

-- iv. Find employees getting commission more than 3000
    -- Display Output in following pattern:  
    --   Chris Gayle, Rahul Dravid  4000

SELECT 
    e.name,
    SUM(c.commission_amt) AS total_commission
FROM Employees e
JOIN Commissions c ON e.id = c.employee_id
GROUP BY e.id, e.name
HAVING SUM(c.commission_amt) > 3000;

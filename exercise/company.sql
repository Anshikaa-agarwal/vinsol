DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS Projects CASCADE;
DROP TABLE IF EXISTS Enrollments CASCADE; 
DROP TABLE IF EXISTS ProjectSkills CASCADE; 


CREATE TABLE Employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30)
);

CREATE TABLE Projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE ProjectSkills (
    project_id INT REFERENCES Projects(id) ON DELETE CASCADE,
    skill VARCHAR(30) NOT NULL,
    PRIMARY KEY (project_id, skill)
);

CREATE TYPE work_status AS ENUM ('completed', 'ongoing');

CREATE TABLE Enrollments (
    id SERIAL PRIMARY KEY,
    emp_id INT REFERENCES Employees(id) ON DELETE CASCADE,
    project_id INT REFERENCES Projects(id) ON DELETE CASCADE,
    status work_status
);

INSERT INTO Employees (name)
VALUES
    ('User A'),
    ('User B'),
    ('User C'),
    ('User D'),
    ('User E'),
    ('User F'),
    ('User G');

INSERT INTO Projects (name) 
VALUES
    ('P1'),
    ('P2'),
    ('P3'),
    ('P4'),
    ('P5'),
    ('P6'),
    ('P7'),
    ('P8'),
    ('P9');

INSERT INTO Enrollments (emp_id, project_id, status)
VALUES
    (1, 1, 'completed'),
    (1, 2, 'completed'),
    (1, 3, 'completed'),
    (1, 6, 'ongoing'),
    (2, 1, 'completed'),
    (2, 3, 'completed'),
    (2, 7, 'completed'),
    (2, 9, 'completed'),
    (3, 1, 'completed'),
    (3, 2, 'completed'),
    (3, 8, 'completed'),
    (3, 9, 'completed'),
    (4, 1, 'completed'),
    (4, 2, 'completed'),
    (4, 4, 'completed'),
    (4, 5, 'ongoing'),
    (4, 6, 'ongoing');

INSERT INTO ProjectSkills (project_id, skill)
VALUES 
    (1, 'HTML'),
    (1, 'Javascript'),
    (1, 'Ruby'),
    (1, 'Rails'),
    (2, 'IOS'),
    (3, 'Android'),
    (4, 'IOS'),
    (4, 'Android'),
    (5, 'Ruby'),
    (5, 'Rails'),
    (6, 'Android'),
    (6, 'HTML'),
    (6, 'Javascript'),
    (7, 'Android'),
    (7, 'IOS'),
    (8, 'HTML'),
    (8, 'Javascript'),
    (8, 'Ruby'),
    (8, 'Rails'),
    (8, 'Android'),
    (9, 'IOS');


-- View tables
SELECT * FROM employees;
SELECT * FROM projects;
SELECT * FROM projectskills;
SELECT * FROM enrollments;

-- 1) Find names of all employees currently not working in any projects. (Use joins)
SELECT e.name
FROM Employees e
LEFT JOIN Enrollments en 
    ON e.id = en.emp_id AND en.status = 'ongoing'
WHERE en.emp_id IS NULL;

-- 2) Find all employees who have exposure to HTML, Javascript and IOS.
SELECT DISTINCT e.emp_id, p.skill FROM enrollments e
LEFT JOIN projectskills p ON e.project_id = p.project_id
WHERE p.skill IN ('HTML', 'Javascript', 'IOS')
ORDER BY e.emp_id;

-- 3) Find the technologies in which a particular employee(Say B) has expertise(3 or more projects)
SELECT ps.skill FROM enrollments e
LEFT JOIN projectskills ps ON e.project_id = ps.project_id
WHERE emp_id = (SELECT id FROM Employees WHERE name = 'User A')
GROUP BY ps.skill
HAVING COUNT(DISTINCT e.project_id) >= 2;

-- 4) Find the employee who has done most no of projects in android (do this using variable also).
SELECT e.emp_id, COUNT(*) as total_android_projects
FROM Enrollments e
LEFT JOIN ProjectSkills ps
ON e.project_id = ps.project_id
WHERE ps.skill = 'Android'
GROUP BY e.emp_id
ORDER BY total_android_projects DESC
LIMIT 1;
DROP TABLE IF EXISTS Workers;
DROP TABLE IF EXISTS Bonus;

-- Create tables
CREATE TABLE Workers (
    worker_id SERIAL PRIMARY KEY,
    first_name VARCHAR(25),
    last_name VARCHAR(25),
    salary INT,
    joining_date TIMESTAMP,
    department VARCHAR(30)
);

CREATE TABLE Bonus (
    worker_id INT,
    bonus_amt INT,
    bonus_date DATE,

    FOREIGN KEY (worker_id) REFERENCES Workers(worker_id)
);

CREATE TABLE Title (
    worker_id INT,
    worker_title VARCHAR(25),
    affected_from TIMESTAMP,
    FOREIGN KEY (worker_id)
        REFERENCES Workers(worker_id)
        ON DELETE CASCADE
);

-- Insert values
INSERT INTO Workers (worker_id, first_name, last_name, salary, joining_date, department)
VALUES
    (1, 'Monika', 'Arora', 100000, '2014-02-20 09:00:00', 'HR'),
    (2, 'Niharika', 'Verma', 80000, '2014-06-11 09:00:00', 'Admin'),
    (3, 'Vishal', 'Singhal', 300000, '2014-02-20 09:00:00', 'HR'),
    (4, 'Amitabh', 'Singh', 500000, '2014-02-20 09:00:00', 'Admin'),
    (5, 'Vivek', 'Bhati', 500000, '2014-06-11 09:00:00', 'Admin'),
    (6, 'Vipul', 'Diwan', 200000, '2014-06-11 09:00:00', 'Account'),
    (7, 'Satish', 'Kumar', 75000, '2014-01-20 09:00:00', 'Account'),
    (8, 'Geetika', 'Chauhan', 90000, '2014-04-11 09:00:00', 'Admin');

INSERT INTO Bonus (worker_id, bonus_amt, bonus_date)
VALUES
    (1, 5000, '2016-02-20'),
    (2, 3000, '2016-06-11'),
    (3, 4000, '2016-02-20'),
    (1, 4500, '2016-02-20'),
    (2, 3500, '2016-06-11');

INSERT INTO Title (worker_id, worker_title, affected_from)
VALUES
    (1, 'Manager', '2016-02-20 00:00:00'),
    (2, 'Executive', '2016-06-11 00:00:00'),
    (8, 'Executive', '2016-06-11 00:00:00'),
    (5, 'Manager', '2016-06-11 00:00:00'),
    (4, 'Asst. Manager', '2016-06-11 00:00:00'),
    (7, 'Executive', '2016-06-11 00:00:00'),
    (6, 'Lead', '2016-06-11 00:00:00'),
    (3, 'Lead', '2016-06-11 00:00:00');


-- Display data
SELECT * FROM Workers;
SELECT * FROM Bonus;
SELECT * FROM Title;

-- Q-1. Write an SQL query to fetch "FIRST_NAME" from Worker table using the alias name as <WORKER_NAME>.
SELECT first_name AS WORKER_NAME FROM Workers;

-- Q-2. Write an SQL query to fetch "FIRST_NAME" from Worker table in upper case.
SELECT upper(first_name) FROM Workers;

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT DISTINCT(department) FROM Workers;

-- Q-4. Write an SQL query to print the first three characters of FIRST_NAME from Worker table.
SELECT SUBSTRING(first_name, 1, 3) FROM Workers ;

-- Q-5. Write an SQL query to find the position of the alphabet ('b') in the first name column 'Amitabh' from Worker table.
SELECT POSITION('b' in first_name) FROM Workers 
WHERE first_name = 'Amitabh';

-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
SELECT TRIM(both ' ' FROM first_name) FROM workers;

-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
SELECT LTRIM(department) FROM Workers;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
SELECT DISTINCT department, length(department) FROM Workers;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME
SELECT (first_name || ' ' || last_name) AS COMPLETE_NAME FROM Workers;

-- A space char should separate them.
SELECT regexp_split_to_array(COMPLETE_NAME, ' ') FROM workers;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM workers
ORDER BY first_name ASC;

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by
-- FIRST_NAME Ascending and DEPARTMENT Descending.
SELECT * FROM workers
ORDER BY first_name ASC, department DESC;

-- Q-13. Write an SQL query to print details for Workers with the first name as "Vipul" and "Satish" from Worker table.
SELECT * FROM workers
WHERE first_name = 'Vipul' OR first_name = 'Satish';

-- Q-14. Write an SQL query to print details of workers excluding first names, "Vipul" and "Satish" from Worker table.
SELECT * FROM workers
WHERE first_name NOT IN ('Vipul', 'Satish');

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as "Admin*".
SELECT * FROM workers
WHERE department ILIKE 'ADMIN%';

-- Q-16. Write an SQL query to print details of the Workers whose FIRST NAME contains 'a'
SELECT * FROM Workers
WHERE first_name ~* 'A';

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with 'a'.
SELECT * FROM Workers
WHERE first_name LIKE '%a';

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with 'h' and contains six alphabets.
SELECT * FROM Workers
WHERE first_name ~ '^[A-Za-z]{5}h$';

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
SELECT * FROM Workers
WHERE salary BETWEEN 100000 AND 500000;

-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb'2014.
SELECT * FROM Workers
WHERE EXTRACT(YEAR FROM joining_date) = 2014
AND EXTRACT(MONTH FROM joining_date) = 02;

-- Q-21. Write an SQL query to fetch the count of employees working in the department 'Admin'.
SELECT  department, COUNT(*)
FROM Workers 
WHERE department = 'Admin'
GROUP BY department;

-- Q-22. Write an SQL query to fetch worker full names with salaries >= 50000 and <= 100000.
SELECT 
    first_name || ' ' || last_name AS name,
    salary
FROM Workers
WHERE salary >= 50000
AND salary <= 100000;

-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT department, COUNT(*) FROM Workers
GROUP BY department
ORDER BY COUNT(*) DESC;

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
SELECT * FROM Workers w
LEFT JOIN Title t
ON w.worker_id = t.worker_id
WHERE t.worker_title = 'Manager';

-- Q-25. Write an SQL query to fetch number (more than 1) of different titles in the ORG.
SELECT COUNT(DISTINCT worker_title)
FROM Title;

-- Q-26. Write an SQL query to show only odd rows from a table.
SELECT * FROM Workers
WHERE (worker_id % 2) <> 0;

-- Q-27. Write an SQL query to show only even rows from a table.
SELECT * FROM Workers
WHERE (worker_id % 2) = 0;

-- Q-28. Write an SQL query to clone a new table from another table.
CREATE TABLE Cloned_workers AS
SELECT * FROM Workers;

SELECT * FROM Cloned_workers;

-- 0-29. Write an SQL query to fetch intersecting records of two tables.
SELECT * FROM Workers w
INNER JOIN Bonus b
ON w.worker_id = b.worker_id
ORDER BY w.worker_id;

-- Q-30. Write an SQL query to show records from one table that another table does not have.
SELECT * FROM Workers w
LEFT JOIN Bonus b
ON w.worker_id = b.worker_id
WHERE b.bonus_amt IS NULL;

-- Q-31. Write an SQL query to show the current date and time.
SELECT CURRENT_TIME;
SELECT CURRENT_DATE;
SELECT NOW();
SELECT TIMEOFDAY();

-- Q-32. Write an SQL query to show the top n (say 5) records of a table order by descending salary.
SELECT DISTINCT COMPLETE_NAME, salary FROM Workers
ORDER BY salary DESC
LIMIT 5;

-- 0-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
SELECT DISTINCT COMPLETE_NAME, salary FROM Workers
ORDER BY salary DESC
LIMIT 1 OFFSET 4;

-- Q-34. Write an SQL query to determine the 5th highest salary without using LIMIT keyword.
SELECT DISTINCT MAX(salary) FROM Workers w1
WHERE 4 = (
    SELECT COUNT(*) FROM Workers w2
    WHERE w1.salary < w2.salary
);

-- Q-35. Write an SQL query to fetch the list of employees with the same salary.
SELECT DISTINCT w1.COMPLETE_NAME, w2.COMPLETE_NAME, w1.salary FROM Workers w1
CROSS JOIN Workers w2
WHERE w1.salary = w2.salary
AND w1.worker_id < w2.worker_id;

-- Q-36. Write an SQL query to show the second highest salary from a table.
SELECT DISTINCT MAX(salary) FROM Workers
WHERE salary < (SELECT MAX(SALARY) FROM Workers);

-- 0-37. Write an SQL query to show one row twice in results from a table.
SELECT * FROM Workers
UNION ALL
SELECT * FROM Workers;

-- 0-38. Write an SQL query to list worker id who does not get bonus.
SELECT w.COMPLETE_NAME, b.bonus_amt
FROM Workers w
LEFT JOIN Bonus b
ON w.worker_id = b.worker_id
WHERE b.bonus_amt IS NULL;

-- 0-38. Write an SQL query to list first 50% of records from a table.
SELECT * FROM Workers
WHERE worker_id <= (SELECT MAX(worker_id) FROM Workers)/2;

-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in it.
SELECT department, COUNT(*) FROM Workers
GROUP BY department
HAVING COUNT(*) < 4;

-- Q-41. Write an SQL query to show all departments along with the number of people in there.
SELECT department, COUNT(*) FROM Workers
GROUP BY department;

-- Q-42. Write an SQL query to show the last record from a table.
SELECT * FROM Workers
WHERE worker_id = (
    SELECT worker_id FROM Workers 
    ORDER BY worker_id DESC 
    LIMIT 1
);

-- Q-43. Write an SQL query to fetch the first row of a table.
SELECT * FROM Workers
WHERE worker_id = (
    SELECT worker_id FROM Workers 
    ORDER BY worker_id ASC 
    LIMIT 1
);


-- Q-44. Write an SQL query to fetch the last five records from a table.
SELECT * FROM Workers
ORDER BY worker_id DESC
LIMIT 5;

-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
SELECT department, salary
FROM Workers w
WHERE SALARY = (
    SELECT MAX(SALARY) FROM Workers WHERE department = w.department
)
GROUP BY department;

-- Q-46. Write an SQL query to fetch three max salaries from a table.
SELECT * FROM Workers
ORDER BY salary DESC
LIMIT 3;

-- Q-47. Write an SQL query to fetch three min salaries from a table.
SELECT * FROM Workers
ORDER BY salary
LIMIT 3;
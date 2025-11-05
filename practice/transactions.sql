DROP TABLE IF EXISTS Employees;

CREATE TABLE Employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30),
    dept VARCHAR(30),
    salary INT
);

DELETE FROM Employees;

BEGIN;

INSERT INTO Employees (name, dept, salary)
VALUES ('John', 'Engineer', 1200000);

SAVEPOINT sp1;

INSERT INTO Employees (name, dept, salary)
VALUES ('Belly', 'Creative', 1500000);

ROLLBACK TO SAVEPOINT sp1;
COMMIT;

SELECT * FROM Employees;


BEGIN;

INSERT INTO Books (title, stock) VALUES ('Book A', 5);

SAVEPOINT sp1;  -- mark a savepoint

INSERT INTO Books (book_id, title, stock) VALUES (12, 'Book B', 10);

-- Something goes wrong, rollback only last insert
ROLLBACK TO SAVEPOINT sp1;

COMMIT;

SELECT * FROM Books;
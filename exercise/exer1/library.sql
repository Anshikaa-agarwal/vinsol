-- DROP IF ALREADY EXISTS
DROP TABLE IF EXISTS Holdings;
DROP TABLE IF EXISTS Titles;
DROP TABLE IF EXISTS Branch;

-- CREATE TABLES
CREATE TABLE IF NOT EXISTS Branch (
    bcode VARCHAR(5) PRIMARY KEY,
    librarian VARCHAR(20),
    address TEXT UNIQUE
);

CREATE TABLE IF NOT EXISTS Titles (
    title VARCHAR(20) PRIMARY KEY,
    author VARCHAR(30),
    publisher VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS Holdings (
    branch VARCHAR(5),
    title VARCHAR(20),
    copies INT,

    PRIMARY KEY(branch, title),
    FOREIGN KEY (branch) REFERENCES Branch(bcode),
    FOREIGN KEY(title) REFERENCES Titles(title)
);

-- INSERT VALUES
-- Branch
INSERT INTO Branch VALUES
('B1', 'John Smith', '2 Anglesea Rd'),
('B2', 'Mary Jones', '34 Pearse St'),
('B3', 'Francis Owens', 'Grange X');

-- Titles
INSERT INTO Titles VALUES
('Susannah', 'Ann Brown', 'Macmillan'),
('How to Fish', 'Amy Fly', 'Stop Press'),
('A History of Dublin', 'David Little', 'Wiley'),
('Computers', 'Blaise Pascal', 'Applewoods'),
('The Wife', 'Ann Brown', 'Macmillan');

-- Holdings
INSERT INTO Holdings VALUES
('B1', 'Susannah', 3),
('B1', 'How to Fish', 2),
('B1', 'A History of Dublin', 1),
('B2', 'How to Fish', 4),
('B2', 'Computers', 2),
('B2', 'The Wife', 3),
('B2', 'A History of Dublin', 1),
('B3', 'Computers', 4),
('B3', 'Susannah', 3),
('B3', 'The Wife', 1);

-- (i) the names of all library books published by Macmillan
SELECT title FROM Titles 
WHERE publisher = 'Macmillan';

-- (ii) branches that hold any books by Ann Brown (nested subquery).
SELECT * FROM Branch 
WHERE bcode IN (
    SELECT DISTINCT branch FROM Holdings 
    WHERE title IN (
        SELECT title FROM Titles 
        WHERE author = 'Ann Brown'
    )   
);

-- (iii) branches that hold any books by Ann Brown (without nested subquery).
SELECT DISTINCT b.* FROM Branch b
LEFT JOIN (
    SELECT * FROM Holdings h
    RIGHT JOIN (
        SELECT * FROM Titles  
        WHERE author = 'Ann Brown'
    ) AS books
    ON h.title = books.title
) AS matched
ON b.bcode = matched.branch;

-- (iv) Total number of books held at each branch
SELECT branch, SUM(copies) FROM Holdings
GROUP BY branch
ORDER BY branch;
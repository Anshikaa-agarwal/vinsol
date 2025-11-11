DROP TABLE IF EXISTS Sandwiches;
DROP TABLE IF EXISTS Tastes;
DROP TABLE IF EXISTS Locations;

CREATE TABLE IF NOT EXISTS Tastes (
    name VARCHAR(50),
    filling VARCHAR(80),
    PRIMARY KEY (name, filling)
);

CREATE TABLE IF NOT EXISTS Locations (
    lname VARCHAR(80) PRIMARY KEY,
    phone NUMERIC UNIQUE,
    address TEXT
);

CREATE TABLE IF NOT EXISTS Sandwiches (
    location VARCHAR(80),
    bread VARCHAR(20),
    filling CHAR(80),
    price DECIMAL,

    PRIMARY KEY (location, bread, filling),
    FOREIGN KEY (location) REFERENCES Locations(lname)
);

-- Insert data
-- LOCATIONS
INSERT INTO Locations VALUES
('Lincoln', 6834523, 'Lincoln Place'),
('O''Neill''s', 6742134, 'Pearse St'),
('Old Nag', 7678132, 'Dame St'),
('Buttery', 7023421, 'College St');

-- TASTES
INSERT INTO Tastes VALUES
('Brown', 'Turkey'),
('Brown', 'Beef'),
('Brown', 'Ham'),
('Jones', 'Cheese'),
('Green', 'Beef'),
('Green', 'Turkey'),
('Green', 'Cheese');

-- SANDWICHES
INSERT INTO Sandwiches VALUES
('Lincoln', 'Rye', 'Ham', 1.25),
('O''Neill''s', 'White', 'Cheese', 1.20),
('O''Neill''s', 'Whole', 'Ham', 1.25),
('Old Nag', 'Rye', 'Beef', 1.35),
('Buttery', 'White', 'Cheese', 1.00),
('O''Neill''s', 'White', 'Turkey', 1.35),
('Buttery', 'White', 'Ham', 1.10),
('Lincoln', 'Rye', 'Beef', 1.35),
('Lincoln', 'White', 'Ham', 1.30),
('Old Nag', 'Rye', 'Ham', 1.40);

-- (i)

SELECT DISTINCT location FROM Sandwiches
WHERE filling = (
    -- Find what filling 'Jones' likes
    SELECT filling FROM Tastes 
    WHERE name = 'Jones'
);

-- (ii)

SELECT DISTINCT s.location FROM Tastes t
JOIN Sandwiches s
ON t.filling = s.filling
WHERE t.name = 'Jones';


-- (iii)
SELECT f.location, COUNT(DISTINCT t.name) FROM Tastes t
FULL JOIN (
    -- find different fillings a location offers
    SELECT DISTINCT location, filling 
    FROM Sandwiches
) AS f
ON t.filling = f.filling
GROUP BY f.location;

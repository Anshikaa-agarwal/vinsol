CREATE TABLE weather (
 city varchar(80),
 temp_lo int, -- low temperature
 temp_hi int, -- high temperature
 prcp real, -- precipitation
 date date
);

CREATE TABLE cities (
    name VARCHAR(30),
    location POINT
);

INSERT INTO weather (city, temp_lo, temp_hi, prcp, date) 
VALUES
    ('New York', 32, 45, 0.25, '2025-01-10'),
    ('Los Angeles', 55, 75, 0.00, '2025-01-10'),
    ('Chicago', 20, 35, 0.10, '2025-01-11'),
    ('Miami', 65, 82, 0.05, '2025-01-11'),
    ('Seattle', 40, 52, 0.50, '2025-01-12'),
    ('Denver', 25, 48, 0.00, '2025-01-13'),
    ('Boston', 28, 43, 0.30, '2025-01-14'),
    ('San Francisco', 50, 68, 0.12, '2025-01-15'),
    ('Dallas', 45, 70, 0.00, '2025-01-15'),
    ('Phoenix', 60, 85, 0.00, '2025-01-16');


INSERT INTO cities (name, location) 
VALUES
    ('New York', POINT(40.7128, -74.0060)),
    ('Los Angeles', POINT(34.0522, -118.2437)),
    ('Chicago', POINT(41.8781, -87.6298)),
    ('Houston', POINT(29.7604, -95.3698)),
    ('Phoenix', POINT(33.4484, -112.0740)),
    ('Philadelphia', POINT(39.9526, -75.1652)),
    ('San Antonio', POINT(29.4241, -98.4936)),
    ('San Diego', POINT(32.7157, -117.1611)),
    ('Dallas', POINT(32.7767, -96.7970)),
    ('San Jose', POINT(37.3382, -121.8863));

SELECT * FROM weather;
SELECT * FROM cities;

SELECT w.*, c.location
FROM weather as w
LEFT JOIN cities AS c
ON c.name = w.city;

-- List all cities in the cities table, and show their latest known weather data (if any).
SELECT c.*, w.temp_hi, w.temp_lo, w.prcp, w.date
FROM cities AS c
LEFT JOIN weather AS w
ON c.name = w.city;

-- List all weather records that don’t have a matching city in the cities table.
SELECT w.*
FROM weather AS w
LEFT JOIN cities AS c
ON w.city = c.name
WHERE location IS NULL;

-- Show all city-weather pairs whether or not a match exists in both tables.
SELECT COALESCE(w.city, c.name) AS city,  -- pick whichever city name exists
    w.temp_lo,
    w.temp_hi,
    w.prcp,
    w.date,
    c.location
FROM cities AS c
FULL JOIN weather AS w
ON w.city = c.name
ORDER BY city;

-- List all cities where precipitation (prcp) was greater than 0.2, 
-- along with their coordinates.
SELECT c.name, c.location, w.prcp
FROM cities AS c
LEFT JOIN weather AS w
ON c.name = w.city
WHERE w.prcp > 0.2;

-- Show all cities that have weather data (use INNER JOIN).
SELECT w.*, c.location
FROM cities AS c
INNER JOIN weather AS w
ON c.name = w.city;

-- Show all weather records along with city locations, 
-- even if the city’s location is not available.
SELECT w.*, c.location
FROM weather AS w
LEFT JOIN cities AS c
ON c.name = w.city;

-- Show all cities from the cities table along with their 
-- weather data if available.
SELECT c.*, w.temp_hi, w.temp_lo, w.prcp, w.date
FROM cities AS c 
LEFT JOIN weather AS w
ON w.city = c.name;

-- Show all cities from both tables, even if they don’t match.
SELECT
    COALESCE(c.name, w.city) AS city,
    w.temp_lo,
    w.temp_hi,
    w.prcp,
    w.date,
    c.location
FROM cities AS c
FULL JOIN weather AS w
ON w.city = c.name;

-- Show city name, temperature, and precipitation for cities where prcp > 0.2.
SELECT c.name, w.temp_hi, w.temp_lo, w.prcp
FROM cities AS c
INNER JOIN weather AS w
ON w.city = c.name
WHERE w.prcp > 0.2;

-- Show all cities that have no weather data.
SELECT c.*
FROM cities AS c
LEFT JOIN weather AS w
ON w.city = c.name
WHERE w.city IS NULL;

-- Show all weather entries where the city exists in the cities table.
SELECT w.*
FROM weather AS w
INNER JOIN cities AS c
ON w.city = c.name;

-- Show all cities where temp_hi is greater than 70 and location is known.
SELECT w.city, w.temp_hi, c.location
FROM weather AS w
INNER JOIN cities AS c
ON w.city = c.name
WHERE w.temp_hi > 70;

-- Show each city’s name, average temperature ((temp_lo + temp_hi)/2), and location.
SELECT C.name, (W.temp_hi + W.temp_lo)/2 AS avg_temp, C.location
FROM cities AS C
INNER JOIN weather AS W
ON C.name = W.city;

-- Show all cities (from both tables) ordered by precipitation (highest first).
SELECT 
    COALESCE(w.city, c.name) AS city,
    w.prcp
FROM weather AS w
FULL JOIN cities AS c
ON w.city = c.name
ORDER BY w.prcp DESC;

-- Show only those cities whose weather entry is missing (NULL) in the weather table.
SELECT C.name, W.*
FROM cities AS C
LEFT JOIN weather AS W
ON W.city = C.name
WHERE W.city IS NULL;

-- Show the count of weather entries available per city 
-- (include cities with zero entries).
SELECT C.name, COUNT(W.city)
FROM cities AS C
LEFT JOIN weather AS W
ON W.city = C.name
GROUP BY C.name;

-- Find the average temp_hi for cities that exist in both tables.
SELECT C.name, AVG(W.temp_hi) AS avg_temp_hi
FROM cities AS C
INNER JOIN weather AS W
ON C.name = W.city
GROUP BY C.name;

-- Show all unique city names that appear in either table.
SELECT COALESCE(W.city, C.name) AS city
FROM weather AS W
FULL JOIN cities AS C
ON C.name = W.city;

SELECT city FROM weather
UNION
SELECT name FROM cities;

-- Display each city’s highest and lowest temperature recorded (if available).

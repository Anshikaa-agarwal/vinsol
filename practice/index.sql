DROP TABLE IF EXISTS Addresses;

CREATE TABLE Addresses (
    address_id SERIAL PRIMARY KEY,
    address VARCHAR(200),
    address2 VARCHAR(200),
    district VARCHAR(20),
    city_id INT,
    postal_code INT,
    phone BIGINT,
    last_update DATE
);

-- Insert 150 dummy records
INSERT INTO Addresses (address, address2, district, city_id, postal_code, phone, last_update)
SELECT 
    'Street ' || (i % 100) || ' Block ' || (i % 10),
    'Apartment ' || (i % 50),
    CASE 
        WHEN i % 5 = 0 THEN 'North'
        WHEN i % 5 = 1 THEN 'South'
        WHEN i % 5 = 2 THEN 'East'
        WHEN i % 5 = 3 THEN 'West'
        ELSE 'Central'
    END AS district,
    (i % 20) + 1 AS city_id,
    100000 + (i * 7) % 900000 AS postal_code,
    9000000000 + i AS phone,
    CURRENT_DATE - (i % 365)
FROM generate_series(1,150) AS s(i);

SELECT * FROM Addresses;


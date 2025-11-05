-- Given a table storing 3 sides of a triangle.
-- Based on the value of sides, return type of triangle

CREATE TABLE Triangle (
    A INT DEFAULT 1,
    B INT DEFAULT 1,
    C INT DEFAULT 1
);

INSERT INTO Triangle
VALUES
    (1, 2, 3),
    (3, 3, 3),
    (4, 4, 5),
    (1, 1, 10);

SELECT * FROM triangle;

SELECT 
    CASE
        WHEN (A+B <= C) OR (B+C <= A) OR (C+A <= B) THEN 'Not A Triangle'
        WHEN A = B AND B = C THEN 'Equilateral'
        WHEN (A = B AND B != C) OR  (A = C AND C != B) OR (C = B AND A != C) THEN 'Isosceles'
        WHEN (A != B AND B != C) THEN 'Scalene'
    END as type
FROM triangle;

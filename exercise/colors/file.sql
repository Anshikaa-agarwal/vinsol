DROP TABLE IF EXISTS Colors CASCADE;
DROP TABLE IF EXISTS Mixtures CASCADE;

CREATE TABLE Colors (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    density NUMERIC NOT NULL
);

CREATE TABLE Mixtures (
    id SERIAL PRIMARY KEY,
    parent1_id INT REFERENCES Colors(id) ON DELETE CASCADE,
    parent2_id INT REFERENCES Colors(id) ON DELETE CASCADE,
    mix_Id INT REFERENCES Colors(id),
    mix_density NUMERIC,
    parent1_perc NUMERIC NOT NULL,
    parent2_perc NUMERIC NOT NULL
);

INSERT INTO Colors  VALUES
(10, 'Red',    0.20),
(11, 'Green',  0.30),
(12, 'Blue',   0.40),
(13, 'Yellow', 0.20),
(14, 'Pink',   0.30),
(15, 'Cyan',   0.40),
(16, 'White',  0.28);

INSERT INTO Mixtures (parent1_id, parent2_id, mix_id, mix_density, parent1_perc, parent2_perc)
VALUES
(10, 11, 13, 0.60, 30, 70),
(10, 12, 14, 0.50, 50, 50),
(11, 12, 15, 0.75, 40, 60),
(10, 13, 16, 0.38, 80, 20);

SELECT * FROM colors;
SELECT * FROM mixtures;

-- Make indexes
CREATE INDEX idx_mixtures_parent1 ON Mixtures(parent1_id);
CREATE INDEX idx_mixtures_parent2 ON Mixtures(parent2_id);
CREATE INDEX idx_mixtures_mixid ON Mixtures(mix_id);

CREATE INDEX idx_colors_red ON Colors(name) WHERE name ILIKE 'red';

-- 1. Find the colors that can be clubbed with 'Red' and also name the resulting color
SELECT
    CASE
    WHEN m.parent1_id = red.id THEN c2.name
    WHEN m.parent2_id = red.id THEN c1.name
    END AS "combine with",
    result.name AS "resulting color"
FROM mixtures m
JOIN colors red ON red.name ILIKE 'red'
JOIN colors c1 ON c1.id = m.parent1_id
JOIN colors c2 ON c2.id = m.parent2_id
JOIN colors result ON result.id = m.mix_id
WHERE m.parent1_id = red.id OR m.parent2_id = red.id;

-- Find mixtures that can be formed without 'Red'
SELECT name FROM Colors 
WHERE id IN (
    SELECT m.mix_Id FROM Mixtures m
    WHERE (SELECT id FROM Colors WHERE name ILIKE 'RED') 
    NOT IN (parent1_id, parent2_id)
);

-- 3. Find the mixtures that have one common parent
SELECT 
    parent.name AS "parent name",
    string_agg(mix.name, ' & ') AS "possible mixture"
FROM (
    SELECT parent1_id AS parent_id, mix_id FROM Mixtures
    UNION ALL
    SELECT parent2_id AS parent_id, mix_id FROM Mixtures
) AS p
JOIN Colors parent ON parent.id = p.parent_id
JOIN Colors mix ON mix.id = p.mix_id
GROUP BY parent.name;

-- 4. Find parent colors(as a couple) that give mix colors with density higher than the color density originally
SELECT
    m.parent1_id || ' & ' || m.parent2_id AS "parent colors",
    m.mix_id,
    m.mix_density,
    c.density AS "original density"
FROM Mixtures m 
LEFT JOIN Colors c ON m.mix_Id = c.id
WHERE m.mix_density > c.density;

-- 5. calculate the total amount of color 'Red'(in kgs) needed to make a 1kg mix each for its possible mixtures(yellow,pink..)
SELECT 
    ROUND((SUM(
        CASE 
            WHEN m.parent1_id = red.id THEN m.parent1_perc / 100.0
            WHEN m.parent2_id = red.id THEN m.parent2_perc / 100.0
        END
    )), 2) AS amount
FROM mixtures m
JOIN colors red ON red.name ILIKE 'red'
WHERE m.parent1_id = red.id OR m.parent2_id = red.id;
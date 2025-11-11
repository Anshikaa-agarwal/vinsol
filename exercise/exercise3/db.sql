DROP TABLE IF EXISTS Users CASCADE;
DROP TABLE IF EXISTS Articles CASCADE;
DROP TABLE IF EXISTS Comments CASCADE;
DROP TABLE IF EXISTS Categories CASCADE;

-- i) manage(create, update, delete) categories, articles, comments, and users

CREATE TYPE user_role AS ENUM ('admin', 'normal');

-- CREATING TABLES
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    role user_role DEFAULT 'normal'
);

CREATE TABLE Categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL
);

CREATE TABLE Articles (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    author_id INT,
    category_id INT,

    CONSTRAINT fk_users
        FOREIGN KEY (author_id) REFERENCES Users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_categories
        FOREIGN KEY (category_id) REFERENCES Categories(id)
        ON DELETE CASCADE
);

CREATE TABLE Comments (
    id SERIAL PRIMARY KEY,
    user_id INT,
    article_id INT,
    context TEXT NOT NULL,

    CONSTRAINT fk_users
        FOREIGN KEY (user_id) REFERENCES Users(id)
        ON DELETE CASCADE,
    
    CONSTRAINT fk_articles
        FOREIGN KEY (article_id) REFERENCES Articles(id)
        ON DELETE CASCADE
);

-- Insert dummy values
INSERT INTO Users (name)
VALUES 
('User1'),
('User2'),
('User3'),
('User4'),
('User5'),
('CorruptedUser1'),
('CorruptedUser2');

INSERT INTO Categories (name)
VALUES
('Technology'),
('Health'),
('Sports'),
('Education'),
('Entertainment'),
('History');


INSERT INTO Articles (title, author_id, category_id)
VALUES
('AI and the Future', 1, 1),
('Staying Fit in 2025', 2, 2),
('Olympics Highlights', 3, 3),
('Online Learning Platforms', 3, 4),
('Movie Review: Sci-Fi Era', 4, 5),
('Healthy Eating Tips', 2, 2),
('Tech Startups to Watch', 3, 1);


INSERT INTO Comments (user_id, article_id, context)
VALUES
(1, 1, 'Great article!'),
(2, 1, 'Very informative.'),
(3, 2, 'I totally agree!'),
(4, 3, 'Nice coverage!'),
(5, 3, 'Exciting games!'),
(3, 3, 'Loved this!'),
(2, 4, 'Very useful info!'),
(2, 5, 'Interesting take.'),
(3, 5, 'Good read!'),
(3, 7, 'Startup scene is booming!'),
(3, 7, 'Can’t wait for more!');


-- Delete some values from Comments
DELETE FROM Comments
WHERE article_id = 4;

-- Update in Comments
ALTER TABLE Comments
ADD CONSTRAINT check_length CHECK (length(context) < 500);

-- Delete from Users
DELETE FROM Users
WHERE name LIKE 'Corrupted%';

-- Update in Users
ALTER TABLE Users
ALTER COLUMN name TYPE VARCHAR(20); -- changes from VARCHAR(30) to VARCHAR(20)

-- Delete from Category
DELETE FROM Categories
WHERE name ~ 'y$';

-- Update a category name
UPDATE Categories
SET name = 'Science & Technology'
WHERE name = 'Technology';

-- Update Articles
UPDATE Articles
SET 
    title = 'Quantum Computing Revolution',
    category_id = 1
WHERE id = 1;

-- Delete an article
DELETE FROM Articles
WHERE id = 2;

-- ii) select all articles whose author's name is user3

SELECT 
    a.*,
    u.name AS author_name 
FROM articles a
INNER JOIN users u
ON a.author_id = u.id
WHERE u.name = 'User3';

-- using variable
-- \set author_name 'User3'
SELECT 
    a.*,
    u.name AS author_name 
FROM articles a
INNER JOIN users u
ON a.author_id = u.id
WHERE u.name = :'author_name';

-- iii) a)(Joins) For all the articles being selected above, select all the articles 
-- and also the comments associated with those articles in a single query.

SELECT 
    a.id, 
    a.title, 
    c.context
FROM articles a
INNER JOIN users u ON a.author_id = u.id
LEFT JOIN comments c ON c.article_id = A.id
WHERE u.name = 'User3';

-- iii) b)(Subquery) For all the articles being selected above, select all the articles 
-- and also the comments associated with those articles in a single query.

SELECT
    a.id, 
    a.title,
    (
        SELECT context FROM Comments c 
        WHERE c.article_id = a.id
        LIMIT 1
    )
FROM articles a 
WHERE a.author_id = (SELECT id FROM Users WHERE name = 'User3');

-- iv) (Joins) Write a query to select all articles which do not have any comments
SELECT DISTINCT * FROM Articles a
LEFT JOIN Comments c
ON a.id = c.article_id
WHERE c.id IS NULL;

-- iv) (Subquery) Write a query to select all articles which do not have any comments
SELECT DISTINCT * FROM articles
WHERE id NOT IN (
    SELECT article_id FROM comments
);

-- v) (Joins) Write a query to select article which has maximum comments
SELECT 
    a.id, 
    a.title, 
    a.author_id,
    COUNT(c.id) AS comment_count 
FROM articles a
JOIN comments c
ON a.id = c.article_id
GROUP BY a.id
ORDER BY comment_count DESC
LIMIT 1;

-- v) (Subquery) Write a query to select article which has maximum comments
SELECT *
FROM (
    SELECT 
        a.id,
        a.title,
        a.author_id,
        (
            SELECT COUNT(*) 
            FROM Comments c 
            WHERE c.article_id = a.id
        ) AS comment_count
    FROM Articles a
) sub
ORDER BY comment_count DESC
LIMIT 1;

-- vi) Write a query to select article which does not have more than one comment by the same user ( do this using left join and group by )
SELECT 
    a.id,
    c.user_id,
    COUNT(c.id)
FROM comments c
LEFT JOIN articles a
ON a.id = c.article_id
GROUP BY a.id, c.user_id
HAVING COUNT(c.id) <= 1
ORDER BY a.id;
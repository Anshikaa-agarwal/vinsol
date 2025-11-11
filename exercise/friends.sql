-- DROP previously made tables in db
DROP TABLE IF EXISTS Tags CASCADE;
DROP TABLE IF EXISTS Images CASCADE;
DROP TABLE IF EXISTS Friends CASCADE;
DROP TABLE IF EXISTS Users CASCADE;

-- Create tables

-- Create Users table
CREATE TABLE Users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL
);

-- Create Friends table
CREATE TABLE IF NOT EXISTS Friends (
    user_id INT,
    friend_id INT,

    PRIMARY KEY(user_id, friend_id),

    CONSTRAINT fk_users
        FOREIGN KEY (user_id) REFERENCES Users(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_user_friend
        FOREIGN KEY (friend_id) REFERENCES Users(id)
        ON DELETE CASCADE
);

-- Create Images table
CREATE TABLE IF NOT EXISTS Images (
    id SERIAL PRIMARY KEY,
    image_user INT,

    FOREIGN KEY (image_user) REFERENCES Users(id) ON DELETE CASCADE
);

-- Create Tags table
CREATE TABLE Tags (
    image_id INT,
    tagged_user INT,
    
    FOREIGN KEY (image_id) REFERENCES Images(id) ON DELETE CASCADE,
    FOREIGN KEY (tagged_user) REFERENCES Users(id) ON DELETE CASCADE
);

-- INSERT VALUES

-- Insert into Users
INSERT INTO Users (name) VALUES
('Alice'),
('Bob'),
('Charlie'),
('David'),
('Eve'),
('Frank'),
('Grace');

-- Insert into Friends
INSERT INTO Friends (user_id, friend_id) VALUES
(1, 2), (2, 1),
(1, 3), (3, 1),
(2, 4), (4, 2),
(3, 4), (4, 3),
(5, 6), (6, 5),
(1, 7), (7, 1);

-- Insert into Images
INSERT INTO Images (image_user) VALUES
(1), (1), (1),
(2), (2),
(3),
(4),
(5),
(6),
(7);

-- Insert into Tags
INSERT INTO Tags (image_id, tagged_user) VALUES
(1, 2), (1, 3), (1, 7),
(2, 2), (2, 3),
(3, 2), (3, 2), (3, 3),
(4, 1), (4, 3), (4, 4),
(5, 1), (5, 1),
(6, 1), (6, 2),
(7, 2), (7, 3),
(8, 6),
(9, 5), (9, 5), (9, 5),
(10, 1), (10, 2);

-- View data
SELECT * FROM Users;
SELECT * FROM friends;
SELECT * FROM images;
SELECT * FROM tags;

-- Creating indexes
CREATE INDEX idx_users_name_hash ON Users USING HASH (name);
CREATE INDEX idx_friends_friend ON Friends(friend_id);
CREATE INDEX idx_images_user ON Images(image_user);
CREATE INDEX idx_tags_image ON Tags(image_id);
CREATE INDEX idx_tags_tagged_user ON Tags(tagged_user);

-- 1) Find image that has been tagged most no of times.
WITH ranked_tb AS (
    SELECT 
        image_id, 
        COUNT(tagged_user) AS tagged,
        RANK() OVER (ORDER BY COUNT(tagged_user) DESC) AS rank 
    FROM tags
    GROUP BY image_id
)
SELECT image_id, tagged
FROM ranked_tb
WHERE rank = 1;


-- 2) Find all images belonging to the friends of a particular user.
-- (let's say user is 'Bob')

SELECT 
    f.user_id,
    f.friend_id,
    i.id AS image_id
FROM Friends f
JOIN Images i ON f.friend_id = i.image_user
WHERE f.user_id = (SELECT id FROM Users WHERE name = 'Bob')
ORDER BY f.friend_id, i.id;

-- To list entire table, i.e, all images of all friends of all users:
SELECT 
    DISTINCT
    f.user_id,
    f.friend_id,
    i.id as image_id
FROM friends f
LEFT JOIN images i ON f.friend_id = i.image_user
ORDER BY f.user_id, f.friend_id;

-- 3) Find all friends of a particular user (Say, userA) who has tagged him in all of his pics.

SELECT DISTINCT f.friend_id
FROM friends f
JOIN images i ON f.friend_id = i.image_user
JOIN tags t ON i.id = t.image_id AND t.tagged_user = f.user_id
WHERE f.user_id = (SELECT id FROM users WHERE name = 'Alice')
GROUP BY f.friend_id
HAVING COUNT(DISTINCT i.id) = COUNT(distinct t.image_id);

-- 4) Find friend of a particular user (Say, userA) who have tagged him most no. of times.
SELECT f.friend_id, COUNT(t.tagged_user)
FROM friends f
JOIN images i ON f.friend_id = i.image_user
JOIN tags t ON i.id = t.image_id AND t.tagged_user = f.user_id
WHERE f.user_id = (SELECT id FROM users WHERE name = 'Alice')
GROUP BY f.friend_id
ORDER BY COUNT(t.tagged_user) DESC
LIMIT 1;
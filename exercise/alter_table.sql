DROP TABLE IF EXISTS testing_table;

CREATE TABLE IF NOT EXISTS testing_table (
    roll_no VARCHAR(10) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    contact_name VARCHAR(30)
);

ALTER TABLE testing_table
DROP COLUMN name;

ALTER TABLE testing_table
RENAME contact_name TO username;

ALTER TABLE testing_table
ADD COLUMN first_name VARCHAR(30) NOT NULL CHECK (length(first_name) >= 2);

ALTER TABLE testing_table
ADD COLUMN last_name VARCHAR(30);

ALTER TABLE testing_table
ALTER COLUMN roll_no TYPE INTEGER USING roll_no::integer;
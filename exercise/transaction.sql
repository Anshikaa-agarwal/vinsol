-- CREATE DATABASE bank;
-- \c bank

DROP TABLE IF EXISTS Accounts;
DROP TABLE IF EXISTS userss;

CREATE TABLE Accounts (
    id SERIAL PRIMARY KEY,
    account_no NUMERIC UNIQUE NOT NULL,
    balance NUMERIC NOT NULL CHECK (balance >= 0)
);

CREATE TABLE userss (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    account_no NUMERIC,

    CONSTRAINT fk_accounts
        FOREIGN KEY (account_no) REFERENCES Accounts(account_no)
        ON DELETE CASCADE
);

-- Insert sample accounts
INSERT INTO Accounts (account_no, balance) VALUES
(1001, 5000),
(1002, 3000),
(1003, 7000),
(1004, 2500);

-- Insert sample userss
INSERT INTO userss (name, email, account_no) VALUES
('UserA', 'usera@example.com', 1001),
('UserB', 'userb@example.com', 1002),
('UserC', 'userc@example.com', 1003),
('UserD', 'userd@example.com', 1004);

-- View tables
SELECT * FROM accounts;
SELECT * FROM userss;

-- i) UserA is depositing Rs.1000 his account
BEGIN;

UPDATE Accounts a
SET balance = a.balance + 1000
FROM userss u
WHERE a.account_no = u.account_no
  AND u.name = 'UserA';

COMMIT;

-- ii) userA is withdrawing 500 Rs.
BEGIN;

UPDATE accounts
SET balance = (balance - 500)
WHERE account_no = (SELECT account_no FROM userss WHERE name = 'UserA');

COMMIT;

-- iii) userA is transferring 200 Rs to userB's account
BEGIN;

UPDATE accounts
SET balance = (balance - 200)
WHERE account_no = (SELECT account_no FROM userss WHERE name = 'UserA');

UPDATE accounts
SET balance = (balance + 200)
WHERE account_no = (SELECT account_no FROM userss WHERE name = 'UserB');

COMMIT;



BEGIN;

UPDATE accounts a
SET balance = CASE u.name
    WHEN 'UserA' THEN a.balance - 200
    WHEN 'UserB' THEN a.balance + 200
END
FROM userss u
WHERE a.account_no = u.account_no
  AND u.name IN ('UserA', 'UserB');

COMMIT;
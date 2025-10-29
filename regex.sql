DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    email VARCHAR(100),
    department VARCHAR(50)
);

INSERT INTO Student (emp_id, name, city, email, department) VALUES
(1, 'Rahul Sharma', 'Delhi', 'rahul.sharma@gmail.com', 'Sales'),
(2, 'Anita Rao', 'Bangalore', 'anita.rao@yahoo.com', 'HR'),
(3, 'Suresh Patil', 'Hyderabad', 'suresh.patil@outlook.com', 'Finance'),
(4, 'Neha Gupta', 'Mumbai', 'neha.gupta@gmail.com', 'IT'),
(5, 'Ravi Mehta', 'Chandigarh', 'ravi_mehta@gmail.com', 'Marketing'),
(6, 'Reena Kapoor', 'Kolkata', 'reena.kapoor@gmail.com', 'Sales'),
(7, 'Amit Singh', 'Delhi', 'amit.singh@yahoo.com', 'Finance'),
(8, 'Karan Johar', 'Noida', 'karan_johar@rediffmail.com', 'IT'),
(9, 'Meena Roy', 'Jaipur', 'meena.roy@gmail.com', 'HR'),
(10, 'Sahil Arora', 'Lucknow', 'sahil_arora@gmail.com', 'Operations');

DROP TABLE IF EXISTS Movie;

CREATE TABLE Movie (
    movie_id INT PRIMARY KEY,
    title VARCHAR(100),
    genre VARCHAR(50),
    release_year INT
);

INSERT INTO Movie (movie_id, title, genre, release_year) VALUES
(1, 'The Fault in Our Stars', 'Romance', 2014),
(2, 'Love Actually', 'Romance', 2003),
(3, 'Fast and Furious', 'Action', 2009),
(4, 'The Matrix', 'Sci-Fi', 1999),
(5, 'The Great Gatsby', 'Drama', 2013),
(6, 'Endless Love', 'Romance', 2014),
(7, 'The Lion King', 'Animation', 1994),
(8, 'Crazy, Stupid, Love', 'Comedy', 2011),
(9, 'The Dark Knight', 'Action', 2008),
(10, 'The Notebook', 'Romance', 2004);


DROP TABLE IF EXISTS Book;

CREATE TABLE Book (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author VARCHAR(50),
    category VARCHAR(50)
);

INSERT INTO Book (book_id, title, author, category) VALUES
(1, 'Python Programming Guide', 'John Miller', 'Programming'),
(2, 'Data Science for Beginners', 'Anita Sharma', 'Data Science'),
(3, 'SQL Complete Reference', 'James Smith', 'Database'),
(4, 'Machine Learning Made Easy', 'Priya Verma', 'AI'),
(5, 'A Gentle Guide to Java', 'Ravi Kumar', 'Programming'),
(6, 'The Art of Database Design', 'Neha Patel', 'Database'),
(7, 'Advanced C++ Concepts', 'Rahul Sen', 'Programming'),
(8, 'Cloud Computing Guide', 'Amit Joshi', 'Technology'),
(9, 'Networking Fundamentals', 'Rohit Sharma', 'Networking'),
(10, 'Frontend Developer Handbook', 'Karan Gupta', 'Web Development');

DROP TABLE IF EXISTS Customer;

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO Customer (customer_id, name, city, email) VALUES
(1, 'Rohit Agarwal', 'Delhi', 'rohit.agarwal@gmail.com'),
(2, 'Ankita Mehta', 'Pune', 'ankita_mehta@yahoo.com'),
(3, 'Rajesh Kumar', 'Mumbai', 'rajesh.kumar@hotmail.com'),
(4, 'Sonia Jain', 'Jaipur', 'sonia.jain@gmail.com'),
(5, 'Akash Rana', 'Delhi', 'akash_rana@gmail.com'),
(6, 'Deepa Sethi', 'Chennai', 'deepa.sethi@yahoo.com'),
(7, 'Nikhil Sharma', 'Lucknow', 'nikhil_sharma@gmail.com'),
(8, 'Tanya Verma', 'Kolkata', 'tanya.verma@outlook.com'),
(9, 'Aarti Chauhan', 'Noida', 'aarti_chauhan@gmail.com'),
(10, 'Mohan Lal', 'Bangalore', 'mohan.lal@rediffmail.com');


DROP TABLE IF EXISTS Orders;

CREATE TABLE Orders (
    order_id VARCHAR(10) PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

INSERT INTO Orders (order_id, customer_id, order_date) VALUES
('AB01', 1, '2024-04-12'),
('AB12', 2, '2024-05-03'),
('XY34', 3, '2024-05-10'),
('AB99', 4, '2024-06-15'),
('CD45', 5, '2024-06-18'),
('EF67', 6, '2024-07-01'),
('GH89', 7, '2024-07-22'),
('AB22', 8, '2024-08-05'),
('PQ11', 9, '2024-08-16'),
('RS55', 10, '2024-09-09');

DROP TABLE IF EXISTS Country;

CREATE TABLE Country (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(50)
);

INSERT INTO Country (country_id, country_name) VALUES
(1, 'Finland'),
(2, 'Poland'),
(3, 'Switzerland'),
(4, 'Thailand'),
(5, 'Netherlands'),
(6, 'Iceland'),
(7, 'Ireland'),
(8, 'New Zealand'),
(9, 'Scotland'),
(10, 'England');

DROP TABLE IF EXISTS Files;

CREATE TABLE Files (
    file_id INT PRIMARY KEY,
    file_name VARCHAR(100)
);

INSERT INTO Files (file_id, file_name) VALUES
(1, 'report_2024.pdf'),
(2, 'employee_data.xlsx'),
(3, 'project_summary.docx'),
(4, 'sales_results_2023.csv'),
(5, 'config_file.ini'),
(6, 'backup_01.zip'),
(7, 'notes_v2.txt'),
(8, 'resume_final.pdf'),
(9, 'profile_pic.png'),
(10, 'invoice_#001.pdf');


-- Write a query to find all students whose names start with the letter 'R'.
SELECT * FROM student
WHERE name ILIKE 'R%';

-- Write a query to find all employees whose names end with the letter 'a'.
SELECT * FROM Student
WHERE name LIKE '%a';

-- Write a query to find all cities that contain the substring 'del'.
SELECT * FROM Student
WHERE city LIKE '%del%';

-- Write a query to find all products whose names start with 'S' and end with 't'.
SELECT * FROM Student
WHERE name LIKE 'S%t';

-- Write a query to find all customers whose names have exactly 6 characters.
SELECT * FROM Student 
WHERE name LIKE '______';

-- Write a query to find all users whose email addresses contain '@gmail.com'.
SELECT * FROM Student
WHERE email LIKE '%@gmail.com';

-- Write a query to find all movie titles that have the word 'love' anywhere in them.
SELECT * FROM Movie
WHERE title LIKE '%love%';

-- Write a query to find all employees whose second letter in their name is 'e'.
SELECT * FROM Student
WHERE name LIKE '_a%';

-- Write a query to find all books whose titles do not contain the word 'guide'.
SELECT * FROM Book
WHERE title NOT LIKE '%guide%';

-- Write a query to find all countries that start with 'N' and have 'i' as the third letter.
SELECT * FROM Country
WHERE country_name LIKE 'N_i%';

-- Write a query to find all records in the orders table where the order_id starts with 'AB' followed by any two digits.
SELECT * FROM Orders
WHERE order_id ~ '^AB[0-9]{2}$';

-- Write a query to find all countries whose names end with 'land'.
SELECT * FROM Country
WHERE country_name LIKE '%land';

-- Write a query to find all files whose names contain an underscore _.
SELECT * FROM Files
WHERE file_name LIKE '%\_%' ESCAPE '\';

-- Write a query to find all employees whose names contain both 'a' and 'e'.
SELECT * FROM Student
WHERE name LIKE '%a%' AND name LIKE '%e%';

-- Write a query to find all movies whose titles begin with 'The ' (including the space).
SELECT * FROM Movie
WHERE title LIKE 'Th %';

-- Write a query to find all customers whose names don’t start with 'A'.
SELECT * FROM Customer
WHERE name NOT LIKE 'A%';

-- Write a query to find all departments whose names have 'it' as the last two letters.
SELECT department FROM Student
WHERE department LIKE '%it';

SELECT * 
FROM customer 
WHERE name = 'Mohan Lal';

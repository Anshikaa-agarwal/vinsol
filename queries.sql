CREATE TABLE students (
    roll_no SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    marks NUMERIC(5,2) CHECK (marks BETWEEN 0 AND 100),
    grade VARCHAR(10) DEFAULT 'N/A',
    admission_date DATE DEFAULT CURRENT_DATE
);

INSERT INTO students (name, marks)
VALUES
('Ananya Gupta', 95),
('Rohan Mehta', 88),
('Priya Sharma', 72),
('Vikas Jain', 60),
('Kavita Yadav', 45);

CREATE TABLE courses (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(100) UNIQUE NOT NULL,
    credits INT CHECK (credits BETWEEN 1 AND 6)
);

INSERT INTO courses (course_id, course_name, credits)
VALUES
('CSE101', 'Computer Science Basics', 4),
('CSE102', 'Advanced Programming', 3),
('MAT101', 'Mathematics I', 3);

CREATE TABLE enrollments (
    student_id INT,
    course_id VARCHAR(10),
    enrollment_date DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(roll_no),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

ALTER TABLE students
ADD COLUMN email VARCHAR(100);

ALTER TABLE students
ALTER COLUMN marks TYPE NUMERIC(5,2) USING marks::NUMERIC;

ALTER TABLE students
RENAME COLUMN grade TO final_grade;

UPDATE students
SET email = 
    CASE 
        WHEN name = 'Ananya Gupta' THEN 'ananya@example.com'
        WHEN name = 'Rohan Mehta' THEN 'rohan@example.com'
        WHEN name = 'Priya Sharma' THEN 'priya@example.com'
        WHEN name = 'Vikas Jain' THEN 'vikas@example.com'
        WHEN name = 'Kavita Yadav' THEN 'kavita@example.com'
    END;


INSERT INTO enrollments (student_id, course_id, enrollment_date)
SELECT 
    roll_no,
    CASE
        WHEN marks > 90 THEN 'CSE101'
        WHEN marks BETWEEN 81 AND 90 THEN 'CSE102'
    END AS course_id,
    CURRENT_DATE
FROM students
WHERE marks > 80;

SELECT s.roll_no, s.name, s.marks, e.course_id, e.enrollment_date
FROM students s
JOIN enrollments e ON s.roll_no = e.student_id;

SELECT * FROM students;

UPDATE students
SET final_grade = 
    CASE
        WHEN marks > 90 THEN 'A'
        WHEN marks BETWEEN 75 AND 90 THEN 'B'
        WHEN marks BETWEEN 60 AND 74 THEN 'C'
        WHEN marks < 60 THEN 'D'
    END
WHERE admission_date < '2024-01-01'
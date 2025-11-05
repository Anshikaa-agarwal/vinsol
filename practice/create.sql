CREATE TABLE departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(50) UNIQUE NOT NULL,
    location VARCHAR(100)
);

CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    salary NUMERIC(10,2) CHECK (salary > 0),
    dept_id INT,
    hire_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

ALTER TABLE employees
DROP CONSTRAINT employees_salary_check;

ALTER TABLE employees
ADD CONSTRAINT salary_amt CHECK (salary >= 30000);


ALTER TABLE employees
DROP CONSTRAINT employees_dept_id_fkey;

ALTER TABLE employees
ADD CONSTRAINT employees_dept_id_fkey FOREIGN KEY (dept_id)
REFERENCES departments(dept_id)
ON DELETE CASCADE;

ALTER TABLE employees
ADD CONSTRAINT distinct_first_name
UNIQUE (first_name);

CREATE TABLE Projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    deadline DATE DEFAULT '2025-12-31'
);

CREATE TABLE project_allocation (
    project_id INT, 
    emp_id INT,

    PRIMARY KEY (project_id, emp_id),
    FOREIGN KEY (project_id) REFERENCES Projects(id),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
    ON DELETE CASCADE
);

ALTER TABLE departments
RENAME TO company_departments;

ALTER TABLE company_departments
RENAME dept_name TO department_title;

ALTER TABLE employees
RENAME CONSTRAINT employees_pkey TO pk_employee_id;

ALTER TABLE employees
ADD COLUMN experience_years INT
DEFAULT 0
CHECK (experience_years >= 0);

ALTER TABLE company_departments
DROP CONSTRAINT departments_dept_name_key;
-- Drop tables if they exist to allow clean reruns
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE performance_reviews CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
   EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE departments (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(100) NOT NULL
);

CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    salary NUMBER(10, 2) NOT NULL,
    dept_id NUMBER,
    CONSTRAINT fk_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE performance_reviews (
    review_id NUMBER PRIMARY KEY,
    emp_id NUMBER,
    rating NUMBER(1) CHECK (rating BETWEEN 1 AND 5),
    review_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_emp_review FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);
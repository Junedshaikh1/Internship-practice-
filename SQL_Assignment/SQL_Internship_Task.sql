CREATE TABLE Department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    salary DECIMAL(10,2),
    hire_date DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
);

INSERT INTO Department VALUES
(1,'HR'),
(2,'IT'),
(3,'Finance'),
(4,'Sales');

INSERT INTO Employee VALUES
(101,'Amit',55000,'2026-01-15',2),
(102,'Neha',65000,'2025-12-20',2),
(103,'Rahul',45000,'2026-03-10',1),
(104,'Priya',70000,'2025-11-18',3),
(105,'Rohan',50000,'2026-05-01',4),
(106,'Sneha',80000,'2025-10-10',2),
(107,'Karan',60000,'2026-02-12',3),
(108,'Pooja',75000,'2026-04-22',4),
(109,'Arjun',55000,'2026-01-20',1),
(110,'Vikas',45000,'2026-06-01',2);

-- Top 5 Highest Salary Employees
SELECT *
FROM Employee
ORDER BY salary DESC
LIMIT 5;

-- Department-wise Employee Count
SELECT dept_id,
COUNT(*) AS employee_count
FROM Employee
GROUP BY dept_id;

-- Second Highest Salary
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (
SELECT MAX(salary)
FROM Employee
);

-- Employees Whose Salary is Greater Than Department Average
SELECT *
FROM Employee e
WHERE salary >
(
SELECT AVG(salary)
FROM Employee
WHERE dept_id = e.dept_id
);

-- Inner Join
SELECT e.emp_name,
d.dept_name,
e.salary
FROM Employee e
INNER JOIN Department d
ON e.dept_id = d.dept_id;

-- Left Join
SELECT e.emp_name,
d.dept_name
FROM Employee e
LEFT JOIN Department d
ON e.dept_id = d.dept_id;

-- Group By with HAVING
SELECT dept_id,
COUNT(*) AS total_employees
FROM Employee
GROUP BY dept_id
HAVING COUNT(*) > 2;

-- Employees Hired in Last 6 Months
SELECT *
FROM Employee
WHERE hire_date >= CURRENT_DATE - INTERVAL 6 MONTH;

-- Find Duplicate Records
SELECT emp_name,
salary,
COUNT(*) AS duplicate_count
FROM Employee
GROUP BY emp_name,
salary
HAVING COUNT(*) > 1;

-- To disable and enable safe update to delete data from the table  
SET SQL_SAFE_UPDATES = 1;

-- Remove Duplicate Records
DELETE e1
FROM Employee e1
INNER JOIN Employee e2
ON e1.emp_id > e2.emp_id
AND e1.emp_name = e2.emp_name
AND e1.salary = e2.salary;
  

CREATE DATABASE IF NOT EXISTS employee_db;

USE employee_db;

DROP TABLE IF EXISTS employees;




CREATE TABLE employees
(
    employee_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    designation VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,

    hra DECIMAL(10,2) DEFAULT 0.00,
    da DECIMAL(10,2) DEFAULT 0.00,
    pf DECIMAL(10,2) DEFAULT 0.00,
    tax DECIMAL(10,2) DEFAULT 0.00,
    gross_salary DECIMAL(10,2) DEFAULT 0.00,
    net_salary DECIMAL(10,2) DEFAULT 0.00,
    bonus DECIMAL(10,2) DEFAULT 0.00,

    CONSTRAINT chk_employee_id_positive
        CHECK (employee_id > 0),

    CONSTRAINT chk_salary_positive
        CHECK (salary > 0)
);



INSERT INTO employees
(
    employee_id,
    name,
    department,
    designation,
    salary
)
VALUES
(1, 'Ravali', 'IT', 'Developer', 50000.00),
(2, 'Siddhu', 'IT', 'Developer', 40000.00),
(3, 'Shiva', 'HR', 'Manager', 60000.00),
(4, 'Sai', 'IT', 'Developer', 50000.00),
(5, 'Goutham', 'IT', 'Developer', 45000.00),
(6, 'Bunny', 'IT', 'Developer', 50000.00);



SELECT
    employee_id,
    name,
    department,
    designation,
    salary
FROM employees;

UPDATE employees
SET hra = salary * 0.20;

UPDATE employees
SET da = salary * 0.10;

UPDATE employees
SET pf = salary * 0.12;


UPDATE employees
SET tax = salary * 0.05;




UPDATE employees
SET gross_salary = salary + hra + da;



UPDATE employees
SET net_salary = gross_salary - pf - tax;



UPDATE employees
SET bonus =
    CASE
        WHEN salary >= 50000 THEN salary * 0.15
        WHEN salary >= 30000 THEN salary * 0.10
        ELSE salary * 0.05
    END;



SELECT
    employee_id AS 'Employee ID',
    name AS 'Employee Name',
    department AS 'Department',
    designation AS 'Designation',
    salary AS 'Basic Salary',
    hra AS 'HRA',
    da AS 'DA',
    pf AS 'PF',
    tax AS 'Tax',
    gross_salary AS 'Gross Salary',
    bonus AS 'Bonus',
    net_salary AS 'Net Salary'
FROM employees
ORDER BY employee_id;




SELECT
    employee_id,
    name,
    salary,
    CASE
        WHEN salary IS NULL THEN 'INVALID - NULL'
        WHEN salary <= 0 THEN 'INVALID - ZERO OR NEGATIVE'
        ELSE 'VALID'
    END AS salary_validation
FROM employees;



SELECT
    employee_id,
    name,
    CASE
        WHEN employee_id IS NULL THEN 'INVALID - NULL'
        WHEN employee_id <= 0 THEN 'INVALID - ZERO OR NEGATIVE'
        ELSE 'VALID'
    END AS employee_id_validation
FROM employees;


/* ============================================================
   EMPLOYEE NAME VALIDATION
   ============================================================ */

SELECT
    employee_id,
    name,
    CASE
        WHEN name IS NULL THEN 'INVALID - NULL'
        WHEN TRIM(name) = '' THEN 'INVALID - EMPTY'
        WHEN name NOT REGEXP '^[A-Za-z ]+$'
            THEN 'INVALID - NUMBERS OR SYMBOLS'
        ELSE 'VALID'
    END AS name_validation
FROM employees;




SELECT
    employee_id,
    name,
    salary,
    CASE
        WHEN salary >= 50000 THEN 'A'
        WHEN salary >= 30000 THEN 'B'
        WHEN salary >= 15000 THEN 'C'
        ELSE 'D'
    END AS salary_grade
FROM employees;



SELECT
    employee_id,
    name,
    salary,
    CASE
        WHEN salary >= 50000 THEN '15%'
        WHEN salary >= 30000 THEN '10%'
        ELSE '5%'
    END AS bonus_percentage
FROM employees;

SELECT
    employee_id,
    name,
    department,
    designation,
    salary
FROM employees
WHERE salary =
(
    SELECT MAX(salary)
    FROM employees
);
SELECT
    department,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department;


SELECT
    employee_id,
    name,
    department,
    designation,
    salary,
    hra,
    da,
    pf,
    tax,
    gross_salary,
    bonus,
    net_salary
FROM employees
WHERE employee_id = 1;

SELECT
    *
FROM employees
WHERE name = 'Shiva';

SELECT
    *
FROM employees
WHERE department = 'IT';

SELECT
    *
FROM employees
WHERE employee_id = 3
   OR name = 'Shiva'
   OR department = 'HR';



UPDATE employees
SET salary = 45000
WHERE employee_id = 2;


UPDATE employees
SET
    hra = salary * 0.20,
    da = salary * 0.10,
    pf = salary * 0.12,
    tax = salary * 0.05,
    gross_salary = salary + (salary * 0.20) + (salary * 0.10),
    bonus =
        CASE
            WHEN salary >= 50000 THEN salary * 0.15
            WHEN salary >= 30000 THEN salary * 0.10
            ELSE salary * 0.05
        END;


UPDATE employees
SET net_salary = gross_salary - pf - tax;




SELECT *
FROM employees
WHERE employee_id = 2;

SELECT
    employee_id AS 'Employee ID',
    name AS 'Employee Name',
    department AS 'Department',
    designation AS 'Designation',
    salary AS 'Basic Salary',
    hra AS 'HRA',
    da AS 'DA',
    gross_salary AS 'Gross Salary',
    pf AS 'PF',
    tax AS 'Tax',
    bonus AS 'Bonus',
    net_salary AS 'Net Salary'
FROM employees
WHERE employee_id = 1;

SELECT
    employee_id AS 'Employee ID',
    name AS 'Employee Name',
    department AS 'Department',
    designation AS 'Designation',
    salary AS 'Basic Salary',
    hra AS 'HRA',
    da AS 'DA',
    pf AS 'PF',
    tax AS 'Tax',
    gross_salary AS 'Gross Salary',
    bonus AS 'Bonus',
    net_salary AS 'Net Salary'
FROM employees
ORDER BY employee_id;
SELECT
    employee_id,
    name,
    department,
    net_salary
FROM employees
WHERE net_salary =
(
    SELECT MAX(net_salary)
    FROM employees
);

SELECT
    COUNT(*) AS total_employees,
    SUM(salary) AS total_basic_salary,
    SUM(hra) AS total_hra,
    SUM(da) AS total_da,
    SUM(gross_salary) AS total_gross_salary,
    SUM(pf) AS total_pf,
    SUM(tax) AS total_tax,
    SUM(bonus) AS total_bonus,
    SUM(net_salary) AS total_net_salary,
    AVG(salary) AS average_salary,
    AVG(net_salary) AS average_net_salary
FROM employees;


SELECT
    CASE
        WHEN salary >= 50000 THEN 'A'
        WHEN salary >= 30000 THEN 'B'
        WHEN salary >= 15000 THEN 'C'
        ELSE 'D'
    END AS salary_grade,
    COUNT(*) AS total_employees
FROM employees
GROUP BY
    CASE
        WHEN salary >= 50000 THEN 'A'
        WHEN salary >= 30000 THEN 'B'
        WHEN salary >= 15000 THEN 'C'
        ELSE 'D'
    END
ORDER BY salary_grade;

SELECT
    employee_id,
    name,
    department,
    designation,
    salary
FROM employees
ORDER BY salary DESC;

SELECT
    employee_id,
    name,
    department,
    net_salary
FROM employees
ORDER BY net_salary DESC;

SELECT
    employee_id,
    name,
    salary
FROM employees
WHERE salary >= 50000;
SELECT
    employee_id,
    name,
    salary
FROM employees
WHERE salary BETWEEN 30000 AND 50000;

SELECT
    *
FROM employees
WHERE name LIKE '%a%';


/* ============================================================
   SEARCH BY NAME OR DEPARTMENT
   ============================================================ */

SELECT
    *
FROM employees
WHERE name LIKE '%Shiva%'
   OR department = 'IT';
DELETE FROM employees
WHERE employee_id = 6;

SELECT * FROM employees;




SELECT
    employee_id AS 'ID',
    name AS 'Employee Name',
    department AS 'Department',
    designation AS 'Designation',
    salary AS 'Basic Salary',
    hra AS 'HRA',
    da AS 'DA',
    pf AS 'PF',
    tax AS 'Tax',
    gross_salary AS 'Gross Salary',
    bonus AS 'Bonus',
    net_salary AS 'Net Salary'
FROM employees
ORDER BY employee_id;  




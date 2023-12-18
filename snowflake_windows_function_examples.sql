
-- ROW_NUMBER() Function:
sql
Copy code
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

---------------------------------------------------------------------------------------------------------------------------

-- RANK() Function:
sql
Copy code
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM employees;

---------------------------------------------------------------------------------------------------------------------------

-- DENSE_RANK() Function:
sql
Copy code
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_dense_rank
FROM employees;

---------------------------------------------------------------------------------------------------------------------------

-- NTILE() Function:
sql
Copy code
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    NTILE(4) OVER (ORDER BY salary) AS quartile
FROM employees;

---------------------------------------------------------------------------------------------------------------------------

-- LEAD() and LAG() Functions:
sql
Copy code
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    salary,
    LEAD(salary) OVER (ORDER BY salary) AS next_salary,
    LAG(salary) OVER (ORDER BY salary) AS prev_salary
FROM employees;

---------------------------------------------------------------------------------------------------------------------------

-- SUM() Over a Window:
sql
Copy code
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    salary,
    SUM(salary) OVER (PARTITION BY department_id ORDER BY salary) AS dept_salary_sum
FROM employees;

---------------------------------------------------------------------------------------------------------------------------

-- AVG() Over a Window:
sql
Copy code
SELECT 
    employee_id, 
    first_name, 
    last_name, 
    salary,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg_salary
FROM employees;

-- ROW_NUMBER() Function:
-- Returns a unique row number for each row within a window partition. The row number starts at 1 and continues up sequentially.

SELECT 
    employee_id, 
    first_name, 
    last_name, 
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

---------------------------------------------------------------------------------------------------------------------------

-- RANK() Function:
-- Returns the rank of a value within an ordered group of values. The rank value starts at 1 and continues up sequentially. If two values are the same, they have the same rank.

SELECT 
    employee_id, 
    first_name, 
    last_name, 
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM employees;

---------------------------------------------------------------------------------------------------------------------------

-- DENSE_RANK() Function:
-- Returns the rank of a value within a group of values, without gaps in the ranks. The rank value starts at 1 and continues up sequentially. If two values are the same, they have the same rank.

SELECT 
    employee_id, 
    first_name, 
    last_name, 
    DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_dense_rank
FROM employees;

---------------------------------------------------------------------------------------------------------------------------

-- NTILE() Function:
-- Divides an ordered data set equally into the number of buckets specified by constant_value. Buckets are sequentially numbered 1 through constant_value.

SELECT 
    employee_id, 
    first_name, 
    last_name, 
    NTILE(4) OVER (ORDER BY salary) AS quartile
FROM employees;

---------------------------------------------------------------------------------------------------------------------------

-- LEAD() and LAG() Functions:

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

SELECT 
    employee_id, 
    first_name, 
    last_name, 
    salary,
    SUM(salary) OVER (PARTITION BY department_id ORDER BY salary) AS dept_salary_sum
FROM employees;

---------------------------------------------------------------------------------------------------------------------------

-- AVG() Over a Window:

SELECT 
    employee_id, 
    first_name, 
    last_name, 
    salary,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg_salary
FROM employees;

-- Calculating Rolling Averages:
-- Suppose you want to calculate a rolling average of sales for each month for a specific product.

SELECT
    product_id,
    transaction_date,
    SUM(sales_amount) OVER (PARTITION BY product_id ORDER BY transaction_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg_sales
FROM sales_data;

-- This query calculates the rolling average of sales for each product, considering the sales amounts for the current and previous two months.

---------------------------------------------------------------------------------------------------------------------------

-- Identifying Top Performers within Groups:
-- Let's say you want to find the top two performing employees within each department based on their sales.

SELECT
    employee_id,
    department_id,
    sales_amount,
    RANK() OVER (PARTITION BY department_id ORDER BY sales_amount DESC) AS sales_rank
FROM employee_sales;

-- This query ranks employees within each department based on their sales amounts, allowing you to identify the top performers.

---------------------------------------------------------------------------------------------------------------------------

-- Calculating Running Totals:
-- To compute a running total of orders placed for each customer.

SELECT
    customer_id,
    order_date,
    SUM(order_total) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM orders;

-- This query uses the SUM window function to calculate the running total of orders for each customer based on the order date.

---------------------------------------------------------------------------------------------------------------------------

-- Determining Time Gaps Between Events:
-- Suppose you want to identify the time difference between consecutive login events for users.

SELECT
    user_id,
    login_time,
    LEAD(login_time) OVER (PARTITION BY user_id ORDER BY login_time) - login_time AS time_gap
FROM user_logins;

-- Here, the LEAD function is used to find the time difference (time gap) between consecutive login events for each user.
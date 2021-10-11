-- ***********************
-- Name: Dmytro Benko
-- ID: 115223208
-- Date: 21.09.2021
-- Purpose: Lab 1 DBS311
-- ***********************

-- Q1: Write a query to display the tomorrow’s date in the following format:
--Advanced Option:  Define an SQL variable called “tomorrow”, assign it a value of tomorrow’s date and use it in an SQL statement. 

--Q1 Solution:
select to_char(sysdate +1, 'Month DD "of year" YYYY') as Tomorrow from dual;

--Advanced solution
define tomorrow = sysdate + 1;
SELECT * FROM employees WHERE hire_date >= tomorrow;


-- Q2: For each product in category 2, 3, and 5, show product ID, 
--product name, list price, and the new list price increased by 2%. 
--Display a new list price as a whole number.
--In your result, add a calculated column to show the difference of old and new list prices.

--Q2 Solution
SELECT product_id, product_name, list_price, ROUND(list_price *(100+2)/100) AS "New price", 
ROUND(list_price *(100+2)/100)-list_price AS "Price Difference"
FROM products  WHERE category_id = 2 OR category_id = 3 OR
category_id = 5 ORDER BY category_id, product_id;

-- Q3: For employees whose manager ID is 2, write a query that displays the employee’s
--Full Name and Job Title in the following format:

--Q3 Solution
SELECT last_name || ', ' || first_name || ' is ' || job_title AS "Employee info" FROM employees
WHERE manager_id=2 ORDER BY employee_id;

-- Q4: For each employee hired before October 2016, display the employee’s last name,
--hire date and calculate the number of YEARS between TODAY and the date the employee was hired.

--Q4 Solution
SELECT last_name, hire_date, EXTRACT(YEAR FROM SYSDATE)-1 - to_char(hire_date,'YYYY')
AS "Years Worked" FROM employees WHERE to_char(hire_date,'MMYYYY')>=10.2016 ORDER BY
hire_date, EXTRACT(YEAR FROM sysdate)-1 - to_char(hire_date,'YYYY');


-- Q5: Display each employee’s last name, hire date, and the review date,
--which is the first Tuesday after a year of service, but only for those 
--hired after January 1, 2016.

--Q5 Solution
SELECT last_name, hire_date,
to_char((next_day(hire_date,'Tuesday')),'fmDAY,   fmMonth " the " ddspth "of year" yyyy')
AS "Review Date" FROM employees
WHERE to_char(hire_date,'DDMMYYYY')> 01012016 ORDER BY hire_date;
-- There are NO employees hired after January 1, 2016, so I displayed all that are hired before this date.

-- Q6: For all warehouses, display warehouse id, warehouse name, city,
--and state. For warehouses with the null value for the state column,
--display “unknown”. Sort the result based on the warehouse ID.

--Q6 Solution
SELECT w.warehouse_id, w.warehouse_name, l.city, 
CASE WHEN
l.state IS NULL THEN 'Unknown' ELSE l.state
END
 AS "State"
FROM warehouses w,
locations l WHERE l.location_id=w.location_id ORDER BY warehouse_id;
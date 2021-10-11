-- ***********************
-- Name: Dmytro Benko
-- ID: 115223208
-- Date: 08.10.2021
-- Purpose: Lab 3 DBS311
-- ***********************

--Q1.	Write a SQL query to display the last name and hire date of all employees who were hired before the employee with ID 107 got hired but after March 2016. Sort the result by the hire date and then employee ID.
--Q1 Solution:

SELECT last_name, hire_date FROM employees WHERE hire_date< (SELECT hire_date FROM 
employees WHERE employee_id=107)
AND hire_date > '31-MAR-16'
ORDER BY hire_date, employee_id;



--Q2.	Write a SQL query to display customer name and credit limit for customers with lowest credit limit. Sort the result by customer ID.
--Q2 Solution:

SELECT name, credit_limit FROM customers 
WHERE credit_limit=(SELECT MIN(credit_limit) FROM employees) 
ORDER BY customer_id;


--Q3.	Write a SQL query to display the product ID, product name, and list price of the highest paid product(s) in each category.  Sort by category ID and the product ID. 
--Q3 Solution:

SELECT c.category_id, p.product_id, p.product_name, p.list_price 
FROM products p, product_categories c
WHERE 
c.category_id=p.category_id AND 
p.list_price=(SELECT MAX(p.list_price) FROM
products p WHERE p.category_id=c.category_id) 
ORDER BY category_id, product_id;



--Q4.	Write a SQL query to display the category ID and the category name of the most expensive (highest list price) product(s).
--Q4 Solution:

SELECT p.category_id , c.category_name
FROM products p, product_categories c 
WHERE p.category_id=c.category_id AND  p.list_price = (SELECT MAX(p.list_price)
FROM products p ); 


--Q5.	Write a SQL query to display product name and list price for products in category 1 which have the list price less than the lowest list price in ANY category.  Sort the output by top list prices first and then by the product ID.
--Q5 Solution:


SELECT product_name, list_price FROM
products WHERE category_id = 1 GROUP BY
list_price, product_name
HAVING MIN(list_price) < ANY (SELECT MIN(list_price)
FROM products WHERE category_id = 2)
ORDER BY list_price DESC;


--Q6.	Display the maximum price (list price) of the category(s) that has the lowest price product.
--Q6 Solution:



SELECT MAX(list_price) FROM products WHERE 
category_id != (SELECT MIN(list_price) FROM products);




















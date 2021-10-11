-- ***********************
-- Name: Dmytro Benko
-- ID: 115223208
-- Date: 30.09.2021
-- Purpose: Lab 2 DBS311
-- ***********************

--Q1. 1. For each job title display the number of employees. Sort the result according to the number of employees.
--Q1 Solution
SELECT job_title, COUNT(*) AS "Employees" FROM EMPLOYEES
GROUP BY job_title
ORDER BY "Employees";


--Q2.	Display the highest, lowest, and average customer credit limits. Name these results high, low, and average. Add a column that shows the difference between the highest and the lowest credit limits named “High and Low Difference”. Round the average to 2 decimal places.
--Q2 Solution

SELECT MAX(credit_limit) AS "HIGH", MIN(credit_limit) AS "LOW",
ROUND(AVG(credit_limit), 2) AS "AVERAGE",  
MAX(credit_limit) - MIN(credit_limit) AS "High Low Difference"
FROM customers;

--Q3.	Display the order id, the total number of products, and the total order amount for orders with the total amount over $1,000,000. Sort the result based on total amount from the high to low values.
--Q3 Solution

SELECT o.order_id, SUM(p.quantity) AS "TOTAL_ITEMS",
SUM(p.quantity * p.unit_price)
AS "TOTAL_AMOUNT"
FROM orders o, order_items p 
WHERE
o.order_id=p.order_id GROUP BY o.order_id 
 ORDER BY "TOTAL_AMOUNT" DESC;


--Q4.	Display the warehouse id, warehouse name, and the total number of products for each warehouse. Sort the result according to the warehouse ID.
--Q4 Solution

SELECT w.warehouse_id, w.warehouse_name, SUM(i.quantity)
AS "TOTAL_PRODUCTS" FROM warehouses w, inventories i WHERE
w.warehouse_id = i.warehouse_id GROUP BY w.warehouse_id,
w.warehouse_name
ORDER BY w.warehouse_id;


--Q5.	For each customer display customer number, customer full name, and the total number of orders issued by the customer. 
--Q5 Solution

SELECT c.customer_id, c.name, COUNT(o.order_id)
AS "total number of orders"
FROM customers c LEFT OUTER JOIN orders o ON c.customer_id=o.customer_id
WHERE
c.name LIKE 'O%' AND c.name LIKE '%e%' 
OR TRIM(c.name) LIKE '%t'
GROUP BY c.customer_id, c.name
ORDER BY "total number of orders" DESC;


--Q6.	Write a SQL query to show the total and the average sale amount for each category. Round the average to 2 decimal places.
--Q6 Solution

SELECT p.category_id, SUM(o.quantity*o.unit_price) AS "TOTAL_AMOUNT",
ROUND(AVG(o.quantity*o.unit_price), 2) AS "AVERAGE_AMOUNT" FROM products p
LEFT JOIN order_items o ON p.product_id=o.product_id GROUP BY
p.category_id;






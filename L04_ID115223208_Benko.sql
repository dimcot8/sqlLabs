-- ***********************
-- Name: Dmytro Benko
-- ID: 115223208
-- Date: 15.10.2021
-- Purpose: Lab 3 DBS311
-- ***********************


--Q1. Display cities that no warehouse is located in them. (use set operators to answer this question)
--Q1 Solution:

SELECT city FROM locations MINUS 
SELECT l.city FROM locations l, warehouses w
 WHERE l.location_id = w.location_id;



--Q2. Display the category ID, category name, and the number of products in category 1, 2, and 5. In your result, display first the number of products in category 5, then category 1 and then 2.
--Q2 Solution:

SELECT pc.category_id, pc.category_name, COUNT(product_id) as "COUNT(*)"
FROM product_categories pc JOIN products p ON
pc.category_id=p.category_id
WHERE p.category_id = 5 
GROUP BY pc.category_id,pc.category_name 

UNION ALL

SELECT
pc.category_id, pc.category_name, COUNT(product_id) as "COUNT(*)"
FROM product_categories pc JOIN products p ON
pc.category_id=p.category_id
WHERE p.category_id = 1 
GROUP BY pc.category_id,pc.category_name 

UNION ALL

SELECT
pc.category_id, pc.category_name, COUNT(product_id) as "COUNT(*)"
FROM product_categories pc JOIN products p ON
pc.category_id=p.category_id
WHERE p.category_id = 2 
GROUP BY pc.category_id,pc.category_name;


--Q3.	Display product ID for products whose quantity in the inventory is less than to 5. (You are not allowed to use JOIN for this question.)
--Q3 Solution:

SELECT o.product_id FROM order_items o, inventories i WHERE 
i.quantity<5 AND
o.product_id=i.product_id GROUP BY o.product_id
ORDER BY o.product_id;


--Q4.	We need a single report to display all warehouses and the state that they are located in and all states regardless of whether they have warehouses in them or not. (Use set operators in you answer.)
--Q4 Solution:

SELECT w.warehouse_name, l.state FROM warehouses w
LEFT JOIN locations l
ON w.location_id = l.location_id
UNION 

SELECT w.warehouse_name, l.state 
FROM warehouses w 
RIGHT JOIN locations l
ON w.location_id = l.location_id;






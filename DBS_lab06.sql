/*
Name: Dmytro Benko
Student ID: 115223208
Email: dbenko1@myseneca.ca
Date: 11/03/21
Lab 06 - Trasnactions
*/

--1.	List the 4 ways that we know that a transaction can be started
/*
1. When the user has established a connection to the server, thus starting a new transaction.
2. Using BEGIN statement.
3. Using ANY DDL statement.
4. Using COMMIT statement, a new transaction will be started and the current one commited.
*/

/*2.	Using SQL, create an empty table, that is the same as the employees table, 
and name it newEmployees.
 */
CREATE TABLE newEmployees (
 employeeNumber NUMBER(38,0) NOT NULL PRIMARY KEY, 

  lastName VARCHAR2(50) NOT NULL, 

  firstName VARCHAR2(50) NOT NULL, 

  extension VARCHAR2(10) NOT NULL, 

  email VARCHAR2(100) NOT NULL, 

  officeCode VARCHAR2(10) NOT NULL, 

  reportsTo NUMBER(38,0) DEFAULT NULL, 

  jobTitle VARCHAR2(50) NOT NULL
);


/*3.	Execute the following commands.*/
SET AUTOCOMMIT OFF;
SET TRANSACTION READ WRITE;
    
/*4. Write an INSERT statement to populate the newEmployees table with
the rows of the sample data. Insert the NULL value for the reportsTo column.
(Write a single INSERT statement to insert all the rows)
 */
    
--INSERT ALL
INSERT INTO newemployees VALUES (1000,'Smith','John','x4011','jsmith@employee.com','1', NULL, 'VP Sales');
INSERT INTO newemployees VALUES (1001,'Willson','James','x3901','jwillson@employee.com','2', 1001, 'Sales rep'); 
--SELECT * FROM DUAL;
--COMMIT;

/*5.	Create a query that shows all the inserted rows from the newEmployees table.
How many rows are selected? */

SELECT * FROM newemployees;
/*There were selected as many rows as there were created, which is 2. */

/*6. Execute the rollback command. Display all rows and columns from 
the newEmployees table. How many rows are selected? */

ROLLBACK;

SELECT * FROM newemployees;

/*Now there are 0 rows
 If COMMIT was used, these two inserted rows would not have gone (they would remain)*/

/* 7.	Repeat Task 4. Make the insertion permanent to the table newEmployees. 
Display all rows and columns from the newEmployee table. How many rows are selected? */

 INSERT ALL
 INTO newemployees VALUES (1002,'Sm','John','x4013','jsmith@employee.com','3', NULL, 'Sales rep')
 INTO newemployees VALUES (1003,'Will','James','x3904','jwillson@employee.com','3', 1002, 'Sales rep') 
 SELECT * FROM DUAL;
COMMIT;
SELECT * FROM newemployees;
/*2 rows were selected, because I just created as many */

/*
8.	Write an update statement to update the value of column jobTitle to ‘unknown’
for all the employees in the newEmployees table.
 */
 
 UPDATE newemployees SET jobtitle='unknown';
 
 /*9.	Make your changes permanent.*/
 COMMIT;

/*10.	Execute the rollback command. 
a.	Display all employees from the newEmployees table whose job title is ‘unknown’.
How many rows are still updated?
 */
 ROLLBACK;

SELECT * FROM newemployees WHERE jobtitle='unknown';
/*Every row is still updated. */

/*b.	Was the rollback command effective?*/
/*It was not effective as didn't change anything, because after COMMIT a new transaction
was started.*/

/*c.	What was the difference between the result of the rollback execution from
Task 6 and the result of the rollback execution of this task? */
/*In this task it was asked to make changes permanent (to use COMMIT), so that the current 
transaction is commited and ROLLBACK wouldn't work. In task 6 I didn't use any statements which
are commiting a current transaction, so ROLLBACK worked as expected.*/


/*11.	Begin a new transaction and then create a statement to delete to employees from 
the newEmployees table
*/
COMMIT;
DELETE FROM newemployees;

/*12.	Create a VIEW, called vwNewEmps, that queries all the records in the newEmployees 
table sorted by last name and then by first name.*/
CREATE VIEW vwNewEmps AS
SELECT * FROM newemployees ORDER BY lastname, firstname;

/*13.	Perform a rollback to undo the deletion of the employees*/
ROLLBACK;
/*a.	How many employees are now in the newEmployees table?*/
SELECT * FROM newemployees;
--Now there are 0 employees.

/*b.	Was the rollback effective and why? */
--It was effective as it was used in the new transaction and worked fine.


/*14.	Begin a new transaction and rerun the data insertion from Task 4
(copy the code down to Task 14 and run it) */
--INSERT ALL
INSERT INTO newemployees VALUES (1000,'Smith','John','x4011','jsmith@employee.com','1', NULL, 'VP Sales');
INSERT INTO newemployees VALUES (1001,'Willson','James','x3901','jwillson@employee.com','2', 1001, 'Sales rep'); 
--SELECT * FROM DUAL;
--COMMIT;

--15.	Set a Savepoint, called insertion, after inserting the data
SAVEPOINT insertion;

/*16.	Rerun the update statement from Task 8 and run a query to view the data 
(copy the code down and run it again) */
SELECT * FROM newemployees;
UPDATE newemployees SET jobtitle='unknown';
SELECT * FROM newemployees;

/*17.	Rollback the transaction to the Savepoint created in task 15 above and run a query to view the data.
What does the data look like (i.e. describe what happened?*/
ROLLBACK TO SAVEPOINT insertion;
SELECT * FROM newemployees;
/*Rollback worked to the point when jobtitle wasn't updated yet; no jobtitle is now unknown now. */

/*18.	Use the basic for of the rollback statement and again view the data. 
Describe what the results look like and what happened. */
ROLLBACK;
SELECT * FROM newemployees;
/*No data is shown as we deleted it (in task 11, there was created transaction the last time)*/

/*19. Write a statement that denies all access to the newemployees table for all public users */

DENY SELECT, UPDATE, DELETE, ALTER, MODIFY, INSERT, REFERENCES ON newemployees TO dbs211_211za05;
/*REVOKE SELECT, UPDATE, DELETE, ALTER, MODIFY, INSERT ON newemployees TO DBS211_202A23; could maybe also work */

/*20.	Write a statement that allows a classmate (use their database login) read
only access to the newemployees table. */
GRANT SELECT ON newemployees TO shonda;

/* 21.	Write a statement that allows the same classmate to modify (insert,
update and delete) the data of the newemployees table. */
GRANT INSERT, UPDATE, DELETE ON newemployees TO shonda;

/*22.	Write a statement the denies all access to the newemployees table for
the same classmate. */
DENY SELECT, UPDATE, DELETE, ALTER, MODIFY, INSERT, REFERENCES ON newemployees TO shonda;


/*23.	Write statements to permanently remove the view and table created for this lab */
DROP TABLE newemployees;
DROP VIEW vwNewEmps;



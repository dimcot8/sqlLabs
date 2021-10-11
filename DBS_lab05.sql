/*
Name: Dmytro Benko
Student ID: 115223208
Email: dbenko1@myseneca.ca
Date: 19/02/21
Lab 05 - DDL
*/
SET AUTOCOMMIT ON; 
/*1.	Create table the following tables and their given constraints:
L5_MOVIES (movieid:int, title:varchar(35), year:int, director:int,score:decimal(3,2)) */

CREATE TABLE l5_movies (
mid int  PRIMARY KEY, 
title varchar (35) NOT NULL,
releaseYear int NOT NULL,
director int not null,
score decimal(3,2) CHECK (score> 0 AND score<5)
);

/*L5_ACTORS (actorid:int, name:varchar(20), lastname:varchar(30)) */

CREATE TABLE l5_actors (
aid int PRIMARY KEY,
firstName varchar(20) NOT NULL,
lastName varchar(20) NOT NULL
)

/*L5_CASTINGS (movieid:int, actorid:int)  */

CREATE TABLE l5_casting (
movieid int,
actorid int,
PRIMARY KEY(movieid, actorid),
FOREIGN KEY (movieid) REFERENCES l5_movies (mid),
FOREIGN KEY (actorid) REFERENCES l5_actors (aid)
)

/*L5_DIRECTORS(id:int, name:varchar(20), lastname:varchar(30)) */

CREATE TABLE l5_directors (
directorid int PRIMARY KEY,
fistname varchar(20) NOT NULL,
lastname varchar(30) NOT NULL
)

/*2. Modify the movies table to create a foreign key constraint that refers to table directors.  */

ALTER TABLE l5_movies
  ADD CONSTRAINT l5_fk_director FOREIGN KEY (director) REFERENCES l5_directors(directorid); 

/* 3.	Modify the movies table to create a new constraint so the uniqueness
of the movie title is guaranteed. */

ALTER TABLE l5_movies
  ADD CONSTRAINT l5_unique_movies UNIQUE (title);

/*4.	Write insert statements to add the following data to table directors and movies. */ 

INSERT ALL 
 INTO l5_directors VALUES (1010, 'Rob', 'Minkoff')
 INTO l5_directors VALUES (1020, 'Bill', 'Condon')
  INTO l5_directors VALUES (1050, 'Josh', 'Cooley')
 INTO l5_directors VALUES (2010, 'Brad', 'Bird')
 INTO l5_directors VALUES (3020, 'Lake', 'Bell')
 
 INTO l5_movies VALUES (100, 'The Lion King', 2019, 3020, 3.50)
  INTO l5_movies VALUES (200, 'Beauty and the Beast', 2017, 1050, 4.20)
  INTO l5_movies VALUES (300, 'Toy Story 4', 2019, 1020, 4.50)
  INTO l5_movies VALUES (400, 'Mission Impossible', 2018, 2010, 5.00)
  INTO l5_movies VALUES (500, 'The Secret Life of Pets', 2016, 1010, 3.90)


 SELECT * FROM DUAL;
COMMIT;

/* 5.	Write SQL statements to remove all above tables. 
Is the order of tables important when removing? Why?  

Yes, the order is important as we can't remove a table with foreign key, 
which is a primary key in another table, we should remove the second one first.
*/

DROP TABLE l5_movies cascade constraints; 

DROP TABLE l5_actors cascade constraints; 

DROP TABLE l5_casting cascade constraints; 

DROP TABLE l5_directors cascade constraints; 

/*6.	Create a new empty table employee2 the same as table employees.  
Use a single statement to create the table and insert the data at the same time.*/

CREATE TABLE employees2 ( 

  employeeNumber int NOT NULL PRIMARY KEY, 

  lastName varchar(50) NOT NULL, 

  firstName varchar(50) NOT NULL, 

  extension varchar(10) NOT NULL, 

  email varchar(100) NOT NULL, 

  officeCode varchar(10) NOT NULL, 

  reportsTo int DEFAULT NULL, 

  jobTitle varchar(50) NOT NULL

); 

/*7.	Modify table employee2 and add a new column username to this table. The value 
of this column is not required and does not have to be unique. */

ALTER table employees2
ADD username varchar(20);

INSERT INTO employees2 VALUES (1056,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales', 'username') 

/*8.	Delete all the data in the employee2 table */

DELETE FROM employees2;

/*9.	Re-insert all data from the employees table into your new table employee2 
using a single statement.  */

INSERT INTO employees2 (employeeNumber, lastName, firstName, extension, email, officeCode,
reportsTo, jobTitle) SELECT employeeNumber, lastName, firstName, extension, email, officeCode,
reportsTo, jobTitle FROM employees

/*10.	In table employee2, write a SQL statement to change the first name and
the last name of employee with ID 1002 to your name.  */

UPDATE employees2 SET firstname = 'Dmytro', lastname = 'Benko'
WHERE employeenumber = 1002;

/*11.	In table employee2, generate the email address for column username
for each student by concatenating the first character of employee’s first name
and the employee’s last name. For instance, the username of employee Peter Stone
will be pstone. NOTE: the username is in all lower case letters.  */

Update employees2 SET username = LOWER(substr(firstname,1,1) || lastname)

/*12.	In table employee2, remove all employees with office code 4.  */

DELETE FROM employees2 WHERE officecode = 4;

/*13.	Drop table employee2. */

DROP TABLE employees2;
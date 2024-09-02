CREATE TABLE employee (
  emp_id INT PRIMARY KEY,
  first_name VARCHAR(40),
  last_name VARCHAR(40),
  birth_day DATE,
  sex VARCHAR(1),
  salary INT,
  super_id INT,
  branch_id INT
);

CREATE TABLE branch (
  branch_id INT PRIMARY KEY,
  branch_name VARCHAR(40),
  mgr_id INT,
  mgr_start_date DATE,
  FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client (
  client_id INT PRIMARY KEY,
  client_name VARCHAR(40),
  branch_id INT,
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with (
  emp_id INT,
  client_id INT,
  total_sales INT,
  PRIMARY KEY(emp_id, client_id),
  FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
  FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier (
  branch_id INT,
  supplier_name VARCHAR(40),
  supply_type VARCHAR(40),
  PRIMARY KEY(branch_id, supplier_name),
  FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);


-- -----------------------------------------------------------------------------

-- Corporate
INSERT INTO employee VALUES(100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL);

INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');

UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;

INSERT INTO employee VALUES(101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);

-- Scranton
INSERT INTO employee VALUES(102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);

INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-06');

UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;

INSERT INTO employee VALUES(103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);

INSERT INTO branch VALUES(3, 'Stamford', 106, '1998-02-13');

UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;

INSERT INTO employee VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);


-- BRANCH SUPPLIER
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

-- CLIENT
INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);

-- WORKS_WITH
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

INSERT INTO works_with VALUES(105, 406, 130000), (112, 455, 1000),
			(113, 413, 10000), (123, 489, 40000);



-- Find all employees
SELECT *
FROM employee;

-- Find all clients
SELECT *
FROM clients;

-- Find all employees ordered by salary
SELECT *
from employee
ORDER BY salary ASC/DESC;

-- Find all employees ordered by sex then name
SELECT *
from employee
ORDER BY sex, name;

-- Find the first 5 employees in the table
SELECT *
from employee
LIMIT 5;

-- Find the first and last names of all employees
SELECT first_name, employee.last_name
FROM employee;

-- Find the forename and surnames names of all employees
SELECT first_name AS forename, employee.last_name AS surname
FROM employee;

-- Find out all the different genders
SELECT DISCINCT sex
FROM employee;

-- Find all male employees
SELECT *
FROM employee
WHERE sex = 'M';

-- Find all employees at branch 2
SELECT *
FROM employee
WHERE branch_id = 2;

-- Find all employee's id's and names who were born after 1969
SELECT emp_id, first_name, last_name
FROM employee
WHERE birth_day >= 1970-01-01;

-- Find all female employees at branch 2
SELECT *
FROM employee
WHERE branch_id = 2 AND sex = 'F';

-- Find all employees who are female & born after 1969 or who make over 80000
SELECT *
FROM employee
WHERE (birth_day >= '1970-01-01' AND sex = 'F') OR salary > 80000;

-- Find all employees born between 1970 and 1975
SELECT *
FROM employee
WHERE birth_day BETWEEN '1970-01-01' AND '1975-01-01';

-- Find all employees named Jim, Michael, Johnny or David
SELECT *
FROM employee
WHERE first_name IN ('Jim', 'Michael', 'Johnny', 'David');



-- Find the number of employees
SELECT COUNT(super_id)
FROM employee;

-- Find the average of all employee's salaries
SELECT AVG(salary)
FROM employee;

-- Find the sum of all employee's salaries
SELECT SUM(salary)
FROM employee;

-- Find out how many males and females there are
SELECT COUNT(sex), sex
FROM employee
GROUP BY sex

-- Find the total sales of each salesman
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY client_id;

-- Find the total amount of money spent by each client
SELECT SUM(total_sales), client_id
FROM works_with
GROUP BY client_id;



-- % = any # characters, _ = one character

-- Find any client's who are an LLC
SELECT *
FROM client
WHERE client_name LIKE '%LLC';

-- Find any branch suppliers who are in the label business
SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '% Label%';

-- Find any employee born on the 10th day of the month
SELECT *
FROM employee
WHERE birth_day LIKE '_____10%';

-- Find any clients who are schools
SELECT *
FROM client
WHERE client_name LIKE '%Highschool%';



-- Find a list of employee and branch names
SELECT employee.first_name AS Employee_Branch_Names
FROM employee
UNION
SELECT branch.branch_name
FROM branch;

-- Find a list of all clients & branch suppliers' names
SELECT client.client_name AS Non-Employee_Entities, client.branch_id AS Branch_ID
FROM client
UNION
SELECT branch_supplier.supplier_name, branch_supplier.branch_id
FROM branch_supplier;




-- Add the extra branch
INSERT INTO branch VALUES(4, "Buffalo", NULL, NULL);

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch    -- LEFT JOIN, RIGHT JOIN
ON employee.emp_id = branch.mgr_id;



-- Find names of all employees who have sold over 50,000
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (SELECT works_with.emp_id
                          FROM works_with
                          WHERE works_with.total_sales > 50000);

-- Find all clients who are handles by the branch that Michael Scott manages
-- Assume you know Michael's ID
SELECT client.client_id, client.client_name
FROM client
WHERE client.branch_id = (SELECT branch.branch_id
                          FROM branch
                          WHERE branch.mgr_id = 102);

 -- Find all clients who are handles by the branch that Michael Scott manages
 -- Assume you DONT'T know Michael's ID
 SELECT client.client_id, client.client_name
 FROM client
 WHERE client.branch_id = (SELECT branch.branch_id
                           FROM branch
                           WHERE branch.mgr_id = (SELECT employee.emp_id
                                                  FROM employee
                                                  WHERE employee.first_name = 'Michael' AND 					employee.last_name ='Scott'
                                                  LIMIT 1));
	

-- Find the names of employees who work with clients handled by the scranton branch
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (
                         SELECT works_with.emp_id
                         FROM works_with
                         )
AND employee.branch_id = 2;

-- Find the names of all clients who have spent more than 100,000 dollars
SELECT client.client_name
FROM client
WHERE client.client_id IN (
                          SELECT client_id
                          FROM (
                                SELECT SUM(works_with.total_sales) AS totals, client_id
                                FROM works_with
                                GROUP BY client_id) AS total_client_sales
                          WHERE totals > 100000
);

--Subquery with insert statement
INSERT INTO orders
SELECT prod_id, item, sell_price FROM products WHERE prod_id IN (
								SELECT prod_id FROM products
								WHERE sell_price>1000
								);

--Subquery with update statement
UPDATE employees SET salary=salary*1.3 WHERE AGE IN (
							SELECT age FROM employees WHERE
							age >= 27
							);
							
--Subquery with delete statement
DELETE FROM employees WHERE age IN (
	SELECT age FROM employees WHERE age >=27
);




--JOINS

--Joins are commands used to combine rows fromtwo or more tables
--Inner joins returns records which have matching values in both tables
--Natural joins work like inner joins but return less number of columns due to avoiding repeatition

SELECT * FROM Employee;
SELECT * FROM Project;
SELECT Employee.EmpID, Employee.EmpFname, Employee.EmpLname, Project.ProjectID, Project.ProjectName FROM Employee
INNER JOIN Project ON Employee.EmpID=Project.EmpID;

--Left join or left outer join returns all the records from the left table and records which satisfy a condition from the right table. For records having no matching values in the right table will be null

SELECT Employee.EmpFname, Employee.EmpLname, Project.ProjectID, Project.ProjectName FROM Employee
LEFT JOIN Project ON Employee.EmpID=Project.EmpID;

--Right join or right outer join returns all the records from the right table and records which satisfy a condition from the left table. For records having no matching values in the left table will be null

SELECT Employee.EmpFname, Employee.EmpLname, Project.ProjectID, Project.ProjectName FROM Employee
RIGHT JOIN Project ON Employee.EmpID=Project.EmpID;

--Full joins returns all those records which either have a match in the left or right table. If full join command isnt available use UNION command with left join query and right join query

SELECT Employee.EmpFname, Employee.EmpLname, Project.ProjectID, Project.ProjectName FROM Employee
FULL JOIN Project ON Employee.EmpID=Project.EmpID;



--Constraints
--Are rules for data entered in a table to increase accuracy and reliability
--NOT NULL, UNIQUE, PRIMARY KEY, FOREIGN KEY, CHECK, DEFAULT

CREATE TABLE employee(
ID int(6)
NAME varchar(10) CHECK(NAME != 'Chief'),
ADDRESS varchar(20)
);

CREATE TABLE employee(
ID int(6)
NAME varchar(10) DEFAULT  'Chief',
ADDRESS varchar(20)
);



--SQL FUNCTIONS
--functions are categorized into several types based on their functionality. Here are the main categories of functions in SQL:

-- 1. **Aggregate Functions**
--Aggregate functions operate on a set of values and return a single value. They are commonly used with `GROUP BY` clauses in SQL queries. Examples include:
 `SUM()` - Returns the sum of a numeric column.
 `AVG()` - Returns the average value of a numeric column.
 `COUNT()` - Returns the number of rows matching a specific condition.
 `MAX()` - Returns the maximum value in a set.
 `MIN()` - Returns the minimum value in a set.

--2. **Scalar Functions**
--Scalar functions operate on a single value and return a single value. They can be used to perform operations on strings, numbers, dates, etc. Examples include:
 `UPPER()` - Converts a string to uppercase.
 		SELECT UPPER(first_name) AS UpperCaseName FROM employees;
 `LOWER()` - Converts a string to lowercase.
 `LEN()` or `LENGTH()` - Returns the length of a string.
 `ROUND()` - Rounds a numeric value to a specified number of decimal places.
 		SELECT ROUND(salary, 2) AS RoundedSalary FROM employees;
 `GETDATE()` - Returns the current date and time.

-- 3. **String Functions**
--String functions perform operations on strings (character data). Examples include:
 `CONCAT()` - Concatenates two or more strings.
 	SELECT CONCAT(first_name, ' ', last_name) AS FullName FROM employees;
 `SUBSTRING()` - Returns a substring from a string.
 `TRIM()` - Removes leading and trailing spaces from a string.
 `REPLACE()` - Replaces occurrences of a specified substring with another substring.

-- 4. **Date Functions**
--Date functions operate on date values and return a date or a numeric value. Examples include:
 `GETDATE()` or `CURRENT_DATE` - Returns the current date.
 `DATEADD()` - Adds a specified interval to a date.
 `DATEDIFF()` - Returns the difference between two dates.
 `DATE_FORMAT()` - Formats a date value based on a specified format.

-- 5. **Numeric Functions**
--Numeric functions perform operations on numeric data types and return numeric values. Examples include:
 `ABS()` - Returns the absolute value of a number.
 `CEILING()` - Returns the smallest integer greater than or equal to a number.
 `FLOOR()` - Returns the largest integer less than or equal to a number.
 `POWER()` - Returns the value of a number raised to a specified power.

-- 6. **Conversion Functions**
--Conversion functions convert data from one type to another. Examples include:
 `CAST()` - Converts a value from one data type to another.
 		SELECT CAST(salary AS VARCHAR) AS SalaryString FROM employees;
 `CONVERT()` - Converts a value from one data type to another with additional formatting.
 		SELECT CONVERT(2022.10.27, DATE);

-- 7. **Conditional Functions**
--Conditional functions return results based on conditions. Examples include:
 `CASE` - Returns values based on specified conditions.
 	SELECT freight,
       	CASE 
           WHEN freight >= 50000 THEN 'High'
           WHEN freight >= 3000 THEN 'Medium'
           WHEN freight >= 1000 THEN 'Low'
           ELSE 'Feather'
       	END AS FreightCategory
	FROM orders;
 `COALESCE()` - Returns the first non-null value in a list.


--EXISTS
--EXISTS(subquery) -> the subquery is evaluated to determine if it returns any rows
--if the subquery returns exists turns true, if not, it returns false 

SELECT department_name
FROM departments d
WHERE EXISTS (
    SELECT 1--this value doesn't matter so much
    FROM employees e
    WHERE e.department_id = d.department_id
);






--NORMALIZATION: the process of reducing data redundancy and improves data integrity


--1NF -> every table should have a primary key, mixing data types within the same column is not permitted, repeating groups in the table are not permitted
--2NF -> every non-key attribute must depend on the whole primary key
--3NF -> non-key attributes should not depend on other non-key attributes
--Boyce-Codd NF/ BCNF -> every attribute should depend on the key attribute and nothing but the key attribute 
--4NF -> multivalued depandancies in a table must be multivalued dependancies on the key
--5NF -> the table(already in 4NF) cannot be described as the logical result of joining some other tables together







--INDEXES
--An index is an object that allows you to find specific data in a database faster. Recommended to be used on WHERE, FOREIGN KEY COLUMNS AND JOINS
--Indexes can be enforced on multiple columns
--B-tree index(has branches and leaves)

CREATE INDEX idx_emp_id ON employee(id);
DROP employee.idx_emp_id;

--Function-based index(index that created on results of a function or expression)

SELECT employee_id, annual_salary, annual_salary/12 AS monthly_salar
FROM epmloyee WHERE annual_salary/12 >= 10000;

CREATE INDEX idx_emp_mnthsalary ON employee(annual_salary/12);

--Clustered index (data in the table stored in the same way as data in the index)

CREATE CLUSTERED INDEX idx_emp_id ON employee(id);
CREATE NONCLUSTERED INDEX idx_last_name ON employee(last_name);

--Unique index (is used to enforce uniqueness of key values in the index)
CREATE UNIQUE NONCLUSTERED INDEX idx_last_name ON employee(last_name);


sp_helpindex [tablename]; --allows you to view all indexes available for a given table

  
--WHILE LOOP in SQL 
CREATE TABLE employees(
	id INT PRIMARY KEY IDENTITY,
	name VARCHAR(50),
	email VARCHAR(50),
	department VARCHAR(50)
)

Declare @counter INT =1

while @counter <=1000
begin
	DECLARE @name VARCHAR(50) = 'ABC' + RTRIM(@counter)
	DECLARE @email VARCHAR(50) = 'abc' + RTRIM(@counter) + '@barney.com'
	DECLARE @department VARCHAR(50) = 'Dept' + RTRIM(@counter)

	INSERT INTO employees VALUES (@name, @email, @department)
	
	SET @counter = @counter +1
	
	if(@counter%1000 = 0)
		Print RTRIM(@counter) + 'rows inserted'
end

--RTRIM is a trim function that removes trailing spaces




 


--VIEWS
--View is a database object representing results returned by an sql query, can be described as a virtual table except that it doesn't store any data
--Are useful for replacing common queries that are repeatedly used as one can just simply save a view for such queries


CREATE VIEW order_summary
AS
SELECT o.order_id, o.date, p.prod_name, c.cust_name
FROM customer c JOIN order o ON o.cust_id = c.cust_id
JOIN product p ON p.prod_id = o.prod_id;

SELECT * FROM order_summary;

--Purpose of using views
--1. Security: hiding the query used to create the view as well db table credentials
--2. Simplifies complex sql queries: helps avoid rewriting same complex query over and over. Sharing a view is better than sharing a complex query

--UPDATING AN EXISTING VIEW
--Updating only includes adding functionality, but column names, column data types and column order cannot be changed(o.order_id::varchar)

CREATE 	or REPLACE VIEW order_summary
AS
SELECT o.order_id, o.date, p.prod_name, c.cust_name
FROM customer c JOIN order o ON o.cust_id = c.cust_id
JOIN product p ON p.prod_id = o.prod_id;

SELECT * FROM order_summary;

--column names and data types can be changed using alter command

ALTER VIEW order_summary rename column date to order_date;

ALTER VIEW order_summary rename  to order_summary2;

DROP VIEW order_summary2; 

--Views do not reflect changes made in actual tables, views are set to the table structure at the point of their creation unless one uses create or replace to refreshh the view


--Updatable views(views that one can change data in the rows that also reflect on the table)
-- 1)Views should be created using 1 table only

create or replace view expensive_products
as
select * from product_info where price>1000;

select * from expensive_products;
select * from product_info;

update expensive_products
set prod_name = 'airpods', brand = 'apple'
where prod_id = 'p10';


-- 2) View cannot have a distinct clause

-- 3) View cannot have a group by clause

-- 4) View cannot have a WITH clause

-- 5) View cannot have window functions clause


--View attributes
--View attributes include: encryption, schemabinding, view_metadata, check option

--Encryption protects the definition of the view from access, the view definition can only be accessed where it was defined

create or replace view expensive_products
with encryption
as
select * from product_info where price>1000;


--Schemabinding binds the view to the schema of the underlying objects as a result these objects cannot be modified in a way that would affect the definition of the view

create or replace view expensive_products
with schemabinding
as
select * from product_info where price>1000;

exec sp_rename 'product_iinfo.product_id', 'id', 'COLUMN'
go;	--will result in an error as the query will change the view

--View_metadata is information about the view's properties



--Check option for updatable views that can manipulate data on tables that may cause integrity issues, this can be prevented using check options to acertain that data manipulation is scrutenised
--It applies mostly to views with WHERE

create or replace view expensive_products
with schemabinding
as
select * from product_info where price>1000
WITH check option;

update expensive_products
set prod_name = 'airpods', price = 900
where prod_id = 'p10'; --this query will fail as it attempts to add a row that fails the price condition



--Indexed Views/Materialised views: is a view that has a unique clustered index created on it thus the result of the view is stored on disk
--Schemabinding option is required for creating an indexed view. It prevents changes to the schema of the underlying tables that would affect the view

CREATE VIEW SalesSummary
WITH SCHEMABINDING AS
SELECT 
    ProductID,
    SUM(SalesAmount) AS TotalSales,
    COUNT_BIG(*) AS CountSales
FROM dbo.Sales
GROUP BY ProductID;


CREATE UNIQUE CLUSTERED INDEX idx_SalesSummary_ProductID 
ON SalesSummary (ProductID);









--BATCHES, SCRIPTS, GO AND STATEMENTS

--A sql script is a .sql file(or other) that contains SQL commands to execute
--A batch is a set of sql commands that get sent to SQL server in one network packet
--GO is a special command that is a batch terminator, as the semicolon(;) is a command terminator, GO is a batch terminator


select * from employees

select * from sales

select * from clients
where employee.id = 3

GO;









--STORED PROCEDURES(SPROCs)

--Stored procedures are prepared sql statements that can be saved to be stored in the database system for frequent use


--for example the below statement is very verbose and would be tiresome writing it down each time, might just save it as a stored procedure then call it when required

SELECT Employee.EmpFname, Employee.EmpLname, Project.ProjectID, Project.ProjectName FROM Employee
LEFT JOIN Project ON Employee.EmpID=Project.EmpID;

--Method1:
DELIMETTER $$
CREATE PROCEDURE get_employees()
BEGIN
	SELECT Employee.EmpFname, Employee.EmpLname,
	Project.ProjectName FROM Employee
	LEFT JOIN Project ON Employee.EmpID=Project.EmpID;
END$$
DELIMETTER ;

CALL get_employees();--this is the call to a stored procedure
DROP PROCEDURE get_customers();

--Method2:
CREATE PROC spGet_employees
AS
SELECT Employee.EmpFname, Employee.EmpLname,
	Project.ProjectName 
FROM Employee
LEFT JOIN Project ON Employee.EmpID=Project.EmpID;

EXEC spGet_employees;

ALTER PROC spGet_employees
WITH ENCRYPTION
AS
SELECT Employee.EmpFname, Employee.EmpLname,
	Project.ProjectName 
FROM Employee
LEFT JOIN Project ON Employee.EmpID=Project.EmpID;



--Stored procedure that takes in parameters


DELIMETTER $$
CREATE PROCEDURE find_customer(IN id INT)--take in a param id of type integer
BEGIN
	SELECT * FROM customers
	WHERE customer_id = id;
END$$
DELIMETTER ;

CALL find_customer(123)


DELIMETTER $$
CREATE PROCEDURE find_customer(IN fname VARCHAR, IN lname VARCHAR)--take in two params fname and lname both of type varchar
BEGIN
	SELECT * FROM customers
	WHERE first_name = fname AND last_name = lname;
END$$
DELIMETTER ;

CALL find_customer("larry","lobster")

--benefits:
 
--reduces network traffic
--increases performance
--secure, admin can grant permission to use


--disadvantage: increases memory usage of every connection










--USER DEFINED FUNCTIONS
--Scalar functions are functions that return a single value

CREATE FUNCTION function_name
(
@parameter1 DATATYPE,
@parameter2 DATATYPE,
...,
@parameterN DATATYPE,
)
RETURNS return_datatype
AS
BEGIN
	--Function body
	RETURN return_datatype
END


CREATE FUNCTION fn_fullname(@id INT)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @fullName VARCHAR(100)
	
	SELECT @fullName = fname + ' ' + lname FROM email WHERE id = @id
	RETURN @fullName
END

--function call(include database name)
SELECT customerDB.fn_fullname(23)

SELECT customerDB.fn_fullname(id) AS fullname from email--this will execute the function for all rows in the table


CREATE FUNCTION fn_getgender(@gender VARCHAR(10))
RETURNS TABLE
AS
RETURN ( SELECT * FROM email WHERE gender = @gender )

SELECT * FROM customerDB.fn_getgender('female')













--TRANSACTIONS IN SQL:transaction is a group of commands that change data stored in a database

--to rollback a transaction is to undo the changes made by a transaction
--One might have to disable autocommit in the database before using transactions

begin transaction
update employee set age = 30 where name = 'george'
end transaction

select * from employee

rollback transaction

--in a batch of transactions if one tranactions fails, the whole batch gets rolled back
--to make a transaction permanent, it must be committed

begin transaction
update employee set age = 30 where name = 'george'
end transaction
commit transaction


begin try
	begin transaction
	update employee set salary=50 where gender='male'
	update employee set salary=70 where gender='female'
	commit transaction
	print 'transaction committed'
end try
begin catch
	rollback transaction
	print 'transaction rolled back'
end catch


 



--LOCKING
--Locking is a feauture used to prevent data inconsistency arising due to concurrent use of database tables

--1-Exclusive(X/Write) locking: while one transaction is running with update statements(update, insert, delete) this lock prevents other transactions from accessing the same data. Lock is retained until first started transaction finishes

--2-Shared(S/read) locking: while one transaction is running a SELECT query, shared locking prevents other transactions from updating the same data with update statements(update, insert, delete).Lock is retained after row is read

--3-Intent locking: is a signal to new queries about the existence of locks for referencing data

--4-Update(U) locking: used during data modifications where the lock is acquired, the row is then evaluated if there is need for updating where it will then be changed to Exclusive lock, if not the update statement is released.











--TRIGGERS

--Triggers are sql codes that are automatically executed in responses to certain events on a particular table


CREATE TRIGGER trigger_name
{BEFORE | AFTER} {INSERT | UPDATE | DELETE}
ON table_name
FOR EACH ROW | COLUMN
BEGIN
    -- SQL statements to be executed
END;

CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    SET NEW.updated_at = NOW();
END;

SHOW TRIGGERS IN database_name








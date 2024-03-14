--TASK1

CREATE TABLE FRIENDS
(
	ID serial NOT NULL PRIMARY KEY,
	NAME VARCHAR(50),
	AGE INT,
	HOBBY VARCHAR(50),
	DEPARTMENT VARCHAR(50)
);

insert into FRIENDS (NAME,AGE,HOBBY,DEPARTMENT) VALUES ('ARSAL',20,'ASFC','CE');
insert into FRIENDS (NAME,AGE,HOBBY,DEPARTMENT) VALUES ('TAHA',18,'AASFWC','CEF');
insert into FRIENDS (NAME,AGE,HOBBY,DEPARTMENT) VALUES ('TES',21,'ASSFC','CSE');
insert into FRIENDS (NAME,AGE,HOBBY,DEPARTMENT) VALUES ('BES',22,'ADSFC','CEE');
insert into FRIENDS (NAME,AGE,HOBBY,DEPARTMENT) VALUES ('ADA',25,'ASFFC','CFE');
insert into FRIENDS (NAME,AGE,HOBBY,DEPARTMENT) VALUES ('ADA',22,NULL,'CFE');

SELECT * FROM FRIENDS WHERE ID IN (1, 3);
SELECT * FROM FRIENDS WHERE NAME LIKE 'A%';
SELECT * FROM FRIENDS WHERE AGE>=18;
--SELECT * FROM FRIENDS WHERE 2>=ID>=8;
SELECT * FROM FRIENDS WHERE ID BETWEEN 2 AND 8;

SELECT id, name as first_name, hobby, department from friends;

select distinct age from friends ;

--SELECT * FROM FRIENDS WHERE NULL;
--SELECT * FROM FRIENDS WHERE COALESCE( NAME, AGE, HOBBY, DEPARTMENT) IS NULL;

SELECT * FROM FRIENDS WHERE ID IS NULL OR NAME IS NULL OR AGE IS NULL OR HOBBY IS NULL OR DEPARTMENT IS NULL;

ALTER TABLE FRIENDS ADD COLUMN FAVDRINK VARCHAR(50);
ALTER TABLE FRIENDS ADD COLUMN	FAVNUM INT;

UPDATE FRIENDS SET FAVDRINK = 'Coffee' WHERE AGE >= 20;

ALTER TABLE FRIENDS DROP COLUMN AGE;

SELECT * FROM FRIENDS;

DROP TABLE FRIENDS;

--TASK2

CREATE TABLE EMPLOYEE_INFO
(
	EMP_ID SERIAL PRIMARY KEY,
	NAME VARCHAR(50),
	AGE INT,
	DEPARTMENT VARCHAR (50)
);

CREATE TABLE SALARY
(
	EMP_ID INT,
	SALARY INT,
	FOREIGN KEY (EMP_ID) REFERENCES EMPLOYEE_INFO(EMP_ID) 
);

INSERT INTO Employee_info (Name, Age, Department) VALUES
('John', 30, 'HR'),
('Alice', 25, 'IT'),
('Bob', 35, 'Finance'),
('Emma', 28, 'Marketing'),
('Michael', 32, 'Operations');

INSERT INTO Salary (Emp_Id, Salary) VALUES
(1, 50000),
(2, 60000),
(3, 55000),
(4, 62000),
(5, 58000);

DELETE FROM SALARY WHERE EMP_ID = 2 ;

TRUNCATE TABLE Salary;


--LAB 3
-- Create the order_table
CREATE TABLE order_table (
    order_id INT,
    total_amount DECIMAL(10, 2),
    customer_id INT,
    quantity INT,
    order_date DATE
);

-- Insert sample data into the order_table
INSERT INTO order_table (order_id, total_amount, customer_id, quantity, order_date)
VALUES
(1, 50.00, 101, 2, '2024-03-01'),
(2, 100.00, 102, 3, '2024-03-02'),
(3, 150.00, 103, 1, '2024-03-03'),
(4, 200.00, 104, 4, '2024-03-04'),
(5, 250.00, 105, 2, '2024-03-05'),
(6, 300.00, 101, 5, '2024-03-06'),
(7, 350.00, 102, 3, '2024-03-07'),
(8, 400.00, 103, 2, '2024-03-08'),
(9, 450.00, 104, 1, '2024-03-09'),
(10, 500.00, 105, 4, '2024-03-10'),
(11, 550.00, 101, 3, '2024-03-11'),
(12, 600.00, 102, 2, '2024-03-12'),
(13, 650.00, 103, 3, '2024-03-13'),
(14, 700.00, 104, 1, '2024-03-14'),
(15, 750.00, 105, 5, '2024-03-15');

-- 1. Identify customers who have placed more than 5 orders and list them along with the total number of orders placed
SELECT customer_id, COUNT(*) AS total_orders
FROM order_table
GROUP BY customer_id
HAVING COUNT(*) > 5;

--alternate query1
SELECT 
    customer_id, 
    COUNT(order_id) AS total_orders -- Counting the number of orders for each customer
FROM 
    order_table
GROUP BY 
    customer_id -- Grouping the results by customer_id
HAVING 
    COUNT(order_id) > 5; -- Filtering out customers with more than 5 orders


-- 2. Find the total amount spent by each customer and list them in descending order of total spending
SELECT customer_id, SUM(total_amount) AS total_spending                    
  
FROM order_table
GROUP BY customer_id
ORDER BY total_spending DESC;

--3. Identify products with an average order quantity greater than 10 and list them along with their average order quantity
--SELECT product_id, AVG(quantity) AS average_order_quantity FROM order_table GROUP BY product_id HAVING AVG(quantity) > 10;
--Perform the query to identify products with an average order quantity greater than 10
SELECT 'All Products' AS product_name, AVG(quantity) AS average_order_quantity
FROM order_table
HAVING AVG(quantity) > 10;


-- 4. Identify customers who have placed orders with a total amount greater than $1000 and list them along with their total spending
SELECT customer_id, SUM(total_amount) AS total_spending
FROM order_table
GROUP BY customer_id
HAVING SUM(total_amount) > 1000;

DROP TABLE ORDER_TABLE;


                    
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
                      
  

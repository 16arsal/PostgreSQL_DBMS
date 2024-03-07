CREATE TABLE TABLE1 (ID SERIAL PRIMARY KEY, NAME VARCHAR(50));
CREATE TABLE TABLE2 (ID SERIAL, NAME VARCHAR(50),PRIMARY KEY (ID));
CREATE TABLE TABLE3 (ID SERIAL, NAME VARCHAR(50));
ALTER TABLE  TABLE3 ADD CONSTRAINT ID_PKEY PRIMARY KEY (ID);
ALTER TABLE  TABLE3 DROP CONSTRAINT ID_PKEY;
CREATE TABLE TABLE4 (IDT4 SERIAL PRIMARY KEY, ID SERIAL, SALARY NUMERIC , CONSTRAINT F_KEY FOREIGN KEY (ID) REFERENCES TABLE3(ID));
CREATE TABLE TABLE5(ID SERIAL, NAME VARCHAR(50), BIRTHDATE DATE CHECK  (BIRTHDATE > '1999-01-01'));
ALTER TABLE TABLE5 ADD CONSTRAINT UNI_ID UNIQUE(ID);
--ALTER TABLE TABLE5 ADD CONSTRAINT NULL_ID NOT NULL(ID));
--CREATE TABLE TABLE6 (ID SERIAL NOT NULL);
ALTER TABLE TABLE5 ALTER COLUMN ID SET NOT NULL;


-- Create Product Table WITH RELEVANT STUFF
CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category_id INT,
    price NUMERIC(10, 2),
    quantity_in_stock INT,
    CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES Category(category_id) --TO FETCH 
);

-- Create Category Table --TO BE RUN FIRST
CREATE TABLE Category (
    category_id INT PRIMARY KEY, --MAKING IT PRIMARY KEY
    name VARCHAR(100) --NAME LIMIT UPTO 100
);

-- Insert data into Category Table
INSERT INTO Category (category_id, name) VALUES
(1, 'Electricity'), --TYPE1
(2, 'Garments'), --TYPE2
(3, 'Education'); --TYPE2

-- Insert data into Product Table
INSERT INTO Product (product_id, name, category_id, price, quantity_in_stock) VALUES
(1, 'Macbook', 1, 1200.00, 10),  --RAW DATA
(2, 'iPhone', 1, 800.00, 20),  --RAW DATA
(3, 'SupremeShirt', 2, 25.00, 50),  --RAW DATA
(4, 'Levis511', 2, 50.00, 30),  --RAW DATA
(5, 'BeatsHeadPhones', 1, 50.00, 15), --RAW DATA
(6, 'AngelsAndDemons', 3, 10.00, 100), --RAW DATA
(7, 'STab', 1, 300.00, 5),  --RAW DATA
(8, 'PrinceCoat', 2, 80.00, 10), --RAW DATA
(9, 'AsusMouse', 1, 15.00, 25), --RAW DATA
(10, 'MacKeyBoard', 1, 30.00, 20);  --RAW DATA

--  Update the value of product price where product_id is 3
UPDATE Product SET price = 50.00 WHERE product_id = 3; 

--  Add Not Null constraint on price column
ALTER TABLE Product ALTER COLUMN price SET DATA TYPE NUMERIC(10, 2); --TYPECASTING
ALTER TABLE Product ALTER COLUMN price SET NOT NULL; --QUERY 

--  Enforce unique constraint on product_id and name
ALTER TABLE Product ADD CONSTRAINT unique_product_id_name UNIQUE (product_id, name); --TYPE OF CONSTRAINT

--  Add a check constraint to ensure that the price of the product is greater than 0
ALTER TABLE Product ADD CONSTRAINT check_price_positive CHECK (price > 0); --LOGICAL OPEARTION

-- Delete all products whose quantity_in_stock is less than or equal to 0
DELETE FROM Product WHERE quantity_in_stock <= 0; --CONDITION

--  Retrieve the data from both the tables together using join
SELECT p.product_id, p.name AS product_name, c.name AS category_name, p.price, p.quantity_in_stock
FROM Product p --USING JOIN TO RETRIEVE DATA
INNER JOIN Category c ON p.category_id = c.category_id;

--  Count the number of products in each category
SELECT c.name AS category_name, COUNT(*) AS product_count
FROM Product p --FROM PRODUCT TABLE
INNER JOIN Category c ON p.category_id = c.category_id --TYPE OF JOINING
GROUP BY c.name; --SORTING

--  Add a unique constraint to category name to ensure that categories are not repeated
ALTER TABLE Category ADD CONSTRAINT unique_category_name UNIQUE (name); -- UNIQUE CONSTRAINT

--  Drop NOT NULL constraint applied on price column
ALTER TABLE Product ALTER COLUMN price SET DATA TYPE NUMERIC(10, 2);
ALTER TABLE Product ALTER COLUMN price DROP NOT NULL; --TYPECASTING

--  Drop foreign key constraint applied on category_id
ALTER TABLE Product DROP CONSTRAINT fk_category_id; --DELETING

SELECT * FROM PRODUCT; --DISPLAY ALL THE VALUES

DROP TABLE PRODUCT; --DELETING TABLES FOR RE RUNNING
DROP TABLE CATEGORY; --DELETING TABLES FOR RE RUNNING











CREATE TABLE T1(ID SERIAL, NAME VARCHAR(50), AGE INT);
INSERT INTO T1(NAME,AGE) VALUES('UMER',34),('BASIT',25);
INSERT INTO T1(NAME,AGE) VALUES('UMEEEER',34),('BAIT',25);
SELECT * FROM T1;
SELECT AVG (AGE) AS AVG_AGE FROM T1;
SELECT COUNT(*) AS CNT_M FROM T1;

SELECT MAX(AGE) AS MAX_NUM FROM T1;
SELECT MIN(AGE) AS MIN_NUM FROM T1;
SELECT SUM(AGE) AS SUM_NUM FROM T1;

SELECT * FROM T1;
SELECT ID, STRING_AGG(NAME||','||AGE,','ORDER BY ID ASC)
FROM T1 GROUP BY ID;
--SYNTAX FOR CONCATENATION
SELECT STRING_AGG(ID||','||NAME|| ','||AGE,',' ORDER BY ID ASC)
FROM T1 GROUP BY ID;

--SELECT ID FROM T1 WHERE AGE>AVG(AGE);

SELECT ID FROM T1 WHERE AGE>ALL(SELECT AVG(AGE) FROM T1 GROUP BY ID);
SELECT COUNT (*) AS CNT_MAX FROM T1 WHERE AGE < (SELECT COUNT (*) FROM T1);

SELECT COUNT(*) AS CNT_MAX 
FROM T1 
WHERE AGE < (SELECT COUNT(*) FROM T1);
 
 
SELECT AVG(AGE) AS AGE_AVG 
FROM T1
WHERE AGE > (SELECT AVG(AGE) FROM T1);

SELECT *
FROM T1
WHERE AGE < ALL(SELECT AGE FROM T1 WHERE AGE < 23);


SELECT *
FROM T1
WHERE AGE > ANY(SELECT AGE FROM T1 WHERE AGE>23);

DROP TABLE T1;





























-- Create tables
CREATE TABLE employees (
  employee_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  department VARCHAR(255) NOT NULL,
  salary NUMERIC(10, 2) NOT NULL
);

CREATE TABLE projects (
  project_id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL
);

CREATE TABLE employee_projects (
  employee_id INTEGER NOT NULL,
  project_id INTEGER NOT NULL,
  PRIMARY KEY (employee_id, project_id),
  FOREIGN KEY (employee_id) REFERENCES employees (employee_id) ON DELETE CASCADE,
  FOREIGN KEY (project_id) REFERENCES projects (project_id) ON DELETE CASCADE
);

-- Insert sample data
INSERT INTO employees (name, department, salary) VALUES ('Arsal', 'HR', 50000);
INSERT INTO employees (name, department, salary) VALUES ('Saeed', 'IT', 600);
INSERT INTO employees (name, department, salary) VALUES ('Affan', 'IT', 7000);
INSERT INTO employees (name, department, salary) VALUES ('Ahmed', 'HR', 39000);

INSERT INTO projects (name, start_date, end_date) VALUES ('Project A', '2023-01-01', '2023-12-31');
INSERT INTO projects (name, start_date, end_date) VALUES ('Project B', '2024-01-01', '2024-12-31');

INSERT INTO employee_projects (employee_id, project_id) VALUES (1, 1);
INSERT INTO employee_projects (employee_id, project_id) VALUES (2, 1);
INSERT INTO employee_projects (employee_id, project_id) VALUES (2, 2);
INSERT INTO employee_projects (employee_id, project_id) VALUES (3, 2);

-- Perform required operations
-- 1. Calculate the total salary of all employees
SELECT SUM(salary) FROM employees;

-- 2. List all employees along with the total number of projects they are assigned to
SELECT e.name, COUNT(ep.project_id) AS num_projects
FROM employees e
LEFT JOIN employee_projects ep ON e.employee_id = ep.employee_id
GROUP BY e.name;

-- 3. List all projects along with the total number of employees assigned to each project
SELECT p.name, COUNT(ep.employee_id) AS num_employees
FROM projects p
LEFT JOIN employee_projects ep ON p.project_id = ep.project_id
GROUP BY p.name;

-- 4. List all departments along with the average salary of employees in each department
SELECT e.department, AVG(e.salary) AS avg_salary
FROM employees e
GROUP BY e.department;

-- 5. Concatenate the names of employees working on each project into a single string
SELECT p.name, STRING_AGG(e.name, ', ') AS employee_names
FROM projects p
JOIN employee_projects ep ON p.project_id = ep.project_id
JOIN employees e ON ep.employee_id = e.employee_id
GROUP BY p.name;

-- 6. Find the project with the longest duration
SELECT *
FROM projects
ORDER BY end_date - start_date DESC
LIMIT 1;

-- 7. List employees who are not assigned to any project
SELECT e.name
FROM employees e
WHERE NOT EXISTS (
  SELECT 1
  FROM employee_projects ep
  WHERE ep.employee_id = e.employee_id
);

-- 8. List employees who are assigned to all projects
SELECT e.name
FROM employees e
WHERE e.employee_id IN (
  SELECT ep.employee_id
  FROM employee_projects ep
  GROUP BY ep.employee_id
  HAVING COUNT(DISTINCT ep.project_id) = (SELECT COUNT(*) FROM projects)
);

-- 9. List employees who are assigned to projects with project IDs 1, 2, or 3
SELECT e.name
FROM employees e
JOIN employee_projects ep ON e.employee_id = ep.employee_id
WHERE ep.project_id IN (1, 2, 3)
GROUP BY e.name
HAVING COUNT(DISTINCT ep.project_id) = 3;

-- 10. List employees who have a salary greater than the salary of at least one other employee
SELECT e1.name
FROM employees e1
WHERE EXISTS (
  SELECT 1
  FROM employees e2
  WHERE e1.employee_id != e2.employee_id AND e1.salary > e2.salary
);

DELETE FROM employee_projects;
DELETE FROM projects;
DELETE FROM employees;
DROP TABLE employee_projects CASCADE;
DROP TABLE projects CASCADE;
DROP TABLE employees CASCADE;









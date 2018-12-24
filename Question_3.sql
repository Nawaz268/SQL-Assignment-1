
/* Question 3a*/

SELECT 
    Country,
    SUM(Gender = 'M') AS Male,
    SUM(Gender = 'F') AS Female,
    SUM(Gender = 'M') * 100 / COUNT(*) AS perMale
FROM
    customer
GROUP BY country
ORDER BY perMale ASC;

/* Question 3b*/

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT 
    p.product_id as "Product ID",
    p.Product_Name as "Product Name",
    SUM(o.quantity) AS "Total Sold"
FROM
    product_dim p
     Inner Join order_fact o
WHERE
    o.product_id = p.Product_ID
GROUP BY p.product_id
ORDER BY SUM(o.quantity) DESC;


/*Question 3c*/

SELECT 
    emp1.Employee_ID as "Employee ID",
    emp1.Employee_Name as "Employee Name",
    s.Job_Title as "Job Title",
    s.Manager_ID as "Manager ID",
    emp2.Employee_Name AS "Employee Name"
FROM
    employee_addresses emp1,
    employee_addresses emp2,
    staff s
WHERE
    emp2.employee_id = s.Manager_ID
        AND emp1.Employee_ID = s.Employee_ID
        AND s.Job_Title LIKE '%TEMP%'
        OR s.Job_Title LIKE '%train%'
ORDER BY s.Employee_ID;


/* Question 3d*/


SELECT employee_id, 
       salary                        AS "Salary", 
       Lag(salary, 1, 0) 
         OVER ( 
           ORDER BY salary)          AS "Salary Previous", 
       salary - Lag(salary, 1, 0) 
                  OVER ( 
                    ORDER BY salary) AS "Salary Difference" 
FROM   employee_payroll 
ORDER  BY "salary"; 

SELECT employee_id, 
       salary                        AS "Salary", 
       Lead(salary, 1, 0) 
         OVER ( 
           ORDER BY salary)          AS "Salary Next", 
       Lead(salary, 1, 0) 
         OVER ( 
           ORDER BY salary) - salary AS "Salary Difference" 
FROM   employee_payroll 
ORDER  BY "salary"; 

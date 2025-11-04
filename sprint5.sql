USE hr;




  
  -- task1--------------------------------------------------------------------------------------------------------
  -- select the id ,first name, last name and department name using subqueries(tables employees,departments)
  
 select  employee_id, first_name, last_name,(select department_name from departments where department_id=employees.employee_id )as department_name from employees;
 ######################################################################################################################################################################
 
 --     TASK2 

-- Display the first names, last names, and salaries of the employees whose salaries are greater than the average salary of all employees, grouped by the department IDs.

-- Hint: This query involves only one table. Try to use aggregate function.
SELECT employees.first_name, employees.last_name, employees.salary, employees.department_id
FROM employees 
LEFT JOIN (
  SELECT department_id,AVG(salary) AS Averages_Salary
  FROM employees
  GROUP BY department_id
) AS Average ON employees.department_id = Average.department_id 
WHERE employees.salary  > Averages_Salary ;



###########################################################################################################################################

 -- Task3  
 
 -- display the firstname,lastname of those employees of sales department who have salary less than the avg salary of the  all employees of sales department use to tables like employee and depatment using subquries
 
select first_name, last_name from  employees where department_id=(select department_id from departments where department_name='Sales')
and salary< all(select  avg(salary) from employees where department_id=(select department_id from departments where department_name='sales'));

#####################################################################################################################################################################

-- TASK4

-- display the firstname,lastname ans salary of  employees who have salary lhigher than the max  salary of the  all employees of it_programmers.  and display the salary in ascending order.
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = 'it_programmers'
)
ORDER BY salary ASC;


 ####################################################################################################################################################################################################
-- TASK5     display the employees min salary  of all employees group by employee_id and arrange the salary in ascending order.

SELECT e.employee_id, (SELECT MIN(salary) FROM employees AS inner_emp WHERE inner_emp.employee_id = e.employee_id) AS min_salary
FROM employees AS e
GROUP BY e.employee_id
ORDER BY min_salary ASC;


###################################################################################################################################################
-- Task6
-- Task 6

-- Display the first names, last names, and department IDs of the employees whose salary is greater than 60% of the sum of the salaries of all employees of their respective departments.

-- Hints:

-- i. The data for the above task is present in a single table.

-- ii. Try to use comparison operator.
select first_name, last_name, department_id,salary
from employees
where  salary > any(
  select AVG(salary)*0.6
  from employees
  where department_id = employees.department_id
);

 #################################################
 -- Display the first names and last names of all those employees who have their managers based out of UK, using subquery.

-- int The data for the above task is present in three different tables.
 
 --
SELECT e.first_name, e.last_name
FROM hr.employees e
WHERE e.manager_id IN (
    SELECT m.employee_id
    FROM hr.employees m
    JOIN hr.departments d ON m.department_id = d.department_id
    JOIN hr.locations l ON d.location_id = l.location_id
    WHERE l.country = 'UK'
);
USE hr;

SELECT e.first_name, e.last_name
FROM employees e
WHERE e.manager_id IN (
    SELECT m.employee_id
    FROM employees m
    JOIN departments d ON m.department_id = d.department_id
    JOIN locations l ON d.location_id = l.location_id
    WHERE l.country = 'UK'
);


SELECT e.first_name, e.last_name
FROM employees e
WHERE e.manager_id IN (
    SELECT m.manager_id
    FROM employees m
    JOIN departments d ON m.department_id = d.department_id
    JOIN locations l ON d.location_id = l.location_id
    WHERE l.country = 'UK'
);
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.manager_id IN (
    SELECT m.manager_id
    FROM employees m
    JOIN departments d ON m.department_id = d.department_id
    JOIN locations l ON d.location_id = l.location_id
    WHERE l.country = 'UK'
);
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.manager_id IN (
    SELECT m.manager_id
    FROM employees m
    JOIN departments d ON m.department_id = d.department_id
    JOIN locations l ON d.location_id = l.location_id
    WHERE l.country = 'UK'
);
SELECT e.first_name, e.last_name
FROM employees e
WHERE e.manager_id IN (
    SELECT m.manager_id
    FROM employees m
    JOIN departments d ON m.department_id = d.department_id
    JOIN locations l ON d.location_id = l.location_id
    WHERE l.country = 'UK'
);

DESCRIBE hr.locations;
SELECT e.first_name, e.last_name
FROM hr.employees e
WHERE e.manager_id IN (
    SELECT m.employee_id
    FROM hr.employees m
    JOIN hr.departments d ON m.department_id = d.department_id
    JOIN hr.locations l ON d.location_id = l.location_id
    WHERE l.location_country = 'UK'
);









 
#####################################################################################################################################################################
-- Task8 display the employees firstname,lastname salary of top 5 using csv files.
select hr;
select first_name,last_name,salary from employees   order by salary desc limit 5;



###############################################################################################################################################


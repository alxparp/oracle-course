-- 1. Projection/data sampling

-- 1.1. Build a logical query plan that receives the names of employees, 
--      E-mail, their salary for the last three months, including commissions.

select last_name, email, commission_pct, ((salary + salary*NVL(commission_pct,0))*3) as sal
from employees;


-- 1.2. Construct a logical query plan that:
--      * receives the name of the unit;
--      * the division is managed by a manager with ID = 114

select department_name
from departments
where manager_id = 114;


-- 1.3. Build a logical query plan that:
--      * receives the name of employees;
--      * the paid salary of employees for the entire period of work should be in the range from
--        $50,000 to $100,000 numbers down - round ).

select last_name
from employees
where (round(months_between(current_date, hire_date)*salary))
between 500000 and 1000000;


-- 1.4. Build a logical query plan that:
--      * receives the name of employees;
--      * employees work in department with ID = 90;
--      * Salary ranges from $5,000 to $10,000

select last_name
from employees
where department_id = 90
        and salary between 20000 and 30000;
        


-- 2. Table joins

-- 2.1. Build a logical query plan that receives the last name of employees, 
--      the names of departments and the city in which they work.       
        
select last_name, department_name, country_name
from employees emp, departments dep, locations loc, countries countr
where emp.department_id = dep.department_id
    and dep.location_id = loc.location_id
    and loc.country_id = countr.country_id;
    

-- 2.2. Build a logical query plan that:
--      * receives the surname of the employees, the names of the departments in which they work;
--      * subdivisions are located in the city = Seattle.
    
select last_name, department_name
from employees emp, departments dep, locations loc
where emp.department_id = dep.department_id
    and dep.location_id = loc.location_id
    and loc.city = 'Seattle';
    

-- 2.3. Build a logical query plan that:
--      * receives a surname, the title of a position of employees;
--      * employees work in the city = Toronto.
    
select last_name, job_title
from employees empl, jobs job, departments dep, locations loc
where empl.job_id = job.job_id
    and empl.department_id = dep.department_id
    and dep.location_id = loc.location_id
    and loc.city = 'Toronto';


-- 2.4. Construct a logical query plan that:
--      * receives a surname, the title of a position of employees;
--      * the employee's salary must fall within the range of minimum and maximum salaries,
--        established in the directory of positions.    
    
select last_name, job_title
from employees emp, jobs job
where emp.job_id = job.job_id
    and emp.salary between job.min_salary and max_salary;
    

-- 2.5. Build a logical query plan that receives the number and surname of the employee,
--      the name and number of his manager.
    
select emp.employee_id, emp.last_name employee, mgr.employee_id manager_id, mgr.last_name manager
from employees emp, employees mgr
where emp.manager_id = mgr.employee_id;


-- 2.6. Build a logical query plan that:
--      * receives the number and name of units;
--      * subdivisions are located in the country = United States of America;
--      * there should be no employees in the departments.

select distinct dep.department_id, dep.department_name
from departments dep, locations loc, countries countr, employees emp
where dep.location_id = loc.location_id
    and loc.country_id = countr.country_id
    and countr.country_name = 'United States of America'
    and dep.department_id not in (select nvl(department_id, 0) 
                                        from employees
                                        group by department_id
                                        having count(employee_id) > 0);
										

-- 3. Data sampling

-- 3.1 Run a query that gets the names of employees and their E-mail addresses 
--     in full format: E-mail attribute value + "@Netcracker.com"										
										
select email || '@Netcracker.com' full_email
from employees;


-- 3.2. Run a query that:
--      * receives the name of employees and their salary;
--      * salary exceeds $15,000.

select last_name, salary
from employees
where salary > 15000;


-- 3.3. Run a query that gets the names of employees, salary, commissions, 
--      their salary for the year, taking into account commissions.

select last_name, salary, nvl(commission_pct, 0) commis, 
    (salary + salary*nvl(commission_pct, 0)) full_salary
from employees;



-- 4. Working with sets

-- 4.1. Run a query that:
--      * receives for each employee a string in the format
--        'Dear '+A+ ' ' + B + ’! ' + ' Your salary = ' + C,
--        where A = {‘Mr.’,’Mrs.’} is an abbreviated version of the address to a man or woman
--        (assume that all female employees whose name ends with the letter
--        'a' or 'e')
--        B – last name of the employee;
--        C - annual salary including employee commissions

select 'Dear Mrs. ' || last_name || '! Your salary = ' || (salary+salary*nvl(commission_pct, 0)*12) annual_sal
from employees
where substr(first_name, length(first_name), length(first_name)) in('e', 'a')
union
select 'Dear Mr. ' || last_name || '! Your salary = ' || (salary+salary*nvl(commission_pct, 0)*12) annual_sal
from employees
where substr(first_name, length(first_name), length(first_name)) not in('e', 'a');



-- 5. Table join operations

-- 5.1 Run a query that:
--     * receives the names of departments;
--     * divisions are located in the city of Seattle.

select department_name
from departments dep 
    inner join locations loc
        on dep.location_id = loc.location_id
where loc.city = 'Seattle';  



-- 5.2. Run a query that:
--      * receives the surname, position, department number of employees
--      * employees work in the city of Toronto.

select emp.last_name, j.job_title, emp.department_id
from employees emp
    inner join departments dep
        on emp.department_id = dep.department_id
    inner join locations loc
        on dep.location_id = loc.location_id
    inner join jobs j
        on emp.job_id = j.job_id
where loc.city = 'Toronto'; 


-- 5.3. Run a query that:
--      * receives the number and surname of the employee, the number and surname of his manager

select emp.employee_id, emp.last_name employee, mgr.employee_id manager_id, mgr.last_name manager
from employees emp
    inner join employees mgr
        on emp.manager_id = mgr.employee_id;


-- 5.4. Run a query that:
--      * receives the number and name of units;
--      * divisions are located in the country UNITED STATES OF AMERICA
--      * there should be no employees in the departments.        
        
select distinct dep.department_id, dep.department_name
from departments dep
    inner join locations loc
        using(location_id)
    inner join countries c
        using(country_id)
    left join employees empl
        using(department_id)
where empl.department_id is null
    and c.country_name = 'United States of America';



-- 6. Data aggregation

-- 6.1. Run a query that:
--      * receives the number of employees in each department;
--      * the number of employees should not be less than 2;

select department_name, count(employee_id)
from employees empl
    inner join departments dep
        on empl.department_id = dep.department_id
group by dep.department_name
having count(employee_id) >= 2;


-- 6.2. Run a query that:
--      * receives the titles of positions and the average salary for the position;
--      * the position must be related to management, i.е. contain the word Manager;
--      * the average salary should not be less than 10 thousand.

select job_title, avg(salary)
from jobs j
    inner join employees e
        on j.job_id = e.job_id
where job_title like '%Manager'        
group by job_title
having avg(salary) >= 10000;


-- 6.3. Run a query that:
--      * receives the number of employees in each department;
--      * the last line of the response to the request should be the total number of employees.


select dep.department_name, count(employee_id)
from employees empl
    inner join departments dep
        using(department_id)
group by rollup(dep.department_name);	
    
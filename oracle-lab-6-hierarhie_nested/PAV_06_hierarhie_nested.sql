-- Homework


select distinct j.job_title
from jobs j, employees e
where j.job_id = e.job_id;

select j.job_title
from jobs j
where exists (select job_id
                from employees
                where j.job_id = job_id);
                
select last_name, salary
from employees
where salary > (select avg(salary)
                from employees
                    inner join departments using(department_id)
                    inner join locations using(location_id)
                    inner join countries using(country_id)
                    inner join regions using(region_id)
                where region_name = 'Europe');

select department_name
from departments e
where exists (
        select e1.department_id
        from employees e1, (select department_id, avg(salary) avgsal
                        from employees
                        group by department_id) e2
        where e1.department_id = e2.department_id
        and e.department_id = e2.department_id
        and salary > avgsal);

with
country_with_count as
(
    select country_name, count_empl
    from (select c.country_name, count(employee_id) count_empl
            from employees e
                inner join departments d 
                    on e.department_id = d.department_id
                inner join locations l
                    on d.location_id = l.location_id
                inner join countries c 
                    on l.country_id = c.country_id
            group by c.country_name)
) 
select country_name 
from country_with_count
where count_empl = (select min(count_empl)
                    from country_with_count);
					
					
with max_salary as
(select last_name, round(salary*months_between(sysdate, hire_date)) income
        from employees)
select last_name
from max_salary
where income = (select max(income) from max_salary);


select dep.department_id, contr.country_name, dep.department_name
from countries contr
    inner join locations loc
        on contr.country_id = loc.country_id
    inner join departments dep
        on loc.location_id = dep.location_id
where not exists (select employee_id 
                    from employees emp
                    where dep.department_id = emp.department_id);
					

select 
    dep.department_name, 
    sum(emp.salary) dep_sum,
    sum(emp.salary)/(select sum(salary) general_sum from employees)*100 percent
from departments dep
    inner join employees emp
        on dep.department_id = emp.department_id
group by dep.department_name
union all
select dep.department_name, 0 dep_sum, 0 percent
from departments dep
where not exists (select employee_id 
                    from employees emp
                    where dep.department_id = emp.department_id);
					


create sequence locno start with 3300 increment by 100;
create sequence deptno start with 280 increment by 10;
create sequence empno start with 207 increment by 1;			

insert all
    into jobs(job_id, job_title, min_salary, max_salary)
        values ('SD_PROG', 'Software Developer', 1000, 5000)
    into countries(country_id, country_name, region_id)
        values ('UA', 'Ukraine', 1)
    into locations(location_id, street_address, postal_code, city, state_province, country_id)
        values (locno.nextval, 'Myasoedovskaya, 1', 52250, 'Odessa', 'Odessa', 'UA')
    into departments(department_id, department_name, manager_id, location_id)
        values (deptno.nextval, 'NC Office', null, locno.currval)
    into employees (employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
        values (empno.nextval, 'Alex', 'Parpalak', 'al.parp@gmail.com', '380994586234', sysdate, 'SD_PROG', 4000, 0.35, null, deptno.currval)
select * from dual;


delete from countries
where country_id = (
    select distinct countr.country_id 
    from countries countr
        inner join locations loc
            on countr.country_id = loc.country_id
        inner join departments dep
            on loc.location_id = dep.location_id
    where not exists (select emp.employee_id 
                            from employees emp
                            where dep.department_id = emp.department_id)
);



update employees set 
commission_pct = commission_pct * 0.1
where employee_id = (select employee_id 
					 from employees 
					 where (sysdate-hire_date) =
						(select max(sysdate-hire_date)
						 from employees 
						 where department_id = 
							  (select e.department_id
							   from employees e
							   group by department_id having avg(salary) < all (
										select avg(salary)
										from employees em
										where e.department_id <> em.department_id
										group by department_id
							   ) and department_id is not null)));
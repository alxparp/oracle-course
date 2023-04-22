-- Stage 1. Creating views (VIEW) with arbitrary names

-- 1.1. In the old database, create views with arbitrary names and 
--      column names.(Warning! If a permissions error occurs while 
--      creating a view, the username system you need to run: GRANT 
--      CREATE VIEW TO username;)

-- 1.1.1 Create a view that:
--       - receives the last name of the employees and the number of 
--		   months that have passed since they were hired work;
--		 - the surname of employees should be presented as: the first 
--         letter in uppercase, the rest - in lower;
--       - round off the number of months to the nearest integer;
--       - sort employees by period descending
-- 		 Execute a query on the generated view.

create view emp_work_months
as select initcap(last_name) last_name, round(months_between(sysdate, hire_date)) work_months
from employees
order by hire_date;

select * from emp_work_months;


-- 1.1.2. Create a view that:
--        - receives surnames, names of employees;
--        - receives a "Tax" salary increment for employees, which is 
--          defined as 0.4% for each month of work for Programmer, 0.3% 
--          for each month of work for Accountant, 0.2% for each month 
--          of work for Sales Manager 0.1% for each month of work for 
--          Administration Assistant.
--        Execute a query on the generated view.

create view emp_taxes
as select last_name, first_name,
        decode(job_title, 'Programmer', salary*0.004,
                            'Accountant', salary*0.003,
                            'Sales Manager', salary*0.002,
                            'Administration Assistant', salary*0.001,
                            salary*0) Tax           
from employees emp, jobs job
where emp.job_id = job.job_id;

select * from emp_taxes;


-- 1.1.3. Create a view that:
--        - receives the names of employees and the number of days off 
--          (Saturday, Sunday) from the moment they are hired;
--        - Employees were enlisted in March 1999.
--        Execute a query on the generated view.

create view empl_day_offs
as select last_name, round((sysdate-hire_date)/7*2) day_offs
from employees
where hire_date between '01-03-99' and '31-03-99';

select * from empl_day_offs;


-- Stage 2. Primary filling of database tables storing project data

-- 2.1. For all tables of the new database, create sequence generators 
--      that automatically create new column values included in the 
--      primary key.

drop sequence department_sq;
drop sequence employee_sq;
drop sequence location_sq;
drop sequence position_sq;
drop sequence product_sq;
drop sequence transaction_sq;

create sequence department_sq
increment by 1
start with 1
maxvalue 99
nocache
nocycle;

create sequence employee_sq
increment by 1
start with 1
maxvalue 99
nocache
nocycle;

create sequence location_sq
increment by 1
start with 1
maxvalue 99
nocache
nocycle;

create sequence position_sq
increment by 1
start with 1
maxvalue 99
nocache
nocycle;

create sequence product_sq
increment by 1
start with 1
maxvalue 99
nocache
nocycle;

create sequence transaction_sq
increment by 1
start with 1
maxvalue 99
nocache
nocycle;


-- 2.2. For each table of the new database, create 2 commands for 
--      entering data (enter two lines).

insert into location(location_id, city_name)
values (location_sq.nextval, 'San-Francisco');

insert into location (location_id, city_name)
values (location_sq.nextval, 'Kyiv');

insert into department(department_id, department_name, location_id)
values (department_sq.nextval, 'Administration', 1);

insert into department(department_id, department_name, location_id)
values (department_sq.nextval, 'Marketing', 2);

insert into position(position_id, position_name)
values (position_sq.nextval, 'President');

insert into position(position_id, position_name)
values (position_sq.nextval, 'Marketing Manager');

insert into employee(employee_id, first_name, last_name, hire_date, department_id, position_id)
values (employee_sq.nextval, 'Steven', 'King', '17.01.87', 2, 1);

insert into employee(employee_id, first_name, last_name, hire_date, department_id, position_id)
values (employee_sq.nextval, 'Alexander', 'Hunold', '17.01.97', 3, 2);

insert into product(product_id, product_name, price)
values (product_sq.nextval, 'Cigarettes', 27);

insert into product(product_id, product_name, price)
values (product_sq.nextval, 'Wine', 50);

insert into transaction(trans_id, trans_date, product_id, employee_id)
values (transaction_sq.nextval, '22.04.2023', 1, 4);

insert into transaction(trans_id, trans_date, product_id, employee_id)
values (transaction_sq.nextval, '22.04.2023', 2, 4);


-- 2.3. Run a command to commit all changes to the database.

commit;


-- 2.4. For one of the tables containing a foreign key integrity 
--      constraint, execute a command to change the value of the foreign 
--      key column to a value that is not in the primary key column of 
--      the corresponding table. Check the response of the DBMS to such 
--      a change.

update department set department_id = 3;


-- 2.5. For one of the tables containing a primary key integrity 
--      constraint, execute a command to change the value of the primary 
--      key column to a value that is not in the foreign key column of 
--      the corresponding table. Check the response of the DBMS to such 
--      a change.

delete from department where departmnet_id = 3;


-- 2.7. For one of the tables, change the foreign key integrity 
--      constraint that enables the cascading delete.

alter table transaction drop constraint trans_empl_fk;
alter table transaction drop constraint trans_prod_fk;
ALTER TABLE TRANSACTION ADD
	CONSTRAINT trans_empl_FK
		FOREIGN KEY (employee_id) 
			REFERENCES EMPLOYEE (employee_id)
				ON DELETE CASCADE;
ALTER TABLE TRANSACTION ADD
	CONSTRAINT trans_prod_FK
		FOREIGN KEY (product_id) 
			REFERENCES product (product_id)
				ON DELETE CASCADE;


-- 2.8. Execute a command to cancel (rollback) the delete operation

rollback;

-- Stage 3. Conducting database change operations

-- 3.1. Increase commissions by 5% to all programmers (Programmer) who 
--      have worked for more than 20 years.

update employees
set commission_pct = (nvl(commission_pct,0)+(nvl(commission_pct,0)*0.05))
where job_id in (select emp.job_id
                    from employees emp
                        inner join jobs j
                            on emp.job_id = j.job_id
                    where (months_between(current_date, hire_date)/12) > 20
                        and job_title = 'Programmer');


-- 3.2 Dismiss all employees (remove from the table) who have worked for 
--     more than 20 years in the position of Shipping Clerk. Before 
--     deleting, store the information about the employees being laid 
--     off in a separate employee_drop table, which contains the same 
--     structure as the employee table.

insert into job_history (employee_id, start_date, end_date, job_id, department_id)
select emp.employee_id, emp.hire_date, current_date, emp.job_id, emp.department_id
                    from employees emp
                        inner join jobs j
                            on emp.job_id = j.job_id
                    where (months_between(current_date, hire_date)/12) > 20
                        and job_title = 'Shipping Clerk';              
delete from employees
where employee_id in (select emp.employee_id
                    from employees emp
                        inner join jobs j
                            on emp.job_id = j.job_id
                    where (months_between(current_date, hire_date)/12) > 20
                        and job_title = 'Shipping Clerk');

-- All operations are completed with a transaction commit command.
						
commit;






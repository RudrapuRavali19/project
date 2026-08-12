use employee_db;

create table if not exists employees(
    employee_id int primary key,
    name varchar(50),
    department varchar(50),
    designation varchar(50),
    salary decimal(10,2),
    hra decimal(10,2),
    da decimal(10,2),
    gross_salary decimal(10,2)
);

insert into employees(employee_id, name, department, designation, salary)
VALUES 
(1, 'Ravali' , 'IT', 'Developer', 50000),
(2, 'siddhu', 'IT', 'Developer', 40000),
(3, 'shiva', 'HR', 'Manager', 60000);
set sql_safe_updates=0;
update employees 
set 
    hra = salary*0.20, 
    da = salary*0.10, 
    gross_salary = salary + (salary*0.20) + (salary*0.10);

select * from employees;
alter table employees
add column pf decimal(10,2) after gross_salary,
add column tax decimal(10,2)after pf,
add column net_salary decimal(10,2)after tax;
select * from employees;
update employees
set
pf=salary*0.12,
tax=salary*0.5,
net_salary=gross_salary - (salary*0.12)-(salary*0.05);
select * from employees;
update employees
set
hra=salary*0.20,
da=salary*0.10,
gross_salary=salary+(salary*0.20)+(salary*0.10);
select * from employees;
update employees
set
net_salary=gross_salary-pf-tax;
select * from employees;
alter table employees
add constraint chk_salary_positive check (salary>0);
select * from employees;
select employee_id,
name,
salary,
case
when salary>0 then 'vaild'
when salary<=0 then 'invaild:negativeor zero'
when salary is null then 'invaild:null'
end as salary_validation
from employees;
insert into employees(employee_id, name, department, designation, salary)
values
(4, 'sai', 'IT', 'Developer', 50000),
(5, 'goutham', 'IT', 'Developer', 45000),
(6, 'bunny', 'IT', 'developer', 50000);
select * from employees;
select employee_id,name,salary
from employees
where employee_id<=0 or employee_id is null;
alter table employees
add constraint chk_employee_id_positive check(employee_id>0);
select * from employees;
select
employee_id,
name,
case
when employee_id>0 then 'vaild'
when employee_id<=0 then 'invaild:zero or negative'
when employee_id is null then 'invaild:null'
end as employee_id_vaildation
from employees;
select
employee_id,
name,
case
when name is null then 'invaild:null'
when name=''then 'invaild:empty'
when name not regexp '^[a-zA-Z ]+$' then 'invaild:contain numbers/symbols'
else 'vaild'
end as name_vaildation
from employees;
select
case
when salary>=50000 then 'A'
when salary>=30000 then 'B'
when salary>=15000 then 'c'
else 'D'
end as salary_grade,
count(*) as total_employee
from employees
group by salary_grade
order by salary_grade;
select*from employees;



















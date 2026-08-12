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







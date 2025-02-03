create database company_db;

use company_db;

create table employees(
id int primary key auto_increment,
name varchar(50) not null,
position varchar(50) not null,
salary decimal(10,2) check(salary > 0),
hire_date varchar(10) not null
);

alter table employees
add column email varchar(50),
drop column hire_date,
rename column position to job_title,
modify column salary int;

alter table employees
add column department varchar(50) after job_title;

insert into employees (name, job_title, department, salary, email) 
values ('Анна Иванова', 'Менеджер', 'Отдел продаж', 60000, 'anna.ivanova@example.ru');

insert into employees (name, job_title, department, salary, email) 
values ('Иван Смирнов', 'Разработчик', 'IT', 75000, 'ivan.smirnov@example.com');

insert into employees (name, job_title, department, salary, email) 
values ('Мария Петрова', 'Бухгалтер', 'Финансы', 50000, 'maria.petrova@example.com');

insert into employees (name, job_title, department, salary, email) 
values ('Петр Васильев', 'Разработчик', 'IT', 80000, 'petr.vasiliev@example.ru');

insert into employees (name, job_title, department, salary, email) 
values ('Екатерина Соколова', 'HR-специалист', 'HR', 55000, 'ekaterina.sokolova@example.com');

insert into employees (name, job_title, department, salary, email) 
values ('Алексей Кузнецов', 'Менеджер по продажам', 'Отдел продаж', 65000, 'alexey.kuznetsov@example.ge');

insert into employees (name, job_title, department, salary, email) 
values ('Ольга Морозова', 'Аналитик', 'Финансы', 70000, 'olga.morozova@example.com');

select *
from employees
where department = "IT" or department = "Финансы";

select *
from employees
where name like '% С%';

select *
from employees
where email like '%@example.com';

select *
from employees
where salary between 60000 and 75000;

select *
from employees
where job_title like '%Менеджер%';

select *
from employees
where department = "HR";

select *
from employees
where salary > 70000 and department = "Финансы";

select *
from employees
where email like "%.ru" or email like "%.ge";

select *
from employees
where name like "%ов" or name like "%ев";

select *
from employees
where salary < 55000 and department != "IT";

select *
from employees
order by name;

select *
from employees
order by salary desc;

select *
from employees
where department = "IT" or department = "Финансы" 
order by salary desc;

select *
from employees
where salary > 60000
order by name;

select distinct department
from employees;

select distinct job_title
from employees;

drop table employees;





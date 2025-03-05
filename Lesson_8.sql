create database company1;
use company1;
create table employees(
id int primary key,
first_name varchar(64),
last_name varchar(64),
email varchar(128),
department_id int
);

create table departments(
id int primary key,
dep_name varchar(64),
dep_description varchar(256),
manager_id int
);

insert into employees
values (1, 'John', 'Smith', 'jsmith@gmail.com', 2),
		(2, 'Bob', 'Brown', 'brown@gmail.com', 2),
        (3, 'David', 'Austin', 'daustin@gmail.com', 1),
        (4, 'Elen', 'Jameson', 'ejameson@gmail.com', 1);
        
insert into departments
values (1, 'IT', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis felis ipsum, vulputate ac sem ut, tincidunt maximus ex. Cras semper metus sed porta laoreet.', 2),
		(2, 'HR', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis felis ipsum, vulputate ac sem ut, tincidunt maximus ex. Cras semper metus sed porta laoreet.', 1), 
        (3, 'Sales', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis felis ipsum, vulputate ac sem ut, tincidunt maximus ex. Cras semper metus sed porta laoreet.', 3);
        
select * from employees;
select * from departments;

-- Горизонтальное  

-- INNER JOIN
-- Join позволяет объединять данные из таблиц "горизонтально". То есть указав
-- правило, по которым мы хотите объединять строки, join их объединяет.
-- При inner join в результирующую выборку попадут только те записи, которые
-- нашли себе пару по условию join (указанное после ключевого слова on).
-- Все остальные записи в результирующую выборку не попадут

-- select table1.column1, table1.column2, table2.column3
-- from table1
-- [inner] join table2
-- on table1.column = table2.column
-- [inner] join table3
-- on условие;

-- Вывести идентификаторы, имена, фамилии сотрудников и название их департаментов.
select first_name, last_name, dep_name
from employees
inner join departments
on employees.department_id = departments.id;
-- Error Code: 1052. Column 'id' in field list is ambiguous	0.015 sec


select employees.id, employees.first_name, employees.last_name, departments.dep_name
from employees
join departments
on employees.department_id = departments.id;

select employees.id, employees.first_name, employees.last_name, departments.dep_name
from departments
join employees
on employees.department_id = departments.id;

select emp.id, emp.first_name, emp.last_name, dep.dep_name
from employees as emp -- временное название таблицы 
join departments as dep
on emp.department_id = dep.id;

select t1.id, t1.first_name, t1.last_name, t2.dep_name
from employees as t1 -- t1 - table1
join departments as t2 -- t2 - table2
on t1.department_id = t2.id;

-- Вывести название департамента и имя менеджера департамента(менеджер это сотрудник из employees)
select t1.dep_name, t2.first_name
from departments as t1
join employees as t2
on t1.manager_id = t2.id;

-- Вывести имена, фамилии сотрудников, а так же название их департаментов и имена менеджеров этих департаментов.
select emp.first_name, emp.last_name, dep.dep_name, mng.first_name as mng_first_name, mng.last_name as mng_last_name
from employees as emp
join departments as dep
on emp.department_id = dep.id
join employees as mng
on mng.id = dep.manager_id;

select emp.*, dep.*, mng.*
from employees as emp
join departments as dep
on emp.department_id = dep.id
join employees as mng
on mng.id = dep.manager_id;

-- Вывести все поля из трех таблиц
select emp.*, dep.*, mng.*
from employees as emp
join departments as dep
on emp.department_id = dep.id
join employees as mng
on mng.id = dep.manager_id;
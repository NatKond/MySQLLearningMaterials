use gt081024;

select *
from employees;

-- Сортировка
-- order by column_name -- по умолчанию сортировка по возрастанию/ в алфавитном порядке
-- order by column_name asc -- сортировка по возрастанию/ в алфавитном порядке
-- order by column_name desc -- сортировка по убыванию/ в обратном алфавитном порядке

-- Вывести имена, фамилии и зарплаты сотрудников, отсортированные по зарплатам по убыванию

select first_name, last_name, salary
from employees
order by salary desc;

-- Вывести сотрудников из отдела 'Sales', отсортированнные в алфавитном порядке имени
select *
from employees
where department = 'Sales'
order by first_name;

-- Пагинация

-- Limit - позволяет извлечь определенное количество строк
-- Limit N - где N - количество строк, которое нужно вывести
-- limit M,N - где M - количество строк, которые нужно пропустить, а N - количество строк, которое нужно вывести

-- Вывести первых трех сотрудников
select *
from employees
limit 3;

-- Вывыести первых двух сотрудников, которые зарабатывают больше 1000
select *
from employees
where salary > 1000
limit 2;

-- Вывести двух сотрудников из отдела 'IT' пропуская первых трех
select *
from employees
where department = 'IT'
limit 3, 2;

-- Вывести сотрудника с максимальной зарплатой
select *
from employees
order by salary desc
limit 1;

-- Вывести 5 сотрудников с самой высокой зарплатой.
select *
from employees
order by salary desc
limit 5;

-- Вывести 10 сотрудников с самой низкой зарплатой.
select *
from employees
order by salary
limit 7;

-- Вывести 7 последних сотрудников по employee_id (по убыванию).
select *
from employees
order by employee_id desc
limit 7;

-- Вывести 4 сотрудника с самой высокой зарплатой, пропуская самого высокооплачиваемого
select *
from employees
order by salary desc
limit 1, 4;

-- Обновление и удаление данных 

-- update table_name
-- set column_name1 = new_value, column_name2 = new_value
-- [where condition];

-- delete from table_name
-- [where condition];

set sql_safe_updates = 0; -- Отключить безопасный режим обновления данных
set sql_safe_updates = 1; -- Включить безопасный режим обновления данных

-- Изменить значение департамента сотрудника Steven King на IT
update employees
set department = 'IT'
where first_name = 'Steven' and last_name = 'King';
-- Error Code: 1175. You are using safe update mode and you tried to update a table without a WHERE that uses a KEY column.  To disable safe mode, toggle the option in Preferences -> SQL Editor and reconnect.	0.016 sec

set sql_safe_updates = 0;

update employees
set department = 'IT'
where first_name = 'Steven' and last_name = 'King';
-- 1 row(s) affected Rows matched: 1  Changed: 1  Warnings: 0

-- Повысить зарплату сотрудника Diana Lorentz на 2000
update employees
set salary = salary + 2000
where first_name = 'Diana' and last_name = 'Lorentz';

-- Повысить зарплату сотрудников из отдела Sales в два раза
update employees
set salary = salary * 2
where department = 'Sales';

-- Изменить фамилию сотрудника с именем Luis Popp на Smith
update employees
set last_name = 'Smith'
where first_name = 'Luis' and last_name = 'Popp';

-- Изименить значение зарплаты из отдела IT на 12000
update employees
set salary = 12000
where department = 'IT';
-- 5 row(s) affected Rows matched: 7  Changed: 5  Warnings: 0

-- Сотрудника с id 9 перевели в отдел 'Sales' и повысили зарплату на 3000.
update employees
set department = 'Sales', salary = salary + 3000
where employee_id = 9;

-- Изменить название департамента с 'IT' на 'Information Technology' для всех сотрудников этого отдела.
update employees
set department = 'Information Technology' 
where department = 'IT';

-- Повысить зарплаты всех сотрудников на 5%
update employees
set salary = salary * (1 + 5/100);

-- Удалить сотрудника Luis Smith из таблицы
delete from employees
where first_name = 'Luis' and last_name = 'Smith';

-- Удалть всех сотрудников, которые получают меньше 3000
delete from employees
where salary < 3000;

-- Удалить сотрудников с employee_id 2, 7, 10
delete from employees
-- where employee_id = 2 or employee_id = 7 or employee_id = 10;
where employee_id in (2, 7, 10);

select *
from employees;

-- delete from table_name;
-- truncate table table_name;
-- Доп. инфо об операторах delete и truncate
-- https://sky.pro/wiki/sql/razbiraem-raznitsu-mezhdu-truncate-i-delete-v-sql/

delete from employees;

insert into employees (first_name, last_name, email, salary, department)
values ('John', 'Smith' ,'JOHNSM', 20000, 'IT');

select * from employees;

truncate table employees;

insert into employees (first_name, last_name, email, salary, department)
values ('John', 'Smith' ,'JOHNSM', 20000, 'IT');

select * from employees;